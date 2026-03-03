from fastapi import APIRouter, Query

from app.core.dependencies import DbSession
from app.search import service
from app.search.schemas import SearchResult, SearchSuggestion

router = APIRouter(prefix="/search", tags=["search"])


@router.get("", response_model=SearchResult)
async def search_products(
    db: DbSession,
    q: str = Query(..., min_length=1, description="Search query"),
    page: int = Query(1, ge=1),
    per_page: int = Query(20, ge=1, le=100),
):
    return await service.search_products(db, q, page, per_page)


@router.get("/suggestions", response_model=list[SearchSuggestion])
async def search_suggestions(
    db: DbSession,
    q: str = Query(..., min_length=1, description="Partial query"),
):
    return await service.search_suggestions(db, q)
