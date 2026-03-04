from uuid import UUID

from sqlalchemy import select, update
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.exceptions import NotFoundError
from app.users.models import Address, User
from app.users.schemas import AddressCreate, AddressOut, AddressUpdate, UserOut, UserUpdate


async def get_profile(user: User) -> UserOut:
    return UserOut.model_validate(user)


async def update_profile(db: AsyncSession, user: User, data: UserUpdate) -> UserOut:
    update_data = data.model_dump(exclude_unset=True)
    for key, value in update_data.items():
        setattr(user, key, value)
    await db.commit()
    await db.refresh(user)
    return UserOut.model_validate(user)


async def list_addresses(db: AsyncSession, user_id: UUID) -> list[AddressOut]:
    query = select(Address).where(Address.user_id == user_id).order_by(Address.is_default.desc())
    result = await db.execute(query)
    return [AddressOut.model_validate(a) for a in result.scalars().all()]


async def create_address(db: AsyncSession, user_id: UUID, data: AddressCreate) -> AddressOut:
    # If new address is default, unset existing defaults
    if data.is_default:
        await db.execute(
            update(Address)
            .where(Address.user_id == user_id, Address.is_default.is_(True))
            .values(is_default=False)
        )

    address = Address(user_id=user_id, **data.model_dump())
    db.add(address)
    await db.commit()
    await db.refresh(address)
    return AddressOut.model_validate(address)


async def update_address(
    db: AsyncSession, user_id: UUID, address_id: UUID, data: AddressUpdate
) -> AddressOut:
    address = await db.get(Address, address_id)
    if not address or address.user_id != user_id:
        raise NotFoundError("Address", str(address_id))

    update_data = data.model_dump(exclude_unset=True)

    if update_data.get("is_default"):
        await db.execute(
            update(Address)
            .where(Address.user_id == user_id, Address.is_default.is_(True))
            .values(is_default=False)
        )

    for key, value in update_data.items():
        setattr(address, key, value)

    await db.commit()
    await db.refresh(address)
    return AddressOut.model_validate(address)


async def delete_address(db: AsyncSession, user_id: UUID, address_id: UUID) -> None:
    address = await db.get(Address, address_id)
    if not address or address.user_id != user_id:
        raise NotFoundError("Address", str(address_id))
    await db.delete(address)
    await db.commit()


async def set_default_address(db: AsyncSession, user_id: UUID, address_id: UUID) -> AddressOut:
    address = await db.get(Address, address_id)
    if not address or address.user_id != user_id:
        raise NotFoundError("Address", str(address_id))

    await db.execute(
        update(Address)
        .where(Address.user_id == user_id, Address.is_default.is_(True))
        .values(is_default=False)
    )
    address.is_default = True
    await db.commit()
    await db.refresh(address)
    return AddressOut.model_validate(address)
