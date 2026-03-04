from uuid import UUID

from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from app.core.exceptions import ConflictError, NotFoundError
from app.products.models import Product
from app.wishlist.models import Wishlist, WishlistItem
from app.wishlist.schemas import WishlistItemOut


async def _get_or_create_wishlist(db: AsyncSession, user_id: UUID) -> Wishlist:
    query = select(Wishlist).where(
        Wishlist.user_id == user_id, Wishlist.is_default.is_(True)
    )
    result = await db.execute(query)
    wishlist = result.scalar_one_or_none()

    if not wishlist:
        wishlist = Wishlist(user_id=user_id)
        db.add(wishlist)
        await db.flush()

    return wishlist


async def list_items(db: AsyncSession, user_id: UUID) -> list[WishlistItemOut]:
    wishlist = await _get_or_create_wishlist(db, user_id)

    query = (
        select(WishlistItem)
        .where(WishlistItem.wishlist_id == wishlist.id)
        .options(
            selectinload(WishlistItem.product).selectinload(Product.images)
        )
        .order_by(WishlistItem.created_at.desc())
    )
    result = await db.execute(query)
    items = result.scalars().unique().all()
    return [WishlistItemOut.model_validate(i) for i in items]


async def add_item(db: AsyncSession, user_id: UUID, product_id: UUID) -> WishlistItemOut:
    # Verify product exists
    product = await db.get(Product, product_id)
    if not product or product.deleted_at or not product.is_active:
        raise NotFoundError("Product", str(product_id))

    wishlist = await _get_or_create_wishlist(db, user_id)

    # Check for duplicate
    existing = await db.execute(
        select(WishlistItem).where(
            WishlistItem.wishlist_id == wishlist.id,
            WishlistItem.product_id == product_id,
        )
    )
    if existing.scalar_one_or_none():
        raise ConflictError("Product already in wishlist")

    item = WishlistItem(
        wishlist_id=wishlist.id,
        product_id=product_id,
        added_at_price=product.price,
    )
    db.add(item)
    await db.commit()
    await db.refresh(item)

    # Reload with product
    query = (
        select(WishlistItem)
        .where(WishlistItem.id == item.id)
        .options(selectinload(WishlistItem.product).selectinload(Product.images))
    )
    item = (await db.execute(query)).scalar_one()
    return WishlistItemOut.model_validate(item)


async def remove_item(db: AsyncSession, user_id: UUID, product_id: UUID) -> None:
    wishlist = await _get_or_create_wishlist(db, user_id)

    query = select(WishlistItem).where(
        WishlistItem.wishlist_id == wishlist.id,
        WishlistItem.product_id == product_id,
    )
    item = (await db.execute(query)).scalar_one_or_none()

    if not item:
        raise NotFoundError("Wishlist item", str(product_id))

    await db.delete(item)
    await db.commit()
