import pytest
from httpx import AsyncClient


@pytest.mark.asyncio
async def test_list_products(client: AsyncClient, sample_product):
    response = await client.get("/api/v1/products")
    assert response.status_code == 200
    data = response.json()
    assert "items" in data
    assert "meta" in data
    assert data["meta"]["total"] >= 1
    assert data["items"][0]["name"] == "Modern Globe Pendant"


@pytest.mark.asyncio
async def test_list_products_filter_by_category(client: AsyncClient, sample_product):
    response = await client.get("/api/v1/products?category=lighting")
    assert response.status_code == 200
    data = response.json()
    assert data["meta"]["total"] >= 1


@pytest.mark.asyncio
async def test_list_products_filter_by_price(client: AsyncClient, sample_product):
    response = await client.get("/api/v1/products?price_min=100&price_max=200")
    assert response.status_code == 200
    data = response.json()
    assert data["meta"]["total"] >= 1

    response = await client.get("/api/v1/products?price_min=500")
    assert response.status_code == 200
    data = response.json()
    assert data["meta"]["total"] == 0


@pytest.mark.asyncio
async def test_list_products_sort(client: AsyncClient, sample_product):
    response = await client.get("/api/v1/products?sort=price_asc")
    assert response.status_code == 200

    response = await client.get("/api/v1/products?sort=name")
    assert response.status_code == 200


@pytest.mark.asyncio
async def test_list_products_pagination(client: AsyncClient, sample_product):
    response = await client.get("/api/v1/products?page=1&per_page=5")
    assert response.status_code == 200
    data = response.json()
    assert data["meta"]["per_page"] == 5


@pytest.mark.asyncio
async def test_get_product_by_sku(client: AsyncClient, sample_product):
    response = await client.get("/api/v1/products/TEST-001")
    assert response.status_code == 200
    data = response.json()
    assert data["sku"] == "TEST-001"
    assert data["name"] == "Modern Globe Pendant"
    assert len(data["images"]) >= 1


@pytest.mark.asyncio
async def test_get_product_not_found(client: AsyncClient):
    response = await client.get("/api/v1/products/NONEXISTENT")
    assert response.status_code == 404
