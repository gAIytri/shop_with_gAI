from decimal import Decimal
from uuid import UUID

from fastapi import APIRouter, Query

from app.core.dependencies import DbSession
from app.products import service
from app.products.schemas import (
    PaginatedProducts,
    ProductDetail,
    ProductRelationOut,
    ProductSortField,
)

router = APIRouter(prefix="/products", tags=["products"])


@router.get("", response_model=PaginatedProducts)
async def list_products(
    db: DbSession,
    category: str | None = Query(None, description="Filter by category slug"),
    price_min: Decimal | None = Query(None, ge=0),
    price_max: Decimal | None = Query(None, ge=0),
    tags: str | None = Query(None, description="Comma-separated tags"),
    sort: ProductSortField = Query(ProductSortField.newest),
    page: int = Query(1, ge=1),
    per_page: int = Query(20, ge=1, le=100),
    search: str | None = Query(None, description="Full-text search"),
    is_featured: bool | None = Query(None),
    is_bestseller: bool | None = Query(None),
    is_new: bool | None = Query(None),
):
    return await service.list_products(
        db,
        category_slug=category,
        price_min=price_min,
        price_max=price_max,
        tags=tags,
        sort=sort,
        page=page,
        per_page=per_page,
        search=search,
        is_featured=is_featured,
        is_bestseller=is_bestseller,
        is_new=is_new,
    )


@router.get("/{slug}", response_model=ProductDetail)
async def get_product(db: DbSession, slug: str):
    return await service.get_product_by_slug(db, slug)


@router.get("/{product_id}/related", response_model=list[ProductRelationOut])
async def get_related_products(db: DbSession, product_id: UUID):
    return await service.get_related_products(db, product_id)
