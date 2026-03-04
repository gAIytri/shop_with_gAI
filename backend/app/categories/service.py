from sqlalchemy import func, select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from app.admin.models import AttributeTemplate
from app.categories.models import Category
from app.categories.schemas import CategoryDetail, CategoryOut
from app.core.exceptions import NotFoundError
from app.products.models import Product


async def get_categories_tree(db: AsyncSession) -> list[CategoryOut]:
    """Get all top-level categories with children and product types."""
    query = (
        select(Category)
        .where(Category.is_active.is_(True))
        .where(Category.parent_id.is_(None))
        .options(
            selectinload(Category.product_types),
            selectinload(Category.children).selectinload(Category.product_types),
        )
        .order_by(Category.display_order)
    )
    result = await db.execute(query)
    categories = result.scalars().unique().all()
    return [CategoryOut.model_validate(c) for c in categories]


async def get_category_by_slug(db: AsyncSession, slug: str) -> CategoryDetail:
    """Get single category with product types, attribute templates, and product count."""
    query = (
        select(Category)
        .where(Category.slug == slug)
        .where(Category.is_active.is_(True))
        .options(
            selectinload(Category.product_types),
            selectinload(Category.children),
        )
    )
    result = await db.execute(query)
    category = result.scalar_one_or_none()

    if category is None:
        raise NotFoundError("Category", slug)

    # Product count
    count_q = select(func.count()).select_from(
        select(Product.id)
        .where(Product.category_id == category.id)
        .where(Product.is_active.is_(True))
        .where(Product.deleted_at.is_(None))
        .subquery()
    )
    product_count = (await db.execute(count_q)).scalar_one()

    # Attribute templates
    attr_q = (
        select(AttributeTemplate)
        .where(AttributeTemplate.category_id == category.id)
        .where(AttributeTemplate.is_filterable.is_(True))
        .order_by(AttributeTemplate.sort_order)
    )
    attr_result = await db.execute(attr_q)
    templates = attr_result.scalars().all()

    detail = CategoryDetail.model_validate(category)
    detail.product_count = product_count
    detail.attribute_templates = [
        {
            "id": str(t.id),
            "name": t.name,
            "display_name": t.display_name,
            "type": t.type,
            "attribute_path": t.attribute_path,
            "options": t.options,
        }
        for t in templates
    ]
    return detail
