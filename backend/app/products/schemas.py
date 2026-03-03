from datetime import datetime
from decimal import Decimal
from uuid import UUID

from pydantic import BaseModel, ConfigDict, Field


# --- Nested schemas ---

class ProductImageOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: UUID
    url: str
    alt_text: str | None = None
    is_primary: bool = False
    display_order: int = 0


class ProductVariantOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: UUID
    sku: str
    variant_options: dict
    price: Decimal | None = None
    compare_at_price: Decimal | None = None
    stock_quantity: int = 0
    stock_status: str
    image_url: str | None = None
    is_active: bool = True


class CategoryBrief(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: UUID
    name: str
    slug: str


class ProductTypeBrief(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: UUID
    name: str
    slug: str


class RelatedProductBrief(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: UUID
    name: str
    price: Decimal
    compare_at_price: Decimal | None = None
    avg_rating: Decimal = Decimal("0")
    review_count: int = 0
    images: list[ProductImageOut] = []


# --- Product list item ---

class ProductListItem(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: UUID
    sku: str
    name: str
    slug: str | None = None
    price: Decimal
    compare_at_price: Decimal | None = None
    currency: str = "USD"
    stock_status: str
    avg_rating: Decimal = Decimal("0")
    review_count: int = 0
    is_featured: bool = False
    is_bestseller: bool = False
    is_new: bool = False
    images: list[ProductImageOut] = []
    category: CategoryBrief | None = None
    attributes: dict | None = None
    tags: list | None = None


# --- Product detail ---

class ProductDetail(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: UUID
    sku: str
    name: str
    description: str | None = None
    price: Decimal
    compare_at_price: Decimal | None = None
    currency: str = "USD"

    stock_quantity: int = 0
    stock_status: str

    attributes: dict | None = None
    visual_attributes: dict | None = None
    enriched_description: dict | None = None
    tags: list | None = None
    seo: dict | None = None

    is_featured: bool = False
    is_bestseller: bool = False
    is_new: bool = False

    avg_rating: Decimal = Decimal("0")
    review_count: int = 0

    published_at: datetime | None = None
    created_at: datetime

    category: CategoryBrief | None = None
    product_type: ProductTypeBrief | None = None
    images: list[ProductImageOut] = []
    variants: list[ProductVariantOut] = []


class ProductRelationOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    relation_type: str
    display_order: int = 0
    related_product: RelatedProductBrief


# --- Pagination ---

class PaginationMeta(BaseModel):
    page: int
    per_page: int
    total: int
    total_pages: int


class PaginatedProducts(BaseModel):
    items: list[ProductListItem]
    meta: PaginationMeta


# --- Query params ---

class ProductSortField(str, __import__("enum").Enum):
    price_asc = "price_asc"
    price_desc = "price_desc"
    rating = "rating"
    newest = "newest"
    name = "name"
