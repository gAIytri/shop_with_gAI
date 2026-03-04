from __future__ import annotations

import uuid
from datetime import datetime
from typing import TYPE_CHECKING

from sqlalchemy import Boolean, DateTime, ForeignKey, Integer, String, Text
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.core.database import Base

if TYPE_CHECKING:
    from app.products.models import Product
    from app.users.models import User


class Review(Base):
    __tablename__ = "reviews"

    id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    product_id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True), ForeignKey("products.id", ondelete="CASCADE"), nullable=False
    )
    user_id: Mapped[uuid.UUID | None] = mapped_column(
        UUID(as_uuid=True), ForeignKey("users.id", ondelete="SET NULL")
    )
    order_id: Mapped[uuid.UUID | None] = mapped_column(
        UUID(as_uuid=True), ForeignKey("orders.id", ondelete="SET NULL")
    )

    rating: Mapped[int] = mapped_column(Integer, nullable=False)
    title: Mapped[str | None] = mapped_column(String(255))
    content: Mapped[str | None] = mapped_column(Text)

    is_verified_purchase: Mapped[bool] = mapped_column(Boolean, default=False)
    is_recommended: Mapped[bool | None] = mapped_column(Boolean)

    helpful_count: Mapped[int] = mapped_column(Integer, default=0)
    not_helpful_count: Mapped[int] = mapped_column(Integer, default=0)

    is_approved: Mapped[bool] = mapped_column(Boolean, default=False)
    is_featured: Mapped[bool] = mapped_column(Boolean, default=False)
    moderated_at: Mapped[datetime | None] = mapped_column(DateTime(timezone=True))

    store_response: Mapped[str | None] = mapped_column(Text)
    store_responded_at: Mapped[datetime | None] = mapped_column(DateTime(timezone=True))

    created_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True), default=datetime.utcnow
    )
    updated_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True), default=datetime.utcnow, onupdate=datetime.utcnow
    )

    # Relationships
    product: Mapped[Product] = relationship("Product", back_populates="reviews")
    user: Mapped[User | None] = relationship("User", back_populates="reviews")
    images: Mapped[list[ReviewImage]] = relationship(
        back_populates="review", cascade="all, delete-orphan"
    )


class ReviewImage(Base):
    __tablename__ = "review_images"

    id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    review_id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True), ForeignKey("reviews.id", ondelete="CASCADE"), nullable=False
    )
    url: Mapped[str] = mapped_column(Text, nullable=False)
    created_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True), default=datetime.utcnow
    )

    # Relationships
    review: Mapped[Review] = relationship(back_populates="images")
