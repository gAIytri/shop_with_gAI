from uuid import UUID

from fastapi import APIRouter, Query

from app.core.dependencies import CurrentUser, DbSession
from app.reviews import service
from app.reviews.schemas import PaginatedReviews, ReviewCreate, ReviewOut

router = APIRouter(tags=["reviews"])

# Product reviews — mounted under /products
product_reviews_router = APIRouter()


@product_reviews_router.get(
    "/products/{product_id}/reviews", response_model=PaginatedReviews
)
async def get_product_reviews(
    db: DbSession,
    product_id: UUID,
    page: int = Query(1, ge=1),
    per_page: int = Query(10, ge=1, le=50),
):
    return await service.get_product_reviews(db, product_id, page, per_page)


# User reviews — mounted under /reviews
@router.post("/reviews", response_model=ReviewOut, status_code=201)
async def create_review(
    db: DbSession,
    user: CurrentUser,
    data: ReviewCreate,
):
    return await service.create_review(db, user, data)


@router.get("/reviews/me", response_model=list[ReviewOut])
async def get_my_reviews(
    db: DbSession,
    user: CurrentUser,
):
    return await service.get_user_reviews(db, user.id)
