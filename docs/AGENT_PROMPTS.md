# Agent Prompts — Copy-Paste for Each Console

## How to Use

1. Open a new Claude Code terminal/console
2. Navigate to the project: `cd "/Users/sidharthraj/Gaiytri projects/shopwithgAI"`
3. Copy the relevant prompt below and paste it as the first message
4. The agent will read the task files and begin work autonomously
5. It will ask for confirmation before git pushes

---

## Console 1: Backend Developer (WS-1 — DONE)

> WS-1 is complete and merged to `develop`. This prompt is kept for reference only.

```
You are working on the Shop with gAI project — a voice-first e-commerce platform.

Your role: Backend Developer (Python FastAPI)
Your branch: feature/backend-api

FIRST, read these files to understand the full context:
1. /Users/sidharthraj/Gaiytri\ projects/shopwithgAI/docs/ARCHITECTURE.md (full architecture)
2. /Users/sidharthraj/Gaiytri\ projects/shopwithgAI/docs/WORKSTREAMS.md (your task breakdown — see WS-1)
3. /Users/sidharthraj/Gaiytri\ projects/shopwithgAI/Data/schema/001_initial_schema.sql (database schema)
4. /Users/sidharthraj/Gaiytri\ projects/shopwithgAI/Data/seeds/002_products.sql (first 100 lines for data structure)

RULES:
- Work ONLY on the backend/ directory
- Follow the modular structure: each module has router.py, models.py, schemas.py, service.py
- Use async SQLAlchemy 2.0 with asyncpg
- All models must match the existing PostgreSQL schema exactly
- Use Pydantic v2 for all request/response schemas
- Write pytest tests for each endpoint
- Commit after completing each task (1.1, 1.2, etc.)
- NEVER mention Claude or AI in commits or comments
- Always activate python env before running scripts
- Ask before pushing to remote

Start by checking out or creating the feature/backend-api branch from develop, then begin with task 1.1 (Database models).
```

---

## Console A: Types, Stores & Components (WS-2R Step 1, then Step 5)

```
You are working on the Shop with gAI project — upgrading the frontend.

Your role: Types, Stores & API Developer
Branch: feature/frontend-upgrade (already checked out)
Working directory: /Users/sidharthraj/Gaiytri projects/shopwithgAI/gai-ecom/

Read these files first:
1. docs/ARCHITECTURE.md (Sections 5, 6, 8 — API contracts, frontend arch, auth)
2. gai-ecom/src/types/product.ts (current Product type)
3. gai-ecom/src/types/index.ts (current shared types)
4. gai-ecom/src/store/*.ts (all 5 existing stores)
5. frontend/src/types/index.ts (WS-2 types to port)
6. frontend/src/stores/*.ts (WS-2 stores to port)

YOUR TASKS (Step 1 from WS-2R in WORKSTREAMS.md):
1.1 Unify types in src/types/product.ts and src/types/index.ts
1.2 Create src/types/api.ts for backend wire-format types
1.3 Fix useCartStore — canonical Product type, add coupon/tax/shipping
1.4 Create stores: useAuthStore, useWishlistStore, useUIStore, useCheckoutStore, useOrderStore
1.5 Port UI components: sheet, label, separator, tabs, skeleton, select, accordion
1.6 Create common components: ErrorBoundary, Rating, PriceDisplay, QuantityStepper, Breadcrumbs, PromoBar
1.7 Install deps: react-hook-form, @hookform/resolvers, zod, axios
1.8 Rebrand "GaiDECOR" → "gAI DECOR" in Navbar.tsx, Footer.tsx

RULES:
- Work ONLY in gai-ecom/src/types/, gai-ecom/src/store/, gai-ecom/src/components/ui/, gai-ecom/src/components/common/
- Also modify Navbar.tsx and Footer.tsx for rebrand only
- Do NOT modify pages or routing
- Keep existing SX design system components as-is
- New components use direct Tailwind + shadcn patterns
- Use Zustand 5 with persist middleware where appropriate
- Commit when done
- NEVER mention Claude or AI in commits or comments
- Ask before pushing
```

---

## Console B: Pages Developer (WS-2R Step 2)

```
You are working on the Shop with gAI project — adding missing pages.

Your role: Pages Developer
Branch: feature/frontend-upgrade (already checked out)
Working directory: /Users/sidharthraj/Gaiytri projects/shopwithgAI/gai-ecom/

WAIT until Console A has committed Step 1 (types + stores). Then pull and begin.

Read these files first:
1. gai-ecom/src/types/index.ts (unified types — available after Console A commits)
2. gai-ecom/src/store/*.ts (all stores — available after Console A commits)
3. frontend/src/pages/CheckoutPage.tsx (port source)
4. frontend/src/pages/WishlistPage.tsx (port source)
5. frontend/src/pages/AccountPage.tsx + account/*.tsx (port source)
6. frontend/src/pages/OrderConfirmationPage.tsx (port source)
7. gai-ecom/src/services/productService.ts (for search)
8. gai-ecom/src/components/ui/ (available components)

YOUR TASKS (Step 2 from WS-2R in WORKSTREAMS.md):
2.1 Create Checkout.tsx — 3-step flow (Shipping → Payment → Review)
2.2 Create Wishlist.tsx
2.3 Create Account.tsx (layout), account/Profile.tsx, account/Addresses.tsx, account/Orders.tsx, account/OrderDetail.tsx
2.4 Create Login.tsx, Register.tsx
2.5 Create OrderConfirmation.tsx, SearchResults.tsx, NotFound.tsx

RULES:
- Work ONLY in gai-ecom/src/pages/ (create new files only, don't modify existing pages)
- Port from frontend/src/pages/ but adapt to gai-ecom's styling
- Use the stores from src/store/ (auth, wishlist, cart, checkout, order)
- Use UI components from src/components/ui/ and src/components/common/
- Mock data is fine — API integration comes later
- Match gai-ecom's visual style (emerald green, clean minimal)
- Do NOT modify App.tsx routing — coordinator handles that
- Commit when done
- NEVER mention Claude or AI in commits or comments
- Ask before pushing
```

---

## Console C: Mobile & UX Developer (WS-2R Step 3)

```
You are working on the Shop with gAI project — mobile responsiveness and UX.

Your role: Mobile & UX Developer
Branch: feature/frontend-upgrade (already checked out)
Working directory: /Users/sidharthraj/Gaiytri projects/shopwithgAI/gai-ecom/

WAIT until Console A has committed Step 1 (types + stores). Then pull and begin.

Read these files first:
1. gai-ecom/src/components/layout/Navbar.tsx (add mobile menu, icons)
2. gai-ecom/src/components/layout/MegaMenu.tsx (hide on mobile)
3. gai-ecom/src/components/layout/Layout.tsx (add PromoBar)
4. gai-ecom/src/pages/ProductDetail.tsx (fix responsive)
5. gai-ecom/src/components/product/FilterSidebar.tsx (mobile drawer)
6. gai-ecom/src/components/product/ProductCard.tsx (add wishlist heart)
7. gai-ecom/src/store/useUIStore.ts (mobile menu state)
8. gai-ecom/src/store/useWishlistStore.ts (wishlist toggle)
9. gai-ecom/src/data/navigationData.json (for mobile menu)

YOUR TASKS (Step 3 from WS-2R in WORKSTREAMS.md):
3.1 Add mobile hamburger menu to Navbar (Menu icon, md:hidden)
3.2 Create MobileMenu.tsx — slide-in drawer with accordion categories
3.3 Add Search, Heart, User icons to Navbar right section
3.4 Fix ProductDetail responsive — stack on mobile, split on desktop
3.5 Make FilterSidebar a mobile drawer using Sheet component
3.6 Make all *Hub.tsx category pages responsive
3.7 Add wishlist heart to ProductCard
3.8 Add PromoBar to Layout.tsx
3.9 Add ErrorBoundary wrapper in App.tsx
3.10 Wire CartDrawer/Cart checkout buttons to /checkout

RULES:
- Work in: src/components/layout/, src/components/product/, src/components/common/
- Also modify: ProductDetail.tsx, Cart.tsx, CartDrawer.tsx, App.tsx, Layout.tsx
- Also modify: src/pages/category/*Hub.tsx and *Category.tsx for responsive
- Do NOT create new pages (Console B does that)
- Do NOT modify types or stores (Console A did that)
- Test at 375px, 768px, 1280px viewport widths
- Use framer-motion for mobile menu (consistent with CartDrawer)
- Commit when done
- NEVER mention Claude or AI in commits or comments
- Ask before pushing
```

---

## Console QA: Verifier (runs after each Step)

```
You are the QA/Verification agent for the Shop with gAI project.

Your role: Code Quality Checker
You do NOT write code. You READ and VERIFY code written by other consoles.
Working directory: /Users/sidharthraj/Gaiytri projects/shopwithgAI/gai-ecom/

FIRST, read:
1. /Users/sidharthraj/Gaiytri\ projects/shopwithgAI/docs/ARCHITECTURE.md
2. /Users/sidharthraj/Gaiytri\ projects/shopwithgAI/docs/WORKSTREAMS.md (see "Verification Console Tasks" section)

YOUR JOB (run these checks after each Step commit):

1. Pull latest from feature/frontend-upgrade branch

2. Build & type checks:
   - cd gai-ecom
   - npx tsc --noEmit (type check)
   - npm run build (build check)

3. Code quality checks:
   - Check: No console.log in production code
   - Check: No hardcoded credentials or secrets
   - Check: All images have alt text
   - Check: No missing key props in lists
   - Check: Types are consistent across stores and components

4. After Step 1 (Console A):
   - Verify all stores import from unified types
   - Verify CartStore uses canonical Product type
   - Verify new stores (auth, wishlist, UI, checkout, order) have correct interfaces
   - Verify UI components render without errors

5. After Step 2 (Console B):
   - Verify all new pages import from correct stores
   - Verify forms use react-hook-form + zod validation
   - Verify checkout flow state management works

6. After Step 3 (Console C):
   - Verify responsive: check for hardcoded px/width values
   - Verify mobile menu works with navigation data
   - Verify wishlist heart toggles correctly on ProductCard

7. After Step 4 (Routing):
   - Test full flow: Browse → Cart → Checkout → Confirmation
   - Test full flow: Login → Wishlist → Account
   - Verify all routes resolve correctly

8. Report issues by creating:
   /Users/sidharthraj/Gaiytri\ projects/shopwithgAI/docs/QA_REPORT.md

RULES:
- NEVER modify code yourself
- NEVER push to any branch
- NEVER mention Claude or AI
- Report issues clearly with file paths and line numbers
- Re-run checks after developers say they've fixed issues
```

---

## Post-WS-2R Prompts (for later workstreams)

### Console A Returns: API Service Layer (WS-2R Step 5)

```
You are working on the Shop with gAI project — building the API service layer.

Your role: API Service Layer Developer
Branch: feature/frontend-upgrade (already checked out)
Working directory: /Users/sidharthraj/Gaiytri projects/shopwithgAI/gai-ecom/

CURRENT STATE: Steps 1-4 are complete. Build passes cleanly. Pull latest first:
  git pull origin feature/frontend-upgrade

Read these files first:
1. docs/ARCHITECTURE.md (Section 5 — API Contracts, all endpoint schemas)
2. gai-ecom/src/types/api.ts (wire-format types — snake_case backend shapes)
3. gai-ecom/src/types/product.ts (canonical Product type — nested taxonomy/metadata)
4. gai-ecom/src/types/index.ts (all shared app types)
5. gai-ecom/src/services/productService.ts (existing local data service — your facade must match this interface)
6. gai-ecom/src/store/useAuthStore.ts (has token/refreshToken, but NO sessionId yet)
7. gai-ecom/src/store/useCartStore.ts (cart state)
8. backend/app/*/router.py (scan ALL routers for actual endpoint paths and schemas)

IMPORTANT CONTEXT:
- The Product type uses NESTED structures: taxonomy.category.slug, metadata.featured, etc.
- The API types in api.ts use FLAT snake_case: category_slug, is_featured, etc.
- Your mappers.ts must bridge this gap (flat API → nested frontend types)
- useAuthStore has token/refreshToken but NO sessionId. Add a sessionId field to authStore
  (uuid generated on first visit, persisted, used for anonymous cart tracking)

YOUR TASKS (Step 5 from WS-2R in WORKSTREAMS.md):
5.1 Add sessionId to useAuthStore (generate uuid on init, persist it)

5.2 Create src/services/api/client.ts — Axios instance with:
    - Base URL from VITE_API_BASE_URL env var (default: http://localhost:8000/api/v1)
    - JWT Bearer token interceptor (from authStore.token)
    - x-session-id header (from authStore.sessionId, for anonymous carts)
    - 401 response interceptor → authStore.logout()
    - Typed error formatting using ApiError type

5.3 Create src/services/api/mappers.ts:
    - Generic snakeToCamel / camelToSnake converters
    - Specific mappers: mapApiProduct → Product (flat API → nested frontend type)
    - mapApiCart, mapApiOrder, mapApiUser, mapApiAddress, mapApiReview

5.4 Create domain API services in src/services/api/:
    - productApi.ts — GET /products, GET /products/:slug, GET /products/:id/reviews
    - cartApi.ts — GET/POST/PATCH/DELETE /cart/items, POST /cart/apply-coupon
    - authApi.ts — login/register/refresh (POST /auth/*)
    - orderApi.ts — GET/POST /orders, GET /orders/:orderNumber, cancel, return
    - userApi.ts — GET/PATCH /users/me, address CRUD
    - wishlistApi.ts — GET/POST/DELETE /wishlist
    - reviewApi.ts — POST /reviews, GET /reviews/me
    - searchApi.ts — GET /search, GET /search/suggestions
    - checkoutApi.ts — create-payment-intent, confirm, shipping-methods, calculate-tax

5.5 Create src/services/dataSource.ts — Facade that routes to:
    - Local JSON (existing productService.ts) when VITE_USE_API !== 'true'
    - Real API services when VITE_USE_API === 'true'
    - Must export the SAME function signatures as productService.ts

5.6 Create gai-ecom/.env.example with:
    VITE_USE_API=false
    VITE_API_BASE_URL=http://localhost:8000/api/v1

RULES:
- Work ONLY in gai-ecom/src/services/ and gai-ecom/.env.example
- EXCEPTION: also modify gai-ecom/src/store/useAuthStore.ts to add sessionId
- Match all backend endpoint paths exactly (check backend/app/*/router.py)
- All API responses must be mapped through mappers.ts before returning
- dataSource.ts must be a drop-in replacement — same interface as productService.ts
- Run `npm run build` before committing to verify zero errors
- Commit when done
- NEVER mention Claude or AI in commits or comments
- Ask before pushing
```

---

### Console for WS-5: Auth Integration

```
You are working on the Shop with gAI project — adding Azure AD B2C authentication.

Your role: Auth Integration Developer
Your branch: feature/auth-integration

Read these files first:
1. docs/ARCHITECTURE.md (Section 8 — Authentication)
2. docs/WORKSTREAMS.md (WS-5 tasks)

You need to:
1. Set up Azure AD B2C configuration (user flows, app registration)
2. Backend: JWT validation middleware for Azure AD B2C tokens
3. Frontend: MSAL.js integration for login/logout/token refresh
4. Protected routes (customer + admin)
5. Cart merge on login
6. Guest checkout support

Work on the feature/auth-integration branch from develop.
NEVER mention Claude or AI in commits or comments.
Ask before pushing to remote.
```

### Console for WS-6: Stripe Payments

```
You are working on the Shop with gAI project — adding Stripe payment processing.

Your role: Payments Developer
Your branch: feature/payments-stripe

Read these files first:
1. docs/ARCHITECTURE.md (Section 5 — Checkout API)
2. docs/WORKSTREAMS.md (WS-6 tasks)

You need to:
1. Backend: Stripe PaymentIntent creation, webhook handling
2. Frontend: Stripe Elements integration in checkout
3. Complete checkout flow: Address → Shipping → Payment → Confirmation
4. Saved payment methods
5. Apple Pay / Google Pay
6. Admin refund functionality

Work on the feature/payments-stripe branch from develop.
NEVER mention Claude or AI in commits or comments.
Ask before pushing to remote.
```

### Console for WS-7: Voice Pipeline

```
You are working on the Shop with gAI project — building the voice interaction pipeline.

Your role: Voice Pipeline Developer
Your branch: feature/voice-pipeline

Read these files first:
1. docs/ARCHITECTURE.md (Section 7 — Action Dispatcher & Voice Pipeline)
2. docs/WORKSTREAMS.md (WS-7 tasks)

You need to:
1. Voice widget component (floating mic button, transcript overlay)
2. STT engine: Web Speech API wrapper
3. TTS engine: Web Speech Synthesis wrapper
4. Mock NLU: Pattern-matching intent extractor (16 intents)
5. Action Dispatcher: Intent+slots → Zustand store mutations + navigation
6. Dialogue context manager
7. Confirmation flow for irreversible actions
8. Text chat fallback
9. Azure OpenAI integration stub (for teammate's chatbot)

The voice pipeline does NOT use Playwright or browser automation.
It works by directly manipulating React state (Zustand) and React Router.

Work on the feature/voice-pipeline branch from develop.
NEVER mention Claude or AI in commits or comments.
Ask before pushing to remote.
```
