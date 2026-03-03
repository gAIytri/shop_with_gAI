from datetime import datetime
from decimal import Decimal
from uuid import UUID

from pydantic import BaseModel, ConfigDict, Field


class ReviewImageOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)
    id: UUID
    url: str


class ReviewOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: UUID
    product_id: UUID
    user_id: UUID | None = None
    rating: int
    title: str | None = None
    content: str | None = None
    is_verified_purchase: bool = False
    is_recommended: bool | None = None
    helpful_count: int = 0
    not_helpful_count: int = 0
    is_featured: bool = False
    store_response: str | None = None
    store_responded_at: datetime | None = None
    created_at: datetime
    images: list[ReviewImageOut] = []
    reviewer_name: str | None = None


class ReviewCreate(BaseModel):
    product_id: UUID
    rating: int = Field(ge=1, le=5)
    title: str | None = None
    content: str | None = None
    is_recommended: bool | None = None


class PaginatedReviews(BaseModel):
    items: list[ReviewOut]
    total: int
    page: int
    per_page: int
