# NLU Assistant Documentation (Archived)

This document contains the archived documentation for the NLU (Natural Language Understanding) module that was part of the original GaiEcom database schema.

## Overview

The NLU module supports conversational AI features for search, navigation, and personalized shopping assistance.

---

## NLU Tables

| Table | Description |
|-------|-------------|
| `nlu_intents` | Intent definitions with example utterances |
| `nlu_entities` | Named entities (product_type, style, color) |
| `search_synonyms` | Term synonyms for better search matching |
| `conversation_sessions` | Active chat sessions with context |
| `conversation_messages` | Message history with detected intents |
| `search_logs` | Search queries for analytics |
| `user_behavior` | Event tracking for personalization |

---

## Supported Intents

| Intent | Description | Expected Entities |
|--------|-------------|-------------------|
| `search_product` | Find products | product_type, style, color, room, material, price_range |
| `navigate_category` | Go to category | category, product_type |
| `check_order_status` | Order tracking | order_number |
| `add_to_cart` | Add item | product_id, quantity, variant |
| `view_cart` | Show cart | - |
| `ask_product_info` | Product questions | product_id, attribute |
| `compare_products` | Compare items | product_ids |
| `get_recommendations` | Suggestions | style, room, budget |
| `remove_from_cart` | Remove item | product_id, clear_all |
| `apply_coupon` | Apply discount | coupon_code |
| `checkout` | Proceed to payment | - |
| `manage_wishlist` | Wishlist operations | product_id, action |
| `account_management` | Account settings | action |
| `get_help` | Customer support | topic |
| `greeting` | Welcome | - |

---

## Entity Extraction

| Entity | Type | Examples |
|--------|------|----------|
| `product_type` | categorical | "pendant light", "floor lamp", "rug" |
| `style` | categorical | "modern", "traditional", "bohemian" |
| `color` | categorical | "blue", "brass", "white" |
| `room` | categorical | "living room", "bedroom", "kitchen" |
| `material` | categorical | "glass", "wood", "metal" |
| `price_range` | numeric | "under $100", "50 to 200" |
| `size` | categorical | "small", "medium", "large", "queen" |
| `occasion` | categorical | "everyday", "gift", "seasonal" |

---

## Intent Structure

```sql
INSERT INTO nlu_intents (name, description, examples, expected_entities, handler_function)
VALUES (
    'search_product',
    'User wants to find products',
    '[
        "show me modern lamps",
        "I need a pendant light for my kitchen",
        "find blue rugs"
    ]'::jsonb,
    '["product_type", "style", "color", "room"]'::jsonb,
    'handleProductSearch'
);
```

---

## Entity Structure

```sql
INSERT INTO nlu_entities (name, entity_type, values)
VALUES (
    'product_type',
    'categorical',
    '[
        {"value": "pendant light", "synonyms": ["pendant", "hanging light", "pendant lamp"]},
        {"value": "floor lamp", "synonyms": ["standing lamp", "floor light", "tall lamp"]},
        {"value": "ceiling light", "synonyms": ["ceiling fixture", "overhead light"]}
    ]'::jsonb
);
```

---

## Conversation Context

Sessions maintain context for multi-turn conversations:

```json
{
    "current_category": "lighting",
    "filters": {"style": "Modern", "room": "Living Room"},
    "cart_id": "uuid",
    "last_viewed_products": ["uuid1", "uuid2"],
    "price_range": {"min": 50, "max": 200}
}
```

---

## Search Logging

Track searches for improving NLU:

```sql
-- What users search for
query               TEXT     -- "modern brass lamp for bedroom"
normalized_query    TEXT     -- "modern brass lamp bedroom"
source              VARCHAR  -- 'search_bar', 'nlu_assistant', 'voice'

-- Results and actions
result_count        INTEGER
clicked_product_id  UUID
resulted_in_cart    BOOLEAN
resulted_in_purchase BOOLEAN
```

---

## Query Flow

```
User: "Show me modern pendant lights for my kitchen under $200"
        │
        ▼
┌───────────────────────────────────────┐
│           Intent Detection            │
│   Intent: search_product (0.95)       │
└───────────────────┬───────────────────┘
                    │
                    ▼
┌───────────────────────────────────────┐
│          Entity Extraction            │
│   style: "modern"                     │
│   product_type: "pendant light"       │
│   room: "kitchen"                     │
│   price_max: 200                      │
└───────────────────┬───────────────────┘
                    │
                    ▼
┌───────────────────────────────────────┐
│          Database Query               │
│   SELECT * FROM v_product_search      │
│   WHERE product_type = 'pendant'      │
│   AND 'Modern' = ANY(styles)          │
│   AND 'Kitchen' = ANY(rooms)          │
│   AND price <= 200                    │
└───────────────────┬───────────────────┘
                    │
                    ▼
┌───────────────────────────────────────┐
│         Response Generation           │
│   "I found 12 modern pendant lights   │
│   for your kitchen under $200..."     │
└───────────────────────────────────────┘
```

---

## NLU: Find Synonyms Query

```sql
-- Expand user query with synonyms
SELECT DISTINCT unnest(synonyms::text[])
FROM search_synonyms
WHERE term ILIKE ANY(string_to_array($1, ' '));
```

---

## Architecture Diagram

```
┌─────────────────────────────────────┐
│       NLU Assistant Module          │
│  ┌─────────┐  ┌──────────────┐     │
│  │ Intents │  │ Conversations│     │
│  │Entities │  │ Search Logs  │     │
│  └─────────┘  └──────────────┘     │
└─────────────────────────────────────┘
```

---

## Re-integration Notes

When re-integrating the NLU module:

1. Ensure the main schema is loaded first (needs `users`, `products`, `categories` tables)
2. Run `nlu_schema.sql` to create NLU tables
3. Load `nlu_seed_data.sql` for initial intents/entities
4. Update FastAPI backend to include NLU service endpoints
5. Connect to Azure Cognitive Services or custom NLU model
