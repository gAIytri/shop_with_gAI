from datetime import date, datetime
from decimal import Decimal
from uuid import UUID

from pydantic import BaseModel, ConfigDict, Field


class OrderItemOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: UUID
    product_id: UUID | None = None
    variant_id: UUID | None = None
    product_snapshot: dict
    quantity: int
    unit_price: Decimal
    discount_amount: Decimal = Decimal("0")
    tax_amount: Decimal = Decimal("0")
    total: Decimal
    fulfilled_quantity: int = 0


class PaymentOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: UUID
    payment_method: str
    status: str
    amount: Decimal
    card_last_four: str | None = None
    card_brand: str | None = None
    created_at: datetime


class OrderOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: UUID
    order_number: str
    status: str
    customer_email: str
    customer_name: str | None = None

    subtotal: Decimal
    discount_amount: Decimal = Decimal("0")
    shipping_amount: Decimal = Decimal("0")
    tax_amount: Decimal = Decimal("0")
    total: Decimal
    currency: str = "USD"
    coupon_code: str | None = None

    shipping_method: str | None = None
    tracking_number: str | None = None
    estimated_delivery_date: date | None = None

    placed_at: datetime
    created_at: datetime


class OrderDetail(OrderOut):
    shipping_address: dict
    billing_address: dict
    customer_phone: str | None = None
    customer_notes: str | None = None

    shipped_at: datetime | None = None
    delivered_at: datetime | None = None
    cancelled_at: datetime | None = None

    items: list[OrderItemOut] = []
    payments: list[PaymentOut] = []


class PlaceOrderRequest(BaseModel):
    shipping_address_id: UUID
    billing_address_id: UUID | None = None  # defaults to shipping
    shipping_method_id: UUID
    customer_notes: str | None = None


class CancelOrderRequest(BaseModel):
    reason: str | None = None


class ReturnOrderRequest(BaseModel):
    items: list[UUID] = Field(description="Order item IDs to return")
    reason: str


class PaginatedOrders(BaseModel):
    items: list[OrderOut]
    total: int
    page: int
    per_page: int
