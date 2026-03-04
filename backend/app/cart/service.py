from datetime import datetime, timezone
from decimal import Decimal
from uuid import UUID

from sqlalchemy import delete, select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from app.cart.models import Cart, CartItem
from app.cart.schemas import CartOut
from app.core.exceptions import InsufficientStockError, NotFoundError, ValidationError
from app.coupons.models import Coupon, CouponUsage
from app.products.models import Product, ProductVariant
from app.users.models import User


def _cart_query():
    """Base cart query with eagerly loaded items."""
    return select(Cart).options(
        selectinload(Cart.items)
        .selectinload(CartItem.product)
        .selectinload(Product.images)
    )


async def _recalculate_cart(cart: Cart) -> None:
    """Recalculate cart totals from items (mirrors the PostgreSQL trigger)."""
    item_count = 0
    subtotal = Decimal("0")
    for item in cart.items:
        item_count += item.quantity
        subtotal += item.quantity * item.unit_price
    cart.item_count = item_count
    cart.subtotal = subtotal
    shipping = cart.shipping_estimate or Decimal("0")
    cart.total = subtotal - cart.discount_amount + cart.tax_amount + shipping


async def _find_or_create_cart(
    db: AsyncSession,
    user_id: UUID | None = None,
    session_id: str | None = None,
) -> Cart:
    """Find existing cart or create new one."""
    query = _cart_query()

    if user_id:
        query = query.where(Cart.user_id == user_id)
    elif session_id:
        query = query.where(Cart.session_id == session_id)
    else:
        raise ValidationError("Either user or session_id is required")

    result = await db.execute(query)
    cart = result.scalar_one_or_none()

    if cart is None:
        cart = Cart(
            user_id=user_id,
            session_id=session_id if not user_id else None,
        )
        db.add(cart)
        await db.flush()

        refetch = _cart_query().where(Cart.id == cart.id)
        result = await db.execute(refetch)
        cart = result.scalar_one()

    return cart


async def _fresh_cart(
    db: AsyncSession,
    user_id: UUID | None = None,
    session_id: str | None = None,
) -> CartOut:
    """Load a fresh cart from DB and return as Pydantic model."""
    query = _cart_query()
    if user_id:
        query = query.where(Cart.user_id == user_id)
    elif session_id:
        query = query.where(Cart.session_id == session_id)
    else:
        raise ValidationError("Either user or session_id is required")

    result = await db.execute(query)
    cart = result.scalar_one_or_none()

    if cart is None:
        cart = Cart(
            user_id=user_id,
            session_id=session_id if not user_id else None,
        )
        db.add(cart)
        await db.flush()
        result = await db.execute(
            _cart_query().where(Cart.id == cart.id)
        )
        cart = result.scalar_one()

    await _recalculate_cart(cart)
    return CartOut.model_validate(cart)


async def get_cart(
    db: AsyncSession,
    user: User | None = None,
    session_id: str | None = None,
) -> CartOut:
    """Public API: get cart using User object or session_id."""
    uid = user.id if user else None
    return await _fresh_cart(db, user_id=uid, session_id=session_id)


async def add_item(
    db: AsyncSession,
    data_product_id: UUID,
    data_variant_id: UUID | None,
    data_quantity: int,
    user: User | None = None,
    session_id: str | None = None,
) -> CartOut:
    user_id = user.id if user else None
    cart = await _find_or_create_cart(db, user_id, session_id)

    product = await db.get(Product, data_product_id)
    if not product or product.deleted_at or not product.is_active:
        raise NotFoundError("Product", str(data_product_id))

    available_stock = product.stock_quantity
    unit_price = product.price

    if data_variant_id:
        variant = await db.get(ProductVariant, data_variant_id)
        if not variant or not variant.is_active:
            raise NotFoundError("Variant", str(data_variant_id))
        available_stock = variant.stock_quantity
        if variant.price is not None:
            unit_price = variant.price

    existing_q = select(CartItem).where(
        CartItem.cart_id == cart.id,
        CartItem.product_id == data_product_id,
        CartItem.variant_id == data_variant_id,
    )
    existing = (await db.execute(existing_q)).scalar_one_or_none()

    new_qty = data_quantity
    if existing:
        new_qty = existing.quantity + data_quantity

    if new_qty > available_stock:
        raise InsufficientStockError(product.name)

    if existing:
        existing.quantity = new_qty
        existing.unit_price = unit_price
    else:
        item = CartItem(
            cart_id=cart.id,
            product_id=data_product_id,
            variant_id=data_variant_id,
            quantity=data_quantity,
            unit_price=unit_price,
        )
        db.add(item)

    await db.commit()
    db.expire_all()
    return await _fresh_cart(db, user_id, session_id)


async def update_item(
    db: AsyncSession,
    item_id: UUID,
    quantity: int,
    user: User | None = None,
    session_id: str | None = None,
) -> CartOut:
    user_id = user.id if user else None
    cart = await _find_or_create_cart(db, user_id, session_id)

    item_q = select(CartItem).where(
        CartItem.id == item_id, CartItem.cart_id == cart.id
    )
    item = (await db.execute(item_q)).scalar_one_or_none()
    if not item:
        raise NotFoundError("Cart item", str(item_id))

    if quantity == 0:
        await db.delete(item)
    else:
        product = await db.get(Product, item.product_id)
        available = product.stock_quantity if product else 0
        if item.variant_id:
            variant = await db.get(ProductVariant, item.variant_id)
            if variant:
                available = variant.stock_quantity
        if quantity > available:
            raise InsufficientStockError(
                product.name if product else "Product"
            )
        item.quantity = quantity

    await db.commit()
    db.expire_all()
    return await _fresh_cart(db, user_id, session_id)


async def remove_item(
    db: AsyncSession,
    item_id: UUID,
    user: User | None = None,
    session_id: str | None = None,
) -> CartOut:
    user_id = user.id if user else None
    cart = await _find_or_create_cart(db, user_id, session_id)

    item_q = select(CartItem).where(
        CartItem.id == item_id, CartItem.cart_id == cart.id
    )
    item = (await db.execute(item_q)).scalar_one_or_none()
    if not item:
        raise NotFoundError("Cart item", str(item_id))

    await db.delete(item)
    await db.commit()
    db.expire_all()
    return await _fresh_cart(db, user_id, session_id)


async def clear_cart(
    db: AsyncSession,
    user: User | None = None,
    session_id: str | None = None,
) -> CartOut:
    user_id = user.id if user else None
    cart = await _find_or_create_cart(db, user_id, session_id)
    await db.execute(
        delete(CartItem).where(CartItem.cart_id == cart.id)
    )
    cart.coupon_code = None
    cart.discount_amount = Decimal("0")
    await db.commit()
    db.expire_all()
    return await _fresh_cart(db, user_id, session_id)


async def merge_carts(
    db: AsyncSession,
    user: User,
    anonymous_session_id: str,
) -> CartOut:
    """Merge anonymous cart into user cart on login."""
    user_id = user.id

    anon_q = (
        select(Cart)
        .where(Cart.session_id == anonymous_session_id)
        .options(selectinload(Cart.items))
    )
    anon_cart = (await db.execute(anon_q)).scalar_one_or_none()

    if not anon_cart or not anon_cart.items:
        return await _fresh_cart(db, user_id=user_id)

    user_cart = await _find_or_create_cart(db, user_id=user_id)

    for anon_item in anon_cart.items:
        existing_q = select(CartItem).where(
            CartItem.cart_id == user_cart.id,
            CartItem.product_id == anon_item.product_id,
            CartItem.variant_id == anon_item.variant_id,
        )
        existing = (await db.execute(existing_q)).scalar_one_or_none()

        if existing:
            existing.quantity = max(
                existing.quantity, anon_item.quantity
            )
        else:
            new_item = CartItem(
                cart_id=user_cart.id,
                product_id=anon_item.product_id,
                variant_id=anon_item.variant_id,
                quantity=anon_item.quantity,
                unit_price=anon_item.unit_price,
            )
            db.add(new_item)

    await db.delete(anon_cart)
    await db.commit()
    db.expire_all()
    return await _fresh_cart(db, user_id=user_id)


async def apply_coupon(
    db: AsyncSession,
    code: str,
    user: User | None = None,
    session_id: str | None = None,
) -> CartOut:
    user_id = user.id if user else None
    cart = await _find_or_create_cart(db, user_id, session_id)

    coupon_q = (
        select(Coupon)
        .where(Coupon.code == code, Coupon.is_active.is_(True))
        .options(selectinload(Coupon.promotion))
    )
    coupon = (await db.execute(coupon_q)).scalar_one_or_none()

    if not coupon:
        raise NotFoundError("Coupon", code)

    promo = coupon.promotion
    now = datetime.now(timezone.utc)

    if not promo.is_active:
        raise ValidationError("This promotion is no longer active")
    if promo.starts_at > now:
        raise ValidationError("This coupon is not yet active")
    if promo.ends_at and promo.ends_at < now:
        raise ValidationError("This coupon has expired")
    if coupon.max_uses and coupon.current_uses >= coupon.max_uses:
        raise ValidationError(
            "This coupon has reached its usage limit"
        )
    if (
        promo.min_purchase_amount
        and cart.subtotal < promo.min_purchase_amount
    ):
        raise ValidationError(
            f"Minimum purchase of ${promo.min_purchase_amount} required"
        )

    # Calculate discount
    discount = Decimal("0")
    if promo.discount_type.value == "percentage":
        discount = cart.subtotal * promo.discount_value / 100
        if promo.max_discount_amount:
            discount = min(discount, promo.max_discount_amount)
    elif promo.discount_type.value == "fixed_amount":
        discount = min(promo.discount_value, cart.subtotal)
    elif promo.discount_type.value == "free_shipping":
        cart.shipping_estimate = Decimal("0")

    cart.coupon_code = code
    cart.discount_amount = discount
    shipping = cart.shipping_estimate or Decimal("0")
    cart.total = cart.subtotal - discount + cart.tax_amount + shipping

    # Track coupon usage
    coupon.current_uses += 1
    usage = CouponUsage(
        coupon_id=coupon.id,
        user_id=user_id,
        discount_applied=discount,
    )
    db.add(usage)

    await db.commit()
    db.expire_all()
    return await _fresh_cart(db, user_id, session_id)


async def remove_coupon(
    db: AsyncSession,
    user: User | None = None,
    session_id: str | None = None,
) -> CartOut:
    user_id = user.id if user else None
    cart = await _find_or_create_cart(db, user_id, session_id)
    cart.coupon_code = None
    cart.discount_amount = Decimal("0")
    shipping = cart.shipping_estimate or Decimal("0")
    cart.total = cart.subtotal + cart.tax_amount + shipping
    await db.commit()
    db.expire_all()
    return await _fresh_cart(db, user_id, session_id)
