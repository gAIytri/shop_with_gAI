from uuid import UUID

from fastapi import APIRouter, Header

from app.cart import service
from app.cart.schemas import AddCartItem, ApplyCoupon, CartOut, MergeCart, UpdateCartItem
from app.core.dependencies import CurrentUser, DbSession, OptionalUser

router = APIRouter(prefix="/cart", tags=["cart"])


def _session_id(x_session_id: str | None = Header(None)) -> str | None:
    return x_session_id


@router.get("", response_model=CartOut)
async def get_cart(
    db: DbSession,
    user: OptionalUser,
    x_session_id: str | None = Header(None),
):
    return await service.get_cart(db, user=user, session_id=x_session_id)


@router.post("/items", response_model=CartOut, status_code=201)
async def add_item(
    db: DbSession,
    data: AddCartItem,
    user: OptionalUser,
    x_session_id: str | None = Header(None),
):
    return await service.add_item(
        db,
        data_product_id=data.product_id,
        data_variant_id=data.variant_id,
        data_quantity=data.quantity,
        user=user,
        session_id=x_session_id,
    )


@router.patch("/items/{item_id}", response_model=CartOut)
async def update_item(
    db: DbSession,
    item_id: UUID,
    data: UpdateCartItem,
    user: OptionalUser,
    x_session_id: str | None = Header(None),
):
    return await service.update_item(
        db, item_id, data.quantity, user=user, session_id=x_session_id
    )


@router.delete("/items/{item_id}", response_model=CartOut)
async def remove_item(
    db: DbSession,
    item_id: UUID,
    user: OptionalUser,
    x_session_id: str | None = Header(None),
):
    return await service.remove_item(db, item_id, user=user, session_id=x_session_id)


@router.delete("", response_model=CartOut)
async def clear_cart(
    db: DbSession,
    user: OptionalUser,
    x_session_id: str | None = Header(None),
):
    return await service.clear_cart(db, user=user, session_id=x_session_id)


@router.post("/merge", response_model=CartOut)
async def merge_carts(
    db: DbSession,
    user: CurrentUser,
    data: MergeCart,
):
    return await service.merge_carts(db, user, data.session_id)


@router.post("/apply-coupon", response_model=CartOut)
async def apply_coupon(
    db: DbSession,
    data: ApplyCoupon,
    user: OptionalUser,
    x_session_id: str | None = Header(None),
):
    return await service.apply_coupon(db, data.code, user=user, session_id=x_session_id)


@router.delete("/coupon", response_model=CartOut)
async def remove_coupon(
    db: DbSession,
    user: OptionalUser,
    x_session_id: str | None = Header(None),
):
    return await service.remove_coupon(db, user=user, session_id=x_session_id)
