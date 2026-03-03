from fastapi import APIRouter, Query

from app.core.dependencies import CurrentUser, DbSession
from app.orders import service
from app.orders.schemas import (
    CancelOrderRequest,
    OrderDetail,
    PaginatedOrders,
    PlaceOrderRequest,
    ReturnOrderRequest,
)

router = APIRouter(prefix="/orders", tags=["orders"])


@router.post("", response_model=OrderDetail, status_code=201)
async def place_order(db: DbSession, user: CurrentUser, data: PlaceOrderRequest):
    return await service.place_order(
        db,
        user,
        shipping_address_id=data.shipping_address_id,
        billing_address_id=data.billing_address_id,
        shipping_method_id=data.shipping_method_id,
        customer_notes=data.customer_notes,
    )


@router.get("", response_model=PaginatedOrders)
async def list_orders(
    db: DbSession,
    user: CurrentUser,
    page: int = Query(1, ge=1),
    per_page: int = Query(10, ge=1, le=50),
):
    return await service.get_user_orders(db, user.id, page, per_page)


@router.get("/{order_number}", response_model=OrderDetail)
async def get_order(db: DbSession, user: CurrentUser, order_number: str):
    return await service.get_order_detail(db, order_number, user)


@router.post("/{order_number}/cancel", response_model=OrderDetail)
async def cancel_order(db: DbSession, user: CurrentUser, order_number: str):
    return await service.cancel_order(db, order_number, user)


@router.post("/{order_number}/return", response_model=OrderDetail)
async def return_order(
    db: DbSession,
    user: CurrentUser,
    order_number: str,
    data: ReturnOrderRequest,
):
    return await service.return_order(db, order_number, user, data.items, data.reason)
