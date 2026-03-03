from decimal import Decimal

from fastapi import APIRouter, Query

from app.core.dependencies import DbSession
from app.categories import service
from app.categories.schemas import CategoryDetail, CategoryOut
from app.products import service as product_service
from app.products.schemas import PaginatedProducts, ProductSortField

router = APIRouter(prefix="/categories", tags=["categories"])


@router.get("", response_model=list[CategoryOut])
async def list_categories(db: DbSession):
    return await service.get_categories_tree(db)


@router.get("/{slug}", response_model=CategoryDetail)
async def get_category(db: DbSession, slug: str):
    return await service.get_category_by_slug(db, slug)


@router.get("/{slug}/products", response_model=PaginatedProducts)
async def list_category_products(
    db: DbSession,
    slug: str,
    price_min: Decimal | None = Query(None, ge=0),
    price_max: Decimal | None = Query(None, ge=0),
    tags: str | None = Query(None),
    sort: ProductSortField = Query(ProductSortField.newest),
    page: int = Query(1, ge=1),
    per_page: int = Query(20, ge=1, le=100),
    search: str | None = Query(None),
):
    return await product_service.list_products(
        db,
        category_slug=slug,
        price_min=price_min,
        price_max=price_max,
        tags=tags,
        sort=sort,
        page=page,
        per_page=per_page,
        search=search,
    )
