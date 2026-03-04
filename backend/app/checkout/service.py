from decimal import Decimal

from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.admin.models import ShippingMethod
from app.checkout.schemas import ShippingMethodOut


async def get_shipping_methods(db: AsyncSession) -> list[ShippingMethodOut]:
    query = (
        select(ShippingMethod)
        .where(ShippingMethod.is_active.is_(True))
        .order_by(ShippingMethod.sort_order)
    )
    result = await db.execute(query)
    methods = result.scalars().all()
    return [ShippingMethodOut.model_validate(m) for m in methods]


async def calculate_tax(subtotal: Decimal, state: str) -> tuple[Decimal, Decimal]:
    """Placeholder tax calculation. Returns (tax_amount, tax_rate)."""
    # Simple state-based tax rates for MVP
    tax_rates = {
        "CA": Decimal("0.0725"),
        "NY": Decimal("0.08"),
        "TX": Decimal("0.0625"),
        "FL": Decimal("0.06"),
        "WA": Decimal("0.065"),
    }
    rate = tax_rates.get(state, Decimal("0.05"))
    tax = (subtotal * rate).quantize(Decimal("0.01"))
    return tax, rate
