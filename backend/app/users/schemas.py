from datetime import datetime
from uuid import UUID

from pydantic import BaseModel, ConfigDict


class UserOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: UUID
    email: str
    first_name: str | None = None
    last_name: str | None = None
    display_name: str | None = None
    phone: str | None = None
    avatar_url: str | None = None
    role: str
    email_verified: bool = False
    phone_verified: bool = False
    preferred_styles: list | None = None
    preferred_rooms: list | None = None
    preferred_colors: list | None = None
    newsletter_subscribed: bool = False
    created_at: datetime


class UserUpdate(BaseModel):
    first_name: str | None = None
    last_name: str | None = None
    display_name: str | None = None
    phone: str | None = None
    preferred_styles: list | None = None
    preferred_rooms: list | None = None
    preferred_colors: list | None = None
    newsletter_subscribed: bool | None = None


class AddressOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: UUID
    address_type: str
    is_default: bool = False
    label: str | None = None
    street_address: str
    address_line_2: str | None = None
    city: str
    state: str
    postal_code: str
    country: str = "US"
    recipient_name: str | None = None
    recipient_phone: str | None = None
    delivery_instructions: str | None = None


class AddressCreate(BaseModel):
    address_type: str = "both"
    is_default: bool = False
    label: str | None = None
    street_address: str
    address_line_2: str | None = None
    city: str
    state: str
    postal_code: str
    country: str = "US"
    recipient_name: str | None = None
    recipient_phone: str | None = None
    delivery_instructions: str | None = None


class AddressUpdate(BaseModel):
    address_type: str | None = None
    is_default: bool | None = None
    label: str | None = None
    street_address: str | None = None
    address_line_2: str | None = None
    city: str | None = None
    state: str | None = None
    postal_code: str | None = None
    country: str | None = None
    recipient_name: str | None = None
    recipient_phone: str | None = None
    delivery_instructions: str | None = None
