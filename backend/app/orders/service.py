from datetime import datetime, timezone
from decimal import Decimal
from uuid import UUID

from sqlalchemy import func, select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from app.admin.models import ShippingMethod
from app.cart.models import Cart
from app.core.exceptions import NotFoundError, ValidationError
from app.orders.models import Order, OrderItem, OrderStatus, Payment, PaymentMethod, PaymentStatus
from app.orders.schemas import OrderDetail, OrderOut, PaginatedOrders
from app.products.models import Product, ProductVariant
from app.users.models import Address, User


def _generate_order_number() -> str:
    now = datetime.now(timezone.utc)
    import random

    seq = random.randint(10000, 99999)
    return f"ORD-{now.year}-{seq}"


async def place_order(
    db: AsyncSession,
    user: User,
    shipping_address_id: UUID,
    billing_address_id: UUID | None,
    shipping_method_id: UUID,
    customer_notes: str | None,
) -> OrderDetail:
    # Get cart
    cart_q = (
        select(Cart)
        .where(Cart.user_id == user.id)
        .options(selectinload(Cart.items))
    )
    cart = (await db.execute(cart_q)).scalar_one_or_none()

    if not cart or not cart.items:
        raise ValidationError("Cart is empty")

    # Get addresses
    shipping_addr = await db.get(Address, shipping_address_id)
    if not shipping_addr or shipping_addr.user_id != user.id:
        raise NotFoundError("Shipping address", str(shipping_address_id))

    billing_addr = shipping_addr
    if billing_address_id and billing_address_id != shipping_address_id:
        billing_addr = await db.get(Address, billing_address_id)
        if not billing_addr or billing_addr.user_id != user.id:
            raise NotFoundError("Billing address", str(billing_address_id))

    # Get shipping method
    shipping_method = await db.get(ShippingMethod, shipping_method_id)
    if not shipping_method or not shipping_method.is_active:
        raise NotFoundError("Shipping method", str(shipping_method_id))

    def _addr_snapshot(addr: Address) -> dict:
        return {
            "street_address": addr.street_address,
            "address_line_2": addr.address_line_2,
            "city": addr.city,
            "state": addr.state,
            "postal_code": addr.postal_code,
            "country": addr.country,
            "recipient_name": addr.recipient_name,
            "recipient_phone": addr.recipient_phone,
        }

    # Validate stock and build order items
    order_items = []
    subtotal = Decimal("0")

    for ci in cart.items:
        product = await db.get(Product, ci.product_id)
        if not product or product.deleted_at:
            raise ValidationError("Product no longer available")

        available = product.stock_quantity
        variant = None
        if ci.variant_id:
            variant = await db.get(ProductVariant, ci.variant_id)
            if variant:
                available = variant.stock_quantity

        if ci.quantity > available:
            raise ValidationError(f"Insufficient stock for '{product.name}'")

        item_total = ci.unit_price * ci.quantity
        subtotal += item_total

        # Build snapshot
        snapshot = {
            "sku": product.sku,
            "name": product.name,
            "image_url": None,
        }
        if product.images:
            primary = next((i for i in product.images if i.is_primary), None)
            snapshot["image_url"] = (primary or product.images[0]).url if product.images else None
        if variant:
            snapshot["variant"] = variant.variant_options

        order_items.append(
            OrderItem(
                product_id=product.id,
                variant_id=ci.variant_id,
                product_snapshot=snapshot,
                quantity=ci.quantity,
                unit_price=ci.unit_price,
                total=item_total,
            )
        )

        # Decrement stock
        if variant:
            variant.stock_quantity -= ci.quantity
        else:
            product.stock_quantity -= ci.quantity

    shipping_amount = shipping_method.price
    total = subtotal - cart.discount_amount + cart.tax_amount + shipping_amount

    order = Order(
        order_number=_generate_order_number(),
        user_id=user.id,
        status=OrderStatus.pending,
        shipping_address=_addr_snapshot(shipping_addr),
        billing_address=_addr_snapshot(billing_addr),
        customer_email=user.email,
        customer_phone=user.phone,
        customer_name=f"{user.first_name or ''} {user.last_name or ''}".strip(),
        subtotal=subtotal,
        discount_amount=cart.discount_amount,
        shipping_amount=shipping_amount,
        tax_amount=cart.tax_amount,
        total=total,
        coupon_code=cart.coupon_code,
        shipping_method=shipping_method.name,
        customer_notes=customer_notes,
        items=order_items,
    )

    # Create payment record
    payment = Payment(
        order=order,
        payment_method=PaymentMethod.credit_card,
        status=PaymentStatus.pending,
        amount=total,
        payment_provider="stripe",
    )
    db.add(payment)
    db.add(order)

    # Clear cart
    for ci in list(cart.items):
        await db.delete(ci)
    cart.coupon_code = None
    cart.discount_amount = Decimal("0")

    await db.commit()
    await db.refresh(order)

    # Reload with relationships
    return await get_order_detail(db, order.order_number, user)


async def get_user_orders(
    db: AsyncSession,
    user_id: UUID,
    page: int = 1,
    per_page: int = 10,
) -> PaginatedOrders:
    base = select(Order).where(Order.user_id == user_id)

    count_q = select(func.count()).select_from(base.subquery())
    total = (await db.execute(count_q)).scalar_one()

    per_page = min(max(per_page, 1), 50)
    page = max(page, 1)

    query = base.order_by(Order.placed_at.desc()).offset((page - 1) * per_page).limit(per_page)
    result = await db.execute(query)
    orders = result.scalars().all()

    return PaginatedOrders(
        items=[OrderOut.model_validate(o) for o in orders],
        total=total,
        page=page,
        per_page=per_page,
    )


async def get_order_detail(
    db: AsyncSession,
    order_number: str,
    user: User,
) -> OrderDetail:
    query = (
        select(Order)
        .where(Order.order_number == order_number, Order.user_id == user.id)
        .options(
            selectinload(Order.items),
            selectinload(Order.payments),
        )
    )
    order = (await db.execute(query)).scalar_one_or_none()

    if not order:
        raise NotFoundError("Order", order_number)

    return OrderDetail.model_validate(order)


async def cancel_order(
    db: AsyncSession,
    order_number: str,
    user: User,
) -> OrderDetail:
    query = select(Order).where(Order.order_number == order_number, Order.user_id == user.id)
    order = (await db.execute(query)).scalar_one_or_none()

    if not order:
        raise NotFoundError("Order", order_number)

    cancellable = {OrderStatus.pending, OrderStatus.confirmed}
    if order.status not in cancellable:
        raise ValidationError(f"Cannot cancel order with status '{order.status.value}'")

    order.status = OrderStatus.cancelled
    order.cancelled_at = datetime.now(timezone.utc)

    # Restore stock
    items_q = select(OrderItem).where(OrderItem.order_id == order.id)
    items = (await db.execute(items_q)).scalars().all()
    for item in items:
        if item.variant_id:
            variant = await db.get(ProductVariant, item.variant_id)
            if variant:
                variant.stock_quantity += item.quantity
        elif item.product_id:
            product = await db.get(Product, item.product_id)
            if product:
                product.stock_quantity += item.quantity

    await db.commit()
    return await get_order_detail(db, order_number, user)


async def return_order(
    db: AsyncSession,
    order_number: str,
    user: User,
    item_ids: list[UUID],
    reason: str,
) -> OrderDetail:
    query = select(Order).where(Order.order_number == order_number, Order.user_id == user.id)
    order = (await db.execute(query)).scalar_one_or_none()

    if not order:
        raise NotFoundError("Order", order_number)

    if order.status != OrderStatus.delivered:
        raise ValidationError("Only delivered orders can be returned")

    order.status = OrderStatus.returned
    order.internal_notes = f"Return reason: {reason}"

    await db.commit()
    return await get_order_detail(db, order_number, user)
