import pytest
from httpx import AsyncClient


@pytest.mark.asyncio
async def test_get_cart_guest(client: AsyncClient):
    response = await client.get(
        "/api/v1/cart", headers={"X-Session-Id": "test-session-123"}
    )
    assert response.status_code == 200
    data = response.json()
    assert data["item_count"] == 0
    assert data["session_id"] == "test-session-123"


@pytest.mark.asyncio
async def test_get_cart_authenticated(client: AsyncClient, auth_headers):
    response = await client.get("/api/v1/cart", headers=auth_headers)
    assert response.status_code == 200
    data = response.json()
    assert data["item_count"] == 0


@pytest.mark.asyncio
async def test_add_item_to_cart(client: AsyncClient, sample_product, auth_headers):
    response = await client.post(
        "/api/v1/cart/items",
        json={"product_id": str(sample_product.id), "quantity": 2},
        headers=auth_headers,
    )
    assert response.status_code == 201
    data = response.json()
    assert data["item_count"] == 2
    assert len(data["items"]) == 1
    assert data["items"][0]["quantity"] == 2


@pytest.mark.asyncio
async def test_add_item_insufficient_stock(client: AsyncClient, sample_product, auth_headers):
    response = await client.post(
        "/api/v1/cart/items",
        json={"product_id": str(sample_product.id), "quantity": 999},
        headers=auth_headers,
    )
    assert response.status_code == 409


@pytest.mark.asyncio
async def test_update_cart_item(client: AsyncClient, sample_product, auth_headers):
    # Add item first
    add_resp = await client.post(
        "/api/v1/cart/items",
        json={"product_id": str(sample_product.id), "quantity": 1},
        headers=auth_headers,
    )
    item_id = add_resp.json()["items"][0]["id"]

    # Update quantity
    response = await client.patch(
        f"/api/v1/cart/items/{item_id}",
        json={"quantity": 5},
        headers=auth_headers,
    )
    assert response.status_code == 200
    assert response.json()["items"][0]["quantity"] == 5


@pytest.mark.asyncio
async def test_remove_cart_item(client: AsyncClient, sample_product, auth_headers):
    # Add item
    add_resp = await client.post(
        "/api/v1/cart/items",
        json={"product_id": str(sample_product.id), "quantity": 1},
        headers=auth_headers,
    )
    item_id = add_resp.json()["items"][0]["id"]

    # Remove
    response = await client.delete(
        f"/api/v1/cart/items/{item_id}", headers=auth_headers
    )
    assert response.status_code == 200
    assert response.json()["item_count"] == 0


@pytest.mark.asyncio
async def test_clear_cart(client: AsyncClient, sample_product, auth_headers):
    await client.post(
        "/api/v1/cart/items",
        json={"product_id": str(sample_product.id), "quantity": 1},
        headers=auth_headers,
    )

    response = await client.delete("/api/v1/cart", headers=auth_headers)
    assert response.status_code == 200
    assert response.json()["item_count"] == 0
