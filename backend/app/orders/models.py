from __future__ import annotations

import enum
import uuid
from datetime import date, datetime
from decimal import Decimal
from typing import TYPE_CHECKING

from sqlalchemy import (
    CheckConstraint,
    Date,
    DateTime,
    Enum,
    ForeignKey,
    Integer,
    Numeric,
    String,
    Text,
)
from sqlalchemy.dialects.postgresql import JSONB, UUID
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.core.database import Base

if TYPE_CHECKING:
    from app.products.models import Product, ProductVariant
    from app.users.models import User


class OrderStatus(str, enum.Enum):
    pending = "pending"
    confirmed = "confirmed"
    processing = "processing"
    shipped = "shipped"
    delivered = "delivered"
    cancelled = "cancelled"
    refunded = "refunded"
    returned = "returned"


class PaymentStatus(str, enum.Enum):
    pending = "pending"
    authorized = "authorized"
    captured = "captured"
    failed = "failed"
    refunded = "refunded"
    partially_refunded = "partially_refunded"


class PaymentMethod(str, enum.Enum):
    credit_card = "credit_card"
    debit_card = "debit_card"
    paypal = "paypal"
    apple_pay = "apple_pay"
    google_pay = "google_pay"
    bank_transfer = "bank_transfer"
    cod = "cod"


class Order(Base):
    __tablename__ = "orders"

    id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True), primary_key=True, default=uuid.uuid4
    )
    order_number: Mapped[str] = mapped_column(String(50), unique=True, nullable=False)
    user_id: Mapped[uuid.UUID | None] = mapped_column(
        UUID(as_uuid=True), ForeignKey("users.id", ondelete="SET NULL")
    )

    status: Mapped[OrderStatus] = mapped_column(
        Enum(OrderStatus, name="order_status", create_type=False),
        default=OrderStatus.pending,
    )

    # Addresses (snapshots)
    shipping_address: Mapped[dict] = mapped_column(JSONB, nullable=False)
    billing_address: Mapped[dict] = mapped_column(JSONB, nullable=False)

    # Contact
    customer_email: Mapped[str] = mapped_column(String(255), nullable=False)
    customer_phone: Mapped[str | None] = mapped_column(String(20))
    customer_name: Mapped[str | None] = mapped_column(String(200))

    # Financials
    subtotal: Mapped[Decimal] = mapped_column(Numeric(10, 2), nullable=False)
    discount_amount: Mapped[Decimal] = mapped_column(Numeric(10, 2), default=0)
    shipping_amount: Mapped[Decimal] = mapped_column(Numeric(10, 2), default=0)
    tax_amount: Mapped[Decimal] = mapped_column(Numeric(10, 2), default=0)
    total: Mapped[Decimal] = mapped_column(Numeric(10, 2), nullable=False)
    currency: Mapped[str] = mapped_column(String(3), default="USD")

    # Promotions
    coupon_code: Mapped[str | None] = mapped_column(String(50))
    promotion_details: Mapped[dict | None] = mapped_column(JSONB)

    # Shipping
    shipping_method: Mapped[str | None] = mapped_column(String(100))
    shipping_carrier: Mapped[str | None] = mapped_column(String(50))
    tracking_number: Mapped[str | None] = mapped_column(String(100))
    estimated_delivery_date: Mapped[date | None] = mapped_column(Date)
    shipped_at: Mapped[datetime | None] = mapped_column(DateTime(timezone=True))
    delivered_at: Mapped[datetime | None] = mapped_column(DateTime(timezone=True))

    # Notes
    customer_notes: Mapped[str | None] = mapped_column(Text)
    internal_notes: Mapped[str | None] = mapped_column(Text)

    # Timestamps
    placed_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True), default=datetime.utcnow
    )
    confirmed_at: Mapped[datetime | None] = mapped_column(DateTime(timezone=True))
    cancelled_at: Mapped[datetime | None] = mapped_column(DateTime(timezone=True))
    completed_at: Mapped[datetime | None] = mapped_column(DateTime(timezone=True))

    created_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True), default=datetime.utcnow
    )
    updated_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True), default=datetime.utcnow, onupdate=datetime.utcnow
    )

    # Relationships
    items: Mapped[list[OrderItem]] = relationship(
        back_populates="order", cascade="all, delete-orphan"
    )
    payments: Mapped[list[Payment]] = relationship(
        back_populates="order", cascade="all, delete-orphan"
    )
    refunds: Mapped[list[Refund]] = relationship(
        back_populates="order", cascade="all, delete-orphan"
    )
    user: Mapped[User | None] = relationship("User")


class OrderItem(Base):
    __tablename__ = "order_items"

    id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True), primary_key=True, default=uuid.uuid4
    )
    order_id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True), ForeignKey("orders.id", ondelete="CASCADE"), nullable=False
    )
    product_id: Mapped[uuid.UUID | None] = mapped_column(
        UUID(as_uuid=True), ForeignKey("products.id", ondelete="SET NULL")
    )
    variant_id: Mapped[uuid.UUID | None] = mapped_column(
        UUID(as_uuid=True), ForeignKey("product_variants.id", ondelete="SET NULL")
    )

    product_snapshot: Mapped[dict] = mapped_column(JSONB, nullable=False)

    quantity: Mapped[int] = mapped_column(Integer, nullable=False)
    unit_price: Mapped[Decimal] = mapped_column(Numeric(10, 2), nullable=False)
    discount_amount: Mapped[Decimal] = mapped_column(Numeric(10, 2), default=0)
    tax_amount: Mapped[Decimal] = mapped_column(Numeric(10, 2), default=0)
    total: Mapped[Decimal] = mapped_column(Numeric(10, 2), nullable=False)

    fulfilled_quantity: Mapped[int] = mapped_column(Integer, default=0)

    created_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True), default=datetime.utcnow
    )

    __table_args__ = (
        CheckConstraint("quantity > 0", name="order_items_quantity_check"),
    )

    # Relationships
    order: Mapped[Order] = relationship(back_populates="items")
    product: Mapped[Product | None] = relationship("Product")
    variant: Mapped[ProductVariant | None] = relationship("ProductVariant")


class Payment(Base):
    __tablename__ = "payments"

    id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True), primary_key=True, default=uuid.uuid4
    )
    order_id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True), ForeignKey("orders.id", ondelete="CASCADE"), nullable=False
    )

    payment_method: Mapped[PaymentMethod] = mapped_column(
        Enum(PaymentMethod, name="payment_method", create_type=False), nullable=False
    )
    status: Mapped[PaymentStatus] = mapped_column(
        Enum(PaymentStatus, name="payment_status", create_type=False),
        default=PaymentStatus.pending,
    )

    amount: Mapped[Decimal] = mapped_column(Numeric(10, 2), nullable=False)
    currency: Mapped[str] = mapped_column(String(3), default="USD")

    payment_provider: Mapped[str | None] = mapped_column(String(50))
    provider_transaction_id: Mapped[str | None] = mapped_column(String(255))
    provider_response: Mapped[dict | None] = mapped_column(JSONB)

    card_last_four: Mapped[str | None] = mapped_column(String(4))
    card_brand: Mapped[str | None] = mapped_column(String(20))

    authorized_at: Mapped[datetime | None] = mapped_column(DateTime(timezone=True))
    captured_at: Mapped[datetime | None] = mapped_column(DateTime(timezone=True))
    failed_at: Mapped[datetime | None] = mapped_column(DateTime(timezone=True))
    refunded_at: Mapped[datetime | None] = mapped_column(DateTime(timezone=True))

    failure_reason: Mapped[str | None] = mapped_column(Text)

    created_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True), default=datetime.utcnow
    )
    updated_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True), default=datetime.utcnow, onupdate=datetime.utcnow
    )

    # Relationships
    order: Mapped[Order] = relationship(back_populates="payments")
    refunds: Mapped[list[Refund]] = relationship(back_populates="payment")


class Refund(Base):
    __tablename__ = "refunds"

    id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True), primary_key=True, default=uuid.uuid4
    )
    order_id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True), ForeignKey("orders.id", ondelete="CASCADE"), nullable=False
    )
    payment_id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True), ForeignKey("payments.id", ondelete="CASCADE"), nullable=False
    )

    amount: Mapped[Decimal] = mapped_column(Numeric(10, 2), nullable=False)
    reason: Mapped[str | None] = mapped_column(Text)
    provider_refund_id: Mapped[str | None] = mapped_column(String(255))

    processed_at: Mapped[datetime | None] = mapped_column(DateTime(timezone=True))
    created_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True), default=datetime.utcnow
    )

    # Relationships
    order: Mapped[Order] = relationship(back_populates="refunds")
    payment: Mapped[Payment] = relationship(back_populates="refunds")
