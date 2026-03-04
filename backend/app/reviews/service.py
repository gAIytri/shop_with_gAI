from uuid import UUID

from sqlalchemy import func, select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from app.core.exceptions import ConflictError, NotFoundError
from app.orders.models import Order, OrderItem
from app.products.models import Product
from app.reviews.models import Review
from app.reviews.schemas import PaginatedReviews, ReviewCreate, ReviewOut
from app.users.models import User


async def get_product_reviews(
    db: AsyncSession,
    product_id: UUID,
    page: int = 1,
    per_page: int = 10,
) -> PaginatedReviews:
    # Verify product exists
    prod = await db.execute(select(Product.id).where(Product.id == product_id))
    if prod.scalar_one_or_none() is None:
        raise NotFoundError("Product", str(product_id))

    base = select(Review).where(
        Review.product_id == product_id,
        Review.is_approved.is_(True),
    )

    # Count
    count_q = select(func.count()).select_from(base.subquery())
    total = (await db.execute(count_q)).scalar_one()

    # Fetch
    per_page = min(max(per_page, 1), 50)
    page = max(page, 1)
    query = (
        base.options(selectinload(Review.images))
        .order_by(Review.created_at.desc())
        .offset((page - 1) * per_page)
        .limit(per_page)
    )
    result = await db.execute(query)
    reviews = result.scalars().unique().all()

    items = []
    for r in reviews:
        data = ReviewOut.model_validate(r)
        # Attach reviewer display name if available
        if r.user_id:
            user_q = await db.execute(
                select(User.first_name, User.last_name).where(User.id == r.user_id)
            )
            row = user_q.one_or_none()
            if row:
                data.reviewer_name = f"{row.first_name or ''} {row.last_name or ''}".strip() or None
        items.append(data)

    return PaginatedReviews(items=items, total=total, page=page, per_page=per_page)


async def create_review(
    db: AsyncSession,
    user: User,
    data: ReviewCreate,
) -> ReviewOut:
    # Check for existing review
    existing = await db.execute(
        select(Review).where(
            Review.product_id == data.product_id,
            Review.user_id == user.id,
        )
    )
    if existing.scalar_one_or_none():
        raise ConflictError("You have already reviewed this product")

    # Check verified purchase
    is_verified = False
    order_id = None
    purchase_q = await db.execute(
        select(OrderItem.order_id)
        .join(Order)
        .where(
            OrderItem.product_id == data.product_id,
            Order.user_id == user.id,
            Order.status.in_(["delivered", "shipped", "completed"]),
        )
        .limit(1)
    )
    purchase = purchase_q.scalar_one_or_none()
    if purchase:
        is_verified = True
        order_id = purchase

    review = Review(
        product_id=data.product_id,
        user_id=user.id,
        order_id=order_id,
        rating=data.rating,
        title=data.title,
        content=data.content,
        is_recommended=data.is_recommended,
        is_verified_purchase=is_verified,
    )
    db.add(review)
    await db.commit()
    await db.refresh(review)

    out = ReviewOut.model_validate(review)
    out.reviewer_name = f"{user.first_name or ''} {user.last_name or ''}".strip() or None
    return out


async def get_user_reviews(
    db: AsyncSession,
    user_id: UUID,
) -> list[ReviewOut]:
    query = (
        select(Review)
        .where(Review.user_id == user_id)
        .options(selectinload(Review.images))
        .order_by(Review.created_at.desc())
    )
    result = await db.execute(query)
    reviews = result.scalars().unique().all()
    return [ReviewOut.model_validate(r) for r in reviews]
