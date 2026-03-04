from decimal import Decimal
from uuid import UUID

from pydantic import BaseModel, ConfigDict, Field

from app.products.schemas import ProductImageOut


class CartItemProduct(BaseModel):
    model_config = ConfigDict(from_attributes=True)
    id: UUID
    name: str
    sku: str
    price: Decimal
    compare_at_price: Decimal | None = None
    stock_quantity: int = 0
    stock_status: str
    images: list[ProductImageOut] = []


class CartItemOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: UUID
    product_id: UUID
    variant_id: UUID | None = None
    quantity: int
    unit_price: Decimal
    product: CartItemProduct | None = None


class CartOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: UUID
    user_id: UUID | None = None
    session_id: str | None = None
    subtotal: Decimal = Decimal("0")
    discount_amount: Decimal = Decimal("0")
    tax_amount: Decimal = Decimal("0")
    shipping_estimate: Decimal | None = None
    total: Decimal = Decimal("0")
    coupon_code: str | None = None
    item_count: int = 0
    currency: str = "USD"
    items: list[CartItemOut] = []


class AddCartItem(BaseModel):
    product_id: UUID
    variant_id: UUID | None = None
    quantity: int = Field(1, ge=1)


class UpdateCartItem(BaseModel):
    quantity: int = Field(ge=0)


class ApplyCoupon(BaseModel):
    code: str


class MergeCart(BaseModel):
    session_id: str
