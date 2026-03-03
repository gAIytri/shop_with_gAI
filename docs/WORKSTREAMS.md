# Shop with gAI - Implementation Workstreams & Task Breakdown

## How to Use This File

This file is the **single source of truth** for all implementation tasks. Each workstream is self-contained with enough detail for any developer or agent to pick it up independently.

### Console Strategy

| Console | Role | Branch | What It Does |
|---------|------|--------|-------------|
| Console 1 | Backend Developer | `feature/backend-api` | WS-1: All backend API work |
| Console 2 | Frontend Developer | `feature/frontend-core` | WS-2: All frontend UI work |
| Console 3 | Verifier/QA | Reads all branches | Continuously checks code quality, tests, type errors |

### Rules for All Consoles
1. Always read this file + `docs/ARCHITECTURE.md` before starting work
2. Work ONLY on your assigned branch
3. Never push directly to `main` — all work goes through PRs
4. After completing a task, update the checkbox in this file: `[ ]` → `[x]`
5. Commit frequently with descriptive messages
6. If blocked, document the blocker in a comment and move to the next task

---

## Dependency Graph

```
WS-0 (Setup) ──────────────────────────────── MUST BE FIRST
    │
    ├──→ WS-1 (Backend API) ──────┐
    │                              ├──→ WS-4 (Integration) ──┬──→ WS-5 (Auth)
    └──→ WS-2 (Frontend UI) ─────┘                          ├──→ WS-6 (Payments)
              │                                               ├──→ WS-7 (Voice)
              └──→ WS-3 (Admin Panel) ─────────────────────→│
                                                              └──→ WS-8 (Polish)
```

**Parallel Groups:**
- Group A (after WS-0): WS-1 + WS-2 run in parallel
- Group B (after WS-4): WS-5 + WS-6 + WS-7 run in parallel
- Sequential: WS-0 → Group A → WS-3 + WS-4 → Group B → WS-8

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

## WS-2: Frontend - UI Shell & Components

**Branch:** `feature/frontend-core` (from `develop`)
**Estimated:** 5-7 days
**Dependencies:** WS-0 complete
**Console:** Console 2 (Frontend Developer)

### Reference Files
- `docs/ARCHITECTURE.md` Section 6 (Frontend Architecture), Section 14 (Design System)
- Screenshots in project root (Jonathan Y reference design)

### Important Note
Use **mock data** for all pages. Do NOT connect to the real API yet (that's WS-4). Create mock data files that match the API response schemas from ARCHITECTURE.md Section 5.

### Tasks

#### Design System Setup
- [ ] **2.1** Tailwind config with design tokens
  ```
  Colors: primary #1B1B3A, background #FFFFFF, surface #F9F9F9, etc.
  Fonts: Playfair Display (display), Inter (body)
  Spacing, shadows, breakpoints per ARCHITECTURE.md Section 14
  ```
  - Import Google Fonts
  - Configure shadcn/ui theme to match

- [ ] **2.2** Base UI primitives (via shadcn/ui + custom)
  - Install shadcn components: Button, Input, Select, Dialog, Sheet, Accordion, Tabs, Badge, Separator, Skeleton, Toast, Dropdown Menu, Checkbox, Slider, Label, Card
  - Custom components:
    - `Rating` — Star rating display (filled/empty, 1-5, shows count)
    - `PriceDisplay` — Formats price with currency, sale price strikethrough
    - `QuantityStepper` — [-] count [+] control
    - `Breadcrumbs` — From route path
    - `PromoBar` — Top banner ("FREE SHIPPING ON ALL ORDERS")

#### Layout Components
- [ ] **2.3** Layout shell
  - `Header` — Sticky, full-width
    - Logo (left): Serif font "SHOP WITH gAI"
    - Navigation (center): Dynamic category links (hardcoded from mock data for now)
    - Icons (right): Search, Account, Cart (with badge count)
    - Mobile: Hamburger menu → slide-out sheet
  - `Footer`
    - Newsletter signup bar (email input + SUBSCRIBE button)
    - Link columns: Shop, About, Help, Legal
    - Social icons
    - Copyright
  - `PageLayout` — Wraps Header + content + Footer
  - `Container` — Max-width 1440px centered wrapper

#### Pages
- [ ] **2.4** HomePage
  - Hero carousel (full-width, 3-4 slides, auto-rotate, pause on hover)
    - Each slide: lifestyle image + overlay text + CTA button
  - Category grid (3-column on desktop, 2 on tablet, 1 on mobile)
    - Each card: lifestyle image + category name overlay/below
    - Links to `/category/{slug}`
  - "TRENDING" section
    - Horizontal scroll on mobile, 5-col grid on desktop
    - Product cards (image, name, price, rating)
  - Featured collection banner (full-width lifestyle image)
  - "NEW ARRIVALS" section (4-col product grid)
  - Use mock data for all products

- [ ] **2.5** CollectionPage (`/category/:slug`)
  - Breadcrumbs: Home > {Category Name}
  - Category title + product count
  - **Filter sidebar** (left, 240px width on desktop, slide-out on mobile)
    - Collapsible accordion sections
    - For MVP, hardcode filter sections matching seed data:
      - Color (checkbox list with color swatches)
      - Material (checkbox list)
      - Style (checkbox list)
      - Price Range (range slider or min/max inputs)
      - Room (checkbox list)
    - "Clear All Filters" button
    - NOTE: In future (WS-4), filters auto-generate from attribute_templates API
  - **Product grid** (right)
    - Sort dropdown: "Best Selling", "Price: Low to High", "Price: High to Low", "Newest", "Top Rated"
    - 4-col grid (desktop), 3-col (tablet), 2-col (mobile)
    - Product cards matching Jonathan Y style:
      - Product image (hover: show second image if available)
      - Product name (truncated to 2 lines)
      - Price (sale price + original price strikethrough)
      - Star rating + review count
    - Pagination or "Load More" button
  - Filter state stored in Zustand `filterStore`
  - URL query params sync with filter state

- [ ] **2.6** ProductDetailPage (`/product/:slug`)
  - Breadcrumbs: Home > {Category} > {Product Name}
  - **Left column (60%)**:
    - Large main image (zoomable on hover or click)
    - Thumbnail strip below (5-6 images, click to swap main)
  - **Right column (40%)**:
    - Product name (H1)
    - Price: `$43.99` (sale shows original strikethrough)
    - Rating: ★★★★★ 4.6 (63 reviews) — clickable to scroll to reviews
    - Color selector: swatch buttons with active state
    - Size/variant selector: button grid (like Jonathan Y: tab groups for shape, then size buttons)
    - "YOU MAY ALSO NEED" cross-sell section (checkbox + price + details link)
    - Installment payment info text
    - Quantity stepper + "ADD TO BAG" button (navy, full-width)
  - **Below** (full-width):
    - Collapsible accordion sections:
      - DESCRIPTION (product long description)
      - SHIPPING & RETURNS (static text)
      - DETAILS & DIMENSIONS (from attributes)
    - Customer reviews section:
      - Average rating summary
      - "Write a Review" button
      - Review list (paginated)
  - **"YOU MAY ALSO LIKE"** section (4-col product grid)
  - Mobile: Single column, image gallery becomes horizontal swipe

- [ ] **2.7** CartPage (`/cart`)
  - **Left column (65%)**:
    - "CART ({count})" heading
    - Cart item list:
      - Product image (small)
      - Product name
      - Options: Color, Size, Shape
      - Price
      - Quantity stepper [-] count [+]
      - "Remove" link
    - "YOU MAY ALSO NEED" cross-sell section below
  - **Right column (35%)**:
    - "ORDER SUMMARY" card
      - Subtotal
      - Shipping: "Free" or calculated
      - Tax: "calculated at checkout"
      - Discount code: input + "APPLY" button
      - Total (bold, large)
      - "CHECKOUT" button (navy, full-width)
      - Payment icons row: Apple Pay, PayPal, Google Pay
  - Empty cart state: Illustration + "Your cart is empty" + "Continue Shopping" button
  - Cart state from Zustand `cartStore`

- [ ] **2.8** CheckoutPage (`/checkout`)
  - Multi-step form:
    - Step 1: Shipping Address (form fields OR select saved address)
    - Step 2: Shipping Method (radio buttons: Standard/Express/Free)
    - Step 3: Payment (Stripe Elements placeholder — just the UI for now)
    - Step 4: Review Order (summary of all selections)
  - Order summary sidebar (sticky on desktop)
  - Progress indicator (steps 1-4)
  - Form validation with React Hook Form + Zod
  - Mobile: Steps as full-width sections (no sidebar)

- [ ] **2.9** OrderConfirmationPage (`/order-confirmation/:orderNumber`)
  - Success checkmark animation
  - "Thank you for your order!"
  - Order number
  - Order summary
  - "Continue Shopping" button
  - "Track Order" link

- [ ] **2.10** Account pages
  - `/account` — Profile overview (name, email, phone, edit button)
  - `/account/addresses` — Address list + add/edit/delete
  - `/account/orders` — Order history list (order number, date, status, total)
  - `/account/orders/:orderNumber` — Order detail (items, tracking, status timeline)
  - Protected routes (redirect to login if not authenticated)

- [ ] **2.11** WishlistPage (`/wishlist`)
  - Product grid (same cards as collection page)
  - "Add to Cart" button on each card
  - "Remove" button on each card
  - Empty state

#### State Management
- [ ] **2.12** Zustand stores
  - `cartStore` — items, addItem, removeItem, updateQuantity, clearCart, coupon, totals
  - `authStore` — user, isAuthenticated, login, logout, token
  - `productStore` — currentProduct, relatedProducts
  - `filterStore` — activeFilters, setFilter, clearFilters, sort, page
  - `uiStore` — isMobileMenuOpen, isCartDrawerOpen, toasts, searchOpen
  - `wishlistStore` — items, addItem, removeItem, isInWishlist

#### Mock Data
- [ ] **2.13** Create mock data files
  - `src/mocks/products.ts` — 20 products matching seed data structure
  - `src/mocks/categories.ts` — 6 categories with product types
  - `src/mocks/cart.ts` — Sample cart with 2-3 items
  - `src/mocks/orders.ts` — Sample order history
  - `src/mocks/user.ts` — Sample user profile with addresses

#### Responsive Design
- [ ] **2.14** Mobile responsive for ALL pages
  - Test at: 375px (iPhone), 768px (iPad), 1024px (laptop), 1440px (desktop)
  - Mobile nav: Hamburger → slide-out sheet with categories
  - Filter sidebar: Slide-out drawer on mobile
  - Product grid: 2-col on mobile
  - Cart: Stack columns vertically on mobile

---

## WS-3: Admin Panel

**Branch:** `feature/admin-panel` (from `develop`)
**Estimated:** 4-5 days
**Dependencies:** WS-1 partially complete (needs API endpoints), WS-2 (shares UI components)
**Console:** Console 1 or 2 (whoever finishes first picks this up)

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
**Dependencies:** WS-1 + WS-2 substantially complete
**Console:** Any

### Tasks

- [ ] **4.1** API client setup
  - `frontend/src/services/api.ts`:
    - Axios instance with base URL from env
    - Request interceptor: Attach Bearer token from authStore
    - Response interceptor: Handle 401 (redirect to login), 403, 500
    - Error formatting
  - Create typed service functions for each API endpoint group

- [ ] **4.2** Connect product listing
  - Replace mock data in CollectionPage with real `GET /api/v1/products`
  - Wire filter sidebar to API query params
  - Wire sort dropdown
  - Wire pagination

- [ ] **4.3** Connect product detail
  - Replace mock data in ProductDetailPage with real `GET /api/v1/products/{slug}`
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

The verification/QA console runs continuously and checks:

### After Each Commit
- [ ] TypeScript: `tsc --noEmit` passes (no type errors)
- [ ] ESLint: No errors (warnings OK)
- [ ] Backend lint: `ruff check` passes
- [ ] Backend types: `mypy` passes (or acceptable errors)
- [ ] All tests pass: `pytest` (backend), `vitest` (frontend if added)
- [ ] Build succeeds: `vite build` (no build errors)

### After Each Workstream
- [ ] API contracts match: Frontend service calls match backend endpoint signatures
- [ ] No hardcoded secrets or credentials in code
- [ ] No console.log left in production code (except intentional debug mode)
- [ ] All pages render without errors
- [ ] Mobile responsive check at 375px width
- [ ] Accessibility: No missing alt text, aria labels on buttons

### Integration Checks
- [ ] Docker Compose starts cleanly (postgres + redis + backend + frontend)
- [ ] Database migrations run without errors
- [ ] Seed data loads correctly
- [ ] Full user flow works end-to-end

---

## Status Tracking

| Workstream | Status | Branch | Assigned To | Started | Completed |
|-----------|--------|--------|-------------|---------|-----------|
| WS-0: Setup | Not Started | main/develop | — | — | — |
| WS-1: Backend | Not Started | feature/backend-api | Console 1 | — | — |
| WS-2: Frontend | Not Started | feature/frontend-core | Console 2 | — | — |
| WS-3: Admin | Not Started | feature/admin-panel | — | — | — |
| WS-4: Integration | Not Started | feature/integration | — | — | — |
| WS-5: Auth | Not Started | feature/auth-integration | — | — | — |
| WS-6: Payments | Not Started | feature/payments-stripe | — | — | — |
| WS-7: Voice | Not Started | feature/voice-pipeline | — | — | — |
| WS-8: Polish | Not Started | feature/realtime-polish | — | — | — |
