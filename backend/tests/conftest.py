import asyncio
import uuid
from collections.abc import AsyncGenerator
from decimal import Decimal

import pytest
import pytest_asyncio
from httpx import ASGITransport, AsyncClient
from sqlalchemy import event

# --- SQLite compatibility for PostgreSQL-specific types ---
from sqlalchemy.dialects.postgresql import ARRAY, JSONB
from sqlalchemy.ext.asyncio import AsyncSession, async_sessionmaker, create_async_engine
from sqlalchemy.ext.compiler import compiles

# Import all models
import app.models  # noqa: F401
from app.core.database import Base
from app.core.dependencies import get_db
from app.core.security import create_access_token
from app.main import app as fastapi_app


# Make JSONB compile as JSON on SQLite
@compiles(JSONB, "sqlite")
def compile_jsonb_sqlite(type_, compiler, **kw):
    return "JSON"

# Make PostgreSQL ARRAY compile as JSON on SQLite
@compiles(ARRAY, "sqlite")
def compile_array_sqlite(type_, compiler, **kw):
    return "JSON"

# --- End SQLite compatibility ---

TEST_DATABASE_URL = "sqlite+aiosqlite:///:memory:"

engine = create_async_engine(TEST_DATABASE_URL, echo=False)
TestSessionLocal = async_sessionmaker(engine, class_=AsyncSession, expire_on_commit=False)


@event.listens_for(engine.sync_engine, "connect")
def set_sqlite_pragma(dbapi_connection, connection_record):
    cursor = dbapi_connection.cursor()
    cursor.execute("PRAGMA foreign_keys=OFF")
    cursor.close()


@pytest.fixture(scope="session")
def event_loop():
    loop = asyncio.new_event_loop()
    yield loop
    loop.close()


@pytest_asyncio.fixture(autouse=True)
async def setup_db():
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)
    yield
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.drop_all)


@pytest_asyncio.fixture
async def db_session() -> AsyncGenerator[AsyncSession, None]:
    async with TestSessionLocal() as session:
        yield session


@pytest_asyncio.fixture
async def client(db_session: AsyncSession) -> AsyncGenerator[AsyncClient, None]:
    async def override_get_db():
        yield db_session

    fastapi_app.dependency_overrides[get_db] = override_get_db

    async with AsyncClient(
        transport=ASGITransport(app=fastapi_app),
        base_url="http://test",
    ) as ac:
        yield ac

    fastapi_app.dependency_overrides.clear()


@pytest_asyncio.fixture
async def test_user(db_session: AsyncSession):
    from app.users.models import User, UserRole, UserStatus

    user = User(
        id=uuid.uuid4(),
        email="test@example.com",
        first_name="Test",
        last_name="User",
        role=UserRole.customer,
        status=UserStatus.active,
        email_verified=True,
    )
    db_session.add(user)
    await db_session.commit()
    await db_session.refresh(user)
    return user


@pytest_asyncio.fixture
async def admin_user(db_session: AsyncSession):
    from app.users.models import User, UserRole, UserStatus

    user = User(
        id=uuid.uuid4(),
        email="admin@example.com",
        first_name="Admin",
        last_name="User",
        role=UserRole.admin,
        status=UserStatus.active,
        email_verified=True,
    )
    db_session.add(user)
    await db_session.commit()
    await db_session.refresh(user)
    return user


@pytest_asyncio.fixture
async def auth_headers(test_user):
    token = create_access_token({"sub": str(test_user.id)})
    return {"Authorization": f"Bearer {token}"}


@pytest_asyncio.fixture
async def admin_headers(admin_user):
    token = create_access_token({"sub": str(admin_user.id)})
    return {"Authorization": f"Bearer {token}"}


@pytest_asyncio.fixture
async def sample_category(db_session: AsyncSession):
    from app.categories.models import Category

    cat = Category(
        name="Lighting",
        slug="lighting",
        description="Test category",
        display_order=1,
        is_active=True,
    )
    db_session.add(cat)
    await db_session.commit()
    await db_session.refresh(cat)
    return cat


@pytest_asyncio.fixture
async def sample_product(db_session: AsyncSession, sample_category):
    from app.products.models import Product, ProductImage, StockStatus

    product = Product(
        sku="TEST-001",
        name="Modern Globe Pendant",
        description="A beautiful pendant light",
        category_id=sample_category.id,
        price=Decimal("149.99"),
        compare_at_price=Decimal("199.99"),
        stock_quantity=50,
        stock_status=StockStatus.in_stock,
        attributes={"color": ["Brass"], "material": ["Glass"]},
        tags=["modern", "lighting"],
        is_active=True,
        avg_rating=Decimal("4.5"),
        review_count=10,
    )
    db_session.add(product)
    await db_session.flush()

    img = ProductImage(
        product_id=product.id,
        url="https://example.com/image.jpg",
        alt_text="Test product",
        is_primary=True,
        display_order=0,
    )
    db_session.add(img)
    await db_session.commit()
    await db_session.refresh(product)
    return product
