import pytest
from httpx import AsyncClient


@pytest.mark.asyncio
async def test_list_categories(client: AsyncClient, sample_category):
    response = await client.get("/api/v1/categories")
    assert response.status_code == 200
    data = response.json()
    assert len(data) >= 1
    assert data[0]["name"] == "Lighting"
    assert data[0]["slug"] == "lighting"


@pytest.mark.asyncio
async def test_get_category_by_slug(client: AsyncClient, sample_category):
    response = await client.get("/api/v1/categories/lighting")
    assert response.status_code == 200
    data = response.json()
    assert data["name"] == "Lighting"
    assert "product_count" in data
    assert "attribute_templates" in data


@pytest.mark.asyncio
async def test_get_category_not_found(client: AsyncClient):
    response = await client.get("/api/v1/categories/nonexistent")
    assert response.status_code == 404


@pytest.mark.asyncio
async def test_category_products(client: AsyncClient, sample_product, sample_category):
    response = await client.get("/api/v1/categories/lighting/products")
    assert response.status_code == 200
    data = response.json()
    assert data["meta"]["total"] >= 1
