# NLU Integration Guide — Shop with gAI

> **For:** Azure OpenAI Chatbot Developer
> **Last Updated:** 2026-03-03
> **Status:** Backend API complete, Frontend UI complete (mock data), Voice Pipeline (WS-7) pending

---

## Table of Contents

1. [Overview & Architecture](#1-overview--architecture)
2. [The Integration Contract](#2-the-integration-contract)
3. [Supported Intents (16)](#3-supported-intents-16)
4. [Slot Reference & Valid Values](#4-slot-reference--valid-values)
5. [Backend API Endpoints](#5-backend-api-endpoints)
6. [Frontend State & Action Dispatch](#6-frontend-state--action-dispatch)
7. [End-to-End Flow Examples](#7-end-to-end-flow-examples)
8. [Context Object — What You Receive](#8-context-object--what-you-receive)
9. [Error Handling & Edge Cases](#9-error-handling--edge-cases)
10. [Product Catalog Reference](#10-product-catalog-reference)
11. [Search Synonyms & Query Expansion](#11-search-synonyms--query-expansion)
12. [Testing & Validation Checklist](#12-testing--validation-checklist)
13. [Swap Mechanism: Mock → Azure OpenAI](#13-swap-mechanism-mock--azure-openai)
14. [Common Pitfalls & Gotchas](#14-common-pitfalls--gotchas)

---

## 1. Overview & Architecture

Shop with gAI is a **voice-first furniture e-commerce platform**. Users speak or type natural language queries, which your NLU service interprets into structured intents + slots. An Action Dispatcher on the frontend then executes the corresponding action (filter products, add to cart, navigate to checkout, etc.).

### Data Flow

```
User (voice/text)
        ↓
    Web Speech API (STT) → raw text
        ↓
    Frontend sends POST /api/v1/chat/message
        ↓
    Backend proxies to YOUR NLU service (Azure OpenAI)
        ↓
    You return: { intent, slots, response_text, confidence, suggestions }
        ↓
    Backend returns response to Frontend
        ↓
    Action Dispatcher: intent → Zustand store mutations + router.navigate()
        ↓
    UI re-renders with new state
        ↓
    TTS speaks response_text back to user
```

### Your Responsibility

You own the **NLU box** — given a user message + context, return structured JSON with:
- `intent` — what the user wants to do
- `slots` — extracted parameters (category, color, price, etc.)
- `response_text` — natural language response (will be spoken via TTS)
- `confidence` — 0.0–1.0 score
- `suggestions` — optional follow-up prompts

You do **NOT** need to:
- Call backend APIs directly (the Action Dispatcher handles that)
- Manage session state (context is passed to you each request)
- Handle authentication (user_id is passed in context)

---

## 2. The Integration Contract

### Endpoint

```
POST /api/v1/chat/message
Content-Type: application/json
```

### Request Schema

```json
{
  "message": "Show me red sofas under $500",
  "context": {
    "current_page": "/category/furniture",
    "active_filters": {
      "colors": ["Natural"],
      "materials": [],
      "styles": [],
      "rooms": [],
      "priceRange": [0, 1000]
    },
    "cart_item_count": 2,
    "last_intents": ["search_product", "filter_products"],
    "user_id": "a1b2c3d4-uuid-or-null"
  }
}
```

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `message` | string | Yes | Raw user input (from STT or text input) |
| `context.current_page` | string | Yes | Current URL path (e.g., `/`, `/category/lighting`, `/product/modern-globe-pendant`, `/cart`) |
| `context.active_filters` | object | Yes | Current filter state from the filter store |
| `context.cart_item_count` | integer | Yes | Number of items currently in cart |
| `context.last_intents` | string[] | Yes | Last 3 detected intents (for multi-turn context) |
| `context.user_id` | string\|null | Yes | User UUID if authenticated, null for guests |

### Response Schema

```json
{
  "intent": "search_product",
  "slots": {
    "category": "furniture",
    "color": "red",
    "price_max": 500
  },
  "response_text": "Here are red sofas under $500",
  "confidence": 0.95,
  "suggestions": ["Filter by material", "Sort by price", "Show me blue sofas"]
}
```

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `intent` | string | Yes | One of the 16 supported intents (see Section 3) |
| `slots` | object | Yes | Extracted parameters (varies by intent, see Section 3) |
| `response_text` | string | Yes | Natural language response for TTS. Keep under 150 chars for good speech output. |
| `confidence` | float | Yes | 0.0–1.0. Below 0.7 triggers clarification dialog on frontend. |
| `suggestions` | string[] | No | 2–3 follow-up suggestions shown as clickable chips. |

---

## 3. Supported Intents (16)

### Product Discovery

#### `search_product`
User wants to find products matching criteria.

| Slot | Type | Example Values |
|------|------|---------------|
| `category` | string | `"lighting"`, `"furniture"`, `"rugs"` (use category slug) |
| `product_type` | string | `"pendant"`, `"sofa"`, `"indoor-rug"` (use product type slug) |
| `color` | string | `"red"`, `"brass"`, `"white"` |
| `material` | string | `"wood"`, `"glass"`, `"leather"` |
| `style` | string | `"modern"`, `"bohemian"`, `"industrial"` |
| `room` | string | `"living room"`, `"bedroom"`, `"kitchen"` |
| `price_min` | number | `50` |
| `price_max` | number | `500` |
| `query` | string | Free text search term, e.g., `"globe pendant"` |

**Example utterances:**
- "Show me modern pendant lights under $200"
- "Find leather sofas for my living room"
- "I'm looking for bohemian rugs"
- "What kitchen lighting do you have?"

#### `filter_products`
User wants to narrow down current results (assumes they're already browsing).

| Slot | Type | Example Values |
|------|------|---------------|
| `color` | string\|string[] | `"blue"` or `["blue", "green"]` |
| `material` | string\|string[] | `"wood"` |
| `style` | string\|string[] | `"minimalist"` |
| `room` | string\|string[] | `"bedroom"` |
| `price_min` | number | `100` |
| `price_max` | number | `500` |

**Example utterances:**
- "Only show me blue ones"
- "Filter by wood material"
- "Under $300 please"
- "Just the modern ones"

#### `sort_products`
User wants to change the sort order of current results.

| Slot | Type | Valid Values |
|------|------|-------------|
| `sort_by` | string | `"price_asc"`, `"price_desc"`, `"rating"`, `"newest"`, `"name"` |

**Backend sort values:** `price_asc`, `price_desc`, `rating`, `newest`, `name`
**Frontend sort values:** `best-selling`, `price-asc`, `price-desc`, `newest`, `top-rated`

> **Important:** Map user intent to the correct sort value. "cheapest first" → `price_asc`. "highest rated" → `rating`. "newest arrivals" → `newest`.

**Example utterances:**
- "Sort by price low to high"
- "Show cheapest first"
- "Show me the highest rated"
- "Sort by newest"

#### `navigate_category`
User wants to browse a specific category page.

| Slot | Type | Example Values |
|------|------|---------------|
| `category` | string | Category slug: `"lighting"`, `"decor"`, `"art"`, `"bedding"`, `"furniture"`, `"rugs"` |

**Example utterances:**
- "Take me to furniture"
- "Browse lighting"
- "Show me the rugs section"

---

### Cart Operations

#### `add_to_cart`
User wants to add a product to their cart.

| Slot | Type | Description |
|------|------|-------------|
| `product_id` | string\|null | Product ID if specified. **null** = use current product on screen. |
| `variant_id` | string\|null | Variant ID if user specified color/size variant. |
| `quantity` | integer | Default: 1 |
| `color` | string\|null | If user specified a color, e.g., "add the brass one" |

**Example utterances:**
- "Add this to my cart"
- "Add 2 of these"
- "Add the brass one to cart"
- "I'll take this"

#### `remove_from_cart`
User wants to remove an item from their cart.

| Slot | Type | Description |
|------|------|-------------|
| `item_id` | string\|null | Cart item ID. null = last added or context-inferred. |
| `product_name` | string\|null | Fuzzy match by product name if ID unknown. |

**Example utterances:**
- "Remove the pendant light from my cart"
- "Take out the last item"
- "Delete the sofa"

#### `update_quantity`
User wants to change quantity of a cart item.

| Slot | Type | Description |
|------|------|-------------|
| `item_id` | string\|null | Cart item ID. |
| `product_name` | string\|null | Fuzzy match. |
| `quantity` | integer | New quantity (0 = remove). |

**Example utterances:**
- "Change quantity to 3"
- "I want 2 of the pendant lights"
- "Make it just 1"

#### `view_cart`
User wants to see their cart.

| Slot | Type | Description |
|------|------|-------------|
| — | — | No slots needed. |

**Example utterances:**
- "Show me my cart"
- "What's in my bag?"
- "Open cart"

#### `apply_coupon`
User wants to apply a discount code.

| Slot | Type | Description |
|------|------|-------------|
| `coupon_code` | string | The coupon code, e.g., `"SAVE10"` |

**Example utterances:**
- "Apply coupon SAVE10"
- "I have a code: FREESHIP"
- "Use promo code SAVE20"

---

### Checkout & Orders

#### `start_checkout` / `checkout`
User wants to proceed to checkout. Both intents are treated identically.

| Slot | Type | Description |
|------|------|-------------|
| — | — | No slots needed. |

**Example utterances:**
- "Go to checkout"
- "I'm ready to pay"
- "Proceed to payment"
- "Check out"

#### `use_saved_address`
User wants to select a saved address during checkout.

| Slot | Type | Description |
|------|------|-------------|
| `address_label` | string\|null | `"home"`, `"work"`, or null for default. |

**Example utterances:**
- "Use my home address"
- "Ship to work"
- "Use the default address"

#### `place_order`
User confirms and places the order.

| Slot | Type | Description |
|------|------|-------------|
| — | — | No slots needed. |

> **Important:** This is a high-stakes action. The frontend will show a voice confirmation prompt ("Are you sure you want to place this order?") before executing.

**Example utterances:**
- "Place the order"
- "Confirm my purchase"
- "Yes, buy it"

#### `track_order`
User wants to check order status.

| Slot | Type | Description |
|------|------|-------------|
| `order_number` | string\|null | e.g., `"ORD-2026-12345"`. null = show latest order. |

**Example utterances:**
- "Track my order"
- "Where's order ORD-2026-12345?"
- "What's the status of my order?"

#### `view_orders`
User wants to see their order history.

| Slot | Type | Description |
|------|------|-------------|
| — | — | No slots needed. |

**Example utterances:**
- "Show my orders"
- "View order history"
- "What have I ordered?"

---

### Wishlist

#### `add_to_wishlist`
User wants to save a product for later.

| Slot | Type | Description |
|------|------|-------------|
| `product_id` | string\|null | null = use current product on screen. |

**Example utterances:**
- "Save this for later"
- "Add to my wishlist"
- "I like this, bookmark it"

#### `view_wishlist`
User wants to see their saved items.

| Slot | Type | Description |
|------|------|-------------|
| — | — | No slots needed. |

**Example utterances:**
- "Show my wishlist"
- "What did I save?"
- "Show saved items"

---

## 4. Slot Reference & Valid Values

### Category Slugs (6)

| Slug | Display Name | Synonyms (user might say) |
|------|-------------|---------------------------|
| `lighting` | Lighting | lights, lamps, fixtures, illumination |
| `decor` | Decor | decorations, accessories, accents, home decor |
| `art` | Art & Mirrors | artwork, wall art, mirrors, paintings, prints |
| `bedding` | Bedding & Textiles | bed linens, sheets, comforters, textiles, curtains |
| `furniture` | Furniture | furnishings, seating, tables, sofas, chairs |
| `rugs` | Rugs | carpets, floor coverings, area rugs, mats |

### Product Type Slugs (30)

| Category | Slug | Display Name | Synonyms |
|----------|------|-------------|----------|
| Lighting | `ceiling-light` | Ceiling Light | ceiling fixture, overhead light, flush mount |
| Lighting | `floor-lamp` | Floor Lamp | standing lamp, floor light, tall lamp |
| Lighting | `table-lamp` | Table Lamp | desk lamp, bedside lamp, accent lamp |
| Lighting | `wall-sconce` | Wall Sconce | wall light, sconce, wall fixture |
| Lighting | `pendant` | Pendant Light | pendant lamp, hanging light, drop light, chandelier |
| Decor | `vase` | Vase | flower vase, decorative vase, planter |
| Decor | `candle` | Candle | candles, candle holder, tealight |
| Decor | `tray` | Decorative Tray | serving tray, accent tray |
| Decor | `decorative-object` | Decorative Object | sculpture, figurine, accent piece |
| Art | `wall-art` | Wall Art | wall decor, art print, poster |
| Art | `canvas` | Canvas Art | canvas print, canvas painting |
| Art | `mirror` | Mirror | wall mirror, decorative mirror |
| Art | `framed-print` | Framed Print | framed art, framed picture |
| Bedding | `duvet` | Duvet Cover | duvet, comforter cover |
| Bedding | `bedding-set` | Bedding Set | bed set, linen set |
| Bedding | `sheets` | Sheet Set | bed sheets, fitted sheet |
| Bedding | `quilt` | Quilt | quilts, coverlet, bedspread |
| Bedding | `curtain` | Curtain | curtains, drapes, window panel |
| Bedding | `throw` | Throw Blanket | blanket, throw, afghan |
| Bedding | `pillow` | Pillow | pillows, cushion, decorative pillow |
| Furniture | `sofa` | Sofa | couch, settee, loveseat, sectional |
| Furniture | `accent-chair` | Accent Chair | armchair, lounge chair, side chair |
| Furniture | `coffee-table` | Coffee Table | cocktail table, center table |
| Furniture | `tv-stand` | TV Stand | media console, entertainment center |
| Furniture | `nightstand` | Nightstand | bedside table, night table |
| Furniture | `bookcase` | Bookcase | bookshelf, shelving unit |
| Rugs | `indoor-rug` | Indoor Rug | area rug, living room rug |
| Rugs | `indoor-outdoor-rug` | Indoor/Outdoor Rug | outdoor rug, patio rug |
| Rugs | `natural-fiber-rug` | Natural Fiber Rug | jute rug, sisal rug |
| Rugs | `reversible-rug` | Reversible Rug | double-sided rug |

### Colors

Normalize user input to these standard values for filtering:

| User Might Say | Normalize To |
|---------------|-------------|
| red, crimson, cherry, burgundy | `red` |
| blue, navy, cobalt, sapphire, azure | `blue` |
| green, emerald, sage, olive, forest | `green` |
| white, ivory, cream, pearl | `white` |
| black, ebony, onyx, charcoal | `black` |
| gray, grey, silver, slate | `gray` |
| gold, brass, amber, honey | `gold` |
| brown, walnut, espresso, chocolate, tan | `brown` |
| pink, blush, rose, coral | `pink` |
| purple, plum, violet, lavender | `purple` |
| orange, terracotta, rust, copper | `orange` |
| yellow, mustard, lemon, sunshine | `yellow` |
| multi, multicolor, rainbow, patterned | `multicolor` |
| natural, beige, sand, oatmeal | `natural` |

> **Note:** Product attributes store specific color names (e.g., "Warm Brass", "Frosted White"). The frontend filter uses simplified color names. Your slot values should use the simplified form.

### Materials

| User Might Say | Normalize To |
|---------------|-------------|
| wood, wooden, oak, walnut, pine, teak | `wood` |
| metal, steel, iron, aluminum | `metal` |
| glass, crystal | `glass` |
| fabric, textile, cloth, upholstered | `fabric` |
| leather, faux leather, vegan leather | `leather` |
| ceramic, porcelain, pottery | `ceramic` |
| marble, stone, granite | `marble` |
| rattan, wicker, bamboo | `rattan` |
| velvet | `velvet` |
| linen | `linen` |
| cotton | `cotton` |
| jute, sisal, hemp | `jute` |

### Styles

| User Might Say | Normalize To |
|---------------|-------------|
| modern, contemporary | `modern` |
| traditional, classic | `traditional` |
| mid-century, mid century modern, MCM | `mid-century` |
| industrial, warehouse, loft | `industrial` |
| bohemian, boho, eclectic | `bohemian` |
| minimalist, minimal, simple | `minimalist` |
| scandinavian, scandi, nordic | `scandinavian` |
| rustic, farmhouse, country | `rustic` |
| coastal, nautical, beach, seaside | `coastal` |
| glam, glamorous, luxe, luxury | `glam` |
| transitional | `transitional` |
| abstract | `abstract` |

### Rooms

| User Might Say | Normalize To |
|---------------|-------------|
| living room, lounge, family room, den | `living room` |
| bedroom, master bedroom, guest room | `bedroom` |
| kitchen | `kitchen` |
| dining room, dining area | `dining room` |
| bathroom, bath, restroom | `bathroom` |
| office, home office, study, workspace | `office` |
| entryway, foyer, hallway, entrance | `entryway` |
| outdoor, patio, porch, garden, deck | `outdoor` |
| nursery, kids room, children's room | `nursery` |

### Price Ranges (Natural Language Mapping)

| User Might Say | Slot Values |
|---------------|-------------|
| "cheap", "budget", "affordable", "inexpensive" | `price_max: 100` |
| "under $X", "less than $X", "below $X" | `price_max: X` |
| "over $X", "more than $X", "above $X", "at least $X" | `price_min: X` |
| "between $X and $Y", "$X to $Y" | `price_min: X, price_max: Y` |
| "around $X", "about $X" | `price_min: X*0.8, price_max: X*1.2` |
| "mid-range", "moderate" | `price_min: 100, price_max: 500` |
| "premium", "luxury", "high-end", "expensive" | `price_min: 500` |

### Sort Values

| User Might Say | Slot Value |
|---------------|-----------|
| "cheapest", "lowest price", "price low to high" | `price_asc` |
| "most expensive", "highest price", "price high to low" | `price_desc` |
| "best rated", "highest rated", "top rated" | `rating` |
| "newest", "latest", "new arrivals", "recently added" | `newest` |
| "alphabetical", "A to Z", "by name" | `name` |
| "popular", "best selling", "trending" | `best-selling` (frontend only, no backend equivalent) |

---

## 5. Backend API Endpoints

These are the APIs that the Action Dispatcher calls AFTER your NLU returns the intent. You don't call these directly, but understanding them helps you return correct slot values.

### Search & Products

```
GET /api/v1/search?q={query}&page=1&per_page=20
GET /api/v1/search/suggestions?q={partial_query}

GET /api/v1/products?category={slug}&price_min=X&price_max=Y&tags={csv}&sort={sort}&page=1&per_page=20&search={text}&is_featured=true&is_bestseller=true&is_new=true
GET /api/v1/products/{sku}
GET /api/v1/products/{product_id}/related
```

### Categories

```
GET /api/v1/categories
GET /api/v1/categories/{slug}
GET /api/v1/categories/{slug}/products?price_min=X&price_max=Y&sort={sort}&page=1&per_page=20
```

### Cart

```
GET    /api/v1/cart                          (x-session-id header for guests)
POST   /api/v1/cart/items                    { product_id, variant_id?, quantity }
PATCH  /api/v1/cart/items/{item_id}          { quantity }
DELETE /api/v1/cart/items/{item_id}
DELETE /api/v1/cart
POST   /api/v1/cart/apply-coupon             { code }
DELETE /api/v1/cart/coupon
POST   /api/v1/cart/merge                    { session_id }
```

### Checkout & Orders

```
GET  /api/v1/checkout/shipping-methods
POST /api/v1/checkout/calculate-tax          { address_id }
POST /api/v1/checkout/create-payment-intent  { amount, currency }

GET  /api/v1/orders?page=1&per_page=10
POST /api/v1/orders                          { shipping_address_id, billing_address_id?, shipping_method_id, customer_notes? }
GET  /api/v1/orders/{order_number}
POST /api/v1/orders/{order_number}/cancel
POST /api/v1/orders/{order_number}/return    { items: [UUID], reason }
```

### Wishlist

```
GET    /api/v1/wishlist
POST   /api/v1/wishlist                      { product_id }
DELETE /api/v1/wishlist/{product_id}
```

### Reviews

```
GET  /api/v1/products/{product_id}/reviews?page=1&per_page=10
POST /api/v1/reviews                         { product_id, rating, title?, content?, is_recommended? }
GET  /api/v1/reviews/me
```

### User Profile

```
GET   /api/v1/users/me
PATCH /api/v1/users/me
GET   /api/v1/users/me/addresses
POST  /api/v1/users/me/addresses
PATCH /api/v1/users/me/addresses/{id}
DELETE /api/v1/users/me/addresses/{id}
PATCH /api/v1/users/me/addresses/{id}/default
```

### Error Response Format (All Endpoints)

```json
{
  "detail": "Error message string"
}
```

HTTP Status Codes: 400, 401, 404, 409 (stock/conflict), 422 (validation)

---

## 6. Frontend State & Action Dispatch

When your NLU returns an intent, the Action Dispatcher mutates these Zustand stores:

### Filter Store

```typescript
// Your slots → Filter store mutations
filterStore.setColors(['red'])           // slots.color
filterStore.setMaterials(['wood'])       // slots.material
filterStore.setStyles(['modern'])        // slots.style
filterStore.setRooms(['living room'])    // slots.room
filterStore.setPriceRange([0, 500])      // [slots.price_min, slots.price_max]
filterStore.setSort('price-asc')         // slots.sort_by
filterStore.clearFilters()               // when doing a fresh search
```

### Cart Store

```typescript
cartStore.addItem(product, color, size)  // add_to_cart intent
cartStore.removeItem(itemId)             // remove_from_cart intent
cartStore.updateQuantity(itemId, qty)    // update_quantity intent
cartStore.applyCoupon('SAVE10')          // apply_coupon intent
cartStore.clearCart()                     // clear cart
```

### Navigation (React Router)

```typescript
router.navigate('/')                              // home
router.navigate('/category/lighting')             // search_product / navigate_category
router.navigate('/product/modern-globe-pendant')  // view product detail
router.navigate('/cart')                           // view_cart
router.navigate('/checkout')                       // start_checkout / checkout
router.navigate('/wishlist')                       // view_wishlist
router.navigate('/account/orders')                 // view_orders
router.navigate('/account/orders/ORD-2026-12345') // track_order
```

### Frontend Route Map

| Route | Page | Voice Actions Available |
|-------|------|----------------------|
| `/` | Home | search, navigate category, view cart/wishlist |
| `/category/{slug}` | Collection | filter, sort, add to cart, search |
| `/product/{slug}` | Product Detail | add to cart, add to wishlist, view related |
| `/cart` | Cart | update qty, remove item, apply coupon, checkout |
| `/checkout` | Checkout | use saved address, place order |
| `/wishlist` | Wishlist | remove from wishlist, add to cart |
| `/account/orders` | Orders | track order |

---

## 7. End-to-End Flow Examples

### Example 1: Product Search

```
User: "Show me modern pendant lights for my dining room under $200"

Your NLU Request:
{
  "message": "Show me modern pendant lights for my dining room under $200",
  "context": {
    "current_page": "/",
    "active_filters": {},
    "cart_item_count": 0,
    "last_intents": [],
    "user_id": null
  }
}

Your NLU Response:
{
  "intent": "search_product",
  "slots": {
    "category": "lighting",
    "product_type": "pendant",
    "style": "modern",
    "room": "dining room",
    "price_max": 200
  },
  "response_text": "Here are modern pendant lights for your dining room under $200.",
  "confidence": 0.97,
  "suggestions": ["Sort by price", "Filter by material", "Show all lighting"]
}

Action Dispatcher:
1. router.navigate('/category/lighting')
2. filterStore.clearFilters()
3. filterStore.setStyles(['modern'])
4. filterStore.setRooms(['dining room'])
5. filterStore.setPriceRange([0, 200])
6. TTS speaks: "Here are modern pendant lights for your dining room under $200."
```

### Example 2: Add to Cart (Context-Aware)

```
User: "Add this to my cart" (while viewing a product)

Your NLU Request:
{
  "message": "Add this to my cart",
  "context": {
    "current_page": "/product/modern-globe-pendant",
    "active_filters": {},
    "cart_item_count": 0,
    "last_intents": ["search_product"],
    "user_id": "abc-123-uuid"
  }
}

Your NLU Response:
{
  "intent": "add_to_cart",
  "slots": {
    "product_id": null,
    "quantity": 1
  },
  "response_text": "Added to your cart!",
  "confidence": 0.99,
  "suggestions": ["View cart", "Continue shopping", "Checkout"]
}

Action Dispatcher:
1. Gets current product from productStore.currentProduct
2. cartStore.addItem(currentProduct, selectedColor)
3. toast.success('Modern Globe Pendant added to cart')
4. TTS speaks: "Added to your cart!"
```

### Example 3: Multi-Turn Refinement

```
--- Turn 1 ---
User: "Show me sofas"
Response: { intent: "search_product", slots: { category: "furniture", product_type: "sofa" } }
Action: Navigate to /category/furniture, filter to sofas

--- Turn 2 ---
User: "Only the leather ones"
Request context: { last_intents: ["search_product"], current_page: "/category/furniture" }
Response: { intent: "filter_products", slots: { material: "leather" } }
Action: filterStore.setMaterials(['leather'])

--- Turn 3 ---
User: "Sort cheapest first"
Request context: { last_intents: ["search_product", "filter_products"], current_page: "/category/furniture" }
Response: { intent: "sort_products", slots: { sort_by: "price_asc" } }
Action: filterStore.setSort('price-asc')

--- Turn 4 ---
User: "I like the second one, add it to my cart"
Request context: { last_intents: ["search_product", "filter_products", "sort_products"] }
Response: { intent: "add_to_cart", slots: { product_id: null }, response_text: "Could you tap on the sofa you'd like? Then say 'add to cart'." }
```

### Example 4: Coupon + Checkout Flow

```
--- Turn 1 ---
User: "Apply coupon code SAVE10"
Response: {
  intent: "apply_coupon",
  slots: { coupon_code: "SAVE10" },
  response_text: "Coupon SAVE10 applied! You're saving 10%.",
  confidence: 0.98
}

--- Turn 2 ---
User: "Proceed to checkout"
Response: {
  intent: "start_checkout",
  slots: {},
  response_text: "Taking you to checkout.",
  confidence: 0.99
}

--- Turn 3 ---
User: "Use my home address"
Response: {
  intent: "use_saved_address",
  slots: { address_label: "home" },
  response_text: "Using your home address for shipping.",
  confidence: 0.95
}

--- Turn 4 ---
User: "Place the order"
Response: {
  intent: "place_order",
  slots: {},
  response_text: "Placing your order now. Your total is $449.99.",
  confidence: 0.99
}
→ Frontend shows confirmation dialog before executing
```

---

## 8. Context Object — What You Receive

### `current_page` Values and What They Mean

| Pattern | User Is Currently | Implications |
|---------|-------------------|-------------|
| `/` | Home page | User is browsing, likely starting a search |
| `/category/{slug}` | Browsing a category | Filter/sort intents apply to this category |
| `/product/{slug}` | Viewing a specific product | "this", "it", "add to cart" = current product |
| `/cart` | Viewing cart | Cart operations (remove, update qty, coupon) |
| `/checkout` | In checkout flow | Address selection, payment, place order |
| `/wishlist` | Viewing wishlist | "Remove this", "add to cart" = wishlist context |
| `/account/orders` | Order history | "Track order", "view details" |
| `/account/orders/{num}` | Viewing specific order | "Track this", "cancel this order" |

### Using `last_intents` for Multi-Turn

The `last_intents` array (max 3) tells you what the user was doing recently:

| last_intents | What It Means | How To Use |
|-------------|--------------|-----------|
| `["search_product"]` | User just searched | "only blue ones" → `filter_products` |
| `["search_product", "filter_products"]` | User searched then filtered | "sort by price" → `sort_products` |
| `["add_to_cart"]` | User just added something | "one more" → `update_quantity` |
| `["view_cart"]` | User is looking at cart | "remove the lamp" → `remove_from_cart` |
| `[]` | Fresh session | Anything goes |

### Using `active_filters` for Smart Responses

```json
"active_filters": {
  "colors": ["red"],
  "materials": [],
  "styles": ["modern"],
  "rooms": [],
  "priceRange": [0, 500]
}
```

If user says "also in blue", you should return:
```json
{
  "intent": "filter_products",
  "slots": { "color": ["red", "blue"] },
  "response_text": "Added blue to your color filter. Showing red and blue items."
}
```

Not:
```json
{
  "slots": { "color": "blue" }  // This would REPLACE red, not add to it
}
```

> **Rule:** For additive filter operations ("also", "and", "too"), merge with existing `active_filters`. For replacement operations ("only", "just", "switch to"), replace the filter.

---

## 9. Error Handling & Edge Cases

### Low Confidence Responses

When you're not sure what the user means:

```json
{
  "intent": "search_product",
  "slots": {},
  "response_text": "I'm not sure what you're looking for. Could you try again?",
  "confidence": 0.3,
  "suggestions": ["Browse lighting", "Search furniture", "View my cart"]
}
```

The frontend will show suggestions as clickable chips instead of executing the low-confidence intent.

### Ambiguous Intent

When the utterance could mean multiple things:

```json
{
  "intent": "search_product",
  "slots": { "query": "table" },
  "response_text": "Are you looking for tables, or table lamps?",
  "confidence": 0.5,
  "suggestions": ["Coffee tables", "Dining tables", "Table lamps"]
}
```

### Empty Cart Operations

If user says "checkout" with an empty cart:

```json
{
  "intent": "start_checkout",
  "slots": {},
  "response_text": "Your cart is empty. Would you like to browse our products?",
  "confidence": 0.95,
  "suggestions": ["Browse lighting", "View trending", "Search products"]
}
```

> Use `cart_item_count` from context to detect this.

### Guest vs Authenticated Operations

Some intents require authentication: `place_order`, `view_orders`, `track_order`, `add_to_wishlist`, `view_wishlist`.

If `user_id` is null and user requests one of these:

```json
{
  "intent": "view_orders",
  "slots": {},
  "response_text": "You'll need to sign in to view your orders.",
  "confidence": 0.95,
  "suggestions": ["Sign in", "Continue as guest"]
}
```

### Out of Scope

If the user asks something unrelated to shopping:

```json
{
  "intent": "search_product",
  "slots": {},
  "response_text": "I can help you shop for furniture, lighting, decor, and more. What are you looking for?",
  "confidence": 0.1,
  "suggestions": ["Browse categories", "Show trending", "Search products"]
}
```

---

## 10. Product Catalog Reference

### Catalog Stats

| Category | Product Count | Price Range |
|----------|--------------|-------------|
| Lighting | ~42 | $29.99 – $449.99 |
| Decor | ~27 | $19.99 – $159.99 |
| Art & Mirrors | ~25 | $39.99 – $399.99 |
| Bedding & Textiles | ~27 | $39.99 – $259.99 |
| Furniture | ~31 | $149.99 – $1,799.99 |
| Rugs | ~6 | $89.99 – $449.99 |
| **Total** | **158** | **$19.99 – $1,799.99** |

### Sample Products (for testing your NLU)

| Product | Category | Price | Key Attributes |
|---------|----------|-------|---------------|
| Modern Globe Pendant | Lighting | $159.99 | Warm Brass, Glass, Modern |
| Arc Floor Lamp | Lighting | $299.99 | Natural, Metal, Mid-Century |
| Textured Ceramic Vase | Decor | $49.99 | White, Ceramic, Minimalist |
| Linen Sectional Sofa | Furniture | $1,799.99 | Natural, Linen, Modern |
| Hand-Knotted Wool Rug | Rugs | $449.99 | Multicolor, Wool, Bohemian |
| Organic Cotton Duvet | Bedding | $159.99 | White, Cotton, Minimalist |
| Abstract Canvas Art | Art | $199.99 | Multicolor, Canvas, Abstract |

---

## 11. Search Synonyms & Query Expansion

Your NLU should handle these common synonym mappings:

### Product Synonyms

| User Says | Map To |
|-----------|--------|
| lamp, light, fixture | Product in Lighting category |
| couch, settee, loveseat, sectional | `sofa` product type |
| carpet, floor covering, area rug | Product in Rugs category |
| drapes, window panel, curtain | `curtain` product type |
| blanket, afghan, throw | `throw` product type |
| cushion, decorative pillow | `pillow` product type |
| bookshelf, shelving unit | `bookcase` product type |
| bedside table, night table | `nightstand` product type |
| media console, entertainment center | `tv-stand` product type |
| armchair, lounge chair | `accent-chair` product type |

### Action Synonyms

| User Says | Intent |
|-----------|--------|
| "buy", "purchase", "get", "I want", "I'll take" | `add_to_cart` |
| "remove", "delete", "take out", "get rid of" | `remove_from_cart` |
| "save", "bookmark", "favorite", "heart" | `add_to_wishlist` |
| "pay", "purchase", "buy now", "ready to order" | `start_checkout` |
| "where is my order", "shipping status", "delivery status" | `track_order` |
| "what's in my bag", "shopping bag", "basket" | `view_cart` |

---

## 12. Testing & Validation Checklist

Use these test cases to validate your NLU before integration:

### Must-Pass Test Cases

```
1. "Show me pendant lights" → search_product, category: lighting, product_type: pendant
2. "Red sofas under 500 dollars" → search_product, category: furniture, color: red, price_max: 500
3. "Add to cart" (on product page) → add_to_cart, product_id: null
4. "Remove the lamp" (viewing cart) → remove_from_cart, product_name: lamp
5. "Apply coupon SAVE10" → apply_coupon, coupon_code: SAVE10
6. "Sort by price" → sort_products, sort_by: price_asc
7. "Only the blue ones" (after search) → filter_products, color: blue
8. "Checkout" → start_checkout
9. "Track order ORD-2026-12345" → track_order, order_number: ORD-2026-12345
10. "Show my wishlist" → view_wishlist
```

### Edge Cases to Handle

```
11. "Show me something nice" → search_product (low confidence, ask for specifics)
12. "Hmm" → confidence < 0.3, provide suggestions
13. "What's the weather?" → out of scope, redirect to shopping
14. "Table" → ambiguous (table lamp vs coffee table), ask for clarification
15. "Cheaper ones" → filter_products, sort_by: price_asc (use last_intents context)
16. "More like this" → needs current_page context to find related products
17. "The brass one" → needs variant resolution based on current product
18. "Actually, make it 3" → update_quantity, quantity: 3 (after add_to_cart)
19. "Never mind, remove it" → remove_from_cart (after add_to_cart)
20. "I changed my mind" → ambiguous without context
```

### Response Quality Checks

- [ ] `response_text` is under 150 characters
- [ ] `response_text` reads naturally when spoken aloud
- [ ] `confidence` is calibrated (high for clear intents, low for ambiguous)
- [ ] `suggestions` are actionable and contextually relevant
- [ ] Slot values match the valid values in Section 4
- [ ] Category/product type slugs are lowercase with hyphens
- [ ] Price values are numbers (not strings)
- [ ] Multi-turn context is respected (last_intents inform interpretation)

---

## 13. Swap Mechanism: Mock → Azure OpenAI

During development, we use a mock NLU that pattern-matches intents. When your Azure OpenAI chatbot is ready:

### Configuration

```env
# .env
NLU_PROVIDER=mock          # Change to: azure_openai
AZURE_OPENAI_ENDPOINT=https://your-resource.openai.azure.com/
AZURE_OPENAI_KEY=your-key
AZURE_OPENAI_DEPLOYMENT=your-deployment-name
```

### Backend Integration Point

The backend will have a service layer that routes to your NLU:

```python
# app/chat/service.py (to be built in WS-7)

async def process_message(message: str, context: dict) -> dict:
    if settings.nlu_provider == "mock":
        return mock_nlu(message, context)
    elif settings.nlu_provider == "azure_openai":
        return await azure_openai_nlu(message, context)
```

### Your Azure OpenAI Implementation

You need to provide a function/service that:

1. Accepts: `message: str`, `context: dict`
2. Calls Azure OpenAI with a system prompt that defines the 16 intents and slot schemas
3. Returns: `{ intent, slots, response_text, confidence, suggestions }`

**Recommended approach:** Use Azure OpenAI's function calling / tool use feature to extract structured intent + slots from natural language. This gives you reliable JSON output.

### Testing the Swap

1. Set `NLU_PROVIDER=azure_openai` in `.env`
2. Run the test cases from Section 12
3. Verify all 20 test cases return correct intents and valid slot values
4. Check response latency (target: < 2 seconds for voice UX)

---

## 14. Common Pitfalls & Gotchas

### 1. Slot Value Mismatches

**Problem:** Your NLU returns `"Pendant Light"` but the backend expects `"pendant"` (slug).

**Fix:** Always return slugs for `category` and `product_type` slots. Use the mappings in Section 4.

### 2. Overwriting vs Appending Filters

**Problem:** User says "also in blue" but your response replaces the existing "red" filter.

**Fix:** Check `active_filters` in context. If user says "also/and/too", merge arrays. If "only/just/switch", replace.

### 3. Ignoring Context

**Problem:** User says "add to cart" on the home page (no product selected).

**Fix:** Check `current_page`. If not on a product page and no `product_id` in slots, ask which product they want.

### 4. Authentication-Required Intents

**Problem:** Guest user says "show my orders" — NLU returns intent but it fails.

**Fix:** Check `user_id` in context. If null and intent requires auth, return helpful response with login suggestion.

### 5. Confidence Calibration

**Problem:** Everything returns 0.95 confidence, even ambiguous queries.

**Fix:** Reserve 0.9+ for clear, unambiguous intents. Use 0.5-0.7 for reasonable guesses. Use < 0.5 for unclear/out-of-scope.

### 6. Response Text Too Long for TTS

**Problem:** 300-character response sounds robotic and slow.

**Fix:** Keep under 150 characters. Front-load the key information. "Here are 12 modern pendant lights under $200" not "I found several options that might interest you in our modern pendant lights collection priced below two hundred dollars."

### 7. Not Handling "More" / "Next" / "Previous"

**Problem:** User says "show more" but NLU doesn't know about pagination.

**Fix:** Map these to `search_product` with a `page` slot incremented from context, or handle as a filter continuation.

### 8. Price Extraction Failures

**Problem:** "Five hundred" not recognized as 500.

**Fix:** Handle written numbers (one hundred = 100, five fifty = 550), currency symbols ($500, 500 dollars), and ranges (200 to 500).

---

## Quick Reference Card

```
INTENTS:  search_product | filter_products | sort_products | navigate_category
          add_to_cart | remove_from_cart | update_quantity | view_cart
          apply_coupon | start_checkout | checkout | use_saved_address
          place_order | track_order | view_orders
          add_to_wishlist | view_wishlist

CATEGORIES: lighting | decor | art | bedding | furniture | rugs

SORT:     price_asc | price_desc | rating | newest | name

COLORS:   red | blue | green | white | black | gray | gold | brown
          pink | purple | orange | yellow | multicolor | natural

STYLES:   modern | traditional | mid-century | industrial | bohemian
          minimalist | scandinavian | rustic | coastal | glam | transitional

MATERIALS: wood | metal | glass | fabric | leather | ceramic | marble
           rattan | velvet | linen | cotton | jute

ROOMS:    living room | bedroom | kitchen | dining room | bathroom
          office | entryway | outdoor | nursery
```

---

> **Questions?** Reach out to Sidharth for backend/frontend clarification. The integration point is `POST /api/v1/chat/message` — everything else is handled by the Action Dispatcher.
