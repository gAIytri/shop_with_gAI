import math
from decimal import Decimal
from uuid import UUID

from sqlalchemy import func, select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from app.categories.models import Category
from app.core.exceptions import NotFoundError
from app.products.models import Product, ProductRelation
from app.products.schemas import (
    PaginatedProducts,
    PaginationMeta,
    ProductDetail,
    ProductListItem,
    ProductRelationOut,
    ProductSortField,
)


async def list_products(
    db: AsyncSession,
    *,
    category_slug: str | None = None,
    price_min: Decimal | None = None,
    price_max: Decimal | None = None,
    attributes: dict | None = None,
    tags: str | None = None,
    sort: ProductSortField = ProductSortField.newest,
    page: int = 1,
    per_page: int = 20,
    search: str | None = None,
    is_featured: bool | None = None,
    is_bestseller: bool | None = None,
    is_new: bool | None = None,
) -> PaginatedProducts:
    # Base query — active, non-deleted products
    query = (
        select(Product)
        .where(Product.is_active.is_(True))
        .where(Product.deleted_at.is_(None))
        .options(
            selectinload(Product.images),
            selectinload(Product.category),
        )
    )

    # --- Filters ---

    if category_slug:
        query = query.join(Product.category).where(Category.slug == category_slug)

    if price_min is not None:
        query = query.where(Product.price >= price_min)

    if price_max is not None:
        query = query.where(Product.price <= price_max)

    if attributes:
        for key, value in attributes.items():
            query = query.where(Product.attributes[key].astext == str(value))

    if tags:
        for tag in tags.split(","):
            tag = tag.strip()
            if tag:
                query = query.where(Product.tags.contains([tag]))

    if is_featured is not None:
        query = query.where(Product.is_featured.is_(is_featured))

    if is_bestseller is not None:
        query = query.where(Product.is_bestseller.is_(is_bestseller))

    if is_new is not None:
        query = query.where(Product.is_new.is_(is_new))

    if search:
        search_filter = Product.name.ilike(f"%{search}%")
        query = query.where(search_filter)

    # --- Count total ---
    count_query = select(func.count()).select_from(query.subquery())
    total_result = await db.execute(count_query)
    total = total_result.scalar_one()

    # --- Sort ---
    sort_map = {
        ProductSortField.price_asc: Product.price.asc(),
        ProductSortField.price_desc: Product.price.desc(),
        ProductSortField.rating: Product.avg_rating.desc(),
        ProductSortField.newest: Product.created_at.desc(),
        ProductSortField.name: Product.name.asc(),
    }
    query = query.order_by(sort_map.get(sort, Product.created_at.desc()))

    # --- Paginate ---
    per_page = min(max(per_page, 1), 100)
    page = max(page, 1)
    offset = (page - 1) * per_page
    query = query.offset(offset).limit(per_page)

    result = await db.execute(query)
    products = result.scalars().unique().all()

    return PaginatedProducts(
        items=[ProductListItem.model_validate(p) for p in products],
        meta=PaginationMeta(
            page=page,
            per_page=per_page,
            total=total,
            total_pages=math.ceil(total / per_page) if per_page else 0,
        ),
    )


async def get_product_by_slug(db: AsyncSession, slug: str) -> ProductDetail:
    """Look up product by slug (we use SKU as slug since there's no slug column)."""
    # The seed data uses SKU as the unique identifier; products don't have a slug column.
    # We'll search by SKU first, then by name-based slug pattern.
    query = (
        select(Product)
        .where(Product.is_active.is_(True))
        .where(Product.deleted_at.is_(None))
        .where(Product.sku == slug)
        .options(
            selectinload(Product.images),
            selectinload(Product.variants),
            selectinload(Product.category),
            selectinload(Product.product_type),
        )
    )
    result = await db.execute(query)
    product = result.scalar_one_or_none()

    if product is None:
        raise NotFoundError("Product", slug)

    return ProductDetail.model_validate(product)


async def get_product_by_id(db: AsyncSession, product_id: UUID) -> Product:
    query = (
        select(Product)
        .where(Product.id == product_id)
        .where(Product.is_active.is_(True))
        .where(Product.deleted_at.is_(None))
        .options(
            selectinload(Product.images),
            selectinload(Product.variants),
            selectinload(Product.category),
            selectinload(Product.product_type),
        )
    )
    result = await db.execute(query)
    product = result.scalar_one_or_none()

    if product is None:
        raise NotFoundError("Product", str(product_id))

    return product


async def get_related_products(
    db: AsyncSession, product_id: UUID
) -> list[ProductRelationOut]:
    query = (
        select(ProductRelation)
        .where(ProductRelation.product_id == product_id)
        .options(
            selectinload(ProductRelation.related_product).selectinload(Product.images)
        )
        .order_by(ProductRelation.display_order)
    )
    result = await db.execute(query)
    relations = result.scalars().unique().all()

    return [ProductRelationOut.model_validate(r) for r in relations]
