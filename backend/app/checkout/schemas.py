from decimal import Decimal
from uuid import UUID

from pydantic import BaseModel, ConfigDict


class ShippingMethodOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: UUID
    name: str
    description: str | None = None
    price: Decimal
    estimated_days_min: int | None = None
    estimated_days_max: int | None = None


class TaxCalculationRequest(BaseModel):
    address_id: UUID


class TaxCalculationResponse(BaseModel):
    tax_amount: Decimal
    tax_rate: Decimal


class CreatePaymentIntentRequest(BaseModel):
    amount: Decimal
    currency: str = "USD"


class PaymentIntentResponse(BaseModel):
    client_secret: str
    payment_intent_id: str
