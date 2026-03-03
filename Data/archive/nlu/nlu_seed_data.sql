-- ============================================================================
-- GaiEcom Seed Data: NLU Intents & Entities
-- For training the NLU assistant model
-- ============================================================================

-- ============================================================================
-- NLU INTENTS
-- ============================================================================

-- 1. Product Search Intent
INSERT INTO nlu_intents (name, description, examples, expected_entities, handler_function, requires_auth) VALUES
(
    'search_product',
    'User wants to search or browse products',
    '[
        "show me modern lamps",
        "I need a pendant light for my kitchen",
        "find blue rugs",
        "looking for brass floor lamps",
        "do you have minimalist decor",
        "I want to see ceiling lights",
        "show bedroom furniture",
        "find me a mirror for my living room",
        "what curtains do you have",
        "looking for something under 200 dollars",
        "show me bestsellers",
        "I need a gift for housewarming",
        "find bohemian style rugs",
        "show me glass vases",
        "I want something in white",
        "looking for wall art",
        "find me a couch",
        "show table lamps",
        "need bedding for queen size bed",
        "looking for industrial style lights"
    ]',
    '["product_type", "style", "color", "room", "material", "price_range", "size", "occasion"]',
    'handleProductSearch',
    false
);

-- 2. Navigate Category Intent
INSERT INTO nlu_intents (name, description, examples, expected_entities, handler_function, requires_auth) VALUES
(
    'navigate_category',
    'User wants to go to a specific category or section',
    '[
        "take me to lighting",
        "go to furniture section",
        "show me the decor category",
        "I want to browse rugs",
        "open bedding",
        "let me see art and mirrors",
        "navigate to ceiling lights",
        "go to floor lamps",
        "show me all categories",
        "back to home page"
    ]',
    '["category", "product_type"]',
    'handleNavigation',
    false
);

-- 3. Add to Cart Intent
INSERT INTO nlu_intents (name, description, examples, expected_entities, handler_function, requires_auth) VALUES
(
    'add_to_cart',
    'User wants to add a product to cart',
    '[
        "add this to cart",
        "I want to buy this",
        "add to my cart",
        "put this in my basket",
        "I will take this one",
        "add 2 of these",
        "add the brass one to cart",
        "buy now",
        "I want this in blue",
        "add the large size"
    ]',
    '["product_id", "quantity", "variant", "color", "size"]',
    'handleAddToCart',
    false
);

-- 4. View Cart Intent
INSERT INTO nlu_intents (name, description, examples, expected_entities, handler_function, requires_auth) VALUES
(
    'view_cart',
    'User wants to see their shopping cart',
    '[
        "show my cart",
        "what is in my cart",
        "view cart",
        "open my basket",
        "check my cart",
        "how many items in cart",
        "show me what I added",
        "cart",
        "my bag"
    ]',
    '[]',
    'handleViewCart',
    false
);

-- 5. Check Order Status Intent
INSERT INTO nlu_intents (name, description, examples, expected_entities, handler_function, requires_auth) VALUES
(
    'check_order_status',
    'User wants to track or check order status',
    '[
        "where is my order",
        "track my order",
        "order status",
        "when will my order arrive",
        "check order GAI-2024-001234",
        "is my order shipped",
        "delivery status",
        "has my order been dispatched",
        "track package",
        "when is my delivery"
    ]',
    '["order_number"]',
    'handleOrderStatus',
    true
);

-- 6. Product Info Intent
INSERT INTO nlu_intents (name, description, examples, expected_entities, handler_function, requires_auth) VALUES
(
    'ask_product_info',
    'User asks questions about a specific product',
    '[
        "what material is this made of",
        "how tall is this lamp",
        "what are the dimensions",
        "is this available in other colors",
        "how do I clean this",
        "what sizes does this come in",
        "is this in stock",
        "when will this be back in stock",
        "tell me more about this",
        "what is the return policy",
        "does this need assembly",
        "is this suitable for outdoor use"
    ]',
    '["product_id", "attribute"]',
    'handleProductInfo',
    false
);

-- 7. Get Recommendations Intent
INSERT INTO nlu_intents (name, description, examples, expected_entities, handler_function, requires_auth) VALUES
(
    'get_recommendations',
    'User wants product recommendations',
    '[
        "what do you recommend",
        "suggest something for my living room",
        "I need help choosing",
        "what goes well with this",
        "show me similar items",
        "recommend something modern",
        "what is popular",
        "best sellers",
        "trending items",
        "what should I buy for a small bedroom",
        "help me find a gift",
        "I am redecorating, what do you suggest"
    ]',
    '["style", "room", "budget", "occasion"]',
    'handleRecommendations',
    false
);

-- 8. Compare Products Intent
INSERT INTO nlu_intents (name, description, examples, expected_entities, handler_function, requires_auth) VALUES
(
    'compare_products',
    'User wants to compare multiple products',
    '[
        "compare these two",
        "what is the difference between these",
        "which one is better",
        "compare the brass and silver versions",
        "show me a comparison",
        "help me decide between these"
    ]',
    '["product_ids"]',
    'handleCompare',
    false
);

-- 9. Remove from Cart Intent
INSERT INTO nlu_intents (name, description, examples, expected_entities, handler_function, requires_auth) VALUES
(
    'remove_from_cart',
    'User wants to remove item from cart',
    '[
        "remove this from cart",
        "delete from cart",
        "I dont want this anymore",
        "take this out of my cart",
        "remove the lamp",
        "clear my cart",
        "empty cart"
    ]',
    '["product_id", "clear_all"]',
    'handleRemoveFromCart',
    false
);

-- 10. Apply Coupon Intent
INSERT INTO nlu_intents (name, description, examples, expected_entities, handler_function, requires_auth) VALUES
(
    'apply_coupon',
    'User wants to apply a discount code',
    '[
        "I have a coupon",
        "apply code SAVE20",
        "use discount code",
        "I have a promo code",
        "enter coupon",
        "apply my discount"
    ]',
    '["coupon_code"]',
    'handleApplyCoupon',
    false
);

-- 11. Checkout Intent
INSERT INTO nlu_intents (name, description, examples, expected_entities, handler_function, requires_auth) VALUES
(
    'checkout',
    'User wants to proceed to checkout',
    '[
        "checkout",
        "proceed to checkout",
        "I want to pay",
        "complete my order",
        "buy now",
        "place order",
        "ready to pay"
    ]',
    '[]',
    'handleCheckout',
    false
);

-- 12. Wishlist Intent
INSERT INTO nlu_intents (name, description, examples, expected_entities, handler_function, requires_auth) VALUES
(
    'manage_wishlist',
    'User wants to manage wishlist',
    '[
        "add to wishlist",
        "save for later",
        "show my wishlist",
        "view saved items",
        "add to favorites",
        "remove from wishlist",
        "move to cart from wishlist"
    ]',
    '["product_id", "action"]',
    'handleWishlist',
    true
);

-- 13. Account Intent
INSERT INTO nlu_intents (name, description, examples, expected_entities, handler_function, requires_auth) VALUES
(
    'account_management',
    'User wants to manage their account',
    '[
        "view my account",
        "update my profile",
        "change my address",
        "my orders",
        "order history",
        "sign out",
        "log out",
        "change password"
    ]',
    '["action"]',
    'handleAccount',
    true
);

-- 14. Help/Support Intent
INSERT INTO nlu_intents (name, description, examples, expected_entities, handler_function, requires_auth) VALUES
(
    'get_help',
    'User needs help or support',
    '[
        "help",
        "I need help",
        "contact support",
        "talk to someone",
        "customer service",
        "how do I return something",
        "shipping policy",
        "FAQ"
    ]',
    '["topic"]',
    'handleHelp',
    false
);

-- 15. Greeting Intent
INSERT INTO nlu_intents (name, description, examples, expected_entities, handler_function, requires_auth) VALUES
(
    'greeting',
    'User greets the assistant',
    '[
        "hello",
        "hi",
        "hey",
        "good morning",
        "good afternoon",
        "hi there",
        "hey there"
    ]',
    '[]',
    'handleGreeting',
    false
);

-- ============================================================================
-- NLU ENTITIES
-- ============================================================================

-- 1. Product Type Entity
INSERT INTO nlu_entities (name, description, entity_type, values) VALUES
(
    'product_type',
    'Type of product the user is looking for',
    'categorical',
    '[
        {"value": "pendant light", "synonyms": ["pendant", "hanging light", "pendant lamp", "drop light"]},
        {"value": "ceiling light", "synonyms": ["ceiling lamp", "overhead light", "ceiling fixture", "flush mount"]},
        {"value": "floor lamp", "synonyms": ["standing lamp", "floor light", "tall lamp"]},
        {"value": "table lamp", "synonyms": ["desk lamp", "bedside lamp", "accent lamp"]},
        {"value": "wall sconce", "synonyms": ["wall light", "sconce", "wall fixture"]},
        {"value": "chandelier", "synonyms": ["candelabra", "hanging chandelier"]},
        {"value": "vase", "synonyms": ["flower vase", "planter", "decorative vase"]},
        {"value": "candle", "synonyms": ["candle holder", "candleholder", "tealight"]},
        {"value": "mirror", "synonyms": ["wall mirror", "decorative mirror", "looking glass"]},
        {"value": "wall art", "synonyms": ["artwork", "painting", "print", "poster"]},
        {"value": "rug", "synonyms": ["carpet", "area rug", "floor rug", "mat"]},
        {"value": "sofa", "synonyms": ["couch", "settee", "loveseat", "sectional"]},
        {"value": "chair", "synonyms": ["accent chair", "armchair", "lounge chair"]},
        {"value": "coffee table", "synonyms": ["cocktail table", "center table"]},
        {"value": "duvet", "synonyms": ["duvet cover", "comforter", "comforter cover"]},
        {"value": "sheets", "synonyms": ["bed sheets", "sheet set", "linens"]},
        {"value": "curtains", "synonyms": ["drapes", "window treatment", "panels"]}
    ]'
);

-- 2. Style Entity
INSERT INTO nlu_entities (name, description, entity_type, values) VALUES
(
    'style',
    'Design style preference',
    'categorical',
    '[
        {"value": "modern", "synonyms": ["contemporary", "current", "sleek"]},
        {"value": "traditional", "synonyms": ["classic", "timeless", "conventional"]},
        {"value": "mid-century", "synonyms": ["mid century modern", "mcm", "retro"]},
        {"value": "industrial", "synonyms": ["factory", "warehouse", "urban"]},
        {"value": "bohemian", "synonyms": ["boho", "eclectic", "free-spirited"]},
        {"value": "minimalist", "synonyms": ["minimal", "simple", "clean"]},
        {"value": "scandinavian", "synonyms": ["nordic", "scandi"]},
        {"value": "rustic", "synonyms": ["farmhouse", "country", "cottage"]},
        {"value": "coastal", "synonyms": ["beach", "nautical", "seaside"]},
        {"value": "glam", "synonyms": ["glamorous", "luxurious", "hollywood"]},
        {"value": "transitional", "synonyms": ["blend", "mixed"]},
        {"value": "abstract", "synonyms": ["non-representational", "geometric"]}
    ]'
);

-- 3. Color Entity
INSERT INTO nlu_entities (name, description, entity_type, values) VALUES
(
    'color',
    'Color preference',
    'categorical',
    '[
        {"value": "white", "synonyms": ["off-white", "ivory", "cream", "snow"]},
        {"value": "black", "synonyms": ["ebony", "onyx", "jet"]},
        {"value": "gray", "synonyms": ["grey", "charcoal", "slate", "silver"]},
        {"value": "blue", "synonyms": ["navy", "cobalt", "azure", "teal", "turquoise"]},
        {"value": "green", "synonyms": ["olive", "sage", "emerald", "forest", "mint"]},
        {"value": "gold", "synonyms": ["brass", "golden", "amber"]},
        {"value": "brown", "synonyms": ["tan", "beige", "taupe", "espresso", "walnut"]},
        {"value": "red", "synonyms": ["burgundy", "crimson", "maroon", "wine"]},
        {"value": "pink", "synonyms": ["blush", "rose", "coral", "salmon"]},
        {"value": "purple", "synonyms": ["violet", "lavender", "plum", "mauve"]},
        {"value": "orange", "synonyms": ["terracotta", "rust", "copper", "peach"]},
        {"value": "yellow", "synonyms": ["mustard", "lemon", "sunshine"]},
        {"value": "multicolor", "synonyms": ["colorful", "multi", "rainbow"]}
    ]'
);

-- 4. Room Entity
INSERT INTO nlu_entities (name, description, entity_type, values) VALUES
(
    'room',
    'Room or space the product is for',
    'categorical',
    '[
        {"value": "living room", "synonyms": ["lounge", "family room", "sitting room", "den"]},
        {"value": "bedroom", "synonyms": ["master bedroom", "guest room"]},
        {"value": "kitchen", "synonyms": ["cooking area", "kitchenette"]},
        {"value": "dining room", "synonyms": ["dining area", "breakfast nook"]},
        {"value": "bathroom", "synonyms": ["bath", "powder room", "washroom"]},
        {"value": "office", "synonyms": ["home office", "study", "workspace", "den"]},
        {"value": "entryway", "synonyms": ["foyer", "hallway", "entrance", "mudroom"]},
        {"value": "outdoor", "synonyms": ["patio", "porch", "deck", "garden", "balcony"]},
        {"value": "nursery", "synonyms": ["baby room", "kids room", "children room"]}
    ]'
);

-- 5. Material Entity
INSERT INTO nlu_entities (name, description, entity_type, values) VALUES
(
    'material',
    'Material preference',
    'categorical',
    '[
        {"value": "wood", "synonyms": ["wooden", "timber", "oak", "walnut", "pine", "teak"]},
        {"value": "metal", "synonyms": ["iron", "steel", "aluminum"]},
        {"value": "glass", "synonyms": ["crystal", "frosted glass", "blown glass"]},
        {"value": "fabric", "synonyms": ["textile", "upholstered", "cloth"]},
        {"value": "leather", "synonyms": ["faux leather", "genuine leather", "hide"]},
        {"value": "ceramic", "synonyms": ["porcelain", "pottery", "clay"]},
        {"value": "marble", "synonyms": ["stone", "granite", "quartz"]},
        {"value": "rattan", "synonyms": ["wicker", "bamboo", "cane"]},
        {"value": "velvet", "synonyms": ["plush", "velour"]},
        {"value": "linen", "synonyms": ["flax"]},
        {"value": "cotton", "synonyms": ["organic cotton"]},
        {"value": "jute", "synonyms": ["sisal", "natural fiber", "seagrass"]}
    ]'
);

-- 6. Price Range Entity
INSERT INTO nlu_entities (name, description, entity_type, values) VALUES
(
    'price_range',
    'Budget or price preference',
    'numeric',
    '[
        {"value": "budget", "synonyms": ["cheap", "affordable", "inexpensive", "under 50", "under $50"]},
        {"value": "mid-range", "synonyms": ["moderate", "reasonable", "50 to 200", "$50-$200"]},
        {"value": "premium", "synonyms": ["expensive", "high-end", "luxury", "over 200", "above $200"]}
    ]'
);

-- 7. Size Entity
INSERT INTO nlu_entities (name, description, entity_type, values) VALUES
(
    'size',
    'Size preference',
    'categorical',
    '[
        {"value": "small", "synonyms": ["mini", "compact", "tiny", "petite"]},
        {"value": "medium", "synonyms": ["mid-size", "regular", "standard"]},
        {"value": "large", "synonyms": ["big", "oversized", "extra large", "xl"]},
        {"value": "twin", "synonyms": ["single", "twin xl"]},
        {"value": "full", "synonyms": ["double"]},
        {"value": "queen", "synonyms": []},
        {"value": "king", "synonyms": ["california king", "cal king", "eastern king"]}
    ]'
);

-- 8. Occasion Entity
INSERT INTO nlu_entities (name, description, entity_type, values) VALUES
(
    'occasion',
    'Occasion or use case',
    'categorical',
    '[
        {"value": "everyday", "synonyms": ["daily use", "regular", "casual"]},
        {"value": "entertaining", "synonyms": ["hosting", "party", "guests"]},
        {"value": "gift", "synonyms": ["present", "housewarming", "wedding gift"]},
        {"value": "seasonal", "synonyms": ["holiday", "christmas", "fall", "spring"]}
    ]'
);

-- ============================================================================
-- SEARCH SYNONYMS (for query expansion)
-- ============================================================================

INSERT INTO search_synonyms (term, synonyms, entity_type) VALUES
    ('lamp', '["light", "fixture", "lighting"]', 'product'),
    ('couch', '["sofa", "settee", "loveseat", "sectional"]', 'product'),
    ('rug', '["carpet", "mat", "floor covering", "area rug"]', 'product'),
    ('mirror', '["looking glass", "reflector", "wall mirror"]', 'product'),
    ('art', '["artwork", "painting", "print", "wall art", "picture"]', 'product'),
    ('modern', '["contemporary", "current", "sleek", "minimalist"]', 'style'),
    ('traditional', '["classic", "conventional", "timeless"]', 'style'),
    ('brass', '["gold", "golden", "warm metal"]', 'material'),
    ('white', '["ivory", "cream", "off-white", "snow"]', 'color'),
    ('living room', '["lounge", "sitting room", "family room"]', 'room'),
    ('cheap', '["affordable", "budget", "inexpensive", "under 50"]', 'price'),
    ('expensive', '["premium", "luxury", "high-end", "over 200"]', 'price');
