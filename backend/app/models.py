"""
Central model registry — import all models here so SQLAlchemy relationships resolve.
Import this module wherever you need all models loaded (e.g., Alembic env, app startup).
"""

from app.core.database import Base  # noqa: F401

# Import order matters for relationship resolution
from app.users.models import User, UserAuthProvider, Address  # noqa: F401
from app.categories.models import Category, ProductType  # noqa: F401
from app.products.models import (  # noqa: F401
    Product,
    ProductImage,
    ProductVariant,
    ProductRelation,
)
from app.cart.models import Cart, CartItem  # noqa: F401
from app.wishlist.models import Wishlist, WishlistItem  # noqa: F401
from app.orders.models import Order, OrderItem, Payment, Refund  # noqa: F401
from app.reviews.models import Review, ReviewImage  # noqa: F401
from app.coupons.models import Promotion, Coupon, CouponUsage  # noqa: F401
from app.admin.models import (  # noqa: F401
    AttributeTemplate,
    ShippingMethod,
    NavigationMenu,
    Page,
)
