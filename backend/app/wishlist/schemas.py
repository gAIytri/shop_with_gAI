from decimal import Decimal
from uuid import UUID

from pydantic import BaseModel, ConfigDict

from app.products.schemas import ProductImageOut


class WishlistProductBrief(BaseModel):
    model_config = ConfigDict(from_attributes=True)
    id: UUID
    name: str
    sku: str
    price: Decimal
    compare_at_price: Decimal | None = None
    stock_status: str
    avg_rating: Decimal = Decimal("0")
    review_count: int = 0
    images: list[ProductImageOut] = []


class WishlistItemOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: UUID
    product_id: UUID
    variant_id: UUID | None = None
    added_at_price: Decimal | None = None
    notes: str | None = None
    product: WishlistProductBrief | None = None


class AddWishlistItem(BaseModel):
    product_id: UUID
