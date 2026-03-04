from uuid import UUID

from fastapi import APIRouter

from app.core.dependencies import CurrentUser, DbSession
from app.wishlist import service
from app.wishlist.schemas import AddWishlistItem, WishlistItemOut

router = APIRouter(prefix="/wishlist", tags=["wishlist"])


@router.get("", response_model=list[WishlistItemOut])
async def list_wishlist(db: DbSession, user: CurrentUser):
    return await service.list_items(db, user.id)


@router.post("", response_model=WishlistItemOut, status_code=201)
async def add_to_wishlist(db: DbSession, user: CurrentUser, data: AddWishlistItem):
    return await service.add_item(db, user.id, data.product_id)


@router.delete("/{product_id}", status_code=204)
async def remove_from_wishlist(db: DbSession, user: CurrentUser, product_id: UUID):
    await service.remove_item(db, user.id, product_id)
