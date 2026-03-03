from contextlib import asynccontextmanager
from collections.abc import AsyncGenerator

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.core.config import settings
from app.core.exceptions import AppException, app_exception_handler

# Import all models so relationships resolve
import app.models  # noqa: F401


@asynccontextmanager
async def lifespan(app: FastAPI) -> AsyncGenerator[None, None]:
    # Startup
    yield
    # Shutdown
    from app.core.database import engine

    await engine.dispose()


app = FastAPI(
    title="Shop with gAI",
    description="Voice-first e-commerce API",
    version="0.1.0",
    lifespan=lifespan,
    docs_url="/api/docs",
    redoc_url="/api/redoc",
    openapi_url="/api/openapi.json",
)

# CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.cors_origins_list,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Exception handlers
app.add_exception_handler(AppException, app_exception_handler)


# Health check
@app.get("/api/health")
async def health_check():
    return {"status": "ok", "version": "0.1.0"}


# Register routers
from app.products.router import router as products_router
from app.categories.router import router as categories_router
from app.cart.router import router as cart_router
from app.orders.router import router as orders_router
from app.users.router import router as users_router
from app.wishlist.router import router as wishlist_router
from app.reviews.router import router as reviews_router
from app.reviews.router import product_reviews_router
from app.search.router import router as search_router
from app.checkout.router import router as checkout_router

app.include_router(products_router, prefix="/api/v1")
app.include_router(categories_router, prefix="/api/v1")
app.include_router(cart_router, prefix="/api/v1")
app.include_router(orders_router, prefix="/api/v1")
app.include_router(users_router, prefix="/api/v1")
app.include_router(wishlist_router, prefix="/api/v1")
app.include_router(reviews_router, prefix="/api/v1")
app.include_router(product_reviews_router, prefix="/api/v1")
app.include_router(search_router, prefix="/api/v1")
app.include_router(checkout_router, prefix="/api/v1")
