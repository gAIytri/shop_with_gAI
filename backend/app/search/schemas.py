from pydantic import BaseModel

from app.products.schemas import PaginatedProducts


class SearchResult(PaginatedProducts):
    query: str


class SearchSuggestion(BaseModel):
    text: str
    score: float
