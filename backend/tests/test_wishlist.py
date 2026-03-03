import pytest
from httpx import AsyncClient


@pytest.mark.asyncio
async def test_wishlist_empty(client: AsyncClient, auth_headers):
    response = await client.get("/api/v1/wishlist", headers=auth_headers)
    assert response.status_code == 200
    assert response.json() == []


@pytest.mark.asyncio
async def test_add_to_wishlist(client: AsyncClient, auth_headers, sample_product):
    response = await client.post(
        "/api/v1/wishlist",
        json={"product_id": str(sample_product.id)},
        headers=auth_headers,
    )
    assert response.status_code == 201
    data = response.json()
    assert data["product_id"] == str(sample_product.id)


@pytest.mark.asyncio
async def test_add_duplicate_to_wishlist(client: AsyncClient, auth_headers, sample_product):
    await client.post(
        "/api/v1/wishlist",
        json={"product_id": str(sample_product.id)},
        headers=auth_headers,
    )
    response = await client.post(
        "/api/v1/wishlist",
        json={"product_id": str(sample_product.id)},
        headers=auth_headers,
    )
    assert response.status_code == 409


@pytest.mark.asyncio
async def test_remove_from_wishlist(client: AsyncClient, auth_headers, sample_product):
    await client.post(
        "/api/v1/wishlist",
        json={"product_id": str(sample_product.id)},
        headers=auth_headers,
    )
    response = await client.delete(
        f"/api/v1/wishlist/{sample_product.id}", headers=auth_headers
    )
    assert response.status_code == 204


@pytest.mark.asyncio
async def test_wishlist_unauthorized(client: AsyncClient, sample_product):
    response = await client.get("/api/v1/wishlist")
    assert response.status_code == 401
