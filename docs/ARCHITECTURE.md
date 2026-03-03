# Shop with gAI - Complete Architecture & System Design

## Voice-First Smart E-Commerce Platform

**Version:** 1.0 - MVP
**Target:** US market, single-vendor furniture e-commerce
**Scale target:** 10,000+ concurrent users
**Date:** March 2026

---

## Table of Contents

1. [System Overview](#1-system-overview)
2. [Architecture Layers](#2-architecture-layers)
3. [Tech Stack (Final)](#3-tech-stack-final)
4. [Database Schema Design](#4-database-schema-design)
5. [API Contracts](#5-api-contracts)
6. [Frontend Architecture](#6-frontend-architecture)
7. [Action Dispatcher & Voice Pipeline](#7-action-dispatcher--voice-pipeline)
8. [Authentication & Authorization](#8-authentication--authorization)
9. [Admin Panel](#9-admin-panel)
10. [Real-Time Features](#10-real-time-features)
11. [Infrastructure & DevOps](#11-infrastructure--devops)
12. [Implementation Workstreams](#12-implementation-workstreams)
13. [Integration Boundary (Azure OpenAI Chatbot)](#13-integration-boundary)
14. [Design System & UI Specification](#14-design-system--ui-specification)

---

## 1. System Overview

### What We're Building

A voice-first e-commerce platform where users can browse, filter, add to cart, checkout, and manage orders using natural speech OR traditional UI interaction. The system is designed as a generic e-commerce engine with furniture as the initial vertical, switchable to any product category via configuration.

### Architecture Philosophy

```
┌─────────────────────────────────────────────────────────────────┐
│                    SIMPLIFIED 3-TIER ARCHITECTURE                │
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │  FRONTEND (React SPA + Voice Widget)                      │   │
│  │  - Pages, Components, State (Zustand)                     │   │
│  │  - Action Dispatcher (intent JSON → state mutations)      │   │
│  │  - Voice I/O (Web Speech API → Azure Speech)              │   │
│  │  - WebSocket client for real-time                         │   │
│  └────────────────────────┬─────────────────────────────────┘   │
│                           │ REST API + WebSocket                  │
│  ┌────────────────────────▼─────────────────────────────────┐   │
│  │  BACKEND (Python FastAPI - Modular Monolith)              │   │
│  │  - Auth module (Azure AD B2C)                             │   │
│  │  - Product module (CRUD + search)                         │   │
│  │  - Cart module                                            │   │
│  │  - Order module                                           │   │
│  │  - User/Profile module                                    │   │
│  │  - Wishlist module                                        │   │
│  │  - Review module                                          │   │
│  │  - Admin module                                           │   │
│  │  - WebSocket hub (real-time events)                       │   │
│  └────────────────────────┬─────────────────────────────────┘   │
│                           │                                      │
│  ┌────────────────────────▼─────────────────────────────────┐   │
│  │  DATA LAYER                                               │   │
│  │  - PostgreSQL (primary data)                              │   │
│  │  - Redis (sessions, cache, cart, real-time pub/sub)       │   │
│  │  - Azure Blob Storage (product images)                    │   │
│  │  - Azure AI Search (full-text product search)             │   │
│  └──────────────────────────────────────────────────────────┘   │
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │  EXTERNAL SERVICES                                        │   │
│  │  - Azure AD B2C (auth)                                    │   │
│  │  - Azure OpenAI (chatbot - teammate builds)               │   │
│  │  - Azure Speech Services (STT/TTS - phase 2)             │   │
│  │  - Stripe (payments)                                      │   │
│  │  - SendGrid/Azure Email (transactional emails)            │   │
│  └──────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────┘
```

### Key Decision: Modular Monolith, NOT Microservices

For 10K users, a well-structured modular monolith in FastAPI handles the load trivially. Each "module" is a separate Python package with its own router, models, and service layer. If any module becomes a bottleneck at scale, it can be extracted into a standalone service without rewriting.

```
backend/
├── app/
│   ├── core/          # Config, security, database, dependencies
│   ├── auth/          # Azure AD B2C integration
│   ├── products/      # Product CRUD, categories, attributes
│   ├── cart/          # Cart operations
│   ├── orders/        # Order lifecycle
│   ├── users/         # User profiles, addresses
│   ├── wishlist/      # Wishlist operations
│   ├── reviews/       # Product reviews
│   ├── search/        # Azure AI Search integration
│   ├── admin/         # Admin endpoints
│   ├── realtime/      # WebSocket hub
│   └── main.py        # FastAPI app entry
```

---

## 2. Architecture Layers

### Layer 1: Frontend (React SPA)

**Responsibility:** UI rendering, client-side state, voice I/O, action dispatch

```
frontend/
├── src/
│   ├── app/                    # App shell, routing, providers
│   ├── components/
│   │   ├── ui/                 # shadcn/ui primitives
│   │   ├── layout/             # Header, Footer, Sidebar, Layout
│   │   ├── product/            # ProductCard, ProductGrid, ProductDetail
│   │   ├── cart/               # CartDrawer, CartItem, CartSummary
│   │   ├── checkout/           # CheckoutForm, PaymentForm, AddressForm
│   │   ├── voice/              # VoiceWidget, Transcript, MicButton
│   │   ├── filters/            # FilterSidebar, FilterAccordion
│   │   ├── search/             # SearchBar, SearchResults
│   │   └── common/             # Breadcrumbs, Ratings, Badge, Modal
│   ├── pages/                  # Route-level page components
│   │   ├── HomePage
│   │   ├── CollectionPage
│   │   ├── ProductDetailPage
│   │   ├── CartPage
│   │   ├── CheckoutPage
│   │   ├── OrderConfirmationPage
│   │   ├── AccountPage
│   │   ├── OrderHistoryPage
│   │   ├── WishlistPage
│   │   └── AdminDashboard/
│   ├── stores/                 # Zustand state stores
│   │   ├── cartStore.ts
│   │   ├── authStore.ts
│   │   ├── productStore.ts
│   │   ├── voiceStore.ts
│   │   ├── filterStore.ts
│   │   └── uiStore.ts
│   ├── services/               # API client functions
│   │   ├── api.ts              # Axios/fetch base config
│   │   ├── productService.ts
│   │   ├── cartService.ts
│   │   ├── orderService.ts
│   │   ├── authService.ts
│   │   └── searchService.ts
│   ├── voice/                  # Voice pipeline
│   │   ├── actionDispatcher.ts # Intent JSON → store mutations + navigation
│   │   ├── sttEngine.ts        # Speech-to-Text wrapper
│   │   ├── ttsEngine.ts        # Text-to-Speech wrapper
│   │   └── mockNlu.ts          # Mock NLU for testing (prefilled intents)
│   ├── hooks/                  # Custom React hooks
│   ├── lib/                    # Utilities, constants, types
│   └── styles/                 # Global styles, Tailwind config
```

### Layer 2: Backend API (FastAPI Modular Monolith)

**Responsibility:** Business logic, data access, auth, real-time events

Each module follows this internal structure:
```
module/
├── __init__.py
├── router.py          # FastAPI route handlers
├── models.py          # SQLAlchemy ORM models
├── schemas.py         # Pydantic request/response schemas
├── service.py         # Business logic
└── dependencies.py    # Module-specific DI
```

### Layer 3: Data Layer

**PostgreSQL** — Source of truth for all transactional data
**Redis** — Session store, cart cache, real-time pub/sub, rate limiting
**Azure Blob Storage** — Product images, user uploads
**Azure AI Search** — Full-text product search with faceted filtering

---

## 3. Tech Stack (Final)

| Layer | Component | Technology | Version |
|-------|-----------|-----------|---------|
| **Frontend** | Framework | React 18 + TypeScript | 18.x |
| **Frontend** | Build Tool | Vite | 5.x |
| **Frontend** | State Management | Zustand | 4.x |
| **Frontend** | Routing | React Router v6 | 6.x |
| **Frontend** | UI Components | shadcn/ui + Radix UI | latest |
| **Frontend** | Styling | Tailwind CSS | 3.x |
| **Frontend** | HTTP Client | Axios | 1.x |
| **Frontend** | Forms | React Hook Form + Zod | latest |
| **Frontend** | Voice (STT) | Web Speech API (MVP) → Azure Speech SDK | - |
| **Frontend** | Voice (TTS) | Web Speech Synthesis (MVP) → Azure Neural TTS | - |
| **Backend** | Framework | Python FastAPI | 0.110+ |
| **Backend** | ORM | SQLAlchemy 2.0 (async) | 2.x |
| **Backend** | Migrations | Alembic | 1.x |
| **Backend** | Validation | Pydantic v2 | 2.x |
| **Backend** | Task Queue | Celery + Redis (for emails, image processing) | 5.x |
| **Backend** | WebSocket | FastAPI WebSocket + Redis pub/sub | - |
| **Auth** | Provider | Azure AD B2C | - |
| **Auth** | Token | JWT (access + refresh tokens) | - |
| **Database** | Primary | PostgreSQL 16 | 16.x |
| **Database** | Cache/Session | Redis 7 | 7.x |
| **Search** | Engine | Azure AI Search | - |
| **Storage** | Images | Azure Blob Storage + Azure CDN | - |
| **Payments** | Gateway | Stripe | latest |
| **Email** | Provider | SendGrid OR Azure Communication Services | - |
| **Monitoring** | Errors | Sentry | latest |
| **Monitoring** | Metrics | Azure Monitor + Application Insights | - |
| **CI/CD** | Pipeline | GitHub Actions | - |
| **Containerization** | Runtime | Docker + Docker Compose (dev) | - |

---

## 4. Database Schema Design

### Source of Truth: `Data/schema/001_initial_schema.sql`

The existing schema in the Data folder is the canonical database design. It is a comprehensive, production-ready PostgreSQL schema with 21+ tables across 7 modules, already deployed to Azure PostgreSQL Flexible Server.

### Design Principles
- **schema.org aligned** — Product vocabulary follows schema.org standards
- **JSONB for dynamic attributes** — Products have `attributes`, `visual_attributes`, `enriched_description` as JSONB
- **Vertical-agnostic** — Categories + product_types + JSONB attributes = any e-commerce vertical
- **NLU-ready** — Product synonyms, search views, trigram indexes for voice search

### Existing Schema Overview (21 tables, 7 modules)

```
┌─────────────────────────────────────────────────────────────┐
│                     ENTITY RELATIONSHIP                      │
│                                                              │
│  USER MANAGEMENT (3 tables)                                  │
│  users ──┬── user_auth_providers (OAuth/social)              │
│          └── addresses (shipping/billing)                     │
│                                                              │
│  PRODUCT CATALOG (6 tables)                                  │
│  categories ── product_types                                 │
│       └── products ──┬── product_variants (SKU/stock)        │
│                      ├── product_images (gallery)            │
│                      └── product_relations (cross-sell)      │
│                                                              │
│  SHOPPING (4 tables)                                         │
│  carts ── cart_items                                         │
│  wishlists ── wishlist_items                                 │
│                                                              │
│  ORDERS & PAYMENTS (4 tables)                                │
│  orders ── order_items                                       │
│  payments (transaction records)                               │
│  refunds                                                     │
│                                                              │
│  REVIEWS (2 tables)                                          │
│  reviews ── review_images                                    │
│                                                              │
│  PROMOTIONS (3 tables)                                       │
│  promotions ── coupons ── coupon_usages                      │
│                                                              │
│  CONTENT (2 tables)                                          │
│  navigation_menus (dynamic mega menu)                         │
│  pages (CMS static pages)                                     │
└─────────────────────────────────────────────────────────────┘
```

### Key Product Table Structure (what makes vertical-switching possible)

```
products table:
  - attributes JSONB         → {colors, materials, styles, rooms, occasions, dimensions, weight}
  - visual_attributes JSONB  → {colors with hex, pattern, texture, finish, shape, silhouette}
  - enriched_description JSONB → {short, long, features[], care_instructions, material_composition}
  - tags TEXT[]              → Quick filtering array
  - seo JSONB               → {metaTitle, metaDescription, altText, keywords[]}

To switch from furniture to electronics:
  1. Add new categories + product_types
  2. Products use same JSONB fields with different attribute keys
  3. Filter sidebar reads attribute keys dynamically from product data
  4. No schema migration needed
```

### Tables We Need to ADD to Existing Schema

#### 1. attribute_templates (NEW - for auto-generating filter sidebar)
| Column | Type | Notes |
|--------|------|-------|
| id | UUID | PK |
| category_id | UUID | FK → categories |
| name | VARCHAR(100) | e.g., 'color', 'material', 'dimensions' |
| display_name | VARCHAR(100) | e.g., 'Color', 'Material' |
| type | ENUM('text','number','enum','boolean','range') | |
| attribute_path | VARCHAR(255) | JSONB path: 'attributes.colors' or 'visual_attributes.finish' |
| options | JSONB | For enum: ["red","blue"]; for range: {min:0, max:10000} |
| is_filterable | BOOLEAN | Show in filter sidebar |
| is_required | BOOLEAN | Required when creating product |
| sort_order | INTEGER | Display order in filter panel |

**Purpose:** The existing product `attributes` JSONB is powerful but the frontend needs to know WHICH attributes to show as filters and HOW to render them (checkbox vs slider vs text). This table provides that metadata.

#### 2. shipping_methods (NEW - for checkout)
| Column | Type | Notes |
|--------|------|-------|
| id | UUID | PK |
| name | VARCHAR(100) | e.g., "Standard", "Express", "Free" |
| description | TEXT | |
| price | DECIMAL(10,2) | 0 for free shipping |
| estimated_days_min | INTEGER | |
| estimated_days_max | INTEGER | |
| is_active | BOOLEAN | Default true |
| sort_order | INTEGER | |

#### 3. Add `order_number` column to existing orders table
```sql
ALTER TABLE orders ADD COLUMN order_number VARCHAR(20) UNIQUE;
-- Format: ORD-2026-00001 (auto-generated by trigger or app code)
```

### Seed Data Available
- 6 categories (Lighting, Decor, Art & Mirrors, Bedding & Textiles, Furniture, Rugs)
- 30 product types
- 158 fully-populated products with images, attributes, descriptions, SEO
- Located at `Data/seeds/002_products.sql`

### Archived NLU Schema (for future integration)
- Located at `Data/archive/nlu/`
- 15 intents, 8 entity types, search synonyms, conversation tracking
- Will be integrated when Azure OpenAI chatbot is production-ready

---

## 5. API Contracts

### Base URL: `/api/v1`

### Authentication
All endpoints except public product browsing require a Bearer token (JWT from Azure AD B2C).

### Products

```
GET    /products                    # List with filtering, pagination, sorting
GET    /products/{slug}             # Single product detail
GET    /products/{id}/reviews       # Product reviews

Query params for listing:
  ?category={slug}
  &price_min={number}
  &price_max={number}
  &attributes={JSON encoded}       # e.g., {"color":"red","material":"oak"}
  &tags={comma-separated}
  &sort={price_asc|price_desc|rating|newest|name}
  &page={number}
  &per_page={number}               # Default 20, max 100
  &search={text}                   # Full-text search via Azure AI Search
```

### Categories

```
GET    /categories                  # Tree structure
GET    /categories/{slug}           # Single category with attribute_templates
GET    /categories/{slug}/products  # Products in category
```

### Cart

```
GET    /cart                        # Get current user's cart
POST   /cart/items                  # Add item {product_id, variant_id?, quantity}
PATCH  /cart/items/{id}             # Update quantity {quantity}
DELETE /cart/items/{id}             # Remove item
DELETE /cart                        # Clear cart
POST   /cart/merge                  # Merge anonymous cart on login {session_id}
POST   /cart/apply-coupon           # Apply coupon {code}
DELETE /cart/coupon                  # Remove coupon
```

### Orders

```
POST   /orders                      # Place order {shipping_address_id, shipping_method_id, payment_method_id, coupon_code?}
GET    /orders                      # List user's orders (paginated)
GET    /orders/{order_number}       # Order detail + tracking
POST   /orders/{order_number}/cancel   # Cancel order
POST   /orders/{order_number}/return   # Initiate return {items[], reason}
```

### Checkout / Payments

```
POST   /checkout/create-payment-intent   # Create Stripe PaymentIntent {amount, currency}
POST   /checkout/confirm                 # Confirm and place order
GET    /checkout/shipping-methods        # Available shipping options
POST   /checkout/calculate-tax           # Calculate tax {address, items}
```

### Users / Profile

```
GET    /users/me                    # Current user profile
PATCH  /users/me                    # Update profile
GET    /users/me/addresses          # List addresses
POST   /users/me/addresses          # Add address
PATCH  /users/me/addresses/{id}     # Update address
DELETE /users/me/addresses/{id}     # Delete address
GET    /users/me/payment-methods    # List Stripe saved payment methods
```

### Wishlist

```
GET    /wishlist                    # List wishlist items
POST   /wishlist                    # Add item {product_id}
DELETE /wishlist/{product_id}       # Remove item
```

### Reviews

```
POST   /reviews                     # Create review {product_id, rating, title, body}
GET    /reviews/me                  # User's reviews
```

### Search

```
GET    /search?q={query}            # Full-text search via Azure AI Search
GET    /search/suggestions?q={partial}  # Autocomplete suggestions
```

### Admin (requires role=admin)

```
# Products
POST   /admin/products              # Create product
PATCH  /admin/products/{id}         # Update product
DELETE /admin/products/{id}         # Soft delete
POST   /admin/products/{id}/images  # Upload images (multipart)

# Categories
POST   /admin/categories
PATCH  /admin/categories/{id}
DELETE /admin/categories/{id}

# Attribute Templates
POST   /admin/attribute-templates
PATCH  /admin/attribute-templates/{id}
DELETE /admin/attribute-templates/{id}

# Orders
GET    /admin/orders                # All orders with filters
PATCH  /admin/orders/{id}/status    # Update order status

# Analytics
GET    /admin/analytics/dashboard   # Key metrics
GET    /admin/analytics/sales       # Sales data
GET    /admin/analytics/products    # Product performance

# Coupons
POST   /admin/coupons
PATCH  /admin/coupons/{id}
DELETE /admin/coupons/{id}

# Users
GET    /admin/users                 # List all users
GET    /admin/users/{id}            # User detail
```

### Real-Time (WebSocket)

```
WS     /ws                          # WebSocket connection

Events (server → client):
  cart:updated          # Cart changed (from another tab/device)
  order:status_changed  # Order status update
  inventory:low_stock   # Product going out of stock (admin)
  notification:new      # General notification

Events (client → server):
  voice:intent          # Send intent JSON for processing
  ping                  # Keepalive
```

---

## 6. Frontend Architecture

### Page Structure (Based on Jonathan Y Design Reference)

```
┌──────────────────────────────────────────────────────────────┐
│ HEADER (sticky)                                               │
│ ┌──────┐ ┌─────────────────────────────────┐ ┌───┬───┬───┐ │
│ │ LOGO │ │  NAV: Categories dynamically     │ │ 🔍│ 👤│ 🛒│ │
│ └──────┘ │  loaded from /categories API     │ └───┴───┴───┘ │
│           └─────────────────────────────────┘                │
├──────────────────────────────────────────────────────────────┤
│ PROMO BAR (optional): "FREE SHIPPING ON ALL ORDERS"          │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│ PAGE CONTENT (varies by route)                               │
│                                                              │
├──────────────────────────────────────────────────────────────┤
│ FOOTER                                                       │
│ Newsletter signup | Links | Social | Copyright               │
├──────────────────────────────────────────────────────────────┤
│ VOICE WIDGET (floating, bottom-right)                        │
│ ┌─────────────────────────┐                                  │
│ │ 🎤 Mic button           │                                  │
│ │ Transcript overlay      │                                  │
│ │ "Try: Show me red sofas"│                                  │
│ └─────────────────────────┘                                  │
└──────────────────────────────────────────────────────────────┘
```

### Homepage Layout

```
┌──────────────────────────────────────────────────────────────┐
│ HERO CAROUSEL (full-width lifestyle images)                  │
│ - Seasonal banner with CTA                                    │
│ - Auto-rotate with pause on hover                             │
├──────────────────────────────────────────────────────────────┤
│ CATEGORY GRID (3 columns)                                     │
│ ┌──────────┐ ┌──────────┐ ┌──────────┐                      │
│ │ Lifestyle │ │ Lifestyle │ │ Lifestyle │                     │
│ │  image    │ │  image    │ │  image    │                     │
│ │ SOFAS     │ │ TABLES    │ │ LIGHTING  │                     │
│ └──────────┘ └──────────┘ └──────────┘                      │
│ ┌──────────┐ ┌──────────┐ ┌──────────┐                      │
│ │ CHAIRS   │ │ OUTDOOR   │ │ STORAGE   │                     │
│ └──────────┘ └──────────┘ └──────────┘                      │
├──────────────────────────────────────────────────────────────┤
│ TRENDING SECTION (horizontal scroll)                          │
│ "TRENDING"                                                   │
│ ┌────┐ ┌────┐ ┌────┐ ┌────┐ ┌────┐                         │
│ │card│ │card│ │card│ │card│ │card│  →                        │
│ └────┘ └────┘ └────┘ └────┘ └────┘                         │
├──────────────────────────────────────────────────────────────┤
│ FEATURED COLLECTION (full-width banner)                       │
├──────────────────────────────────────────────────────────────┤
│ NEW ARRIVALS (4-column grid)                                  │
└──────────────────────────────────────────────────────────────┘
```

### Collection/Listing Page Layout

```
┌──────────────────────────────────────────────────────────────┐
│ Breadcrumbs: Home > Category                                 │
│ CATEGORY NAME                                                │
├──────────┬───────────────────────────────────────────────────┤
│ FILTER   │  "521 products"               SORT BY: [dropdown] │
│ SIDEBAR  │  ┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐    │
│          │  │ Product │ │ Product │ │ Product │ │ Product │   │
│ ▼ Color  │  │  Card   │ │  Card   │ │  Card   │ │  Card   │  │
│   □ Red  │  │ - Image │ │ - Image │ │ - Image │ │ - Image │  │
│   □ Blue │  │ - Name  │ │ - Name  │ │ - Name  │ │ - Name  │  │
│   □ Brown│  │ - Price │ │ - Price │ │ - Price │ │ - Price │  │
│          │  │ - ★★★★★ │ │ - ★★★★★ │ │ - ★★★★★ │ │ - ★★★★★ │  │
│ ▼ Material│ └────────┘ └────────┘ └────────┘ └────────┘    │
│ ▼ Price  │                                                   │
│ ▼ Size   │  ┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐    │
│ ▼ Style  │  │  ...    │ │  ...    │ │  ...    │ │  ...    │  │
│          │  └────────┘ └────────┘ └────────┘ └────────┘    │
│ ▼ Room   │                                                   │
│          │  [Load More / Pagination]                          │
├──────────┴───────────────────────────────────────────────────┤

Filter sidebar is AUTO-GENERATED from attribute_templates API.
Each filter type renders differently:
  - enum → checkbox list
  - number → range slider
  - boolean → toggle
  - text → text input
```

### Product Detail Page Layout

```
┌──────────────────────────────────────────────────────────────┐
│ Breadcrumbs: Home > Category > Product                       │
├──────────────────────────┬───────────────────────────────────┤
│                          │ PRODUCT NAME                      │
│   MAIN IMAGE             │ $43.99        ★★★★★ 4.6 (63 rev) │
│   (large, zoomable)      │                                   │
│                          │ SELECT COLOR: Cream                │
│                          │ [■cream] [■gray] [■blue]          │
│                          │                                   │
│   ┌──┐ ┌──┐ ┌──┐ ┌──┐  │ SELECT SIZE:                      │
│   │t1│ │t2│ │t3│ │t4│  │ [2'x4'] [3'x5'] [6'x9'] [8'x10']│
│   └──┘ └──┘ └──┘ └──┘  │                                   │
│   (thumbnail strip)      │ YOU MAY ALSO NEED                 │
│                          │ □ Rug Pad $43 □ Cleaner $20       │
│                          │                                   │
│                          │ Pay in 2 installments with Shop    │
│                          │                                   │
│                          │ [-] 1 [+]   [  ADD TO BAG  ]     │
├──────────────────────────┴───────────────────────────────────┤
│ ▼ DESCRIPTION                                                │
│ ▼ SHIPPING & RETURNS                                         │
│ ▼ DETAILS & DIMENSIONS                                       │
├──────────────────────────────────────────────────────────────┤
│ CUSTOMER REVIEWS                                              │
│ ★★★★★ 4.6/5 (63 reviews)  [Write a Review]                 │
│ ┌─────────────────────────────────────────┐                  │
│ │ ★★★★★  "Great quality!"  - John D.     │                  │
│ │ Verified purchase | March 1, 2026       │                  │
│ └─────────────────────────────────────────┘                  │
├──────────────────────────────────────────────────────────────┤
│ YOU MAY ALSO LIKE (4-col product grid)                       │
└──────────────────────────────────────────────────────────────┘
```

### Cart Page Layout

```
┌──────────────────────────────────────────────────────────────┐
│ CART (3)                                                     │
├──────────────────────────────┬───────────────────────────────┤
│ CART ITEMS                   │ ORDER SUMMARY                 │
│ ┌──────────────────────────┐ │                               │
│ │ [img] Product Name       │ │ Subtotal:        $62.99      │
│ │       Color: Cream/Black │ │ Shipping:        Free        │
│ │       Size: 3' x 5'     │ │ Tax:             calculated   │
│ │       [-] 1 [+]  $62.99 │ │                               │
│ │       Remove             │ │ Discount: [code____] [APPLY] │
│ └──────────────────────────┘ │                               │
│                              │ TOTAL:           $62.99       │
│ YOU MAY ALSO NEED            │                               │
│ □ Rug Pad $43  □ Cleaner $20│ [     CHECKOUT      ]         │
│                              │                               │
│                              │ 🍎Pay  PayPal  GPay          │
└──────────────────────────────┴───────────────────────────────┘
```

### Design System Tokens

Based on Jonathan Y analysis:

```
Colors:
  --primary:        #1B1B3A    (Navy/dark blue - buttons, header accents)
  --primary-hover:  #2D2D5E
  --background:     #FFFFFF
  --surface:        #F9F9F9    (Card backgrounds, section separators)
  --text-primary:   #1A1A1A
  --text-secondary: #666666
  --text-muted:     #999999
  --border:         #E5E5E5
  --accent:         #C9A96E    (Gold/warm - sale badges, highlights)
  --success:        #22C55E
  --error:          #EF4444
  --rating:         #1A1A1A    (Filled stars - dark, like Jonathan Y)

Typography:
  --font-display:   'Playfair Display', serif  (Logo, headings)
  --font-body:      'Inter', sans-serif        (Body, nav, UI)

  H1: 36px / 700
  H2: 28px / 600
  H3: 20px / 600
  Body: 14px / 400
  Small: 12px / 400
  Nav: 13px / 500 / uppercase / letter-spacing: 1px

Spacing:
  Page max-width: 1440px
  Content padding: 24px (mobile) / 48px (desktop)
  Section gap: 64px
  Card gap: 16px

Shadows:
  --shadow-sm: 0 1px 2px rgba(0,0,0,0.05)
  --shadow-md: 0 4px 12px rgba(0,0,0,0.1)

Breakpoints:
  sm: 640px
  md: 768px
  lg: 1024px
  xl: 1280px
  2xl: 1440px
```

---

## 7. Action Dispatcher & Voice Pipeline

### How It Works (No Playwright, No Browser Automation)

Since we OWN the site, the Action Dispatcher works by directly manipulating React state and the router. No DOM scraping, no selectors, no automation engine.

```
┌─────────────────────────────────────────────────────────────┐
│ VOICE PIPELINE (runs in browser)                             │
│                                                              │
│  Mic 🎤 → Web Speech API (STT) → text                       │
│                 │                                            │
│                 ▼                                            │
│  ┌─────────────────────────────┐                            │
│  │ Mock NLU / Azure OpenAI     │  (teammate's chatbot)      │
│  │ Input: "show me red sofas   │                            │
│  │         under $500"         │                            │
│  │                             │                            │
│  │ Output: {                   │                            │
│  │   intent: "search_product", │                            │
│  │   slots: {                  │                            │
│  │     category: "sofas",      │                            │
│  │     color: "red",           │                            │
│  │     price_max: 500          │                            │
│  │   },                        │                            │
│  │   response_text: "Here are  │                            │
│  │     red sofas under $500"   │                            │
│  │ }                           │                            │
│  └──────────┬──────────────────┘                            │
│             ▼                                                │
│  ┌─────────────────────────────┐                            │
│  │ ACTION DISPATCHER           │                            │
│  │                             │                            │
│  │ Maps intent → actions:      │                            │
│  │                             │                            │
│  │ "search_product" →          │                            │
│  │   1. router.navigate(       │                            │
│  │      /category/sofas)       │                            │
│  │   2. filterStore.setFilters(│                            │
│  │      {color:"red",          │                            │
│  │       price_max:500})       │                            │
│  │   3. productStore.fetch()   │                            │
│  │                             │                            │
│  │ "add_to_cart" →             │                            │
│  │   1. cartStore.addItem(     │                            │
│  │      productId, variantId)  │                            │
│  │   2. uiStore.showToast(     │                            │
│  │      "Added to cart")       │                            │
│  │                             │                            │
│  │ "navigate" →                │                            │
│  │   1. router.navigate(path)  │                            │
│  │                             │                            │
│  └──────────┬──────────────────┘                            │
│             ▼                                                │
│  TTS: Web Speech Synthesis speaks response_text              │
│                                                              │
│  UI updates reactively via Zustand store subscriptions       │
└─────────────────────────────────────────────────────────────┘
```

### Supported Intents (MVP)

| Intent | Slots | Action |
|--------|-------|--------|
| search_product | query?, category?, color?, price_min?, price_max?, material?, size? | Navigate to collection + apply filters |
| filter_products | color?, price_min?, price_max?, material?, size?, sort? | Update filter store (additive to current) |
| sort_products | sort_by (price_asc, price_desc, rating, newest, name) | Update sort in filter store |
| view_product | product_name?, product_index? ("the first one", "second one") | Navigate to product detail page |
| add_to_cart | product_id?, variant_id?, quantity? | Add to cart store + API call |
| remove_from_cart | product_name?, cart_item_index? | Remove from cart |
| update_cart_quantity | product_name?, cart_item_index?, quantity | Update quantity |
| view_cart | — | Navigate to cart page |
| apply_coupon | code | Apply coupon to cart |
| checkout | — | Navigate to checkout |
| use_saved_address | address_label? ("home", "work") | Select address in checkout |
| place_order | — | Confirm and place order (with confirmation step) |
| track_order | order_number? | Navigate to order detail |
| view_orders | — | Navigate to order history |
| add_to_wishlist | product_id? | Add current product to wishlist |
| view_wishlist | — | Navigate to wishlist |
| navigate | target (home, cart, wishlist, orders, account) | Router navigation |
| help | — | Show voice command suggestions |

### Mock NLU for Development

Until the Azure OpenAI chatbot is integrated, we use a local mock:

```typescript
// voice/mockNlu.ts
// Pattern-matching rules that simulate the chatbot's output

const patterns = [
  {
    match: /show me|find|search for (.+)/i,
    intent: "search_product",
    extractSlots: (match) => parseProductQuery(match[1])
  },
  {
    match: /add .* to (?:my )?cart/i,
    intent: "add_to_cart",
    extractSlots: () => ({ product_id: currentProductStore.getState().currentProduct?.id })
  },
  // ... more patterns
];
```

### Integration Contract with Azure OpenAI Chatbot

```typescript
// The interface the teammate's chatbot must implement:

interface ChatbotRequest {
  message: string;           // User's text (from STT or typed)
  context: {
    current_page: string;    // e.g., "/category/sofas"
    active_filters: Record<string, any>;
    cart_items: { product_id: string; name: string }[];
    last_intents: string[];  // Last 3 intents for context
  };
}

interface ChatbotResponse {
  intent: string;            // e.g., "search_product"
  slots: Record<string, any>;
  response_text: string;     // What to speak back to user
  confidence: number;        // 0-1
  suggestions?: string[];    // Follow-up suggestions
}

// Endpoint (when ready):
// POST /api/v1/chat/message → ChatbotResponse
```

---

## 8. Authentication & Authorization

### Azure AD B2C Flow

```
┌──────────┐     ┌──────────────┐     ┌──────────┐
│ Frontend  │────>│ Azure AD B2C │────>│ Backend  │
│          │     │              │     │          │
│ 1. User  │     │ 2. Login page│     │ 4. Verify│
│    clicks │     │    (hosted)  │     │    JWT   │
│    Login  │     │ 3. Returns   │     │ 5. Create│
│          │     │    JWT tokens │     │    user  │
│ 6. Store  │     │              │     │    if new│
│    tokens │     │              │     │          │
└──────────┘     └──────────────┘     └──────────┘
```

### Supported Auth Methods
- Email + Password
- Google social login
- Apple social login
- Phone OTP (SMS)
- Guest checkout (no account required, create account post-purchase option)

### Token Strategy
- Access token: 1 hour expiry, stored in memory (not localStorage)
- Refresh token: 7 days, stored in HTTP-only secure cookie
- On page load: silent token refresh via iframe

### Role-Based Access
- `customer` — default, can browse/buy/review
- `admin` — full access to admin panel and endpoints

---

## 9. Admin Panel

### Pages

```
/admin
├── /dashboard          # Key metrics: revenue, orders, users, top products
├── /products           # CRUD product management
│   ├── /new            # Create product form
│   └── /{id}/edit      # Edit product
├── /categories         # Category tree management
├── /orders             # Order list with status filters
│   └── /{id}           # Order detail + status update
├── /customers          # User list
│   └── /{id}           # Customer detail + order history
├── /coupons            # Coupon management
├── /reviews            # Review moderation (approve/reject)
├── /analytics          # Sales charts, product performance, conversion funnel
└── /settings           # Store settings, shipping methods, tax config
```

### Admin is part of the same React app (route-guarded), NOT a separate app.
This keeps the codebase simple and shares components.

---

## 10. Real-Time Features

### Implementation: FastAPI WebSocket + Redis Pub/Sub

```
Client A (browser)  ←→  FastAPI WebSocket Hub  ←→  Redis Pub/Sub
Client B (browser)  ←→                         ←→
Admin (browser)     ←→                         ←→
```

### Real-Time Events

| Event | Trigger | Who Receives |
|-------|---------|-------------|
| cart:updated | Cart modified from another tab/device | Same user, all tabs |
| order:status_changed | Admin updates order status | The customer |
| inventory:low_stock | Stock drops below threshold | Admin users |
| inventory:out_of_stock | Stock hits 0 | All users viewing that product |
| review:new | New review submitted | Admin (for moderation) |
| notification:promo | Admin sends promotion | All connected users |

---

## 11. Infrastructure & DevOps

### Local Development

```
docker-compose.yml:
  - postgres:16
  - redis:7
  - backend (FastAPI with hot-reload)
  - frontend (Vite dev server)
```

### GitHub Actions CI/CD

```
.github/workflows/
├── ci.yml              # On PR: lint, type-check, test (frontend + backend)
├── deploy-staging.yml  # On merge to develop: deploy to staging
└── deploy-prod.yml     # On merge to main: deploy to production
```

### Branching Strategy

```
main (production)
  └── develop (staging)
       ├── feature/frontend-core       # Agent 1
       ├── feature/backend-api         # Agent 2
       ├── feature/admin-panel         # Agent 3
       ├── feature/voice-pipeline      # Agent 4
       ├── feature/auth-integration    # Agent 5
       └── feature/payments-stripe     # Agent 6
```

Each feature branch merges into `develop` via PR. `develop` merges to `main` for releases.

### Deployment (Defined Later, Placeholders)

- Frontend: Azure Static Web Apps
- Backend: Azure Container Apps
- Database: Azure Database for PostgreSQL Flexible Server
- Cache: Azure Cache for Redis
- Storage: Azure Blob Storage + Azure CDN

---

## 12. Implementation Workstreams

### Dependency Graph

```
                    ┌─────────────────┐
                    │ WS-0: Project   │
                    │ Setup & Infra   │
                    │ (Sequential -   │
                    │  must be first) │
                    └────────┬────────┘
                             │
              ┌──────────────┼──────────────┐
              │              │              │
              ▼              ▼              ▼
    ┌─────────────┐ ┌──────────────┐ ┌──────────────┐
    │ WS-1:       │ │ WS-2:        │ │ WS-3:        │
    │ Backend API │ │ Frontend     │ │ Admin Panel  │
    │ (Core)      │ │ (UI Shell +  │ │ (depends on  │
    │             │ │  Components) │ │  WS-1 + WS-2)│
    └──────┬──────┘ └──────┬───────┘ └──────────────┘
           │               │
           ▼               ▼
    ┌──────────────────────────────┐
    │ WS-4: Frontend-Backend       │
    │ Integration (connects WS-1   │
    │ and WS-2)                    │
    └──────────────┬───────────────┘
                   │
         ┌─────────┼─────────┐
         │         │         │
         ▼         ▼         ▼
   ┌──────────┐ ┌────────┐ ┌──────────┐
   │ WS-5:    │ │ WS-6:  │ │ WS-7:    │
   │ Auth     │ │ Stripe │ │ Voice    │
   │ (Azure   │ │Payment │ │ Pipeline │
   │  AD B2C) │ │        │ │          │
   └──────────┘ └────────┘ └──────────┘
                   │
                   ▼
            ┌──────────────┐
            │ WS-8:        │
            │ Real-Time +  │
            │ Polish +     │
            │ Testing      │
            └──────────────┘
```

### Workstream Details

---

#### WS-0: Project Setup & Infrastructure (Sequential - FIRST)
**Estimated effort:** 1 day
**Dependency:** None
**Branch:** `main` (initial setup)

| Task | Description |
|------|-------------|
| 0.1 | Initialize monorepo structure (frontend/ + backend/) |
| 0.2 | Frontend: Vite + React + TypeScript + Tailwind + shadcn/ui scaffold |
| 0.3 | Backend: FastAPI project scaffold with module structure |
| 0.4 | Docker Compose: PostgreSQL 16 + Redis 7 |
| 0.5 | Alembic migration setup + initial migration (all tables) |
| 0.6 | GitHub Actions CI pipeline (lint + type-check) |
| 0.7 | Environment config (.env.example, settings.py) |
| 0.8 | Seed script for development data (categories, products, users) |

---

#### WS-1: Backend API - Core Modules (PARALLEL with WS-2)
**Estimated effort:** 5-7 days
**Dependency:** WS-0
**Branch:** `feature/backend-api`

| Task | Description |
|------|-------------|
| 1.1 | Core: Database connection (async SQLAlchemy), base models, dependencies |
| 1.2 | Products module: CRUD, filtering, pagination, sorting |
| 1.3 | Categories module: Tree CRUD, attribute templates |
| 1.4 | Cart module: Add/remove/update, anonymous + authenticated, merge |
| 1.5 | Orders module: Place order, status lifecycle, order history |
| 1.6 | Users module: Profile CRUD, addresses |
| 1.7 | Wishlist module: Add/remove/list |
| 1.8 | Reviews module: Create, list, moderate (admin) |
| 1.9 | Search module: Azure AI Search integration (or PostgreSQL full-text as fallback) |
| 1.10 | Coupons module: Validate, apply, admin CRUD |
| 1.11 | Image upload: Azure Blob Storage integration |
| 1.12 | API tests (pytest) for all endpoints |

---

#### WS-2: Frontend - UI Shell & Components (PARALLEL with WS-1)
**Estimated effort:** 5-7 days
**Dependency:** WS-0
**Branch:** `feature/frontend-core`

| Task | Description |
|------|-------------|
| 2.1 | Design system: Tailwind config (colors, fonts, spacing per spec) |
| 2.2 | Layout components: Header (with dynamic nav), Footer, PageLayout |
| 2.3 | UI primitives: Button, Input, Modal, Accordion, Badge, Rating, Toast |
| 2.4 | HomePage: Hero carousel, category grid, trending section |
| 2.5 | CollectionPage: Product grid, FilterSidebar (auto-generated from attribute templates), sort, pagination |
| 2.6 | ProductDetailPage: Image gallery, variant selector, add to bag, accordions, reviews |
| 2.7 | CartPage: Cart items list, order summary, quantity controls, cross-sell |
| 2.8 | CheckoutPage: Multi-step (address → shipping → payment → review) |
| 2.9 | Account pages: Profile, addresses, order history, order detail |
| 2.10 | WishlistPage |
| 2.11 | Zustand stores: cart, auth, products, filters, UI |
| 2.12 | Responsive design: Mobile-first for all pages |

**Note:** WS-2 uses mock data / MSW (Mock Service Worker) initially. Real API integration happens in WS-4.

---

#### WS-3: Admin Panel (PARALLEL after WS-1 starts)
**Estimated effort:** 4-5 days
**Dependency:** WS-1 (needs API endpoints), WS-2 (shares components)
**Branch:** `feature/admin-panel`

| Task | Description |
|------|-------------|
| 3.1 | Admin layout: Sidebar nav, dashboard shell |
| 3.2 | Dashboard: Key metrics cards (revenue, orders, users, top products) |
| 3.3 | Product management: List, create, edit (with image upload, attribute editor) |
| 3.4 | Category management: Tree view, create, edit, reorder |
| 3.5 | Order management: List with status filters, detail view, status update |
| 3.6 | Customer management: List, detail view |
| 3.7 | Coupon management: CRUD |
| 3.8 | Review moderation: Approve/reject queue |
| 3.9 | Analytics charts: Revenue over time, top products, conversion funnel |

---

#### WS-4: Frontend-Backend Integration (Sequential)
**Estimated effort:** 3-4 days
**Dependency:** WS-1 + WS-2 (both must be substantially complete)
**Branch:** `feature/integration`

| Task | Description |
|------|-------------|
| 4.1 | API client setup: Axios instance with auth interceptor, error handling |
| 4.2 | Connect product listing to real API (replace mock data) |
| 4.3 | Connect product detail to real API |
| 4.4 | Connect cart to real API (with Redis-backed persistence) |
| 4.5 | Connect checkout flow to real API |
| 4.6 | Connect user profile, addresses to real API |
| 4.7 | Connect wishlist to real API |
| 4.8 | Connect search to real API |
| 4.9 | Connect admin panel to real API |
| 4.10 | End-to-end flow testing |

---

#### WS-5: Authentication - Azure AD B2C (PARALLEL with WS-6, WS-7)
**Estimated effort:** 2-3 days
**Dependency:** WS-4 (needs integrated frontend + backend)
**Branch:** `feature/auth-integration`

| Task | Description |
|------|-------------|
| 5.1 | Azure AD B2C tenant setup and configuration |
| 5.2 | User flows: Sign-up, Sign-in, Password reset, Profile edit |
| 5.3 | Social login: Google, Apple |
| 5.4 | Backend: JWT validation middleware, user auto-creation on first login |
| 5.5 | Frontend: MSAL.js integration, auth store, protected routes |
| 5.6 | Guest checkout flow (no auth required until payment) |
| 5.7 | Cart merge on login (anonymous → authenticated) |
| 5.8 | Role-based route guards (admin pages) |

---

#### WS-6: Stripe Payment Integration (PARALLEL with WS-5, WS-7)
**Estimated effort:** 2-3 days
**Dependency:** WS-4 (needs checkout flow)
**Branch:** `feature/payments-stripe`

| Task | Description |
|------|-------------|
| 6.1 | Stripe account setup, API keys, webhook endpoint |
| 6.2 | Backend: Create PaymentIntent, handle webhook events |
| 6.3 | Frontend: Stripe Elements integration (card input) |
| 6.4 | Checkout flow: Payment → confirm → order creation |
| 6.5 | Saved payment methods (Stripe Customer) |
| 6.6 | Refund flow (admin-initiated) |
| 6.7 | Apple Pay / Google Pay via Stripe Payment Request |
| 6.8 | Test mode end-to-end with Stripe test cards |

---

#### WS-7: Voice Pipeline & Action Dispatcher (PARALLEL with WS-5, WS-6)
**Estimated effort:** 3-4 days
**Dependency:** WS-4 (needs working frontend with real data)
**Branch:** `feature/voice-pipeline`

| Task | Description |
|------|-------------|
| 7.1 | Voice widget component: Mic button, permission flow, transcript overlay |
| 7.2 | STT engine: Web Speech API wrapper with start/stop/cancel |
| 7.3 | TTS engine: Web Speech Synthesis wrapper with voice selection |
| 7.4 | Mock NLU: Pattern-matching intent+slot extractor for dev/testing |
| 7.5 | Action Dispatcher: Intent → store mutation + navigation mapping for all 16 intents |
| 7.6 | Dialogue context manager: Track last intents, active filters, current page |
| 7.7 | Confirmation flow: Voice confirmation before irreversible actions (place order) |
| 7.8 | Integration contract: Define HTTP endpoint for Azure OpenAI chatbot swap-in |
| 7.9 | Text chat fallback: Chat input that bypasses STT, goes directly to NLU |
| 7.10 | Voice command help overlay ("Try saying...") |

---

#### WS-8: Real-Time, Polish & Testing (Sequential - LAST)
**Estimated effort:** 3-4 days
**Dependency:** WS-5, WS-6, WS-7 all complete
**Branch:** `feature/realtime-polish`

| Task | Description |
|------|-------------|
| 8.1 | WebSocket hub: FastAPI WebSocket + Redis pub/sub |
| 8.2 | Real-time cart sync (across tabs/devices) |
| 8.3 | Real-time order status updates |
| 8.4 | Real-time inventory alerts (admin) |
| 8.5 | Transactional emails: Order confirmation, shipping, return (SendGrid or Azure) |
| 8.6 | SEO: Meta tags, Open Graph, structured data |
| 8.7 | Performance: Image lazy loading, code splitting, bundle optimization |
| 8.8 | Accessibility audit: Keyboard nav, screen reader, WCAG 2.2 basics |
| 8.9 | Error boundaries, loading states, empty states |
| 8.10 | End-to-end testing with Playwright (test suite, not automation engine) |
| 8.11 | Security audit: CORS, CSP, rate limiting, input sanitization |

---

## 13. Integration Boundary (Azure OpenAI Chatbot)

### What We Build (Mock)

A mock NLU service that pattern-matches user text to intents+slots. This allows full development and testing of the voice pipeline without the real chatbot.

### What Your Teammate Builds

An Azure OpenAI-powered service that:
1. Receives user message + conversation context
2. Returns intent + slots JSON

### Swap-In Process

When the chatbot is ready:
1. Deploy it as a REST endpoint (or Azure Function)
2. In our code, change ONE config flag: `NLU_PROVIDER=azure_openai` (from `mock`)
3. The Action Dispatcher doesn't change at all — it only consumes the intent+slots JSON

### The Contract (shared with teammate)

```json
// POST /api/v1/chat/message
// Request:
{
  "message": "Show me red sofas under $500",
  "context": {
    "current_page": "/category/furniture",
    "active_filters": {"material": "wood"},
    "cart_item_count": 2,
    "last_intents": ["search_product", "filter_products"],
    "user_id": "uuid-or-null"
  }
}

// Response:
{
  "intent": "search_product",
  "slots": {
    "category": "sofas",
    "color": "red",
    "price_max": 500
  },
  "response_text": "Here are red sofas under $500",
  "confidence": 0.95,
  "suggestions": ["Filter by material", "Sort by price"]
}
```

---

## 14. Design System & UI Specification

### Reference: Jonathan Y (jonathany.com)

### Design Principles
1. **Clean & minimal** — Lots of whitespace, content-focused
2. **Navy + white + warm neutrals** — Premium but not cold
3. **Serif for brand, sans-serif for UI** — Editorial feel
4. **Large product images** — Products sell themselves
5. **Consistent card design** — Image → Name → Price → Rating
6. **Collapsible filters** — Don't overwhelm, let user expand
7. **Full-width lifestyle imagery** — Hero sections, category banners
8. **Sticky header** — Always accessible navigation
9. **Floating voice widget** — Non-intrusive, bottom-right
10. **Mobile-first** — Responsive at every breakpoint

### Component Inventory

| Component | Priority | Notes |
|-----------|----------|-------|
| Header (nav + search + cart badge) | P0 | Dynamic categories from API |
| Footer (newsletter + links) | P0 | |
| Hero Carousel | P0 | Full-width, auto-rotate |
| Category Grid (3-col lifestyle images) | P0 | |
| Product Card | P0 | Image, name, price, rating |
| Product Grid (4-col) | P0 | |
| Filter Sidebar (auto-generated) | P0 | From attribute_templates |
| Product Detail (gallery + info) | P0 | |
| Cart Drawer / Cart Page | P0 | |
| Checkout Multi-Step | P0 | |
| Voice Widget (mic + transcript) | P1 | Floating bottom-right |
| Search Modal (full-screen overlay) | P1 | |
| Breadcrumbs | P1 | |
| Rating Stars | P0 | |
| Promo Bar (top) | P2 | |
| "You May Also Need" cross-sell | P2 | |
| Size/variant selector buttons | P0 | |
| Quantity stepper | P0 | |
| Toast notifications | P0 | |
| Loading skeletons | P1 | |
| Empty states | P1 | |

---

## Summary

### What Gets Built (MVP Scope)

- Full e-commerce storefront (browse, search, filter, cart, checkout, orders)
- Voice-first interaction with mock NLU (swappable for Azure OpenAI)
- Admin panel for product/order/customer management
- Stripe payments (cards + Apple Pay + Google Pay)
- Azure AD B2C authentication (email, social, phone)
- Real-time updates (cart sync, order status)
- Generic schema supporting any product vertical

### What Gets Deferred

- Azure Speech Services (using free Web Speech API for MVP)
- Offline/PWA mode
- Multi-language support
- Multi-vendor/marketplace
- Advanced analytics (ClickHouse/BigQuery)
- Deployment to Azure (local Docker for now)
- React Native mobile app
- A/B testing and feature flags

---

*End of Architecture Document*
