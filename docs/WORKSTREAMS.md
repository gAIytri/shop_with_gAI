# Shop with gAI - Implementation Workstreams & Task Breakdown

## How to Use This File

This file is the **single source of truth** for all implementation tasks. Each workstream is self-contained with enough detail for any developer or agent to pick it up independently.

### Console Strategy (Updated — Frontend Upgrade Phase)

**Branch**: `feature/frontend-upgrade` (single branch for all frontend consoles)
**No worktrees needed** — all consoles work in the same directory (`gai-ecom/`), each owns different files.

| Console | Role | Files Owned | Step |
|---------|------|-------------|------|
| Coordinator (this console) | Setup, routing, integration | `App.tsx`, git ops, docs | 0, 4, 6 |
| Console A | Types, Stores, Components, API | `src/types/`, `src/store/`, `src/services/`, `src/components/ui/`, `src/components/common/` | 1, then 5 |
| Console B | New Pages | `src/pages/` (new files only) | 2 |
| Console C | Mobile + UX Polish | `src/components/layout/`, `src/components/product/`, existing page responsive fixes | 3 |
| QA Console | Verification | Reads all, writes nothing | After each step |

### Execution Order
```
Step 0: Coordinator → setup branch, baseline commit
Step 1: Console A → types, stores, UI components (BLOCKING — others wait)
Step 2+3: Console B + Console C → pages + mobile (PARALLEL)
Step 4: Coordinator → wire routing, verify
Step 5: Console A → API service layer
Step 6: Coordinator → swap old frontend, cleanup, merge
```

### Rules for All Consoles
1. Always read this file + `docs/ARCHITECTURE.md` before starting work
2. Work ONLY on your assigned files/directories
3. Never push directly to `main` — all work goes through PRs
4. Commit frequently with descriptive messages
5. If blocked, document the blocker and move to the next task
6. NEVER mention Claude or AI in commits or comments

---

## Dependency Graph

```
WS-0 (Setup) ─────────────────────────────────── DONE
    │
    ├──→ WS-1 (Backend API) ──────────────────── DONE (merged to develop)
    │                              ┌─────────────────────────────────────┐
    └──→ WS-2R (Frontend Upgrade)─┤ Step 0: Setup (Coordinator)        │
         (replaces old WS-2)      │ Step 1: Types+Stores (Console A)   │
                                  │ Step 2: Pages (Console B)     ──┐  │
                                  │ Step 3: Mobile+UX (Console C) ──┤  │ PARALLEL
                                  │ Step 4: Routing (Coordinator)   │  │
                                  │ Step 5: API Layer (Console A)   │  │
                                  │ Step 6: Swap+Cleanup (Coord.)   │  │
                                  └──────────────┬──────────────────┘  │
                                                 │                     │
    WS-1 (Backend) ──────────────────────────────┤                     │
                                                 ├──→ WS-4 (Integration)
                                                 │         │
                                                 │         ├──→ WS-5 (Auth)
                                                 │         ├──→ WS-6 (Payments)
         WS-3 (Admin Panel) ────────────────────→│         ├──→ WS-7 (Voice)
                                                           └──→ WS-8 (Polish)
```

**Current Status:**
- WS-0: DONE
- WS-1: DONE (42 endpoints, 28 tests, merged to `develop`)
- WS-2: REPLACED by WS-2R (frontend upgrade using gai-ecom)
- WS-2R: IN PROGRESS (Steps 0-6, see below)

**Execution Order:**
- WS-2R Steps 0-6 complete the frontend upgrade
- WS-4 depends on WS-1 (done) + WS-2R Step 5 (API service layer)
- Group B (WS-5 + WS-6 + WS-7): After WS-4
- WS-8: After all others

---

## WS-0: Project Setup & Infrastructure

**Branch:** `main` (initial setup, then create `develop`)
**Estimated:** 1 day
**Dependencies:** None
**Console:** Any (do this first before splitting)

### Tasks

- [ ] **0.1** Initialize monorepo directory structure
  ```
  /
  ├── frontend/          # React app
  ├── backend/           # FastAPI app
  ├── docker/            # Docker configs
  ├── docs/              # Architecture docs (already exists)
  ├── Data/              # DB schema & seeds (already exists)
  ├── .github/workflows/ # CI/CD
  ├── docker-compose.yml
  └── Makefile           # Common commands
  ```

- [ ] **0.2** Frontend scaffold: Vite + React 18 + TypeScript
  ```bash
  cd frontend
  npm create vite@latest . -- --template react-ts
  ```
  - Install dependencies:
    - `react-router-dom` (routing)
    - `zustand` (state management)
    - `axios` (HTTP client)
    - `react-hook-form` + `zod` + `@hookform/resolvers` (forms)
    - `tailwindcss` + `postcss` + `autoprefixer` (styling)
    - `@radix-ui/react-*` components as needed by shadcn
    - `lucide-react` (icons)
    - `clsx` + `tailwind-merge` (class utilities)
  - Configure shadcn/ui (init with New York style, slate color)
  - Configure Tailwind with design tokens from ARCHITECTURE.md Section 14
  - Set up path aliases (`@/` → `src/`)
  - Create folder structure per ARCHITECTURE.md Section 6

- [ ] **0.3** Backend scaffold: Python FastAPI project
  ```
  backend/
  ├── app/
  │   ├── __init__.py
  │   ├── main.py              # FastAPI app entry, CORS, middleware
  │   ├── core/
  │   │   ├── __init__.py
  │   │   ├── config.py        # Pydantic Settings (env vars)
  │   │   ├── database.py      # Async SQLAlchemy engine + session
  │   │   ├── dependencies.py  # Common DI (get_db, get_current_user)
  │   │   ├── security.py      # JWT validation, password hashing
  │   │   └── exceptions.py    # Custom exception handlers
  │   ├── products/
  │   │   ├── __init__.py
  │   │   ├── router.py
  │   │   ├── models.py
  │   │   ├── schemas.py
  │   │   └── service.py
  │   ├── categories/          # Same structure
  │   ├── cart/
  │   ├── orders/
  │   ├── users/
  │   ├── wishlist/
  │   ├── reviews/
  │   ├── search/
  │   ├── admin/
  │   ├── payments/
  │   ├── coupons/
  │   └── realtime/
  ├── alembic/                 # Migrations
  │   ├── env.py
  │   └── versions/
  ├── tests/
  ├── alembic.ini
  ├── requirements.txt
  ├── requirements-dev.txt
  └── pyproject.toml
  ```
  - Dependencies (requirements.txt):
    - `fastapi[standard]`
    - `uvicorn[standard]`
    - `sqlalchemy[asyncio]>=2.0`
    - `asyncpg` (async PostgreSQL driver)
    - `alembic`
    - `pydantic>=2.0`
    - `pydantic-settings`
    - `python-jose[cryptography]` (JWT)
    - `passlib[bcrypt]`
    - `redis[hiredis]` (async redis)
    - `stripe`
    - `python-multipart` (file uploads)
    - `boto3` or `azure-storage-blob` (image storage)
    - `httpx` (async HTTP client)
    - `celery[redis]` (task queue)
  - Dev dependencies (requirements-dev.txt):
    - `pytest` + `pytest-asyncio`
    - `httpx` (for TestClient)
    - `black` + `ruff` (formatting/linting)
    - `mypy`

- [ ] **0.4** Docker Compose: PostgreSQL 16 + Redis 7
  ```yaml
  # docker-compose.yml
  services:
    postgres:
      image: postgres:16
      ports: ["5432:5432"]
      environment:
        POSTGRES_DB: shopwithgai
        POSTGRES_USER: postgres
        POSTGRES_PASSWORD: postgres
      volumes:
        - postgres_data:/var/lib/postgresql/data
        - ./Data/schema/001_initial_schema.sql:/docker-entrypoint-initdb.d/001_schema.sql
        - ./Data/seeds/002_products.sql:/docker-entrypoint-initdb.d/002_seeds.sql

    redis:
      image: redis:7-alpine
      ports: ["6379:6379"]

  volumes:
    postgres_data:
  ```

- [ ] **0.5** Alembic migration setup
  - Initialize alembic in backend/
  - Configure to use async SQLAlchemy engine
  - Create initial migration that matches `001_initial_schema.sql`
  - Add migration for new tables: `attribute_templates`, `shipping_methods`
  - Add migration for `order_number` column on orders

- [ ] **0.6** Environment config
  - Create `backend/.env.example` with all required vars
  - Create `frontend/.env.example`
  - Create `backend/app/core/config.py` using Pydantic Settings

- [ ] **0.7** GitHub Actions CI pipeline
  ```yaml
  # .github/workflows/ci.yml
  # On: push to any branch, PR to develop/main
  # Jobs:
  #   backend-lint: ruff check + mypy
  #   backend-test: pytest with PostgreSQL service container
  #   frontend-lint: eslint + tsc --noEmit
  #   frontend-build: vite build (catches build errors)
  ```

- [ ] **0.8** Makefile for common commands
  ```makefile
  # make setup     - Install all dependencies
  # make dev       - Start docker + backend + frontend
  # make test      - Run all tests
  # make lint      - Run all linters
  # make migrate   - Run alembic migrations
  # make seed      - Seed database
  ```

- [ ] **0.9** Create `develop` branch from `main` after setup
  - Push both `main` and `develop` to remote

---

## WS-1: Backend API - Core Modules

**Branch:** `feature/backend-api` (from `develop`)
**Estimated:** 5-7 days
**Dependencies:** WS-0 complete
**Console:** Console 1 (Backend Developer)

### Reference Files
- `docs/ARCHITECTURE.md` Section 5 (API Contracts)
- `Data/schema/001_initial_schema.sql` (table definitions)
- `Data/seeds/002_products.sql` (seed data structure)

### Tasks

#### Core Infrastructure
- [ ] **1.1** Database models — Define all SQLAlchemy ORM models matching existing schema
  - `app/core/database.py`: Async engine, session factory, Base class
  - Each module's `models.py`: Map every table from `001_initial_schema.sql`
  - Include all relationships, indexes, and constraints
  - JSONB fields use `sqlalchemy.dialects.postgresql.JSONB`
  - ARRAY fields use `sqlalchemy.dialects.postgresql.ARRAY`
  - ENUM types use `sqlalchemy.Enum` or native PostgreSQL enums

- [ ] **1.2** Base dependencies and middleware
  - `app/core/dependencies.py`: `get_db()` async session dependency
  - `app/core/security.py`: JWT token validation (placeholder for Azure AD B2C)
  - `app/core/exceptions.py`: HTTPException handlers, custom exceptions
  - CORS middleware configuration
  - Request logging middleware

#### Products Module
- [ ] **1.3** Products — CRUD + filtering + pagination
  - `GET /api/v1/products` — List with:
    - Filter by: category (slug), price range, attributes (JSONB query), tags
    - Sort by: price_asc, price_desc, rating, newest, name
    - Pagination: page + per_page (default 20, max 100)
    - Response: paginated list with total count
  - `GET /api/v1/products/{slug}` — Single product with:
    - Variants, images, related products (cross-sell/upsell)
    - Category + product_type info
  - Pydantic schemas for request/response
  - Service layer with async SQLAlchemy queries

- [ ] **1.4** Product reviews endpoint
  - `GET /api/v1/products/{id}/reviews` — Paginated reviews for a product
  - Include reviewer name, rating, title, body, verified purchase badge, date

#### Categories Module
- [ ] **1.5** Categories — Tree structure
  - `GET /api/v1/categories` — Full category tree with product_types
  - `GET /api/v1/categories/{slug}` — Single category with:
    - Product types under it
    - Attribute templates (for filter sidebar generation)
    - Product count
  - `GET /api/v1/categories/{slug}/products` — Products in category (reuse product listing logic)

#### Cart Module
- [ ] **1.6** Cart — Full CRUD with guest support
  - `GET /api/v1/cart` — Get cart (by user_id or session_id)
  - `POST /api/v1/cart/items` — Add item (product_id, variant_id?, quantity)
    - Validate stock availability
    - If item already in cart, increment quantity
  - `PATCH /api/v1/cart/items/{id}` — Update quantity
    - Validate stock
    - If quantity = 0, remove item
  - `DELETE /api/v1/cart/items/{id}` — Remove item
  - `DELETE /api/v1/cart` — Clear entire cart
  - `POST /api/v1/cart/merge` — Merge anonymous cart into user cart on login
  - `POST /api/v1/cart/apply-coupon` — Validate and apply coupon code
  - `DELETE /api/v1/cart/coupon` — Remove coupon
  - Auto-calculate subtotal, discount, total (match DB trigger logic)
  - Redis caching: Write-through to Redis for fast reads

#### Orders Module
- [ ] **1.7** Orders — Lifecycle management
  - `POST /api/v1/orders` — Place order
    - Validate cart not empty
    - Validate stock for all items
    - Snapshot product data in order_items.product_snapshot
    - Generate order_number (ORD-YYYY-XXXXX)
    - Create payment record
    - Decrement stock
    - Clear cart
    - Return order confirmation
  - `GET /api/v1/orders` — User's order history (paginated)
  - `GET /api/v1/orders/{order_number}` — Order detail
  - `POST /api/v1/orders/{order_number}/cancel` — Cancel (if status allows)
  - `POST /api/v1/orders/{order_number}/return` — Initiate return
  - Status flow: pending → confirmed → processing → shipped → delivered
  - Status flow (alt): pending → cancelled, delivered → returned

#### Users Module
- [ ] **1.8** Users — Profile and addresses
  - `GET /api/v1/users/me` — Current user profile
  - `PATCH /api/v1/users/me` — Update profile (name, phone, preferences)
  - `GET /api/v1/users/me/addresses` — List addresses
  - `POST /api/v1/users/me/addresses` — Add address
  - `PATCH /api/v1/users/me/addresses/{id}` — Update address
  - `DELETE /api/v1/users/me/addresses/{id}` — Delete address
  - `PATCH /api/v1/users/me/addresses/{id}/default` — Set as default

#### Wishlist Module
- [ ] **1.9** Wishlist
  - `GET /api/v1/wishlist` — List wishlist items with product details
  - `POST /api/v1/wishlist` — Add item (product_id)
  - `DELETE /api/v1/wishlist/{product_id}` — Remove item
  - Unique constraint: one product per user per wishlist

#### Reviews Module
- [ ] **1.10** Reviews
  - `POST /api/v1/reviews` — Create review (product_id, rating, title, body)
    - Check if user has ordered this product (verified purchase)
    - One review per product per user
  - `GET /api/v1/reviews/me` — User's reviews
  - Update product avg_rating and review_count (DB trigger handles this)

#### Search Module
- [ ] **1.11** Search — Full-text product search
  - `GET /api/v1/search?q={query}` — Search products
    - Use PostgreSQL full-text search (tsvector/tsquery) as primary
    - Search across: name, description, tags, attributes
    - Return products with relevance score
    - Support faceted results (count by category, price ranges)
  - `GET /api/v1/search/suggestions?q={partial}` — Autocomplete
    - Use pg_trgm trigram similarity
    - Return top 5-10 suggestions
  - NOTE: Azure AI Search integration deferred; PostgreSQL FTS is sufficient for MVP

#### Coupons Module
- [ ] **1.12** Coupons — Validation and admin CRUD
  - `POST /api/v1/cart/apply-coupon` — Validate coupon (already in cart module)
    - Check: code exists, is_active, within date range, not over max_uses
    - Calculate discount based on type (percentage, fixed, free_shipping)
  - Admin endpoints (see WS-3)

#### Image Upload
- [ ] **1.13** Image upload to Azure Blob Storage
  - `POST /api/v1/admin/products/{id}/images` — Upload images (multipart)
  - Generate unique filenames
  - Upload to Azure Blob container
  - Return CDN URL
  - Support multiple images per request
  - Image resize/optimization (via Celery task)

#### Admin Endpoints
- [ ] **1.14** Admin-only API endpoints (role=admin guard)
  - Products: `POST/PATCH/DELETE /api/v1/admin/products`
  - Categories: `POST/PATCH/DELETE /api/v1/admin/categories`
  - Product types: `POST/PATCH/DELETE /api/v1/admin/product-types`
  - Orders: `GET /api/v1/admin/orders`, `PATCH /api/v1/admin/orders/{id}/status`
  - Users: `GET /api/v1/admin/users`, `GET /api/v1/admin/users/{id}`
  - Coupons: Full CRUD `/api/v1/admin/coupons`
  - Reviews: `GET /api/v1/admin/reviews/pending`, `PATCH /api/v1/admin/reviews/{id}/approve`
  - Analytics: `GET /api/v1/admin/analytics/dashboard` (revenue, orders, users, top products)

#### Checkout Endpoints
- [ ] **1.15** Checkout flow
  - `GET /api/v1/checkout/shipping-methods` — Available shipping options
  - `POST /api/v1/checkout/calculate-tax` — Calculate tax for address
  - `POST /api/v1/checkout/create-payment-intent` — Stripe PaymentIntent (placeholder)
  - `POST /api/v1/checkout/confirm` — Confirm order after payment

#### Tests
- [ ] **1.16** API tests with pytest
  - Test fixtures: test database, test user, sample products
  - Test each endpoint: success + error cases
  - Test auth: unauthenticated, wrong role
  - Test cart: add, update, remove, merge, coupon
  - Test order: place, cancel, return, status flow
  - Minimum: 1 test per endpoint

---

## WS-2R: Frontend Upgrade (Replaces WS-2)

**Branch:** `feature/frontend-upgrade` (from `develop`)
**Dependencies:** WS-0 + WS-1 complete
**Strategy:** Upgrade existing `gai-ecom/` site (React 19, 158 products, 181 images, custom SX design system) into the production frontend. Port missing features from old `frontend/` (WS-2).
**Brand:** gAI DECOR | **Colors:** Emerald #29B770, Dark Green #072D1F

### What gai-ecom Already Has (DONE)
- Landing page with HeroCarousel, VideoHero, FlashSale, TrendingSection, InteriorStyles
- 6 category Hub pages (Furniture, Rugs, Lighting, Decor, Art, Bedding) with scroll animations
- ProductDetail with split-view gallery, color swatches, accordions, similar products
- Cart page + CartDrawer (framer-motion slide-in)
- 5 Zustand stores: cart, cartDrawer, filter, recentlyViewed, toast
- productService.ts with filtering, search, similar products (341 lines)
- SX Design System (object-to-Tailwind compiler): Box, Flex, Text, Grid, Stack
- 158 real products across 6 categories with 181 images

### What's Missing (TODO — Steps 1-6 below)
- Checkout flow, Wishlist, Account pages, Auth pages, Search results
- Mobile responsiveness (hardcoded `w-1/2`, no hamburger menu)
- Auth store, Wishlist store, Checkout store, Order store, UI store
- Unified Product types (two mismatched Product types exist)
- API service layer for backend integration
- Several shadcn UI components (Sheet, Tabs, Skeleton, etc.)

### Tasks

#### Step 0: Setup (Coordinator)

- [ ] **0.1** Remove old git worktrees
  ```bash
  git worktree remove ../shopwithgAI-backend
  git worktree remove ../shopwithgAI-frontend
  git branch -d feature/backend-api feature/frontend-core
  ```

- [ ] **0.2** Create feature branch
  ```bash
  git checkout develop
  git checkout -b feature/frontend-upgrade
  ```

- [ ] **0.3** Add gai-ecom to git tracking, commit baseline

#### Step 1: Console A — Types, Stores & Components Foundation

**BLOCKING: Steps 2 and 3 depend on this completing first.**
**Files owned:** `src/types/`, `src/store/`, `src/components/ui/`, `src/components/common/`, Navbar.tsx + Footer.tsx (rebrand only)

- [ ] **1.1** Unify Product types
  - Modify `src/types/product.ts`: Add `slug?`, `stockStatus?`, typed `enrichedDescription`
  - Rewrite `src/types/index.ts`: Export Product from `./product`, add User, Address, Order, OrderItem, CartItem (with `id`), Review, WishlistItem, SortOption, ShippingMethod
  - Create `src/types/api.ts`: Backend wire-format types (snake_case)

- [ ] **1.2** Fix CartStore
  - Use canonical Product type from `types/product.ts`
  - Add `id` (uuid) to each CartItem for variant handling
  - Add `couponCode`, `discount` state
  - Add `subtotal()`, `shipping()`, `tax()`, `total()` computed methods
  - Port coupon logic from old `frontend/src/stores/cartStore.ts`

- [ ] **1.3** Create new Zustand stores
  - `useAuthStore.ts` — user, token, sessionId, login/logout/updateUser. Persist token+sessionId
  - `useWishlistStore.ts` — items, addItem/removeItem/isInWishlist. Persist
  - `useUIStore.ts` — isMobileMenuOpen, isSearchOpen
  - `useCheckoutStore.ts` — step (0-2), shippingAddress, shippingMethod, reset
  - `useOrderStore.ts` — orders, currentOrder

- [ ] **1.4** Port missing UI components
  - shadcn-style in `src/components/ui/`: sheet, label, separator, tabs, skeleton, select, accordion
  - Common in `src/components/common/`: ErrorBoundary, Rating, PriceDisplay, QuantityStepper, Breadcrumbs, PromoBar

- [ ] **1.5** Install missing dependencies: `react-hook-form @hookform/resolvers zod axios`

- [ ] **1.6** Rebrand: "GaiDECOR" → "gAI DECOR" in Navbar.tsx, Footer.tsx

**Commit:** "Foundation: unified types, stores, UI components, rebrand"

#### Step 2: Console B — New Pages (PARALLEL with Step 3)

**Depends on Step 1 committed. Works ONLY in `src/pages/` (new files).**

- [ ] **2.1** Checkout.tsx — 3-step flow (Shipping → Payment → Review)
- [ ] **2.2** Wishlist.tsx
- [ ] **2.3** Account pages — Account.tsx (layout), account/Profile.tsx, account/Addresses.tsx, account/Orders.tsx, account/OrderDetail.tsx
- [ ] **2.4** Auth pages — Login.tsx, Register.tsx
- [ ] **2.5** Other pages — OrderConfirmation.tsx, SearchResults.tsx, NotFound.tsx

Port from old `frontend/src/pages/`, adapt to gai-ecom styling (emerald green, clean minimal).

**Commit:** "Add checkout, wishlist, account, auth, search pages"

#### Step 3: Console C — Mobile Responsiveness + UX (PARALLEL with Step 2)

**Depends on Step 1 committed. Works in `src/components/` and existing page files.**

- [ ] **3.1** Mobile navigation — Hamburger icon in Navbar (md:hidden), hide MegaMenu on mobile
- [ ] **3.2** MobileMenu.tsx — Full-screen slide-in with accordion categories
- [ ] **3.3** Navbar icons — Search, Heart (wishlist), User icons in right section
- [ ] **3.4** ProductDetail responsive — `flex-col lg:flex-row`, `w-full lg:w-1/2`, responsive grids
- [ ] **3.5** FilterSidebar mobile drawer — Render inside Sheet on mobile
- [ ] **3.6** Category Hub pages responsive — All `*Hub.tsx` and `*Category.tsx` files
- [ ] **3.7** Wishlist hearts on ProductCard — Heart icon overlay, toggle wishlistStore
- [ ] **3.8** PromoBar + Layout — Add PromoBar above Navbar, ErrorBoundary in App.tsx
- [ ] **3.9** Cart buttons — Wire CartDrawer + Cart checkout buttons to `/checkout`

**Commit:** "Mobile responsive, UX polish, wishlist hearts, nav icons"

#### Step 4: Coordinator — Routing & Integration

**After Steps 2 and 3 committed.**

- [ ] **4.1** Update App.tsx routing — Add all new routes:
  `/checkout`, `/wishlist`, `/order-confirmation/:orderNumber`, `/search`,
  `/login`, `/register`, `/account` (layout with nested routes), `/*` (404)

- [ ] **4.2** Verification: `npm run build` + `npx tsc --noEmit` + visual test at 375px/768px/1280px

- [ ] **4.3** Commit: "Wire up all routes, final integration"

#### Step 5: Console A Returns — API Service Layer

**After Step 4. Enables backend integration (WS-4).**

- [ ] **5.1** API client — `src/services/api/client.ts` (axios, JWT interceptor, sessionId, 401 logout)
- [ ] **5.2** API mappers — `src/services/api/mappers.ts` (snake_case → camelCase)
- [ ] **5.3** Domain services — productApi, cartApi, authApi, orderApi, userApi, wishlistApi, reviewApi, searchApi, checkoutApi
- [ ] **5.4** Data source facade — `src/services/dataSource.ts` (routes to local JSON or API based on `VITE_USE_API`)

**Commit:** "API service layer with data source switching"

#### Step 6: Coordinator — Swap & Cleanup

- [ ] **6.1** Remove old `frontend/` directory
- [ ] **6.2** Update project-level references
- [ ] **6.3** Clean up old worktree branches from remote
- [ ] **6.4** Merge `feature/frontend-upgrade` → `develop`
- [ ] **6.5** Push to remote

---

## WS-3: Admin Panel

**Branch:** `feature/admin-panel` (from `develop`)
**Estimated:** 4-5 days
**Dependencies:** WS-1 complete, WS-2R Step 1+ (shares UI components from gai-ecom)
**Console:** Any (after WS-2R Steps 1-4 complete)

### Tasks

- [ ] **3.1** Admin layout
  - Left sidebar navigation (collapsible)
    - Dashboard, Products, Categories, Orders, Customers, Coupons, Reviews, Analytics, Settings
  - Top bar: Admin name, logout
  - Route guard: Only role=admin can access `/admin/*`
  - Separate layout from storefront (different header/footer)

- [ ] **3.2** Dashboard (`/admin`)
  - Key metric cards (top row): Total Revenue, Orders Today, Active Users, Conversion Rate
  - Recent orders table (last 10)
  - Top selling products (top 5)
  - Revenue chart (last 30 days) — use a simple chart library (recharts)

- [ ] **3.3** Product management (`/admin/products`)
  - Product list: Table with image thumbnail, name, category, price, stock, status, actions
  - Search + filter bar
  - Create product form (`/admin/products/new`):
    - Basic info: Name, slug (auto-generate), description, short_description
    - Category + product type dropdown
    - Pricing: base_price, sale_price
    - Attributes editor: Dynamic form based on category's attribute structure
    - Image upload: Drag & drop, reorder, set primary
    - Variants: Add/remove variants with SKU, price override, stock
    - SEO: Meta title, description, keywords
    - Tags: Tag input
    - Status: Active/Draft toggle
  - Edit product: Same form, pre-populated
  - Delete product: Soft delete with confirmation dialog

- [ ] **3.4** Category management (`/admin/categories`)
  - Category list: Tree view showing parent-child
  - Create/edit form: Name, slug, description, image, parent, display_order
  - Product type management within each category
  - Attribute template management per category

- [ ] **3.5** Order management (`/admin/orders`)
  - Order list: Table with order number, customer, date, total, status, actions
  - Filter by status, date range
  - Order detail view:
    - Customer info
    - Items with product snapshots
    - Addresses
    - Payment info
    - Status update buttons (confirm, process, ship, deliver)
    - Add tracking number
    - Cancel / refund actions

- [ ] **3.6** Customer management (`/admin/customers`)
  - Customer list: Table with name, email, orders count, total spent, joined date
  - Customer detail: Profile, order history, addresses

- [ ] **3.7** Coupon management (`/admin/coupons`)
  - Coupon list with usage stats
  - Create/edit: Code, type, value, min order, max uses, date range

- [ ] **3.8** Review moderation (`/admin/reviews`)
  - Pending reviews queue
  - Approve / reject actions
  - View associated product

- [ ] **3.9** Analytics page (`/admin/analytics`)
  - Revenue chart (daily/weekly/monthly)
  - Orders by status (pie chart)
  - Top products by revenue
  - Top categories
  - Conversion funnel: Visits → Cart → Checkout → Purchase

---

## WS-4: Frontend-Backend Integration

**Branch:** `feature/integration` (from `develop`)
**Estimated:** 3-4 days
**Dependencies:** WS-1 (DONE) + WS-2R Step 5 (API service layer built)
**Console:** Any
**Note:** WS-2R Step 5 creates the API service layer with data source switching (`VITE_USE_API`). WS-4 flips the switch and wires everything to the real backend.

### Tasks

- [ ] **4.1** Enable API mode
  - Set `VITE_USE_API=true` in `.env`
  - Verify API client connects to backend (`http://localhost:8000/api/v1`)
  - Test JWT interceptor with auth store

- [ ] **4.2** Connect product listing
  - Switch dataSource to API for products
  - Wire filter sidebar to API query params
  - Wire sort dropdown + pagination

- [ ] **4.3** Connect product detail
  - Switch to `GET /api/v1/products/{slug}` via dataSource
  - Load reviews from `GET /api/v1/products/{id}/reviews`
  - Load related products

- [ ] **4.4** Connect categories
  - Replace hardcoded nav with `GET /api/v1/categories`
  - Wire category page routing

- [ ] **4.5** Connect cart
  - Wire cartStore to real API endpoints
  - Optimistic updates: Update UI immediately, rollback on API error
  - Cart badge count from API response

- [ ] **4.6** Connect checkout
  - Wire address selection from `GET /api/v1/users/me/addresses`
  - Wire shipping methods from API
  - Wire order placement

- [ ] **4.7** Connect user profile & addresses
  - Wire account pages to real API

- [ ] **4.8** Connect wishlist
  - Wire wishlistStore to real API

- [ ] **4.9** Connect search
  - Wire search bar to `GET /api/v1/search`
  - Wire autocomplete to suggestions endpoint

- [ ] **4.10** Connect admin panel
  - Wire all admin pages to real API endpoints
  - Image upload to real Azure Blob endpoint

- [ ] **4.11** End-to-end flow testing
  - Test: Browse → Filter → View Product → Add to Cart → Checkout → Order History
  - Test: Admin: Create Product → Edit → View on storefront
  - Fix all integration bugs

---

## WS-5: Authentication — Azure AD B2C

**Branch:** `feature/auth-integration` (from `develop`)
**Estimated:** 2-3 days
**Dependencies:** WS-4 complete
**Console:** Any

### Tasks

- [ ] **5.1** Azure AD B2C setup
  - Create B2C tenant (or use existing)
  - Register application
  - Configure user flows: Sign-up, Sign-in, Password reset, Profile edit
  - Configure identity providers: Google, Apple
  - Configure custom attributes if needed

- [ ] **5.2** Backend JWT validation
  - `app/core/security.py`: Validate Azure AD B2C JWT tokens
  - Fetch B2C metadata/JWKS for key verification
  - Extract user claims (email, name, oid)
  - Auto-create user in DB on first login (if not exists)
  - `get_current_user` dependency: Extract + validate token from Authorization header

- [ ] **5.3** Frontend MSAL integration
  - Install `@azure/msal-browser` + `@azure/msal-react`
  - Configure MSAL instance with B2C authority
  - Auth provider wrapping app
  - Login/logout functions in authStore
  - Silent token refresh

- [ ] **5.4** Protected routes
  - Route guard component: Redirect to login if not authenticated
  - Admin route guard: Redirect if not admin role
  - Guest checkout: Allow cart + checkout without login, prompt at payment

- [ ] **5.5** Cart merge on login
  - When anonymous user logs in: merge session cart into user cart
  - Resolve conflicts (same product in both carts: keep higher quantity)

- [ ] **5.6** Phone OTP
  - Configure Azure AD B2C phone authentication
  - Add phone login option to sign-in flow

---

## WS-6: Stripe Payment Integration

**Branch:** `feature/payments-stripe` (from `develop`)
**Estimated:** 2-3 days
**Dependencies:** WS-4 complete
**Console:** Any

### Tasks

- [ ] **6.1** Stripe setup
  - Create Stripe account (or use existing)
  - Get API keys (test mode)
  - Set up webhook endpoint URL

- [ ] **6.2** Backend Stripe integration
  - `app/payments/service.py`:
    - `create_payment_intent(amount, currency, metadata)` — Returns client_secret
    - `handle_webhook(payload, signature)` — Process Stripe events
  - Webhook handler:
    - `payment_intent.succeeded` → Update order status to confirmed, update payment record
    - `payment_intent.payment_failed` → Update order status, notify user
    - `charge.refunded` → Create refund record
  - `POST /api/v1/checkout/create-payment-intent`
  - `POST /api/v1/webhooks/stripe` (webhook receiver)

- [ ] **6.3** Frontend Stripe Elements
  - Install `@stripe/react-stripe-js` + `@stripe/stripe-js`
  - Stripe Provider wrapping checkout
  - PaymentElement component in checkout Step 3
  - Handle payment confirmation flow
  - Show success/failure states

- [ ] **6.4** Complete checkout flow
  - Step 1: Address → Step 2: Shipping → Step 3: Pay (Stripe) → Step 4: Confirm
  - On payment success: Create order via API, show confirmation page
  - On payment failure: Show error, allow retry

- [ ] **6.5** Saved payment methods
  - Create Stripe Customer on first payment
  - Save customer_id to user record
  - List saved payment methods in checkout
  - Allow selecting saved method vs new card

- [ ] **6.6** Apple Pay / Google Pay
  - Stripe Payment Request Button
  - Detect browser capability
  - Show as express checkout option on cart page

- [ ] **6.7** Admin refunds
  - Refund button on admin order detail
  - Call Stripe refund API
  - Create refund record in DB

---

## WS-7: Voice Pipeline & Action Dispatcher

**Branch:** `feature/voice-pipeline` (from `develop`)
**Estimated:** 3-4 days
**Dependencies:** WS-4 complete (needs working frontend with real data)
**Console:** Any

### Reference
- `docs/ARCHITECTURE.md` Section 7 (Action Dispatcher & Voice Pipeline)

### Tasks

- [ ] **7.1** Voice widget component
  - Floating button (bottom-right, above fold)
  - States: idle, listening, processing, speaking
  - Mic button with pulse animation when listening
  - Transcript overlay: Shows recognized text in real-time
  - "Try saying..." hint text when idle
  - Close/minimize button
  - Expandable chat panel (shows conversation history)
  - Permission flow: First-time mic permission request with explanation

- [ ] **7.2** STT engine (Web Speech API)
  - `voice/sttEngine.ts`:
    - Start/stop recording
    - Real-time interim results (shown in transcript)
    - Final result callback
    - Error handling (no mic, permission denied, no speech detected)
    - Language: en-US
    - Auto-stop after silence (configurable timeout)
  - Browser support detection (Chrome/Edge only for Web Speech)
  - Fallback message for unsupported browsers

- [ ] **7.3** TTS engine (Web Speech Synthesis)
  - `voice/ttsEngine.ts`:
    - Speak text with configurable voice, rate, pitch
    - Queue management (don't overlap speech)
    - Stop/cancel current speech
    - Voice selection (list available voices)
  - Preference stored in user preferences

- [ ] **7.4** Mock NLU
  - `voice/mockNlu.ts`:
    - Pattern-matching rules for all 16 intents (see ARCHITECTURE.md Section 7)
    - Slot extraction from natural language
    - Returns `{ intent, slots, response_text, confidence }`
    - Example patterns:
      - "show me|find|search for {query}" → search_product
      - "add (this|it) to (my )cart" → add_to_cart
      - "go to|show (my )cart" → view_cart
      - "sort by {criteria}" → sort_products
      - "filter by|only show {filter}" → filter_products
      - "checkout|place (my )order" → checkout
    - Configurable: `NLU_PROVIDER` env var switches between 'mock' and 'azure_openai'

- [ ] **7.5** Action Dispatcher
  - `voice/actionDispatcher.ts`:
    - Takes intent+slots JSON → executes corresponding actions
    - Uses Zustand stores and React Router for all mutations
    - Maps for each intent:
      - `search_product` → navigate to collection + set filters
      - `filter_products` → update filterStore (additive)
      - `sort_products` → update sort in filterStore
      - `view_product` → navigate to product detail (by name match or index)
      - `add_to_cart` → cartStore.addItem() + success toast + TTS confirmation
      - `remove_from_cart` → cartStore.removeItem()
      - `update_cart_quantity` → cartStore.updateQuantity()
      - `view_cart` → navigate to /cart
      - `apply_coupon` → cartStore.applyCoupon()
      - `checkout` → navigate to /checkout
      - `use_saved_address` → select address by label
      - `place_order` → trigger confirmation first, then submit
      - `track_order` → navigate to order detail
      - `view_orders` → navigate to /account/orders
      - `add_to_wishlist` → wishlistStore.addItem()
      - `view_wishlist` → navigate to /wishlist
      - `navigate` → router.navigate(target)
      - `help` → show voice command overlay

- [ ] **7.6** Dialogue context manager
  - `voice/dialogueContext.ts`:
    - Track: current page, active filters, last N intents, current product
    - Pass context to NLU for multi-turn support
    - Example: User on sofas page says "only blue ones" → knows to filter sofas by blue
    - Context reset on explicit navigation change

- [ ] **7.7** Confirmation flow
  - Before irreversible actions (place_order, cancel_order, clear_cart):
    - TTS: "Are you sure you want to place this order for $134.99?"
    - Wait for "yes"/"no" voice response
    - On "yes": execute action
    - On "no": cancel and TTS "Order cancelled"

- [ ] **7.8** Chat text input fallback
  - Text input field in voice widget panel
  - Typing bypasses STT, goes directly to NLU
  - Same action dispatcher pipeline
  - Always available, even on unsupported browsers

- [ ] **7.9** Azure OpenAI integration stub
  - `voice/azureOpenAiNlu.ts`:
    - HTTP client that calls `POST /api/v1/chat/message`
    - Same input/output contract as mockNlu
    - Feature flag: `VITE_NLU_PROVIDER=mock|azure_openai`
    - When teammate's chatbot is ready: Change env var, done

- [ ] **7.10** Voice command help overlay
  - Accessible from voice widget "?" icon
  - Shows categorized command examples:
    - Shopping: "Show me red sofas under $500"
    - Cart: "Add this to my cart", "What's in my cart?"
    - Navigation: "Go to checkout", "Show my orders"
    - Filters: "Sort by price", "Only show items under $100"

---

## WS-8: Real-Time, Polish & Testing

**Branch:** `feature/realtime-polish` (from `develop`)
**Estimated:** 3-4 days
**Dependencies:** WS-5, WS-6, WS-7 complete
**Console:** Any

### Tasks

- [ ] **8.1** WebSocket hub (backend)
  - `app/realtime/`:
    - FastAPI WebSocket endpoint at `/ws`
    - Connection manager: Track active connections per user
    - Redis pub/sub: Publish events from any API handler, deliver to connected clients
    - Authentication: Validate JWT on WebSocket connect

- [ ] **8.2** WebSocket client (frontend)
  - Auto-connect on auth
  - Reconnect with exponential backoff
  - Event handlers for: cart:updated, order:status_changed, inventory:out_of_stock

- [ ] **8.3** Real-time cart sync
  - When cart changes on one tab, push update to all tabs via WebSocket
  - When cart changes on backend (e.g., stock depleted), notify frontend

- [ ] **8.4** Real-time order status
  - When admin updates order status, push to customer's active connections
  - Show toast notification: "Your order ORD-2026-00001 has shipped!"

- [ ] **8.5** Transactional emails
  - Celery tasks for sending emails:
    - Order confirmation (with order details)
    - Shipping notification (with tracking info)
    - Order delivered
    - Return confirmation
    - Password reset (Azure AD B2C handles this)
    - Welcome email
  - Email templates (HTML)
  - SendGrid or Azure Communication Services integration

- [ ] **8.6** SEO
  - React Helmet for meta tags per page
  - Open Graph tags for social sharing
  - Structured data (JSON-LD) for products (schema.org/Product)
  - Sitemap generation
  - Robots.txt

- [ ] **8.7** Performance optimization
  - Image lazy loading (Intersection Observer)
  - React.lazy + Suspense for route-level code splitting
  - Bundle analysis (vite-plugin-visualizer)
  - Optimize images: WebP format, responsive srcset

- [ ] **8.8** Accessibility
  - Keyboard navigation: All interactive elements reachable via Tab
  - Voice widget: Keyboard shortcut to activate mic (e.g., Ctrl+M)
  - Screen reader: Aria labels on all buttons, images, form fields
  - Color contrast: Verify AA compliance
  - Focus indicators: Visible focus ring on all interactive elements

- [ ] **8.9** Error handling & loading states
  - Error boundaries: Catch React errors, show fallback UI
  - Loading skeletons: For product grid, product detail, cart
  - Empty states: Empty cart, no search results, no orders, empty wishlist
  - 404 page
  - Network error toast: "Connection lost, retrying..."

- [ ] **8.10** End-to-end testing
  - Playwright test suite (NOT automation engine — testing tool):
    - Full purchase flow: Home → Browse → Product → Cart → Checkout → Confirmation
    - Auth flow: Register → Login → Profile
    - Admin flow: Login → Create Product → Manage Orders
    - Voice flow: Activate mic (mock) → Speak command → Verify action
  - Run in CI via GitHub Actions

- [ ] **8.11** Security
  - CORS: Restrict to frontend domain only
  - Rate limiting: 100 req/min per IP on API, 10 req/min on auth endpoints
  - Input sanitization: Escape HTML in all user inputs
  - CSP headers
  - Helmet middleware (security headers)
  - SQL injection: Parameterized queries only (SQLAlchemy handles this)

---

## Verification Console Tasks

The verification/QA console runs after each Step commit during WS-2R.

### After Each Step Commit (WS-2R)
- [ ] TypeScript: `cd gai-ecom && npx tsc --noEmit` passes (no type errors)
- [ ] Build succeeds: `npm run build` (no build errors)
- [ ] No console.log left in production code
- [ ] All pages render without errors at 375px, 768px, 1280px
- [ ] No hardcoded secrets or credentials in code

### After WS-2R Complete
- [ ] Flow: Browse → Product → Cart → Checkout → Confirmation
- [ ] Flow: Login → Wishlist → Account
- [ ] Mobile: Hamburger → Navigate → Product → Cart drawer → Checkout
- [ ] All category Hub pages render correctly
- [ ] Cart operations work (add, remove, update quantity, coupon)

### After WS-4 (Backend Integration)
- [ ] API contracts match: Frontend service calls match backend endpoint signatures
- [ ] Docker Compose starts cleanly (postgres + redis + backend + frontend)
- [ ] Database migrations run without errors
- [ ] Seed data loads correctly
- [ ] Full user flow works end-to-end

---

## Status Tracking

| Workstream | Status | Branch | Assigned To | Notes |
|-----------|--------|--------|-------------|-------|
| WS-0: Setup | DONE | main/develop | — | Monorepo, Docker, CI setup |
| WS-1: Backend | DONE | feature/backend-api (merged) | Console 1 | 42 endpoints, 28 tests, 10 modules |
| WS-2: Frontend (old) | REPLACED | feature/frontend-core (to delete) | — | Superseded by WS-2R |
| **WS-2R: Frontend Upgrade** | **IN PROGRESS** | **feature/frontend-upgrade** | **Consoles A/B/C** | Using gai-ecom as base |
| ↳ Step 0: Setup | Not Started | — | Coordinator | Branch + baseline |
| ↳ Step 1: Types+Stores | Not Started | — | Console A | BLOCKING |
| ↳ Step 2: Pages | Not Started | — | Console B | After Step 1 |
| ↳ Step 3: Mobile+UX | Not Started | — | Console C | After Step 1, parallel with 2 |
| ↳ Step 4: Routing | Not Started | — | Coordinator | After Steps 2+3 |
| ↳ Step 5: API Layer | Not Started | — | Console A | After Step 4 |
| ↳ Step 6: Swap+Cleanup | Not Started | — | Coordinator | After Step 5 |
| WS-3: Admin | Not Started | feature/admin-panel | — | After WS-2R Steps 1-4 |
| WS-4: Integration | Not Started | feature/integration | — | After WS-2R Step 5 |
| WS-5: Auth | Not Started | feature/auth-integration | — | After WS-4 |
| WS-6: Payments | Not Started | feature/payments-stripe | — | After WS-4 |
| WS-7: Voice | Not Started | feature/voice-pipeline | — | After WS-4 |
| WS-8: Polish | Not Started | feature/realtime-polish | — | After WS-5/6/7 |
