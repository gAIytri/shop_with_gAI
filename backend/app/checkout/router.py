from fastapi import APIRouter

from app.checkout import service
from app.checkout.schemas import (
    CreatePaymentIntentRequest,
    PaymentIntentResponse,
    ShippingMethodOut,
    TaxCalculationRequest,
    TaxCalculationResponse,
)
from app.core.dependencies import CurrentUser, DbSession
from app.users.models import Address

router = APIRouter(prefix="/checkout", tags=["checkout"])


@router.get("/shipping-methods", response_model=list[ShippingMethodOut])
async def get_shipping_methods(db: DbSession):
    return await service.get_shipping_methods(db)


@router.post("/calculate-tax", response_model=TaxCalculationResponse)
async def calculate_tax(
    db: DbSession,
    user: CurrentUser,
    data: TaxCalculationRequest,
):
    address = await db.get(Address, data.address_id)
    if not address or address.user_id != user.id:
        from app.core.exceptions import NotFoundError

        raise NotFoundError("Address", str(data.address_id))

    # Get cart subtotal
    from sqlalchemy import select

    from app.cart.models import Cart

    cart_q = select(Cart).where(Cart.user_id == user.id)
    cart = (await db.execute(cart_q)).scalar_one_or_none()
    subtotal = cart.subtotal if cart else 0

    tax_amount, tax_rate = await service.calculate_tax(subtotal, address.state)
    return TaxCalculationResponse(tax_amount=tax_amount, tax_rate=tax_rate)


@router.post("/create-payment-intent", response_model=PaymentIntentResponse)
async def create_payment_intent(data: CreatePaymentIntentRequest):
    """Placeholder — real Stripe integration in WS-6."""
    return PaymentIntentResponse(
        client_secret="pi_placeholder_secret",
        payment_intent_id="pi_placeholder",
    )
