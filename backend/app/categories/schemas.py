from uuid import UUID

from pydantic import BaseModel, ConfigDict


class ProductTypeOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: UUID
    name: str
    slug: str
    description: str | None = None


class CategoryOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: UUID
    name: str
    slug: str
    description: str | None = None
    image_url: str | None = None
    icon: str | None = None
    display_order: int = 0
    is_active: bool = True
    meta_title: str | None = None
    meta_description: str | None = None
    product_types: list[ProductTypeOut] = []
    children: list["CategoryOut"] = []


class CategoryDetail(CategoryOut):
    product_count: int = 0
    attribute_templates: list[dict] = []


# Resolve forward refs
CategoryOut.model_rebuild()
