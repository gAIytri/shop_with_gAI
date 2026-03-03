# GaiEcom Database Schema Documentation

## Overview

This document describes the PostgreSQL database schema for GaiEcom, a home decor e-commerce platform.

**Version:** 1.1.0
**Database:** Azure Database for PostgreSQL (Flexible Server) / PostgreSQL 14+
**Standards:** Aligned with [schema.org](https://schema.org) Product vocabulary

---

## Table of Contents

1. [Architecture Overview](#architecture-overview)
2. [Entity Relationship Diagram](#entity-relationship-diagram)
3. [Core Modules](#core-modules)
   - [User Management](#1-user-management)
   - [Product Catalog](#2-product-catalog)
   - [Shopping Cart & Wishlist](#3-shopping-cart--wishlist)
   - [Orders & Payments](#4-orders--payments)
   - [Reviews & Ratings](#5-reviews--ratings)
   - [Promotions & Coupons](#6-promotions--coupons)
   - [Navigation & Content](#7-navigation--content)
4. [Data Migration from JSON](#data-migration-from-json)
5. [Indexes & Performance](#indexes--performance)
6. [Common Queries](#common-queries)

---

## Architecture Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                         GaiEcom Database                        │
│                  Azure PostgreSQL Flexible Server               │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐          │
│  │    Users     │  │   Products   │  │    Orders    │          │
│  │  Management  │  │   Catalog    │  │   Payments   │          │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘          │
│         │                 │                 │                   │
│         └────────┬────────┴────────┬────────┘                   │
│                  │                 │                            │
│         ┌────────▼────────┐  ┌─────▼─────┐                     │
│         │   Cart/Wishlist │  │  Reviews  │                     │
│         └────────┬────────┘  └───────────┘                     │
│                  │                                              │
│         ┌────────▼────────────────────────┐                    │
│         │     Promotions & Navigation     │                    │
│         └─────────────────────────────────┘                    │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## Entity Relationship Diagram

```
                                    ┌────────────────┐
                                    │     users      │
                                    ├────────────────┤
                            ┌───────│ id (PK)        │───────┐
                            │       │ email          │       │
                            │       │ first_name     │       │
                            │       │ preferences    │       │
                            │       └────────────────┘       │
                            │                │               │
                ┌───────────┼────────────────┼───────────────┼───────────┐
                │           │                │               │           │
                ▼           ▼                ▼               ▼           ▼
        ┌───────────┐ ┌───────────┐   ┌───────────┐   ┌───────────┐ ┌───────────┐
        │ addresses │ │  carts    │   │ wishlists │   │  orders   │ │  reviews  │
        └───────────┘ └─────┬─────┘   └─────┬─────┘   └─────┬─────┘ └───────────┘
                            │               │               │
                            ▼               ▼               ▼
                      ┌───────────┐   ┌───────────┐   ┌───────────┐
                      │cart_items │   │ wishlist_ │   │order_items│
                      └─────┬─────┘   │   items   │   └─────┬─────┘
                            │         └─────┬─────┘         │
                            └───────────────┼───────────────┘
                                            │
                                            ▼
                                    ┌───────────────┐
                                    │   products    │
                                    ├───────────────┤
                                    │ id (PK)       │
                                    │ sku           │
                                    │ name          │
                                    │ attributes    │←─── JSONB (colors, materials, styles)
                                    │ enriched_desc │←─── JSONB (from Azure OpenAI)
                                    │ tags          │←─── JSONB (for search)
                                    └───────┬───────┘
                                            │
                        ┌───────────────────┼───────────────────┐
                        │                   │                   │
                        ▼                   ▼                   ▼
                ┌───────────────┐   ┌───────────────┐   ┌───────────────┐
                │  categories   │   │ product_types │   │product_images │
                └───────────────┘   └───────────────┘   └───────────────┘
```

---

## Core Modules

### 1. User Management

#### Tables

| Table | Description |
|-------|-------------|
| `users` | Core user accounts with profile and preferences |
| `user_auth_providers` | OAuth/social login providers (Google, Facebook, Apple) |
| `addresses` | Shipping and billing addresses |

#### Key Fields in `users`

```sql
-- Profile
first_name, last_name, email, phone, avatar_url

-- Preferences (for personalization)
preferred_styles     JSONB  -- ["Modern", "Minimalist"]
preferred_rooms      JSONB  -- ["Living Room", "Bedroom"]
preferred_colors     JSONB  -- ["Blue", "White"]
price_range_min/max  DECIMAL

-- Status
role                 ENUM   -- customer, admin, support, guest
status               ENUM   -- active, inactive, suspended
```

#### schema.org Alignment

| schema.org | Database Field |
|------------|----------------|
| `Person.givenName` | `first_name` |
| `Person.familyName` | `last_name` |
| `Person.email` | `email` |
| `Person.telephone` | `phone` |
| `PostalAddress.*` | `addresses` table |

---

### 2. Product Catalog

#### Tables

| Table | Description |
|-------|-------------|
| `categories` | Top-level categories (Lighting, Decor, Art, etc.) |
| `product_types` | Subcategories (Ceiling Light, Floor Lamp, etc.) |
| `products` | Main product table with all attributes |
| `product_images` | Product image gallery |
| `product_variants` | Size/color variants with separate stock |
| `product_relations` | Cross-sell, up-sell relationships |

#### Product Structure

```sql
-- Basic Info
id, sku, name, description

-- Taxonomy
category_id      → categories(id)
product_type_id  → product_types(id)

-- Pricing
price            DECIMAL(10,2)
compare_at_price DECIMAL(10,2)  -- Original price if on sale
currency         VARCHAR(3)     -- USD

-- Inventory
stock_quantity      INTEGER
stock_status        ENUM        -- in_stock, low_stock, out_of_stock
track_inventory     BOOLEAN

-- Attributes (JSONB - flexible)
attributes JSONB
{
    "color": ["Warm Brass", "Frosted White"],
    "material": ["Glass", "Brass"],
    "style": ["Modern", "Contemporary"],
    "room": ["Living Room", "Dining Room"],
    "dimensions": {"width": 24, "height": 36, "unit": "inches"}
}

-- Visual Attributes (from enrichment)
visual_attributes JSONB
{
    "primaryColors": [{"name": "Warm Brass", "hex": "#B8860B"}],
    "pattern": "solid",
    "texture": "smooth",
    "finish": "matte"
}

-- Enriched Descriptions (from Azure OpenAI)
enriched_description JSONB
{
    "short": "Chic globe pendant light...",
    "long": "Illuminate your home...",
    "features": ["Sleek frosted glass globes", ...],
    "careInstructions": "Wipe with a soft, dry cloth...",
    "materialComposition": "Constructed with frosted glass..."
}

-- Tags (for search)
tags JSONB  -- ["pendant", "modern", "brass", "globe"]

-- SEO
seo JSONB
{
    "metaTitle": "...",
    "metaDescription": "...",
    "altText": "...",
    "keywords": [...]
}
```

#### schema.org Alignment

| schema.org | Database Field |
|------------|----------------|
| `Product.name` | `name` |
| `Product.description` | `description`, `enriched_description` |
| `Product.sku` | `sku` |
| `Product.image` | `product_images` table |
| `Product.category` | `categories` table |
| `Offer.price` | `price` |
| `Offer.priceCurrency` | `currency` |
| `Offer.availability` | `stock_status` |
| `AggregateRating.ratingValue` | `avg_rating` |
| `AggregateRating.reviewCount` | `review_count` |

---

### 3. Shopping Cart & Wishlist

#### Tables

| Table | Description |
|-------|-------------|
| `carts` | Shopping cart with totals |
| `cart_items` | Items in cart |
| `wishlists` | User wishlists |
| `wishlist_items` | Items in wishlist |

#### Cart Features

- **Guest carts**: Uses `session_id` for unauthenticated users
- **Auto-calculated totals**: Triggers update `subtotal`, `item_count`, `total`
- **Expiration**: `expires_at` for abandoned cart cleanup
- **Coupon support**: `coupon_code` field

---

### 4. Orders & Payments

#### Tables

| Table | Description |
|-------|-------------|
| `orders` | Order header with addresses, totals, status |
| `order_items` | Line items with product snapshots |
| `payments` | Payment transactions |
| `refunds` | Refund records |

#### Order Flow

```
pending → confirmed → processing → shipped → delivered
                  ↓
              cancelled → refunded
```

#### Product Snapshot

Order items store a `product_snapshot` JSONB to preserve product info even if the product changes or is deleted:

```json
{
    "sku": "LGT-CL-001",
    "name": "Modern Globe Pendant",
    "image_url": "...",
    "variant": {"size": "Large", "color": "Brass"}
}
```

---

### 5. Reviews & Ratings

#### Tables

| Table | Description |
|-------|-------------|
| `reviews` | Product reviews with ratings |
| `review_images` | Images attached to reviews |

#### Features

- **Verified purchase**: `is_verified_purchase` links to order
- **Helpful votes**: `helpful_count`, `not_helpful_count`
- **Moderation**: `is_approved` for admin review
- **Store response**: `store_response` field
- **Auto-stats**: Trigger updates `products.avg_rating` and `review_count`

---

### 6. Promotions & Coupons

#### Tables

| Table | Description |
|-------|-------------|
| `promotions` | Discount rules and conditions |
| `coupons` | Coupon codes linked to promotions |
| `coupon_usages` | Tracking coupon usage per user/order |

#### Discount Types

```sql
CREATE TYPE discount_type AS ENUM (
    'percentage',      -- 20% off
    'fixed_amount',    -- $10 off
    'free_shipping',
    'buy_x_get_y'      -- Buy 2 get 1 free
);
```

---

### 7. Navigation & Content

#### Tables

| Table | Description |
|-------|-------------|
| `navigation_menus` | Mega menu structure (from navigationData.json) |
| `pages` | Static CMS pages |

---

## Data Migration from JSON

### Migrating Products

```sql
-- Example: Insert product from your JSON structure
INSERT INTO products (
    id, sku, name, description, price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, avg_rating, review_count
)
SELECT
    uuid_generate_v4(),
    j->>'sku',
    j->>'name',
    j->>'description',
    (j->>'price')::decimal,
    COALESCE(j->>'currency', 'USD'),
    (SELECT id FROM categories WHERE slug = j->'taxonomy'->'category'->>'slug'),
    (SELECT id FROM product_types WHERE slug = j->'taxonomy'->'subcategory'->>'slug'),
    (j->'metadata'->>'stockQuantity')::int,
    CASE WHEN (j->'metadata'->>'inStock')::boolean THEN 'in_stock' ELSE 'out_of_stock' END,
    j->'attributes',
    j->'visualAttributes',
    j->'enrichedDescription',
    j->'tags',
    j->'seo',
    (j->'metadata'->>'featured')::boolean,
    (j->'metadata'->>'rating')::decimal,
    (j->'metadata'->>'reviewCount')::int
FROM jsonb_array_elements(:'json_data') AS j;
```

### Migrating Categories

```sql
INSERT INTO categories (name, slug, synonyms) VALUES
    ('Lighting', 'lighting', '["lights", "lamps", "fixtures"]'),
    ('Decor', 'decor', '["decorations", "accessories", "accents"]'),
    ('Art & Mirrors', 'art', '["artwork", "wall art", "mirrors"]'),
    ('Bedding', 'bedding', '["bed linens", "sheets", "comforters"]'),
    ('Furniture', 'furniture', '["furnishings"]'),
    ('Rugs', 'rugs', '["carpets", "floor coverings", "area rugs"]');
```

---

## Indexes & Performance

### Key Indexes

| Index | Purpose |
|-------|---------|
| `idx_products_name_trgm` | Fuzzy text search on product names |
| `idx_products_tags` | GIN index for tag filtering |
| `idx_products_attributes` | GIN index for attribute filtering |
| `idx_products_category` | Fast category filtering |
| `idx_products_price` | Price range queries |
| `idx_orders_user` | User order history |

### Performance Tips

1. **Use views for common queries**: `v_product_search`, `v_products_with_category`
2. **JSONB operators**: Use `@>`, `?`, `?|` for efficient JSON queries
3. **Partial indexes**: `WHERE is_active = TRUE` reduces index size
4. **Connection pooling**: Use PgBouncer for production

---

## Common Queries

### Product Search

```sql
-- Search by multiple criteria
SELECT * FROM v_product_search
WHERE
    -- Category filter
    category_slug = 'lighting'
    -- Style filter (JSONB contains)
    AND styles @> '"Modern"'
    -- Room filter
    AND rooms @> '"Living Room"'
    -- Price range
    AND price BETWEEN 50 AND 200
    -- Text search (fuzzy)
    AND name ILIKE '%pendant%'
ORDER BY avg_rating DESC, review_count DESC
LIMIT 20;
```

### Get User with Preferences

```sql
SELECT
    u.*,
    COALESCE(
        (SELECT json_agg(a.*) FROM addresses a WHERE a.user_id = u.id),
        '[]'
    ) as addresses
FROM users u
WHERE u.id = $1;
```

### Order History

```sql
SELECT
    o.*,
    json_agg(json_build_object(
        'product', oi.product_snapshot,
        'quantity', oi.quantity,
        'total', oi.total
    )) as items
FROM orders o
JOIN order_items oi ON o.id = oi.order_id
WHERE o.user_id = $1
GROUP BY o.id
ORDER BY o.placed_at DESC;
```

---

## Extensions Required

```sql
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";   -- UUID generation
CREATE EXTENSION IF NOT EXISTS "pgcrypto";    -- Password hashing
CREATE EXTENSION IF NOT EXISTS "pg_trgm";     -- Fuzzy text search
```

---

## Table Summary

| Module | Tables |
|--------|--------|
| User Management | `users`, `user_auth_providers`, `addresses` |
| Product Catalog | `categories`, `product_types`, `products`, `product_images`, `product_variants`, `product_relations` |
| Cart & Wishlist | `carts`, `cart_items`, `wishlists`, `wishlist_items` |
| Orders | `orders`, `order_items`, `payments`, `refunds` |
| Reviews | `reviews`, `review_images` |
| Promotions | `promotions`, `coupons`, `coupon_usages` |
| Navigation | `navigation_menus`, `pages` |

**Total Tables:** 21

---

## Archived Components

NLU (Natural Language Understanding) components have been archived for future integration. See `archive/nlu/` folder for:
- NLU schema (intents, entities, conversation tracking)
- Seed data for intents and entities
- Documentation for NLU integration

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2024-01-22 | Initial schema |
| 1.1.0 | 2026-01-29 | Removed NLU tables (archived), optimized for Azure PostgreSQL |

---

## References

- [schema.org Product](https://schema.org/Product)
- [schema.org Offer](https://schema.org/Offer)
- [PostgreSQL JSONB](https://www.postgresql.org/docs/current/datatype-json.html)
- [pg_trgm for fuzzy search](https://www.postgresql.org/docs/current/pgtrgm.html)
- [Azure Database for PostgreSQL](https://learn.microsoft.com/en-us/azure/postgresql/)
