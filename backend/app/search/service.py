import math

from sqlalchemy import func, or_, select, text
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from app.categories.models import Category
from app.products.models import Product
from app.products.schemas import PaginationMeta, ProductListItem
from app.search.schemas import SearchResult, SearchSuggestion


async def search_products(
    db: AsyncSession,
    query_text: str,
    page: int = 1,
    per_page: int = 20,
) -> SearchResult:
    """Full-text search using PostgreSQL ILIKE + trigram similarity."""
    search_term = f"%{query_text}%"

    query = (
        select(Product)
        .where(Product.is_active.is_(True))
        .where(Product.deleted_at.is_(None))
        .where(
            or_(
                Product.name.ilike(search_term),
                Product.description.ilike(search_term),
                Product.tags.cast(str).ilike(search_term),
            )
        )
        .options(
            selectinload(Product.images),
            selectinload(Product.category),
        )
    )

    # Count
    count_q = select(func.count()).select_from(query.subquery())
    total = (await db.execute(count_q)).scalar_one()

    per_page = min(max(per_page, 1), 100)
    page = max(page, 1)

    query = query.order_by(Product.avg_rating.desc()).offset((page - 1) * per_page).limit(per_page)
    result = await db.execute(query)
    products = result.scalars().unique().all()

    return SearchResult(
        query=query_text,
        items=[ProductListItem.model_validate(p) for p in products],
        meta=PaginationMeta(
            page=page,
            per_page=per_page,
            total=total,
            total_pages=math.ceil(total / per_page) if per_page else 0,
        ),
    )


async def search_suggestions(
    db: AsyncSession,
    partial: str,
    limit: int = 10,
) -> list[SearchSuggestion]:
    """Autocomplete using trigram similarity on product names."""
    query = (
        select(
            Product.name,
            func.similarity(Product.name, partial).label("score"),
        )
        .where(Product.is_active.is_(True))
        .where(Product.deleted_at.is_(None))
        .where(func.similarity(Product.name, partial) > 0.1)
        .order_by(text("score DESC"))
        .limit(limit)
    )
    result = await db.execute(query)
    rows = result.all()

    return [SearchSuggestion(text=row.name, score=float(row.score)) for row in rows]
