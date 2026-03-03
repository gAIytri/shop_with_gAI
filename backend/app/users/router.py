from uuid import UUID

from fastapi import APIRouter

from app.core.dependencies import CurrentUser, DbSession
from app.users import service
from app.users.schemas import AddressCreate, AddressOut, AddressUpdate, UserOut, UserUpdate

router = APIRouter(prefix="/users", tags=["users"])


@router.get("/me", response_model=UserOut)
async def get_profile(user: CurrentUser):
    return await service.get_profile(user)


@router.patch("/me", response_model=UserOut)
async def update_profile(db: DbSession, user: CurrentUser, data: UserUpdate):
    return await service.update_profile(db, user, data)


@router.get("/me/addresses", response_model=list[AddressOut])
async def list_addresses(db: DbSession, user: CurrentUser):
    return await service.list_addresses(db, user.id)


@router.post("/me/addresses", response_model=AddressOut, status_code=201)
async def create_address(db: DbSession, user: CurrentUser, data: AddressCreate):
    return await service.create_address(db, user.id, data)


@router.patch("/me/addresses/{address_id}", response_model=AddressOut)
async def update_address(
    db: DbSession, user: CurrentUser, address_id: UUID, data: AddressUpdate
):
    return await service.update_address(db, user.id, address_id, data)


@router.delete("/me/addresses/{address_id}", status_code=204)
async def delete_address(db: DbSession, user: CurrentUser, address_id: UUID):
    await service.delete_address(db, user.id, address_id)


@router.patch("/me/addresses/{address_id}/default", response_model=AddressOut)
async def set_default_address(db: DbSession, user: CurrentUser, address_id: UUID):
    return await service.set_default_address(db, user.id, address_id)
