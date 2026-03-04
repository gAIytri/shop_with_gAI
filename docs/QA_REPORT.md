# QA Report — Shop with gAI

**Date:** 2026-03-03
**Scope:** WS-1 (Backend API) + WS-2 (Frontend UI)
**Branches checked:** `feature/backend-api`, `feature/frontend-core`

---

## Executive Summary

| Area | Status |
|------|--------|
| Backend pytest (28 tests) | **ALL PASS** |
| Backend ruff | **FAIL** — 55 errors (unused imports, unsorted imports, line length) |
| Backend mypy | **FAIL** — 38 errors (cross-module name resolution, type mismatches) |
| Frontend tsc --noEmit | **PASS** |
| Frontend ESLint | **FAIL** — 3 errors (react-refresh/only-export-components) |
| Frontend vite build | **PASS** (warning: Node.js 20.11.0, Vite wants 20.19+) |

---

## 1. Backend — Linting Results

### 1.1 Ruff (55 errors)

**Unused imports (F401) — 14 occurrences:**

| File | Line | Unused Import |
|------|------|--------------|
| `app/admin/models.py` | 5 | `sqlalchemy.Enum` |
| `app/cart/models.py` | 6 | `sqlalchemy.Boolean` |
| `app/cart/service.py` | 12 | `app.coupons.models.Promotion` |
| `app/categories/service.py` | 6 | `app.categories.models.ProductType` |
| `app/orders/models.py` | 7 | `sqlalchemy.Boolean` |
| `app/orders/service.py` | 3 | `decimal.Decimal` |
| `app/products/models.py` | 6 | `sqlalchemy.Boolean` |
| `app/users/schemas.py` | 2 | `decimal.Decimal` |
| `app/users/schemas.py` | 5 | `pydantic.EmailStr` |
| `tests/conftest.py` | 21 | `sqlalchemy.dialects.postgresql.UUID` (as PG_UUID) |
| `tests/conftest.py` | 22 | `sqlalchemy.JSON`, `sqlalchemy.String`, `sqlalchemy.Text` |

**Unsorted imports (I001) — 5 files:**
- `app/admin/models.py:1`
- `app/categories/router.py:1`
- `app/orders/service.py:1`
- `app/products/schemas.py:1`
- `tests/conftest.py:1`

**Line too long (E501) — 6 occurrences:**
- `app/cart/service.py:26` (109 chars)
- `app/cart/service.py:329` (102 chars)
- `app/orders/models.py:94` (111 chars)
- `app/orders/service.py:109` (102 chars)
- `app/products/models.py:96` (119 chars)
- `app/users/models.py:101` (119 chars)

**Undefined names (F821) — 19 occurrences:**
These are cross-module SQLAlchemy relationship string references (e.g., `Mapped["Product"]` in `cart/models.py`). Ruff flags them because the referenced model isn't imported in that file — SQLAlchemy resolves them at runtime via the registry. These are false positives for the ORM pattern used, but should be suppressed with `# noqa: F821` or by adding `TYPE_CHECKING` imports.

**Fix:** Run `ruff check --fix` for auto-fixable issues (unused imports, import sorting). Add `# noqa: F821` to relationship annotations.

### 1.2 Mypy (38 errors)

**Cross-module name resolution (19 errors):**
Same root cause as ruff F821 — relationship string annotations. Fix with `from __future__ import annotations` or `TYPE_CHECKING` imports in each models.py.

**Real type errors (5):**

| File | Line | Error | Fix |
|------|------|-------|-----|
| `app/products/schemas.py` | 148 | `Invalid base class` — `ProductSortField` uses `__import__("enum")` | Use normal `import enum` at top |
| `app/products/service.py` | 30 | `sort` default is `str` but type is `ProductSortField` | Use `ProductSortField("newest")` as default |
| `app/products/service.py` | 96 | `order_by` arg type incompatible | Add type annotation to sort_map values |
| `app/orders/service.py` | 53 | `Address | None` assigned to `Address` | Change variable type to `Address | None` |
| `app/orders/service.py` | 106 | `dict` assigned to `str | None` | Fix product_snapshot type annotation |
| `app/checkout/router.py` | 43 | `Decimal | int` passed where `Decimal` expected | Wrap with `Decimal()` |

**`app/main.py` shadowing (14 errors):**
Variable `app` shadows the module import `from app.main import app`. Mypy sees `app` as a module after the initial import. Fix by renaming the FastAPI instance (e.g., `application = FastAPI(...)` or restructure imports).

### 1.3 Pytest (28 tests — ALL PASS)

```
tests/test_health.py       1 passed
tests/test_products.py      7 passed
tests/test_categories.py    4 passed
tests/test_cart.py          7 passed
tests/test_users.py         4 passed
tests/test_wishlist.py      5 passed
```

**Warnings:** 153 `DeprecationWarning` for `datetime.utcnow()` — deprecated in Python 3.12+.

**Missing test coverage:**
- No tests for: orders, reviews, search, checkout, coupons
- No tests for admin endpoints (WS-3, expected)

---

## 2. Backend — Schema Verification

### 2.1 SQLAlchemy Models vs SQL Schema (001_initial_schema.sql)

**Extra models (no SQL table exists yet):**

| Model | File | Note |
|-------|------|------|
| `AttributeTemplate` | `app/admin/models.py:22-47` | Planned schema addition — needs migration |
| `ShippingMethod` | `app/admin/models.py:50-66` | Planned schema addition — needs migration |

**Column type annotation mismatches (JSONB arrays annotated as `dict` instead of `list`):**

| Table | Column | SQL Default | Python Type | File:Line |
|-------|--------|-------------|-------------|-----------|
| `products` | `tags` | `'[]'` | `dict | None` | `products/models.py:68` |
| `categories` | `synonyms` | `'[]'` | `dict | None` | `categories/models.py:34` |
| `product_types` | `synonyms` | `'[]'` | `dict | None` | `categories/models.py:67` |
| `users` | `preferred_styles` | `'[]'` | `dict | None` | `users/models.py:72` |
| `users` | `preferred_rooms` | `'[]'` | `dict | None` | `users/models.py:73` |
| `users` | `preferred_colors` | `'[]'` | `dict | None` | `users/models.py:74` |
| `navigation_menus` | `columns` | `'[]'` | `dict | None` | `admin/models.py:79` |

**Nullability mismatches:**

| Table | Column | SQL | Python | Risk |
|-------|--------|-----|--------|------|
| `products` | `avg_rating` | nullable (no NOT NULL) | `Mapped[Decimal]` (non-optional) | Will error loading NULL rows |
| `products` | `review_count` | nullable (no NOT NULL) | `Mapped[int]` (non-optional) | Will error loading NULL rows |

**Missing constraints:**

| Table | Constraint | SQL Line | Python File |
|-------|-----------|----------|-------------|
| `reviews` | `CHECK (rating >= 1 AND rating <= 5)` | 535 | `reviews/models.py:25` — no CheckConstraint |
| `reviews` | `UNIQUE(product_id, user_id)` | — | Not in SQL or Python — enforced only in service layer |

**Missing infrastructure:**
- No Alembic configuration (`alembic.ini`, `alembic/env.py`, migrations/) — WS-0 task 0.5
- `aiosqlite` missing from `requirements-dev.txt` — needed for SQLite test DB

### 2.2 Functional Gaps

| Issue | File:Line | Severity |
|-------|-----------|----------|
| `apply_coupon` never writes to `CouponUsage` table or increments `current_uses` | `app/cart/service.py:248-329` | HIGH |
| `_generate_order_number()` uses random 5-digit int — collision risk | `app/orders/service.py:20-24` | MEDIUM |
| `return_order` does not create a `Refund` record | `app/orders/service.py:270-273` | MEDIUM |
| N+1 query: reviewer names fetched individually per review | `app/reviews/service.py:52-58` | MEDIUM |
| `generic_exception_handler` defined but never registered in `main.py` | `app/core/exceptions.py:44-48` | LOW |
| `Product` model has no `slug` column — service uses SKU as slug | `app/products/service.py:118` | LOW (by design) |
| Payment method hardcoded to `credit_card` on order creation | `app/orders/service.py:151` | LOW (Stripe stub) |

---

## 3. Backend — Security Audit

| # | Finding | Severity | File:Line |
|---|---------|----------|-----------|
| 1 | `SECRET_KEY = "change-me-in-production"` — no runtime guard for production | MEDIUM | `app/core/config.py:13` |
| 2 | CORS allows `http://localhost:3000,http://localhost:5173` — fine for dev, needs lockdown for prod | LOW | `app/core/config.py:21` |
| 3 | No rate limiting on any endpoint | MEDIUM | `app/main.py` (global) |
| 4 | `decode_token` swallows all `JWTError` silently — no logging | LOW | `app/core/security.py` |
| 5 | Admin endpoints (WS-3) not yet implemented — no admin-only routes to audit | INFO | — |
| 6 | No SQL injection risk — all queries use SQLAlchemy ORM | PASS | — |
| 7 | No hardcoded credentials in any `.py` file | PASS | — |
| 8 | `.env.example` contains only placeholder values | PASS | — |

---

## 4. Frontend — Tool Results

### 4.1 TypeScript (`tsc --noEmit`)
**PASS** — zero type errors.

### 4.2 ESLint (3 errors)

All 3 are `react-refresh/only-export-components` — files that export both components and non-component values (CVA variants):

| File | Line | Export |
|------|------|--------|
| `src/components/ui/badge.tsx` | 48 | `badgeVariants` |
| `src/components/ui/button.tsx` | 64 | `buttonVariants` |
| `src/components/ui/tabs.tsx` | 89 | `tabsListVariants` |

**Fix:** These are shadcn/ui generated patterns. Either suppress with `// eslint-disable-next-line` or move variant exports to separate files.

### 4.3 Vite Build
**PASS** — builds successfully in 1.59s. Output: 375.52 kB JS + 61.79 kB CSS.

**Warning:** Node.js 20.11.0 is below Vite 7's requirement of 20.19+. Upgrade Node.js.

---

## 5. Frontend — Code Quality

### 5.1 console.log — **CLEAN** (0 found)

### 5.2 Image alt text — **CLEAN** (all `<img>` have `alt`)

### 5.3 Missing key props — 5 instances using index keys

| File | Line | Context | Risk |
|------|------|---------|------|
| `src/pages/HomePage.tsx` | 67 | Carousel slides `key={i}` | Low (static array) |
| `src/pages/HomePage.tsx` | 117 | Carousel dots `key={i}` | Low (static array) |
| `src/pages/ProductDetailPage.tsx` | 157 | Feature list `key={i}` | Low (read-only list) |
| `src/components/ui/breadcrumbs.tsx` | 21 | Breadcrumbs `key={index}` | Low (route-derived) |
| `src/components/ui/slider.tsx` | 55 | Slider thumbs `key={index}` | Low (shadcn generated) |

### 5.4 Responsive design concerns

| File | Line | Issue |
|------|------|-------|
| `src/pages/CollectionPage.tsx` | 110 | `w-[300px]` filter drawer — may overflow on <320px screens |
| `src/components/layout/Header.tsx` | 22 | `w-[300px]` nav drawer — same issue |
| `src/pages/HomePage.tsx` | 68 | `min-h-[400px]` hero — pushes content on small viewports |
| `src/pages/HomePage.tsx` | 169 | `min-h-[300px]` banner — same concern |

### 5.5 Missing Error Boundary — **CRITICAL**

No `ErrorBoundary` component exists anywhere. Any unhandled JS error will show a blank white page. Needs a top-level boundary around `<App />` in `main.tsx`.

### 5.6 Accessibility issues

| Issue | File:Line | Severity |
|-------|-----------|----------|
| `<Rating>` component has no `aria-label` or `role="img"` for screen readers | `src/components/ui/rating.tsx:15-38` | HIGH |
| Image thumbnail buttons lack `aria-label` and `aria-pressed` | `src/pages/ProductDetailPage.tsx:68-78` | MEDIUM |
| Address action buttons (Edit/Delete) lack context-specific `aria-label` | `src/pages/account/AddressesPage.tsx:31-40` | MEDIUM |

---

## 6. Frontend — Structure vs ARCHITECTURE.md

### 6.1 What's Built

- Design system (CSS variables, fonts, spacing) — matches Section 14
- 5/6 Zustand stores (`cartStore`, `authStore`, `filterStore`, `uiStore`, `wishlistStore`) — missing `productStore`
- 19 UI components (shadcn + 5 custom: Rating, PriceDisplay, QuantityStepper, Breadcrumbs, PromoBar)
- Header component with mobile nav, cart badge
- Mock data: 20 products, 6 categories, 3 orders, user, reviews
- Types matching API response schemas
- 9 pages: Home, Collection, ProductDetail, Cart, Checkout, OrderConfirmation, Account (Profile, Orders, OrderDetail, Addresses), Wishlist, Search (placeholder)

### 6.2 What's Missing

| Component/Page | Spec Reference | Status |
|---------------|---------------|--------|
| `Footer` component | WS-2 Task 2.3 | NOT BUILT |
| `productStore` | WS-2 Task 2.12 | NOT BUILT |
| API integration layer (`src/services/api.ts`) | WS-4 Task 4.1 | NOT BUILT (expected — WS-4) |
| Testing framework (Vitest) | — | NOT INSTALLED |
| Auth integration (MSAL) | WS-5 | NOT BUILT (expected — WS-5) |
| Stripe Elements | WS-6 | NOT BUILT (expected — WS-6) |

---

## 7. Action Items for Developers

### Priority 1 — Must Fix Before Integration (WS-4)

| # | Item | Assigned To | File(s) |
|---|------|-------------|---------|
| 1 | Run `ruff check --fix` to auto-fix imports + add `# noqa: F821` to relationship annotations | Backend | All `models.py` |
| 2 | Add `from __future__ import annotations` to all `models.py` to fix mypy cross-module errors | Backend | All `models.py` |
| 3 | Fix `ProductSortField` — use normal `import enum` | Backend | `app/products/schemas.py:148` |
| 4 | Fix `main.py` variable shadowing (`app` name conflicts with module) | Backend | `app/main.py` |
| 5 | Add `aiosqlite` to `requirements-dev.txt` | Backend | `requirements-dev.txt` |
| 6 | Fix JSONB array type annotations (`dict` → `list`) on 7 columns | Backend | See Section 2.1 |
| 7 | Fix `avg_rating` and `review_count` nullability (`Mapped[Decimal | None]`, `Mapped[int | None]`) | Backend | `app/products/models.py:78-79` |
| 8 | Implement coupon usage tracking in `apply_coupon` | Backend | `app/cart/service.py:248-329` |
| 9 | Add `ErrorBoundary` to frontend | Frontend | `src/main.tsx` |
| 10 | Add `aria-label` to `Rating` component | Frontend | `src/components/ui/rating.tsx` |
| 11 | Build `Footer` component | Frontend | New file |
| 12 | Add `productStore` to Zustand stores | Frontend | New file |

### Priority 2 — Should Fix

| # | Item | Assigned To |
|---|------|-------------|
| 13 | Replace `datetime.utcnow` with `datetime.now(timezone.utc)` across all models | Backend |
| 14 | Fix order number generation to use sequence or retry on collision | Backend |
| 15 | Fix N+1 query in reviews service (use JOIN) | Backend |
| 16 | Register `generic_exception_handler` in `main.py` | Backend |
| 17 | Add `CheckConstraint` for review rating (1-5) | Backend |
| 18 | Add tests for orders, reviews, search, checkout modules | Backend |
| 19 | Setup Alembic migrations | Backend |
| 20 | Fix ESLint errors in shadcn components (suppress or split exports) | Frontend |
| 21 | Upgrade Node.js to 20.19+ for Vite 7 compatibility | Frontend |
| 22 | Add accessibility labels to thumbnail buttons and address action buttons | Frontend |

### Priority 3 — Nice to Have

| # | Item |
|---|------|
| 23 | Replace index-based keys with stable keys in carousel/breadcrumbs |
| 24 | Use `max-w` + percentage widths for mobile drawers instead of fixed 300px |
| 25 | Add rate limiting middleware to backend |
| 26 | Add production guard for `SECRET_KEY` |

---

## 8. Overall Assessment

**Backend (WS-1):** Substantially complete and well-structured. All 10 API modules are implemented with proper async SQLAlchemy patterns. 28 tests pass. The main issues are linting/type errors (easily fixable), a coupon usage tracking gap, and missing Alembic migrations. Ready for WS-4 integration after Priority 1 fixes.

**Frontend (WS-2):** Good foundation with design system, stores, mock data, and 9 pages built. Missing Footer and productStore. No testing infrastructure. The critical gap is the absence of an ErrorBoundary. Ready for WS-4 integration after Priority 1 fixes.

**Next step:** Developers fix Priority 1 items, then QA re-runs all checks.
