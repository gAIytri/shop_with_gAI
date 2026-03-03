import pytest
from httpx import AsyncClient


@pytest.mark.asyncio
async def test_get_profile(client: AsyncClient, auth_headers, test_user):
    response = await client.get("/api/v1/users/me", headers=auth_headers)
    assert response.status_code == 200
    data = response.json()
    assert data["email"] == "test@example.com"
    assert data["first_name"] == "Test"


@pytest.mark.asyncio
async def test_get_profile_unauthorized(client: AsyncClient):
    response = await client.get("/api/v1/users/me")
    assert response.status_code == 401


@pytest.mark.asyncio
async def test_update_profile(client: AsyncClient, auth_headers):
    response = await client.patch(
        "/api/v1/users/me",
        json={"display_name": "Test Display", "phone": "+1234567890"},
        headers=auth_headers,
    )
    assert response.status_code == 200
    data = response.json()
    assert data["display_name"] == "Test Display"
    assert data["phone"] == "+1234567890"


@pytest.mark.asyncio
async def test_address_crud(client: AsyncClient, auth_headers):
    # Create
    create_resp = await client.post(
        "/api/v1/users/me/addresses",
        json={
            "street_address": "123 Main St",
            "city": "New York",
            "state": "NY",
            "postal_code": "10001",
            "is_default": True,
        },
        headers=auth_headers,
    )
    assert create_resp.status_code == 201
    addr = create_resp.json()
    assert addr["street_address"] == "123 Main St"
    assert addr["is_default"] is True
    address_id = addr["id"]

    # List
    list_resp = await client.get("/api/v1/users/me/addresses", headers=auth_headers)
    assert list_resp.status_code == 200
    assert len(list_resp.json()) >= 1

    # Update
    update_resp = await client.patch(
        f"/api/v1/users/me/addresses/{address_id}",
        json={"city": "Brooklyn"},
        headers=auth_headers,
    )
    assert update_resp.status_code == 200
    assert update_resp.json()["city"] == "Brooklyn"

    # Delete
    del_resp = await client.delete(
        f"/api/v1/users/me/addresses/{address_id}", headers=auth_headers
    )
    assert del_resp.status_code == 204
