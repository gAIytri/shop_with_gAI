-- ============================================================================
-- GaiEcom PostgreSQL Database Schema
-- Version: 1.1.0
-- Aligned with: schema.org Product vocabulary, e-commerce best practices
-- Purpose: E-commerce platform for home decor products
-- Target: Azure Database for PostgreSQL (Flexible Server)
-- ============================================================================

-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";  -- For fuzzy text search

-- ============================================================================
-- SECTION 1: CORE ENUMS
-- ============================================================================

CREATE TYPE user_role AS ENUM ('customer', 'admin', 'support', 'guest');
CREATE TYPE user_status AS ENUM ('active', 'inactive', 'suspended', 'pending_verification');
CREATE TYPE order_status AS ENUM ('pending', 'confirmed', 'processing', 'shipped', 'delivered', 'cancelled', 'refunded', 'returned');
CREATE TYPE payment_status AS ENUM ('pending', 'authorized', 'captured', 'failed', 'refunded', 'partially_refunded');
CREATE TYPE payment_method AS ENUM ('credit_card', 'debit_card', 'paypal', 'apple_pay', 'google_pay', 'bank_transfer', 'cod');
CREATE TYPE address_type AS ENUM ('shipping', 'billing', 'both');
CREATE TYPE stock_status AS ENUM ('in_stock', 'low_stock', 'out_of_stock', 'pre_order', 'discontinued');
CREATE TYPE discount_type AS ENUM ('percentage', 'fixed_amount', 'free_shipping', 'buy_x_get_y');

-- ============================================================================
-- SECTION 2: USER MANAGEMENT
-- ============================================================================

-- Users table (aligns with schema.org Person)
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255),  -- NULL for social auth users

    -- Profile (schema.org: givenName, familyName)
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    display_name VARCHAR(200),
    phone VARCHAR(20),
    avatar_url TEXT,

    -- Account settings
    role user_role DEFAULT 'customer',
    status user_status DEFAULT 'pending_verification',
    email_verified BOOLEAN DEFAULT FALSE,
    phone_verified BOOLEAN DEFAULT FALSE,

    -- Preferences (for personalization)
    preferred_styles JSONB DEFAULT '[]',     -- ["Modern", "Minimalist"]
    preferred_rooms JSONB DEFAULT '[]',      -- ["Living Room", "Bedroom"]
    preferred_colors JSONB DEFAULT '[]',     -- ["Blue", "White"]
    price_range_min DECIMAL(10,2),
    price_range_max DECIMAL(10,2),

    -- Marketing
    newsletter_subscribed BOOLEAN DEFAULT FALSE,
    marketing_consent BOOLEAN DEFAULT FALSE,

    -- Auth tracking
    last_login_at TIMESTAMPTZ,
    login_count INTEGER DEFAULT 0,
    failed_login_attempts INTEGER DEFAULT 0,
    locked_until TIMESTAMPTZ,

    -- Timestamps
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    deleted_at TIMESTAMPTZ  -- Soft delete
);

-- Social auth providers (OAuth)
CREATE TABLE user_auth_providers (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    provider VARCHAR(50) NOT NULL,  -- 'google', 'facebook', 'apple'
    provider_user_id VARCHAR(255) NOT NULL,
    access_token TEXT,
    refresh_token TEXT,
    token_expires_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW(),

    UNIQUE(provider, provider_user_id)
);

-- User addresses (schema.org: PostalAddress)
CREATE TABLE addresses (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,

    -- Address details
    address_type address_type DEFAULT 'both',
    is_default BOOLEAN DEFAULT FALSE,
    label VARCHAR(50),  -- "Home", "Office", etc.

    -- schema.org: PostalAddress properties
    street_address VARCHAR(255) NOT NULL,
    address_line_2 VARCHAR(255),
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    country VARCHAR(2) NOT NULL DEFAULT 'US',  -- ISO 3166-1 alpha-2

    -- Contact for this address
    recipient_name VARCHAR(200),
    recipient_phone VARCHAR(20),

    -- Delivery instructions
    delivery_instructions TEXT,

    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================================
-- SECTION 3: PRODUCT CATALOG (schema.org aligned)
-- ============================================================================

-- Categories (schema.org: CategoryCode)
CREATE TABLE categories (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    parent_id UUID REFERENCES categories(id) ON DELETE SET NULL,

    name VARCHAR(100) NOT NULL,
    slug VARCHAR(100) UNIQUE NOT NULL,
    description TEXT,

    -- Display
    image_url TEXT,
    icon VARCHAR(50),
    display_order INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,

    -- SEO
    meta_title VARCHAR(200),
    meta_description VARCHAR(500),

    -- Synonyms for search matching
    synonyms JSONB DEFAULT '[]',  -- ["couches", "sofas", "settees"]

    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Subcategories / Product Types
CREATE TABLE product_types (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    category_id UUID NOT NULL REFERENCES categories(id) ON DELETE CASCADE,

    name VARCHAR(100) NOT NULL,
    slug VARCHAR(100) NOT NULL,
    description TEXT,

    -- Synonyms for search matching
    synonyms JSONB DEFAULT '[]',

    created_at TIMESTAMPTZ DEFAULT NOW(),

    UNIQUE(category_id, slug)
);

-- Products table (schema.org: Product)
CREATE TABLE products (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    sku VARCHAR(50) UNIQUE NOT NULL,

    -- Basic info (schema.org: name, description)
    name VARCHAR(255) NOT NULL,
    description TEXT,

    -- Taxonomy
    category_id UUID NOT NULL REFERENCES categories(id),
    product_type_id UUID REFERENCES product_types(id),

    -- Pricing (schema.org: Offer)
    price DECIMAL(10,2) NOT NULL,
    compare_at_price DECIMAL(10,2),  -- Original price if on sale
    cost_price DECIMAL(10,2),  -- For profit calculation
    currency VARCHAR(3) DEFAULT 'USD',

    -- Inventory
    stock_quantity INTEGER DEFAULT 0,
    stock_status stock_status DEFAULT 'in_stock',
    low_stock_threshold INTEGER DEFAULT 5,
    track_inventory BOOLEAN DEFAULT TRUE,

    -- Product attributes (from your existing structure)
    attributes JSONB DEFAULT '{}',
    /*
    {
        "color": ["Warm Brass", "Frosted White"],
        "material": ["Glass", "Brass"],
        "style": ["Modern", "Contemporary"],
        "room": ["Living Room", "Dining Room"],
        "occasion": ["Everyday", "Entertaining"],
        "dimensions": {"width": 24, "height": 36, "depth": 12, "unit": "inches"},
        "weight": {"value": 5.5, "unit": "lbs"}
    }
    */

    -- Visual attributes (from enrichment)
    visual_attributes JSONB DEFAULT '{}',
    /*
    {
        "primaryColors": [{"name": "Warm Brass", "hex": "#B8860B", "category": "primary"}],
        "pattern": "solid",
        "texture": "smooth",
        "finish": "matte",
        "shape": "organic",
        "silhouette": "Cluster of globes"
    }
    */

    -- Enriched content (from Azure OpenAI)
    enriched_description JSONB DEFAULT '{}',
    /*
    {
        "short": "...",
        "long": "...",
        "features": [],
        "careInstructions": "...",
        "materialComposition": "..."
    }
    */

    -- Tags for search/filter
    tags JSONB DEFAULT '[]',

    -- SEO (schema.org aligned)
    seo JSONB DEFAULT '{}',
    /*
    {
        "metaTitle": "...",
        "metaDescription": "...",
        "altText": "...",
        "keywords": []
    }
    */

    -- Metadata
    is_active BOOLEAN DEFAULT TRUE,
    is_featured BOOLEAN DEFAULT FALSE,
    is_bestseller BOOLEAN DEFAULT FALSE,
    is_new BOOLEAN DEFAULT FALSE,

    -- Reviews (denormalized for performance)
    avg_rating DECIMAL(2,1) DEFAULT 0,
    review_count INTEGER DEFAULT 0,

    -- Timestamps
    published_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    deleted_at TIMESTAMPTZ
);

-- Product images
CREATE TABLE product_images (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,

    url TEXT NOT NULL,
    alt_text VARCHAR(255),
    is_primary BOOLEAN DEFAULT FALSE,
    display_order INTEGER DEFAULT 0,

    -- Image metadata
    width INTEGER,
    height INTEGER,
    file_size INTEGER,

    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Product variants (size, color combinations)
CREATE TABLE product_variants (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    sku VARCHAR(50) UNIQUE NOT NULL,

    -- Variant attributes
    variant_options JSONB NOT NULL,  -- {"size": "Queen", "color": "Blue"}

    -- Override pricing
    price DECIMAL(10,2),
    compare_at_price DECIMAL(10,2),

    -- Individual stock
    stock_quantity INTEGER DEFAULT 0,
    stock_status stock_status DEFAULT 'in_stock',

    -- Image specific to variant
    image_url TEXT,

    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Related products (cross-sell, up-sell)
CREATE TABLE product_relations (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    related_product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    relation_type VARCHAR(50) NOT NULL,  -- 'similar', 'complementary', 'upsell', 'cross_sell'
    display_order INTEGER DEFAULT 0,

    UNIQUE(product_id, related_product_id, relation_type)
);

-- ============================================================================
-- SECTION 4: SHOPPING CART & WISHLIST
-- ============================================================================

-- Shopping carts
CREATE TABLE carts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id) ON DELETE SET NULL,
    session_id VARCHAR(255),  -- For guest carts

    -- Totals (denormalized)
    subtotal DECIMAL(10,2) DEFAULT 0,
    discount_amount DECIMAL(10,2) DEFAULT 0,
    tax_amount DECIMAL(10,2) DEFAULT 0,
    shipping_estimate DECIMAL(10,2),
    total DECIMAL(10,2) DEFAULT 0,

    -- Applied promotions
    coupon_code VARCHAR(50),

    -- Cart metadata
    item_count INTEGER DEFAULT 0,
    currency VARCHAR(3) DEFAULT 'USD',

    expires_at TIMESTAMPTZ,  -- For abandoned cart cleanup
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Cart items
CREATE TABLE cart_items (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    cart_id UUID NOT NULL REFERENCES carts(id) ON DELETE CASCADE,
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    variant_id UUID REFERENCES product_variants(id) ON DELETE CASCADE,

    quantity INTEGER NOT NULL DEFAULT 1 CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL,

    -- Saved customization
    customization JSONB,  -- {"gift_wrap": true, "message": "Happy Birthday!"}

    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),

    UNIQUE(cart_id, product_id, variant_id)
);

-- Wishlists
CREATE TABLE wishlists (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,

    name VARCHAR(100) DEFAULT 'My Wishlist',
    is_default BOOLEAN DEFAULT TRUE,
    is_public BOOLEAN DEFAULT FALSE,

    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Wishlist items
CREATE TABLE wishlist_items (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    wishlist_id UUID NOT NULL REFERENCES wishlists(id) ON DELETE CASCADE,
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    variant_id UUID REFERENCES product_variants(id) ON DELETE CASCADE,

    -- Price tracking
    added_at_price DECIMAL(10,2),

    notes TEXT,
    priority INTEGER DEFAULT 0,

    created_at TIMESTAMPTZ DEFAULT NOW(),

    UNIQUE(wishlist_id, product_id, variant_id)
);

-- ============================================================================
-- SECTION 5: ORDERS & PAYMENTS
-- ============================================================================

-- Orders (schema.org: Order)
CREATE TABLE orders (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_number VARCHAR(50) UNIQUE NOT NULL,  -- Human readable: GAI-2024-001234
    user_id UUID REFERENCES users(id) ON DELETE SET NULL,

    -- Status
    status order_status DEFAULT 'pending',

    -- Addresses (snapshot at time of order)
    shipping_address JSONB NOT NULL,
    billing_address JSONB NOT NULL,

    -- Contact
    customer_email VARCHAR(255) NOT NULL,
    customer_phone VARCHAR(20),
    customer_name VARCHAR(200),

    -- Financials
    subtotal DECIMAL(10,2) NOT NULL,
    discount_amount DECIMAL(10,2) DEFAULT 0,
    shipping_amount DECIMAL(10,2) DEFAULT 0,
    tax_amount DECIMAL(10,2) DEFAULT 0,
    total DECIMAL(10,2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'USD',

    -- Promotions
    coupon_code VARCHAR(50),
    promotion_details JSONB,

    -- Shipping
    shipping_method VARCHAR(100),
    shipping_carrier VARCHAR(50),
    tracking_number VARCHAR(100),
    estimated_delivery_date DATE,
    shipped_at TIMESTAMPTZ,
    delivered_at TIMESTAMPTZ,

    -- Notes
    customer_notes TEXT,
    internal_notes TEXT,

    -- Timestamps
    placed_at TIMESTAMPTZ DEFAULT NOW(),
    confirmed_at TIMESTAMPTZ,
    cancelled_at TIMESTAMPTZ,
    completed_at TIMESTAMPTZ,

    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Order items (schema.org: OrderItem)
CREATE TABLE order_items (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_id UUID NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    product_id UUID REFERENCES products(id) ON DELETE SET NULL,
    variant_id UUID REFERENCES product_variants(id) ON DELETE SET NULL,

    -- Product snapshot (in case product changes/deletes)
    product_snapshot JSONB NOT NULL,
    /*
    {
        "sku": "LGT-CL-001",
        "name": "Modern Globe Pendant",
        "image_url": "...",
        "variant": {"size": "Large", "color": "Brass"}
    }
    */

    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL,
    discount_amount DECIMAL(10,2) DEFAULT 0,
    tax_amount DECIMAL(10,2) DEFAULT 0,
    total DECIMAL(10,2) NOT NULL,

    -- Fulfillment
    fulfilled_quantity INTEGER DEFAULT 0,

    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Payments
CREATE TABLE payments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_id UUID NOT NULL REFERENCES orders(id) ON DELETE CASCADE,

    -- Payment details
    payment_method payment_method NOT NULL,
    status payment_status DEFAULT 'pending',

    amount DECIMAL(10,2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'USD',

    -- Provider details
    payment_provider VARCHAR(50),  -- 'stripe', 'paypal', etc.
    provider_transaction_id VARCHAR(255),
    provider_response JSONB,

    -- Card info (masked)
    card_last_four VARCHAR(4),
    card_brand VARCHAR(20),

    -- Timestamps
    authorized_at TIMESTAMPTZ,
    captured_at TIMESTAMPTZ,
    failed_at TIMESTAMPTZ,
    refunded_at TIMESTAMPTZ,

    failure_reason TEXT,

    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Refunds
CREATE TABLE refunds (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_id UUID NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    payment_id UUID NOT NULL REFERENCES payments(id) ON DELETE CASCADE,

    amount DECIMAL(10,2) NOT NULL,
    reason TEXT,

    provider_refund_id VARCHAR(255),

    processed_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================================
-- SECTION 6: REVIEWS & RATINGS
-- ============================================================================

CREATE TABLE reviews (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    user_id UUID REFERENCES users(id) ON DELETE SET NULL,
    order_id UUID REFERENCES orders(id) ON DELETE SET NULL,

    rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    title VARCHAR(255),
    content TEXT,

    -- Review metadata
    is_verified_purchase BOOLEAN DEFAULT FALSE,
    is_recommended BOOLEAN,

    -- Helpful votes
    helpful_count INTEGER DEFAULT 0,
    not_helpful_count INTEGER DEFAULT 0,

    -- Moderation
    is_approved BOOLEAN DEFAULT FALSE,
    is_featured BOOLEAN DEFAULT FALSE,
    moderated_at TIMESTAMPTZ,

    -- Response from store
    store_response TEXT,
    store_responded_at TIMESTAMPTZ,

    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Review images
CREATE TABLE review_images (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    review_id UUID NOT NULL REFERENCES reviews(id) ON DELETE CASCADE,
    url TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================================
-- SECTION 7: PROMOTIONS & COUPONS
-- ============================================================================

CREATE TABLE promotions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),

    name VARCHAR(255) NOT NULL,
    description TEXT,

    discount_type discount_type NOT NULL,
    discount_value DECIMAL(10,2) NOT NULL,  -- Percentage or fixed amount

    -- Conditions
    min_purchase_amount DECIMAL(10,2),
    max_discount_amount DECIMAL(10,2),
    min_quantity INTEGER,

    -- Applicability
    applies_to_all BOOLEAN DEFAULT TRUE,
    applicable_product_ids UUID[],
    applicable_category_ids UUID[],

    -- Usage limits
    max_uses INTEGER,
    max_uses_per_user INTEGER DEFAULT 1,
    current_uses INTEGER DEFAULT 0,

    -- Validity
    starts_at TIMESTAMPTZ NOT NULL,
    ends_at TIMESTAMPTZ,
    is_active BOOLEAN DEFAULT TRUE,

    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Coupons (codes for promotions)
CREATE TABLE coupons (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    promotion_id UUID NOT NULL REFERENCES promotions(id) ON DELETE CASCADE,

    code VARCHAR(50) UNIQUE NOT NULL,

    -- Override promotion limits for this code
    max_uses INTEGER,
    current_uses INTEGER DEFAULT 0,

    is_active BOOLEAN DEFAULT TRUE,

    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Coupon usage tracking
CREATE TABLE coupon_usages (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    coupon_id UUID NOT NULL REFERENCES coupons(id) ON DELETE CASCADE,
    user_id UUID REFERENCES users(id) ON DELETE SET NULL,
    order_id UUID REFERENCES orders(id) ON DELETE SET NULL,

    discount_applied DECIMAL(10,2) NOT NULL,

    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================================
-- SECTION 8: NAVIGATION & CONTENT
-- ============================================================================

-- Navigation menus (from your navigationData.json)
CREATE TABLE navigation_menus (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),

    title VARCHAR(100) NOT NULL,
    category_slug VARCHAR(100),
    position VARCHAR(50) DEFAULT 'header',  -- 'header', 'footer', 'sidebar'
    display_order INTEGER DEFAULT 0,

    -- Mega menu structure
    columns JSONB DEFAULT '[]',
    /*
    [
        {
            "title": "SHOP BY TYPE",
            "links": [
                {"label": "All Lighting", "path": "/category/lighting"}
            ]
        }
    ]
    */

    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Static pages / CMS
CREATE TABLE pages (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),

    slug VARCHAR(100) UNIQUE NOT NULL,
    title VARCHAR(255) NOT NULL,
    content TEXT,

    -- SEO
    meta_title VARCHAR(200),
    meta_description VARCHAR(500),

    is_published BOOLEAN DEFAULT FALSE,
    published_at TIMESTAMPTZ,

    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================================
-- SECTION 9: INDEXES
-- ============================================================================

-- Users
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_status ON users(status) WHERE deleted_at IS NULL;

-- Products
CREATE INDEX idx_products_sku ON products(sku);
CREATE INDEX idx_products_category ON products(category_id);
CREATE INDEX idx_products_type ON products(product_type_id);
CREATE INDEX idx_products_active ON products(is_active) WHERE deleted_at IS NULL;
CREATE INDEX idx_products_featured ON products(is_featured) WHERE is_active = TRUE;
CREATE INDEX idx_products_price ON products(price);
CREATE INDEX idx_products_rating ON products(avg_rating DESC);
CREATE INDEX idx_products_created ON products(created_at DESC);

-- Full-text search on products
CREATE INDEX idx_products_name_trgm ON products USING gin(name gin_trgm_ops);
CREATE INDEX idx_products_tags ON products USING gin(tags);
CREATE INDEX idx_products_attributes ON products USING gin(attributes);

-- Orders
CREATE INDEX idx_orders_user ON orders(user_id);
CREATE INDEX idx_orders_number ON orders(order_number);
CREATE INDEX idx_orders_status ON orders(status);
CREATE INDEX idx_orders_placed ON orders(placed_at DESC);

-- Cart
CREATE INDEX idx_carts_user ON carts(user_id);
CREATE INDEX idx_carts_session ON carts(session_id);
CREATE INDEX idx_cart_items_cart ON cart_items(cart_id);

-- Reviews
CREATE INDEX idx_reviews_product ON reviews(product_id);
CREATE INDEX idx_reviews_approved ON reviews(product_id, is_approved) WHERE is_approved = TRUE;

-- ============================================================================
-- SECTION 10: TRIGGERS
-- ============================================================================

-- Auto-update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Apply to all tables with updated_at
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_addresses_updated_at BEFORE UPDATE ON addresses
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_categories_updated_at BEFORE UPDATE ON categories
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_products_updated_at BEFORE UPDATE ON products
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_product_variants_updated_at BEFORE UPDATE ON product_variants
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_carts_updated_at BEFORE UPDATE ON carts
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_cart_items_updated_at BEFORE UPDATE ON cart_items
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_wishlists_updated_at BEFORE UPDATE ON wishlists
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_orders_updated_at BEFORE UPDATE ON orders
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_payments_updated_at BEFORE UPDATE ON payments
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_reviews_updated_at BEFORE UPDATE ON reviews
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_promotions_updated_at BEFORE UPDATE ON promotions
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_navigation_menus_updated_at BEFORE UPDATE ON navigation_menus
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_pages_updated_at BEFORE UPDATE ON pages
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Update product review stats when review is added/updated
CREATE OR REPLACE FUNCTION update_product_review_stats()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE products
    SET
        avg_rating = (
            SELECT ROUND(AVG(rating)::numeric, 1)
            FROM reviews
            WHERE product_id = COALESCE(NEW.product_id, OLD.product_id)
            AND is_approved = TRUE
        ),
        review_count = (
            SELECT COUNT(*)
            FROM reviews
            WHERE product_id = COALESCE(NEW.product_id, OLD.product_id)
            AND is_approved = TRUE
        )
    WHERE id = COALESCE(NEW.product_id, OLD.product_id);

    RETURN COALESCE(NEW, OLD);
END;
$$ language 'plpgsql';

CREATE TRIGGER update_product_stats_on_review
    AFTER INSERT OR UPDATE OR DELETE ON reviews
    FOR EACH ROW EXECUTE FUNCTION update_product_review_stats();

-- Update cart totals when items change
CREATE OR REPLACE FUNCTION update_cart_totals()
RETURNS TRIGGER AS $$
DECLARE
    cart_uuid UUID;
BEGIN
    cart_uuid := COALESCE(NEW.cart_id, OLD.cart_id);

    UPDATE carts
    SET
        item_count = (
            SELECT COALESCE(SUM(quantity), 0)
            FROM cart_items
            WHERE cart_id = cart_uuid
        ),
        subtotal = (
            SELECT COALESCE(SUM(quantity * unit_price), 0)
            FROM cart_items
            WHERE cart_id = cart_uuid
        )
    WHERE id = cart_uuid;

    -- Update total (subtotal - discount + tax + shipping)
    UPDATE carts
    SET total = subtotal - discount_amount + tax_amount + COALESCE(shipping_estimate, 0)
    WHERE id = cart_uuid;

    RETURN COALESCE(NEW, OLD);
END;
$$ language 'plpgsql';

CREATE TRIGGER update_cart_on_item_change
    AFTER INSERT OR UPDATE OR DELETE ON cart_items
    FOR EACH ROW EXECUTE FUNCTION update_cart_totals();

-- ============================================================================
-- SECTION 11: VIEWS
-- ============================================================================

-- Product view with category info (commonly used)
CREATE VIEW v_products_with_category AS
SELECT
    p.*,
    c.name as category_name,
    c.slug as category_slug,
    pt.name as product_type_name,
    pt.slug as product_type_slug
FROM products p
LEFT JOIN categories c ON p.category_id = c.id
LEFT JOIN product_types pt ON p.product_type_id = pt.id
WHERE p.deleted_at IS NULL AND p.is_active = TRUE;

-- Order summary view
CREATE VIEW v_order_summary AS
SELECT
    o.*,
    u.email as user_email,
    u.first_name || ' ' || u.last_name as user_name,
    COUNT(oi.id) as item_count,
    (SELECT status FROM payments WHERE order_id = o.id ORDER BY created_at DESC LIMIT 1) as payment_status
FROM orders o
LEFT JOIN users u ON o.user_id = u.id
LEFT JOIN order_items oi ON o.id = oi.order_id
GROUP BY o.id, u.email, u.first_name, u.last_name;

-- Product search view (optimized for search/filtering)
CREATE VIEW v_product_search AS
SELECT
    p.id,
    p.sku,
    p.name,
    p.description,
    p.price,
    p.attributes,
    p.tags,
    p.avg_rating,
    p.stock_status,
    c.name as category,
    c.slug as category_slug,
    pt.name as product_type,
    COALESCE(p.enriched_description->>'short', p.description) as short_description,
    p.visual_attributes->'primaryColors' as colors,
    p.attributes->'style' as styles,
    p.attributes->'room' as rooms,
    p.attributes->'material' as materials
FROM products p
LEFT JOIN categories c ON p.category_id = c.id
LEFT JOIN product_types pt ON p.product_type_id = pt.id
WHERE p.deleted_at IS NULL AND p.is_active = TRUE;

-- ============================================================================
-- END OF SCHEMA
-- ============================================================================
