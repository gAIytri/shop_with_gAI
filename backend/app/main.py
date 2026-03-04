from collections.abc import AsyncGenerator
from contextlib import asynccontextmanager

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

# Import all models so relationships resolve
import app.models  # noqa: F401
from app.cart.router import router as cart_router
from app.categories.router import router as categories_router
from app.checkout.router import router as checkout_router
from app.core.config import settings
from app.core.exceptions import AppException, app_exception_handler
from app.orders.router import router as orders_router
from app.products.router import router as products_router
from app.reviews.router import product_reviews_router
from app.reviews.router import router as reviews_router
from app.search.router import router as search_router
from app.users.router import router as users_router
from app.wishlist.router import router as wishlist_router


@asynccontextmanager
async def lifespan(application: FastAPI) -> AsyncGenerator[None, None]:
    # Startup
    yield
    # Shutdown
    from app.core.database import engine

    await engine.dispose()


application = FastAPI(
    title="Shop with gAI",
    description="Voice-first e-commerce API",
    version="0.1.0",
    lifespan=lifespan,
    docs_url="/api/docs",
    redoc_url="/api/redoc",
    openapi_url="/api/openapi.json",
)

# CORS
application.add_middleware(
    CORSMiddleware,
    allow_origins=settings.cors_origins_list,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Exception handlers
application.add_exception_handler(AppException, app_exception_handler)


# Health check
@application.get("/api/health")
async def health_check():
    return {"status": "ok", "version": "0.1.0"}


# Register routers
application.include_router(products_router, prefix="/api/v1")
application.include_router(categories_router, prefix="/api/v1")
application.include_router(cart_router, prefix="/api/v1")
application.include_router(orders_router, prefix="/api/v1")
application.include_router(users_router, prefix="/api/v1")
application.include_router(wishlist_router, prefix="/api/v1")
application.include_router(reviews_router, prefix="/api/v1")
application.include_router(product_reviews_router, prefix="/api/v1")
application.include_router(search_router, prefix="/api/v1")
application.include_router(checkout_router, prefix="/api/v1")

# Alias for backward compatibility (uvicorn app.main:app)
app = application
