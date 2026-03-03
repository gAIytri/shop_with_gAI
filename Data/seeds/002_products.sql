-- ============================================================================
-- GaiEcom Seed Data: Categories & Product Types
-- Generated from JSON data files
-- ============================================================================

-- Clear existing data (careful in production!)
-- TRUNCATE categories, product_types CASCADE;

-- ============================================================================
-- CATEGORIES
-- ============================================================================

INSERT INTO categories (name, slug, description, synonyms, display_order, is_active)
VALUES (
    'Lighting',
    'lighting',
    'Illuminate your space with our curated lighting collection',
    '["lights","lamps","fixtures","illumination"]',
    1,
    TRUE
) ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    synonyms = EXCLUDED.synonyms;

INSERT INTO categories (name, slug, description, synonyms, display_order, is_active)
VALUES (
    'Decor',
    'decor',
    'Decorative accents to personalize your home',
    '["decorations","accessories","accents","home decor"]',
    2,
    TRUE
) ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    synonyms = EXCLUDED.synonyms;

INSERT INTO categories (name, slug, description, synonyms, display_order, is_active)
VALUES (
    'Art & Mirrors',
    'art',
    'Wall art and mirrors to transform any room',
    '["artwork","wall art","mirrors","paintings","prints"]',
    3,
    TRUE
) ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    synonyms = EXCLUDED.synonyms;

INSERT INTO categories (name, slug, description, synonyms, display_order, is_active)
VALUES (
    'Bedding & Textiles',
    'bedding',
    'Luxurious bedding and curtains for ultimate comfort',
    '["bed linens","sheets","comforters","textiles"]',
    4,
    TRUE
) ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    synonyms = EXCLUDED.synonyms;

INSERT INTO categories (name, slug, description, synonyms, display_order, is_active)
VALUES (
    'Furniture',
    'furniture',
    'Stylish furniture for every room',
    '["furnishings","seating","tables"]',
    5,
    TRUE
) ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    synonyms = EXCLUDED.synonyms;

INSERT INTO categories (name, slug, description, synonyms, display_order, is_active)
VALUES (
    'Rugs',
    'rugs',
    'Beautiful rugs to anchor your space',
    '["carpets","floor coverings","area rugs","mats"]',
    6,
    TRUE
) ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    synonyms = EXCLUDED.synonyms;

-- ============================================================================
-- PRODUCT TYPES (Subcategories)
-- ============================================================================

INSERT INTO product_types (category_id, name, slug, synonyms)
SELECT id, 'Ceiling Light', 'ceiling-light', '["ceiling fixture","overhead light","ceiling lamp","flush mount"]'
FROM categories WHERE slug = 'lighting'
ON CONFLICT (category_id, slug) DO UPDATE SET
    name = EXCLUDED.name,
    synonyms = EXCLUDED.synonyms;

INSERT INTO product_types (category_id, name, slug, synonyms)
SELECT id, 'Floor Lamp', 'floor-lamp', '["standing lamp","floor light","tall lamp"]'
FROM categories WHERE slug = 'lighting'
ON CONFLICT (category_id, slug) DO UPDATE SET
    name = EXCLUDED.name,
    synonyms = EXCLUDED.synonyms;

INSERT INTO product_types (category_id, name, slug, synonyms)
SELECT id, 'Table Lamp', 'table-lamp', '["desk lamp","bedside lamp","accent lamp"]'
FROM categories WHERE slug = 'lighting'
ON CONFLICT (category_id, slug) DO UPDATE SET
    name = EXCLUDED.name,
    synonyms = EXCLUDED.synonyms;

INSERT INTO product_types (category_id, name, slug, synonyms)
SELECT id, 'Wall Sconce', 'wall-sconce', '["wall light","sconce","wall fixture"]'
FROM categories WHERE slug = 'lighting'
ON CONFLICT (category_id, slug) DO UPDATE SET
    name = EXCLUDED.name,
    synonyms = EXCLUDED.synonyms;

INSERT INTO product_types (category_id, name, slug, synonyms)
SELECT id, 'Pendant Light', 'pendant', '["pendant lamp","hanging light","drop light"]'
FROM categories WHERE slug = 'lighting'
ON CONFLICT (category_id, slug) DO UPDATE SET
    name = EXCLUDED.name,
    synonyms = EXCLUDED.synonyms;

INSERT INTO product_types (category_id, name, slug, synonyms)
SELECT id, 'Vase', 'vase', '["flower vase","decorative vase","planter"]'
FROM categories WHERE slug = 'decor'
ON CONFLICT (category_id, slug) DO UPDATE SET
    name = EXCLUDED.name,
    synonyms = EXCLUDED.synonyms;

INSERT INTO product_types (category_id, name, slug, synonyms)
SELECT id, 'Candle', 'candle', '["candles","candle holder","tealight"]'
FROM categories WHERE slug = 'decor'
ON CONFLICT (category_id, slug) DO UPDATE SET
    name = EXCLUDED.name,
    synonyms = EXCLUDED.synonyms;

INSERT INTO product_types (category_id, name, slug, synonyms)
SELECT id, 'Decorative Tray', 'tray', '["serving tray","accent tray"]'
FROM categories WHERE slug = 'decor'
ON CONFLICT (category_id, slug) DO UPDATE SET
    name = EXCLUDED.name,
    synonyms = EXCLUDED.synonyms;

INSERT INTO product_types (category_id, name, slug, synonyms)
SELECT id, 'Decorative Object', 'decorative-object', '["sculpture","figurine","accent piece"]'
FROM categories WHERE slug = 'decor'
ON CONFLICT (category_id, slug) DO UPDATE SET
    name = EXCLUDED.name,
    synonyms = EXCLUDED.synonyms;

INSERT INTO product_types (category_id, name, slug, synonyms)
SELECT id, 'Wall Art', 'wall-art', '["wall decor","art print","poster"]'
FROM categories WHERE slug = 'art'
ON CONFLICT (category_id, slug) DO UPDATE SET
    name = EXCLUDED.name,
    synonyms = EXCLUDED.synonyms;

INSERT INTO product_types (category_id, name, slug, synonyms)
SELECT id, 'Canvas Art', 'canvas', '["canvas print","canvas painting"]'
FROM categories WHERE slug = 'art'
ON CONFLICT (category_id, slug) DO UPDATE SET
    name = EXCLUDED.name,
    synonyms = EXCLUDED.synonyms;

INSERT INTO product_types (category_id, name, slug, synonyms)
SELECT id, 'Mirror', 'mirror', '["wall mirror","decorative mirror","accent mirror"]'
FROM categories WHERE slug = 'art'
ON CONFLICT (category_id, slug) DO UPDATE SET
    name = EXCLUDED.name,
    synonyms = EXCLUDED.synonyms;

INSERT INTO product_types (category_id, name, slug, synonyms)
SELECT id, 'Framed Print', 'framed-print', '["framed art","framed picture"]'
FROM categories WHERE slug = 'art'
ON CONFLICT (category_id, slug) DO UPDATE SET
    name = EXCLUDED.name,
    synonyms = EXCLUDED.synonyms;

INSERT INTO product_types (category_id, name, slug, synonyms)
SELECT id, 'Duvet Cover', 'duvet', '["duvet","comforter cover","duvet set"]'
FROM categories WHERE slug = 'bedding'
ON CONFLICT (category_id, slug) DO UPDATE SET
    name = EXCLUDED.name,
    synonyms = EXCLUDED.synonyms;

INSERT INTO product_types (category_id, name, slug, synonyms)
SELECT id, 'Bedding Set', 'bedding-set', '["bed set","sheet set","linen set"]'
FROM categories WHERE slug = 'bedding'
ON CONFLICT (category_id, slug) DO UPDATE SET
    name = EXCLUDED.name,
    synonyms = EXCLUDED.synonyms;

INSERT INTO product_types (category_id, name, slug, synonyms)
SELECT id, 'Sheet Set', 'sheets', '["bed sheets","fitted sheet","flat sheet"]'
FROM categories WHERE slug = 'bedding'
ON CONFLICT (category_id, slug) DO UPDATE SET
    name = EXCLUDED.name,
    synonyms = EXCLUDED.synonyms;

INSERT INTO product_types (category_id, name, slug, synonyms)
SELECT id, 'Quilt', 'quilt', '["quilts","coverlet","bedspread"]'
FROM categories WHERE slug = 'bedding'
ON CONFLICT (category_id, slug) DO UPDATE SET
    name = EXCLUDED.name,
    synonyms = EXCLUDED.synonyms;

INSERT INTO product_types (category_id, name, slug, synonyms)
SELECT id, 'Curtain', 'curtain', '["curtains","drapes","window panel"]'
FROM categories WHERE slug = 'bedding'
ON CONFLICT (category_id, slug) DO UPDATE SET
    name = EXCLUDED.name,
    synonyms = EXCLUDED.synonyms;

INSERT INTO product_types (category_id, name, slug, synonyms)
SELECT id, 'Throw Blanket', 'throw', '["blanket","throw","afghan"]'
FROM categories WHERE slug = 'bedding'
ON CONFLICT (category_id, slug) DO UPDATE SET
    name = EXCLUDED.name,
    synonyms = EXCLUDED.synonyms;

INSERT INTO product_types (category_id, name, slug, synonyms)
SELECT id, 'Pillow', 'pillow', '["pillows","cushion","decorative pillow"]'
FROM categories WHERE slug = 'bedding'
ON CONFLICT (category_id, slug) DO UPDATE SET
    name = EXCLUDED.name,
    synonyms = EXCLUDED.synonyms;

INSERT INTO product_types (category_id, name, slug, synonyms)
SELECT id, 'Sofa', 'sofa', '["couch","settee","loveseat","sectional"]'
FROM categories WHERE slug = 'furniture'
ON CONFLICT (category_id, slug) DO UPDATE SET
    name = EXCLUDED.name,
    synonyms = EXCLUDED.synonyms;

INSERT INTO product_types (category_id, name, slug, synonyms)
SELECT id, 'Accent Chair', 'accent-chair', '["armchair","lounge chair","side chair"]'
FROM categories WHERE slug = 'furniture'
ON CONFLICT (category_id, slug) DO UPDATE SET
    name = EXCLUDED.name,
    synonyms = EXCLUDED.synonyms;

INSERT INTO product_types (category_id, name, slug, synonyms)
SELECT id, 'Coffee Table', 'coffee-table', '["cocktail table","center table"]'
FROM categories WHERE slug = 'furniture'
ON CONFLICT (category_id, slug) DO UPDATE SET
    name = EXCLUDED.name,
    synonyms = EXCLUDED.synonyms;

INSERT INTO product_types (category_id, name, slug, synonyms)
SELECT id, 'TV Stand', 'tv-stand', '["media console","entertainment center"]'
FROM categories WHERE slug = 'furniture'
ON CONFLICT (category_id, slug) DO UPDATE SET
    name = EXCLUDED.name,
    synonyms = EXCLUDED.synonyms;

INSERT INTO product_types (category_id, name, slug, synonyms)
SELECT id, 'Nightstand', 'nightstand', '["bedside table","night table"]'
FROM categories WHERE slug = 'furniture'
ON CONFLICT (category_id, slug) DO UPDATE SET
    name = EXCLUDED.name,
    synonyms = EXCLUDED.synonyms;

INSERT INTO product_types (category_id, name, slug, synonyms)
SELECT id, 'Bookcase', 'bookcase', '["bookshelf","shelving unit"]'
FROM categories WHERE slug = 'furniture'
ON CONFLICT (category_id, slug) DO UPDATE SET
    name = EXCLUDED.name,
    synonyms = EXCLUDED.synonyms;

INSERT INTO product_types (category_id, name, slug, synonyms)
SELECT id, 'Indoor Rug', 'indoor-rug', '["area rug","living room rug"]'
FROM categories WHERE slug = 'rugs'
ON CONFLICT (category_id, slug) DO UPDATE SET
    name = EXCLUDED.name,
    synonyms = EXCLUDED.synonyms;

INSERT INTO product_types (category_id, name, slug, synonyms)
SELECT id, 'Indoor/Outdoor Rug', 'indoor-outdoor-rug', '["outdoor rug","patio rug"]'
FROM categories WHERE slug = 'rugs'
ON CONFLICT (category_id, slug) DO UPDATE SET
    name = EXCLUDED.name,
    synonyms = EXCLUDED.synonyms;

INSERT INTO product_types (category_id, name, slug, synonyms)
SELECT id, 'Natural Fiber Rug', 'natural-fiber-rug', '["jute rug","sisal rug"]'
FROM categories WHERE slug = 'rugs'
ON CONFLICT (category_id, slug) DO UPDATE SET
    name = EXCLUDED.name,
    synonyms = EXCLUDED.synonyms;

INSERT INTO product_types (category_id, name, slug, synonyms)
SELECT id, 'Reversible Rug', 'reversible-rug', '["double-sided rug"]'
FROM categories WHERE slug = 'rugs'
ON CONFLICT (category_id, slug) DO UPDATE SET
    name = EXCLUDED.name,
    synonyms = EXCLUDED.synonyms;

-- ============================================================================
-- PRODUCTS
-- ============================================================================

-- ----------------------------------------------------------------------------
-- Lighting (34 products)
-- ----------------------------------------------------------------------------

-- Product: Modern Globe Pendant
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'LGT-CL-001',
    'Modern Globe Pendant',
    'Sleek glass globe pendant light with brass accents for contemporary spaces',
    159.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'ceiling-light' AND category_id = c.id),
    25,
    'in_stock'::stock_status,
    '{"color":["Warm Brass","Frosted White"],"material":["Glass","Brass"],"style":["Modern","Contemporary"],"room":["Living Room","Dining Room","Kitchen"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Warm Brass","hex":"#B8860B","category":"primary"},{"name":"Frosted White","hex":"#F5F5F5","category":"secondary"}],"pattern":"solid","texture":"smooth","finish":"matte","shape":"organic","silhouette":"Cluster of globes with intersecting brass rods"}',
    '{"short":"Chic globe pendant light featuring frosted glass and brass accents for a modern touch.","long":"Illuminate your home with the Modern Globe Pendant, an exquisite blend of style and function. This lighting fixture boasts a sleek design with multiple frosted glass globes, gracefully suspended by warm brass accents. Perfect for contemporary interiors, its multi-directional lighting offers a sophisticated ambiance, whether in your living room, dining area, or kitchen. The elegant silhouette of clustered globes intertwined with brass rods adds a touch of luxury and modernity to any space. Its versatile design ensures it complements various decor themes, making it a must-have for those looking to enhance their home with chic and functional lighting.","features":["Sleek frosted glass globes","Elegant warm brass accents","Versatile multi-directional lighting","Sophisticated modern design","Ideal for living rooms, dining areas, and kitchens","Enhances contemporary interiors","Easy installation"],"careInstructions":"Wipe with a soft, dry cloth. Avoid using harsh chemicals or abrasive cleaners to maintain the finish.","materialComposition":"Constructed with frosted glass globes and sturdy brass metal accents"}',
    '["pendant","globe","modern","brass","glass","pendant light","globe design","modern lighting","brass accents","frosted glass","ceiling fixture","contemporary style","multi-directional light","ambient lighting","living room light","dining room light","kitchen light","elegant design","home decor","interior lighting","stylish fixture","versatile lighting","chic appearance","sophisticated ambiance","modern interiors","modern globe pendant","lighting fixture","frosted glass globes","contemporary lighting","multi-directional lighting","elegant pendant light","chic lighting","modern design","luxury lighting","cluster design","warm brass finish","organic silhouette","matte finish","smooth texture","solid pattern"]',
    '{"metaTitle":"Modern Globe Pendant - Chic Lighting with Brass Accents","metaDescription":"Illuminate your space with the Modern Globe Pendant. Enjoy chic design and multi-directional lighting. Perfect for any room. Shop now for elegance!","altText":"Elegant modern globe pendant light featuring frosted glass globes and warm brass accents.","keywords":["modern globe pendant","lighting fixture","brass accents","frosted glass globes","contemporary lighting","multi-directional lighting","ambient lighting","living room light","dining room light","kitchen light","elegant pendant light","chic lighting","stylish fixture","home decor","interior lighting","modern design","versatile lighting","luxury lighting","sophisticated ambiance","pendant light","ceiling fixture","cluster design","warm brass finish","organic silhouette","matte finish","smooth texture","solid pattern"]}',
    TRUE,
    FALSE,
    4.7,
    89,
    TRUE,
    '2024-01-15T00:00:00Z',
    '2024-01-15T00:00:00Z'
FROM categories c
WHERE c.slug = 'lighting'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Industrial Cage Pendant
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'LGT-CL-002',
    'Industrial Cage Pendant',
    'Vintage-inspired industrial cage pendant with Edison bulb compatibility',
    89.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'ceiling-light' AND category_id = c.id),
    42,
    'in_stock'::stock_status,
    '{"color":["Polished Chrome"],"material":["Chrome Metal"],"style":["Modern","Contemporary"],"room":["Kitchen","Dining Room","Office"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Polished Chrome","hex":"#C0C0C0","category":"primary"}],"pattern":"solid","texture":"smooth","finish":"glossy","shape":"organic","silhouette":"Fluid, sculptural form with clean lines"}',
    '{"short":"Stylish industrial pendant light with a cage design, perfect for modern spaces.","long":"Illuminate your space with the Industrial Cage Pendant, a bold statement in modern lighting design. This striking piece features a robust cage structure crafted from durable metal, providing a touch of industrial elegance to any room. The exposed bulb design casts a warm glow, creating an inviting ambiance ideal for kitchens, dining rooms, or loft-style living areas. The matte black finish adds a contemporary edge, effortlessly blending with various decor styles. Hang this pendant solo for a focal point or in multiples for a dramatic effect, and transform your home with its unique charm.","features":["Durable metal cage design","Exposed bulb for ambient lighting","Matte black finish for modern appeal","Perfect for kitchens, dining rooms, and lofts","Easy installation with adjustable height","Compatible with multiple bulb types","Versatile use in residential or commercial spaces"],"careInstructions":"Dust regularly with a soft cloth. Avoid using abrasive cleaners or water on the metal finish.","materialComposition":"Made from high-quality steel with a matte black coating"}',
    '["industrial","cage","vintage","edison","pendant","modern lighting","chrome pendant","organic design","ambient light","sculptural light","contemporary decor","reflective finish","high-gloss lighting","sleek pendant","artistic lighting","interior design","home decor","stylish light","unique pendant","fluid shape","designer lighting","luxury light","kitchen lighting","dining room light","office pendant","ambient illumination","statement piece","decorative lighting","modern pendant","chrome finish","elegant light","architectural light","minimalist design","contemporary style","functional art","high-end lighting","industrial cage pendant","matte black pendant","exposed bulb lighting","kitchen pendant light","dining room lighting","loft-style pendant","industrial elegance","bold lighting design","robust cage structure","ambient lighting","statement lighting","unique pendant light","industrial style light","interior lighting","elegant pendant","stylish pendant","home transformation"]',
    '{"metaTitle":"Industrial Cage Pendant - Modern Lighting with Matte Black Finish","metaDescription":"Transform your space with the Industrial Cage Pendant. Its robust cage design and matte black finish add an industrial edge. Perfect for kitchens and dining rooms.","altText":"Industrial Cage Pendant with matte black finish and exposed bulb design.","keywords":["industrial cage pendant","modern lighting","matte black pendant","exposed bulb lighting","kitchen pendant light","dining room lighting","loft-style pendant","contemporary decor","industrial elegance","bold lighting design","robust cage structure","ambient lighting","home decor","statement lighting","unique pendant light","modern pendant","industrial style light","decorative lighting","interior lighting","elegant pendant","ambient illumination","designer lighting","stylish pendant","architectural light","minimalist design","high-end lighting","functional art","luxury light","statement piece","home transformation"]}',
    FALSE,
    TRUE,
    4.5,
    156,
    TRUE,
    '2024-01-12T00:00:00Z',
    '2024-01-12T00:00:00Z'
FROM categories c
WHERE c.slug = 'lighting'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Rattan Dome Pendant
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'LGT-CL-003',
    'Rattan Dome Pendant',
    'Handwoven rattan dome pendant bringing natural warmth to any room',
    129.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'ceiling-light' AND category_id = c.id),
    18,
    'in_stock'::stock_status,
    '{"color":["Warm White"],"material":["Metal","Acrylic"],"style":["Modern","Contemporary"],"room":["Living Room","Bedroom","Dining Room"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Warm White","hex":"#F5F5DC","category":"primary"}],"pattern":"solid","texture":"smooth","finish":"matte","shape":"organic","silhouette":"Layered with flowing lines"}',
    '{"short":"Illuminate your space with the chic Rattan Dome Pendant, offering warm, natural ambiance.","long":"Transform your home with the Rattan Dome Pendant, a stunning focal point that combines natural charm with modern elegance. Handcrafted from high-quality rattan, its dome shape casts a beautifully diffused light, creating a warm and inviting atmosphere. Whether hanging over a dining table or in a cozy reading nook, its organic texture and neutral tones complement any decor style, from rustic to contemporary. This pendant light not only enhances your home''s aesthetic but also provides functional ambient lighting, making it a versatile choice for any room.","features":["Handcrafted from high-quality rattan","Dome shape for diffused lighting","Warm, natural ambiance","Versatile design complements various decor styles","Ideal for dining areas, living rooms, or reading nooks","Easy to install with adjustable hanging height"],"careInstructions":"Dust gently with a soft cloth. Avoid exposure to excessive moisture. Use a mild cleaner if needed, avoiding harsh chemicals.","materialComposition":"100% natural rattan with a metal frame for durability."}',
    '["rattan","bohemian","natural","handwoven","dome","modern lighting","ceiling light","ambient glow","organic design","layered light","contemporary","home decor","interior lighting","stylish ceiling light","warm light","versatile","living room light","bedroom light","dining room light","smooth finish","matte finish","metal","acrylic","unique design","flowing lines","ambient atmosphere","modern aesthetic","home improvement","lighting fixture","decorative light","soft glow","elegant design","statement piece","designer light","artistic lighting","minimalist","sleek design","contemporary style","home lighting","interior design","stylish decor","functional lighting","ambient effect","eye-catching","Rattan Dome Pendant","versatile lighting","metal light fixture","acrylic light fixture","minimalist lighting","eye-catching light"]',
    '{"metaTitle":"Rattan Dome Pendant - Modern Elegance with Ambient Glow","metaDescription":"Illuminate your space with the Rattan Dome Pendant. Handcrafted elegance meets modern design. Perfect for any room. Shop now for style and function.","altText":"Rattan Dome Pendant light fixture with modern layered design and warm ambient glow.","keywords":["Rattan Dome Pendant","modern lighting","ceiling light","ambient glow","organic design","layered light","contemporary style","home decor","interior lighting","stylish ceiling light","warm light","versatile lighting","living room light","bedroom light","dining room light","smooth finish","matte finish","metal light fixture","acrylic light fixture","unique design","flowing lines","ambient atmosphere","modern aesthetic","home improvement","decorative light","soft glow","elegant design","statement piece","designer light","artistic lighting","minimalist lighting","sleek design","home lighting","interior design","stylish decor","functional lighting","ambient effect","eye-catching light"]}',
    TRUE,
    FALSE,
    4.8,
    67,
    TRUE,
    '2024-01-18T00:00:00Z',
    '2024-01-18T00:00:00Z'
FROM categories c
WHERE c.slug = 'lighting'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Crystal Chandelier
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'LGT-CL-004',
    'Crystal Chandelier',
    'Elegant crystal chandelier with chrome finish for luxurious spaces',
    399.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'ceiling-light' AND category_id = c.id),
    8,
    'in_stock'::stock_status,
    '{"color":["Chrome","Clear"],"material":["Crystal","Metal"],"style":["Glamorous","Traditional"],"room":["Dining Room","Foyer","Bedroom"],"occasion":["Entertaining","Formal Events"]}',
    '{"primaryColors":[{"name":"Chrome","hex":"#B0B0B0","category":"primary"},{"name":"Clear","hex":"#FFFFFF","category":"accent"}],"pattern":"solid","texture":"smooth","finish":"gloss","shape":"organic","silhouette":"Intricate with cascading crystals"}',
    '{"short":"Graceful crystal chandelier with a shimmering chrome finish.","long":"Add a touch of opulence to your home with our Crystal Chandelier, a dazzling masterpiece featuring a sophisticated chrome finish. This exquisite piece boasts an intricate array of sparkling crystals that capture and refract light beautifully, casting a radiant, shimmering glow across any room. Perfect for dining rooms, foyers, or bedrooms, this chandelier is crafted from high-quality metal and crystal, ensuring enduring elegance and durability. Its timeless design complements both traditional and contemporary décor styles, making it a versatile and eye-catching centerpiece. Elevate your space with this stunning chandelier and enjoy the luxurious ambiance it creates.","features":["Sophisticated chrome finish","Dazzling crystal arrangement","Timeless, elegant design","High-quality, durable materials","Ideal for dining rooms, foyers, and bedrooms","Versatile for traditional and modern spaces","Creates a radiant, shimmering glow"],"careInstructions":"Dust regularly using a soft cloth. Avoid abrasive cleaners. Gently wipe crystals with a damp cloth as needed for extra shine.","materialComposition":"Crafted from premium crystal and sturdy metal."}',
    '["chandelier","crystal","glamorous","elegant","chrome","luxury lighting","dining room light","foyer chandelier","bedroom lighting","sparkling","decorative light","ceiling fixture","home decor","interior design","traditional style","metal and crystal","ambient lighting","statement piece","luxurious","high-end","classic design","timeless","refined","sophisticated","decorative","ornate","multi-light","bright","shimmering","eye-catching","crystal chandelier","chrome chandelier","elegant lighting","dining room chandelier","foyer lighting","bedroom chandelier","sparkling chandelier","decorative lighting","traditional chandelier","metal and crystal lighting","statement chandelier","luxurious chandelier","high-end lighting","classic chandelier design","timeless chandelier","refined lighting","sophisticated chandelier","ornate chandelier","multi-light chandelier","bright chandelier","shimmering chandelier","eye-catching chandelier"]',
    '{"metaTitle":"Crystal Chandelier - Luxurious Chrome Finish & Sparkling Crystals","metaDescription":"Elevate your home''s ambiance with our Crystal Chandelier. Featuring a luxurious chrome finish and sparkling crystals, it''s perfect for any elegant space. Shop now!","altText":"Elegant crystal chandelier with a luxurious chrome finish and sparkling crystals.","keywords":["crystal chandelier","luxury lighting","chrome chandelier","elegant lighting","dining room chandelier","foyer lighting","bedroom chandelier","sparkling chandelier","decorative lighting","ceiling fixture","home decor","interior design","traditional chandelier","metal and crystal lighting","ambient lighting","statement chandelier","luxurious chandelier","high-end lighting","classic chandelier design","timeless chandelier","refined lighting","sophisticated chandelier","ornate chandelier","multi-light chandelier","bright chandelier","shimmering chandelier","eye-catching chandelier"]}',
    TRUE,
    FALSE,
    4.9,
    45,
    TRUE,
    '2024-01-20T00:00:00Z',
    '2024-01-20T00:00:00Z'
FROM categories c
WHERE c.slug = 'lighting'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Minimalist Flush Mount
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'LGT-CL-005',
    'Minimalist Flush Mount',
    'Ultra-thin LED flush mount light for modern minimalist interiors',
    119.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'ceiling-light' AND category_id = c.id),
    35,
    'in_stock'::stock_status,
    '{"color":["Golden Yellow","Emerald Green"],"material":["Glass","Ceramic"],"style":["Artistic","Bohemian"],"room":["Dining Room","Living Room"],"occasion":["Entertaining","Ambient Lighting"]}',
    '{"primaryColors":[{"name":"Golden Yellow","hex":"#FFD700","category":"primary"},{"name":"Emerald Green","hex":"#50C878","category":"secondary"}],"pattern":"mosaic","texture":"textured","finish":"glossy","shape":"organic","silhouette":"Bulbous with mosaic pattern"}',
    '{"short":"Sleek and sophisticated, the Minimalist Flush Mount illuminates spaces with a modern, understated elegance.","long":"Elevate your home’s ambiance with the Minimalist Flush Mount, a perfect fusion of style and functionality. Its sleek, low-profile design seamlessly integrates into any ceiling, offering a modern aesthetic that complements a variety of decor styles. Crafted with precision, this flush mount provides ample lighting with its warm, diffused glow, ideal for creating a serene atmosphere in living rooms, bedrooms, or hallways. The unobtrusive silhouette ensures it blends effortlessly into your space while making a subtle statement. With its easy installation and timeless appeal, this lighting solution is both practical and chic, making it an excellent choice for those who appreciate refined simplicity.","features":["Sleek, low-profile design","Warm, diffused illumination","Ideal for living rooms, bedrooms, and hallways","Easy installation process","Timeless, modern aesthetic","Energy-efficient lighting solution"],"careInstructions":"Wipe with a soft, damp cloth to remove dust. Avoid using harsh chemicals or abrasive materials.","materialComposition":"Metal frame with a matte finish, frosted glass diffuser"}',
    '["flush mount","LED","minimalist","modern","slim","mosaic light","pendant lighting","artistic design","ambient light","decorative lighting","bohemian style","glass tiles","ceramic tiles","warm glow","elegant lighting","interior decor","home lighting","unique design","colorful lighting","handcrafted","artistic lighting","living room light","dining room light","stylish lighting","modern lighting","decorative pendant","ambient glow","home decor","creative lighting","designer light","luxury lighting","chic lighting","sophisticated lighting","vibrant colors","eye-catching design","statement piece","minimalist flush mount","ceiling light","living room lighting","bedroom lighting","hallway lighting","sleek design light","low-profile ceiling light","ambient lighting","home decor lighting","flush mount light","contemporary lighting","stylish ceiling fixture","easy installation light","warm diffused glow","refined simplicity lighting","modern aesthetic light","unobtrusive ceiling light","serene atmosphere light","practical chic lighting","timeless appeal light","elegant flush mount","functional lighting solution","subtle statement light","complementary decor light","home ambiance lighting","lighting for modern homes","chic flush mount"]',
    '{"metaTitle":"Minimalist Flush Mount - Sleek, Modern Lighting Fixture","metaDescription":"Enhance your home''s ambiance with the Minimalist Flush Mount. Enjoy easy installation and a warm glow. Perfect for living rooms and bedrooms. Buy now!","altText":"Minimalist Flush Mount with sleek design and warm glow for modern decor.","keywords":["minimalist flush mount","modern lighting","ceiling light","living room lighting","bedroom lighting","hallway lighting","sleek design light","low-profile ceiling light","ambient lighting","home decor lighting","flush mount light","contemporary lighting","stylish ceiling fixture","easy installation light","warm diffused glow","refined simplicity lighting","modern aesthetic light","unobtrusive ceiling light","serene atmosphere light","practical chic lighting","timeless appeal light","elegant flush mount","functional lighting solution","subtle statement light","complementary decor light","home ambiance lighting","lighting for modern homes","chic flush mount"]}',
    FALSE,
    TRUE,
    4.6,
    198,
    TRUE,
    '2024-01-08T00:00:00Z',
    '2024-01-08T00:00:00Z'
FROM categories c
WHERE c.slug = 'lighting'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Sputnik Chandelier
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'LGT-CL-006',
    'Sputnik Chandelier',
    'Mid-century inspired sputnik chandelier with multiple arms',
    279.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'ceiling-light' AND category_id = c.id),
    12,
    'in_stock'::stock_status,
    '{"color":["Copper Gold","Black"],"material":["Metal"],"style":["Mid-Century Modern","Retro"],"room":["Living Room","Dining Room","Office"],"occasion":["Entertaining","Everyday"]}',
    '{"primaryColors":[{"name":"Copper Gold","hex":"#B87333","category":"primary"},{"name":"Black","hex":"#000000","category":"accent"}],"pattern":"solid","texture":"glossy","finish":"polished","shape":"organic","silhouette":"Cluster of spherical forms with clean lines"}',
    '{"short":"Elegant mid-century Sputnik chandelier with reflective metallic spheres, perfect for ambient lighting.","long":"Illuminate your space with the iconic elegance of the Sputnik Chandelier. This masterpiece of mid-century modern design features an array of reflective metallic spheres that radiate light in captivating directions, creating a stunning interplay of shadows and brilliance. Perfect for living rooms, dining areas, or offices, its luxurious copper gold finish and organic cluster silhouette add a sophisticated touch to any decor. Whether hosting guests or enjoying a quiet evening, this chandelier offers ambient lighting that transforms your space into a stylish haven.","features":["Mid-century modern design","Reflective metallic spheres","Luxurious copper gold finish","Ambient lighting for any room","Organic cluster silhouette","Perfect for living rooms, dining rooms, or offices","Multiple arms for even light distribution"],"careInstructions":"Wipe gently with a soft, dry cloth to maintain shine. Avoid harsh chemicals and abrasive materials.","materialComposition":"Constructed from high-quality metal spheres with a polished reflective finish"}',
    '["sputnik","mid-century","chandelier","gold","retro","metallic","ambient lighting","modern decor","reflective","luxury lighting","living room","dining room","office","elegant","sophisticated","design","interior","home decor","ceiling light","unique","stylish","contemporary","artistic","statement piece","decorative","lighting fixture","modern","black","polished finish","organic shape","cluster design","Sputnik chandelier","mid-century modern lighting","retro chandelier","metallic lighting fixture","living room chandelier","dining room lighting","office decor","elegant chandelier","sophisticated lighting","interior design","stylish lighting","contemporary chandelier","artistic lighting","statement lighting piece","decorative chandelier","gold chandelier","black accent lighting","polished finish chandelier","organic shape lighting","cluster design chandelier"]',
    '{"metaTitle":"Sputnik Chandelier: Mid-Century Elegance in Copper Gold","metaDescription":"Elevate your decor with the Sputnik Chandelier''s luxurious copper gold finish and iconic mid-century design. Perfect for stylish living rooms or offices. Buy now!","altText":"Elegant Sputnik chandelier with reflective metallic spheres in copper gold finish.","keywords":["Sputnik chandelier","mid-century modern lighting","retro chandelier","metallic lighting fixture","ambient lighting","luxury lighting","living room chandelier","dining room lighting","office decor","elegant chandelier","sophisticated lighting","interior design","home decor","ceiling light","stylish lighting","contemporary chandelier","artistic lighting","statement lighting piece","decorative chandelier","modern decor","gold chandelier","black accent lighting","polished finish chandelier","organic shape lighting","cluster design chandelier"]}',
    TRUE,
    FALSE,
    4.7,
    78,
    TRUE,
    '2024-01-22T00:00:00Z',
    '2024-01-22T00:00:00Z'
FROM categories c
WHERE c.slug = 'lighting'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Fabric Drum Pendant
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'LGT-CL-007',
    'Fabric Drum Pendant',
    'Classic fabric drum shade pendant in neutral tones',
    149.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'ceiling-light' AND category_id = c.id),
    28,
    'in_stock'::stock_status,
    '{"color":["Pure White"],"material":["Metal"],"style":["Modern","Minimalist"],"room":["Bedroom","Living Room","Dining Room"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Pure White","hex":"#FFFFFF","category":"primary"}],"pattern":"solid","texture":"smooth","finish":"matte","shape":"round","silhouette":"Low-profile with clean lines"}',
    '{"short":"Transform any room with the sophisticated Fabric Drum Pendant, offering modern elegance and warm illumination.","long":"Introducing the Fabric Drum Pendant, a striking piece that seamlessly blends modern design with timeless elegance. Its cylindrical fabric shade casts a warm, inviting glow, perfect for creating a cozy atmosphere in any room. The pendant''s minimalist silhouette, complemented by its sleek metal fittings, makes it a versatile addition to both contemporary and classic interiors. Hang it above your dining table or in your living room to instantly elevate your space with its chic presence. At $149.99, this pendant light not only illuminates your home but also serves as a statement piece that enhances your decor.","features":["Cylindrical fabric shade for soft lighting","Modern and minimalist design","Versatile for various room styles","Sleek metal fittings","Warm ambient glow","Easy installation","Adjustable hanging length"],"careInstructions":"Dust regularly with a soft cloth. Use a mild cleaner for fabric stains. Avoid harsh chemicals on metal parts.","materialComposition":"Fabric shade with metal frame and fittings"}',
    '["drum","fabric","pendant","classic","neutral","flush mount","white light","modern lighting","minimalist design","ambient light","bedroom light","living room light","dining room light","elegant lighting","sleek design","versatile light","home decor","ceiling light","round light","matte finish","clean lines","low-profile","neutral tones","classic style","metal frame","Fabric Drum Pendant","pendant light","contemporary interiors","cozy atmosphere","chic lighting","versatile lighting","metal fittings","cylindrical shade","warm glow","statement piece","modern design","flush mount light"]',
    '{"metaTitle":"Fabric Drum Pendant - Modern Elegance & Warm Glow","metaDescription":"Elevate your space with the Fabric Drum Pendant. Its modern design and warm glow create a cozy atmosphere. Shop now for stylish lighting at $149.99!","altText":"Fabric Drum Pendant with a sleek metal frame and warm fabric shade.","keywords":["Fabric Drum Pendant","modern lighting","elegant lighting","pendant light","home decor","ambient light","contemporary interiors","minimalist design","cozy atmosphere","dining room light","living room light","bedroom light","chic lighting","versatile lighting","metal fittings","cylindrical shade","warm glow","statement piece","modern design","classic style","flush mount light","sleek design","round light","matte finish","clean lines","low-profile","neutral tones"]}',
    FALSE,
    FALSE,
    4.4,
    112,
    TRUE,
    '2024-01-14T00:00:00Z',
    '2024-01-14T00:00:00Z'
FROM categories c
WHERE c.slug = 'lighting'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Geometric Metal Pendant
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'LGT-CL-008',
    'Geometric Metal Pendant',
    'Geometric cage pendant with angular metal frame design',
    169.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'ceiling-light' AND category_id = c.id),
    20,
    'in_stock'::stock_status,
    '{"color":["Matte Black","Warm Gold"],"material":["Metal"],"style":["Modern","Geometric"],"room":["Living Room","Foyer","Dining Room"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Matte Black","hex":"#1C1C1C","category":"primary"},{"name":"Warm Gold","hex":"#FFD700","category":"accent"}],"pattern":"geometric","texture":"textured","finish":"matte","shape":"drum","silhouette":"Low-profile with clean lines"}',
    '{"short":"Illuminate your space with the geometric elegance of this metal pendant light.","long":"Transform your living room, foyer, or dining area with the Geometric Metal Pendant. Its chic angular design with a matte black and warm gold finish creates a statement piece that adds sophistication to any modern interior. The drum-shaped shade, adorned with an intricate geometric pattern, casts mesmerizing shadows that dance across your walls, generating a cozy and inviting atmosphere. Crafted from durable metal, this pendant ensures lasting quality while its open design maximizes light diffusion, enhancing your space with a warm glow.","features":["Striking geometric angular design","Matte black and warm gold finish","Drum-shaped shade with intricate pattern","Captivating shadow casting for warm ambiance","Durable metal construction","Ideal for modern interiors","Ample light diffusion"],"careInstructions":"Wipe with a soft, dry cloth. Avoid abrasive cleaners to maintain finish quality.","materialComposition":"Metal frame with a matte black and warm gold finish"}',
    '["geometric","metal","pendant","modern","angular","lighting","ceiling light","black","gold","drum shade","home decor","interior design","ambient light","stylish","sophisticated","durable","patterned","warm ambiance","living room","foyer","dining room","contemporary","unique design","shadow casting","light fixture","home lighting","modern lighting","metal pendant","angular design","geometric pendant","metal pendant light","angular design lighting","chic lighting","black and gold pendant","drum shade pendant","sophisticated lighting","home decor lighting","interior design light","ambient lighting","stylish pendant light","durable metal light","shadow casting pendant","warm ambiance light","living room pendant","foyer lighting","dining room light","contemporary pendant","unique design lighting","ceiling light fixture","home lighting solution","modern pendant","metal construction light","geometric pattern light","matte finish pendant","textured design light","statement piece lighting"]',
    '{"metaTitle":"Geometric Metal Pendant - Chic Angular Design Lighting","metaDescription":"Upgrade your space with the Geometric Metal Pendant. Its chic angular design and warm glow create a sophisticated ambiance. Shop now for modern elegance!","altText":"Geometric metal pendant light with angular design, matte black and gold finish, drum shade casting shadows.","keywords":["geometric pendant","metal pendant light","angular design lighting","modern lighting","chic lighting","black and gold pendant","drum shade pendant","sophisticated lighting","home decor lighting","interior design light","ambient lighting","stylish pendant light","durable metal light","shadow casting pendant","warm ambiance light","living room pendant","foyer lighting","dining room light","contemporary pendant","unique design lighting","ceiling light fixture","home lighting solution","modern pendant","metal construction light","geometric pattern light","matte finish pendant","textured design light","statement piece lighting"]}',
    FALSE,
    FALSE,
    4.5,
    64,
    TRUE,
    '2024-01-16T00:00:00Z',
    '2024-01-16T00:00:00Z'
FROM categories c
WHERE c.slug = 'lighting'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Arc Floor Lamp
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'LGT-FL-001',
    'Arc Floor Lamp',
    'Dramatic arched floor lamp with marble base and drum shade',
    249.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'floor-lamp' AND category_id = c.id),
    15,
    'in_stock'::stock_status,
    '{"color":["Warm Ivory","Matte Black"],"material":["Resin","Metal"],"style":["Modern","Contemporary"],"room":["Living Room","Bedroom","Reading Nook"],"occasion":["Everyday","Relaxation"]}',
    '{"primaryColors":[{"name":"Warm Ivory","hex":"#F5E9DA","category":"primary"},{"name":"Matte Black","hex":"#2C2C2C","category":"accent"}],"pattern":"solid","texture":"smooth","finish":"matte","shape":"organic","silhouette":"Tall and sculptural with flowing lines"}',
    '{"short":"Elegant sculptural floor lamp with organic form and warm glow.","long":"Illuminate your home with the sophisticated elegance of the Arc Floor Lamp. Its striking sculptural design features an organic, flowing silhouette that seamlessly integrates into modern and contemporary interiors. Bathe your living room, bedroom, or reading nook in a warm, ambient glow that transforms any space into a cozy haven. Crafted from high-quality materials, this lamp promises durability and style, making it the perfect statement piece to elevate your decor. Stand out with its unique shape and soft lighting, whether you''re unwinding with a book or entertaining guests. Experience the blend of artistry and functionality with this exceptional lamp.","features":["Striking sculptural design","Organic flowing silhouette","Warm ambient glow","Durable high-quality materials","Perfect for modern and contemporary spaces","Creates cozy atmosphere","Ideal statement piece"],"careInstructions":"Dust regularly with a soft cloth. Avoid using harsh chemicals to maintain the lamp''s finish and appearance.","materialComposition":"Crafted from durable resin for the shade, complemented by a sturdy metal base."}',
    '["arc","floor lamp","marble","dramatic","modern","sculptural lamp","ambient lighting","modern decor","contemporary design","organic shape","warm glow","statement piece","living room lighting","bedroom lamp","reading nook light","artistic lamp","unique design","home decor","interior lighting","soft lighting","elegant lamp","stylish lighting","decorative lamp","high-quality materials","modern floor lamp","contemporary floor lamp","ambient lamp","sculptural lighting","organic design","warm ivory","matte black","smooth texture","solid pattern","matte finish","organic silhouette","Arc Floor Lamp"]',
    '{"metaTitle":"Arc Floor Lamp - Elegant Sculptural Design & Warm Glow","metaDescription":"Transform any space with the Arc Floor Lamp''s elegant design and warm glow. Perfect for modern interiors. Shop now for style and durability!","altText":"Arc Floor Lamp with elegant sculptural design and warm ambient glow, perfect for modern interiors.","keywords":["Arc Floor Lamp","sculptural lamp","modern decor","ambient lighting","contemporary design","organic shape","living room lighting","bedroom lamp","reading nook light","artistic lamp","unique design","home decor","interior lighting","soft lighting","elegant lamp","stylish lighting","decorative lamp","high-quality materials","modern floor lamp","contemporary floor lamp","ambient lamp","sculptural lighting","organic design","warm ivory","matte black","smooth texture","solid pattern","matte finish","organic silhouette"]}',
    TRUE,
    TRUE,
    4.8,
    234,
    TRUE,
    '2024-01-10T00:00:00Z',
    '2024-01-10T00:00:00Z'
FROM categories c
WHERE c.slug = 'lighting'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Tripod Floor Lamp
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'LGT-FL-002',
    'Tripod Floor Lamp',
    'Wooden tripod floor lamp with linen shade for cozy ambiance',
    179.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'floor-lamp' AND category_id = c.id),
    22,
    'in_stock'::stock_status,
    '{"color":["Black","Beige"],"material":["Metal","Linen"],"style":["Modern","Contemporary"],"room":["Living Room","Bedroom","Office"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Black","hex":"#000000","category":"primary"},{"name":"Beige","hex":"#F5F5DC","category":"accent"}],"pattern":"solid","texture":"smooth","finish":"matte","shape":"organic","silhouette":"Tall with a circular design and clean lines"}',
    '{"short":"Stylish tripod floor lamp with a sleek matte finish and warm linen shade.","long":"Transform your living space with our elegant Tripod Floor Lamp, designed to elevate any room with its modern charm. Featuring a unique tripod base finished in sleek matte black, this lamp offers both stability and style. The warm beige linen shade diffuses light softly, creating a cozy ambiance perfect for relaxing evenings or sophisticated gatherings. With its versatile design, this lamp effortlessly complements contemporary or classic decor, making it an ideal choice for living rooms, bedrooms, or home offices. Illuminate your space with a touch of elegance and functional beauty.","features":["Unique tripod base for stability","Sleek matte black finish","Warm beige linen shade","Soft light diffusion for cozy ambiance","Versatile for various decor styles","Ideal for living rooms, bedrooms, and offices"],"careInstructions":"Dust regularly with a soft, dry cloth. Avoid using water or cleaning solutions on the metal base. Spot clean the shade as needed.","materialComposition":"Metal base with a linen fabric shade"}',
    '["tripod","wooden","floor lamp","scandinavian","cozy","modern lighting","contemporary design","black lamp","linen shade","living room lighting","bedroom lamp","office decor","ambient lighting","unique design","home decor","stylish lamp","elegant lighting","interior design","decorative lamp","tall lamp","sophisticated lighting","cozy ambiance","matte finish","metal base","tripod floor lamp","modern floor lamp","contemporary lighting","black floor lamp","linen shade lamp","bedroom floor lamp","office decor lamp","unique design lamp","home decor lighting","stylish floor lamp","interior design lamp","decorative floor lamp","tall floor lamp","cozy ambiance lamp","matte finish lamp","metal base floor lamp","modern silhouette lamp","beige shade floor lamp","sturdy construction lamp","organic shape lamp","floor lamp for living room","floor lamp for bedroom","floor lamp for office","elegant tripod lamp","floor lamp with linen shade"]',
    '{"metaTitle":"Elegant Tripod Floor Lamp - Modern Charm & Cozy Ambiance","metaDescription":"Elevate your room with our Tripod Floor Lamp. Its matte black finish and beige linen shade create a cozy ambiance. Perfect for any decor. Order now!","altText":"Elegant tripod floor lamp with matte black base and beige linen shade","keywords":["tripod floor lamp","modern floor lamp","contemporary lighting","black floor lamp","linen shade lamp","living room lighting","bedroom floor lamp","office decor lamp","ambient lighting","unique design lamp","home decor lighting","stylish floor lamp","elegant lighting","interior design lamp","decorative floor lamp","tall floor lamp","sophisticated lighting","cozy ambiance lamp","matte finish lamp","metal base floor lamp","modern silhouette lamp","beige shade floor lamp","sturdy construction lamp","organic shape lamp","floor lamp for living room","floor lamp for bedroom","floor lamp for office","elegant tripod lamp","floor lamp with linen shade"]}',
    FALSE,
    FALSE,
    4.6,
    145,
    TRUE,
    '2024-01-12T00:00:00Z',
    '2024-01-12T00:00:00Z'
FROM categories c
WHERE c.slug = 'lighting'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Industrial Task Floor Lamp
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'LGT-FL-003',
    'Industrial Task Floor Lamp',
    'Adjustable industrial floor lamp perfect for reading and task lighting',
    159.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'floor-lamp' AND category_id = c.id),
    30,
    'in_stock'::stock_status,
    '{"color":["Warm Walnut","Cream"],"material":["Walnut Wood","Fabric"],"style":["Modern","Minimalist"],"room":["Living Room","Bedroom","Study"],"occasion":["Everyday","Reading","Relaxation"]}',
    '{"primaryColors":[{"name":"Warm Walnut","hex":"#5D3A1A","category":"primary"},{"name":"Cream","hex":"#F5F5DC","category":"secondary"}],"pattern":"solid","texture":"smooth","finish":"natural","shape":"angular","silhouette":"Tall tripod with clean lines"}',
    '{"short":"Elevate your space with the chic Industrial Task Floor Lamp, boasting a sleek metal finish and adjustable features.","long":"Introducing the Industrial Task Floor Lamp, an embodiment of functional elegance. Its robust metal frame, paired with an adjustable arm and head, ensures precise lighting where you need it. Ideal for reading corners or workspaces, its matte black finish adds a touch of modern sophistication to any room. The lamp''s minimalist design complements urban lofts and contemporary interiors, creating a striking visual impact. Whether illuminating a late-night project or setting the mood in your living room, this lamp is a versatile addition to your decor arsenal.","features":["Adjustable arm and head for focused lighting","Durable metal construction","Matte black finish","Ideal for reading or workspace lighting","Complements industrial and modern decor","Compact design fits various spaces","Easy assembly"],"careInstructions":"Wipe metal surfaces with a soft, damp cloth to remove dust. Avoid using abrasive cleaners. Check electrical connections periodically.","materialComposition":"Metal frame with matte black finish"}',
    '["industrial","task lamp","adjustable","reading","bronze","floor lamp","tripod lamp","ambient lighting","modern design","wood accents","reading lamp","minimalist style","home decor","living room lighting","bedroom lamp","study lamp","elegant lighting","soft glow","fabric shade","natural finish","warm walnut","cream shade","stylish lamp","interior lighting","home ambiance","decorative lamp","functional lighting","lamp with tripod base","wooden lamp","contemporary lighting","cozy atmosphere","lighting accessory","industrial task floor lamp","adjustable floor lamp","modern lighting","workspace lamp","matte black lamp","urban loft lighting","contemporary interiors","minimalist lamp","floor lamp with adjustable arm","metal frame lamp","modern sophistication","task lighting","precision lighting","home decor lighting","lamp for living room","lamp for study","versatile lighting","floor lamp design","adjustable head lamp","modern floor lamp","lamp for reading corners","workspace illumination","black floor lamp"]',
    '{"metaTitle":"Industrial Task Floor Lamp - Adjustable Modern Lighting","metaDescription":"Illuminate your space with the Industrial Task Floor Lamp. Its adjustable arm and matte black finish offer precise lighting. Perfect for reading or workspaces. Order now!","altText":"Industrial Task Floor Lamp with adjustable arm and matte black finish for precise lighting in modern interiors.","keywords":["industrial task floor lamp","adjustable floor lamp","modern lighting","reading lamp","workspace lamp","matte black lamp","functional lighting","urban loft lighting","contemporary interiors","minimalist lamp","floor lamp with adjustable arm","metal frame lamp","modern sophistication","elegant lighting","task lighting","precision lighting","decorative lamp","home decor lighting","lamp for living room","lamp for study","versatile lighting","floor lamp design","adjustable head lamp","modern floor lamp","lighting accessory","interior lighting","home ambiance","lamp for reading corners","workspace illumination","black floor lamp"]}',
    FALSE,
    FALSE,
    4.4,
    98,
    TRUE,
    '2024-01-14T00:00:00Z',
    '2024-01-14T00:00:00Z'
FROM categories c
WHERE c.slug = 'lighting'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Torchiere Floor Lamp
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'LGT-FL-004',
    'Torchiere Floor Lamp',
    'Sleek torchiere lamp providing ambient uplighting',
    119.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'floor-lamp' AND category_id = c.id),
    45,
    'in_stock'::stock_status,
    '{"color":["Warm Gold","Cream"],"material":["Metal","Fabric"],"style":["Modern","Elegant"],"room":["Living Room","Bedroom","Hallway"],"occasion":["Everyday","Relaxing"]}',
    '{"primaryColors":[{"name":"Warm Gold","hex":"#D4AF37","category":"primary"},{"name":"Cream","hex":"#FFFDD0","category":"accent"}],"pattern":"pleated","texture":"smooth","finish":"polished","shape":"organic","silhouette":"Curved with a flowing form"}',
    '{"short":"Illuminate your space with the Torchiere Floor Lamp''s elegant curves and warm glow.","long":"Transform your living space with the Torchiere Floor Lamp, a perfect blend of modern design and ambient lighting. Featuring a gracefully curved silhouette, this lamp is accented with a luxurious warm golden finish that adds a touch of sophistication to any room. The pleated fabric shade gently diffuses light, creating a cozy and inviting ambiance, ideal for living rooms, bedrooms, or hallways. With its sleek and versatile design, this lamp seamlessly complements various interior styles, offering both functionality and aesthetic appeal. Whether you''re curling up with a book or hosting guests, the Torchiere Floor Lamp provides the perfect lighting solution that enhances your home''s atmosphere.","features":["Gracefully curved silhouette","Warm golden polished finish","Pleated fabric shade for soft light diffusion","Ideal for ambient uplighting","Versatile design suitable for multiple rooms","Perfect blend of modern elegance and practicality"],"careInstructions":"Dust regularly with a soft cloth. Avoid using harsh chemicals on the metal finish to maintain its shine.","materialComposition":"Constructed with a durable metal base and a pleated fabric shade."}',
    '["torchiere","uplighting","ambient","modern","sleek","floor lamp","ambient lighting","modern design","elegant","curved silhouette","pleated shade","warm glow","living room lighting","bedroom lamp","hallway decor","metal base","fabric shade","polished finish","home decor","interior lighting","stylish lamp","cozy ambiance","versatile lighting","sleek design","golden finish","contemporary style","soft illumination","decorative lighting","functional lamp","reading light","accent lighting","minimalist","artistic design","warm color palette","luxury lighting","designer lamp","unique lamp","quality craftsmanship","durable materials","easy maintenance","home improvement","lighting solution","floor decor","space-saving","soft fabric","torchiere floor lamp","elegant lighting","living room lamp","bedroom lighting","metal base lamp","fabric shade lamp","home decor lighting","stylish floor lamp","uplighting lamp","sleek lamp design","golden finish lamp","contemporary style lamp","minimalist lamp","artistic design lamp","designer floor lamp"]',
    '{"metaTitle":"Torchiere Floor Lamp - Modern Design & Ambient Lighting","metaDescription":"Elevate your space with the Torchiere Floor Lamp''s modern elegance and cozy glow. Perfect for any room. Shop now to transform your home ambiance!","altText":"Elegant torchiere floor lamp with a warm golden finish and pleated shade, offering ambient lighting.","keywords":["torchiere floor lamp","ambient lighting","modern design","elegant lighting","curved silhouette","pleated shade","warm glow","living room lamp","bedroom lighting","hallway decor","metal base lamp","fabric shade lamp","polished finish","home decor lighting","interior lighting","stylish floor lamp","uplighting lamp","cozy ambiance","versatile lighting","sleek lamp design","golden finish lamp","contemporary style lamp","soft illumination","decorative lighting","functional lamp","reading light","accent lighting","minimalist lamp","artistic design lamp","luxury lighting","designer floor lamp"]}',
    FALSE,
    FALSE,
    4.3,
    76,
    TRUE,
    '2024-01-16T00:00:00Z',
    '2024-01-16T00:00:00Z'
FROM categories c
WHERE c.slug = 'lighting'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Rattan Floor Lamp
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'LGT-FL-005',
    'Rattan Floor Lamp',
    'Bohemian rattan floor lamp with natural texture',
    189.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'floor-lamp' AND category_id = c.id),
    15,
    'in_stock'::stock_status,
    '{"color":["Warm Gold","Cream"],"material":["Metal","Fabric"],"style":["Modern","Contemporary"],"room":["Living Room","Bedroom"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Warm Gold","hex":"#D4AF37","category":"primary"},{"name":"Cream","hex":"#FFFDD0","category":"secondary"}],"pattern":"solid","texture":"smooth","finish":"matte","shape":"curved","silhouette":"Tall and elegant with a sweeping arch"}',
    '{"short":"Stylish rattan floor lamp with natural charm and warm illumination.","long":"Illuminate your space with the Rattan Floor Lamp, a blend of rustic charm and modern elegance. Crafted with an intricate woven rattan shade, this lamp casts a soft, inviting glow, perfect for creating a cozy ambiance in any room. The sleek metal stand provides sturdy support while emphasizing the natural aesthetics of the rattan. Its versatile design complements various decors from coastal to bohemian. Whether placed in your living room or bedroom, this lamp adds a touch of nature and warmth, making it a perfect accent piece. Enjoy the harmony of functionality and style with this exquisite lighting solution.","features":["Woven rattan shade for natural aesthetics","Soft, warm illumination","Sturdy metal stand","Versatile design suits various decor styles","Perfect for living rooms and bedrooms","Adds a touch of rustic charm","Enhances cozy ambiance"],"careInstructions":"Dust the rattan shade with a soft brush. Clean metal parts with a damp cloth. Avoid exposure to moisture.","materialComposition":"Woven rattan shade, metal stand and base"}',
    '["rattan","bohemian","natural","floor lamp","coastal","modern lighting","ambient light","home decor","living room lamp","bedroom lighting","elegant design","adjustable arm","metal lamp","fabric shade","warm glow","contemporary style","interior lighting","decorative lamp","stylish lighting","home ambiance","lighting solution","gold finish","cream shade","tall lamp","versatile lighting","reading light","accent lighting","designer lamp","floor standing lamp","arch lamp","minimalist design","luxury lighting","soft light","cozy atmosphere","home improvement","lighting fixture","stable base","adjustable position","metal construction","Rattan Floor Lamp","rustic lighting","modern floor lamp","woven rattan shade","cozy ambiance","natural aesthetics","coastal decor","bohemian style","metal stand","accent piece","nature-inspired lighting","versatile design"]',
    '{"metaTitle":"Rattan Floor Lamp - Rustic Charm & Modern Elegance","metaDescription":"Brighten your home with the Rattan Floor Lamp. Its woven rattan shade and sleek metal stand create a cozy ambiance. Buy now for stylish lighting!","altText":"Rattan Floor Lamp with a woven rattan shade and sleek metal stand, casting a warm glow.","keywords":["Rattan Floor Lamp","rustic lighting","modern floor lamp","woven rattan shade","cozy ambiance","home decor","living room lamp","bedroom lighting","natural aesthetics","coastal decor","bohemian style","metal stand","elegant design","ambient light","accent piece","lighting solution","floor standing lamp","designer lamp","stylish lighting","soft light","warm glow","interior lighting","decorative lamp","home improvement","lighting fixture","nature-inspired lighting","versatile design"]}',
    TRUE,
    FALSE,
    4.6,
    123,
    TRUE,
    '2024-01-18T00:00:00Z',
    '2024-01-18T00:00:00Z'
FROM categories c
WHERE c.slug = 'lighting'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: LED Tree Floor Lamp
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'LGT-FL-006',
    'LED Tree Floor Lamp',
    'Multi-head LED floor lamp with adjustable arms',
    199.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'floor-lamp' AND category_id = c.id),
    25,
    'in_stock'::stock_status,
    '{"color":["Stone Gray","Warm White"],"material":["Composite"],"style":["Modern","Contemporary"],"room":["Living Room","Office","Bedroom"],"occasion":["Everyday","Artistic Display"]}',
    '{"primaryColors":[{"name":"Stone Gray","hex":"#8A8A8A","category":"primary"},{"name":"Warm White","hex":"#FFD700","category":"accent"}],"pattern":"solid","texture":"textured","finish":"natural","shape":"organic","silhouette":"Sculptural with branching form"}',
    '{"short":"Enchant your space with the sculptural LED Tree Floor Lamp, a blend of art and ambient light.","long":"Transform your living area with our LED Tree Floor Lamp, a stunning union of art and functionality. This lamp boasts a unique tree-like silhouette, offering a sculptural elegance that complements modern and contemporary interiors. Crafted from a textured composite material, it mimics the raw beauty of natural stone while providing a soft, ambient glow that warms the room. Perfect for living rooms, bedrooms, or offices, this lamp is more than a light source; it''s a statement piece. Bring nature indoors with its branching design and enjoy the tranquil ambiance it creates.","features":["Unique tree-like silhouette","Ambient LED lighting for cozy atmosphere","Textured composite material with stone-like finish","Sculptural elegance for modern spaces","Perfect for living rooms, bedrooms, or offices","Artistic statement piece that complements decor","Soft glow enhances tranquility"],"careInstructions":"Dust gently with a soft cloth to maintain the finish. Avoid exposure to harsh chemicals and direct sunlight.","materialComposition":"Crafted from a durable textured composite material that resembles natural stone"}',
    '["LED","tree lamp","multi-head","adjustable","modern","LED floor lamp","tree design","sculptural lighting","modern decor","contemporary style","ambient light","artistic lamp","organic shape","stone-like finish","unique lighting","home decor","stylish lamp","statement piece","living room lamp","office lighting","bedroom lamp","textured finish","natural look","designer lamp","creative lighting","branching design","soft glow","warm ambiance","decorative lamp","minimalist lighting","elegant design","interior lighting","home lighting","floor lamp","LED bulb","artistic design","modern lighting","contemporary lamp","ambient decor","unique design","stylish lighting","decorative piece","home accessory","lighting solution","creative decor","natural texture","organic decor","artistic home decor"]',
    '{"metaTitle":"LED Tree Floor Lamp - Sculptural Design & Ambient Glow","metaDescription":"Illuminate your space with our LED Tree Floor Lamp. Enjoy a sculptural, tree-like design that offers ambient lighting. Perfect for modern interiors. Order now!","altText":"LED Tree Floor Lamp with sculptural tree-like design and ambient glow","keywords":["LED floor lamp","tree design","sculptural lighting","modern decor","contemporary style","ambient light","artistic lamp","organic shape","stone-like finish","unique lighting","home decor","stylish lamp","statement piece","living room lamp","office lighting","bedroom lamp","textured finish","natural look","designer lamp","creative lighting","branching design","soft glow","warm ambiance","decorative lamp","minimalist lighting","elegant design","interior lighting","home lighting","floor lamp","LED bulb"]}',
    FALSE,
    TRUE,
    4.5,
    167,
    TRUE,
    '2024-01-20T00:00:00Z',
    '2024-01-20T00:00:00Z'
FROM categories c
WHERE c.slug = 'lighting'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Paper Lantern Floor Lamp
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'LGT-FL-007',
    'Paper Lantern Floor Lamp',
    'Japanese-inspired paper lantern floor lamp with soft glow',
    139.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'floor-lamp' AND category_id = c.id),
    18,
    'in_stock'::stock_status,
    '{"color":["Ivory White","Natural Wood"],"material":["Rice Paper","Wood"],"style":["Japanese","Minimalist"],"room":["Living Room","Bedroom","Meditation Room"],"occasion":["Everyday","Relaxation"]}',
    '{"primaryColors":[{"name":"Ivory White","hex":"#FFFFF0","category":"primary"},{"name":"Natural Wood","hex":"#A0522D","category":"secondary"}],"pattern":"solid","texture":"smooth","finish":"natural","shape":"rectangular","silhouette":"Slender with clean lines"}',
    '{"short":"Elegant Japanese-inspired paper lantern floor lamp with a warm, ambient glow.","long":"Transform your living space with the Paper Lantern Floor Lamp, a stunning blend of Japanese-inspired design and modern elegance. Its rice paper shade softly diffuses light, creating a calming ambiance that''s perfect for relaxation. The minimalist wooden base adds a touch of natural beauty, making it ideal for any room seeking serenity—from your living room to your meditation space. The lamp''s slender silhouette and clean lines ensure it fits seamlessly into various decor styles, offering both functionality and aesthetic appeal. At $139.99, this lamp is a stylish investment in warmth and tranquility for your home.","features":["Japanese-inspired design","Soft ambient glow","Rice paper shade","Minimalist wooden base","Slender silhouette","Fits various decor styles","Perfect for relaxation spaces"],"careInstructions":"Dust regularly with a soft cloth. Avoid direct contact with water. Handle rice paper shade with care.","materialComposition":"Rice paper shade with a solid wood base."}',
    '["paper lantern","japanese","soft glow","minimalist","zen","Japanese design","minimalist lighting","ambient glow","floor lamp","rice paper","wood base","zen decor","modern lighting","soft light","natural materials","elegant lamp","home decor","relaxation lighting","living room lamp","bedroom lamp","meditation room lighting","stylish lamp","warm light","serene atmosphere","decorative lighting","contemporary lamp","unique design","eco-friendly materials","sustainable design","artisan lamp","handcrafted look","soft lighting","ambient lamp","floor lighting","interior design","home lighting","decorative lamp","modern decor","natural decor","minimalist decor","Japanese style","calming light","peaceful ambiance","soft ambiance","warm ambiance","natural light","simple elegance","clean lines"]',
    '{"metaTitle":"Paper Lantern Floor Lamp - Japanese Design & Soft Glow","metaDescription":"Enhance your space with the Paper Lantern Floor Lamp. Enjoy its serene, soft glow and minimalist design. Order now for $139.99 and transform your home.","altText":"Japanese-inspired paper lantern floor lamp with rice paper shade and wooden base.","keywords":["paper lantern","Japanese design","minimalist lighting","ambient glow","floor lamp","rice paper","wood base","zen decor","modern lighting","soft light","natural materials","elegant lamp","home decor","relaxation lighting","living room lamp","bedroom lamp","meditation room lighting","stylish lamp","warm light","serene atmosphere","decorative lighting","contemporary lamp","unique design","eco-friendly materials","sustainable design","artisan lamp","handcrafted look","soft lighting","interior design","minimalist decor"]}',
    FALSE,
    FALSE,
    4.7,
    89,
    TRUE,
    '2024-01-22T00:00:00Z',
    '2024-01-22T00:00:00Z'
FROM categories c
WHERE c.slug = 'lighting'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Pharmacy Floor Lamp
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'LGT-FL-008',
    'Pharmacy Floor Lamp',
    'Classic pharmacy-style floor lamp with adjustable head',
    169.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'floor-lamp' AND category_id = c.id),
    20,
    'in_stock'::stock_status,
    '{"color":["Jet Black"],"material":["Metal"],"style":["Modern","Contemporary"],"room":["Living Room","Study","Office"],"occasion":["Everyday","Reading","Accent Lighting"]}',
    '{"primaryColors":[{"name":"Jet Black","hex":"#343434","category":"primary"}],"pattern":"solid","texture":"matte","finish":"matte","shape":"angular","silhouette":"Tall with angular geometric shades"}',
    '{"short":"Illuminate your space with our sleek Pharmacy Floor Lamp, offering versatile lighting and a timeless design.","long":"Elevate your home''s ambiance with the Pharmacy Floor Lamp, a perfect blend of elegance and functionality. Designed to suit contemporary aesthetics, this lamp features a polished metal finish that seamlessly integrates with any decor. Its adjustable arm and swivel head ensure optimal lighting angles, making it ideal for reading nooks, cozy corners, or as a stylish accent in living rooms. The lamp''s classic silhouette and minimalist appeal create an inviting atmosphere, offering both style and practicality. Whether you''re settling down with a good book or need focused lighting for a task, this lamp meets all your needs. A true testament to modern design, it stands as both a functional light source and a decorative piece.","features":["Adjustable arm for customized lighting angles","Swivel head for focused illumination","Polished metal finish for a sleek look","Classic silhouette enhances any decor","Energy-efficient bulb compatibility","Stable base ensures safety and stability"],"careInstructions":"Dust regularly with a soft, dry cloth. Avoid cleaners containing alcohol or ammonia. Use a feather duster for delicate components.","materialComposition":"Crafted from high-quality metal with a polished finish"}',
    '["pharmacy","classic","adjustable","brass","traditional","floor lamp","modern lighting","geometric design","black lamp","metal lamp","contemporary decor","accent lighting","reading lamp","office lighting","study lamp","living room lamp","sleek design","angular shades","multi-directional","matte finish","durable construction","stylish lamp","artistic flair","home decor","interior design","lighting solution","versatile lamp","unique lamp","designer lamp","decorative lighting","functional lamp","adjustable lighting","minimalist lamp","statement piece","elegant design","Pharmacy Floor Lamp","multi-directional lighting"]',
    '{"metaTitle":"Pharmacy Floor Lamp - Elegant Modern Lighting Solution","metaDescription":"Enhance your space with the Pharmacy Floor Lamp''s sleek design and adjustable lighting. Perfect for reading nooks and stylish accents. Order now!","altText":"Sleek Pharmacy Floor Lamp with angular geometric shades and modern design in jet black finish.","keywords":["Pharmacy Floor Lamp","modern lighting","geometric design","black lamp","metal lamp","contemporary decor","accent lighting","reading lamp","office lighting","study lamp","living room lamp","sleek design","angular shades","multi-directional lighting","matte finish","durable construction","stylish lamp","artistic flair","home decor","interior design","lighting solution","versatile lamp","unique lamp","designer lamp","decorative lighting","functional lamp","adjustable lighting","minimalist lamp","statement piece","elegant design"]}',
    FALSE,
    FALSE,
    4.4,
    56,
    TRUE,
    '2024-01-24T00:00:00Z',
    '2024-01-24T00:00:00Z'
FROM categories c
WHERE c.slug = 'lighting'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Marble Base Floor Lamp
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'LGT-FL-009',
    'Marble Base Floor Lamp',
    'Elegant floor lamp with genuine marble base and brass finish',
    299.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'floor-lamp' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["White Marble","Brass"],"material":["Marble","Metal","Fabric"],"style":["Modern","Luxury"],"room":["Living Room","Bedroom","Foyer"],"occasion":["Everyday","Reading","Ambient Lighting"]}',
    '{"primaryColors":[{"name":"White Marble","hex":"#FFFFFF","category":"primary"},{"name":"Brass","hex":"#B5A642","category":"accent"}],"pattern":"solid","texture":"smooth","finish":"polished","shape":"angular","silhouette":"Tall and slender with adjustable arm"}',
    '{"short":"Sophisticated floor lamp with marble base and adjustable brass arm.","long":"Illuminate your living space with our Marble Base Floor Lamp, a beacon of elegance and functionality. The lamp boasts a genuine marble base that anchors it with a touch of luxury and stability, perfect for any sophisticated setting. Its adjustable metal arm, finished in a luxurious brass, allows you to direct light precisely where you need it, whether for reading or creating a warm ambient glow. The sleek, modern design effortlessly integrates into contemporary interiors, enhancing your decor with its refined silhouette. Ideal for living rooms, bedrooms, or foyers, this lamp is more than just a source of light; it''s a statement piece that elevates the ambiance of your home.","features":["Genuine marble base for stability and luxury","Adjustable metal arm for versatile lighting","Elegant brass finish complements modern decor","Sleek design ideal for contemporary interiors","Perfect for living rooms, bedrooms, and foyers","Provides ambient or focused lighting"],"careInstructions":"Gently wipe the marble base with a damp cloth to remove dust and polish the metal parts with a soft, dry cloth to maintain their shine.","materialComposition":"Marble base, metal arm and shade with a brass finish, fabric-covered wiring"}',
    '["marble","luxury","brass","elegant","gold","floor lamp","marble base","brass finish","modern lighting","luxury decor","adjustable arm","ambient light","reading lamp","elegant design","home lighting","living room lamp","bedroom lighting","foyer decor","stylish lamp","contemporary","interior design","home decor","lighting solution","metal lamp","white marble","polished finish","versatile lighting","decorative lamp","designer lamp","high-end lighting","sleek design","modern lamp","luxury lamp","adjustable lighting","reading light","ambient lamp","decorative lighting"]',
    '{"metaTitle":"Marble Base Floor Lamp with Adjustable Brass Arm","metaDescription":"Elevate your home with our Marble Base Floor Lamp. Luxurious brass finish and adjustable arm for perfect lighting. Shop now for elegance and functionality!","altText":"Elegant floor lamp with a marble base and adjustable metal arm in brass finish","keywords":["floor lamp","marble base","brass finish","modern lighting","luxury decor","adjustable arm","ambient light","reading lamp","elegant design","home lighting","living room lamp","bedroom lighting","foyer decor","stylish lamp","contemporary","interior design","home decor","lighting solution","metal lamp","white marble","polished finish","versatile lighting","decorative lamp","designer lamp","high-end lighting","sleek design","modern lamp","luxury lamp","adjustable lighting","reading light","ambient lamp"]}',
    TRUE,
    FALSE,
    4.9,
    34,
    TRUE,
    '2024-01-26T00:00:00Z',
    '2024-01-26T00:00:00Z'
FROM categories c
WHERE c.slug = 'lighting'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Ceramic Table Lamp
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'LGT-TL-001',
    'Ceramic Table Lamp',
    'Hand-painted ceramic table lamp with linen shade',
    129.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'table-lamp' AND category_id = c.id),
    30,
    'in_stock'::stock_status,
    '{"color":["Deep Plum","Warm White"],"material":["Synthetic Material"],"style":["Modern","Contemporary"],"room":["Living Room","Bedroom","Office"],"occasion":["Everyday","Ambient Lighting"]}',
    '{"primaryColors":[{"name":"Deep Plum","hex":"#5D3A4B","category":"primary"},{"name":"Warm White","hex":"#F5F5DC","category":"accent"}],"pattern":"solid","texture":"textured","finish":"matte","shape":"rectangular","silhouette":"Cube-shaped with rounded edges"}',
    '{"short":"Elegantly crafted ceramic table lamp with a soft ambient glow.","long":"Illuminate your living space with our Ceramic Table Lamp, priced at $129.99. This exquisite lamp showcases a beautifully sculpted ceramic base with a sleek, matte finish, exuding a sense of modern sophistication. The lamp''s gentle curves and muted tones blend seamlessly into any decor style, making it a versatile addition to your home. The soft ambient glow emitted by the lampshade creates a warm and inviting atmosphere, perfect for relaxing evenings in your living room, bedroom, or office. Its elegant design and practical functionality make this table lamp not just a source of light but an artful statement piece that enhances the aesthetic appeal of your space.","features":["Sculpted ceramic base","Soft ambient glow","Matte finish","Versatile design","Elegant and modern","Perfect for living rooms, bedrooms, and offices","Creates a warm, inviting atmosphere"],"careInstructions":"Gently dust with a soft cloth. Avoid using water or harsh cleaning agents to maintain the lamp''s finish.","materialComposition":"High-quality ceramic base with a fabric lampshade."}',
    '["ceramic","hand-painted","table lamp","blue","coastal","modern lamp","cube lamp","ambient lighting","textured design","contemporary decor","bedroom lamp","living room lighting","office lamp","stylish lamp","compact lamp","warm glow","unique design","modern aesthetic","decorative lighting","soft light","home decor","designer lamp","accent lighting","ambient lamp","synthetic material","matte finish","rectangular shape","rounded edges","cozy atmosphere","lighting fixture","plum color","warm white light","ceramic table lamp"]',
    '{"metaTitle":"Ceramic Table Lamp - Modern Cube Design with Ambient Glow","metaDescription":"Illuminate your space with our Ceramic Table Lamp. Its modern cube design and ambient glow enhance any decor. Buy now for a stylish touch!","altText":"Modern ceramic table lamp with cube-shaped design and warm ambient glow, perfect for living room or bedroom.","keywords":["ceramic table lamp","modern lamp","cube lamp","ambient lighting","textured design","contemporary decor","bedroom lamp","living room lighting","office lamp","stylish lamp","compact lamp","warm glow","unique design","modern aesthetic","decorative lighting","soft light","home decor","designer lamp","accent lighting","table lamp","ambient lamp","synthetic material","matte finish","rectangular shape","rounded edges","cozy atmosphere","lighting fixture","plum color","warm white light"]}',
    TRUE,
    FALSE,
    4.6,
    178,
    TRUE,
    '2024-01-08T00:00:00Z',
    '2024-01-08T00:00:00Z'
FROM categories c
WHERE c.slug = 'lighting'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Crystal Base Table Lamp
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'LGT-TL-002',
    'Crystal Base Table Lamp',
    'Elegant crystal base table lamp with white pleated shade',
    189.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'table-lamp' AND category_id = c.id),
    18,
    'in_stock'::stock_status,
    '{"color":["Sage Green","White"],"material":["Ceramic","Fabric"],"style":["Modern","Artistic"],"room":["Living Room","Bedroom","Office"],"occasion":["Everyday","Decorative"]}',
    '{"primaryColors":[{"name":"Sage Green","hex":"#9CAF88","category":"primary"},{"name":"White","hex":"#FFFFFF","category":"secondary"}],"pattern":"solid","texture":"smooth","finish":"matte","shape":"organic","silhouette":"Flowing sculptural form with clean lines"}',
    '{"short":"Illuminate your space with elegance using the Crystal Base Table Lamp, featuring a stunning crystal base and sophisticated white shade.","long":"Transform your home with the Crystal Base Table Lamp, a statement piece boasting a dazzling crystal base that captures and refracts light, creating a mesmerizing play of sparkle and shadow. Topped with a refined white shade, this lamp casts a warm, inviting glow, perfect for cozy evenings or adding a touch of sophistication to your reading nook. Its versatile design complements both modern and classic decors, making it an ideal choice for living rooms, bedrooms, or home offices. The lamp’s elegant crystal structure not only serves as a functional lighting solution but also as a luxurious decor element that elevates any room’s aesthetic.","features":["Dazzling crystal base for a luxurious look","Sophisticated white shade for soft illumination","Versatile design complements various decor styles","Ideal for living rooms, bedrooms, or offices","Creates a warm and inviting ambiance","Durable construction for long-lasting use","Easy to operate with convenient switch"],"careInstructions":"Wipe the crystal base with a soft, dry cloth to maintain its sparkle. Avoid using harsh chemicals or abrasives. Gently dust the shade regularly.","materialComposition":"Base: High-quality crystal; Shade: Premium fabric"}',
    '["crystal","elegant","glamorous","pleated shade","luxury","table lamp","sculptural design","modern lighting","ambient light","sage green","white shade","decorative lamp","artistic lamp","unique base","home decor","living room lighting","bedroom lamp","office lamp","contemporary style","elegant lighting","soft light","stylish lamp","interior design","matte finish","smooth texture","solid pattern","organic shape","clean lines","Crystal Base Table Lamp","luxurious decor","reading nook lighting","statement piece","sparkle and shadow","cozy evenings"]',
    '{"metaTitle":"Crystal Base Table Lamp - Dazzling Design & Warm Glow","metaDescription":"Elevate your space with the Crystal Base Table Lamp. Its stunning crystal design and warm glow add sophistication. Shop now for modern elegance!","altText":"Crystal Base Table Lamp with white shade, offering a warm glow and elegant design.","keywords":["Crystal Base Table Lamp","modern lighting","ambient light","home decor","living room lighting","bedroom lamp","office lamp","elegant lighting","stylish lamp","interior design","sculptural design","decorative lamp","artistic lamp","unique base","contemporary style","soft light","matte finish","smooth texture","solid pattern","organic shape","clean lines","white shade","luxurious decor","reading nook lighting","statement piece","sparkle and shadow","cozy evenings"]}',
    FALSE,
    TRUE,
    4.8,
    145,
    TRUE,
    '2024-01-10T00:00:00Z',
    '2024-01-10T00:00:00Z'
FROM categories c
WHERE c.slug = 'lighting'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Industrial Desk Lamp
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'LGT-TL-003',
    'Industrial Desk Lamp',
    'Vintage-style industrial desk lamp with adjustable arm',
    89.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'table-lamp' AND category_id = c.id),
    42,
    'in_stock'::stock_status,
    '{"color":["Warm Taupe","Natural Linen"],"material":["Ceramic","Linen"],"style":["Contemporary","Artistic"],"room":["Living Room","Bedroom","Study"],"occasion":["Everyday","Relaxation"]}',
    '{"primaryColors":[{"name":"Warm Taupe","hex":"#B19F8E","category":"primary"},{"name":"Natural Linen","hex":"#D3C5B4","category":"secondary"}],"pattern":"ribbed","texture":"textured","finish":"matte","shape":"round","silhouette":"Rounded base with a drum shade"}',
    '{"short":"Illuminate your space with the sleek Industrial Desk Lamp, blending modern design with vintage charm.","long":"Enhance your workspace or reading nook with the Industrial Desk Lamp, a perfect blend of contemporary and vintage aesthetics. Its robust metal construction features a black matte finish, exuding industrial charm that complements any modern decor. The adjustable arm and head allow you to direct light precisely where you need it, making it ideal for task lighting. The exposed bulb design adds a touch of retro flair while providing ample illumination. Whether you place it on your desk or bedside table, this lamp is sure to be a conversation starter and a functional addition to your home.","features":["Adjustable arm and head for targeted lighting","Sturdy metal construction with matte finish","Exposed bulb design for vintage appeal","Compact size fits perfectly on desks or side tables","Ideal for task lighting in workspaces or studies"],"careInstructions":"Wipe with a soft, dry cloth regularly. Avoid using harsh chemicals or abrasive cleaners.","materialComposition":"Metal with a black matte finish"}',
    '["industrial","desk lamp","adjustable","vintage","task","table lamp","ceramic base","linen shade","ambient lighting","home decor","living room lamp","bedroom lamp","study lamp","elegant design","textured base","modern lighting","artistic lamp","warm taupe","natural linen","ribbed pattern","matte finish","round shape","contemporary style","versatile lighting","soft light","decorative lamp","stylish lamp","home lighting","interior design","ambient lamp","cozy ambiance","sophisticated lamp","textured ceramic","linen fabric","rounded silhouette","drum shade","elegant home accessory","lighting solution","decorative accessory","modern decor","artistic decor","industrial desk lamp","adjustable desk lamp","vintage desk lamp","task lighting","black matte lamp","exposed bulb lamp","workspace lighting","reading nook lamp","modern decor lamp","contemporary lighting","retro desk lamp","home office lamp","bedside table lamp","metal desk lamp","adjustable arm lamp","industrial charm lighting","decorative desk lamp","functional desk lamp","modern industrial lamp","stylish desk lamp","conversation starter lamp","home lighting solution","desk lamp with adjustable head","vintage aesthetic lamp","elegant desk lamp","industrial style lamp","contemporary task lamp","desk lamp with exposed bulb","matte finish desk lamp","versatile desk lamp"]',
    '{"metaTitle":"Industrial Desk Lamp - Adjustable Arm & Vintage Charm","metaDescription":"Upgrade your space with the Industrial Desk Lamp. Enjoy adjustable lighting and vintage style. Perfect for any decor. Order now to illuminate your home!","altText":"Industrial desk lamp with adjustable arm and black matte finish on a desk.","keywords":["industrial desk lamp","adjustable desk lamp","vintage desk lamp","task lighting","black matte lamp","exposed bulb lamp","workspace lighting","reading nook lamp","modern decor lamp","contemporary lighting","retro desk lamp","home office lamp","bedside table lamp","metal desk lamp","adjustable arm lamp","industrial charm lighting","decorative desk lamp","functional desk lamp","modern industrial lamp","stylish desk lamp","conversation starter lamp","home lighting solution","desk lamp with adjustable head","vintage aesthetic lamp","elegant desk lamp","industrial style lamp","contemporary task lamp","desk lamp with exposed bulb","matte finish desk lamp","versatile desk lamp"]}',
    FALSE,
    FALSE,
    4.5,
    203,
    TRUE,
    '2024-01-12T00:00:00Z',
    '2024-01-12T00:00:00Z'
FROM categories c
WHERE c.slug = 'lighting'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Glass Orb Table Lamp
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'LGT-TL-004',
    'Glass Orb Table Lamp',
    'Modern glass orb table lamp with brass accents',
    149.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'table-lamp' AND category_id = c.id),
    25,
    'in_stock'::stock_status,
    '{"color":["Cream","Warm Chestnut Brown"],"material":["Wood","Fabric"],"style":["Modern","Retro"],"room":["Living Room","Bedroom","Office"],"occasion":["Everyday","Accent Lighting"]}',
    '{"primaryColors":[{"name":"Cream","hex":"#FFFDD0","category":"primary"},{"name":"Warm Chestnut Brown","hex":"#8B4513","category":"secondary"}],"pattern":"pleated","texture":"textured","finish":"natural","shape":"rectangular","silhouette":"Elegant with a tapered base and pleated shade"}',
    '{"short":"Illuminate your space with the Glass Orb Table Lamp, featuring a sleek glass sphere and elegant metal base.","long":"Transform your home with the mesmerizing Glass Orb Table Lamp. This captivating lamp showcases a pristine glass orb that exudes modern sophistication, perfectly balanced on a polished metal base. The translucent glass softly diffuses light, creating a warm, inviting glow that enhances any room''s ambiance. Whether placed on a bedside table, living room console, or office desk, its sleek design seamlessly complements both contemporary and classic decor styles. Elevate your lighting experience with this stylish and functional piece, ideal for those looking to add a touch of elegance to their space.","features":["Sleek glass orb design","Polished metal base","Soft, ambient lighting","Modern elegance","Versatile decor piece","Perfect for any room"],"careInstructions":"Wipe the glass orb with a damp cloth regularly. Avoid using abrasive cleaners. Dust the metal base with a soft cloth.","materialComposition":"Glass orb with a metal base"}',
    '["glass orb","modern","brass","contemporary","accent","table lamp","pleated shade","wooden base","modern lighting","retro style","ambient light","home decor","living room lamp","bedroom lighting","office lamp","elegant design","warm lighting","chestnut brown","cream shade","textured lamp","natural finish","stylish lamp","decorative lighting","soft light","home accents","lighting fixture","interior design","contemporary lamp","classic style","versatile lamp","unique design","quality materials","easy care","functional decor","pleated fabric","wooden decor","lamp with shade","lighting solution","soft ambiance","warm glow","stylish home","Glass Orb Table Lamp","glass orb lamp","polished metal base","translucent glass","sophisticated lighting","contemporary decor","ambient lighting","modern sophistication","elegant home accents"]',
    '{"metaTitle":"Glass Orb Table Lamp: Elegant Design & Warm Glow","metaDescription":"Enhance your home''s ambiance with the Glass Orb Table Lamp. Its modern sophistication and warm glow are perfect for any decor. Shop now for elegance!","altText":"Elegant Glass Orb Table Lamp with a polished metal base and warm glow.","keywords":["Glass Orb Table Lamp","modern lighting","home decor","ambient light","living room lamp","bedroom lighting","office lamp","elegant design","warm lighting","glass orb lamp","polished metal base","translucent glass","sophisticated lighting","contemporary decor","classic style","stylish lamp","decorative lighting","soft light","lighting fixture","interior design","quality materials","functional decor","warm glow","ambient lighting","versatile lamp","unique design","modern sophistication","elegant home accents","lighting solution"]}',
    TRUE,
    FALSE,
    4.7,
    112,
    TRUE,
    '2024-01-14T00:00:00Z',
    '2024-01-14T00:00:00Z'
FROM categories c
WHERE c.slug = 'lighting'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Wooden Accent Table Lamp
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'LGT-TL-005',
    'Wooden Accent Table Lamp',
    'Natural wood base table lamp with fabric shade',
    99.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'table-lamp' AND category_id = c.id),
    35,
    'in_stock'::stock_status,
    '{"color":["Olive Green","Warm Beige"],"material":["Ceramic","Fabric"],"style":["Modern","Contemporary"],"room":["Living Room","Bedroom","Office"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Olive Green","hex":"#808000","category":"primary"},{"name":"Warm Beige","hex":"#F5F5DC","category":"secondary"}],"pattern":"solid","texture":"glossy","finish":"gloss","shape":"organic","silhouette":"Stacked cylindrical form with a tapered shade"}',
    '{"short":"Charming wooden accent table lamp with a natural finish and beige fabric shade.","long":"Illuminate your space with the Wooden Accent Table Lamp, a perfect blend of rustic charm and modern elegance. This lamp features a beautifully crafted wooden base with a natural finish that highlights the wood''s unique grains. Topped with a soft beige fabric shade, it diffuses light gently, creating a warm and inviting ambiance ideal for any living room, bedroom, or office. Its sturdy design ensures long-lasting durability while adding a touch of sophistication to your decor. Whether you''re reading a book or enjoying a quiet evening, this lamp is sure to enhance your space with its timeless appeal.","features":["Natural wooden base","Soft beige fabric shade","Warm ambient lighting","Rustic and modern design","Durable construction","Ideal for various room settings","Enhances decor with elegance"],"careInstructions":"Dust the wooden base regularly with a dry cloth. Clean the fabric shade with a lint roller or vacuum using an upholstery attachment.","materialComposition":"Solid wood base, polyester fabric shade"}',
    '["wooden","natural","scandinavian","rustic","accent","table lamp","ceramic","fabric shade","modern","contemporary","ambient lighting","home decor","living room","bedroom","office","elegant","stylish","green","beige","glossy finish","stacked design","unique","durable","cozy atmosphere","decorative","wooden accent table lamp","rustic table lamp","modern table lamp","wood base lamp","beige shade lamp","living room lighting","bedroom lamp","office lamp","home decor lamp","elegant table lamp","stylish lamp","unique design lamp","durable lamp","cozy atmosphere lamp","decorative table lamp","rustic charm lamp","modern elegance lamp","natural finish lamp","timeless appeal lamp","wood grain lamp","reading lamp","quiet evening lamp","sophisticated decor lamp","warm inviting ambiance lamp","sturdy design lamp"]',
    '{"metaTitle":"Wooden Accent Table Lamp - Rustic Charm & Modern Elegance","metaDescription":"Enhance your decor with the Wooden Accent Table Lamp, featuring a natural wooden base and beige shade. Perfect for living rooms, bedrooms, or offices. Buy now!","altText":"Elegant Wooden Accent Table Lamp with a rustic wooden base and beige fabric shade.","keywords":["wooden accent table lamp","rustic table lamp","modern table lamp","wood base lamp","beige shade lamp","living room lighting","bedroom lamp","office lamp","home decor lamp","elegant table lamp","stylish lamp","ambient lighting","unique design lamp","durable lamp","cozy atmosphere lamp","decorative table lamp","rustic charm lamp","modern elegance lamp","natural finish lamp","timeless appeal lamp","wood grain lamp","reading lamp","quiet evening lamp","sophisticated decor lamp","warm inviting ambiance lamp","sturdy design lamp"]}',
    FALSE,
    FALSE,
    4.4,
    87,
    TRUE,
    '2024-01-16T00:00:00Z',
    '2024-01-16T00:00:00Z'
FROM categories c
WHERE c.slug = 'lighting'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Marble Cylinder Table Lamp
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'LGT-TL-006',
    'Marble Cylinder Table Lamp',
    'Sleek marble cylinder lamp with gold trim',
    179.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'table-lamp' AND category_id = c.id),
    15,
    'in_stock'::stock_status,
    '{"color":["Off-White","Slate Gray"],"material":["Metal","Ceramic","Fabric"],"style":["Modern","Contemporary"],"room":["Living Room","Bedroom","Office"],"occasion":["Everyday","Decorative"]}',
    '{"primaryColors":[{"name":"Off-White","hex":"#F5F5F5","category":"primary"},{"name":"Slate Gray","hex":"#708090","category":"secondary"}],"pattern":"ribbed","texture":"textured","finish":"matte","shape":"cylindrical","silhouette":"angular with integrated planter"}',
    '{"short":"Sleek marble table lamp with cylindrical design and warm glow.","long":"Illuminate your home with the Marble Cylinder Table Lamp, a stunning blend of elegance and modern flair. Its cylindrical marble base adds a touch of sophistication, while the fabric shade softly diffuses light to create a warm, inviting atmosphere in any room. Perfect for a bedroom nightstand or living room side table, the lamp''s minimalist design complements both contemporary and classic decor. Its subtle textures and hues provide a versatile style that seamlessly integrates into your space, offering not just illumination, but a statement piece that elevates your home’s aesthetic.","features":["Elegant cylindrical marble base","Soft fabric shade for warm lighting","Modern minimalist design","Versatile for bedroom or living room","Sophisticated blend of textures","Perfect for contemporary or classic decor"],"careInstructions":"Dust regularly with a soft cloth. Avoid harsh cleaning agents to preserve the marble finish.","materialComposition":"Natural marble base, fabric shade, metal fittings"}',
    '["marble","cylinder","luxury","gold","modern","modern lamp","table lamp","ribbed shade","integrated planter","gray frame","contemporary design","home decor","lighting","plant holder","ambient light","office lamp","bedroom lamp","living room lamp","unique design","stylish lamp","ceramic planter","fabric shade","metal frame","matte finish","cylindrical shape","angular silhouette","decorative lighting","greenery","Marble Cylinder Table Lamp","modern table lamp","elegant lighting","contemporary decor","unique lamp design","modern interiors","lighting with planter","minimalist lamp","warm ambiance","statement piece","sophisticated lighting"]',
    '{"metaTitle":"Marble Cylinder Table Lamp - Elegant Lighting & Modern Flair","metaDescription":"Illuminate your space with the Marble Cylinder Table Lamp. Its elegant marble base and soft fabric shade create a warm ambiance. Perfect for any decor. Shop now!","altText":"Modern table lamp with ribbed off-white shade and integrated planter on a sleek gray frame.","keywords":["Marble Cylinder Table Lamp","modern table lamp","elegant lighting","contemporary decor","ribbed shade","integrated planter","gray frame","home decor","ambient light","bedroom lamp","living room lamp","office lamp","unique lamp design","stylish lamp","ceramic planter","fabric shade","metal frame","matte finish","cylindrical shape","angular silhouette","decorative lighting","modern interiors","lighting with planter","minimalist lamp","warm ambiance","statement piece","sophisticated lighting"]}',
    TRUE,
    FALSE,
    4.8,
    67,
    TRUE,
    '2024-01-18T00:00:00Z',
    '2024-01-18T00:00:00Z'
FROM categories c
WHERE c.slug = 'lighting'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Tiffany Style Table Lamp
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'LGT-TL-007',
    'Tiffany Style Table Lamp',
    'Colorful stained glass Tiffany-style lamp',
    229.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'table-lamp' AND category_id = c.id),
    12,
    'in_stock'::stock_status,
    '{"color":["Beige","Ivory"],"material":["Ceramic","Fabric"],"style":["Modern","Traditional"],"room":["Living Room","Bedroom","Office"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Beige","hex":"#F5F5DC","category":"primary"},{"name":"Ivory","hex":"#FFFFF0","category":"secondary"}],"pattern":"solid","texture":"textured","finish":"matte","shape":"organic","silhouette":"Compact with a rounded base and tapered shade"}',
    '{"short":"Illuminate your space with the vibrant Tiffany Style Table Lamp.","long":"The Tiffany Style Table Lamp is a splendid fusion of art and functionality, featuring a hand-crafted stained glass shade that bursts with a kaleidoscope of colors. Its rich, warm glow brings a comforting ambiance to any room, perfect for cozy evenings or sophisticated gatherings. The lamp’s sturdy metal base provides durability and an antique finish, enhancing its timeless appeal. Ideal for living rooms, bedrooms, or study areas, this lamp is a statement piece that captivates attention and inspires warmth and elegance in your decor.","features":["Hand-crafted stained glass shade","Antique finish metal base","Warm ambient lighting","Vibrant color palette","Timeless design","Perfect for various room settings"],"careInstructions":"Clean the stained glass shade gently with a damp cloth to maintain its vivid colors. Avoid using harsh chemicals on the metal base.","materialComposition":"Stained glass shade with a metal base"}',
    '["tiffany","stained glass","art nouveau","colorful","vintage","table lamp","ceramic base","fabric shade","pineapple design","ambient lighting","modern decor","traditional style","beige lamp","elegant lighting","home decor","bedroom lamp","living room lighting","office lamp","unique design","compact lamp","Tiffany Style Table Lamp","stained glass lamp","antique finish lamp","elegant table lamp","home lighting","living room lamp","bedroom lighting","study area lamp","decorative lamp","artistic table lamp","hand-crafted lamp","colorful stained glass","cozy ambiance lamp","sophisticated lighting","metal base lamp","vintage style lamp","unique design lamp","warm glow lamp","statement piece lighting","artistic home decor","classic table lamp","timeless appeal lamp","functional art lamp","hand-crafted glass lamp","elegant home decor","artistic lighting","decorative home lighting","statement table lamp","warm ambient lighting"]',
    '{"metaTitle":"Tiffany Style Table Lamp with Stained Glass Shade","metaDescription":"Illuminate your home with the Tiffany Style Table Lamp. Its stained glass shade and antique finish add elegance. Order now for a cozy ambiance!","altText":"Tiffany Style Table Lamp with stained glass shade and antique finish","keywords":["Tiffany Style Table Lamp","stained glass lamp","antique finish lamp","elegant table lamp","home lighting","living room lamp","bedroom lighting","study area lamp","decorative lamp","artistic table lamp","hand-crafted lamp","colorful stained glass","cozy ambiance lamp","sophisticated lighting","metal base lamp","vintage style lamp","unique design lamp","warm glow lamp","statement piece lighting","artistic home decor","classic table lamp","timeless appeal lamp","functional art lamp","hand-crafted glass lamp","elegant home decor","artistic lighting","decorative home lighting","statement table lamp","warm ambient lighting"]}',
    FALSE,
    FALSE,
    4.9,
    98,
    TRUE,
    '2024-01-20T00:00:00Z',
    '2024-01-20T00:00:00Z'
FROM categories c
WHERE c.slug = 'lighting'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Touch Dimmer Table Lamp
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'LGT-TL-008',
    'Touch Dimmer Table Lamp',
    'Modern touch-activated lamp with three brightness levels',
    79.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'table-lamp' AND category_id = c.id),
    50,
    'in_stock'::stock_status,
    '{"color":["Cream","Brass"],"material":["Metal","Fabric"],"style":["Modern","Minimalist"],"room":["Bedroom","Office","Nightstand"],"occasion":["Everyday","Reading"]}',
    '{"primaryColors":[{"name":"Cream","hex":"#FFFDD0","category":"primary"},{"name":"Brass","hex":"#B5A642","category":"accent"}],"pattern":"solid","texture":"smooth","finish":"matte","shape":"organic","silhouette":"sleek with adjustable neck"}',
    '{"short":"Stylish touch dimmer table lamp with adjustable brass neck and cream shade.","long":"Illuminate your space with the Touch Dimmer Table Lamp, a blend of elegance and functionality. Its sleek design features a smooth cream-colored shade paired with a flexible brass-toned neck, perfect for adjusting light direction effortlessly. Whether placed on a bedside table or an office desk, this lamp''s minimalist aesthetic complements any decor style. The touch-activated dimmer offers three brightness levels, making it ideal for creating ambient lighting or focused task lighting. Compact yet impactful, it enhances small spaces with sophistication and practicality, ensuring it''s not just a source of light but a stylish statement piece.","features":["Touch-activated dimmer for easy light adjustment","Adjustable brass-toned neck for directional lighting","Minimalist cream-colored shade complements any decor","Compact design perfect for small spaces","Three brightness levels for versatile lighting options","Sleek and modern aesthetic"],"careInstructions":"Wipe with a soft, dry cloth. Avoid using harsh chemicals or abrasive cleaners.","materialComposition":"Metal base and neck with fabric shade"}',
    '["touch dimmer","modern","bedside","adjustable","minimalist","reading light","office lamp","compact","elegant","versatile","ambient lighting","task lighting","flexible neck","cream shade","brass accent","space-saving","sleek design","three brightness levels","decorative","functional","stylish","contemporary","small spaces","home office","nightstand lamp","easy adjustment","soft lighting","sophisticated","touch dimmer lamp","modern lighting","bedside lamp","adjustable neck","minimalist design","compact lamp","elegant lighting","versatile lamp","cream shade lamp","brass accent lamp","space-saving lamp","sleek design lamp","decorative lamp","functional lighting","stylish lamp","contemporary lighting","small space lamp","home office lighting","easy adjustment lighting","sophisticated lamp"]',
    '{"metaTitle":"Touch Dimmer Table Lamp - Elegant & Adjustable Lighting","metaDescription":"Illuminate your space with the Touch Dimmer Table Lamp. Its sleek design and touch-activated dimmer offer versatility. Perfect for any decor style. Shop now!","altText":"Elegant touch dimmer table lamp with cream shade and adjustable brass neck for versatile lighting.","keywords":["touch dimmer lamp","modern lighting","bedside lamp","adjustable neck","minimalist design","reading light","office lamp","compact lamp","elegant lighting","versatile lamp","ambient lighting","task lighting","flexible neck","cream shade lamp","brass accent lamp","space-saving lamp","sleek design lamp","three brightness levels","decorative lamp","functional lighting","stylish lamp","contemporary lighting","small space lamp","home office lighting","nightstand lamp","easy adjustment lighting","soft lighting","sophisticated lamp"]}',
    FALSE,
    TRUE,
    4.5,
    234,
    TRUE,
    '2024-01-22T00:00:00Z',
    '2024-01-22T00:00:00Z'
FROM categories c
WHERE c.slug = 'lighting'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Sculptural Art Table Lamp
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'LGT-TL-009',
    'Sculptural Art Table Lamp',
    'Abstract sculptural lamp doubling as art piece',
    249.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'table-lamp' AND category_id = c.id),
    8,
    'in_stock'::stock_status,
    '{"color":["Teal"],"material":["Metal"],"style":["Modern","Contemporary"],"room":["Living Room","Office"],"occasion":["Everyday","Task Lighting"]}',
    '{"primaryColors":[{"name":"Teal","hex":"#008080","category":"primary"}],"pattern":"solid","texture":"smooth","finish":"gloss","shape":"angular","silhouette":"Adjustable arm with clean lines"}',
    '{"short":"Elevate your space with this sculptural teal table lamp featuring an adjustable arm for perfect lighting.","long":"Illuminate your home with the Sculptural Art Table Lamp, a masterpiece of modern design and functionality. This stunning lamp is finished in a vibrant teal, adding a pop of color to any room while complementing contemporary decor. Its sleek, angular shape and smooth gloss finish make it both a functional lighting solution and a statement art piece. The adjustable arm provides versatile positioning, ideal for reading or task lighting in a living room or home office. Crafted from sturdy metal, this lamp promises durability and style, effortlessly enhancing your interior design. Its minimalist silhouette ensures it blends seamlessly with any aesthetic, making it a must-have for those who appreciate artistic yet practical home decor.","features":["Adjustable arm for customizable lighting","Vibrant teal color for a stylish accent","Durable metal construction for longevity","Sleek, sculptural design adds artistic flair","Gloss finish enhances modern aesthetic","Ideal for living rooms, offices, or study areas"],"careInstructions":"To maintain its sleek appearance, wipe the lamp with a soft, damp cloth regularly. Avoid using harsh chemicals or abrasive materials that could damage the finish.","materialComposition":"Constructed from high-quality metal with a painted teal gloss finish"}',
    '["sculptural","art piece","abstract","contemporary","statement","table lamp","teal lamp","adjustable lamp","modern lighting","contemporary decor","task lighting","metal lamp","sculptural design","statement piece","home office","living room lighting","stylish lamp","decorative lamp","artistic lamp","minimalist lamp","colorful lamp","interior design","home decor","lighting fixture","adjustable arm lamp","desk lamp","reading lamp","workspace lighting","accent lamp","designer lamp","unique lamp","functional lamp","durable lamp","Sculptural Art Table Lamp","Teal Table Lamp","Adjustable Arm Lamp","Modern Lighting","Contemporary Decor","Task Lighting","Metal Lamp","Sculptural Design","Statement Piece","Home Office Lamp","Living Room Lighting","Stylish Lamp","Decorative Lamp","Artistic Lamp","Minimalist Lamp","Colorful Lamp","Interior Design","Home Decor","Lighting Fixture","Desk Lamp","Reading Lamp","Workspace Lighting","Accent Lamp","Designer Lamp","Unique Lamp","Functional Lamp","Durable Lamp"]',
    '{"metaTitle":"Sculptural Art Table Lamp - Teal Finish & Adjustable Arm","metaDescription":"Illuminate your space with our Sculptural Art Table Lamp. Featuring a modern teal finish and adjustable arm, it''s perfect for stylish, versatile lighting. Shop now!","altText":"Stylish teal table lamp with adjustable arm and modern design, perfect for task lighting.","keywords":["Sculptural Art Table Lamp","Teal Table Lamp","Adjustable Arm Lamp","Modern Lighting","Contemporary Decor","Task Lighting","Metal Lamp","Sculptural Design","Statement Piece","Home Office Lamp","Living Room Lighting","Stylish Lamp","Decorative Lamp","Artistic Lamp","Minimalist Lamp","Colorful Lamp","Interior Design","Home Decor","Lighting Fixture","Desk Lamp","Reading Lamp","Workspace Lighting","Accent Lamp","Designer Lamp","Unique Lamp","Functional Lamp","Durable Lamp"]}',
    TRUE,
    FALSE,
    4.7,
    45,
    TRUE,
    '2024-01-24T00:00:00Z',
    '2024-01-24T00:00:00Z'
FROM categories c
WHERE c.slug = 'lighting'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Industrial Swing Arm Sconce
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'LGT-WS-001',
    'Industrial Swing Arm Sconce',
    'Adjustable industrial wall sconce with swing arm',
    89.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'wall-sconce' AND category_id = c.id),
    40,
    'in_stock'::stock_status,
    '{"color":["Olive Green","Warm Brass","Natural Wood"],"material":["Brass","Ceramic","Wood"],"style":["Industrial","Vintage"],"room":["Bedroom","Office","Living Room"],"occasion":["Everyday","Reading"]}',
    '{"primaryColors":[{"name":"Olive Green","hex":"#556B2F","category":"primary"},{"name":"Warm Brass","hex":"#B8860B","category":"accent"},{"name":"Natural Wood","hex":"#D2B48C","category":"secondary"}],"pattern":"solid","texture":"smooth","finish":"matte","shape":"curved","silhouette":"sleek with a curved arm and dome shade"}',
    '{"short":"Elegant industrial swing arm sconce with a brass finish and green shade.","long":"Illuminate your space with the Industrial Swing Arm Sconce, a harmonious blend of style and functionality. This sconce features a warm brass arm paired with a deep olive green ceramic shade, exuding a sophisticated charm. The wooden wall mount adds a touch of rustic elegance, complementing both modern and vintage decor styles. Its adjustable swing arm offers customizable lighting, perfect for creating cozy reading nooks or enhancing ambient lighting in your living room or office. Crafted with high-quality materials, this sconce promises durability while elevating your interior aesthetic.","features":["Adjustable swing arm for versatile lighting","Deep olive green ceramic shade","Warm brass finish for a vintage touch","Sturdy wooden wall mount","Ideal for modern and vintage decor","High-quality materials ensure durability","Space-saving wall-mounted design"],"careInstructions":"Clean gently with a soft, dry cloth. Avoid harsh chemicals or abrasive cleaners to preserve the finish.","materialComposition":"Brass arm, ceramic shade, wooden mount"}',
    '["swing arm","industrial","adjustable","wall sconce","vintage","brass","green shade","wood mount","elegant lighting","modern decor","ambient lighting","reading nook","home decor","interior design","stylish","durable","versatile","sleek design","high-quality materials","living room lighting","office lighting","bedroom lighting","decorative sconce","unique style","contemporary","classic","home improvement","lighting fixture","wall-mounted","space-saving","functional","decorative","industrial swing arm sconce","adjustable wall sconce","vintage lighting","brass and green sconce","decorative wall lighting","elegant lighting fixture","home decor lighting","reading nook light","modern decor sconce","stylish wall mount light","high-quality sconce","interior design lighting","office wall sconce","bedroom lighting fixture","unique style sconce","contemporary wall light","classic wall sconce","home improvement lighting","space-saving wall light","functional wall sconce","decorative lighting fixture","olive green and brass sconce","wood mount wall light","versatile lighting options","sleek design sconce","durable lighting fixture","vintage decor sconce","modern industrial sconce"]',
    '{"metaTitle":"Industrial Swing Arm Sconce - Adjustable Lighting & Style","metaDescription":"Enhance your decor with the Industrial Swing Arm Sconce. Adjustable arm and elegant design make it perfect for any space. Order now for stylish lighting!","altText":"Industrial swing arm sconce with olive green shade and brass arm on wooden mount.","keywords":["industrial swing arm sconce","adjustable wall sconce","vintage lighting","brass and green sconce","decorative wall lighting","elegant lighting fixture","home decor lighting","reading nook light","ambient lighting","modern decor sconce","stylish wall mount light","high-quality sconce","interior design lighting","living room lighting","office wall sconce","bedroom lighting fixture","unique style sconce","contemporary wall light","classic wall sconce","home improvement lighting","space-saving wall light","functional wall sconce","decorative lighting fixture","olive green and brass sconce","wood mount wall light","versatile lighting options","sleek design sconce","durable lighting fixture","vintage decor sconce","modern industrial sconce"]}',
    FALSE,
    TRUE,
    4.6,
    189,
    TRUE,
    '2024-01-08T00:00:00Z',
    '2024-01-08T00:00:00Z'
FROM categories c
WHERE c.slug = 'lighting'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Crystal Wall Sconce
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'LGT-WS-002',
    'Crystal Wall Sconce',
    'Elegant crystal wall sconce with chrome finish',
    149.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'wall-sconce' AND category_id = c.id),
    25,
    'in_stock'::stock_status,
    '{"color":["Warm Chestnut Brown","Frosted White"],"material":["Wood","Frosted Glass"],"style":["Contemporary","Scandinavian"],"room":["Living Room","Bedroom","Hallway"],"occasion":["Everyday","Relaxation"]}',
    '{"primaryColors":[{"name":"Warm Chestnut Brown","hex":"#8B4513","category":"primary"},{"name":"Frosted White","hex":"#F5F5F5","category":"accent"}],"pattern":"solid","texture":"smooth","finish":"matte","shape":"organic","silhouette":"Organic shape with a rounded globe"}',
    '{"short":"Elegant wall sconce with a warm glow and organic wooden base.","long":"Illuminate your space with the Crystal Wall Sconce, an exquisite blend of contemporary and Scandinavian design. This stunning fixture features a smooth, organic-shaped wooden base in a warm chestnut brown, perfectly paired with a frosted white glass globe. As the light filters through, it creates a soft, warm glow, transforming any room into a serene oasis. Ideal for hallways, bedrooms, or living rooms, this sconce adds a sophisticated touch of warmth and elegance to your decor. Easy to mount, it''s designed for effortless installation and timeless appeal, making it an essential addition to modern interiors.","features":["Smooth organic wooden base","Frosted glass globe for soft illumination","Warm ambient lighting to enhance mood","Minimalist, elegant design","Quick and easy wall mounting","Perfect for contemporary and Scandinavian styles","Versatile use in various rooms"],"careInstructions":"Wipe with a soft, dry cloth. Avoid harsh chemicals or abrasive materials on the wooden base.","materialComposition":"Wooden base in warm chestnut brown with frosted glass globe"}',
    '["crystal","glamorous","chrome","elegant","wall sconce","modern lighting","wooden sconce","ambient light","frosted glass","contemporary decor","Scandinavian style","wall mounted","warm glow","minimalist design","elegant lighting","organic shape","bedroom lighting","hallway light","living room decor","soft illumination","easy installation","natural materials","stylish sconce","home lighting","interior design","Crystal Wall Sconce","smooth texture","matte finish","organic silhouette","warm chestnut brown","frosted white globe"]',
    '{"metaTitle":"Crystal Wall Sconce - Modern Lighting with Warm Glow","metaDescription":"Illuminate your home with the Crystal Wall Sconce. Experience the elegance of Scandinavian design and effortless installation. Perfect for any room!","altText":"Elegant Crystal Wall Sconce with organic wooden base and frosted glass globe emitting warm ambient light.","keywords":["Crystal Wall Sconce","modern lighting","wooden sconce","ambient light","frosted glass","contemporary decor","Scandinavian style","wall mounted","warm glow","minimalist design","elegant lighting","organic shape","bedroom lighting","hallway light","living room decor","soft illumination","easy installation","natural materials","stylish sconce","home lighting","interior design","smooth texture","matte finish","organic silhouette","warm chestnut brown","frosted white globe"]}',
    TRUE,
    FALSE,
    4.8,
    112,
    TRUE,
    '2024-01-10T00:00:00Z',
    '2024-01-10T00:00:00Z'
FROM categories c
WHERE c.slug = 'lighting'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Modern Globe Sconce
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'LGT-WS-003',
    'Modern Globe Sconce',
    'Minimalist globe wall sconce with brass hardware',
    79.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'wall-sconce' AND category_id = c.id),
    55,
    'in_stock'::stock_status,
    '{"color":["Warm Brass","Soft Beige","Matte Black"],"material":["Brass","Fabric","Metal"],"style":["Modern","Minimalist"],"room":["Bathroom","Bedroom","Hallway"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Warm Brass","hex":"#B8860B","category":"primary"},{"name":"Soft Beige","hex":"#F5F5DC","category":"secondary"},{"name":"Matte Black","hex":"#2F2F2F","category":"accent"}],"pattern":"solid","texture":"textured","finish":"matte","shape":"angular","silhouette":"Slim profile with angular shade"}',
    '{"short":"Stylish globe sconce with brass and matte black accents for a modern touch.","long":"Illuminate your space with the Modern Globe Sconce, an embodiment of contemporary elegance. Featuring a spherical design, this sconce combines warm brass and matte black finishes to create a striking visual contrast. Its soft glow is perfect for setting a cozy atmosphere in any room, whether it''s a bathroom, bedroom, or hallway. The minimalist silhouette seamlessly integrates into various decor styles, providing both ambient and task lighting. Crafted to enhance your home''s aesthetic while being functional, this sconce is an ideal choice for those who appreciate refined luxury.","features":["Spherical globe design","Warm brass accents","Matte black finish","Versatile ambient lighting","Contemporary minimalist style","Easy wall installation","Durable metal construction"],"careInstructions":"Wipe the surface with a soft, damp cloth to remove dust. Avoid harsh chemicals on brass and metal components.","materialComposition":"Brass accents, matte black metal frame, glass globe"}',
    '["globe","modern","minimalist","brass","white","wall sconce","modern lighting","brass hardware","pleated shade","minimalist design","ambient lighting","task lighting","bathroom light","bedroom light","hallway light","elegant lighting","contemporary decor","luxury lighting","fabric shade","metal arm","warm brass","soft beige","matte black","angular design","slim profile","versatile light","stylish sconce","decorative lighting","home lighting","interior design","lighting fixture","decor accent","modern sconce","minimalist sconce","brass sconce","fabric sconce","black sconce","elegant sconce","ambient sconce","task sconce","bathroom sconce","bedroom sconce","hallway sconce","modern globe sconce","elegant wall sconce","brass lighting fixture","black metal arm","pleated shade lighting","bathroom light fixture","bedroom lighting","decorative sconce","interior design lighting","modern minimalist sconce","brass hardware light","fabric shade sconce","stylish lighting fixture","versatile home lighting","warm brass finish","matte black accent","angular design sconce","slim profile lighting","refined luxury sconce","ambient and task lighting","modern home decor"]',
    '{"metaTitle":"Modern Globe Sconce - Elegant Brass & Black Lighting Fixture","metaDescription":"Illuminate your home with the Modern Globe Sconce. Featuring a brass and black finish, it''s perfect for creating a cozy atmosphere. Shop now for refined luxury!","altText":"Modern Globe Sconce with brass accents and pleated shade, ideal for ambient lighting in various rooms.","keywords":["modern globe sconce","elegant wall sconce","brass lighting fixture","black metal arm","pleated shade lighting","ambient lighting","task lighting","minimalist design","contemporary decor","luxury lighting","bathroom light fixture","bedroom lighting","hallway sconce","home lighting","decorative sconce","interior design lighting","modern minimalist sconce","brass hardware light","fabric shade sconce","stylish lighting fixture","versatile home lighting","warm brass finish","matte black accent","angular design sconce","slim profile lighting","refined luxury sconce","ambient and task lighting","modern home decor"]}',
    FALSE,
    FALSE,
    4.5,
    145,
    TRUE,
    '2024-01-12T00:00:00Z',
    '2024-01-12T00:00:00Z'
FROM categories c
WHERE c.slug = 'lighting'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Art Deco Sconce
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'LGT-WS-004',
    'Art Deco Sconce',
    'Geometric art deco wall sconce with frosted glass',
    129.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'wall-sconce' AND category_id = c.id),
    18,
    'in_stock'::stock_status,
    '{"color":["Gold","Frosted White"],"material":["Metal","Glass"],"style":["Art Deco","Glamorous"],"room":["Living Room","Dining Room","Foyer"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Gold","hex":"#D4AF37","category":"primary"},{"name":"Frosted White","hex":"#F5F5F5","category":"accent"}],"pattern":"solid","texture":"smooth","finish":"brushed","shape":"organic","silhouette":"Vertical with spherical elements"}',
    '{"short":"Elegant Art Deco sconce with frosted glass globes and glamorous gold finish.","long":"Illuminate your space with the luxurious allure of the Art Deco Sconce. This wall-mounted fixture boasts a captivating geometric design, featuring frosted glass globes that offer a gentle, ambient glow. The sconce is adorned with a brushed gold finish, adding a sophisticated touch to any room. Perfect for living rooms, dining rooms, or foyers, its seamless blend of style and function transforms interiors with a sense of refined elegance. Whether accentuating a modern decor or adding a vintage-inspired charm, this sconce is a stunning addition that elevates your lighting game.","features":["Elegant Art Deco geometric design","Soft glow from frosted glass globes","Glamorous brushed gold finish","Wall-mounted for versatile placement","Ideal for living, dining, or foyer spaces","Enhances sophisticated interiors","Combines style with functionality"],"careInstructions":"Gently wipe with a soft, dry cloth to maintain shine. Avoid harsh chemicals or abrasive cleaning materials.","materialComposition":"Crafted with a durable metal frame and frosted glass globes for a luxurious finish."}',
    '["art deco","geometric","gold","frosted glass","glamorous","wall sconce","ambient lighting","luxury lighting","home decor","interior design","modern lighting","elegant","stylish","sophisticated","living room lighting","dining room lighting","foyer lighting","metal frame","glass globes","vertical design","spherical elements","brushed finish","smooth texture","Art Deco sconce","geometric design","frosted glass globes","gold finish","wall-mounted light","stylish lighting","sophisticated decor","elegant wall sconce","glamorous lighting","metal frame light","glass globe lighting","vertical design light","art deco style","luxurious allure","refined elegance","vintage-inspired charm","modern decor accent","sophisticated interiors"]',
    '{"metaTitle":"Art Deco Sconce - Luxurious Gold Finish & Ambient Glow","metaDescription":"Transform your space with the Art Deco Sconce. Enjoy ambient lighting and a sophisticated gold finish. Perfect for any stylish room. Buy now!","altText":"Elegant Art Deco sconce with frosted glass globes and gold finish.","keywords":["Art Deco sconce","luxury lighting","geometric design","frosted glass globes","gold finish","ambient lighting","wall-mounted light","living room lighting","dining room lighting","foyer lighting","stylish lighting","sophisticated decor","modern lighting","elegant wall sconce","home decor","interior design","glamorous lighting","metal frame light","glass globe lighting","vertical design light","spherical elements","brushed finish","smooth texture","art deco style","luxurious allure","refined elegance","vintage-inspired charm","modern decor accent","sophisticated interiors"]}',
    TRUE,
    FALSE,
    4.7,
    78,
    TRUE,
    '2024-01-14T00:00:00Z',
    '2024-01-14T00:00:00Z'
FROM categories c
WHERE c.slug = 'lighting'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Fabric Shade Wall Sconce
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'LGT-WS-005',
    'Fabric Shade Wall Sconce',
    'Classic fabric shade wall sconce for ambient lighting',
    99.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'wall-sconce' AND category_id = c.id),
    32,
    'in_stock'::stock_status,
    '{"color":["Warm Bronze","Beige"],"material":["Fabric","Bronze Metal"],"style":["Traditional","Classic"],"room":["Living Room","Bedroom","Hallway"],"occasion":["Everyday","Relaxing"]}',
    '{"primaryColors":[{"name":"Warm Bronze","hex":"#8C6E58","category":"primary"},{"name":"Beige","hex":"#F5F5DC","category":"secondary"}],"pattern":"solid","texture":"smooth","finish":"matte","shape":"oval","silhouette":"Slim profile with an oval shape"}',
    '{"short":"Chic wall sconce with warm bronze finish and fabric shade, perfect for ambient living room or bedroom lighting.","long":"Illuminate your home with the exquisite Fabric Shade Wall Sconce, designed to bring a touch of elegance and warmth to your space. Featuring a sophisticated warm bronze finish paired with a soft fabric shade, this sconce provides a gentle, ambient glow that effortlessly enhances any room''s atmosphere. Perfect for traditional and classic interiors, it complements bedrooms, living rooms, and hallways with its subtle yet stylish design. The oval silhouette and smooth texture add a layer of refinement, while the fabric shade softly diffuses light, creating a cozy and inviting environment. Transform your living space into a haven of tranquility with this versatile lighting solution.","features":["Warm bronze matte finish","Soft fabric shade for diffused lighting","Elegantly complements traditional and classic decor","Ideal for living rooms, bedrooms, and hallways","Oval shape with a slim profile","Provides a cozy, ambient glow"],"careInstructions":"Dust regularly with a soft cloth. Avoid using harsh chemicals on the fabric shade to maintain its quality.","materialComposition":"Bronze metal base with a fabric shade"}',
    '["fabric shade","traditional","classic","ambient","beige","wall sconce","ambient lighting","traditional decor","classic style","bronze finish","elegant lighting","bedroom lighting","living room lighting","hallway lighting","soft glow","warm ambiance","home decor","interior lighting","decorative sconce","beige shade","matte finish","oval design","metal base","fabric diffuser","cozy atmosphere","lighting fixture","wall-mounted","ambient glow","stylish lighting","classic elegance","bronze metal","decor accent","lighting solution","home lighting","sconce light","traditional lighting","classic lighting","bronze sconce","fabric lighting","soft lighting","warm lighting","decorative lighting","interior design","lighting decor","ambient sconce","classic wall sconce","Fabric Shade Wall Sconce"]',
    '{"metaTitle":"Fabric Shade Wall Sconce - Elegant Ambient Lighting Fixture","metaDescription":"Enhance your space with our Fabric Shade Wall Sconce. Experience elegance and warmth with its warm bronze finish. Ideal for bedrooms, living rooms, and hallways. Shop now!","altText":"Elegant wall sconce with warm bronze finish and fabric shade for ambient lighting.","keywords":["Fabric Shade Wall Sconce","ambient lighting","traditional decor","classic style","bronze finish","elegant lighting","bedroom lighting","living room lighting","hallway lighting","soft glow","warm ambiance","home decor","interior lighting","decorative sconce","beige shade","matte finish","oval design","metal base","fabric diffuser","cozy atmosphere","lighting fixture","wall-mounted","ambient glow","stylish lighting","classic elegance","bronze metal","home lighting","sconce light","traditional lighting","classic lighting"]}',
    FALSE,
    FALSE,
    4.4,
    98,
    TRUE,
    '2024-01-16T00:00:00Z',
    '2024-01-16T00:00:00Z'
FROM categories c
WHERE c.slug = 'lighting'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: LED Picture Light
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'LGT-WS-006',
    'LED Picture Light',
    'Slim LED picture light for artwork and displays',
    69.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'wall-sconce' AND category_id = c.id),
    45,
    'in_stock'::stock_status,
    '{"color":["Warm White","Warm Wood"],"material":["Glass","Wood"],"style":["Modern","Minimalist"],"room":["Living Room","Gallery","Office"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Warm White","hex":"#F5F5DC","category":"primary"},{"name":"Warm Wood","hex":"#8B4513","category":"secondary"}],"pattern":"solid","texture":"smooth","finish":"matte","shape":"organic","silhouette":"Wall-mounted with a spherical shade and linear arm"}',
    '{"short":"Illuminate your art with this elegant LED picture light, featuring a sleek design and warm ambiance.","long":"Transform your living space with the sophisticated elegance of our LED Picture Light. Designed to enhance the beauty of your artwork, this fixture features a sleek, minimalist silhouette with a smooth, spherical white glass shade that casts a soft, ambient glow. The arm, crafted from warm wood, adds a touch of natural sophistication, seamlessly blending into both modern and traditional interiors. Ideal for illuminating your favorite pieces in living rooms, galleries, or offices, this versatile light enhances any environment with its stylish design and functional lighting. Whether it’s for an everyday setting or an entertaining occasion, this wall-mounted picture light will create a warm, inviting atmosphere.","features":["Spherical white glass shade","Warm wood arm for natural elegance","Soft, ambient lighting","Minimalist and sleek design","Versatile for modern and traditional spaces","Wall-mounted for easy installation","Perfect for living rooms, galleries, and offices"],"careInstructions":"Gently wipe with a soft, dry cloth to maintain its pristine appearance. Avoid using harsh chemicals or abrasive materials.","materialComposition":"Crafted with a smooth glass shade and a sturdy wooden arm for lasting durability and style."}',
    '["picture light","LED","artwork","gallery","slim","LED light","ambient lighting","spherical shade","wood arm","modern lighting","minimalist design","wall-mounted","art illumination","home decor","gallery light","office light","living room light","elegant lighting","soft glow","natural materials","versatile light","warm ambiance","decorative lighting","contemporary design","interior lighting","stylish light","home lighting","art display","soft lighting","glass shade","wood finish","modern home","minimalist home","design lighting","sophisticated lighting","LED picture light","wall-mounted light"]',
    '{"metaTitle":"LED Picture Light - Elegant Art Illumination & Ambient Glow","metaDescription":"Enhance your artwork with our LED Picture Light''s ambient glow. Sleek design, wood arm - perfect for living rooms, galleries, or offices. Order now!","altText":"Elegant LED picture light with spherical white glass shade and warm wood arm for ambient lighting.","keywords":["LED picture light","ambient lighting","spherical shade","wood arm","modern lighting","minimalist design","wall-mounted light","art illumination","home decor","gallery light","office light","living room light","elegant lighting","soft glow","natural materials","versatile light","warm ambiance","decorative lighting","contemporary design","interior lighting","stylish light","home lighting","art display","soft lighting","glass shade","wood finish","modern home","minimalist home","design lighting","sophisticated lighting"]}',
    FALSE,
    FALSE,
    4.5,
    67,
    TRUE,
    '2024-01-18T00:00:00Z',
    '2024-01-18T00:00:00Z'
FROM categories c
WHERE c.slug = 'lighting'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Outdoor Lantern Sconce
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'LGT-WS-007',
    'Outdoor Lantern Sconce',
    'Weather-resistant outdoor lantern wall sconce',
    119.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'wall-sconce' AND category_id = c.id),
    38,
    'in_stock'::stock_status,
    '{"color":["Black","Clear"],"material":["Metal","Glass"],"style":["Traditional","Farmhouse"],"room":["Porch","Entryway","Patio"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Black","hex":"#000000","category":"primary"},{"name":"Clear","hex":"#FFFFFF","category":"accent"}],"pattern":"solid","texture":"smooth","finish":"matte","shape":"angular","silhouette":"Classic lantern with angular lines"}',
    '{"short":"Elegant outdoor lantern sconce with weather-resistant metal and glass, perfect for adding charm to your porch or patio.","long":"Illuminate your outdoor spaces with the Outdoor Lantern Sconce, a perfect blend of elegance and durability. Crafted with a robust metal frame and clear glass panels, this sconce offers a warm glow that enhances the ambiance of porches, entryways, or patios. Its traditional lantern design with a farmhouse flair ensures a timeless appeal that complements a variety of outdoor settings. The weather-resistant materials promise longevity, while the sleek black finish adds a touch of sophistication. Whether you''re creating a cozy outdoor nook or highlighting your home''s architectural features, this lantern sconce is a stylish and functional addition.","features":["Weather-resistant metal and glass construction","Traditional lantern silhouette with farmhouse style","Sleek black matte finish for a sophisticated look","Clear glass panels for optimal light diffusion","Perfect for porches, entryways, and patios","Easy wall-mounted installation","Timeless design for versatile outdoor decor"],"careInstructions":"To maintain its finish, gently wipe with a damp cloth. Avoid using harsh chemicals that may damage the surface.","materialComposition":"Constructed with a durable metal frame and clear glass panels for lasting performance."}',
    '["outdoor","lantern","weather-resistant","porch","farmhouse","outdoor lighting","lantern sconce","porch light","entryway lighting","patio decor","traditional style","farmhouse decor","metal and glass","classic lantern","black finish","clear glass","durable construction","elegant design","ambient lighting","wall-mounted","exterior light","home improvement","garden lighting","decorative sconce","rustic charm","timeless appeal","easy maintenance","versatile use","high-quality materials","stylish outdoor lighting","enhanced curb appeal","inviting glow","secure mounting","long-lasting","outdoor lantern sconce","weather-resistant lighting","traditional style lighting","metal and glass sconce","classic lantern design","black finish lighting","clear glass panels","durable outdoor light","elegant outdoor lighting","ambient lighting for outdoors","wall-mounted exterior light","home improvement lighting","garden lighting solutions","decorative outdoor sconce","rustic charm lighting","timeless appeal lantern","easy maintenance sconce","versatile outdoor lighting","inviting glow lighting","secure mounting sconce","long-lasting outdoor light"]',
    '{"metaTitle":"Outdoor Lantern Sconce - Elegant, Weather-Resistant Lighting","metaDescription":"Illuminate your outdoor spaces with our elegant Outdoor Lantern Sconce. Durable and weather-resistant, it''s perfect for porches, patios, and entryways. Buy now!","altText":"Elegant black outdoor lantern sconce with clear glass panels and weather-resistant design.","keywords":["outdoor lantern sconce","weather-resistant lighting","porch light","entryway lighting","patio decor","traditional style lighting","farmhouse decor","metal and glass sconce","classic lantern design","black finish lighting","clear glass panels","durable outdoor light","elegant outdoor lighting","ambient lighting for outdoors","wall-mounted exterior light","home improvement lighting","garden lighting solutions","decorative outdoor sconce","rustic charm lighting","timeless appeal lantern","easy maintenance sconce","versatile outdoor lighting","high-quality materials","stylish outdoor lighting","enhanced curb appeal","inviting glow lighting","secure mounting sconce","long-lasting outdoor light"]}',
    FALSE,
    TRUE,
    4.6,
    156,
    TRUE,
    '2024-01-20T00:00:00Z',
    '2024-01-20T00:00:00Z'
FROM categories c
WHERE c.slug = 'lighting'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Up-Down Wall Light
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'LGT-WS-008',
    'Up-Down Wall Light',
    'Modern up-down LED wall light for ambient effects',
    89.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'wall-sconce' AND category_id = c.id),
    30,
    'in_stock'::stock_status,
    '{"color":["Matte Black"],"material":["Aluminum"],"style":["Modern","Contemporary"],"room":["Hallway","Living Room","Bedroom"],"occasion":["Everyday","Ambient Lighting"]}',
    '{"primaryColors":[{"name":"Matte Black","hex":"#2B2B2B","category":"primary"}],"pattern":"solid","texture":"matte","finish":"matte","shape":"cylindrical","silhouette":"Low-profile cylindrical form"}',
    '{"short":"Illuminate your space with the sleek and modern Up-Down Wall Light, offering ambient LED lighting for any decor.","long":"Transform your living space with the Up-Down Wall Light, a sophisticated fixture that blends style and functionality. Its sleek cylindrical silhouette crafted from durable aluminum and finished in a matte black hue, exudes contemporary elegance. Ideal for hallways, living rooms, or bedrooms, this wall light casts a warm, ambient glow both upwards and downwards, creating a serene atmosphere. The minimalist design seamlessly integrates with modern and contemporary decor styles, providing a versatile lighting solution that enhances any room''s aesthetic. Whether you''re highlighting artwork or illuminating a cozy reading nook, this energy-efficient LED light fixture is the perfect choice for stylish home illumination.","features":["Up-down LED illumination for ambient lighting","Sleek, modern cylindrical design","Elegant matte black finish","Constructed from durable aluminum","Complements modern and contemporary decor","Energy-efficient LED lighting"],"careInstructions":"Wipe gently with a soft, dry cloth. Avoid harsh chemicals or abrasive cleaners to maintain the finish.","materialComposition":"Constructed from high-quality aluminum with a matte black finish"}',
    '["up-down","LED","modern","ambient","contemporary","up-down lighting","LED wall light","modern wall sconce","ambient lighting","contemporary design","matte black light","cylindrical wall light","aluminum light fixture","hallway lighting","living room light","bedroom illumination","minimalist lighting","home decor","interior design","wall-mounted light","energy-efficient lighting","stylish light fixture","modern home lighting","sleek design","soft lighting","up-down wall light","modern decor","contemporary wall light","upward and downward illumination","matte finish wall light","elegant wall fixture","LED lighting solutions"]',
    '{"metaTitle":"Up-Down Wall Light - Modern LED Illumination Fixture","metaDescription":"Enhance your space with the Up-Down Wall Light. Sleek, energy-efficient LED design casts ambient glow. Perfect for modern decor. Shop now!","altText":"Sleek modern up-down wall light with matte black finish, LED illumination","keywords":["up-down wall light","LED wall light","modern wall sconce","ambient lighting","contemporary design","matte black light","cylindrical wall light","aluminum light fixture","hallway lighting","living room light","bedroom illumination","minimalist lighting","home decor","interior design","wall-mounted light","energy-efficient lighting","stylish light fixture","modern home lighting","sleek design","soft lighting","modern decor","contemporary wall light","upward and downward illumination","matte finish wall light","elegant wall fixture","LED lighting solutions"]}',
    FALSE,
    FALSE,
    4.4,
    89,
    TRUE,
    '2024-01-22T00:00:00Z',
    '2024-01-22T00:00:00Z'
FROM categories c
WHERE c.slug = 'lighting'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- ----------------------------------------------------------------------------
-- Decor (19 products)
-- ----------------------------------------------------------------------------

-- Product: Terracotta Floor Vase
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'DEC-DECOR-VASE-002',
    'Terracotta Floor Vase',
    'Large terracotta floor vase with natural texture. Ideal for dried arrangements.',
    95,
    125,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'vase' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Warm Beige"],"material":["Terracotta"],"style":["Bohemian","Mediterranean"],"room":["Living Room","Entryway"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Warm Beige","hex":"#D3B8A6","category":"primary"}],"pattern":"solid","texture":"smooth","finish":"matte","shape":"organic","silhouette":"Tall and slender with a graceful curve"}',
    '{"short":"Elegant terracotta floor vase with a smooth, natural finish perfect for dried arrangements.","long":"This terracotta floor vase boasts a smooth, natural finish that adds warmth and sophistication to any room. Its large size makes it ideal for showcasing dried arrangements, creating an inviting atmosphere. The vase''s neutral tones blend seamlessly with Bohemian and Mediterranean styles, enhancing your living space with its earthy charm. Crafted from high-quality terracotta, it offers durability and timeless appeal, making it a versatile decor piece for entryways or living rooms.","features":["Large size for impactful display","Smooth, natural terracotta finish","Ideal for dried floral arrangements","Versatile for Bohemian and Mediterranean styles","Durable and timeless design","Earthy warm beige color","Organic tall silhouette"],"careInstructions":"Dust gently with a soft cloth. Avoid exposure to moisture to preserve the terracotta finish.","materialComposition":"100% Terracotta"}',
    '["vase","terracotta","floor vase","bohemian","large","Mediterranean","home decor","natural finish","entryway","living room","dried arrangements","elegant","earthy tones","smooth texture","organic shape","matte finish","decor piece","versatile","timeless design","high-quality terracotta","warm beige","terracotta vase","Bohemian style","Mediterranean style","large vase","entryway decor","living room decor","elegant vase","versatile vase","warm beige vase","sophisticated decor","durable vase","inviting atmosphere","showcase vase","neutral tones","decorative vase","large terracotta vase"]',
    '{"metaTitle":"Terracotta Floor Vase - Elegant Decor with Natural Finish","metaDescription":"Enhance your home with our Terracotta Floor Vase, featuring a smooth finish and large size for dried arrangements. Perfect for Bohemian & Mediterranean styles. Shop now!","altText":"Elegant terracotta floor vase with a smooth, natural finish, ideal for dried arrangements in Bohemian and Mediterranean styles.","keywords":["terracotta vase","floor vase","home decor","Bohemian style","Mediterranean style","dried arrangements","large vase","natural finish","entryway decor","living room decor","elegant vase","earthy tones","smooth texture","organic shape","matte finish","decor piece","versatile vase","timeless design","high-quality terracotta","warm beige vase","sophisticated decor","durable vase","inviting atmosphere","showcase vase","neutral tones","decorative vase","large terracotta vase"]}',
    FALSE,
    TRUE,
    4.8,
    156,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'decor'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Ceramic Bud Vase
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'DEC-DECOR-VASE-001',
    'Ceramic Bud Vase',
    'Minimalist ceramic bud vase in matte white finish. Perfect for single stems.',
    28,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'vase' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Off-White"],"material":["Ceramic"],"style":["Minimalist","Modern"],"room":["Living Room","Bedroom","Office"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Off-White","hex":"#F5F5DC","category":"primary"}],"pattern":"textured","texture":"textured","finish":"matte","shape":"organic","silhouette":"Curved with an organic form"}',
    '{"short":"Elegant ceramic bud vase with textured matte finish.","long":"The Ceramic Bud Vase is a stunning addition to any home, offering a harmonious blend of elegance and simplicity. Its textured surface and matte finish create a tactile experience, while the organic silhouette invites a touch of nature indoors. Ideal for showcasing single stems or petite floral arrangements, this vase effortlessly enhances modern and minimalist interiors. The off-white color palette seamlessly integrates with a variety of decors, making it perfect for any room—from serene bedrooms to vibrant living spaces. At just $28, it''s an affordable way to elevate your decor with a sophisticated touch.","features":["Textured surface for added visual interest","Matte finish for a modern look","Organic silhouette complements natural decor","Versatile decor piece for any room","Perfect for single stems or small arrangements","Off-white color suits various palettes","Affordable elegance at $28"],"careInstructions":"Wipe gently with a soft, damp cloth. Avoid abrasive cleaners to maintain the matte finish.","materialComposition":"100% ceramic"}',
    '["vase","ceramic","minimalist","white","bud vase","modern","textured","matte finish","organic shape","decor","home decor","interior design","living room","bedroom","office","single stems","floral arrangement","elegant","sophisticated","off-white","ceramic bud vase","minimalist vase","modern vase","textured vase","matte finish vase","organic shape vase","living room decor","bedroom decor","office decor","single stem vase","floral arrangement vase","elegant vase","sophisticated vase","off-white vase","ceramic decor","modern interiors","minimalist interiors","stylish vase","affordable decor","unique vase","small floral arrangements","decor piece","vase for home"]',
    '{"metaTitle":"Ceramic Bud Vase - Textured Matte Finish Elegance","metaDescription":"Elevate your decor with our Ceramic Bud Vase. Perfect for single stems, its textured matte finish adds sophistication. Buy now for $28!","altText":"Elegant ceramic bud vase with textured matte finish, ideal for modern and minimalist decor.","keywords":["ceramic bud vase","decor","home decor","interior design","vase","minimalist vase","modern vase","textured vase","matte finish vase","organic shape vase","living room decor","bedroom decor","office decor","single stem vase","floral arrangement vase","elegant vase","sophisticated vase","off-white vase","ceramic decor","modern interiors","minimalist interiors","stylish vase","affordable decor","unique vase","small floral arrangements","decor piece","vase for home"]}',
    TRUE,
    FALSE,
    4.6,
    89,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'decor'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Glass Cylinder Vase
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'DEC-DECOR-VASE-003',
    'Glass Cylinder Vase',
    'Clear glass cylinder vase with modern proportions. Versatile for any arrangement.',
    35,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'vase' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Taupe"],"material":["Ceramic"],"style":["Modern","Minimalist"],"room":["Living Room","Dining Room","Bedroom"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Taupe","hex":"#B38B6D","category":"primary"}],"pattern":"ribbed","texture":"textured","finish":"matte","shape":"cylindrical","silhouette":"Tall with ribbed texture and clean lines"}',
    '{"short":"Sleek glass cylinder vase, perfect for showcasing floral arrangements and enhancing your decor.","long":"Elevate your decor with our Glass Cylinder Vase, a sleek and sophisticated piece ideal for any setting. Crafted from high-quality clear glass, this vase effortlessly complements both traditional and contemporary interiors. Its simple, cylindrical shape provides a versatile canvas for showcasing your favorite floral arrangements or decorative elements, such as stones or fairy lights. The transparency of the glass and its minimalist design make it a captivating centerpiece for dining tables, mantels, or entryways. At 12 inches tall, it offers ample space for long-stemmed flowers, bringing elegance and freshness to any room. Whether used solo or grouped with other vases, this piece adds a touch of timeless elegance to your home decor.","features":["High-quality clear glass construction","Simple, elegant cylindrical design","Versatile for various decor styles","Ideal for long-stemmed floral arrangements","Perfect centerpiece for tables and mantels","12 inches tall for ample display space"],"careInstructions":"Hand wash with warm soapy water. Dry thoroughly to prevent water spots. Handle with care to avoid chipping.","materialComposition":"100% Glass"}',
    '["vase","glass","cylinder","clear","modern","ceramic","ribbed","neutral","decor","taupe","textured","minimalist","elegant","home decor","interior design","flower vase","decorative","living room","dining room","bedroom","cylindrical","matte finish","durable","versatile","stylish","sophisticated","clean lines","tall vase","set of vases","display","arrangement","home accessory","design piece","accent decor","contemporary","artistic","Glass Cylinder Vase","elegant vase","clear glass vase","floral centerpiece","dining table decor","mantelpiece vase","12-inch vase","contemporary vase","traditional vase","decorative vase","glass decor","modern vase","minimalist vase","transparent vase","entryway decor","living room vase","high-quality glass","versatile vase","timeless elegance","centerpiece vase","decor statement"]',
    '{"metaTitle":"Glass Cylinder Vase - Elegant Decor for Any Setting","metaDescription":"Enhance your home with our Glass Cylinder Vase. Perfect for floral displays, this sleek, 12-inch centerpiece adds timeless elegance. Shop now!","altText":"Glass Cylinder Vase showcasing floral arrangements, ideal for modern and traditional decor settings.","keywords":["Glass Cylinder Vase","home decor","elegant vase","clear glass vase","floral centerpiece","dining table decor","mantelpiece vase","12-inch vase","contemporary vase","traditional vase","decorative vase","flower vase","glass decor","interior design","modern vase","minimalist vase","transparent vase","entryway decor","living room vase","high-quality glass","versatile vase","timeless elegance","centerpiece vase","home accessory","decor statement"]}',
    FALSE,
    FALSE,
    4.4,
    78,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'decor'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Ribbed Ceramic Vase
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'DEC-DECOR-VASE-004',
    'Ribbed Ceramic Vase',
    'Textured ribbed ceramic vase in sage green. Adds visual interest to any space.',
    48,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'vase' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Warm Beige","Soft Taupe"],"material":["Ceramic"],"style":["Modern","Transitional"],"room":["Living Room","Bedroom"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Warm Beige","hex":"#D3B8A6","category":"primary"},{"name":"Soft Taupe","hex":"#B8A48D","category":"secondary"}],"pattern":"ribbed","texture":"textured","finish":"natural","shape":"organic","silhouette":"Tall and slender with a rounded base"}',
    '{"short":"Elegant ribbed ceramic vase in earthy tones, perfect for enhancing any decor.","long":"Introducing the Ribbed Ceramic Vase, a masterpiece in home decor that effortlessly marries sophistication with simplicity. Its earthy tones and ribbed texture create a visual symphony that resonates with both modern and transitional styles. Standing tall with an organic shape, it serves as a captivating centerpiece in any room, be it your cozy living room or serene bedroom. Crafted from durable ceramic, this vase is designed to elegantly cradle both dried and fresh floral arrangements. The natural finish exudes a calming ambiance, making it not just a vase, but a piece of art that enhances your space''s aesthetic appeal. Elevate your home decor with this exquisite vase, where elegance meets function.","features":["Ribbed texture for added visual interest","Earthy tones complement various decor styles","Durable ceramic construction","Ideal for dried or fresh floral arrangements","Versatile design suitable for multiple rooms","Natural finish for a serene ambiance","Organic shape enhances aesthetic appeal"],"careInstructions":"Wipe with a damp cloth to clean. Avoid harsh chemicals to preserve the finish.","materialComposition":"100% Ceramic"}',
    '["vase","ceramic","ribbed","green","textured","earthy tones","modern decor","transitional style","home accessory","living room","bedroom","natural finish","organic shape","decorative vase","centerpiece","floral arrangement","home decor","elegant design","durable ceramic","visual interest","sophisticated","calm ambiance","versatile decor","stylish accessory","interior design","decor piece","artistic vase","unique design","decorative accessory","home styling","modern vase","transitional vase","textured vase","ribbed ceramic vase","beige vase","taupe vase","natural vase","decorative item","home enhancement","decor enhancement","room decor","decor inspiration","decorative art","stylish decor","interior styling","home aesthetics","elegant decor","home centerpiece","living room decor","bedroom decor","natural finish vase","organic shape vase","floral arrangement vase","durable ceramic vase","visual interest vase","sophisticated vase","calm ambiance decor","interior design vase","unique design vase","home styling vase"]',
    '{"metaTitle":"Ribbed Ceramic Vase - Elegant Decor Centerpiece","metaDescription":"Elevate your home with the Ribbed Ceramic Vase. Its earthy tones and ribbed texture create a stunning centerpiece. Perfect for dried or fresh flowers. Shop now!","altText":"Ribbed ceramic vase in warm beige and soft taupe, ideal for modern decor.","keywords":["ribbed ceramic vase","elegant decor","home centerpiece","modern vase","transitional style","earthy tones","textured vase","decorative vase","home accessory","living room decor","bedroom decor","natural finish vase","organic shape vase","floral arrangement vase","durable ceramic vase","visual interest vase","sophisticated vase","calm ambiance decor","versatile decor","stylish accessory","interior design vase","artistic vase","unique design vase","decorative accessory","home styling vase","beige vase","taupe vase","home enhancement","decor inspiration"]}',
    TRUE,
    FALSE,
    4.7,
    112,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'decor'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Soy Wax Pillar Candle
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'DEC-DECOR-CANDLE-001',
    'Soy Wax Pillar Candle',
    'Hand-poured soy wax pillar candle in vanilla scent. Clean burning and long-lasting.',
    24,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'candle' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Ivory","Warm Brass"],"material":["Soy Wax","Brass"],"style":["Classic","Vintage"],"room":["Living Room","Bedroom","Bathroom"],"occasion":["Everyday","Relaxation"]}',
    '{"primaryColors":[{"name":"Ivory","hex":"#FFFFF0","category":"primary"},{"name":"Warm Brass","hex":"#B8860B","category":"accent"}],"pattern":"solid","texture":"smooth","finish":"matte","shape":"cylindrical","silhouette":"Tall and slender with a smooth surface"}',
    '{"short":"Elegant soy wax pillar candle with soothing vanilla aroma.","long":"Transform your home into a serene sanctuary with our Soy Wax Pillar Candle. Hand-poured to perfection, this candle boasts a smooth ivory finish that complements any decor style. Its warm vanilla scent gently infuses your space, creating a cozy ambiance perfect for unwinding in the living room, bedroom, or bathroom. Enjoy clean burning and long-lasting illumination, accentuated by a vintage brass holder that adds a touch of timeless elegance to your surroundings.","features":["Hand-poured for quality craftsmanship","Inviting warm vanilla aroma","Clean burning for minimal soot","Durable, long-lasting burn","Elegant classic design","Complementary vintage brass holder","Smooth ivory finish"],"careInstructions":"Trim wick to 1/4 inch before each use. Avoid drafts and keep away from flammable materials. Allow the wax to pool across the surface before extinguishing.","materialComposition":"100% soy wax with cotton wick, brass holder"}',
    '["candle","soy","pillar","vanilla","scented","soy wax","pillar candle","vanilla scent","home decor","classic style","brass holder","elegant","long-lasting","clean burning","living room","bedroom","bathroom","relaxation","hand-poured","smooth finish","cylindrical shape","vintage","soy wax candle","vanilla scented candle","home decor candles","elegant candles","classic style candle","brass candle holder","long-lasting candle","clean burning candle","hand-poured candle","smooth finish candle","cylindrical candle","vintage candle style","cozy ambiance candle","living room decor","bedroom candle","bathroom candle","relaxation candle","ivory candle","warm brass holder","matte finish candle","tall candle","soy wax decor","elegant home decor","serene sanctuary candle","classic decor style"]',
    '{"metaTitle":"Soy Wax Pillar Candle - Warm Vanilla Scent & Brass Holder","metaDescription":"Elevate your space with our Soy Wax Pillar Candle. Hand-poured, clean-burning, and long-lasting with a warm vanilla scent. Order now for a cozy ambiance!","altText":"Hand-poured soy wax pillar candle with warm vanilla scent in a vintage brass holder.","keywords":["soy wax candle","pillar candle","vanilla scented candle","home decor candles","elegant candles","classic style candle","brass candle holder","long-lasting candle","clean burning candle","hand-poured candle","smooth finish candle","cylindrical candle","vintage candle style","cozy ambiance candle","living room decor","bedroom candle","bathroom candle","relaxation candle","ivory candle","warm brass holder","matte finish candle","tall candle","soy wax decor","elegant home decor","serene sanctuary candle","classic decor style"]}',
    TRUE,
    TRUE,
    4.9,
    234,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'decor'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Brass Metallic Vase
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'DEC-DECOR-VASE-005',
    'Brass Metallic Vase',
    'Brushed brass metallic vase with organic form. A luxurious accent piece.',
    72,
    95,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'vase' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Brass","Gold"],"material":["Brass"],"style":["Glamorous","Modern"],"room":["Living Room","Dining Room","Office"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Brass","hex":"#B5A642","category":"primary"},{"name":"Gold","hex":"#FFD700","category":"accent"}],"pattern":"solid","texture":"brushed","finish":"brushed","shape":"organic","silhouette":"Curved form with a sleek profile"}',
    '{"short":"Elegant brushed brass vase with a luxurious organic form.","long":"Elevate your interior with the Brass Metallic Vase, a stunning piece that embodies both art and functionality. Its brushed brass finish radiates a warm, golden glow that captures the eye, while the organic silhouette adds a modern touch to any setting. Perfectly sized for showcasing fresh or dried blooms, this vase becomes a centerpiece that seamlessly complements contemporary decor. Whether placed in a living room, dining area, or office, its glamorous presence enriches your space with sophistication and style. Crafted from 100% brass, this vase is not just a decoration but a statement of elegance.","features":["Brushed brass finish","Organic, modern silhouette","Ideal for fresh or dried flowers","Sophisticated accent piece","Enhances contemporary decor","Perfect for living room or office","Warm, golden glow"],"careInstructions":"Wipe with a soft, dry cloth. Avoid using harsh chemicals or abrasives to preserve the finish.","materialComposition":"100% Brass"}',
    '["vase","brass","metallic","gold","luxury","decor","modern","glamorous","accent piece","home decor","elegant","sophisticated","organic shape","flower vase","interior design","living room","dining room","office","gift","stylish","contemporary","artistic","display","centerpiece","unique","high-end","polished","versatile","decorative","brass metallic vase","brushed brass finish","modern decor vase","elegant home decor","luxury vase","organic shape vase","glamorous decor piece","sophisticated vase","interior design vase","living room decor","dining room centerpiece","office decor","contemporary vase","decorative brass vase","stylish home accent","high-end decor","unique vase design","modern vase","artistic vase","polished brass decor","versatile vase","home decor accent","elegant centerpiece","luxurious vase","brass home decor","decorative flower vase","organic form vase","modern home accessory"]',
    '{"metaTitle":"Brass Metallic Vase - Elegant Brushed Finish Decor","metaDescription":"Enhance your decor with the Brass Metallic Vase. Its brushed finish and modern design make it a stunning centerpiece. Shop now for elegance!","altText":"Elegant brass metallic vase with a brushed finish and organic shape, perfect for modern decor.","keywords":["brass metallic vase","brushed brass finish","modern decor vase","elegant home decor","luxury vase","organic shape vase","glamorous decor piece","sophisticated vase","interior design vase","flower vase","living room decor","dining room centerpiece","office decor","contemporary vase","decorative brass vase","stylish home accent","high-end decor","unique vase design","modern vase","artistic vase","polished brass decor","versatile vase","home decor accent","elegant centerpiece","luxurious vase","brass home decor","decorative flower vase","organic form vase","modern home accessory"]}',
    FALSE,
    FALSE,
    4.5,
    67,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'decor'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Concrete Candle Holder Set
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'DEC-DECOR-CANDLE-002',
    'Concrete Candle Holder Set',
    'Set of 3 concrete candle holders in varying sizes. Industrial modern aesthetic.',
    42,
    55,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'candle' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Warm Chestnut Brown"],"material":["Wood"],"style":["Modern","Traditional"],"room":["Living Room","Dining Room","Office"],"occasion":["Entertaining","Everyday"]}',
    '{"primaryColors":[{"name":"Warm Chestnut Brown","hex":"#8B4513","category":"primary"}],"pattern":"solid","texture":"smooth","finish":"polished","shape":"organic","silhouette":"Varied heights with elegant curves"}',
    '{"short":"Stylish concrete candle holder set with sleek, modern design for a chic and minimalist touch.","long":"Transform your space with our Concrete Candle Holder Set, perfect for adding a touch of modern elegance. This set includes three distinct holders, each crafted from high-quality concrete that showcases a smooth, matte finish. The minimalist design, with its clean lines and sturdy construction, brings a chic industrial vibe to any room. Arrange them on your dining table, mantel, or sideboard to create a sophisticated ambiance. Their neutral gray color effortlessly complements any decor style, making them a versatile addition to your home. Whether you''re hosting a dinner party or enjoying a quiet evening, these candle holders will illuminate your space with style and grace.","features":["Set of three concrete candle holders","Smooth, matte finish for a modern look","Sturdy and durable construction","Neutral gray color complements any decor","Perfect for dining tables, mantels, or sideboards","Adds a chic industrial vibe","Ideal for both everyday and special occasions"],"careInstructions":"Wipe with a damp cloth to clean. Avoid using abrasive cleaners. Keep away from direct sunlight to prevent color fading.","materialComposition":"100% high-quality concrete"}',
    '["candle holder","concrete","industrial","set","modern","wooden decor","modern design","traditional style","home accessory","tabletop decor","natural wood","polished finish","set of five","elegant curves","warm chestnut brown","living room","dining room","office","entertaining","everyday use","sophisticated decor","versatile design","home decor","interior styling","decorative set","natural finish","solid wood","smooth texture","organic shapes","stylish accessory","timeless piece","dynamic display","mantel decor","sideboard accessory","concrete candle holder","modern decor","industrial chic","candle holder set","minimalist design","elegant candle holders","gray candle holders","concrete decor","sophisticated ambiance","dining table decor","mantelpiece accessories","sideboard decor","versatile home accessory","modern elegance","chic industrial style","contemporary candle holders","decorative candle holders","stylish candle holders","neutral color decor","home styling","interior decor","sophisticated design","modern home accessory","concrete home decor","matte finish candle holders","elegant home decor","industrial home decor","decorative accessories"]',
    '{"metaTitle":"Concrete Candle Holder Set - Modern Elegance for Your Decor","metaDescription":"Elevate your space with our Concrete Candle Holder Set. Perfect for modern elegance, this versatile set adds sophistication to any decor. Shop now!","altText":"Set of three concrete candle holders with a smooth matte finish and modern design.","keywords":["concrete candle holder","modern decor","industrial chic","home decor","candle holder set","minimalist design","elegant candle holders","gray candle holders","concrete decor","sophisticated ambiance","dining table decor","mantelpiece accessories","sideboard decor","versatile home accessory","modern elegance","chic industrial style","contemporary candle holders","decorative candle holders","stylish candle holders","neutral color decor","home styling","interior decor","sophisticated design","modern home accessory","concrete home decor","decorative set","matte finish candle holders","elegant home decor","industrial home decor","decorative accessories"]}',
    FALSE,
    FALSE,
    4.6,
    98,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'decor'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Glass Jar Candle
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'DEC-DECOR-CANDLE-003',
    'Glass Jar Candle',
    'Amber glass jar candle with cedar and sandalwood fragrance.',
    32,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'candle' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Warm Brass","Ivory"],"material":["Brass"],"style":["Modern","Vintage"],"room":["Living Room","Dining Room","Bedroom"],"occasion":["Entertaining","Special Occasions"]}',
    '{"primaryColors":[{"name":"Warm Brass","hex":"#B8860B","category":"primary"},{"name":"Ivory","hex":"#FFFFF0","category":"accent"}],"pattern":"solid","texture":"smooth","finish":"polished","shape":"organic","silhouette":"Tall and slender with spherical bases"}',
    '{"short":"Transform your space with our aromatic Glass Jar Candle, blending style and serenity for $32.","long":"Elevate your home ambiance with our exquisite Glass Jar Candle, an essential decor piece that combines elegance with tranquility. Encased in a sleek, transparent glass jar, this candle adds a touch of sophistication to any room while offering a warm, inviting glow. As the flame flickers, it releases a soothing aroma that dances through the air, creating a peaceful retreat right in your living space. Priced at $32, it''s a perfect addition to your decor collection, ideal for calming evenings or setting the mood for special occasions. Its minimalist design seamlessly blends with various decor styles, ensuring it complements any aesthetic from modern to rustic.","features":["Elegant transparent glass jar","Soothing aromatic experience","Warm, inviting glow","Blends with modern and rustic decor","Ideal for relaxation and special occasions","Perfect size for various spaces","Long-lasting burn time"],"careInstructions":"Trim wick to 1/4 inch before each use. Allow wax to pool evenly for the first burn. Store in a cool, dry place away from direct sunlight.","materialComposition":"High-quality paraffin wax, cotton wick, and a durable glass jar."}',
    '["candle","glass jar","amber","cedar","sandalwood","candle holder","brass","spherical design","tapered candles","elegant decor","ambient lighting","modern style","vintage style","home decor","tabletop display","decorative","functional","stable base","smooth finish","polished brass","living room","dining room","bedroom","special occasions","entertaining","ambient light","stylish","sophisticated","unique design","warm brass","ivory candles","set of candle holders","decor accent","home accessory","interior design","decorative lighting","classic look","timeless piece","artistic","luxury decor","gift idea","centerpiece","table decoration","holiday decor","festive","glass jar candle","home decor candle","elegant candle","soothing aroma candle","decorative candle","modern candle decor","rustic candle style","sophisticated candle","ambient lighting candle","tranquil candle","home ambiance candle","decor piece candle","minimalist design candle","candle for special occasions","warm glow candle","peaceful retreat candle","elevate home decor","luxury candle","candle for calming evenings","room decor candle","glass encased candle","aromatic candle","candle for modern decor","candle with inviting glow","decorative lighting candle","candle for rustic decor","scented candle","candle with warm brass accents","candle with ivory highlights","candle for living room"]',
    '{"metaTitle":"Glass Jar Candle - Elegant Decor with Soothing Aroma","metaDescription":"Enhance your home ambiance with our Glass Jar Candle. Its elegant design and soothing aroma make it a must-have for tranquil evenings. Buy now for $32!","altText":"Glass Jar Candle in a sleek transparent jar, offering a warm glow and soothing aroma.","keywords":["glass jar candle","home decor candle","elegant candle","soothing aroma candle","decorative candle","modern candle decor","rustic candle style","sophisticated candle","ambient lighting candle","tranquil candle","home ambiance candle","decor piece candle","minimalist design candle","candle for special occasions","warm glow candle","peaceful retreat candle","elevate home decor","luxury candle","candle for calming evenings","room decor candle","glass encased candle","aromatic candle","candle for modern decor","candle with inviting glow","decorative lighting candle","candle for rustic decor","scented candle","candle with warm brass accents","candle with ivory highlights","candle for living room"]}',
    FALSE,
    TRUE,
    4.8,
    187,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'decor'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Brass Candle Stick Pair
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'DEC-DECOR-CANDLE-004',
    'Brass Candle Stick Pair',
    'Elegant brass candlestick holders in a tapered design. Sold as a pair.',
    58,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'candle' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Jet Black"],"material":["Metal"],"style":["Modern","Contemporary"],"room":["Dining Room","Living Room","Bedroom"],"occasion":["Entertaining","Romantic Dinner"]}',
    '{"primaryColors":[{"name":"Jet Black","hex":"#343434","category":"primary"}],"pattern":"fluted","texture":"textured","finish":"matte","shape":"organic","silhouette":"tapered with fluted details"}',
    '{"short":"Timeless brass candle sticks add elegance and warmth to any space, perfect for creating a sophisticated ambiance.","long":"Elevate your home with the Brass Candle Stick Pair, a stunning duo that effortlessly combines classic elegance with modern charm. Each candlestick is exquisitely crafted from premium brass, offering a warm, golden glow that enhances any decor style. Standing tall and graceful, these candle holders are perfect for dining tables, mantels, or as statement pieces on a sideboard. Their sleek silhouette and lustrous finish catch the light beautifully, creating an inviting and cozy atmosphere. Whether hosting a dinner party or enjoying a quiet evening, these candle sticks add a touch of sophistication and warmth to your space.","features":["Crafted from premium brass","Sleek and timeless design","Perfect for dining tables or mantels","Adds a warm, golden glow","Enhances any decor style","Sold as a pair"],"careInstructions":"Gently wipe with a soft, dry cloth. Avoid using abrasive cleaners to maintain the brass finish.","materialComposition":"100% Brass"}',
    '["candlestick","brass","pair","elegant","traditional","candle holder","black","fluted","modern","contemporary","decor","sophisticated","pillar candle","home decor","ambient lighting","table centerpiece","mantel display","metal","textured","matte finish","tapered design","brass candle stick pair","elegant candle holders","fluted design decor","modern candle holders","contemporary decor","home decor candle holders","sophisticated candle sticks","brass decor items","dining table candle holders","mantel candle display","pillar candle holders","ambient lighting decor","metal candle holders","decorative candle sticks","black finish candle holders","modern home accessories","contemporary candle decor","elegant home accents","fluted candle holders","matte finish decor","tapered silhouette candle holders","decorative brass items","stylish candle holders","luxury home decor","statement candle holders","classic candle holder design","warm ambiance decor","sophisticated home lighting","dining room candle decor","living room candle accents"]',
    '{"metaTitle":"Brass Candle Stick Pair - Elegant Fluted Design Decor","metaDescription":"Enhance your decor with our Brass Candle Stick Pair. Crafted from premium brass, these elegant holders add warmth and sophistication. Shop now!","altText":"Elegant brass candle stick pair with fluted design, perfect for sophisticated decor.","keywords":["brass candle stick pair","elegant candle holders","fluted design decor","modern candle holders","contemporary decor","home decor candle holders","sophisticated candle sticks","brass decor items","dining table candle holders","mantel candle display","pillar candle holders","ambient lighting decor","metal candle holders","decorative candle sticks","black finish candle holders","modern home accessories","contemporary candle decor","elegant home accents","fluted candle holders","matte finish decor","tapered silhouette candle holders","decorative brass items","stylish candle holders","luxury home decor","statement candle holders","classic candle holder design","warm ambiance decor","sophisticated home lighting","dining room candle decor","living room candle accents"]}',
    TRUE,
    FALSE,
    4.7,
    89,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'decor'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Marble Bookends
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'DEC-DECOR-OBJECT-001',
    'Marble Bookends',
    'Pair of white marble bookends with geometric design. Heavy and sturdy.',
    85,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'decorative-object' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Warm Chestnut Brown"],"material":["Solid Wood"],"style":["Modern","Rustic"],"room":["Dining Room","Kitchen","Living Room"],"occasion":["Entertaining","Everyday"]}',
    '{"primaryColors":[{"name":"Warm Chestnut Brown","hex":"#8B4513","category":"primary"}],"pattern":"solid","texture":"natural","finish":"natural","shape":"organic","silhouette":"Tall and wavy with a sculptural form"}',
    '{"short":"Sophisticated marble bookends for elegant book display and organization.","long":"Elevate your bookshelf with our exquisite Marble Bookends, a perfect blend of elegance and functionality. Each piece is crafted from premium quality marble, showcasing natural veining that adds an artistic touch to your décor. These bookends not only provide stable support for your books but also serve as a stunning focal point on any shelf or mantle. The smooth, cool texture of the marble exudes luxury, making them a perfect addition to both modern and classic interiors. Whether you''re organizing your literary collection or displaying art books, these bookends will enhance the aesthetic appeal of your space. Priced at $85, they offer both style and substance, making them an ideal gift for book lovers or a sophisticated accent for your own home.","features":["Crafted from premium quality marble","Natural veining for a unique appearance","Heavy and stable for secure book support","Elegant design suitable for any décor style","Perfect for organizing books or displaying art","Enhances aesthetic appeal of shelves and mantles"],"careInstructions":"Wipe with a soft, damp cloth; avoid harsh cleaners. Use coasters to prevent staining.","materialComposition":"100% natural marble"}',
    '["bookends","marble","geometric","white","modern","wine holder","wooden decor","wavy design","bottle storage","modern style","rustic charm","home bar","kitchen accessory","entertaining","functional decor","artistic piece","solid wood","natural finish","unique design","sculptural form","warm tones","elegant storage","stylish display","home accessory","decorative object","gift idea","handcrafted","quality craftsmanship","interior decor","space-saving","compact design","versatile use","eye-catching","conversation starter","home improvement","luxury decor","premium material","designer piece","statement decor","artistic touch","modern rustic","wood grain","natural beauty","warm chestnut brown","marble bookends","elegant bookends","decorative bookends","premium marble","natural veining","bookshelf decor","home accessories","artistic bookends","modern interiors","classic interiors","stylish bookends","book support","sophisticated decor","gift for book lovers","home decor","interior design","elegant home accents","shelf decor","mantle decor","book organization","decorative accents","marble decor","luxury home goods","modern home decor","classic home decor","artistic home accents","premium home decor","stylish home accessories"]',
    '{"metaTitle":"Elegant Marble Bookends - Luxury Decor with Natural Veining","metaDescription":"Enhance your bookshelf with our luxurious Marble Bookends. Crafted from premium marble, they add elegance and stability. Order now for a stylish touch!","altText":"Elegant marble bookends with natural veining, providing stylish support for books.","keywords":["marble bookends","luxury decor","elegant bookends","decorative bookends","premium marble","natural veining","bookshelf decor","home accessories","artistic bookends","modern interiors","classic interiors","stylish bookends","book support","sophisticated decor","gift for book lovers","home decor","interior design","elegant home accents","shelf decor","mantle decor","book organization","decorative accents","marble decor","luxury home goods","modern home decor","classic home decor","artistic home accents","premium home decor","functional decor","stylish home accessories"]}',
    TRUE,
    FALSE,
    4.8,
    112,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'decor'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Wooden Sculptural Object
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'DEC-DECOR-OBJECT-002',
    'Wooden Sculptural Object',
    'Hand-carved wooden abstract sculpture. Each piece is unique.',
    125,
    165,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'decorative-object' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Warm Chestnut Brown"],"material":["Wood"],"style":["Artistic","Bohemian"],"room":["Living Room","Office","Entryway"],"occasion":["Everyday","Artistic Display"]}',
    '{"primaryColors":[{"name":"Warm Chestnut Brown","hex":"#8B4513","category":"primary"}],"pattern":"solid","texture":"smooth","finish":"matte","shape":"organic","silhouette":"Abstract form with flowing lines"}',
    '{"short":"Elegant hand-carved wooden sculpture with an abstract design, perfect for any decor.","long":"Introducing the Wooden Sculptural Object, an exquisite hand-carved masterpiece that embodies abstract artistry. Bathed in a rich, warm chestnut brown hue, this sculpture exudes a natural elegance with its smooth finish and organic shape. Designed to be a conversation starter, it seamlessly complements bohemian or modern decor themes, making it a versatile addition to your living room, office, or entryway. Each piece is unique, reflecting the artisanal craftsmanship that goes into its creation. Elevate your space with this artistic object that stands as both a decorative accent and a testament to fine design.","features":["Hand-carved abstract design","Warm chestnut brown color","Smooth, matte finish","Unique, individual piece","Perfect for bohemian or modern decor","Ideal for living rooms, offices, or entryways"],"careInstructions":"Dust regularly with a soft cloth. Avoid direct sunlight and moisture to preserve its natural beauty.","materialComposition":"100% solid wood"}',
    '["sculpture","wood","hand-carved","abstract","artistic","decor","unique","bohemian","modern","living room","office","entryway","conversation starter","organic shape","smooth finish","warm chestnut brown","solid wood","artistic display","elegant","stylish","home decor","interior design","handmade","craftsmanship","natural material","decorative object","gift idea","minimalist","statement piece","design element","creative","versatile","accent piece","modern art","boho chic","unique piece","artisan","wooden sculpture","hand-carved decor","abstract artistry","bohemian decor","modern decor","living room art","office decor","entryway sculpture","elegant home decor","stylish interior design","handmade craftsmanship","minimalist art","creative decor","versatile accent","artisan sculpture"]',
    '{"metaTitle":"Wooden Sculptural Object - Hand-Carved Abstract Decor","metaDescription":"Discover the Wooden Sculptural Object, a hand-carved masterpiece perfect for bohemian or modern decor. Elevate your space today with this unique art piece!","altText":"Elegant hand-carved wooden sculpture with abstract design, warm chestnut brown color.","keywords":["wooden sculpture","hand-carved decor","abstract artistry","bohemian decor","modern decor","living room art","office decor","entryway sculpture","conversation starter","organic shape","smooth finish","warm chestnut brown","solid wood","artistic display","elegant home decor","stylish interior design","handmade craftsmanship","natural material","decorative object","gift idea","minimalist art","statement piece","design element","creative decor","versatile accent","modern art","boho chic","unique piece","artisan sculpture"]}',
    FALSE,
    FALSE,
    4.6,
    45,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'decor'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Ceramic Geometric Object
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'DEC-DECOR-OBJECT-004',
    'Ceramic Geometric Object',
    'Contemporary geometric ceramic sculpture in matte white. A modern accent for minimalist spaces.',
    65,
    85,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'decorative-object' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Speckled Beige","Matte Black"],"material":["Ceramic"],"style":["Modern","Minimalist"],"room":["Living Room","Office","Entryway"],"occasion":["Everyday","Decorative"]}',
    '{"primaryColors":[{"name":"Speckled Beige","hex":"#D3B8A6","category":"primary"},{"name":"Matte Black","hex":"#2D2D2D","category":"accent"}],"pattern":"solid","texture":"smooth","finish":"matte","shape":"organic","silhouette":"Varied geometric forms with clean lines"}',
    '{"short":"Elegant ceramic sculptures in geometric forms, perfect for modern spaces.","long":"Introducing the Ceramic Geometric Object set, an exquisite collection of four unique sculptures that embody modern elegance. Crafted in speckled beige ceramic, each piece showcases distinct geometric shapes adorned with matte black accents, offering a sophisticated touch to any decor. These objects are perfect for minimalist and contemporary interiors, enhancing spaces like living rooms, offices, or entryways with their striking presence. Their smooth texture and matte finish create a refined aesthetic, making them versatile decor elements that seamlessly integrate into various settings.","features":["Set of four geometric sculptures","Crafted from speckled beige ceramic","Elegant matte black accents","Modern and minimalist design","Ideal for living rooms, offices, and entryways","Smooth texture and sophisticated matte finish","Versatile decorative elements"],"careInstructions":"Dust gently with a soft cloth. Avoid using harsh cleaners to preserve the matte finish.","materialComposition":"Primarily ceramic with matte black accents"}',
    '["geometric","ceramic","sculpture","modern","white","minimalist","decor","beige","black","accent","home decor","interior design","art","contemporary","elegant","unique","stylish","decorative objects","living room","office","entryway","set","smooth texture","matte finish","organic shapes","clean lines","modern accents","ceramic geometric object","modern decor","minimalist sculptures","ceramic decor","home accents","geometric shapes","speckled beige ceramic","matte black accents","living room decor","office decor","entryway decor","modern elegance","contemporary art","unique sculptures","elegant home decor","stylish decor pieces","ceramic art","home decoration","decor set","chic home accents","sophisticated decor"]',
    '{"metaTitle":"Ceramic Geometric Object Set - Modern Elegance Decor","metaDescription":"Discover the Ceramic Geometric Object set, perfect for modern interiors. Enhance your space with these elegant sculptures. Shop now for a chic touch!","altText":"Set of four ceramic geometric sculptures with matte black accents.","keywords":["ceramic geometric object","modern decor","minimalist sculptures","ceramic decor","home accents","geometric shapes","matte finish","speckled beige ceramic","matte black accents","interior design","decorative objects","living room decor","office decor","entryway decor","modern elegance","contemporary art","unique sculptures","elegant home decor","stylish decor pieces","ceramic art","home decoration","modern accents","smooth texture","organic shapes","clean lines","decor set","chic home accents","sophisticated decor"]}',
    TRUE,
    FALSE,
    4.7,
    67,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'decor'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Brass Chain Link Decor
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'DEC-DECOR-OBJECT-005',
    'Brass Chain Link Decor',
    'Decorative brass chain link sculpture. Modern coffee table accent.',
    78,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'decorative-object' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Warm Chestnut Brown"],"material":["Solid Wood"],"style":["Modern","Minimalist"],"room":["Living Room","Office"],"occasion":["Everyday","Decorative"]}',
    '{"primaryColors":[{"name":"Warm Chestnut Brown","hex":"#8B4513","category":"primary"}],"pattern":"natural","texture":"textured","finish":"natural","shape":"organic","silhouette":"Tall and stacked with irregular shapes"}',
    '{"short":"Elegant brass chain link decor for a touch of sophistication.","long":"Elevate your interior with our Brass Chain Link Decor, a stunning blend of elegance and modernity. This exquisite piece features a series of interlocking brass links, each with a polished finish that catches the light beautifully. Perfect for adding a sophisticated accent to your living room, office, or hallway, the Brass Chain Link Decor can be styled in various ways—draped over a stack of books, displayed on a mantel, or used as a centerpiece. Its metallic sheen and intricate design create a striking visual impact, inviting conversation and admiration. Whether your decor is contemporary or eclectic, this piece infuses a touch of luxury and finesse into any space.","features":["Interlocking brass links","Polished metallic finish","Versatile styling options","Sleek and modern aesthetic","Adds a touch of luxury"],"careInstructions":"Wipe with a soft, dry cloth. Avoid harsh chemicals. Keep away from moisture to maintain its shine.","materialComposition":"100% brass with a polished finish"}',
    '["chain link","brass","sculpture","modern","gold","wooden sculpture","modern decor","natural art","stacked blocks","minimalist design","organic form","living room accent","office decor","natural texture","warm tones","solid wood","artistic piece","unique grain patterns","elegant sculpture","decorative object","natural finish","contemporary style","interior design","home accent","sculptural art","wood grain","modern sculpture","artistic decor","natural elegance","minimalist sculpture","wooden blocks","decorative sculpture","home decor","office accent","modern art","natural sculpture","stacked design","warm chestnut brown","organic silhouette","Brass decor","Chain link decor","Elegant home accents","Modern interior design","Luxury home decor","Sophisticated decor","Brass home accessories","Living room decor","Office decor","Hallway decor","Contemporary style","Eclectic design","Polished brass finish","Decorative centerpiece","Decor styling ideas","Home accent pieces","Metallic sheen decor","Interior design trends","Luxury decor items","Home styling tips","Decorative brass links","Modern decor elements","Artistic home decor","Brass link sculpture","Stylish decor accents","Elegant brass decor"]',
    '{"metaTitle":"Brass Chain Link Decor - Elegant Modern Accent Piece","metaDescription":"Enhance your space with our Brass Chain Link Decor. A sophisticated accent for any room, perfect for modern or eclectic styles. Shop now for luxury decor!","altText":"Brass Chain Link Decor featuring interlocking polished brass links for elegant interior styling.","keywords":["Brass decor","Chain link decor","Elegant home accents","Modern interior design","Luxury home decor","Sophisticated decor","Brass home accessories","Living room decor","Office decor","Hallway decor","Contemporary style","Eclectic design","Polished brass finish","Decorative centerpiece","Decor styling ideas","Home accent pieces","Metallic sheen decor","Interior design trends","Luxury decor items","Home styling tips","Decorative brass links","Modern decor elements","Artistic home decor","Brass link sculpture","Stylish decor accents","Elegant brass decor"]}',
    FALSE,
    FALSE,
    4.4,
    34,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'decor'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Stone Sphere Trio
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'DEC-DECOR-OBJECT-006',
    'Stone Sphere Trio',
    'Set of 3 natural stone spheres in varying sizes. Organic textures and tones.',
    92,
    120,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'decorative-object' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Muted Olive Green","Charcoal Black","Warm Earth Brown"],"material":["Resin"],"style":["Eclectic","Traditional"],"room":["Living Room","Entryway","Office"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Muted Olive Green","hex":"#6B8E23","category":"primary"},{"name":"Charcoal Black","hex":"#36454F","category":"accent"},{"name":"Warm Earth Brown","hex":"#8B4513","category":"secondary"}],"pattern":"solid","texture":"textured","finish":"matte","shape":"organic","silhouette":"Tall, slender figures with dynamic poses"}',
    '{"short":"Sophisticated trio of stone spheres adds timeless elegance to any space.","long":"Introduce a touch of sophistication and timeless elegance to your home with the Stone Sphere Trio. This captivating set features three meticulously crafted spheres, each varying in size, offering a harmonious balance that enhances any decor style. The natural stone texture evokes a sense of calm and grounding, while the varying shades of gray and beige complement a wide array of interior palettes. Perfect for display on mantels, shelves, or as a centerpiece, these spheres create an inviting atmosphere with their understated beauty. Whether placed in a minimalist setting or among eclectic pieces, the Stone Sphere Trio is a versatile decor solution that brings depth and character to your living space.","features":["Set of three stone spheres","Varying sizes for dynamic display","Natural stone texture for a calming effect","Complementary shades of gray and beige","Ideal for mantels, shelves, or centerpieces","Versatile for minimalist or eclectic styles","Enhances depth and character in spaces"],"careInstructions":"Wipe with a damp cloth to remove dust. Avoid harsh chemicals to preserve natural stone finish.","materialComposition":"Crafted from high-quality natural stone"}',
    '["stone","sphere","set","natural","organic","musician sculptures","rustic decor","artistic expression","home decor","tabletop display","cultural sophistication","hand-painted","resin figures","unique poses","musical instruments","eclectic style","traditional decor","muted tones","earthy colors","textured finish","matte surface","decorative objects","living room decor","entryway decor","office decor","creative home accents","artistic sculptures","set of sculptures","tall figures","slender silhouette","dynamic poses","elegant decor","harmonious design","cultural decor","expressive art","musical theme","sculpture set","Stone Sphere Trio","natural stone spheres","decorative spheres","sophisticated decor","timeless elegance","interior design","mantel decoration","centerpiece ideas","harmonious balance","minimalist decor","gray and beige decor","sophisticated home accents","decor set","shelf decoration","calm and grounding decor","versatile decor solution","decorative centerpiece","interior palettes","understated beauty","home accents","decorative spheres set","timeless home decor","elegant home accessories","stone texture decor","decorative home accents"]',
    '{"metaTitle":"Stone Sphere Trio - Elegant Natural Stone Decor Set","metaDescription":"Elevate your home decor with the Stone Sphere Trio. This elegant set adds sophistication to any space. Perfect for mantels or centerpieces. Shop now!","altText":"Three stone spheres of varying sizes with natural textures and shades of gray and beige.","keywords":["Stone Sphere Trio","elegant decor","natural stone spheres","home decor","decorative spheres","sophisticated decor","timeless elegance","interior design","mantel decoration","centerpiece ideas","harmonious balance","minimalist decor","eclectic style","gray and beige decor","sophisticated home accents","decor set","living room decor","shelf decoration","decorative objects","calm and grounding decor","versatile decor solution","decorative centerpiece","interior palettes","understated beauty","home accents","decorative spheres set","timeless home decor","elegant home accessories","stone texture decor","decorative home accents"]}',
    FALSE,
    FALSE,
    4.6,
    78,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'decor'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Velvet Throw Pillow
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'DEC-DECOR-PILLOW-001',
    'Velvet Throw Pillow',
    'Luxurious velvet throw pillow in deep emerald green. Down-alternative fill.',
    48,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'throw-pillow' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Warm Beige"],"material":["Cotton","Linen"],"style":["Modern","Minimalist"],"room":["Living Room","Bedroom"],"occasion":["Everyday","Decorative"]}',
    '{"primaryColors":[{"name":"Warm Beige","hex":"#D3B8A3","category":"primary"}],"pattern":"textured","texture":"textured","finish":"matte","shape":"square","silhouette":"Classic square with fringe edges"}',
    '{"short":"Luxurious velvet throw pillow with intricate tufted design for elegance and comfort.","long":"Transform your living space with our Velvet Throw Pillow, a perfect blend of luxury and comfort. The plush velvet fabric offers a soft touch and rich texture, while the intricate tufted design adds a touch of sophistication. Its deep, inviting hue is perfect for creating a cozy atmosphere in any room. Whether adorning your sofa or resting on your bed, this pillow effortlessly complements a variety of decor styles from modern to traditional. Experience the perfect balance of style and comfort with this elegant addition to your home.","features":["Plush velvet fabric for a soft touch","Intricate tufted design for added elegance","Deep, inviting color enhances room ambiance","Versatile style complements various decor themes","Durable construction ensures long-lasting use","Comfortable and supportive for lounging"],"careInstructions":"To maintain the luxurious feel, spot clean only with a damp cloth. Avoid machine washing and direct sunlight to preserve color and texture.","materialComposition":"100% high-quality velvet fabric"}',
    '["pillow","velvet","emerald","green","throw pillow","decorative pillow","beige pillow","fringe pillow","textured pillow","modern decor","minimalist style","living room accessory","bedroom decor","cotton pillow","linen pillow","home decor","accent pillow","neutral color","soft furnishing","comfortable pillow","stylish pillow","elegant pillow","versatile decor","high-quality fabric","spot clean","warm beige","grid pattern","fringe detail","matte finish","square shape","velvet throw pillow","luxury pillow","tufted design","cozy atmosphere"]',
    '{"metaTitle":"Velvet Throw Pillow - Luxury Comfort & Sophisticated Design","metaDescription":"Elevate your decor with our Velvet Throw Pillow. Experience luxury and comfort with its plush fabric and intricate tufted design. Shop now for elegance.","altText":"Warm beige velvet throw pillow with textured grid pattern and fringe detailing, perfect for modern decor.","keywords":["velvet throw pillow","decorative pillow","beige pillow","fringe pillow","textured pillow","modern decor","minimalist style","living room accessory","bedroom decor","cotton pillow","linen pillow","home decor","accent pillow","neutral color","soft furnishing","comfortable pillow","stylish pillow","elegant pillow","versatile decor","high-quality fabric","spot clean","warm beige","grid pattern","fringe detail","matte finish","square shape","luxury pillow","tufted design","cozy atmosphere"]}',
    TRUE,
    TRUE,
    4.8,
    198,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'decor'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Ceramic Decorative Balls
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'DEC-DECOR-OBJECT-003',
    'Ceramic Decorative Balls',
    'Set of 3 textured ceramic decorative balls in neutral tones.',
    38,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'decorative-object' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Beige","Cream","Taupe"],"material":["Ceramic"],"style":["Transitional","Natural"],"room":["Living Room","Bedroom","Dining Room"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Beige","hex":"#F5F5DC","category":"primary"},{"name":"Cream","hex":"#FFFDD0","category":"secondary"},{"name":"Taupe","hex":"#483C32","category":"accent"}],"pattern":"solid","texture":"textured","finish":"matte","shape":"round","silhouette":"Simple spherical form with textured surface"}',
    '{"short":"Elegant ceramic decorative balls in neutral tones, perfect for elevating your decor with subtle sophistication.","long":"Transform your space with our exquisite set of Ceramic Decorative Balls, designed to infuse any room with understated elegance. These spherical beauties feature a textured ceramic surface that adds a tactile dimension to your decor. Their harmonious blend of neutral tones—soft beige, creamy white, and warm taupe—ensures they seamlessly integrate into various design styles, whether modern, traditional, or transitional. Ideal for adorning coffee tables, shelves, or mantels, these decorative balls are perfect accent pieces that enhance your home’s ambiance. Let their simple yet sophisticated charm bring a touch of refinement to your living room, bedroom, or dining area.","features":["Set of 3 ceramic decorative balls","Elegant textured finish","Neutral hues: beige, cream, taupe","Blends with modern and traditional decor","Ideal for tabletop or shelf enhancements","Versatile decorative accents","Adds tactile and visual interest"],"careInstructions":"To maintain their beauty, gently wipe with a damp cloth. Avoid using abrasive cleaners or scrubbing to preserve the textured finish.","materialComposition":"Crafted entirely from durable ceramic"}',
    '["decorative balls","ceramic","set","neutral","textured","home decor","living room","bedroom","dining room","modern","traditional","elegant","spherical","matte finish","transitional style","natural style","versatile","tabletop decor","shelf display","beige","cream","taupe","ceramic decor","decorative objects","home accessories","interior design","accent pieces","minimalist","neutral decor","textured ceramic","simple elegance","tactile appeal","ceramic decorative balls","elegant decor","textured ceramic balls","neutral home accents","spherical decor","living room accents","bedroom decor","dining room decor","modern decor","traditional decor","neutral tones","beige decor","cream decor","taupe decor","minimalist decor","matte finish decor","versatile decor"]',
    '{"metaTitle":"Ceramic Decorative Balls - Elegant Textured Home Decor","metaDescription":"Elevate your space with our Ceramic Decorative Balls. Perfect for any decor style, these textured spheres add elegance to your home. Shop now for a refined touch!","altText":"Set of ceramic decorative balls in neutral tones with a textured finish.","keywords":["ceramic decorative balls","home decor","elegant decor","textured ceramic balls","neutral home accents","ceramic decor","spherical decor","living room accents","bedroom decor","dining room decor","modern decor","traditional decor","transitional style","neutral tones","beige decor","cream decor","taupe decor","tabletop decor","shelf display","interior design","home accessories","minimalist decor","accent pieces","matte finish decor","simple elegance","tactile appeal","versatile decor","decorative objects","natural style"]}',
    FALSE,
    TRUE,
    4.5,
    156,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'decor'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Linen Lumbar Pillow
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'DEC-DECOR-PILLOW-002',
    'Linen Lumbar Pillow',
    'Natural linen lumbar pillow with frayed edges. Relaxed, organic style.',
    38,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'throw-pillow' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Warm Beige"],"material":["Linen"],"style":["Bohemian","Natural"],"room":["Living Room","Bedroom"],"occasion":["Everyday","Relaxation"]}',
    '{"primaryColors":[{"name":"Warm Beige","hex":"#D3B8A6","category":"primary"}],"pattern":"solid","texture":"textured","finish":"natural","shape":"rectangular","silhouette":"Low-profile with clean lines"}',
    '{"short":"Elegant linen lumbar pillow with frayed edges, perfect for a relaxed, organic style.","long":"Transform your living space with the Linen Lumbar Pillow, an epitome of natural elegance and bohemian charm. Crafted from premium linen, this pillow features stylish frayed edges that evoke a sense of relaxed sophistication. Its soft, textured surface invites you to sink into comfort while providing excellent lumbar support. The pillow''s warm beige hue effortlessly blends with a variety of color schemes, enhancing the aesthetic of any room. Whether placed on a sofa or a bed, it''s a versatile accessory that adds both function and flair to your decor. Embrace the harmony of organic design and contemporary style with this exquisite pillow.","features":["Frayed edges for a relaxed look","Natural linen material","Lumbar shape for support","Earthy beige color","Versatile for various decor styles","Soft, textured surface","Enhances bohemian and natural aesthetics"],"careInstructions":"Spot clean with mild detergent and water. Air dry to maintain texture.","materialComposition":"100% Linen"}',
    '["pillow","linen","lumbar","natural","organic","linen pillow","lumbar support","bohemian decor","natural style","beige pillow","textured linen","frayed edges","decorative pillow","living room accessory","bedroom decor","neutral tones","organic design","soft texture","versatile pillow","earthy tones","comfortable pillow","stylish pillow","home decor","throw pillow","couch accessory","bed accessory","relaxation pillow","support pillow","decor piece","natural fabric","eco-friendly decor","simple elegance","casual style","modern bohemian","textured design","neutral decor"]',
    '{"metaTitle":"Linen Lumbar Pillow - Bohemian Charm & Natural Elegance","metaDescription":"Enhance your decor with the Linen Lumbar Pillow. Enjoy bohemian charm and natural elegance. Shop now for comfort and style!","altText":"Linen lumbar pillow with frayed edges in warm beige for bohemian decor.","keywords":["linen pillow","lumbar support","bohemian decor","natural style","beige pillow","textured linen","frayed edges","decorative pillow","living room accessory","bedroom decor","neutral tones","organic design","soft texture","versatile pillow","earthy tones","comfortable pillow","stylish pillow","home decor","throw pillow","couch accessory","bed accessory","relaxation pillow","support pillow","decor piece","natural fabric","eco-friendly decor","simple elegance","casual style","modern bohemian","textured design","neutral decor"]}',
    FALSE,
    FALSE,
    4.6,
    112,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'decor'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Textured Cotton Pillow
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'DEC-DECOR-PILLOW-003',
    'Textured Cotton Pillow',
    'Woven cotton pillow with geometric texture pattern. Adds visual interest without overwhelming.',
    42,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'throw-pillow' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Ivory","Cream"],"material":["Cotton"],"style":["Modern","Transitional"],"room":["Living Room","Bedroom"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Ivory","hex":"#FFFFF0","category":"primary"},{"name":"Cream","hex":"#FFFDD0","category":"secondary"}],"pattern":"geometric","texture":"textured","finish":"matte","shape":"rectangular","silhouette":"Low-profile with clean lines"}',
    '{"short":"Luxurious textured cotton pillow with a geometric pattern.","long":"Elevate your home decor with the Textured Cotton Pillow, a perfect blend of luxury and comfort. Its plush, geometric design is crafted to add depth and sophistication to any room, whether it''s your living room or bedroom. The pillow''s soft, woven texture invites touch, providing an exquisite tactile experience. Subtle ivory and cream tones effortlessly harmonize with any color palette, enhancing visual interest without overwhelming your space. Ideal for modern and transitional styles, this versatile pillow is a must-have for those seeking elegance and comfort in their home decor.","features":["Geometric texture pattern","Soft woven cotton material","Neutral ivory and cream colors","Suitable for modern and transitional styles","Enhances visual interest without overwhelming","Versatile addition to various decor palettes","Low-profile with clean lines"],"careInstructions":"Spot clean with mild detergent and water. Air dry flat.","materialComposition":"100% Cotton"}',
    '["pillow","cotton","textured","woven","geometric","ivory","cream","modern","transitional","decor","home","living room","bedroom","comfortable","stylish","neutral","versatile","soft","plush","luxurious","accent","throw pillow","cushion","interior design","home decor","fashionable","elegant","sophisticated","minimalist","contemporary","classic","decorative","comfy","cozy","designer","quality","durable","easy care","spot clean","textured cotton pillow","geometric pillow","luxurious pillow","home decor pillow","modern pillow","transitional pillow","ivory pillow","cream pillow","plush pillow","woven pillow","soft cotton pillow","decorative pillow","elegant pillow","stylish pillow","neutral pillow","versatile pillow","accent pillow","living room pillow","bedroom pillow","cozy pillow","comfy pillow","designer pillow","quality pillow","durable pillow","easy care pillow","spot clean pillow","interior design pillow","sophisticated pillow"]',
    '{"metaTitle":"Textured Cotton Pillow - Luxurious Geometric Design","metaDescription":"Transform your decor with the Textured Cotton Pillow. Experience luxury and comfort with its plush geometric design. Shop now for elegance and style.","altText":"Luxurious textured cotton pillow with geometric pattern in ivory and cream tones.","keywords":["textured cotton pillow","geometric pillow","luxurious pillow","home decor pillow","modern pillow","transitional pillow","ivory pillow","cream pillow","plush pillow","woven pillow","soft cotton pillow","decorative pillow","elegant pillow","stylish pillow","neutral pillow","versatile pillow","accent pillow","throw pillow","living room pillow","bedroom pillow","cozy pillow","comfy pillow","designer pillow","quality pillow","durable pillow","easy care pillow","spot clean pillow","interior design pillow","sophisticated pillow"]}',
    FALSE,
    TRUE,
    4.5,
    145,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'decor'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Bouclé Accent Pillow
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'DEC-DECOR-PILLOW-004',
    'Bouclé Accent Pillow',
    'Cozy bouclé texture pillow in warm cream. Perfect for layering.',
    52,
    68,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'throw-pillow' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Warm Cream","Black"],"material":["Bouclé","Polyester"],"style":["Modern","Cozy"],"room":["Living Room","Bedroom"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Warm Cream","hex":"#F5F5DC","category":"primary"},{"name":"Black","hex":"#000000","category":"accent"}],"pattern":"solid","texture":"textured","finish":"natural","shape":"square","silhouette":"Classic square with contrasting trim"}',
    '{"short":"Elegant bouclé accent pillow with contrasting trim for a modern touch.","long":"Transform your space with the Bouclé Accent Pillow, a luxurious addition that blends comfort and style effortlessly. Its cozy bouclé texture in warm cream creates a welcoming aura, while the sleek black trim adds a modern flair. Perfect for layering on sofas or beds, this pillow is not only a visual delight but also a comfort haven. Its soft fabric invites relaxation, making it an ideal companion for a cozy evening. Whether placed in a living room or bedroom, it enhances decor aesthetics, offering a sophisticated yet inviting atmosphere.","features":["Luxurious bouclé texture","Warm cream color","Striking black trim","Modern design aesthetic","Ideal for layering","Enhances decor aesthetics","Invites relaxation"],"careInstructions":"Spot clean with mild detergent. Avoid direct sunlight to maintain color vibrancy.","materialComposition":"Bouclé fabric with polyester filling"}',
    '["pillow","boucle","textured","cream","cozy","bouclé pillow","accent pillow","cream pillow","modern decor","textured pillow","cozy pillow","living room decor","bedroom decor","home accessories","interior design","stylish pillow","soft fabric","decorative pillow","layering pillow","black trim","square pillow","comfortable pillow","elegant design","neutral color","contrast trim","bouclé texture","polyester filling","spot clean","warm cream","black accent","home decor","decor pillow","throw pillow","pillow with trim","soft texture","cozy ambiance","modern style"]',
    '{"metaTitle":"Bouclé Accent Pillow - Cozy Texture & Modern Flair","metaDescription":"Enhance your decor with the Bouclé Accent Pillow. Its warm cream bouclé texture and sleek black trim offer comfort and style. Shop now for a cozy ambiance!","altText":"Elegant bouclé accent pillow in warm cream with black trim, perfect for modern decor.","keywords":["bouclé pillow","accent pillow","cream pillow","modern decor","textured pillow","cozy pillow","living room decor","bedroom decor","home accessories","interior design","stylish pillow","soft fabric","decorative pillow","layering pillow","black trim","square pillow","comfortable pillow","elegant design","neutral color","contrast trim","bouclé texture","polyester filling","spot clean","warm cream","black accent","home decor","decor pillow","throw pillow","pillow with trim","soft texture","cozy ambiance","modern style"]}',
    TRUE,
    FALSE,
    4.7,
    89,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'decor'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- ----------------------------------------------------------------------------
-- Art & Mirrors (19 products)
-- ----------------------------------------------------------------------------

-- Product: Round Sunburst Mirror
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'ART-ART-MIRROR-001',
    'Round Sunburst Mirror',
    'Stunning sunburst mirror with gold metal rays. A statement piece for any wall.',
    285,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'mirror' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Vibrant Green"],"material":["Glass","Fabric"],"style":["Modern","Contemporary"],"room":["Living Room","Bedroom","Entryway"],"occasion":["Everyday","Statement Piece"]}',
    '{"primaryColors":[{"name":"Vibrant Green","hex":"#6E8B3D","category":"primary"}],"pattern":"solid","texture":"smooth","finish":"matte","shape":"organic","silhouette":"Organic shape with smooth curves"}',
    '{"short":"Radiate elegance with the Round Sunburst Mirror, featuring a captivating design and luxurious finish.","long":"Transform your space with the exquisite Round Sunburst Mirror, priced at $285, which effortlessly combines artistry and functionality. This stunning piece showcases a dazzling sunburst design, emanating from a central, perfectly round mirror. The intricate frame, crafted with meticulous attention to detail, creates a sense of movement and light, making it an ideal focal point for any room. Whether placed in a living room, bedroom, or entryway, its radiant charm will elevate your decor, reflecting natural light to brighten and expand your space. This mirror is more than just a decorative element; it''s a statement of luxury and style.","features":["Striking sunburst design","Luxurious and intricate frame","Perfect for living rooms, bedrooms, and entryways","Enhances natural light and creates depth","High-quality craftsmanship","Versatile and timeless"],"careInstructions":"Dust the frame regularly with a soft cloth. Clean the mirror surface with a gentle glass cleaner to maintain its shine.","materialComposition":"Crafted from high-quality glass and a durable metallic frame, ensuring longevity and elegance."}',
    '["mirror","sunburst","gold","statement","glamorous","organic shape","green frame","modern","contemporary","home decor","statement piece","living room","bedroom","entryway","unique design","smooth texture","matte finish","decorative mirror","interior design","stylish","elegant","artistic","bold color","unconventional","eye-catching","focal point","versatile","fashionable","trendy","luxury","high-end","decor","Round Sunburst Mirror","artistic mirror","decorative mirrors","luxury home decor","statement mirror","living room mirror","bedroom mirror","entryway mirror","sunburst design","intricate frame mirror","modern decor","contemporary mirror","unique mirror design","high-end mirrors","mirror for home","stylish mirrors","elegant mirrors","artistic home decor","mirror with movement","radiant mirror","mirror with light reflection","mirror focal point","luxury statement piece","exquisite mirrors","mirror with organic shape","green frame mirror"]',
    '{"metaTitle":"Round Sunburst Mirror - Artistic & Functional Decor","metaDescription":"Elevate your space with the Round Sunburst Mirror. Its stunning design and radiant charm make it a luxurious focal point. Buy now for $285!","altText":"Round Sunburst Mirror with dazzling sunburst design and intricate frame, reflecting light to brighten any room.","keywords":["Round Sunburst Mirror","artistic mirror","decorative mirrors","luxury home decor","statement mirror","living room mirror","bedroom mirror","entryway mirror","sunburst design","intricate frame mirror","modern decor","contemporary mirror","unique mirror design","high-end mirrors","mirror for home","stylish mirrors","elegant mirrors","artistic home decor","mirror with movement","radiant mirror","mirror with light reflection","mirror focal point","luxury statement piece","exquisite mirrors","mirror with organic shape","green frame mirror"]}',
    TRUE,
    TRUE,
    4.9,
    178,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'art'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Arched Floor Mirror
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'ART-ART-MIRROR-002',
    'Arched Floor Mirror',
    'Full-length arched mirror with slim black metal frame, perfect for bedrooms and dressing areas.',
    445,
    575,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'mirror' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Jet Black"],"material":["Metal","Glass"],"style":["Modern","Minimalist"],"room":["Bedroom","Dressing Area","Living Room"],"occasion":["Everyday","Decorative"]}',
    '{"primaryColors":[{"name":"Jet Black","hex":"#343434","category":"primary"}],"pattern":"solid","texture":"smooth","finish":"matte","shape":"arched","silhouette":"Tall and slender with an arched top"}',
    '{"short":"Elegant arched floor mirror with a sleek black metal frame for modern decor.","long":"Transform your interior with the Arched Floor Mirror, a captivating blend of functionality and style. This full-length mirror is encased in a slim, sleek black metal frame, delivering a modern aesthetic that seamlessly integrates into any decor. Its elegant arched silhouette adds a touch of architectural intrigue, making it a focal point in any room. Whether placed in a bedroom, dressing area, or living room, this mirror enhances your space by creating the illusion of depth and light. The crystal-clear reflective surface offers an undistorted view, perfect for daily grooming or adding a decorative touch. With its minimalist design and sophisticated finish, the Arched Floor Mirror is more than just a reflection—it''s an expression of style.","features":["Full-length mirror for comprehensive views","Elegant arched top for architectural interest","Sleek black metal frame for a modern touch","Minimalist design enhances room decor","Clear reflective surface for undistorted images","Space-enhancing effect for a spacious feel"],"careInstructions":"Wipe with a soft, dry cloth. Avoid harsh chemicals and abrasive cleaners to maintain its pristine finish.","materialComposition":"Frame: Metal; Mirror: Glass"}',
    '["mirror","floor","arched","full-length","bedroom","floor mirror","arched mirror","full-length mirror","bedroom decor","modern mirror","minimalist mirror","black frame","sleek design","decorative mirror","tall mirror","elegant mirror","living room mirror","dressing area mirror","home decor","interior design","reflective surface","clear reflection","space-enhancing","architectural interest","arched floor mirror","sleek black frame","bedroom mirror","space-enhancing mirror","clear reflective surface","modern style","minimalist style","black metal frame","mirror with arched top","undistorted view","room decor","stylish home accessory","versatile mirror","decorative touch","modern elegance","matte finish mirror","slim frame mirror"]',
    '{"metaTitle":"Arched Floor Mirror - Modern Elegance with Sleek Black Frame","metaDescription":"Enhance your space with the Arched Floor Mirror. Its sleek black frame and elegant design create depth and style. Order now for a stylish touch!","altText":"Arched floor mirror with a sleek black metal frame, enhancing room decor.","keywords":["arched floor mirror","modern mirror","sleek black frame","full-length mirror","minimalist mirror","home decor","bedroom mirror","living room mirror","dressing area mirror","decorative mirror","elegant mirror","tall mirror","interior design","space-enhancing mirror","clear reflective surface","architectural interest","modern style","minimalist style","black metal frame","mirror with arched top","sleek design","reflective surface","undistorted view","room decor","stylish home accessory","versatile mirror","decorative touch","modern elegance","matte finish mirror","slim frame mirror"]}',
    TRUE,
    FALSE,
    4.8,
    89,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'art'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Venetian Style Ornate Mirror
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'ART-ART-MIRROR-003',
    'Venetian Style Ornate Mirror',
    'Elegantly detailed Venetian-style mirror with intricate etched glass border and beveled edges.',
    495,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'mirror' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Warm Chestnut Brown","Clear"],"material":["Wood","Glass"],"style":["Modern","Minimalist"],"room":["Living Room","Bedroom","Entryway"],"occasion":["Everyday","Decorative"]}',
    '{"primaryColors":[{"name":"Warm Chestnut Brown","hex":"#8B5A2B","category":"primary"},{"name":"Clear","hex":"#FFFFFF","category":"accent"}],"pattern":"solid","texture":"smooth","finish":"natural","shape":"organic","silhouette":"Curved with flowing lines"}',
    '{"short":"Exquisite Venetian Style Ornate Mirror for your elegant home decor.","long":"Transform your space with the Venetian Style Ornate Mirror, a masterpiece of craftsmanship and elegance. Its intricate detailing and luxurious design make it a standout piece in any room, reflecting both light and sophistication. Perfect for enhancing the charm of living rooms, bedrooms, or entryways, this mirror serves as a functional art piece that draws admiration and complements a variety of interior styles. Whether accentuating your modern decor or adding a touch of opulence to traditional settings, this mirror is an investment in beauty and style.","features":["Venetian ornate design","Reflective glass surface","Luxurious craftsmanship","Versatile room placement","Enhances light and space","Adds elegance to decor","Intricate detailing"],"careInstructions":"Clean the glass with a gentle glass cleaner. Dust the frame using a soft cloth, avoiding abrasive materials.","materialComposition":"Glass mirror encased in a resin ornate frame"}',
    '["mirror","venetian","ornate","decorative","traditional","wooden frame","organic shape","modern decor","minimalist","home accessory","reflective","natural finish","elegant design","living room","bedroom","entryway","interior design","decorative mirror","unique shape","warm tones","home decor","wall mirror","large mirror","stylish","functional","versatile","smooth texture","contemporary","artistic","statement piece","neutral colors","flowing lines","brightening space","natural materials","clean lines","modern aesthetic","Venetian mirror","ornate mirror","elegant mirror","wooden frame mirror","large wall mirror","modern decor mirror","minimalist mirror","reflective mirror","natural finish mirror","living room mirror","bedroom mirror","entryway mirror","interior design mirror","unique shape mirror","warm tones mirror","stylish mirror","functional mirror","versatile mirror","smooth texture mirror","contemporary mirror","artistic mirror","statement piece mirror","neutral colors mirror","flowing lines mirror","brightening space mirror","natural materials mirror","clean lines mirror"]',
    '{"metaTitle":"Venetian Style Ornate Mirror - Elegant Craftsmanship & Design","metaDescription":"Enhance your decor with the Venetian Style Ornate Mirror. Its luxurious design and intricate details make it a standout piece. Order now for elegance!","altText":"Venetian Style Ornate Mirror with organic wooden frame and smooth finish.","keywords":["Venetian mirror","ornate mirror","elegant mirror","wooden frame mirror","decorative mirror","large wall mirror","modern decor mirror","minimalist mirror","home accessory","reflective mirror","natural finish mirror","living room mirror","bedroom mirror","entryway mirror","interior design mirror","unique shape mirror","warm tones mirror","stylish mirror","functional mirror","versatile mirror","smooth texture mirror","contemporary mirror","artistic mirror","statement piece mirror","neutral colors mirror","flowing lines mirror","brightening space mirror","natural materials mirror","clean lines mirror"]}',
    FALSE,
    FALSE,
    4.7,
    45,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'art'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Organic Shape Mirror
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'ART-ART-MIRROR-004',
    'Organic Shape Mirror',
    'Asymmetrical organic-shaped mirror with natural curves. A unique modern accent.',
    225,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'mirror' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Warm Chestnut","Clear"],"material":["Glass","Wood"],"style":["Modern","Organic"],"room":["Living Room","Bedroom","Bathroom"],"occasion":["Everyday","Decorative Accent"]}',
    '{"primaryColors":[{"name":"Warm Chestnut","hex":"#8B4513","category":"primary"},{"name":"Clear","hex":"#FFFFFF","category":"accent"}],"pattern":"solid","texture":"smooth","finish":"natural","shape":"organic","silhouette":"Asymmetrical with flowing curves"}',
    '{"short":"Transform your space with our elegant organic-shaped mirror framed in warm chestnut wood.","long":"Elevate your home decor with the Organic Shape Mirror, an embodiment of modern elegance and nature-inspired design. The mirror features a captivating asymmetrical shape that flows with graceful curves, making it a unique accent piece for any room. Encased in a warm chestnut wood frame, it exudes a cozy ambiance while enhancing your space''s light and depth. Perfect for living rooms, bedrooms, or bathrooms, this mirror not only serves a functional purpose but also adds artistic flair to your walls. Its organic silhouette effortlessly complements contemporary settings, offering a harmonious blend of style and substance.","features":["Asymmetrical organic silhouette","Warm chestnut wood frame","Enhances space and light","Perfect for contemporary decor","Nature-inspired elegance","Artistic accent piece","Versatile for multiple rooms"],"careInstructions":"Use a soft, damp cloth to clean the glass mirror. Maintain the wooden frame by wiping with a dry cloth and avoid using harsh chemicals.","materialComposition":"Crafted from high-quality glass with a solid chestnut wood frame."}',
    '["mirror","organic","asymmetrical","modern","unique","decor","home","interior","design","accent","wood","glass","natural","elegant","stylish","contemporary","artistic","frame","chestnut","warm","decorative","space","light","living room","bedroom","bathroom","home decor","wall mirror","statement piece","nature-inspired","organic shape mirror","modern mirror","chestnut wood frame","asymmetrical mirror","unique home decor","living room mirror","bedroom mirror","bathroom mirror","nature-inspired design","artistic wall mirror","decorative mirror","modern elegance","home accent piece","stylish mirror","contemporary decor","natural mirror","mirror with curves","elegant mirror","mirror for space enhancement","light enhancing mirror","statement piece mirror","warm chestnut mirror","mirror for modern homes","accent mirror","mirror with wooden frame","home interior mirror","mirror for artistic flair","unique aesthetic mirror","mirror for contemporary settings"]',
    '{"metaTitle":"Organic Shape Mirror - Modern Elegance with Chestnut Frame","metaDescription":"Transform your decor with the Organic Shape Mirror. Its unique asymmetrical design and warm chestnut frame enhance any room''s style. Shop now!","altText":"Elegant organic-shaped mirror with asymmetrical design and warm chestnut wood frame.","keywords":["organic shape mirror","modern mirror","chestnut wood frame","asymmetrical mirror","unique home decor","living room mirror","bedroom mirror","bathroom mirror","nature-inspired design","artistic wall mirror","decorative mirror","modern elegance","home accent piece","stylish mirror","contemporary decor","natural mirror","mirror with curves","elegant mirror","mirror for space enhancement","light enhancing mirror","statement piece mirror","warm chestnut mirror","mirror for modern homes","accent mirror","mirror with wooden frame","home interior mirror","mirror for artistic flair","unique aesthetic mirror","mirror for contemporary settings"]}',
    TRUE,
    FALSE,
    4.6,
    67,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'art'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Rattan Frame Mirror
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'ART-ART-MIRROR-006',
    'Rattan Frame Mirror',
    'Natural rattan frame mirror with bohemian coastal appeal.',
    165,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'mirror' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Black"],"material":["Glass","Metal"],"style":["Modern","Contemporary"],"room":["Bedroom","Bathroom","Living Room"],"occasion":["Everyday","Decorative"]}',
    '{"primaryColors":[{"name":"Black","hex":"#000000","category":"primary"}],"pattern":"solid","texture":"smooth","finish":"matte","shape":"rectangular","silhouette":"Tall and slender with rounded corners"}',
    '{"short":"Charming Rattan Frame Mirror adds a natural touch to your space.","long":"Embrace the effortless elegance of nature with our Rattan Frame Mirror. Its intricate woven design evokes a sense of warmth and authenticity, making it an exceptional centerpiece for any room. Ideal for entryways or living spaces, the mirror''s organic texture and light brown hue harmonize beautifully with earthy or bohemian decor. Reflecting light with grace, this mirror enhances the feeling of openness in your home, while the sturdy rattan frame ensures durability and long-lasting beauty.","features":["Rattan woven frame for a natural aesthetic","Lightweight and easy to hang","Versatile design complements various decor styles","Large mirror surface enhances room brightness","Durable craftsmanship for long-lasting use","Perfect for entryways, living rooms, or bedrooms"],"careInstructions":"Dust the rattan frame regularly with a soft brush or cloth. Clean the mirror surface with a damp cloth and mild glass cleaner. Avoid excessive moisture.","materialComposition":"Frame: 100% natural rattan; Mirror: high-quality reflective glass"}',
    '["mirror","rattan","natural","bohemian","coastal","full-length","LED","black frame","modern","contemporary","home decor","bedroom mirror","bathroom mirror","living room mirror","sleek design","ambient lighting","rectangular mirror","stylish","elegant","versatile","Rattan Frame Mirror","Art & Mirrors","woven mirror design","bohemian decor mirror","entryway mirror","organic texture mirror","light brown mirror","durable rattan mirror","natural elegance mirror","decorative wall mirror","home decor mirror","mirror with rattan frame","authentic design mirror","earthy decor mirror","mirror centerpiece","reflective home decor","mirror with warmth","mirror for open spaces","versatile mirror design","mirror with authenticity","mirror for modern homes","mirror with woven texture","mirror for stylish homes","mirror for elegant interiors"]',
    '{"metaTitle":"Rattan Frame Mirror - Elegant Woven Design & Durability","metaDescription":"Transform your space with our Rattan Frame Mirror, featuring an intricate woven design that adds warmth and authenticity. Perfect for entryways or living spaces. Order now!","altText":"Rattan Frame Mirror with intricate woven design, perfect for entryways or living spaces.","keywords":["Rattan Frame Mirror","Art & Mirrors","woven mirror design","bohemian decor mirror","entryway mirror","living room mirror","organic texture mirror","light brown mirror","durable rattan mirror","natural elegance mirror","decorative wall mirror","home decor mirror","mirror with rattan frame","authentic design mirror","earthy decor mirror","mirror centerpiece","reflective home decor","mirror with warmth","mirror for open spaces","versatile mirror design","mirror with authenticity","mirror for modern homes","mirror with woven texture","mirror for stylish homes","mirror for elegant interiors"]}',
    FALSE,
    FALSE,
    4.7,
    78,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'art'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Industrial Pipe Mirror
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'ART-ART-MIRROR-005',
    'Industrial Pipe Mirror',
    'Round mirror with industrial pipe frame in matte black finish.',
    195,
    250,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'mirror' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Matte Black"],"material":["Metal","Glass"],"style":["Industrial","Modern"],"room":["Bathroom","Entryway","Office"],"occasion":["Everyday","Decorative"]}',
    '{"primaryColors":[{"name":"Matte Black","hex":"#2B2B2B","category":"primary"}],"pattern":"solid","texture":"smooth","finish":"matte","shape":"round","silhouette":"Low-profile with clean lines"}',
    '{"short":"Enhance your space with an edgy round mirror featuring a matte black industrial pipe frame.","long":"Introduce a bold, modern statement piece to your home with our Industrial Pipe Mirror. This round mirror is enclosed in a striking industrial pipe frame finished in a sleek matte black, providing a perfect blend of contemporary design and rugged elegance. Its reflective surface not only enhances the light and depth of any room but also adds an industrial touch to spaces like bathrooms, entryways, and offices. Designed for versatility, this mirror complements various interior styles, from minimalist to modern industrial. Transform your space with this unique and functional art piece that promises to be both a conversation starter and a practical addition to your decor.","features":["Round mirror with industrial pipe frame","Matte black finish for a sleek look","Enhances light and depth","Perfect for bathrooms, entryways, or offices","Versatile design complements various styles","Durable construction for long-lasting use"],"careInstructions":"Clean the mirror surface with a glass cleaner and a soft cloth. Dust the frame regularly with a dry cloth to maintain its matte finish.","materialComposition":"Metal frame with durable glass mirror"}',
    '["mirror","industrial","pipe","round","black","modern","decor","home","bathroom","entryway","office","wall","reflective","stylish","functional","versatile","matte","metal","glass","frame","design","interior","decorative","accent","edgy","sleek","contemporary","minimalist","art","home decor","unique","statement piece","easy to clean","durable","high quality","trendy","modern design","industrial style","matte black","industrial pipe mirror","modern mirror","matte black mirror","round mirror","decorative mirror","bathroom mirror","entryway mirror","office mirror","wall mirror","reflective surface","stylish mirror","functional mirror","versatile mirror","matte finish","metal frame mirror","glass mirror","industrial design","contemporary mirror","minimalist mirror","unique mirror","durable mirror","high quality mirror","trendy mirror"]',
    '{"metaTitle":"Industrial Pipe Mirror - Modern Matte Black Statement Piece","metaDescription":"Transform your space with the Industrial Pipe Mirror, featuring a sleek matte black pipe frame. Perfect for bathrooms, entryways, and offices. Shop now!","altText":"Round mirror with sleek industrial pipe frame in matte black finish, perfect for modern decor.","keywords":["industrial pipe mirror","modern mirror","matte black mirror","round mirror","decorative mirror","home decor","bathroom mirror","entryway mirror","office mirror","wall mirror","reflective surface","stylish mirror","functional mirror","versatile mirror","matte finish","metal frame mirror","glass mirror","industrial design","contemporary mirror","minimalist mirror","statement piece","unique mirror","easy to clean","durable mirror","high quality mirror","trendy mirror","modern design"]}',
    FALSE,
    TRUE,
    4.5,
    134,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'art'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Hexagon Wall Mirror Set
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'ART-ART-MIRROR-007',
    'Hexagon Wall Mirror Set',
    'Set of 3 hexagonal wall mirrors in varying sizes for geometric arrangements.',
    125,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'mirror' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Jet Black"],"material":["Glass","Metal"],"style":["Modern","Minimalist"],"room":["Bathroom","Hallway","Living Room"],"occasion":["Everyday","Decorative"]}',
    '{"primaryColors":[{"name":"Jet Black","hex":"#343434","category":"primary"}],"pattern":"solid","texture":"smooth","finish":"matte","shape":"oval","silhouette":"Low-profile with clean lines"}',
    '{"short":"Transform your space with the elegant Hexagon Wall Mirror Set, perfect for adding depth and modern flair.","long":"Elevate your home decor with the Hexagon Wall Mirror Set, a stunning trio that effortlessly combines functionality with style. Each hexagonal mirror boasts a sleek frame, enhancing the modern aesthetic of your living room, hallway, or bedroom. The geometric design not only creates visual interest but also reflects light to make any space appear larger and brighter. Ideal for contemporary and minimalist interiors, this set provides versatility in arrangement, allowing you to customize your wall decor. Whether grouped together or placed separately, these mirrors are sure to be conversation starters and focal points in your home.","features":["Set of three hexagonal mirrors","Sleek, modern frame design","Reflects light to enhance space","Versatile arrangement options","Perfect for contemporary decor","Adds depth and style","Easy wall mounting"],"careInstructions":"Wipe mirrors with a soft, damp cloth. Avoid using harsh chemicals or abrasive materials to prevent scratches.","materialComposition":"High-quality glass mirrors with durable metal frames."}',
    '["mirror","hexagon","set","geometric","gold","oval","black frame","modern","minimalist","decor","bathroom mirror","hallway","living room","sleek design","elegant","reflective","glass","metal","home decor","wall mirror","interior design","stylish","functional","versatile","light enhancing","space enhancing","easy maintenance","hexagon wall mirror","mirror set","modern mirrors","geometric design","living room mirrors","hallway decor","bedroom mirrors","minimalist mirrors","contemporary mirrors","mirror trio","light enhancing mirrors","decorative mirrors","stylish mirror set","versatile wall mirrors","mirror arrangement ideas","sleek mirror frames","reflective wall mirrors","interior design mirrors","conversation starter decor","focal point mirrors","customizable mirror set","space enhancing mirrors","modern aesthetic mirrors","elegant wall mirrors","functional mirror decor","mirror for brightening spaces","mirror for larger appearance","mirror set for modern homes"]',
    '{"metaTitle":"Hexagon Wall Mirror Set - Stylish Trio for Modern Decor","metaDescription":"Transform your space with the Hexagon Wall Mirror Set. Enhance light and style in your home. Shop now for versatile, modern wall decor!","altText":"Hexagon Wall Mirror Set featuring sleek frames and geometric design, perfect for modern home decor.","keywords":["hexagon wall mirror","mirror set","home decor","modern mirrors","geometric design","living room mirrors","hallway decor","bedroom mirrors","minimalist mirrors","contemporary mirrors","mirror trio","light enhancing mirrors","decorative mirrors","stylish mirror set","versatile wall mirrors","mirror arrangement ideas","sleek mirror frames","reflective wall mirrors","interior design mirrors","conversation starter decor","focal point mirrors","customizable mirror set","space enhancing mirrors","modern aesthetic mirrors","elegant wall mirrors","functional mirror decor","mirror for brightening spaces","mirror for larger appearance","mirror set for modern homes"]}',
    TRUE,
    FALSE,
    4.6,
    92,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'art'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Minimalist Rectangle Mirror
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'ART-ART-MIRROR-008',
    'Minimalist Rectangle Mirror',
    'Clean-lined rectangular mirror with thin brass frame. Versatile and elegant.',
    175,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'mirror' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Bright Red"],"material":["Glass","Metal"],"style":["Contemporary","Modern"],"room":["Bathroom","Bedroom","Entryway"],"occasion":["Everyday","Decorative"]}',
    '{"primaryColors":[{"name":"Bright Red","hex":"#FF0000","category":"accent"}],"pattern":"solid","texture":"smooth","finish":"gloss","shape":"organic","silhouette":"Organic shape with bold lines"}',
    '{"short":"Elevate your space with this minimalist rectangle mirror, featuring a sleek design and versatile charm.","long":"Enhance your home''s aesthetic with the Minimalist Rectangle Mirror, a perfect blend of simplicity and elegance. Its clean lines and unobtrusive design make it an ideal choice for modern and minimalist decor styles. The mirror''s expansive reflective surface is perfect for amplifying natural light and creating a sense of space in any room. Whether placed in a bathroom to brighten the area, or in a bedroom as a subtle statement piece, this mirror seamlessly integrates into various settings. With a focus on functionality and style, its enduring appeal lies in its ability to complement without overwhelming.","features":["Sleek minimalist design","Rectangle shape for versatile placement","Large reflective surface","Enhances natural light","Perfect for modern decor","Unobtrusive and elegant","Ideal for bathrooms and bedrooms"],"careInstructions":"Clean the mirror with a soft, dry cloth to remove dust. For smudges, use a gentle glass cleaner. Avoid abrasive materials.","materialComposition":"High-quality glass mirror with a durable metal frame"}',
    '["mirror","minimalist","rectangle","brass","modern","organic shape","red frame","contemporary","decor","home","wall mirror","accent piece","unique design","statement mirror","reflective surface","glass","metal","bold color","artistic","versatile","bathroom mirror","bedroom mirror","entryway mirror","interior design","home decor","stylish","elegant","sleek","trendy","fashionable","decorative mirror","Minimalist Rectangle Mirror","bold red frame mirror","modern decor mirror","contemporary mirror","home decor mirror","reflective surface mirror","organic shape mirror","accent piece mirror","glass and metal mirror","interior design mirror","stylish mirror","elegant mirror","minimalist mirror","sleek mirror","trendy mirror","fashionable mirror","artistic mirror","unique design mirror","organic-shaped mirror","bright red mirror","versatile mirror"]',
    '{"metaTitle":"Minimalist Rectangle Mirror with Bold Red Frame","metaDescription":"Elevate your space with the Minimalist Rectangle Mirror. Its bold red frame and expansive surface enhance light and style. Perfect for modern decor. Shop now!","altText":"Minimalist Rectangle Mirror with bold red frame, ideal for modern and contemporary home decor.","keywords":["Minimalist Rectangle Mirror","bold red frame mirror","modern decor mirror","contemporary mirror","home decor mirror","reflective surface mirror","organic shape mirror","accent piece mirror","statement mirror","glass and metal mirror","bathroom mirror","bedroom mirror","entryway mirror","interior design mirror","stylish mirror","elegant mirror","minimalist mirror","sleek mirror","trendy mirror","fashionable mirror","decorative mirror","artistic mirror","unique design mirror","organic-shaped mirror","bright red mirror","versatile mirror"]}',
    FALSE,
    TRUE,
    4.8,
    156,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'art'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Ornate Carved Mirror
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'ART-ART-MIRROR-009',
    'Ornate Carved Mirror',
    'Beautifully carved wooden frame mirror with antique white finish.',
    325,
    425,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'mirror' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Black"],"material":["Glass","Metal"],"style":["Modern","Minimalist"],"room":["Bedroom","Bathroom","Dining Room"],"occasion":["Everyday","Decorative"]}',
    '{"primaryColors":[{"name":"Black","hex":"#000000","category":"primary"}],"pattern":"solid","texture":"smooth","finish":"matte","shape":"rectangular","silhouette":"Curved top with clean lines"}',
    '{"short":"Bring opulence and charm with the Ornate Carved Mirror.","long":"Elevate your space with the Ornate Carved Mirror, a testament to exquisite craftsmanship. Its intricately carved wooden frame boasts elegant floral motifs, offering a touch of vintage allure to your home. This mirror''s rich details and reflective surface create an expansive feel, ideal for adorning any wall in need of a statement piece. Whether gracing the entryway, living room, or bedroom, it harmonizes effortlessly with both traditional and contemporary interiors, enhancing light and depth. Priced at $325, this piece is more than a mirror; it''s an artful addition to your decor.","features":["Intricately carved wooden frame","Vintage floral motifs","Expands light and space","Suitable for traditional and contemporary styles","Ideal for entryways, living rooms, or bedrooms","Statement piece for wall decor","Reflective surface enhances ambiance"],"careInstructions":"Dust regularly with a soft cloth. Clean glass with a gentle glass cleaner. Avoid moisture contact with the wooden frame.","materialComposition":"Glass mirror with solid wood frame featuring carved details"}',
    '["mirror","ornate","carved","antique","french country","sleek","curved","modern","minimalist","decorative","elegant","reflective","home decor","interior design","wall mirror","bedroom mirror","bathroom mirror","dining room mirror","black frame","contemporary","clean lines","light enhancement","space enhancement","versatile","stylish","sophisticated","accent piece","home improvement","wall decor","furniture","accessory","ornament","design","architecture","living space","home styling","room enhancement","visual appeal","ornate carved mirror","vintage mirror","floral mirror","wooden frame mirror","art and mirrors","decorative mirror","elegant mirror","statement piece","entryway mirror","living room mirror","traditional decor","contemporary decor","reflective surface","depth enhancement","mirror craftsmanship","artful mirror","mirror for home","mirror with motifs","mirror elegance","mirror allure","mirror vintage","mirror design","mirror style"]',
    '{"metaTitle":"Ornate Carved Mirror - Vintage Elegance for Your Home","metaDescription":"Transform your space with the Ornate Carved Mirror''s floral motifs. Add vintage allure and depth to any room. Shop now for $325!","altText":"Ornate Carved Mirror with elegant floral motifs on a wooden frame, enhancing room decor.","keywords":["ornate carved mirror","vintage mirror","floral mirror","wooden frame mirror","art and mirrors","decorative mirror","elegant mirror","home decor","interior design","statement piece","entryway mirror","living room mirror","bedroom mirror","traditional decor","contemporary decor","reflective surface","light enhancement","depth enhancement","mirror craftsmanship","artful mirror","wall mirror","mirror for home","mirror with motifs","mirror elegance","mirror allure","mirror vintage","mirror design","mirror style"]}',
    FALSE,
    FALSE,
    4.7,
    56,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'art'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Art Deco Fan Mirror
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'ART-ART-MIRROR-010',
    'Art Deco Fan Mirror',
    'Dramatic art deco inspired mirror with fan-shaped design and brass finish.',
    275,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'mirror' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Jet Black"],"material":["Glass","Metal"],"style":["Modern","Contemporary"],"room":["Living Room","Bedroom","Entryway"],"occasion":["Everyday","Dressing"]}',
    '{"primaryColors":[{"name":"Jet Black","hex":"#343434","category":"primary"}],"pattern":"solid","texture":"smooth","finish":"matte","shape":"rectangular","silhouette":"Tall and sleek with clean lines"}',
    '{"short":"Add vintage charm with the Art Deco Fan Mirror, featuring a unique fan-shaped design and a sophisticated gold frame.","long":"Transform your home with the Art Deco Fan Mirror, a captivating blend of vintage elegance and modern functionality. Its distinct fan-shaped design, outlined by a luxurious gold frame, evokes the glamorous essence of the Art Deco era. Ideal for making a bold statement in your living room, bedroom, or entryway, this mirror not only serves as a piece of art but also enhances natural light and creates the illusion of more space. The reflective surface provides a crisp, clear image, perfect for last-minute checks before heading out. Add a touch of refinement to your decor with this exquisite accent piece.","features":["Unique fan-shaped design","Elegant gold frame","Art Deco-inspired aesthetics","Clear reflective glass surface","Enhances light and space"],"careInstructions":"Wipe with a soft, dry cloth. Use a gentle glass cleaner for the mirror surface. Avoid harsh chemicals on the frame.","materialComposition":"High-quality glass mirror with a durable metal frame finished in gold"}',
    '["mirror","art deco","fan","brass","glamorous","full-length","black frame","modern","contemporary","sleek","minimalist","home decor","reflective","glass","metal","rectangular","elegant","versatile","entryway","bedroom","living room","dressing","interior design","decor","stylish","clean lines","matte finish","smooth texture","solid pattern","tall mirror","floor mirror","accent piece","home accessory","decorative mirror","functional","sleek design","modern aesthetic","contemporary style","black accent","glass surface","clear reflection","metal frame","simple elegance","versatile use","room enhancement","space enlarging","light reflecting","easy maintenance","Art Deco Fan Mirror","vintage mirror","gold frame mirror","fan-shaped mirror","elegant mirrors","decorative mirrors","modern mirrors","home decor mirrors","living room mirrors","bedroom mirrors","entryway mirrors","luxury mirrors","artistic mirrors","statement mirrors","reflective mirrors","light enhancing mirrors","space enlarging mirrors","clear reflection mirrors","accent mirrors","glamorous mirrors","mirrors for home","stylish mirrors","bold mirrors","refined decor","decor accent pieces","mirror art","home accessories","interior design mirrors","glam mirrors","elegant home decor"]',
    '{"metaTitle":"Art Deco Fan Mirror - Vintage Elegance & Modern Flair","metaDescription":"Elevate your space with the Art Deco Fan Mirror''s luxurious gold frame and fan-shaped design. Perfect for enhancing light and space. Shop now!","altText":"Art Deco Fan Mirror with a gold frame and fan-shaped design.","keywords":["Art Deco Fan Mirror","vintage mirror","gold frame mirror","fan-shaped mirror","elegant mirrors","decorative mirrors","modern mirrors","home decor mirrors","living room mirrors","bedroom mirrors","entryway mirrors","luxury mirrors","artistic mirrors","statement mirrors","reflective mirrors","light enhancing mirrors","space enlarging mirrors","clear reflection mirrors","accent mirrors","glamorous mirrors","mirrors for home","stylish mirrors","bold mirrors","refined decor","decor accent pieces","mirror art","home accessories","interior design mirrors","glam mirrors","elegant home decor"]}',
    TRUE,
    FALSE,
    4.9,
    89,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'art'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Abstract Canvas Print
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'ART-ART-WALL-001',
    'Abstract Canvas Print',
    'Large abstract canvas print in soft neutral tones. Gallery wrapped and ready to hang.',
    185,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'wall-art' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Forest Green","Soft Beige","Neutral Gray"],"material":["Canvas"],"style":["Abstract","Modern"],"room":["Living Room","Bedroom","Office"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Forest Green","hex":"#2C5F2D","category":"primary"},{"name":"Soft Beige","hex":"#D8CFC4","category":"secondary"},{"name":"Neutral Gray","hex":"#B0B0B0","category":"accent"}],"pattern":"abstract","texture":"textured","finish":"matte","shape":"rectangular","silhouette":"Bold and dynamic with flowing lines"}',
    '{"short":"Large abstract canvas print in deep green and neutral tones, gallery wrapped.","long":"Transform your space with this captivating abstract canvas print, featuring a harmonious blend of deep forest green and soft neutral tones. The textured design creates a sense of movement and depth, making it a striking centerpiece for any room. Its gallery-wrapped finish ensures a polished look from every angle, while the ready-to-hang design makes installation effortless. Perfect for living spaces, offices, or bedrooms, this piece adds a touch of modern elegance and complements various interior styles with its versatile color palette and artistic flair.","features":["Large abstract design","Deep forest green and neutral tones","Textured appearance","Gallery wrapped","Ready to hang","Versatile color palette","Modern and elegant touch"],"careInstructions":"Dust gently with a soft, dry cloth. Avoid direct sunlight to prevent fading.","materialComposition":"Canvas with gallery wrap"}',
    '["wall art","abstract","canvas","neutral","modern","neutral tones","modern design","gallery wrapped","forest green","interior decor","living room art","bedroom art","office art","large canvas","textured art","ready to hang","contemporary","artistic centerpiece","decorative","home decor","stylish","elegant","versatile","art print","modern art","neutral palette","green tones","abstract painting","canvas print","artwork","creative","design","sophisticated","minimalist","statement piece","decor","abstract canvas print","forest green art","neutral tones decor","ready to hang art","contemporary art","stylish wall art","elegant art","versatile canvas","canvas artwork","creative design","sophisticated decor","minimalist art"]',
    '{"metaTitle":"Abstract Canvas Print - Modern Art with Gallery Wrap","metaDescription":"Elevate your space with this large abstract canvas print in deep green and neutral tones. Ready to hang, it adds modern elegance. Order now!","altText":"Large abstract canvas print with deep forest green and neutral tones, gallery-wrapped finish.","keywords":["abstract canvas print","modern art","gallery wrapped","forest green art","neutral tones decor","living room art","bedroom art","office art","large canvas","textured art","ready to hang art","contemporary art","artistic centerpiece","home decor","stylish wall art","elegant art","versatile canvas","art print","modern design","neutral palette","green tones","abstract painting","canvas artwork","creative design","sophisticated decor","minimalist art","statement piece"]}',
    TRUE,
    TRUE,
    4.8,
    234,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'art'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Botanical Print Set
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'ART-ART-WALL-002',
    'Botanical Print Set',
    'Set of 4 vintage-style botanical prints in matching black frames.',
    145,
    195,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'wall-art' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Warm Chestnut Brown","Soft Beige","Gold"],"material":["Canvas","Metal"],"style":["Contemporary","Modern"],"room":["Living Room","Bedroom","Office"],"occasion":["Everyday","Decorative"]}',
    '{"primaryColors":[{"name":"Warm Chestnut Brown","hex":"#8B5A2B","category":"primary"},{"name":"Soft Beige","hex":"#D3B8A3","category":"secondary"},{"name":"Gold","hex":"#FFD700","category":"accent"}],"pattern":"abstract","texture":"textured","finish":"matte","shape":"rectangular","silhouette":"Bold abstract with textured brushstrokes"}',
    '{"short":"Elegant Botanical Print Set in soothing hues, perfect for enhancing any room''s ambiance.","long":"Transform your space with our Botanical Print Set, a trio of stunning artworks that encapsulate nature''s beauty. Each piece showcases intricate botanical illustrations, rendered in soothing greens and subtle earth tones, offering a tranquil escape into the natural world. The prints'' vivid details and delicate lines are framed in elegant white mats and housed within sleek black frames, making them a versatile addition to any decor style. Ideal for living rooms, bedrooms, or home offices, this set brings a refreshing touch of nature indoors, inviting serenity and elegance into your space.","features":["Set of three botanical prints","Intricate botanical illustrations","Soothing green and earth tone palette","Elegant white mats and black frames","Perfect for living rooms, bedrooms, offices"],"careInstructions":"Clean frames with a damp cloth. Avoid hanging in direct sunlight to prevent fading.","materialComposition":"High-quality paper prints with wooden frames and glass covers"}',
    '["wall art","botanical","print set","vintage","nature","abstract art","modern decor","canvas painting","gold frame","earth tones","contemporary style","living room art","bedroom decor","office artwork","textured painting","elegant wall art","sophisticated design","artistic focal point","warm color palette","interior design","home decoration","stylish art piece","visual depth","artistic flair","decorative accent","modern aesthetics","canvas art","gold accent","matte finish","rectangular shape","bold design","artistic expression","unique artwork","creative decor","room enhancement","visual intrigue","harmonious blend","botanical prints","nature art","art and mirrors","living room decor","bedroom art","black frames","green and earth tones","nature illustrations","modern art","decorative accents","serene art","art trio","nature-inspired art","tranquil decor","elegant art set","botanical illustrations","art for home","stylish art pieces","nature escape"]',
    '{"metaTitle":"Botanical Print Set - Elegant Nature Art Trio","metaDescription":"Revitalize your space with our Botanical Print Set. These elegant artworks bring nature indoors, offering serenity and sophistication. Order now!","altText":"Botanical Print Set featuring elegant black frames and intricate nature illustrations.","keywords":["botanical prints","nature art","art and mirrors","elegant wall art","home decoration","living room decor","bedroom art","office artwork","black frames","green and earth tones","nature illustrations","interior design","modern art","contemporary style","artistic flair","decorative accents","serene art","art trio","nature-inspired art","tranquil decor","sophisticated design","elegant art set","botanical illustrations","art for home","stylish art pieces","nature escape","visual depth","artistic expression"]}',
    FALSE,
    TRUE,
    4.7,
    187,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'art'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Minimalist Line Art
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'ART-ART-WALL-003',
    'Minimalist Line Art',
    'Elegant single-line drawing print in sleek white frame. Modern simplicity.',
    95,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'wall-art' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Antique Gold"],"material":["Wood","Glass"],"style":["Traditional","Vintage"],"room":["Living Room","Bedroom","Hallway"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Antique Gold","hex":"#D4AF37","category":"primary"}],"pattern":"solid","texture":"ornate","finish":"polished","shape":"arched","silhouette":"Tall and arched with intricate frame detailing"}',
    '{"short":"Minimalist black line art print adds contemporary elegance to any space.","long":"Enhance your living space with our Minimalist Line Art, a striking blend of simplicity and sophistication. This piece features bold black lines on a crisp white background, creating a dynamic visual impact. Its minimalist design complements modern and contemporary interiors, adding a touch of artistic flair to your walls. Whether displayed in the living room, bedroom, or office, this art piece effortlessly elevates your decor with its clean lines and stylish appeal. Perfect for art enthusiasts who appreciate understated elegance, the Minimalist Line Art is a versatile addition that invites contemplation and conversation.","features":["Bold black lines on white background","Contemporary minimalist design","Versatile for various room settings","Enhances modern decor","Artistic focal point","Unframed for seamless integration","Ideal for art lovers"],"careInstructions":"Dust gently with a soft cloth. Avoid direct sunlight to prevent fading. Frame as desired to protect and preserve.","materialComposition":"High-quality paper print with archival ink"}',
    '["wall art","line art","minimalist","black and white","modern","mirror","gold frame","ornate","baroque","traditional decor","vintage style","home accessory","luxury","elegant","reflective","decorative","large mirror","arched mirror","classic design","interior design","wall mirror","accent piece","home decor","living room","bedroom","hallway","opulent","sophisticated","baroque style","ornate detailing","polished finish","decorative mirror","statement piece","golden hue","traditional style","vintage charm","minimalist line art","modern wall decor","contemporary art piece","sophisticated wall art","minimalist design","bold black lines","artistic flair","modern interiors","living room art","bedroom wall decor","office art","understated elegance","dynamic visual impact","clean lines art","stylish appeal","decorative art piece","contemplative art","conversation starter art","minimalist wall decor","art for modern homes","simplicity in art","elevate your decor","art for contemporary spaces","minimalist home decor","versatile art piece","art for art enthusiasts","sophisticated art piece","minimalist black and white art","modern minimalist art"]',
    '{"metaTitle":"Minimalist Line Art - Sophisticated Modern Wall Decor","metaDescription":"Elevate your space with Minimalist Line Art. Perfect for modern interiors, this art piece adds sophistication and style. Shop now to transform your decor!","altText":"Minimalist Line Art featuring bold black lines on a white background.","keywords":["minimalist line art","modern wall decor","contemporary art piece","sophisticated wall art","minimalist design","bold black lines","artistic flair","modern interiors","living room art","bedroom wall decor","office art","understated elegance","dynamic visual impact","clean lines art","stylish appeal","decorative art piece","contemplative art","conversation starter art","minimalist wall decor","art for modern homes","simplicity in art","elevate your decor","art for contemporary spaces","minimalist home decor","versatile art piece","art for art enthusiasts","sophisticated art piece","minimalist black and white art","modern minimalist art"]}',
    TRUE,
    FALSE,
    4.6,
    112,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'art'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Textured Wall Sculpture
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'ART-ART-WALL-004',
    'Textured Wall Sculpture',
    'Dimensional wall sculpture in white ceramic. Creates beautiful shadow play.',
    245,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'wall-art' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Terracotta","Deep Teal","Beige","Black"],"material":["Canvas","Metal"],"style":["Modern","Abstract"],"room":["Living Room","Entryway","Dining Room"],"occasion":["Everyday","Decorative"]}',
    '{"primaryColors":[{"name":"Terracotta","hex":"#E2725B","category":"primary"},{"name":"Deep Teal","hex":"#004B49","category":"secondary"},{"name":"Beige","hex":"#D3B8A0","category":"accent"},{"name":"Black","hex":"#000000","category":"accent"}],"pattern":"geometric","texture":"textured","finish":"matte","shape":"rectangular","silhouette":"Framed geometric composition"}',
    '{"short":"Elevate your space with a stunning Textured Wall Sculpture in earthy tones and geometric design.","long":"Transform your home with the Textured Wall Sculpture, a masterpiece of modern art that brings depth and sophistication to any room. This striking piece features an abstract array of geometric shapes in a harmonious blend of terracotta, deep teal, and beige. Encased in a sleek black frame, it offers a contemporary flair that''s perfect for living rooms, entryways, or dining areas. The textured finish of this sculpture adds dimension, creating an engaging focal point that captivates the eye. With its earthy color palette and modern design, this wall art seamlessly integrates into various interior styles, offering both aesthetic appeal and versatility.","features":["Abstract geometric design","Earthy tones: terracotta, deep teal, beige","Sleek black metal frame","Textured, dimensional finish","Modern, contemporary style","Ideal for living rooms, entryways, and dining rooms"],"careInstructions":"Dust regularly with a soft cloth. Keep out of direct sunlight to prevent fading.","materialComposition":"Canvas print with a black metal frame"}',
    '["wall art","sculpture","ceramic","white","textured","modern art","abstract design","geometric shapes","earthy tones","framed art","canvas print","wall decor","contemporary style","living room art","entryway decor","dining room art","terracotta","deep teal","beige","black frame","textured wall art","art piece","home decoration","interior design","visual interest","focal point","artistic expression","minimalist","stylish","unique design","creative","decorative piece","artistic","eye-catching","modern aesthetic","home styling","art collection","gallery wall","artistic flair","design element","wall sculpture","ceramic art","shadow play","textured wall sculpture","terracotta art","deep teal art","beige art","black frame art","focal point art","minimalist art","stylish wall decor","creative art","eye-catching art"]',
    '{"metaTitle":"Textured Wall Sculpture - Modern Art with Geometric Design","metaDescription":"Elevate your space with the Textured Wall Sculpture. This modern art piece features abstract geometric shapes in earthy tones. Perfect for any room. Shop now!","altText":"Modern wall sculpture with abstract geometric shapes in terracotta, teal, and beige.","keywords":["textured wall sculpture","modern art","abstract design","geometric shapes","earthy tones","framed art","canvas print","wall decor","contemporary style","living room art","entryway decor","dining room art","terracotta art","deep teal art","beige art","black frame art","textured wall art","home decoration","interior design","visual interest","focal point art","artistic expression","minimalist art","stylish wall decor","unique design","creative art","decorative piece","eye-catching art","modern aesthetic","home styling"]}',
    FALSE,
    FALSE,
    4.8,
    67,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'art'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Photography Print
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'ART-ART-WALL-005',
    'Photography Print',
    'Black and white architectural photography print in oak frame.',
    165,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'wall-art' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Warm Ochre","Natural Oak"],"material":["Paper","Oak Wood","Glass"],"style":["Modern","Contemporary"],"room":["Living Room","Office","Hallway"],"occasion":["Everyday","Decorative"]}',
    '{"primaryColors":[{"name":"Warm Ochre","hex":"#C68A53","category":"primary"},{"name":"Natural Oak","hex":"#D3BFA6","category":"accent"}],"pattern":"geometric","texture":"smooth","finish":"matte","shape":"rectangular","silhouette":"Bold geometric shapes with clean lines"}',
    '{"short":"Abstract geometric print in warm ochre tones, framed in oak.","long":"This striking abstract print features bold geometric shapes in a warm ochre hue, creating a captivating visual impact. The artwork is elegantly framed in natural oak, enhancing its modern appeal. Ideal for adding a touch of contemporary sophistication to any space, this piece is perfect for living rooms, offices, or hallways. The print''s minimalist design and earthy color palette make it versatile and easy to integrate into various decor styles. Whether you''re looking to enliven a neutral space or complement a colorful room, this print provides a balanced blend of style and elegance.","features":["Abstract geometric design","Warm ochre color","Natural oak frame","Modern and contemporary style","Versatile decor piece","High-quality art print","Smooth matte finish"],"careInstructions":"Dust frame regularly with a soft cloth. Avoid direct sunlight to prevent fading.","materialComposition":"Print on high-quality paper, framed with solid oak and glass."}',
    '["wall art","photography","black and white","architecture","modern","abstract art","geometric print","modern decor","contemporary art","home decor","office art","living room","hallway","minimalist","oak frame","warm tones","ochre","art print","decorative piece","stylish","elegant","sophisticated","versatile","clean lines","bold design","framed art","interior design","artistic","visual impact","earthy colors","modern style","contemporary style","high-quality print","natural materials","easy to integrate","captivating","living room art","hallway decor","minimalist design","ochre art","stylish art","elegant decor","sophisticated art","versatile wall art","artistic print"]',
    '{"metaTitle":"Photography Print - Abstract Geometric Art in Oak Frame","metaDescription":"Enhance your space with our abstract geometric photography print in warm ochre. Elegantly framed in natural oak, perfect for modern decor. Shop now!","altText":"Abstract geometric photography print in warm ochre, framed in natural oak.","keywords":["abstract art","geometric print","modern decor","contemporary art","wall art","home decor","office art","living room art","hallway decor","minimalist design","oak frame","warm tones","ochre art","art print","decorative piece","stylish art","elegant decor","sophisticated art","versatile wall art","clean lines","bold design","framed art","interior design","artistic print","visual impact","earthy colors","modern style","contemporary style","high-quality print","natural materials"]}',
    FALSE,
    FALSE,
    4.5,
    78,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'art'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Metal Wall Art
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'ART-ART-WALL-006',
    'Metal Wall Art',
    'Geometric metal wall art in brushed gold finish. Modern sophistication.',
    215,
    275,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'wall-art' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Vivid Orange","Jet Black","Bright White"],"material":["Canvas"],"style":["Contemporary","Urban"],"room":["Living Room","Office","Bedroom"],"occasion":["Everyday","Art Display"]}',
    '{"primaryColors":[{"name":"Vivid Orange","hex":"#FF4500","category":"primary"},{"name":"Jet Black","hex":"#000000","category":"secondary"},{"name":"Bright White","hex":"#FFFFFF","category":"accent"}],"pattern":"abstract","texture":"textured","finish":"matte","shape":"rectangular","silhouette":"Bold and dynamic with expressive lines"}',
    '{"short":"Add dynamic urban flair with this vibrant graffiti-style cat wall art.","long":"Transform your space with this vibrant graffiti-style wall art, featuring a whimsical cat on a vivid orange canvas. The dynamic design incorporates bold black and white stripes and expressive text elements, creating an urban aesthetic that stands out. Perfect for contemporary and eclectic interiors, this piece not only adds a splash of color but also brings a playful, artistic vibe to your decor. Whether in a living room, office, or bedroom, it serves as a striking statement piece that''s sure to spark conversation and admiration. Infuse your space with creativity and modern street art charm.","features":["Vivid graffiti-style artwork","Whimsical cat motif","Bold color palette with vivid orange","Expressive text elements for added flair","Urban aesthetic perfect for modern spaces","High-quality canvas print","Ideal for contemporary and eclectic decor"],"careInstructions":"Dust gently with a soft cloth. Avoid direct sunlight to prevent fading and preserve color vibrancy.","materialComposition":"Printed on high-quality canvas"}',
    '["wall art","metal","geometric","gold","modern","graffiti art","street art","urban decor","cat illustration","vivid colors","modern art","canvas print","expressive design","bold artwork","contemporary style","artistic decor","whimsical cat","orange wall art","black and white","text elements","dynamic art","creative decor","unique wall art","eye-catching design","playful illustration","artistic expression","modern aesthetic","decorative piece","statement art","colorful artwork","urban style","artistic flair","vibrant decor","creative wall art","eclectic style"]',
    '{"metaTitle":"Vibrant Graffiti Metal Wall Art - Whimsical Cat Design","metaDescription":"Transform your space with vibrant graffiti wall art featuring a whimsical cat. Shop now for bold, urban decor that sparks conversation and admiration.","altText":"Graffiti-style metal wall art with a whimsical cat on a vivid orange canvas.","keywords":["graffiti art","street art","urban decor","cat illustration","vivid colors","modern art","canvas print","expressive design","bold artwork","contemporary style","artistic decor","whimsical cat","orange wall art","black and white","text elements","dynamic art","creative decor","unique wall art","eye-catching design","playful illustration","artistic expression","modern aesthetic","decorative piece","statement art","colorful artwork","urban style","artistic flair","vibrant decor","creative wall art","eclectic style"]}',
    TRUE,
    FALSE,
    4.7,
    98,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'art'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Woven Wall Hanging
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'ART-ART-WALL-007',
    'Woven Wall Hanging',
    'Handwoven macramé wall hanging in natural cotton. Bohemian texture.',
    125,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'wall-art' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Natural Cotton","Cream"],"material":["Cotton","Wood"],"style":["Bohemian","Handcrafted"],"room":["Living Room","Bedroom","Nursery"],"occasion":["Everyday","Decorative"]}',
    '{"primaryColors":[{"name":"Natural Cotton","hex":"#F5F5DC","category":"primary"},{"name":"Cream","hex":"#FFFDD0","category":"secondary"}],"pattern":"textured","texture":"woven","finish":"natural","shape":"organic","silhouette":"Flowing with intricate knots and tassels"}',
    '{"short":"Elegant macramé wall hanging crafted from natural cotton for a bohemian touch.","long":"Transform your living space with this elegant macramé wall hanging, meticulously handwoven from natural cotton. Its delicate craftsmanship showcases a bohemian charm, accentuated by cascading tassels and intricate knots. The neutral palette of soft creams and natural hues harmonizes effortlessly with any decor style, making it an ideal addition to bedrooms, living rooms, or nurseries. The wooden rod adds a rustic element, enhancing its artisanal appeal. Perfect for those who appreciate handcrafted artistry, this piece promises to add warmth and character to your home.","features":["Handwoven macramé design","Natural cotton fibers for soft texture","Bohemian style with intricate knots","Wooden rod for rustic charm","Neutral tones for versatile decor","Ideal for bedrooms, living rooms, and nurseries","Artisanal and handcrafted"],"careInstructions":"Gently dust with a soft cloth or use a vacuum with a brush attachment. Avoid direct exposure to moisture.","materialComposition":"100% natural cotton with wooden accents"}',
    '["wall art","macrame","woven","bohemian","handmade","natural decor","cotton","wood","textured","organic","artisan","craft","home decor","interior design","neutral tones","rustic","soft texture","bedroom decor","living room decor","nursery decor","artisanal","handcrafted","boho","eco-friendly","sustainable","decorative piece","wall hanging","natural fibers","unique design","gift idea","stylish","elegant","woven wall hanging","macrame wall art","bohemian decor","handcrafted wall hanging","natural cotton","rustic home decor","artisanal wall piece","boho style","unique wall decor","cotton wall hanging","wooden accents","bedroom wall art","eco-friendly decor","handmade wall art","intricate knots","tassels","decorative wall hanging","organic design","artistic wall piece","stylish home decor","sustainable decor","elegant wall hanging","artisan craftsmanship"]',
    '{"metaTitle":"Woven Wall Hanging - Handcrafted Bohemian Art Piece","metaDescription":"Elevate your home decor with our elegant woven wall hanging. Handcrafted from natural cotton, it adds warmth and charm. Shop now for boho style!","altText":"Elegant handwoven macramé wall hanging made of natural cotton with intricate knots and tassels.","keywords":["woven wall hanging","macrame wall art","bohemian decor","handcrafted wall hanging","natural cotton","rustic home decor","artisanal wall piece","boho style","unique wall decor","cotton wall hanging","wooden accents","neutral tones","living room decor","bedroom wall art","nursery decor","eco-friendly decor","handmade wall art","soft texture","intricate knots","tassels","decorative wall hanging","organic design","artistic wall piece","stylish home decor","gift idea","sustainable decor","elegant wall hanging","natural fibers","artisan craftsmanship","interior design"]}',
    FALSE,
    TRUE,
    4.9,
    156,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'art'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Gallery Frame Set
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'ART-ART-WALL-008',
    'Gallery Frame Set',
    'Set of 5 matching gallery frames in matte black for custom photo arrangements.',
    95,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'wall-art' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Matte Black"],"material":["Wood","Glass"],"style":["Modern","Classic"],"room":["Living Room","Hallway","Office"],"occasion":["Everyday","Decorative"]}',
    '{"primaryColors":[{"name":"Matte Black","hex":"#000000","category":"primary"}],"pattern":"solid","texture":"smooth","finish":"matte","shape":"rectangular","silhouette":"Sleek and minimalist with clean lines"}',
    '{"short":"Elevate your space with this sleek set of 5 matte black gallery frames.","long":"Transform any room with the Gallery Frame Set, featuring five meticulously crafted frames in a sophisticated matte black finish. Each frame is designed to enhance your cherished memories or artwork with a touch of elegance. The sturdy wood and glass construction ensures durability, while the minimalist rectangular design seamlessly integrates into modern or classic interiors. Whether displayed in your living room, hallway, or office, these frames create a personalized visual narrative. Let your creativity flow as you arrange them to suit your style, adding depth and character to your decor.","features":["Set of 5 matching frames","Sophisticated matte black finish","Sturdy wood and glass construction","Minimalist rectangular design","Enhances modern and classic interiors","Ideal for personalized arrangements","Creates a cohesive visual narrative"],"careInstructions":"Wipe frames with a soft, dry cloth to remove dust. Avoid using harsh chemicals or abrasive materials.","materialComposition":"Wood frame with glass front"}',
    '["frames","gallery","set","black","modern","gallery frames","photo display","matte black","modern decor","classic style","home decor","wall art","living room","office decor","hallway decoration","wood frames","glass front","set of frames","minimalist design","custom arrangement","photo frames","art display","decorative frames","sleek design","clean lines","durable construction","versatile decor","interior design","elegant frames","black frames","frame set","wall decoration","memory display","art showcase","picture frames","home styling","artistic display","visual appeal","sophisticated decor","frame collection","stylish frames","decor accents","frame arrangement","photo gallery","art frames","decorative accents","home accents","interior accents"]',
    '{"metaTitle":"Gallery Frame Set - Elegant Matte Black Frames for Art Display","metaDescription":"Transform your space with our Gallery Frame Set. Durable, matte black frames enhance your photos or art. Arrange them creatively for a stylish decor. Shop now!","altText":"Set of 5 elegant gallery frames in matte black, perfect for personalized photo displays and art arrangements.","keywords":["gallery frames","photo display","matte black","modern decor","classic style","home decor","wall art","living room","office decor","hallway decoration","wood frames","glass front","set of frames","minimalist design","custom arrangement","photo frames","art display","decorative frames","sleek design","clean lines","durable construction","versatile decor","interior design","elegant frames","black frames","frame set","wall decoration","memory display","art showcase","picture frames"]}',
    FALSE,
    FALSE,
    4.6,
    134,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'art'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Oversized Canvas Art
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'ART-ART-WALL-009',
    'Oversized Canvas Art',
    'Extra-large abstract canvas in bold blue tones. Statement piece for large walls.',
    395,
    495,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'wall-art' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Vivid Yellow","Deep Teal","Fiery Red"],"material":["Canvas","Acrylic Paint"],"style":["Abstract","Contemporary"],"room":["Living Room","Dining Room","Office"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Vivid Yellow","hex":"#FFD700","category":"primary"},{"name":"Deep Teal","hex":"#008080","category":"secondary"},{"name":"Fiery Red","hex":"#FF4500","category":"accent"}],"pattern":"abstract","texture":"textured","finish":"matte","shape":"rectangular","silhouette":"Bold and dynamic with layered colors"}',
    '{"short":"Elevate your space with vibrant oversized abstract canvas art.","long":"Transform your home with this oversized canvas art, a magnificent addition to any large wall. Its bold abstract design features a vibrant palette dominated by vivid yellow, deep teal, and fiery red, creating an exhilarating visual impact. Perfect for living rooms, dining areas, or offices, this contemporary masterpiece breathes life and energy into any space. The textured surface adds depth and movement, inviting you into its intricate layers, making it a dynamic centerpiece for creative expression.","features":["Oversized format ideal for large walls","Bold abstract design for a modern look","Vibrant color palette including yellow, teal, and red","Textured canvas adds depth","Contemporary style fits various decor themes","Dynamic visual impact","Perfect for living rooms, dining areas, or offices"],"careInstructions":"Dust gently with a soft cloth. Avoid direct sunlight to prevent fading and preserve vibrancy.","materialComposition":"Crafted from high-quality canvas with durable acrylic paint"}',
    '["wall art","canvas","oversized","abstract","blue","abstract art","canvas painting","vibrant colors","large wall art","contemporary design","home decor","living room art","office decoration","modern style","statement piece","artwork","colorful painting","bold design","textured surface","unique art","acrylic paint","interior decoration","creative expression","visual impact","dynamic art","oversized canvas art","contemporary artwork","textured canvas","art & mirrors","exhilarating visual impact","fiery red","deep teal","vivid yellow","high-quality canvas"]',
    '{"metaTitle":"Oversized Canvas Art - Bold Abstract Design for Impact","metaDescription":"Transform your space with oversized canvas art. Bold abstract colors create a dynamic centerpiece. Perfect for living rooms or offices. Shop now!","altText":"Oversized canvas art with bold abstract design featuring vivid yellow, deep teal, and fiery red colors.","keywords":["oversized canvas art","abstract art","bold design","vibrant colors","large wall art","contemporary artwork","home decor","living room art","office decoration","statement piece","modern style","colorful painting","textured canvas","acrylic paint","unique art","creative expression","visual impact","dynamic art","art & mirrors","artwork","interior decoration","exhilarating visual impact","textured surface","fiery red","deep teal","vivid yellow","high-quality canvas"]}',
    TRUE,
    FALSE,
    4.8,
    67,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'art'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- ----------------------------------------------------------------------------
-- Bedding & Textiles (21 products)
-- ----------------------------------------------------------------------------

-- Product: Linen Duvet Set
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'BED-BEDDING-SET-001',
    'Linen Duvet Set',
    'Premium stonewashed linen duvet set in soft white. Includes duvet cover and two pillowcases.',
    285,
    375,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'bedding-set' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Soft White","Ivory"],"material":["Linen"],"style":["Modern","Natural"],"room":["Bedroom","Guest Room"],"occasion":["Everyday","Relaxation"]}',
    '{"primaryColors":[{"name":"Soft White","hex":"#F5F5F5","category":"primary"},{"name":"Ivory","hex":"#FFFFF0","category":"secondary"}],"pattern":"solid","texture":"textured","finish":"matte","shape":"rectangular","silhouette":"Low-profile with clean lines"}',
    '{"short":"Indulge in comfort with our luxurious stonewashed linen duvet set in soft white.","long":"Transform your bedroom into a serene retreat with our Linen Duvet Set. Crafted from 100% stonewashed linen, this elegant set exudes timeless sophistication and ultimate comfort. The soft white hue adds a touch of brightness, while the natural texture offers a cozy, inviting feel. Perfect for modern and minimalist decors, it includes a duvet cover and two matching pillowcases. The breathable linen ensures a restful night''s sleep, keeping you cool in summer and warm in winter. Elevate your bedroom with this versatile and durable set that promises to enhance any interior style.","features":["Luxurious 100% stonewashed linen","Includes duvet cover and two pillowcases","Breathable fabric for year-round comfort","Elegant soft white color complements any decor","Durable and versatile for modern and minimalist styles","Textured finish adds visual interest"],"careInstructions":"Machine wash cold on a gentle cycle. Tumble dry low or hang to dry. Iron on low heat if needed.","materialComposition":"100% stonewashed linen"}',
    '["bedding","linen","duvet","white","natural","duvet set","soft white","stonewashed","modern decor","natural style","breathable","comfortable","luxury bedding","bedroom essentials","guest room","machine washable","easy care","high quality","elegant design","minimalist","neutral tones","textured finish","relaxation","cozy","inviting","stylish","functional","durable","versatile","soft touch","premium material","home decor","bedroom update","interior design","natural fibers","eco-friendly","linen duvet set","stonewashed linen","soft white duvet","breathable bedding","comfortable linen","guest room bedding","machine washable duvet","easy care linen","high quality bedding","elegant duvet design","minimalist bedding","neutral tones duvet","textured finish bedding","cozy duvet set","inviting bedroom decor","stylish linen set","functional bedding","durable linen","versatile duvet","soft touch bedding","premium linen material","eco-friendly bedding"]',
    '{"metaTitle":"Linen Duvet Set - 100% Stonewashed Linen Comfort","metaDescription":"Transform your bedroom with our Linen Duvet Set. Crafted from stonewashed linen for ultimate comfort and style. Shop now for a serene retreat.","altText":"Elegant linen duvet set in soft white with cozy, textured look, includes cover and pillowcases.","keywords":["linen duvet set","stonewashed linen","bedding","soft white duvet","modern decor","natural style","breathable bedding","comfortable linen","luxury bedding","bedroom essentials","guest room bedding","machine washable duvet","easy care linen","high quality bedding","elegant duvet design","minimalist bedding","neutral tones duvet","textured finish bedding","cozy duvet set","inviting bedroom decor","stylish linen set","functional bedding","durable linen","versatile duvet","soft touch bedding","premium linen material","home decor","bedroom update","interior design","natural fibers","eco-friendly bedding"]}',
    TRUE,
    TRUE,
    4.9,
    267,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'bedding'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Cotton Sateen Sheet Set
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'BED-BEDDING-SET-002',
    'Cotton Sateen Sheet Set',
    'Silky smooth 400-thread count cotton sateen sheets. Full set includes fitted, flat, and pillowcases.',
    165,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'bedding-set' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Charcoal Gray"],"material":["Cotton"],"style":["Modern","Classic"],"room":["Bedroom","Guest Room"],"occasion":["Everyday","Special Occasions"]}',
    '{"primaryColors":[{"name":"Charcoal Gray","hex":"#36454F","category":"primary"}],"pattern":"solid","texture":"smooth","finish":"satin","shape":"rectangular","silhouette":"sleek and tailored with clean lines"}',
    '{"short":"Indulge in luxury with our Cotton Sateen Sheet Set, offering a silky touch and supreme comfort.","long":"Transform your bedroom into a luxurious retreat with our Cotton Sateen Sheet Set. Crafted from premium 100% cotton sateen, these sheets boast an impressive 400-thread count, enveloping you in a silky, smooth embrace each night. The set includes a fitted sheet, a flat sheet, and pillowcases, designed to fit seamlessly into both modern and classic decors. Available in a sophisticated charcoal gray, this sheet set not only elevates the aesthetics of your space but also provides breathable comfort, making it perfect for year-round use. Whether you''re preparing for restful slumbers or dressing up the guest room for visitors, this sheet set is the epitome of elegance and functionality.","features":["400-thread count for superior softness","Complete set: fitted sheet, flat sheet, pillowcases","Silky smooth cotton sateen finish","Durable and breathable, ideal for all seasons","Elegant charcoal gray suits various decor styles"],"careInstructions":"Machine wash cold with similar colors. Tumble dry on low. Avoid bleach to preserve color and texture.","materialComposition":"100% Cotton Sateen"}',
    '["bedding","sheets","cotton","sateen","gray","luxury","comfort","bedroom","modern","classic","soft","durable","breathable","high-quality","fitted sheet","flat sheet","pillowcases","machine washable","easy care","home decor","bed linens","guest room","master bedroom","smooth finish","elegant","stylish","premium","silky","tailored","clean lines","versatile","neutral color","cotton sateen sheet set","luxury bedding","400-thread count sheets","charcoal gray sheets","silky smooth bed sheets","breathable cotton sheets","modern bedding","classic bedroom decor","high-quality bed linens","comfortable sheets","premium cotton sheets","elegant bedding","soft sheet set","durable bed sheets","machine washable sheets","tailored bedding","versatile bed linens","neutral color sheets","guest room sheets","master bedroom sheets","satin finish sheets","smooth finish bedding","stylish bed sheets","easy care sheets","home decor sheets","fitted sheet set","flat sheet and pillowcases","silky texture sheets","tailored clean lines bedding"]',
    '{"metaTitle":"Cotton Sateen Sheet Set - Luxurious 400-Thread Count Comfort","metaDescription":"Elevate your bedroom with our Cotton Sateen Sheet Set. Enjoy silky smooth comfort and elegance with a 400-thread count. Shop now for year-round luxury.","altText":"Charcoal gray cotton sateen sheet set with a silky smooth finish and 400-thread count.","keywords":["cotton sateen sheet set","luxury bedding","400-thread count sheets","charcoal gray sheets","silky smooth bed sheets","breathable cotton sheets","modern bedding","classic bedroom decor","high-quality bed linens","comfortable sheets","premium cotton sheets","elegant bedding","soft sheet set","durable bed sheets","machine washable sheets","tailored bedding","versatile bed linens","neutral color sheets","guest room sheets","master bedroom sheets","satin finish sheets","smooth finish bedding","stylish bed sheets","easy care sheets","home decor sheets","fitted sheet set","flat sheet and pillowcases","silky texture sheets","tailored clean lines bedding"]}',
    FALSE,
    TRUE,
    4.7,
    189,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'bedding'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Velvet Duvet Cover
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'BED-BEDDING-SET-004',
    'Velvet Duvet Cover',
    'Luxurious velvet duvet cover in deep navy. Button closure with interior ties.',
    225,
    295,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'bedding-set' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Deep Navy"],"material":["Velvet","Cotton"],"style":["Glamorous","Modern"],"room":["Bedroom"],"occasion":["Everyday","Luxury"]}',
    '{"primaryColors":[{"name":"Deep Navy","hex":"#001F3F","category":"primary"}],"pattern":"solid","texture":"velvet","finish":"matte","shape":"rectangular","silhouette":"Low-profile with clean lines"}',
    '{"short":"Indulge in luxury with our deep navy velvet duvet cover, featuring a chic button closure.","long":"Transform your bedroom into a sanctuary of elegance with our Velvet Duvet Cover in a mesmerizing deep navy hue. Crafted from plush velvet, this cover promises an indulgent touch and a lavish feel against your skin. The button closure, complimented by interior ties, ensures your duvet stays perfectly in place while adding a sophisticated finish to your bedding ensemble. Ideal for modern and glamorous interiors, it’s a statement piece designed to elevate the aesthetic of your space. Whether you''re looking for a cozy retreat or a stylish upgrade, this velvet duvet cover is your go-to for comfort and refinement.","features":["Plush velvet fabric for a luxurious touch","Chic button closure with interior ties for secure fit","Deep navy hue complements modern decor","Matte finish for understated elegance","Designed for glamorous and contemporary spaces","Rectangular shape with low-profile silhouette","Machine washable for easy care"],"careInstructions":"Machine wash cold on a gentle cycle. Tumble dry low or hang to dry. Do not use bleach.","materialComposition":"100% Velvet exterior with cotton lining"}',
    '["bedding","velvet","duvet","navy","luxury","duvet cover","modern","glamorous","bedroom decor","soft texture","plush feel","elegant design","comfortable","high-quality","machine washable","easy care","stylish","interior design","home textiles","bed linen","premium bedding","deep navy","solid color","button closure","cotton lining","matte finish","rectangular shape","low-profile","clean lines","bedroom essentials","textile","decorative","functional","aesthetic","velvet duvet cover","deep navy bedding","luxury duvet cover","modern bedroom decor","glamorous bedding","plush velvet cover","button closure duvet","interior ties duvet","elegant bedroom design","comfortable duvet cover","high-quality bedding","machine washable duvet","easy care duvet cover","stylish duvet cover","solid color duvet","cotton lined duvet","matte finish bedding","rectangular duvet cover","low-profile bedding","clean lines duvet","decorative duvet cover","functional bedding","aesthetic duvet cover"]',
    '{"metaTitle":"Velvet Duvet Cover - Deep Navy Elegance & Comfort","metaDescription":"Elevate your bedroom with our Velvet Duvet Cover in deep navy. Experience luxury with plush velvet and secure button closure. Shop now for style and comfort!","altText":"Deep navy velvet duvet cover with button closure and interior ties, luxurious and elegant bedding.","keywords":["velvet duvet cover","deep navy bedding","luxury duvet cover","modern bedroom decor","glamorous bedding","plush velvet cover","button closure duvet","interior ties duvet","elegant bedroom design","comfortable duvet cover","high-quality bedding","machine washable duvet","easy care duvet cover","stylish duvet cover","home textiles","premium bedding","solid color duvet","cotton lined duvet","matte finish bedding","rectangular duvet cover","low-profile bedding","clean lines duvet","bedroom essentials","decorative duvet cover","functional bedding","aesthetic duvet cover"]}',
    FALSE,
    FALSE,
    4.8,
    78,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'bedding'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Quilted Coverlet Set
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'BED-BEDDING-SET-003',
    'Quilted Coverlet Set',
    'Lightweight quilted coverlet with matching shams in soft sage green.',
    195,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'bedding-set' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Sage Green"],"material":["Cotton","Polyester"],"style":["Traditional","Farmhouse"],"room":["Bedroom","Guest Room"],"occasion":["Everyday","Relaxation"]}',
    '{"primaryColors":[{"name":"Sage Green","hex":"#9CAF88","category":"primary"}],"pattern":"solid","texture":"quilted","finish":"matte","shape":"rectangular","silhouette":"Low-profile with clean lines"}',
    '{"short":"Elegant quilted coverlet set in soothing sage green, perfect for a cozy bedroom.","long":"Transform your bedroom into a tranquil retreat with our Quilted Coverlet Set, elegantly designed in a calming sage green. This lightweight coverlet is crafted with a soft quilted texture, offering both comfort and style. The set comes complete with matching shams, ensuring a harmonious look that fits seamlessly into traditional and farmhouse aesthetics. Made from a durable blend of cotton and polyester, this set promises longevity and easy maintenance. Envelop yourself in its soft embrace, perfect for adding a touch of relaxation and everyday luxury to your master or guest bedroom. Experience the soothing allure of this versatile bedding ensemble, designed to enhance your home''s decor effortlessly.","features":["Lightweight quilted design","Matching shams included","Soft sage green color","Cotton and polyester blend","Suitable for traditional and farmhouse styles","Durable and comfortable","Versatile for master or guest bedrooms"],"careInstructions":"Machine wash cold, gentle cycle. Tumble dry low. Do not bleach.","materialComposition":"70% Cotton, 30% Polyester"}',
    '["bedding","coverlet","quilted","green","farmhouse","sage green","traditional","cotton blend","guest room","bedroom decor","soft texture","lightweight","machine washable","durable","comfortable","cozy","elegant","home textiles","bed linen","bedding set","bedroom style","interior design","home decor","blanket","bedspread","textile","fabric","green bedding","modern farmhouse","classic design","versatile","quilted coverlet set","sage green bedding","elegant bedding","cotton polyester blend","traditional bedroom decor","farmhouse style bedding","lightweight coverlet","matching shams","soft quilted texture","cozy bedroom set","durable bedding set","machine washable coverlet","guest room bedding","master bedroom decor","versatile bedding"]',
    '{"metaTitle":"Quilted Coverlet Set - Elegant Sage Green Comfort","metaDescription":"Transform your bedroom with our Quilted Coverlet Set in sage green. Enjoy comfort and style with matching shams. Order now for cozy elegance!","altText":"Elegant quilted coverlet set in soothing sage green with matching shams.","keywords":["quilted coverlet set","sage green bedding","elegant bedding","cotton polyester blend","traditional bedroom decor","farmhouse style bedding","lightweight coverlet","matching shams","soft quilted texture","cozy bedroom set","durable bedding set","machine washable coverlet","guest room bedding","master bedroom decor","home textiles","bed linen","bedroom style","interior design","home decor","blanket","bedspread","textile","fabric","green bedding","modern farmhouse","classic design","versatile bedding"]}',
    TRUE,
    FALSE,
    4.6,
    112,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'bedding'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Organic Cotton Bundle
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'BED-BEDDING-SET-005',
    'Organic Cotton Bundle',
    'GOTS certified organic cotton bedding bundle. Chemical-free and sustainable.',
    245,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'bedding-set' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Cream","Sage Green"],"material":["Organic Cotton"],"style":["Natural","Minimalist"],"room":["Bedroom","Guest Room"],"occasion":["Everyday","Relaxation"]}',
    '{"primaryColors":[{"name":"Cream","hex":"#FFFDD0","category":"primary"},{"name":"Sage Green","hex":"#9CAF88","category":"accent"}],"pattern":"solid","texture":"smooth","finish":"matte","shape":"rectangular","silhouette":"Low-profile with clean lines"}',
    '{"short":"Luxurious organic cotton bedding set in soothing natural tones.","long":"Elevate your sleep sanctuary with our Organic Cotton Bundle, a harmonious blend of comfort and sustainability. This exquisite bedding set, priced at $245, features a soft, cream-colored duvet cover and pillowcases that caress your skin with gentle warmth, complemented by a sage green throw blanket that adds a refreshing splash of color. Crafted from 100% GOTS certified organic cotton, this bundle is a haven for those seeking a chemical-free, eco-conscious lifestyle. Its minimalist design and serene hues create an oasis of tranquility, inviting relaxation and restorative sleep. Perfect for both bedrooms and guest rooms, this bundle promises to transform any space into a peaceful retreat.","features":["GOTS certified organic cotton for eco-friendly luxury","Chemical-free production for safe and healthy sleep","Includes duvet cover, pillowcases, and sage green throw blanket","Minimalist design in soothing natural tones","Soft, breathable fabric enhancing comfort"],"careInstructions":"Machine wash cold with like colors. Tumble dry low or hang to dry. Avoid bleach to maintain fabric integrity.","materialComposition":"100% GOTS certified organic cotton"}',
    '["bedding","organic","cotton","sustainable","natural","minimalist","eco-friendly","GOTS certified","cream","sage green","bedroom","guest room","soft","breathable","chemical-free","luxury","comfort","relaxation","sleep","home decor","interior design","textiles","bedding set","duvet cover","pillowcases","throw blanket","machine washable","easy care","environmentally friendly","natural fibers","clean lines","calming","Organic Cotton Bundle","eco-friendly bedding","GOTS certified bedding","sustainable bedding set","natural cotton bedding","minimalist bedding design","cream duvet cover","sage green throw blanket","chemical-free bedding","luxurious sleep set","breathable cotton bedding","soft cotton duvet","eco-conscious bedroom decor","organic bedding set","natural fibers bedding","machine washable bedding","easy care bedding set","environmentally friendly textiles","calming bedroom decor","luxury bedding","home decor bedding","interior design textiles","relaxation bedding","comfortable sleep set","bedroom transformation","guest room bedding","serene bedding colors","GOTS certified cotton"]',
    '{"metaTitle":"Organic Cotton Bundle: Luxurious, Eco-Friendly Bedding","metaDescription":"Transform your bedroom with our Organic Cotton Bundle. Enjoy sustainable luxury and comfort. Shop now for a serene, eco-friendly sleep experience.","altText":"Organic Cotton Bundle featuring cream duvet cover and sage green throw blanket.","keywords":["Organic Cotton Bundle","eco-friendly bedding","GOTS certified bedding","sustainable bedding set","natural cotton bedding","minimalist bedding design","cream duvet cover","sage green throw blanket","chemical-free bedding","luxurious sleep set","breathable cotton bedding","soft cotton duvet","eco-conscious bedroom decor","organic bedding set","natural fibers bedding","machine washable bedding","easy care bedding set","environmentally friendly textiles","calming bedroom decor","luxury bedding","home decor bedding","interior design textiles","relaxation bedding","comfortable sleep set","bedroom transformation","guest room bedding","serene bedding colors","GOTS certified cotton"]}',
    TRUE,
    FALSE,
    4.9,
    145,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'bedding'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Percale Sheet Set
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'BED-BEDDING-SET-006',
    'Percale Sheet Set',
    'Crisp percale weave sheets in classic white. Cool and breathable.',
    145,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'bedding-set' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Soft White"],"material":["Cotton"],"style":["Classic","Hotel"],"room":["Bedroom","Guest Room"],"occasion":["Everyday","Special Occasions"]}',
    '{"primaryColors":[{"name":"Soft White","hex":"#F5F5F5","category":"primary"}],"pattern":"embroidered","texture":"smooth","finish":"matte","shape":"rectangular","silhouette":"Low-profile with clean lines"}',
    '{"short":"Experience luxury with our soft, breathable Percale Sheet Set, featuring intricate embroidery and a crisp, cool feel.","long":"Transform your bedroom into a serene retreat with our Percale Sheet Set. Crafted from 100% high-quality cotton, these sheets boast a crisp percale weave that feels cool and refreshing against the skin, perfect for warm nights. The elegant soft white hue is adorned with intricate embroidery, adding a touch of sophistication and timelessness to your decor. Whether you''re furnishing a master suite or a guest room, this set promises a restful sleep enveloped in luxury. Easy to care for and designed for durability, these sheets maintain their pristine look and feel wash after wash, ensuring your comfort is uninterrupted.","features":["100% high-quality cotton for breathability","Crisp percale weave for a cool, refreshing feel","Intricate embroidery for added elegance","Soft white hue to complement any decor","Durable and easy to care for"],"careInstructions":"Machine wash cold with like colors. Tumble dry low. Iron on low heat if needed to maintain the embroidery detail.","materialComposition":"100% Cotton"}',
    '["bedding","percale","sheets","white","crisp","embroidered","cotton","luxury","hotel","classic","elegant","comfortable","breathable","soft","bedroom","guest room","high-quality","machine washable","cool","refined","decor","sleep","home","textiles","bed linen","bed set","sheet set","matte finish","smooth texture","rectangular shape","low-profile design","percale sheet set","crisp cotton sheets","embroidered sheets","luxury bed linen","cool sheets","breathable cotton","elegant bedding","hotel style sheets","classic white sheets","high-quality cotton sheets","machine washable sheets","soft white percale","comfortable bed sheets","bedroom decor","guest room sheets","cooling sheets","sophisticated bedding","durable sheets","easy care sheets","cotton percale sheets","luxury sleep","refined bedroom","soft texture sheets","matte finish bedding","rectangular sheet set","low-profile design sheets"]',
    '{"metaTitle":"Percale Sheet Set - Cool, Crisp Cotton with Embroidery","metaDescription":"Elevate your bedroom with our Percale Sheet Set. Enjoy cool, crisp comfort with intricate embroidery. Order now for luxury sleep!","altText":"Elegant percale sheet set with intricate embroidery in soft white.","keywords":["percale sheet set","bedding","crisp cotton sheets","embroidered sheets","luxury bed linen","cool sheets","breathable cotton","elegant bedding","hotel style sheets","classic white sheets","high-quality cotton sheets","machine washable sheets","soft white percale","comfortable bed sheets","bedroom decor","guest room sheets","cooling sheets","sophisticated bedding","durable sheets","easy care sheets","cotton percale sheets","luxury sleep","refined bedroom","soft texture sheets","matte finish bedding","rectangular sheet set","low-profile design sheets"]}',
    FALSE,
    TRUE,
    4.6,
    234,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'bedding'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Velvet Thermal Curtains
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'BED-CURTAIN-002',
    'Velvet Thermal Curtains',
    'Plush velvet curtains with thermal backing. Insulating and sound-dampening.',
    165,
    215,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'curtain' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Emerald Green"],"material":["Velvet","Polyester"],"style":["Glamorous","Traditional"],"room":["Living Room","Bedroom","Dining Room"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Emerald Green","hex":"#50C878","category":"primary"}],"pattern":"solid","texture":"velvet","finish":"matte","shape":"rectangular","silhouette":"Floor-length with a flowing drape"}',
    '{"short":"Luxurious emerald green velvet curtains with thermal backing for insulation.","long":"Transform your living space with these opulent Velvet Thermal Curtains in a captivating emerald green. The sumptuous velvet fabric adds a touch of glamour, while the thermal backing ensures superior insulation, keeping your home cozy and energy-efficient. These curtains not only enhance your decor with their rich, vibrant color but also offer sound-dampening qualities, creating a serene environment. Ideal for living rooms, bedrooms, or dining areas, they bring a blend of luxury and practicality to any setting. The floor-length design with a flowing drape exudes elegance, making these curtains a perfect choice for those who appreciate both style and function.","features":["Emerald green velvet fabric","Thermal backing for insulation","Sound-dampening properties","Luxurious and glamorous style","Suitable for multiple rooms","Floor-length with a flowing drape","Energy-efficient design"],"careInstructions":"Dry clean recommended to maintain fabric quality and thermal properties.","materialComposition":"Velvet front with polyester thermal backing."}',
    '["curtains","velvet","thermal","green","luxury","insulation","soundproof","home decor","living room","bedroom","dining room","elegant","plush","cozy","traditional","glamorous","window treatment","interior design","energy efficient","privacy","decorative","rich color","high quality","floor-length","matte finish","solid pattern","easy care","dry clean","thermal curtains","emerald green","velvet curtains","emerald green curtains","luxury curtains","insulation curtains","soundproof curtains","living room curtains","bedroom curtains","dining room curtains","elegant curtains","plush curtains","cozy curtains","traditional curtains","glamorous curtains","energy efficient curtains","privacy curtains","decorative curtains","rich color curtains","high quality curtains","floor-length curtains","matte finish curtains","solid pattern curtains","easy care curtains","dry clean curtains"]',
    '{"metaTitle":"Velvet Thermal Curtains - Emerald Green for Cozy Elegance","metaDescription":"Upgrade your home with luxurious Velvet Thermal Curtains in emerald green. Enjoy superior insulation and sound-dampening. Shop now for style and comfort!","altText":"Emerald green velvet thermal curtains offering insulation and sound-dampening properties.","keywords":["velvet curtains","thermal curtains","emerald green curtains","luxury curtains","insulation curtains","soundproof curtains","home decor","living room curtains","bedroom curtains","dining room curtains","elegant curtains","plush curtains","cozy curtains","traditional curtains","glamorous curtains","window treatment","interior design","energy efficient curtains","privacy curtains","decorative curtains","rich color curtains","high quality curtains","floor-length curtains","matte finish curtains","solid pattern curtains","easy care curtains","dry clean curtains"]}',
    FALSE,
    FALSE,
    4.7,
    134,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'bedding'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Linen Blackout Curtains
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'BED-CURTAIN-001',
    'Linen Blackout Curtains',
    'Natural linen curtains with blackout lining. Room darkening with elegant drape.',
    185,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'curtain' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Sage Green"],"material":["Linen"],"style":["Natural","Modern"],"room":["Living Room","Bedroom"],"occasion":["Everyday","Relaxation"]}',
    '{"primaryColors":[{"name":"Sage Green","hex":"#9CAF88","category":"primary"}],"pattern":"solid","texture":"linen","finish":"matte","shape":"rectangular","silhouette":"Full-length with elegant drape"}',
    '{"short":"Elevate your space with luxurious sage green linen blackout curtains.","long":"Transform your living room or bedroom into a serene retreat with our Linen Blackout Curtains in a calming sage green. Crafted from premium linen, these curtains offer an elegant matte finish and a soft, natural texture that complements any modern or natural decor. The full-length design provides an elegant drape, creating an inviting ambiance while ensuring complete privacy and light blocking with their efficient blackout lining. Ideal for creating a cozy, energy-efficient environment, these curtains not only enhance your space aesthetically but also offer practical benefits. Enjoy a peaceful night''s sleep or a relaxing afternoon, shielded from the outside world.","features":["Sage green color palette","Effective blackout lining","Soft, elegant drape","Natural linen texture","Energy-efficient and light-blocking","Suitable for various decor styles","Ideal for bedrooms and living rooms"],"careInstructions":"Machine wash cold on a gentle cycle. Avoid bleach. Tumble dry low and iron on low heat if necessary.","materialComposition":"Crafted from 100% premium linen with a blackout lining for optimal room darkening."}',
    '["curtains","linen","blackout","natural","drapes","sage green","room darkening","elegant","modern","living room","bedroom","home decor","window treatment","soft drape","light blocking","privacy","energy efficient","machine washable","easy care","stylish","sophisticated","serene","inviting","full-length","matte finish","solid color","textured","versatile","decorative","functional","linen blackout curtains","sage green curtains","room darkening drapes","elegant window treatment","modern linen curtains","natural decor curtains","energy efficient curtains","privacy curtains","blackout lining curtains","soft drape curtains","full-length curtains","matte finish curtains","solid color curtains","textured curtains","living room curtains","bedroom curtains","home decor curtains","machine washable curtains","easy care curtains","stylish curtains","sophisticated curtains","serene atmosphere curtains","inviting ambiance curtains","versatile curtains","decorative curtains","functional curtains"]',
    '{"metaTitle":"Linen Blackout Curtains - Sage Green Elegance & Privacy","metaDescription":"Transform your space with our Linen Blackout Curtains in sage green. Enjoy privacy and style with energy-efficient, elegant drapes. Shop now!","altText":"Elegant sage green linen blackout curtains with a soft drape for complete privacy and style.","keywords":["linen blackout curtains","sage green curtains","room darkening drapes","elegant window treatment","modern linen curtains","natural decor curtains","energy efficient curtains","privacy curtains","blackout lining curtains","soft drape curtains","full-length curtains","matte finish curtains","solid color curtains","textured curtains","living room curtains","bedroom curtains","home decor curtains","machine washable curtains","easy care curtains","stylish curtains","sophisticated curtains","serene atmosphere curtains","inviting ambiance curtains","versatile curtains","decorative curtains","functional curtains"]}',
    TRUE,
    TRUE,
    4.8,
    198,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'bedding'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Cotton Grommet Curtains
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'BED-CURTAIN-003',
    'Cotton Grommet Curtains',
    'Classic cotton curtains with brushed nickel grommets. Easy to hang with clean, modern lines.',
    125,
    165,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'curtain' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Light Gray","Brushed Nickel"],"material":["Cotton","Metal"],"style":["Modern","Contemporary"],"room":["Living Room","Bedroom","Office"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Light Gray","hex":"#D3D3D3","category":"primary"},{"name":"Brushed Nickel","hex":"#A9A9A9","category":"accent"}],"pattern":"solid","texture":"smooth","finish":"matte","shape":"rectangular","silhouette":"Full-length with clean lines"}',
    '{"short":"Elegant gray cotton curtains with brushed nickel grommets for a modern touch.","long":"Elevate your living space with our Cotton Grommet Curtains, designed to blend sophistication with functionality. These full-length curtains boast a refined light gray hue that seamlessly complements any decor. The brushed nickel grommets not only add a contemporary flair but also ensure hassle-free installation. Crafted from 100% premium cotton, these curtains offer a soft, smooth texture while maintaining durability. Perfect for your living room, bedroom, or office, they provide the ideal balance of privacy and natural light, creating an inviting and serene atmosphere. Whether you''re hosting guests or relaxing at home, these curtains are a chic addition to your space.","features":["Elegant light gray color","Brushed nickel grommets for easy hanging","Full-length design","Soft and durable 100% cotton","Modern and contemporary style","Enhances privacy while allowing natural light","Machine washable for easy care"],"careInstructions":"Machine wash cold on a gentle cycle. Tumble dry low or hang to dry. Iron on low heat if necessary.","materialComposition":"100% Cotton"}',
    '["curtains","cotton","grommet","gray","modern","contemporary","living room","bedroom","office","home decor","window treatment","easy installation","privacy","light filtering","elegant","durable","machine washable","brushed nickel","soft texture","matte finish","solid pattern","rectangular shape","full-length","cotton grommet curtains","gray curtains","modern window treatment","elegant curtains","living room curtains","bedroom curtains","office curtains","home decor curtains","easy installation curtains","privacy curtains","light filtering curtains","contemporary curtains","durable cotton curtains","machine washable curtains","brushed nickel grommets","soft texture curtains","matte finish curtains","solid pattern curtains","full-length curtains","rectangular curtains","modern home decor","chic window treatment","elegant home upgrade","premium cotton curtains","light gray curtains","grommet top curtains","soft cotton texture","refined curtains","sophisticated curtains"]',
    '{"metaTitle":"Cotton Grommet Curtains - Elegant Light Gray Design","metaDescription":"Enhance your home with Cotton Grommet Curtains. Easy to install, these elegant gray curtains offer privacy and style. Shop now for a chic upgrade!","altText":"Elegant light gray cotton curtains with brushed nickel grommets, perfect for modern spaces.","keywords":["cotton grommet curtains","gray curtains","modern window treatment","elegant curtains","living room curtains","bedroom curtains","office curtains","home decor curtains","easy installation curtains","privacy curtains","light filtering curtains","contemporary curtains","durable cotton curtains","machine washable curtains","brushed nickel grommets","soft texture curtains","matte finish curtains","solid pattern curtains","full-length curtains","rectangular curtains","modern home decor","chic window treatment","elegant home upgrade","premium cotton curtains","light gray curtains","grommet top curtains","soft cotton texture","refined curtains","sophisticated curtains"]}',
    FALSE,
    TRUE,
    4.6,
    234,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'bedding'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Sheer Voile Panels
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'BED-CURTAIN-004',
    'Sheer Voile Panels',
    'Lightweight sheer voile panels in pure white. Filter light beautifully.',
    65,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'curtain' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Warm Beige","Pure White"],"material":["Polyester"],"style":["Classic","Romantic"],"room":["Living Room","Bedroom","Dining Room"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Warm Beige","hex":"#D3B8A3","category":"primary"},{"name":"Pure White","hex":"#FFFFFF","category":"accent"}],"pattern":"solid","texture":"smooth","finish":"matte","shape":"rectangular","silhouette":"Floor-length with soft folds"}',
    '{"short":"Elegant sheer voile panels in warm neutral tones, perfect for softening light.","long":"Transform your space with our exquisite Sheer Voile Panels, designed to impart a touch of elegance and serenity to any room. These panels, crafted from lightweight 100% polyester, offer an inviting ambiance with their warm neutral tones that beautifully filter natural light. The airy texture and graceful drape create a soft, romantic feel, ideal for living rooms, bedrooms, and dining areas. The sheer fabric allows for a gentle diffusion of sunlight, enhancing the aesthetic of your home while maintaining privacy. With their versatile design, these panels effortlessly complement any interior style, adding a classic charm and sophistication that is timeless.","features":["Lightweight sheer fabric","Warm neutral tones","Elegant drape with soft folds","Light-filtering design","Versatile for living rooms, bedrooms, dining rooms","Classic and romantic style","Smooth, matte finish"],"careInstructions":"Machine wash cold, gentle cycle. Tumble dry low. Iron on low heat if needed.","materialComposition":"100% Polyester"}',
    '["curtains","sheer","voile","white","light","beige","light-filtering","elegant","classic","romantic","polyester","living room","bedroom","dining room","neutral tones","home decor","window treatment","soft light","airy","floor-length","machine washable","easy care","modern","versatile","matte finish","smooth texture","solid pattern","warm beige","pure white","soft folds","sheer voile panels","elegant curtains","light-filtering curtains","neutral tone curtains","polyester curtains","living room curtains","bedroom curtains","dining room curtains","soft light curtains","airy curtains","floor-length curtains","machine washable curtains","classic style curtains","romantic curtains","modern curtains","versatile curtains","matte finish curtains","smooth texture curtains","solid pattern curtains","warm beige curtains","pure white curtains","soft folds curtains","elegant home decor","lightweight curtains"]',
    '{"metaTitle":"Sheer Voile Panels - Elegant Light-Filtering Curtains","metaDescription":"Elevate your home decor with our Sheer Voile Panels. Crafted from lightweight polyester, they softly filter light. Shop now for elegance and style!","altText":"Elegant sheer voile panels in warm neutral tones, filtering light in a living room.","keywords":["sheer voile panels","elegant curtains","light-filtering curtains","neutral tone curtains","polyester curtains","living room curtains","bedroom curtains","dining room curtains","home decor","window treatment","soft light curtains","airy curtains","floor-length curtains","machine washable curtains","classic style curtains","romantic curtains","modern curtains","versatile curtains","matte finish curtains","smooth texture curtains","solid pattern curtains","warm beige curtains","pure white curtains","soft folds curtains","elegant home decor","lightweight curtains"]}',
    FALSE,
    FALSE,
    4.5,
    178,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'bedding'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Patterned Jacquard Curtains
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'BED-CURTAIN-005',
    'Patterned Jacquard Curtains',
    'Elegant jacquard weave curtains with subtle geometric pattern.',
    155,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'curtain' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Warm Gold","Cream"],"material":["Polyester","Cotton"],"style":["Traditional","Glamorous"],"room":["Living Room","Dining Room","Bedroom"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Warm Gold","hex":"#D4AF37","category":"primary"},{"name":"Cream","hex":"#FFFDD0","category":"secondary"}],"pattern":"geometric","texture":"textured","finish":"matte","shape":"rectangular","silhouette":"Floor-length with elegant drape"}',
    '{"short":"Elegant jacquard curtains with a subtle geometric pattern in warm tones.","long":"Transform your space with our Patterned Jacquard Curtains, featuring a sophisticated geometric design that exudes elegance. The warm gold and cream hues harmonize beautifully, creating a cozy ambiance that invites relaxation. Crafted from a high-quality polyester and cotton blend, these curtains are not only durable but also luxuriously soft to the touch. Perfectly suited for living rooms, dining rooms, or bedrooms, they offer both style and functionality, enhancing privacy and light control. The traditional yet glamorous style effortlessly complements a variety of interior designs, making them a versatile addition to your home decor. Experience the refined charm they bring to your windows, creating a stunning focal point in any room.","features":["Elegant jacquard weave","Sophisticated geometric pattern","Warm gold and cream hues","Durable polyester-cotton blend","Enhances privacy and light control","Versatile for multiple rooms","Luxurious feel and appearance"],"careInstructions":"Machine wash cold, gentle cycle. Tumble dry low or hang to dry. Iron on low heat if needed.","materialComposition":"70% Polyester, 30% Cotton"}',
    '["curtains","jacquard","patterned","gold","elegant","geometric","traditional","glamorous","living room","bedroom","dining room","home decor","window treatment","luxury","privacy","light control","polyester","cotton","warm tones","floor-length","textured","matte finish","machine washable","durable","versatile","sophisticated","cozy ambiance","patterned jacquard curtains","elegant curtains","geometric design curtains","gold and cream curtains","living room curtains","bedroom curtains","dining room curtains","home decor curtains","luxury curtains","privacy curtains","light control curtains","polyester curtains","cotton curtains","warm tone curtains","floor-length curtains","textured curtains","matte finish curtains","machine washable curtains","durable curtains","versatile curtains","sophisticated curtains","cozy ambiance curtains","traditional style curtains","glamorous style curtains","high-quality curtains","jacquard weave curtains","subtle geometric pattern"]',
    '{"metaTitle":"Patterned Jacquard Curtains - Elegant Geometric Design","metaDescription":"Enhance your home with our Patterned Jacquard Curtains. Luxurious and durable with a geometric design. Perfect for any room. Shop now for elegance!","altText":"Elegant jacquard curtains with geometric pattern in gold and cream hues.","keywords":["patterned jacquard curtains","elegant curtains","geometric design curtains","gold and cream curtains","living room curtains","bedroom curtains","dining room curtains","home decor curtains","window treatment","luxury curtains","privacy curtains","light control curtains","polyester curtains","cotton curtains","warm tone curtains","floor-length curtains","textured curtains","matte finish curtains","machine washable curtains","durable curtains","versatile curtains","sophisticated curtains","cozy ambiance curtains","traditional style curtains","glamorous style curtains","high-quality curtains","jacquard weave curtains","subtle geometric pattern"]}',
    TRUE,
    FALSE,
    4.7,
    89,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'bedding'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Boho Tassel Curtains
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'BED-CURTAIN-006',
    'Boho Tassel Curtains',
    'Cotton curtains with hand-knotted tassel trim. Bohemian charm.',
    135,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'curtain' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Cream"],"material":["Cotton"],"style":["Bohemian","Coastal"],"room":["Bedroom","Living Room","Nursery"],"occasion":["Everyday","Relaxation"]}',
    '{"primaryColors":[{"name":"Cream","hex":"#F5F5DC","category":"primary"}],"pattern":"solid","texture":"smooth","finish":"matte","shape":"rectangular","silhouette":"Full-length with tassel accents"}',
    '{"short":"Elevate your space with elegant Boho Tassel Curtains, featuring creamy tones and playful tassels.","long":"Transform your room into a serene sanctuary with our Boho Tassel Curtains. Crafted from 100% soft, natural cotton, these curtains offer a blend of bohemian flair and timeless elegance. The hand-knotted tassels add a charming touch, while the creamy hue harmonizes with a variety of decor styles, from coastal to contemporary. Designed to softly diffuse light, these curtains create an inviting ambiance while maintaining privacy. Perfect for bedrooms, living rooms, or nurseries, they are a versatile addition to any home. Let these curtains be the finishing touch that ties your room together, offering both style and substance.","features":["Elegant hand-knotted tassel details","Made from 100% natural cotton","Cream color complements multiple styles","Light-filtering for a cozy atmosphere","Bohemian chic and coastal-inspired design","Versatile use in various rooms"],"careInstructions":"Machine wash cold on a gentle cycle. Tumble dry on low heat. Iron on low setting if needed.","materialComposition":"100% Cotton"}',
    '["curtains","tassel","boho","cream","bohemian","cotton","natural","light-filtering","bedroom","living room","nursery","home decor","window treatment","soft","elegant","versatile","coastal","hand-knotted","textiles","bedding","matte finish","solid pattern","smooth texture","boho tassel curtains","bohemian curtains","cotton curtains","light-filtering curtains","cream curtains","natural cotton curtains","hand-knotted tassel curtains","elegant curtains","bohemian home decor","coastal style curtains","bedroom curtains","living room curtains","nursery curtains","soft cotton curtains","versatile curtains","matte finish curtains","solid pattern curtains","smooth texture curtains","home textiles","boho style curtains","decorative curtains","privacy curtains","serene sanctuary curtains","charming tassel curtains","boho chic curtains","soft light curtains","elegant home decor"]',
    '{"metaTitle":"Boho Tassel Curtains - Soft Cotton, Light-Filtering Elegance","metaDescription":"Elevate your space with Boho Tassel Curtains. Crafted from 100% cotton, these elegant curtains offer bohemian charm and light-filtering privacy. Shop now!","altText":"Elegant cream Boho Tassel Curtains with hand-knotted tassels, made from soft cotton.","keywords":["boho tassel curtains","bohemian curtains","cotton curtains","light-filtering curtains","cream curtains","natural cotton curtains","hand-knotted tassel curtains","elegant curtains","bohemian home decor","coastal style curtains","bedroom curtains","living room curtains","nursery curtains","window treatment","soft cotton curtains","versatile curtains","matte finish curtains","solid pattern curtains","smooth texture curtains","home textiles","boho style curtains","decorative curtains","privacy curtains","serene sanctuary curtains","charming tassel curtains","boho chic curtains","soft light curtains","elegant home decor"]}',
    FALSE,
    FALSE,
    4.8,
    67,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'bedding'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Room Darkening Drapes
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'BED-CURTAIN-007',
    'Room Darkening Drapes',
    'Triple-weave room darkening drapes in charcoal. Maximum light blocking.',
    145,
    185,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'curtain' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Soft Beige"],"material":["Polyester"],"style":["Modern","Contemporary"],"room":["Bedroom","Media Room","Office"],"occasion":["Everyday","Privacy Enhancement"]}',
    '{"primaryColors":[{"name":"Soft Beige","hex":"#D3C6B6","category":"primary"}],"pattern":"solid","texture":"smooth","finish":"matte","shape":"rectangular","silhouette":"Floor-length with elegant pleats"}',
    '{"short":"Elegant room darkening drapes in soft beige to elevate modern interiors.","long":"Transform your space with these elegant room darkening drapes, designed in a timeless soft beige that seamlessly complements modern interiors. Crafted from premium polyester, these drapes promise superior light blocking, offering you the privacy and tranquility you crave. Their smooth texture combined with a chic pleated design adds a touch of sophistication, making them perfect for bedrooms, offices, or media rooms. These versatile drapes not only enhance your decor but also provide practical benefits, blending style with functionality effortlessly.","features":["Superior room darkening capabilities","Chic pleated design for added elegance","Soft beige hue complements various decors","Crafted from premium polyester","Ideal for modern and contemporary spaces","Smooth, matte finish","Floor-length for full coverage"],"careInstructions":"Machine wash cold on gentle cycle. Avoid bleach. Tumble dry on low and iron on low heat if necessary.","materialComposition":"100% Polyester"}',
    '["curtains","blackout","room darkening","charcoal","drapes","beige curtains","modern decor","privacy curtains","light blocking","polyester drapes","contemporary style","bedroom curtains","office drapes","media room curtains","elegant pleats","machine washable","easy care","soft texture","matte finish","solid pattern","floor-length curtains","room darkening drapes","light blocking drapes","contemporary style curtains","machine washable drapes","easy care curtains","soft texture drapes","matte finish curtains","solid pattern drapes","high-quality polyester","smooth texture drapes","chic pleated design","privacy enhancement","modern interiors","versatile drapes","functional drapes","timeless beige drapes","premium drapes"]',
    '{"metaTitle":"Room Darkening Drapes - Elegant Beige for Modern Interiors","metaDescription":"Transform your space with elegant room darkening drapes. Enjoy privacy and style with premium polyester, perfect for bedrooms and offices. Shop now!","altText":"Elegant room darkening drapes in soft beige, featuring pleated design for modern interiors.","keywords":["room darkening drapes","beige curtains","modern decor","privacy curtains","light blocking drapes","polyester drapes","contemporary style curtains","bedroom curtains","office drapes","media room curtains","elegant pleats","machine washable drapes","easy care curtains","soft texture drapes","matte finish curtains","solid pattern drapes","floor-length curtains","high-quality polyester","smooth texture drapes","chic pleated design","privacy enhancement","modern interiors","versatile drapes","functional drapes","timeless beige drapes","premium drapes"]}',
    FALSE,
    TRUE,
    4.6,
    156,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'bedding'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Stripe Linen Curtains
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'BED-CURTAIN-008',
    'Stripe Linen Curtains',
    'Classic striped linen curtains in navy and white. Coastal elegance.',
    175,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'curtain' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Warm Beige"],"material":["Linen"],"style":["Coastal","Classic"],"room":["Living Room","Bedroom","Dining Room"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Warm Beige","hex":"#D3B8A3","category":"primary"}],"pattern":"solid","texture":"textured","finish":"matte","shape":"rectangular","silhouette":"Full-length with a flowing drape"}',
    '{"short":"Elevate your space with our Stripe Linen Curtains, offering warmth and elegance in a stunning beige tone.","long":"Transform your home with the sophisticated charm of our Stripe Linen Curtains. These luxurious curtains, crafted from 100% linen, boast a warm beige hue that enhances the natural light in any room, creating an inviting and serene atmosphere. The subtle stripe pattern adds a touch of modern elegance, while the full-length design ensures optimal privacy and light control. Perfect for living rooms, bedrooms, or dining spaces, these curtains not only serve as a beautiful window treatment but also as a statement piece that complements a variety of decor styles. Let the flowing drape and textured fabric bring a timeless and cozy allure to your home.","features":["Warm beige with subtle stripe pattern","100% linen for a natural look","Full-length for enhanced privacy","Optimal light control","Versatile for any room","Textured fabric for depth","Elegant and timeless design"],"careInstructions":"Machine wash cold on a gentle cycle. Tumble dry low. Iron on low heat as needed to maintain the fabric''s texture.","materialComposition":"100% Linen"}',
    '["curtains","striped","linen","navy","coastal","beige","textured","classic","living room","bedroom","dining room","elegant","natural","warm","full-length","light control","privacy","home decor","window treatment","cozy","sophisticated","inviting","Stripe Linen Curtains","beige linen curtains","elegant window treatment","full-length curtains","curtains for living room","curtains for bedroom","curtains for dining room","linen home decor","coastal style curtains","classic style curtains","textured fabric curtains","light control curtains","privacy curtains","modern elegant curtains","sophisticated home decor","warm tone curtains","inviting home ambiance","natural light enhancement","luxurious linen curtains","curtains with flowing drape","beige home accessories","curtains for cozy spaces","machine washable curtains","100% linen curtains","home decor curtains","statement piece curtains"]',
    '{"metaTitle":"Stripe Linen Curtains - Elegant Full-Length Privacy Solution","metaDescription":"Enhance your home with Stripe Linen Curtains. Enjoy modern elegance with optimal privacy. Shop now for a cozy and sophisticated touch!","altText":"Warm beige Stripe Linen Curtains with a textured weave, full-length design for light control.","keywords":["Stripe Linen Curtains","beige linen curtains","elegant window treatment","full-length curtains","curtains for living room","curtains for bedroom","curtains for dining room","linen home decor","coastal style curtains","classic style curtains","textured fabric curtains","light control curtains","privacy curtains","modern elegant curtains","sophisticated home decor","warm tone curtains","inviting home ambiance","natural light enhancement","luxurious linen curtains","curtains with flowing drape","beige home accessories","curtains for cozy spaces","machine washable curtains","100% linen curtains","home decor curtains","statement piece curtains"]}',
    TRUE,
    FALSE,
    4.7,
    112,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'bedding'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Chunky Knit Throw
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'BED-BLANKET-001',
    'Chunky Knit Throw',
    'Hand-knitted chunky wool throw in soft cream. Cozy and textural.',
    125,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'throw-blanket' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Soft Cream"],"material":["Wool"],"style":["Cozy","Modern"],"room":["Living Room","Bedroom"],"occasion":["Everyday","Relaxing"]}',
    '{"primaryColors":[{"name":"Soft Cream","hex":"#F5F5DC","category":"primary"}],"pattern":"solid","texture":"chunky knit","finish":"natural","shape":"rectangular","silhouette":"Plush and voluminous with thick knit strands"}',
    '{"short":"Luxurious chunky knit throw in soft cream for ultimate coziness.","long":"Embrace the warmth and style with our Chunky Knit Throw, a masterpiece hand-knitted from premium wool in a soothing soft cream shade. This plush throw invites you to experience its sumptuous texture, draping elegantly over your favorite chair or sofa, transforming any room into a cozy sanctuary. The chunky knit design not only provides exceptional warmth but also adds a modern touch to your decor. Perfect for snuggling during chilly evenings, its timeless appeal and versatile color effortlessly complement any interior style, making it a must-have addition to your living room or bedroom.","features":["Hand-knitted for unique texture","Soft cream color for versatile styling","Made from high-quality wool","Chunky knit design for added warmth","Perfect for living room or bedroom decor","Plush and voluminous with thick knit strands","Enhances home decor with cozy aesthetic"],"careInstructions":"Spot clean with mild detergent and cold water. Lay flat to dry. Avoid machine washing to maintain texture.","materialComposition":"100% Wool"}',
    '["blanket","throw","chunky knit","cream","wool","cozy","modern","handmade","soft","warm","decor","living room","bedroom","luxury","plush","comfort","textural","knitted","home","accessory","gift","neutral","elegant","stylish","interior","design","snug","relaxation","quality","natural","versatile","decorative","premium","chunky knit throw","soft cream throw","hand-knitted blanket","wool throw","cozy bedding","modern decor throw","luxury knit throw","plush wool blanket","living room throw","bedroom decor","warm knit blanket","elegant throw","interior design accessory","soft wool throw","neutral color throw","stylish home accessory","premium knit throw","decorative blanket","versatile home decor","quality wool throw","natural fiber throw","plush and cozy throw","snug wool blanket","textural knit throw","handmade wool throw","gift throw blanket","elegant home decor","cream color throw","relaxation blanket","chunky knit design"]',
    '{"metaTitle":"Chunky Knit Throw - Soft Cream, Hand-Knitted Luxury","metaDescription":"Snuggle up in style with our Chunky Knit Throw. Hand-knitted in soft cream, it''s perfect for adding warmth and elegance to your home. Buy now!","altText":"Luxurious chunky knit throw in soft cream, hand-knitted for warmth and style.","keywords":["chunky knit throw","soft cream throw","hand-knitted blanket","wool throw","cozy bedding","modern decor throw","luxury knit throw","plush wool blanket","living room throw","bedroom decor","warm knit blanket","elegant throw","interior design accessory","soft wool throw","neutral color throw","stylish home accessory","premium knit throw","decorative blanket","versatile home decor","quality wool throw","natural fiber throw","plush and cozy throw","snug wool blanket","textural knit throw","handmade wool throw","gift throw blanket","elegant home decor","cream color throw","relaxation blanket","chunky knit design"]}',
    TRUE,
    TRUE,
    4.9,
    234,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'bedding'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Cashmere Blend Throw
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'BED-BLANKET-002',
    'Cashmere Blend Throw',
    'Luxuriously soft cashmere blend throw with fringed edges.',
    195,
    250,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'throw-blanket' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Warm Gray","Burnt Orange","Cream"],"material":["Cashmere","Wool"],"style":["Luxury","Classic"],"room":["Living Room","Bedroom"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Warm Gray","hex":"#A9A9A9","category":"primary"},{"name":"Burnt Orange","hex":"#CC5500","category":"accent"},{"name":"Cream","hex":"#FFFDD0","category":"accent"}],"pattern":"geometric","texture":"woven","finish":"natural","shape":"rectangular","silhouette":"Soft drape with fringed edges"}',
    '{"short":"Elegant cashmere blend throw with geometric pattern and fringed edges.","long":"Wrap yourself in the luxurious embrace of our Cashmere Blend Throw, a perfect fusion of style and comfort. Featuring a sophisticated geometric pattern, this throw showcases soft gray tones that bring warmth and elegance to any space. The fringed edges add a playful touch of burnt orange, making it a versatile accent piece for your living room or bedroom. Crafted from high-quality materials, this throw combines the exquisite softness of cashmere with the durability of wool, ensuring it remains a cherished part of your home decor for years to come. Whether draped over a sofa or snuggled up in bed, it offers a cozy retreat during chilly evenings while elevating your interior design with its classic allure.","features":["Soft cashmere blend for ultimate comfort","Elegant geometric pattern for visual interest","Fringed edges adding a stylish touch","Warm gray tones complemented by burnt orange accents","High-quality craftsmanship ensuring longevity","Versatile design suitable for living room or bedroom","Perfect for cozy evenings or stylish decor"],"careInstructions":"Dry clean only to maintain the quality and softness of the cashmere blend.","materialComposition":"70% Cashmere, 30% Wool"}',
    '["blanket","throw","cashmere","camel","luxury","cashmere blend","throw blanket","geometric design","fringed edges","luxury bedding","soft texture","warm gray","burnt orange accent","living room decor","bedroom accessory","high-quality craftsmanship","cozy throw","classic style","woven texture","natural finish","elegant design","durable wool","dry clean only","soft cashmere","decorative throw","warm tones","stylish blanket","premium material","comfortable bedding","home decor","interior design","textile accessory","versatile use","gift idea","seasonal decor","accent piece","modern classic","timeless design","cashmere blend throw","geometric pattern throw","fringed edges blanket","soft texture bedding","warm gray throw","cozy throw blanket","classic style bedding","woven texture throw","natural finish throw","elegant design blanket","durable wool throw","dry clean only bedding","soft cashmere blanket","decorative throw blanket","warm tones bedding","premium material throw","home decor throw","interior design accessory","versatile use throw","gift idea bedding","seasonal decor throw","accent piece blanket","modern classic throw"]',
    '{"metaTitle":"Cashmere Blend Throw - Luxury Bedding with Geometric Pattern","metaDescription":"Experience luxury with our Cashmere Blend Throw. Soft, durable, and stylish, it''s perfect for cozy nights. Shop now for elegance and comfort!","altText":"Cashmere blend throw with geometric pattern in gray tones and fringed burnt orange edges.","keywords":["cashmere blend throw","luxury bedding","geometric pattern throw","fringed edges blanket","soft texture bedding","warm gray throw","burnt orange accent","living room decor","bedroom accessory","high-quality craftsmanship","cozy throw blanket","classic style bedding","woven texture throw","natural finish throw","elegant design blanket","durable wool throw","dry clean only bedding","soft cashmere blanket","decorative throw blanket","warm tones bedding","stylish blanket","premium material throw","comfortable bedding","home decor throw","interior design accessory","textile accessory","versatile use throw","gift idea bedding","seasonal decor throw","accent piece blanket","modern classic throw"]}',
    FALSE,
    FALSE,
    4.8,
    89,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'bedding'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Cotton Waffle Blanket
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'BED-BLANKET-003',
    'Cotton Waffle Blanket',
    'Breathable cotton waffle weave blanket. Perfect for year-round comfort.',
    85,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'throw-blanket' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Navy Blue","Light Gray","Cream"],"material":["Cotton"],"style":["Modern","Classic"],"room":["Living Room","Bedroom"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Navy Blue","hex":"#001F54","category":"primary"},{"name":"Light Gray","hex":"#D3D3D3","category":"secondary"},{"name":"Cream","hex":"#FFFDD0","category":"accent"}],"pattern":"striped","texture":"textured","finish":"matte","shape":"rectangular","silhouette":"Classic rectangular form with bold stripes"}',
    '{"short":"Experience cozy comfort with this stylish cotton waffle blanket.","long":"Wrap yourself in comfort with our Cotton Waffle Blanket, designed to elevate any room with its modern striped pattern in navy blue, light gray, and cream hues. The textured waffle weave adds a layer of visual interest and warmth, ensuring year-round coziness. Perfect for draping over your sofa or layering on your bed, this blanket not only serves as a functional piece but also as a stylish accent that complements a variety of decor styles. Made from breathable 100% cotton, it offers a soft touch and a comforting embrace, making it an ideal addition to your home.","features":["Striking navy, light gray, and cream stripes","Textured waffle weave for added warmth","Breathable 100% cotton fabric","Ideal for both living room and bedroom","Modern yet classic design","Soft and cozy feel","Perfect for year-round use"],"careInstructions":"Machine wash cold on a gentle cycle. Tumble dry on low heat. Avoid using bleach.","materialComposition":"100% Cotton"}',
    '["blanket","cotton","waffle","white","breathable","waffle weave","striped","navy blue","light gray","cream","cozy","modern","classic","home decor","bedding","throw blanket","comfortable","soft","warm","versatile","machine washable","durable","stylish","decorative","layering","bedroom","living room","sofa","bed","year-round","textured","cotton waffle blanket","striped blanket","modern bedding","navy blue blanket","light gray blanket","cream blanket","breathable cotton blanket","cozy blanket","home decor blanket","comfortable blanket","soft blanket","warm blanket","versatile blanket","machine washable blanket","durable blanket","stylish blanket","decorative blanket","layering blanket","bedroom blanket","living room blanket","sofa blanket","bed blanket","year-round blanket","textured blanket"]',
    '{"metaTitle":"Cotton Waffle Blanket - Modern Striped Design","metaDescription":"Discover ultimate comfort with our Cotton Waffle Blanket. Featuring a stylish striped pattern, it''s perfect for any decor. Shop now for cozy elegance!","altText":"Cotton waffle blanket with navy blue, light gray, and cream stripes, perfect for modern decor.","keywords":["cotton waffle blanket","striped blanket","modern bedding","navy blue blanket","light gray blanket","cream blanket","breathable cotton blanket","cozy blanket","home decor blanket","bedding","throw blanket","comfortable blanket","soft blanket","warm blanket","versatile blanket","machine washable blanket","durable blanket","stylish blanket","decorative blanket","layering blanket","bedroom blanket","living room blanket","sofa blanket","bed blanket","year-round blanket","textured blanket"]}',
    FALSE,
    TRUE,
    4.7,
    178,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'bedding'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Faux Fur Throw
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'BED-BLANKET-004',
    'Faux Fur Throw',
    'Plush faux fur throw in warm gray. Ultimate softness.',
    95,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'throw-blanket' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Soft Cream"],"material":["Faux Fur","Polyester"],"style":["Glamorous","Cozy"],"room":["Living Room","Bedroom"],"occasion":["Everyday","Relaxing"]}',
    '{"primaryColors":[{"name":"Soft Cream","hex":"#F5F5DC","category":"primary"}],"pattern":"textured","texture":"velvet","finish":"matte","shape":"rectangular","silhouette":"Generously sized with plush folds"}',
    '{"short":"Luxurious faux fur throw in soft cream, perfect for cozying up.","long":"Wrap yourself in the indulgent embrace of our Faux Fur Throw, a statement piece in soft cream designed to elevate your home decor. Enveloping you in warmth and plush comfort, its velvety texture is perfect for snuggling during chilly evenings. Whether draped elegantly over your sofa or layered onto your bed, this throw adds a touch of glamour to any space. Ethically crafted from high-quality faux fur, it replicates the softness of real fur without the ethical concerns. Experience the ultimate blend of style and comfort, transforming your living room or bedroom into a haven of relaxation and sophistication.","features":["Soft cream color complements any décor","Luxurious faux fur texture for ultimate comfort","Enhances elegance in living room or bedroom","Generously sized for versatile use","Ethically crafted from high-quality materials","Plush and cozy feel"],"careInstructions":"Machine wash cold on a gentle cycle. Tumble dry low or air dry. Avoid using bleach to maintain quality.","materialComposition":"100% high-quality polyester faux fur"}',
    '["blanket","throw","faux fur","gray","plush","faux fur throw","soft cream blanket","plush bedding","cozy throw","luxurious blanket","home decor","living room accessory","bedroom throw","warm blanket","soft texture","elegant design","machine washable","polyester faux fur","ethical bedding","comfortable throw","snuggle blanket","decorative blanket","versatile use","chic style","modern home","glamorous style","high-quality faux fur","plush texture","velvety feel","ethically crafted","soft cream color","textured pattern","rectangular throw","living room throw"]',
    '{"metaTitle":"Faux Fur Throw - Luxurious Soft Cream Blanket","metaDescription":"Elevate your home decor with our Faux Fur Throw. Experience plush comfort and style. Perfect for cozy evenings. Shop now for ultimate relaxation.","altText":"Luxurious faux fur throw blanket in soft cream, perfect for cozying up.","keywords":["faux fur throw","soft cream blanket","plush bedding","cozy throw","luxurious blanket","home decor","living room accessory","bedroom throw","warm blanket","soft texture","elegant design","machine washable","polyester faux fur","ethical bedding","comfortable throw","snuggle blanket","decorative blanket","versatile use","chic style","modern home","glamorous style","high-quality faux fur","plush texture","velvety feel","ethically crafted","soft cream color","textured pattern","rectangular throw","living room throw"]}',
    TRUE,
    FALSE,
    4.6,
    145,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'bedding'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Herringbone Wool Throw
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'BED-BLANKET-005',
    'Herringbone Wool Throw',
    'Classic herringbone pattern wool throw in charcoal and ivory.',
    145,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'throw-blanket' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Ivory"],"material":["Faux Fur","Polyester"],"style":["Luxurious","Contemporary"],"room":["Living Room","Bedroom","Office"],"occasion":["Everyday","Relaxation"]}',
    '{"primaryColors":[{"name":"Ivory","hex":"#FFFFF0","category":"primary"}],"pattern":"solid","texture":"velvet","finish":"matte","shape":"rectangular","silhouette":"Plush and inviting with a soft drape"}',
    '{"short":"Elegant Herringbone Wool Throw for warmth and style in any setting.","long":"Enhance your living space with the luxurious Herringbone Wool Throw, priced at $145. Crafted from premium wool, this throw features a classic herringbone pattern, marrying timeless style with unmatched comfort. Its rich texture and weight make it perfect for draping over a sofa or layering on your bed, providing both warmth and a sophisticated touch. The neutral tones blend seamlessly into any decor, making it a versatile addition to your home.","features":["Classic herringbone pattern for timeless style","Crafted from premium wool for ultimate warmth","Versatile neutral tones complement any decor","Perfect for layering on beds or draping over sofas","Adds a sophisticated touch to your living space","Generous size for ample coverage","Durable construction for long-lasting use"],"careInstructions":"Dry clean only to maintain quality and texture. Avoid direct sunlight to prevent fading. Store in a cool, dry place when not in use.","materialComposition":"100% Wool"}',
    '["blanket","throw","herringbone","wool","classic","faux fur","throw blanket","ivory","luxury","cozy","soft","home decor","living room","bedroom","office","plush","warm","comfortable","elegant","contemporary","machine washable","polyester","cruelty-free","gift","relaxation","chic","stylish","decorative","snuggle","textile","bedding","accessory","interior design","modern","neutral","versatile","soft touch","gentle cycle","tumble dry","no bleach","no ironing","Herringbone Wool Throw","luxurious bedding","premium wool throw","classic herringbone pattern","warm wool blanket","neutral decor throw","elegant home accessory","comfortable wool blanket","sophisticated throw","versatile home decor","living room throw","bedroom blanket","office decor","plush wool throw","stylish bedding","warm and cozy throw","timeless style blanket","neutral tones throw","premium quality wool","soft texture blanket","decorative wool throw","bedding accessory","interior design throw","modern wool blanket","classic design throw","cozy home decor","wool throw blanket","sophisticated home accessory","comfortable and stylish throw","elegant wool blanket"]',
    '{"metaTitle":"Herringbone Wool Throw - Luxurious Comfort & Style","metaDescription":"Add elegance to your home with the Herringbone Wool Throw. Crafted from premium wool, it offers warmth and style for $145. Shop now for sophistication!","altText":"Luxurious Herringbone Wool Throw in neutral tones, perfect for draping over furniture.","keywords":["Herringbone Wool Throw","luxurious bedding","premium wool throw","classic herringbone pattern","warm wool blanket","neutral decor throw","elegant home accessory","comfortable wool blanket","sophisticated throw","versatile home decor","living room throw","bedroom blanket","office decor","plush wool throw","stylish bedding","warm and cozy throw","timeless style blanket","neutral tones throw","premium quality wool","soft texture blanket","decorative wool throw","bedding accessory","interior design throw","modern wool blanket","classic design throw","cozy home decor","wool throw blanket","sophisticated home accessory","comfortable and stylish throw","elegant wool blanket"]}',
    FALSE,
    FALSE,
    4.8,
    98,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'bedding'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Sherpa Fleece Blanket
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'BED-BLANKET-006',
    'Sherpa Fleece Blanket',
    'Reversible sherpa fleece blanket with smooth velvet side.',
    75,
    95,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'throw-blanket' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Warm Taupe"],"material":["Polyester","Sherpa Fleece"],"style":["Cozy","Casual"],"room":["Living Room","Bedroom","Family Room"],"occasion":["Everyday","Relaxation"]}',
    '{"primaryColors":[{"name":"Warm Taupe","hex":"#B38B6D","category":"primary"}],"pattern":"textured","texture":"textured","finish":"matte","shape":"rectangular","silhouette":"Soft and plush with a textured surface"}',
    '{"short":"Luxurious reversible sherpa fleece blanket with textured design.","long":"Wrap yourself in warmth and elegance with our Sherpa Fleece Blanket, priced at $75. This plush blanket features a reversible design, offering a smooth velvet-like texture on one side and a cozy sherpa fleece on the other. Its warm taupe color adds a sophisticated touch to any room, enhancing your decor with its textured pattern. Perfect for those chilly nights when you want to snuggle up with a good book or a movie, this blanket blends comfort with style effortlessly. Whether draped over your living room sofa, spread across your bed, or used in a family room, it promises to be a delightful addition to your home.","features":["Reversible design with sherpa fleece and velvet sides","Warm taupe color with textured pattern","Soft and plush for ultimate comfort","Ideal for living room, bedroom, or family room","Enhances room decor with elegant style","Offers cozy warmth for cold nights","Machine washable for easy care"],"careInstructions":"Machine wash cold on gentle cycle. Tumble dry low. Do not bleach.","materialComposition":"100% Polyester"}',
    '["blanket","sherpa","fleece","navy","reversible","taupe","cozy","soft","plush","textured","warm","bedding","home decor","living room","bedroom","family room","comfortable","luxurious","machine washable","polyester","casual style","elegant","snuggle","cold nights","decorative","matte finish","soft touch","versatile","gift idea","warmth","relaxation","comfort","sherpa fleece blanket","reversible blanket","taupe blanket","cozy bedding","plush blanket","textured blanket","warm bedding","home decor blanket","living room blanket","bedroom blanket","family room blanket","comfortable blanket","luxurious blanket","machine washable blanket","polyester blanket","casual style blanket","elegant blanket","snuggle blanket","cold nights blanket","decorative blanket","matte finish blanket","soft touch blanket","versatile blanket","gift idea blanket","warmth blanket","relaxation blanket","comfort blanket"]',
    '{"metaTitle":"Sherpa Fleece Blanket - Reversible, Cozy & Elegant Bedding","metaDescription":"Experience ultimate comfort with our Sherpa Fleece Blanket. Reversible design in warm taupe adds elegance. Order now for cozy nights at $75!","altText":"Luxurious sherpa fleece blanket with reversible design and textured pattern in warm taupe.","keywords":["sherpa fleece blanket","reversible blanket","taupe blanket","cozy bedding","plush blanket","textured blanket","warm bedding","home decor blanket","living room blanket","bedroom blanket","family room blanket","comfortable blanket","luxurious blanket","machine washable blanket","polyester blanket","casual style blanket","elegant blanket","snuggle blanket","cold nights blanket","decorative blanket","matte finish blanket","soft touch blanket","versatile blanket","gift idea blanket","warmth blanket","relaxation blanket","comfort blanket"]}',
    FALSE,
    TRUE,
    4.5,
    212,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'bedding'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Linen Summer Throw
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'BED-BLANKET-007',
    'Linen Summer Throw',
    'Lightweight linen throw perfect for warm nights. Relaxed and airy.',
    115,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'throw-blanket' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Charcoal Gray"],"material":["Polyester"],"style":["Contemporary","Coastal"],"room":["Living Room","Bedroom","Sunroom"],"occasion":["Everyday","Relaxation"]}',
    '{"primaryColors":[{"name":"Charcoal Gray","hex":"#4A4A4A","category":"primary"}],"pattern":"textured","texture":"textured","finish":"matte","shape":"rectangular","silhouette":"Draped with plush waves"}',
    '{"short":"Elevate your space with the Linen Summer Throw in soothing charcoal gray.","long":"The Linen Summer Throw is the epitome of cozy sophistication. Its deep charcoal gray hue adds a touch of modern elegance to any room, seamlessly blending with contemporary and coastal styles. Crafted from premium linen, it features a subtly textured surface that invites tactile exploration. Perfect for draping over your favorite armchair or layering on your bed, this throw offers warmth without compromising style. Its lightweight yet plush feel makes it ideal for snuggling during cool evenings or enhancing your decor year-round. Experience the luxurious embrace of this versatile piece, which promises comfort and chic aesthetics.","features":["Premium linen material","Deep charcoal gray color","Subtly textured surface","Lightweight yet plush","Versatile design for all seasons","Perfect for layering and decor"],"careInstructions":"Machine wash cold on gentle cycle. Tumble dry low or lay flat to dry. Do not bleach.","materialComposition":"100% Linen"}',
    '["blanket","throw","linen","natural","summer","throw blanket","charcoal gray","plush","luxury","textured","cozy","elegant","home decor","living room","bedroom","soft","warm","comfortable","relaxation","polyester","matte finish","versatile","decorative","modern","contemporary","coastal","neutral color","machine washable","easy care","gift idea","stylish","high quality","premium","snuggle","winter","cool evenings","linen summer throw","charcoal gray throw","cozy throw blanket","luxury home decor","textured throw","elegant bedding","soft throw blanket","plush linen throw","contemporary decor","coastal style throw","versatile home accessory","warm and stylish throw","polyester throw blanket","machine washable throw","easy care bedding","high quality throw","premium linen throw","snuggle blanket","winter throw blanket","cool evenings throw","decorative throw blanket","neutral color throw","living room decor","bedroom throw blanket","stylish home accessory","gift idea throw","comfortable throw blanket","relaxation throw blanket","modern home decor"]',
    '{"metaTitle":"Linen Summer Throw - Cozy Elegance in Charcoal Gray","metaDescription":"Elevate your decor with the Linen Summer Throw. Experience cozy sophistication in charcoal gray. Perfect for year-round comfort. Shop now!","altText":"Luxurious charcoal gray linen summer throw blanket with textured surface.","keywords":["linen summer throw","charcoal gray throw","cozy throw blanket","luxury home decor","textured throw","elegant bedding","soft throw blanket","plush linen throw","contemporary decor","coastal style throw","versatile home accessory","warm and stylish throw","polyester throw blanket","machine washable throw","easy care bedding","high quality throw","premium linen throw","snuggle blanket","winter throw blanket","cool evenings throw","decorative throw blanket","neutral color throw","living room decor","bedroom throw blanket","stylish home accessory","gift idea throw","comfortable throw blanket","relaxation throw blanket","modern home decor"]}',
    TRUE,
    FALSE,
    4.7,
    67,
    TRUE,
    NOW(),
    NOW()
FROM categories c
WHERE c.slug = 'bedding'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- ----------------------------------------------------------------------------
-- Furniture (40 products)
-- ----------------------------------------------------------------------------

-- Product: Mid-Century Tufted Sofa
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'FURN-SOF-003',
    'Mid-Century Tufted Sofa',
    'Classic mid-century design with button tufting',
    749.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'sofa' AND category_id = c.id),
    15,
    'in_stock'::stock_status,
    '{"color":["Terracotta","Charcoal Gray","Ivory"],"material":["Linen","Solid Wood","Metal"],"style":["Mid-Century Modern","Contemporary"],"room":["Living Room"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Terracotta","hex":"#E2725B","category":"primary"},{"name":"Charcoal Gray","hex":"#4A4A4A","category":"accent"},{"name":"Ivory","hex":"#FFFFF0","category":"accent"}],"pattern":"solid","texture":"linen","finish":"matte","shape":"rectangular","silhouette":"Low-profile with clean lines"}',
    '{"short":"Sophisticated mid-century tufted sofa in warm terracotta with sleek lines, perfect for stylish comfort.","long":"Transform your living space with our Mid-Century Tufted Sofa, a blend of classic elegance and modern style. Draped in a warm terracotta linen, this sofa exudes inviting warmth, while its button-tufted design adds a layer of timeless sophistication. Slender black metal legs provide a sleek contrast, supporting a solid wood frame that promises durability. The plush cushions are designed for ultimate comfort, making it the perfect centerpiece for relaxation or entertaining. Ideal for a contemporary or mid-century modern decor, this sofa''s versatile appeal ensures it will be a cherished addition to your home for years to come.","features":["Warm terracotta linen upholstery","Classic button tufted design","Durable solid wood frame","Sleek black metal legs","Plush, comfortable seating","Versatile mid-century modern style","Low-profile silhouette with clean lines"],"careInstructions":"Vacuum regularly to remove dust and debris. Spot clean with a damp cloth and mild detergent. Avoid direct sunlight to prevent fading.","materialComposition":"Linen upholstery, solid wood frame, metal legs"}',
    '["living-room","3-seater","mid-century","mid-century sofa","terracotta sofa","button tufted","modern living room","comfortable seating","linen upholstery","sleek design","metal legs","home decor","contemporary furniture","stylish sofa","elegant seating","warm tones","versatile style","cozy living room","classic elegance","minimalist design","plush cushions","timeless addition","solid wood frame","mid-century modern","living room furniture","durable sofa","sophisticated design","terracotta fabric","black metal legs"]',
    '{"metaTitle":"Mid-Century Tufted Sofa: Elegance & Comfort in Terracotta","metaDescription":"Upgrade your living room with the Mid-Century Tufted Sofa. Experience timeless elegance and ultimate comfort. Order now for a stylish home centerpiece!","altText":"Mid-century tufted sofa in warm terracotta fabric with sleek black legs and plush cushions.","keywords":["mid-century sofa","terracotta sofa","button tufted","modern living room","comfortable seating","linen upholstery","sleek design","metal legs","home decor","contemporary furniture","stylish sofa","elegant seating","warm tones","versatile style","cozy living room","classic elegance","minimalist design","plush cushions","timeless addition","solid wood frame","mid-century modern","living room furniture","durable sofa","sophisticated design","terracotta fabric","black metal legs"]}',
    TRUE,
    FALSE,
    4.6,
    156,
    TRUE,
    '2024-01-20T00:00:00Z',
    '2024-01-20T00:00:00Z'
FROM categories c
WHERE c.slug = 'furniture'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Contemporary Leather Sofa
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'FURN-SOF-002',
    'Contemporary Leather Sofa',
    'Sleek contemporary sofa in premium leather',
    1299.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'sofa' AND category_id = c.id),
    8,
    'in_stock'::stock_status,
    '{"color":["Olive Green","Warm Chestnut Brown"],"material":["Fabric","Solid Wood"],"style":["Contemporary","Modern"],"room":["Living Room"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Olive Green","hex":"#556B2F","category":"primary"},{"name":"Warm Chestnut Brown","hex":"#8B4513","category":"accent"}],"pattern":"solid","texture":"smooth","finish":"natural","shape":"rectangular","silhouette":"Low-profile with clean lines"}',
    '{"short":"Elegant olive green leather sofa with chic wooden accents, perfect for modern homes.","long":"Transform your living space with the Contemporary Leather Sofa, a masterpiece of modern design and comfort. Dressed in luxurious olive green leather, this sofa invites relaxation with its plush seating and supportive track arms. The sleek silhouette is complemented by tapered wooden legs, offering a warm chestnut brown contrast that enriches its contemporary appeal. Its clean lines and solid craftsmanship make it a versatile addition for gatherings or quiet evenings at home. The sofa''s inviting texture and stunning visual presence ensure it becomes the focal point of any room, seamlessly blending with diverse decor styles.","features":["Luxurious olive green leather upholstery","Tapered wooden legs with chestnut finish","Comfortable plush seating","Sleek track arms","Durable contemporary design","Versatile for various interior styles","Low-profile silhouette with clean lines"],"careInstructions":"Wipe with a soft, damp cloth regularly. Avoid direct sunlight and heat sources. Condition leather periodically.","materialComposition":"Top-grain leather upholstery, solid wood legs with chestnut finish"}',
    '["living-room","2-seater","contemporary","contemporary sofa","olive green sofa","modern furniture","living room sofa","fabric sofa","wooden legs","stylish seating","comfortable sofa","home decor","interior design","two-seater sofa","plush cushions","track arms","low-profile sofa","clean lines","modern style","solid pattern","smooth texture","natural finish","rectangular shape","elegant design","versatile furniture","durable materials","easy maintenance","vacuum regularly","avoid direct sunlight","soft fabric","warm wood accents","inviting texture","perfect for relaxing","ideal for entertaining","seamless blend","various interior styles","contemporary leather sofa"]',
    '{"metaTitle":"Contemporary Leather Sofa - Modern Design & Comfort","metaDescription":"Enhance your living space with our Contemporary Leather Sofa. Luxurious olive green leather, plush seating, and sleek design. Order now for comfort and style!","altText":"Contemporary leather sofa in olive green with wooden legs and plush seating.","keywords":["contemporary leather sofa","modern furniture","olive green sofa","living room sofa","stylish seating","comfortable sofa","home decor","interior design","two-seater sofa","plush cushions","track arms","low-profile sofa","clean lines","modern style","solid pattern","smooth texture","natural finish","rectangular shape","elegant design","versatile furniture","durable materials","easy maintenance","vacuum regularly","avoid direct sunlight","soft fabric","warm wood accents","inviting texture","perfect for relaxing","ideal for entertaining"]}',
    FALSE,
    TRUE,
    4.7,
    189,
    TRUE,
    '2024-01-18T00:00:00Z',
    '2024-01-18T00:00:00Z'
FROM categories c
WHERE c.slug = 'furniture'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Modern Velvet 3-Seater Sofa
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'FURN-SOF-001',
    'Modern Velvet 3-Seater Sofa',
    'Luxurious 3-seater sofa with plush velvet upholstery',
    899.99,
    1099.99,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'sofa' AND category_id = c.id),
    12,
    'in_stock'::stock_status,
    '{"color":["Light Gray","Warm Oak"],"material":["Velvet","Wood"],"style":["Modern","Contemporary"],"room":["Living Room"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Light Gray","hex":"#D3D3D3","category":"primary"},{"name":"Warm Oak","hex":"#A0522D","category":"accent"}],"pattern":"solid","texture":"velvet","finish":"matte","shape":"rectangular","silhouette":"Low-profile with clean lines"}',
    '{"short":"Experience luxury with our Modern Velvet 3-Seater Sofa, featuring plush light gray upholstery and a sturdy wooden frame.","long":"Transform your living space with the Modern Velvet 3-Seater Sofa, where comfort meets contemporary elegance. Wrapped in soft, light gray velvet, this sofa invites you to sink into plush cushions, while its sleek wooden frame adds a touch of warmth and sophistication. Designed for modern interiors, its clean lines and neutral palette harmonize effortlessly with various decor styles. Whether you''re lounging with a book or entertaining guests, this sofa promises a cozy yet stylish experience, making it the centerpiece of your living room.","features":["Luxurious velvet upholstery in light gray","Sturdy wooden frame for durability","Modern, sleek design with clean lines","Comfortable seating with plush cushions","Neutral tones complement diverse decor styles","Low-profile silhouette for a contemporary look","Perfect for relaxing or entertaining guests"],"careInstructions":"Regularly vacuum to keep dust at bay. Spot clean with a damp cloth and mild detergent for stains.","materialComposition":"Crafted from high-quality velvet fabric and solid wood frame"}',
    '["living-room","3-seater","modern","modern sofa","3-seater sofa","light gray sofa","velvet upholstery","wooden frame","living room furniture","contemporary design","comfortable seating","neutral decor","elegant sofa","home decor","stylish furniture","luxury sofa","plush cushions","interior design","furniture sale","best seller","on sale","in stock","high rating","customer favorite","quality craftsmanship","durable materials","easy maintenance","versatile style","trendy design","soft fabric","solid construction","cozy seating","inviting atmosphere","perfect for guests","home improvement","decor inspiration","space-saving design"]',
    '{"metaTitle":"Modern Velvet 3-Seater Sofa - Comfort & Elegance","metaDescription":"Upgrade your living space with the Modern Velvet 3-Seater Sofa. Enjoy plush comfort and sleek design. Shop now to make it your living room centerpiece!","altText":"Elegant modern 3-seater sofa in light gray velvet with wooden frame","keywords":["modern sofa","3-seater sofa","light gray sofa","velvet upholstery","wooden frame","living room furniture","contemporary design","comfortable seating","neutral decor","elegant sofa","home decor","stylish furniture","luxury sofa","plush cushions","interior design","furniture sale","best seller","on sale","in stock","high rating","customer favorite","quality craftsmanship","durable materials","easy maintenance","versatile style","trendy design","soft fabric","solid construction","cozy seating","inviting atmosphere"]}',
    TRUE,
    TRUE,
    4.8,
    234,
    TRUE,
    '2024-01-15T00:00:00Z',
    '2024-01-15T00:00:00Z'
FROM categories c
WHERE c.slug = 'furniture'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Industrial Loft Sofa
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'FURN-SOF-006',
    'Industrial Loft Sofa',
    'Urban industrial style sofa',
    999.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'sofa' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Slate Gray","Jet Black"],"material":["Fabric","Metal"],"style":["Industrial","Modern"],"room":["Living Room","Office"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Slate Gray","hex":"#708090","category":"primary"},{"name":"Jet Black","hex":"#343434","category":"accent"}],"pattern":"solid","texture":"smooth","finish":"matte","shape":"rectangular","silhouette":"Low-profile with clean lines"}',
    '{"short":"Elegant gray sectional sofa with robust black metal legs, perfect for modern spaces.","long":"The Industrial Loft Sofa is the epitome of urban chic, blending comfort and style seamlessly. Its sleek gray fabric upholstery is complemented by strong black metal legs, creating a sturdy yet stylish foundation. The sectional design allows for flexible seating arrangements, making it a versatile addition to any living room or office. With its minimalist silhouette and clean lines, this sofa is a perfect choice for those seeking to enhance their decor with a touch of industrial elegance. Whether hosting guests or relaxing after a long day, this sofa promises both aesthetic appeal and supreme comfort.","features":["Chic gray fabric upholstery","Durable black metal legs","Flexible sectional design","Minimalist silhouette","Versatile for living rooms and offices","Urban industrial style","Comfortable and stylish seating"],"careInstructions":"To maintain its pristine look, spot clean using a damp cloth and mild detergent. Keep away from direct sunlight to prevent fabric fading.","materialComposition":"Crafted with high-quality fabric upholstery and robust metal frame and legs."}',
    '["living-room","office","industrial","industrial sofa","modern furniture","sectional sofa","gray sofa","metal legs","living room seating","office furniture","urban style","minimalist design","comfortable seating","versatile sofa","home decor","sleek design","contemporary sofa","stylish seating","fabric sofa","durable construction","easy maintenance","compact design","space-saving","trendy furniture","black accents","neutral colors","modern home","industrial chic","urban loft","apartment furniture","cozy seating","functional design","decorative piece","high-quality materials","easy to clean","sturdy frame","comfortable cushions","modern aesthetic","versatile use","sleek lines","fashionable sofa","home office","industrial loft sofa"]',
    '{"metaTitle":"Industrial Loft Sofa - Urban Chic with Sectional Design","metaDescription":"Discover the Industrial Loft Sofa, blending urban chic with supreme comfort. Perfect for modern spaces. Order now for stylish, versatile seating.","altText":"Industrial Loft Sofa with gray fabric and black metal legs, featuring a sectional design.","keywords":["industrial loft sofa","modern furniture","sectional sofa","gray sofa","metal legs","living room seating","office furniture","urban style","minimalist design","comfortable seating","versatile sofa","home decor","sleek design","contemporary sofa","stylish seating","fabric sofa","durable construction","easy maintenance","compact design","space-saving","trendy furniture","black accents","neutral colors","modern home","industrial chic","urban loft","apartment furniture","cozy seating","functional design"]}',
    FALSE,
    FALSE,
    4.6,
    145,
    TRUE,
    '2024-02-10T00:00:00Z',
    '2024-02-10T00:00:00Z'
FROM categories c
WHERE c.slug = 'furniture'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Minimalist Loveseat
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'FURN-SOF-005',
    'Minimalist Loveseat',
    'Compact loveseat perfect for small spaces',
    549.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'sofa' AND category_id = c.id),
    20,
    'in_stock'::stock_status,
    '{"color":["Cream","Warm Chestnut Brown"],"material":["Polyester","Solid Wood"],"style":["Modern","Minimalist"],"room":["Living Room","Bedroom"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Cream","hex":"#F5F5DC","category":"primary"},{"name":"Warm Chestnut Brown","hex":"#8B4513","category":"accent"}],"pattern":"solid","texture":"smooth","finish":"matte","shape":"rectangular","silhouette":"Low-profile with rounded edges"}',
    '{"short":"Chic minimalist loveseat with built-in side table for modern living.","long":"Transform your living space with the elegance of our Minimalist Loveseat, priced at $549.99. This piece combines sleek design with practicality, featuring smooth cream upholstery that exudes sophistication. The integrated wooden side table in warm chestnut brown adds a functional touch, perfect for holding your favorite book or a cup of coffee. Its low-profile silhouette and rounded edges create a soft, inviting look, while its compact size makes it an ideal fit for small apartments or cozy corners. The plush seating ensures lasting comfort, making it a perfect spot to relax. Whether placed in the living room or bedroom, this loveseat enhances any modern decor with its stylish and versatile appeal.","features":["Integrated wooden side table for convenience","Smooth cream upholstery for a chic look","Rounded edges for a soft, inviting appearance","Low-profile silhouette complements modern spaces","Compact design perfect for small apartments","Warm wood accents add natural elegance","Plush seating for enhanced comfort"],"careInstructions":"Spot clean with a damp cloth and mild detergent. Avoid direct sunlight to prevent fading.","materialComposition":"Upholstery: Polyester blend; Frame: Solid wood"}',
    '["living-room","bedroom","loveseat","modern","minimalist","compact","integrated table","cream upholstery","wood accents","small spaces","elegant","comfortable","living room","apartment","stylish","functional","design","furniture","home decor","interior design","seating","cozy","space-saving","contemporary","neutral colors","versatile","trendy","durable","easy care","luxury","affordable","quality","unique","rounded edges","matte finish","solid pattern","smooth texture","polyester","solid wood","warm chestnut brown","minimalist loveseat","modern furniture","integrated side table","compact loveseat","small space furniture","elegant loveseat","comfortable seating","living room furniture","bedroom loveseat","apartment furniture","stylish loveseat","functional design","cozy seating","space-saving loveseat","contemporary loveseat","versatile loveseat","trendy furniture","durable loveseat","easy care loveseat","luxury loveseat","affordable furniture","quality loveseat","unique design","solid wood accents"]',
    '{"metaTitle":"Minimalist Loveseat with Integrated Side Table - $549.99","metaDescription":"Upgrade your space with our Minimalist Loveseat. Sleek design, cream upholstery, and an integrated side table. Perfect for small spaces. Buy now for $549.99!","altText":"Elegant cream minimalist loveseat with integrated wooden side table.","keywords":["minimalist loveseat","modern furniture","cream upholstery","integrated side table","compact loveseat","small space furniture","elegant loveseat","comfortable seating","living room furniture","bedroom loveseat","apartment furniture","stylish loveseat","functional design","home decor","interior design","cozy seating","space-saving loveseat","contemporary loveseat","neutral colors","versatile loveseat","trendy furniture","durable loveseat","easy care loveseat","luxury loveseat","affordable furniture","quality loveseat","unique design","rounded edges","matte finish","solid wood accents","warm chestnut brown"]}',
    FALSE,
    FALSE,
    4.5,
    98,
    TRUE,
    '2024-02-05T00:00:00Z',
    '2024-02-05T00:00:00Z'
FROM categories c
WHERE c.slug = 'furniture'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Scandinavian L-Shaped Sectional
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'FURN-SOF-004',
    'Scandinavian L-Shaped Sectional',
    'Spacious L-shaped sectional',
    1499.99,
    1799.99,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'sofa' AND category_id = c.id),
    5,
    'in_stock'::stock_status,
    '{"color":["Grayish Blue","Natural Wood"],"material":["Fabric","Wood"],"style":["Scandinavian","Minimalist"],"room":["Living Room"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Grayish Blue","hex":"#A9B9C2","category":"primary"},{"name":"Natural Wood","hex":"#D2B48C","category":"accent"}],"pattern":"solid","texture":"textured","finish":"matte","shape":"L-shaped","silhouette":"Low-profile with clean lines"}',
    '{"short":"Transform your living room with the elegant Scandinavian L-Shaped Sectional.","long":"Embrace the essence of Scandinavian design with our exquisite L-Shaped Sectional, priced at $1499.99. This sectional combines functionality with aesthetic appeal, featuring a sophisticated textured fabric in a serene grayish-blue hue. Its minimalist wooden frame offers warmth and stability, making it a perfect focal point for modern living spaces. Whether you''re hosting a gathering or enjoying a quiet evening, this sectional provides ample seating and comfort. The clean lines and neutral tones effortlessly integrate with various decor styles, enhancing your home''s overall ambiance. Experience the seamless blend of style and practicality with this versatile piece.","features":["Spacious L-shaped design for optimal seating","Textured fabric in calming grayish-blue","Sturdy solid wood frame for lasting durability","Scandinavian minimalist aesthetic","Neutral palette complements diverse decor","Ideal for relaxation and entertaining"],"careInstructions":"To maintain the sectional''s pristine condition, vacuum regularly to remove dust and debris. Spot clean using a damp cloth and mild detergent when necessary. Keep away from direct sunlight to avoid fading.","materialComposition":"The sectional features a textured fabric upholstery and a solid wood frame, ensuring both comfort and durability."}',
    '["living-room","sectional","scandinavian","Scandinavian","L-shaped sectional","textured fabric","minimalist design","modern living room","neutral colors","wooden frame","cozy seating","elegant sofa","contemporary furniture","living room decor","stylish sectional","home furniture","versatile sofa","comfortable seating","interior design","decor inspiration","furniture trends","home essentials","luxury sofa","designer furniture","space-saving","functional design","chic sofa","modern aesthetics","quality materials","durable construction","easy maintenance","neutral palette","inviting atmosphere","decorative sofa","stylish home","elegant design","warm ambiance","timeless style","classic design","sophisticated look","family-friendly","entertainment space","relaxation area","home comfort","living space enhancement","Scandinavian sectional","L-shaped sofa","textured fabric sectional","minimalist sectional","modern living room furniture","neutral color sectional","wooden frame sofa","cozy seating furniture","elegant sectional sofa","contemporary furniture design","living room decor ideas","stylish sectional sofa","versatile sectional sofa","comfortable seating sectional","interior design sectional","furniture trends 2023","luxury sectional sofa","space-saving sectional","functional design sofa","chic sectional sofa","modern aesthetics furniture","quality materials sofa","durable sectional construction","easy maintenance furniture","neutral palette sofa","inviting atmosphere sectional","decorative sectional sofa","stylish home furniture","elegant design sectional","warm ambiance sofa","timeless style furniture","classic design sectional","sophisticated look sofa","family-friendly sectional","entertainment space furniture","relaxation area sofa","home comfort sectional","living space enhancement furniture"]',
    '{"metaTitle":"Scandinavian L-Shaped Sectional - Textured Fabric Elegance","metaDescription":"Discover the Scandinavian L-Shaped Sectional for $1499.99. Enjoy comfort and style with textured fabric and wooden frame. Perfect for modern living spaces. Buy now!","altText":"Elegant Scandinavian L-shaped sectional with textured grayish-blue fabric and wooden frame.","keywords":["Scandinavian sectional","L-shaped sofa","textured fabric sectional","minimalist sectional","modern living room furniture","neutral color sectional","wooden frame sofa","cozy seating furniture","elegant sectional sofa","contemporary furniture design","living room decor ideas","stylish sectional sofa","home furniture","versatile sectional sofa","comfortable seating sectional","interior design sectional","furniture trends 2023","luxury sectional sofa","designer furniture","space-saving sectional","functional design sofa","chic sectional sofa","modern aesthetics furniture","quality materials sofa","durable sectional construction","easy maintenance furniture","neutral palette sofa","inviting atmosphere sectional","decorative sectional sofa","stylish home furniture","elegant design sectional","warm ambiance sofa","timeless style furniture","classic design sectional","sophisticated look sofa","family-friendly sectional","entertainment space furniture","relaxation area sofa","home comfort sectional","living space enhancement furniture"]}',
    TRUE,
    TRUE,
    4.9,
    312,
    TRUE,
    '2024-02-01T00:00:00Z',
    '2024-02-01T00:00:00Z'
FROM categories c
WHERE c.slug = 'furniture'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Coastal White Slipcovered Sofa
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'FURN-SOF-007',
    'Coastal White Slipcovered Sofa',
    'Relaxed coastal style sofa',
    849.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'sofa' AND category_id = c.id),
    7,
    'in_stock'::stock_status,
    '{"color":["Olive Green"],"material":["Leather","Wood"],"style":["Modern","Contemporary"],"room":["Living Room"],"occasion":["Everyday","Relaxation"]}',
    '{"primaryColors":[{"name":"Olive Green","hex":"#556B2F","category":"primary"}],"pattern":"tufted","texture":"leather","finish":"matte","shape":"angular","silhouette":"Low-profile with clean lines"}',
    '{"short":"Chic coastal white slipcovered sofa offering serene comfort and style.","long":"Embrace the tranquil vibes of seaside living with our Coastal White Slipcovered Sofa. Its soft, crisp white fabric invites relaxation, while the slipcover provides an easy-care solution, perfect for families and pet owners. Sink into plush cushions that offer superior comfort, making this sofa an ideal centerpiece for gatherings or quiet evenings. The clean lines and versatile design effortlessly complement any decor, transforming your living space into a coastal retreat. Crafted with quality in mind, this sofa combines style, functionality, and durability, ensuring it remains a beloved piece in your home for years to come.","features":["Removable slipcover for easy maintenance","Plush, supportive cushions","Versatile design complements various decor styles","High-quality construction for lasting durability","Spacious seating for ultimate comfort","Neutral white color ideal for coastal themes"],"careInstructions":"Machine wash slipcover on gentle cycle in cold water. Tumble dry low. Spot clean cushions as needed.","materialComposition":"100% cotton slipcover, foam cushioning, hardwood frame"}',
    '["living-room","coastal","slipcovered","armchair","olive green","leather","tufted","modern","contemporary","living room","comfortable","luxury","stylish","elegant","home decor","furniture","interior design","seating","accent chair","solid wood","plush","matte finish","angular shape","low-profile","clean lines","relaxation","everyday use","durable","quality","Coastal White Slipcovered Sofa","white sofa","slipcovered sofa","easy-care sofa","family sofa","pet-friendly sofa","comfortable sofa","plush cushions","living room furniture","coastal decor","versatile sofa","quality sofa","durable sofa","relaxation sofa","stylish sofa","modern sofa","contemporary sofa","home furniture","sofa centerpiece","coastal retreat","sofa for gatherings","quiet evenings sofa","soft white fabric","clean lines sofa","decor complement","seaside living sofa","easy maintenance sofa"]',
    '{"metaTitle":"Coastal White Slipcovered Sofa - Relaxation & Easy Care","metaDescription":"Transform your living space with the Coastal White Slipcovered Sofa. Enjoy superior comfort and easy maintenance. Perfect for families and pet owners. Shop now!","altText":"Coastal White Slipcovered Sofa with plush cushions and easy-care slipcover.","keywords":["Coastal White Slipcovered Sofa","white sofa","slipcovered sofa","easy-care sofa","family sofa","pet-friendly sofa","comfortable sofa","plush cushions","living room furniture","coastal decor","versatile sofa","quality sofa","durable sofa","relaxation sofa","stylish sofa","modern sofa","contemporary sofa","home furniture","interior design","sofa centerpiece","coastal retreat","sofa for gatherings","quiet evenings sofa","soft white fabric","clean lines sofa","decor complement","seaside living sofa","easy maintenance sofa"]}',
    FALSE,
    TRUE,
    4.7,
    201,
    TRUE,
    '2024-02-12T00:00:00Z',
    '2024-02-12T00:00:00Z'
FROM categories c
WHERE c.slug = 'furniture'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Modular Sleeper Sofa
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'FURN-SOF-009',
    'Modular Sleeper Sofa',
    'Versatile sleeper sofa with storage',
    1099.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'sofa' AND category_id = c.id),
    9,
    'in_stock'::stock_status,
    '{"color":["Olive Green","Natural Rattan"],"material":["Fabric","Rattan"],"style":["Modern","Bohemian"],"room":["Living Room","Bedroom"],"occasion":["Everyday","Relaxation"]}',
    '{"primaryColors":[{"name":"Olive Green","hex":"#808000","category":"primary"},{"name":"Natural Rattan","hex":"#C3A370","category":"accent"}],"pattern":"solid","texture":"woven","finish":"natural","shape":"organic","silhouette":"Low-profile with curved lines"}',
    '{"short":"Transform your space with our versatile olive green modular sleeper sofa, featuring natural rattan accents.","long":"Elevate your home decor with our Modular Sleeper Sofa, a masterpiece of modern design and bohemian charm. The inviting organic shape and soothing olive green fabric create a tranquil ambiance, while the natural woven rattan accents add a touch of earthy elegance. Ideal for both lounging and sleeping, this sofa effortlessly adapts to your needs with its modular design. Its low-profile silhouette and curved lines make it a perfect fit for any living room or bedroom, offering a harmonious blend of comfort and style. Whether you''re hosting guests or enjoying a quiet night in, this sleeper sofa provides the ultimate in versatility and aesthetic appeal.","features":["Organic-shaped design","Soothing olive green fabric","Natural rattan accents","Modular and flexible layout","Converts easily to a sleeper","Low-profile silhouette","Removable cushions for easy care"],"careInstructions":"Clean fabric with mild detergent and water. Dust rattan regularly and avoid direct sunlight to prevent fading.","materialComposition":"Crafted with high-quality fabric upholstery and woven rattan accents."}',
    '["living-room","bedroom","sleeper","modern","modular sofa","sleeper sofa","modern design","olive green","rattan accents","organic shape","living room furniture","bedroom furniture","comfortable seating","versatile sofa","stylish sofa","bohemian style","natural materials","low-profile","curved lines","removable cushions","woven texture","solid pattern","natural finish","relaxation","home decor","modular sleeper sofa","modern furniture","olive green sofa","organic shape sofa","low-profile sofa","curved lines sofa","solid pattern sofa","natural finish sofa","relaxation furniture","modern design sofa","bohemian charm","organic design","sleeper functionality","lounging sofa","sleeping sofa","textured sofa","earthy elegance"]',
    '{"metaTitle":"Modular Sleeper Sofa: Bohemian Charm & Modern Design","metaDescription":"Discover the Modular Sleeper Sofa with olive green fabric and rattan accents. Perfect for lounging or sleeping. Shop now for comfort and style!","altText":"Organic-shaped modular sleeper sofa in olive green with rattan accents, ideal for modern living spaces.","keywords":["modular sleeper sofa","modern furniture","bohemian style","olive green sofa","rattan accents","organic shape sofa","living room furniture","bedroom furniture","comfortable seating","versatile sofa","stylish sofa","natural materials","low-profile sofa","curved lines sofa","removable cushions","woven texture","solid pattern sofa","natural finish sofa","home decor","relaxation furniture","modern design sofa","bohemian charm","organic design","sleeper functionality","lounging sofa","sleeping sofa","textured sofa","earthy elegance"]}',
    FALSE,
    TRUE,
    4.5,
    178,
    TRUE,
    '2024-02-18T00:00:00Z',
    '2024-02-18T00:00:00Z'
FROM categories c
WHERE c.slug = 'furniture'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Chesterfield Tufted Sofa
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'FURN-SOF-008',
    'Chesterfield Tufted Sofa',
    'Classic Chesterfield with deep button tufting',
    1599.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'sofa' AND category_id = c.id),
    6,
    'in_stock'::stock_status,
    '{"color":["Light Beige","Black"],"material":["Metal","Fabric"],"style":["Modern","Contemporary"],"room":["Patio","Terrace"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Light Beige","hex":"#F5F5DC","category":"primary"},{"name":"Black","hex":"#000000","category":"accent"}],"pattern":"solid","texture":"smooth","finish":"matte","shape":"rectangular","silhouette":"sleek with clean lines"}',
    '{"short":"Luxurious Chesterfield sofa with timeless tufted design.","long":"Immerse your living space in classic sophistication with our Chesterfield Tufted Sofa. This elegant piece instantly transforms any room with its iconic deep button tufting and graceful rolled arms. Upholstered in opulent, high-quality fabric, the sofa offers a plush seating experience that invites relaxation and conversation. The robust wooden frame ensures durability, while the rich hue complements a variety of decor styles. Perfect for creating a cozy yet refined atmosphere, this sofa is an investment in both style and comfort.","features":["Iconic Chesterfield design with deep button tufting","Elegant rolled arms","Plush and comfortable seating","Durable wooden frame","Rich, versatile color","High-quality upholstery","Timeless appeal"],"careInstructions":"Vacuum regularly using upholstery attachment. Spot clean with mild fabric cleaner. Avoid direct sunlight to prevent fading.","materialComposition":"Solid wood frame, high-density foam cushions, premium fabric upholstery"}',
    '["living-room","traditional","chesterfield","outdoor","patio","modern","contemporary","metal frame","plush cushions","terrace","garden furniture","sleek design","comfortable seating","weather-resistant","stylish","elegant","durable","light beige","black accents","coffee table","relaxation","entertaining","minimalist","clean lines","versatile","decorative","functional","luxury","high-quality","easy maintenance","space-saving","compact","trendy","chic","urban","sophisticated","inviting","Chesterfield Tufted Sofa","classic sofa","elegant furniture","plush seating","living room sofa","button tufting","rolled arms","high-quality fabric","durable wooden frame","sophisticated decor","comfortable sofa","refined atmosphere","luxury sofa","traditional style sofa","timeless design","home decor","interior design","furniture investment","cozy seating","rich hue sofa","decor styles","style and comfort","classic sophistication","iconic sofa","opulent upholstery","room transformation"]',
    '{"metaTitle":"Chesterfield Tufted Sofa - Classic Elegance & Comfort","metaDescription":"Enhance your living space with the Chesterfield Tufted Sofa. Experience timeless elegance and plush comfort. Order now for a refined atmosphere!","altText":"Chesterfield Tufted Sofa with deep button tufting and rolled arms in a living room.","keywords":["Chesterfield Tufted Sofa","classic sofa","elegant furniture","plush seating","living room sofa","button tufting","rolled arms","high-quality fabric","durable wooden frame","sophisticated decor","comfortable sofa","refined atmosphere","luxury sofa","traditional style sofa","timeless design","home decor","interior design","furniture investment","cozy seating","rich hue sofa","decor styles","style and comfort","classic sophistication","iconic sofa","opulent upholstery","room transformation"]}',
    TRUE,
    FALSE,
    4.8,
    267,
    TRUE,
    '2024-02-15T00:00:00Z',
    '2024-02-15T00:00:00Z'
FROM categories c
WHERE c.slug = 'furniture'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Tufted Velvet Accent Chair
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'FURN-CHR-001',
    'Tufted Velvet Accent Chair',
    'Elegant tufted accent chair with velvet upholstery',
    449.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'accent-chair' AND category_id = c.id),
    18,
    'in_stock'::stock_status,
    '{"color":["Camel"],"material":["Velvet","Solid Wood"],"style":["Mid-Century Modern"],"room":["Living Room","Bedroom"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Camel","hex":"#C19A6B","category":"primary"}],"pattern":"solid","texture":"textured","finish":"matte","shape":"curved","silhouette":"Low-profile with curved lines"}',
    '{"short":"Experience luxury with our Tufted Velvet Accent Chair, featuring plush velvet and a chic mid-century design.","long":"Elevate your home''s style with the Tufted Velvet Accent Chair, a stunning blend of luxury and comfort. This piece showcases a rich camel-colored velvet that exudes warmth and sophistication. The chair''s mid-century modern design features a gracefully curved silhouette and elegant tapered wooden legs, perfect for enhancing the aesthetic of any living room or bedroom. The tufted back not only adds a touch of classic elegance but also enhances the chair''s plush comfort, making it an ideal spot for relaxation or conversation. Its textured velvet upholstery invites you to sink in and unwind, while the sturdy build ensures durability. Create a cozy, inviting atmosphere with this versatile yet stylish addition to your home decor.","features":["Luxurious camel velvet upholstery","Elegant mid-century modern design","Curved silhouette with tufted back","Sturdy tapered wooden legs","Plush cushioning for maximum comfort","Rich, warm color palette","Durable construction"],"careInstructions":"Spot clean with a damp cloth and mild detergent. Avoid exposure to direct sunlight to prevent fading. Regularly vacuum to maintain fabric texture.","materialComposition":"100% Velvet upholstery, Solid wood legs"}',
    '["living-room","bedroom","tufted","mid-century","accent chair","velvet","mid-century modern","living room","camel color","textured upholstery","comfortable seating","stylish design","home decor","furniture","interior design","elegant","modern","luxury","plush cushion","wooden legs","curved silhouette","warm tones","sophisticated","relaxing","entertaining","spot clean","durable","high-quality","trendy","decorative","unique","eye-catching","cozy","chic","versatile","statement piece","comfortable","supportive","stylish","functional","designer","premium","tufted velvet accent chair","luxury furniture","mid-century modern chair","camel velvet chair","living room decor","bedroom accent chair","elegant chair","modern velvet chair","plush cushion chair","wooden legs furniture","curved silhouette chair","warm tones chair","sophisticated accent chair","relaxing seating","entertaining furniture","spot clean chair","durable accent chair","high-quality velvet chair","trendy home furniture","decorative chair","unique design chair","eye-catching accent chair","cozy seating","chic velvet chair","versatile accent chair"]',
    '{"metaTitle":"Tufted Velvet Accent Chair - Luxury Comfort & Style","metaDescription":"Elevate your home''s decor with our Tufted Velvet Accent Chair. Experience ultimate comfort and sophistication. Buy now for a cozy, stylish addition!","altText":"Luxurious tufted velvet accent chair with camel-colored upholstery and tapered wooden legs.","keywords":["tufted velvet accent chair","luxury furniture","mid-century modern chair","camel velvet chair","living room decor","bedroom accent chair","textured upholstery","comfortable seating","stylish design","home decor","furniture","interior design","elegant chair","modern velvet chair","plush cushion chair","wooden legs furniture","curved silhouette chair","warm tones chair","sophisticated accent chair","relaxing seating","entertaining furniture","spot clean chair","durable accent chair","high-quality velvet chair","trendy home furniture","decorative chair","unique design chair","eye-catching accent chair","cozy seating","chic velvet chair","versatile accent chair"]}',
    TRUE,
    TRUE,
    4.9,
    201,
    TRUE,
    '2024-01-10T00:00:00Z',
    '2024-01-10T00:00:00Z'
FROM categories c
WHERE c.slug = 'furniture'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Rustic Farmhouse Sofa
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'FURN-SOF-010',
    'Rustic Farmhouse Sofa',
    'Cozy farmhouse style sofa',
    799.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'sofa' AND category_id = c.id),
    11,
    'in_stock'::stock_status,
    '{"color":["Espresso"],"material":["Leather","Wood"],"style":["Traditional","Classic"],"room":["Living Room","Office"],"occasion":["Entertaining","Relaxing"]}',
    '{"primaryColors":[{"name":"Espresso","hex":"#4B3A30","category":"primary"}],"pattern":"tufted","texture":"leather","finish":"matte","shape":"rectangular","silhouette":"Low-profile with rolled arms and deep tufting"}',
    '{"short":"Embrace cozy elegance with the Rustic Farmhouse Sofa, perfect for any living space.","long":"Transform your living space into a warm haven with the Rustic Farmhouse Sofa. Crafted to embody the charm of a country retreat, this sofa features plush cushions covered in soft, durable fabric that invites you to sink in and stay awhile. The solid wood frame, highlighted by a natural finish, adds a touch of rustic beauty that''s both timeless and welcoming. Whether you''re hosting a gathering or enjoying a quiet evening with a book, this sofa provides the ideal setting with its spacious seating and supportive backrest. Its neutral tones effortlessly blend with various decor styles, making it a versatile addition to your home. Enhance your living room''s aesthetic and comfort with this beautifully designed piece that promises to be the heart of your home.","features":["Plush, comfortable cushions","Durable, soft fabric upholstery","Solid wood frame with a natural finish","Spacious seating for family and guests","Versatile neutral tones","Rustic farmhouse design","Supportive backrest for added comfort"],"careInstructions":"Vacuum regularly to remove dust. Spot clean with a mild detergent and water. Avoid placing in direct sunlight to prevent fading.","materialComposition":"Fabric upholstery with a solid wood frame and high-density foam cushions."}',
    '["living-room","rustic","farmhouse","Chesterfield","leather sofa","button tufted","rolled arms","espresso","classic design","living room furniture","office decor","luxury seating","traditional style","comfortable sofa","durable construction","elegant upholstery","solid wood frame","timeless elegance","home decor","furniture","sophisticated look","matte finish","rectangular shape","low-profile design","rich color","high-quality materials","stylish seating","premium leather","accent piece","interior design","decorative sofa","classic furniture","luxurious feel","quality craftsmanship","versatile use","entertaining guests","relaxation","office seating","home office","living room centerpiece","Rustic Farmhouse Sofa","country retreat sofa","plush cushions sofa","solid wood frame sofa","natural finish sofa","spacious seating sofa","supportive backrest sofa","neutral tone sofa","versatile living room sofa","home decor sofa","classic design sofa","timeless elegance sofa","comfortable living room furniture","durable fabric sofa","warm haven sofa","country-style sofa","inviting sofa","home comfort sofa","rustic beauty furniture","enhance living room aesthetic","classic elegance sofa","quality craftsmanship sofa","stylish seating sofa","luxury seating sofa","sophisticated look furniture","interior design sofa","entertaining guests sofa","relaxation sofa"]',
    '{"metaTitle":"Rustic Farmhouse Sofa - Timeless Charm & Comfort","metaDescription":"Transform your living room with the Rustic Farmhouse Sofa. Experience plush comfort and rustic beauty. Shop now for a warm, inviting space!","altText":"Rustic Farmhouse Sofa with plush cushions and solid wood frame in a country-style living room.","keywords":["Rustic Farmhouse Sofa","country retreat sofa","plush cushions sofa","solid wood frame sofa","natural finish sofa","spacious seating sofa","supportive backrest sofa","neutral tone sofa","versatile living room sofa","home decor sofa","classic design sofa","timeless elegance sofa","comfortable living room furniture","durable fabric sofa","warm haven sofa","country-style sofa","living room centerpiece","inviting sofa","home comfort sofa","rustic beauty furniture","enhance living room aesthetic","classic elegance sofa","quality craftsmanship sofa","decorative sofa","stylish seating sofa","luxury seating sofa","sophisticated look furniture","interior design sofa","entertaining guests sofa","relaxation sofa"]}',
    FALSE,
    FALSE,
    4.6,
    134,
    TRUE,
    '2024-02-20T00:00:00Z',
    '2024-02-20T00:00:00Z'
FROM categories c
WHERE c.slug = 'furniture'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Leather Wingback Chair
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'FURN-CHR-002',
    'Leather Wingback Chair',
    'Classic wingback chair in premium leather',
    699.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'accent-chair' AND category_id = c.id),
    12,
    'in_stock'::stock_status,
    '{"color":["Warm Walnut","Beige"],"material":["Wood","Textured Fabric"],"style":["Modern","Contemporary"],"room":["Living Room","Bedroom","Office"],"occasion":["Everyday","Relaxation"]}',
    '{"primaryColors":[{"name":"Warm Walnut","hex":"#7E4A35","category":"primary"},{"name":"Beige","hex":"#D3B8A0","category":"secondary"}],"pattern":"solid","texture":"textured","finish":"natural","shape":"curved","silhouette":"Low-profile with rounded edges"}',
    '{"short":"Immerse in luxury with the Leather Wingback Chair, a perfect blend of vintage charm and modern elegance.","long":"Introducing the Leather Wingback Chair, a timeless piece that effortlessly marries classic design with modern sophistication. Upholstered in rich, supple leather, this chair promises not only style but unparalleled comfort. Its high back and elegantly curved wings provide both support and a touch of grandeur, making it a striking addition to any living room or study. The chair''s sturdy wooden legs ensure stability and durability, while its deep seating invites you to sink in and unwind. Perfect for curling up with a book or entertaining guests, this chair is the epitome of luxury and functionality. Add a touch of elegance to your space with this exquisite piece.","features":["High-quality leather upholstery","Elegant wingback design","Sturdy wooden legs","Deep, comfortable seating","Timeless vintage appeal","Perfect for living rooms and studies","Durable construction"],"careInstructions":"Keep away from direct sunlight to prevent fading. Clean spills immediately with a damp cloth. Regularly dust and condition the leather with a suitable leather conditioner.","materialComposition":"Upholstery: 100% Genuine Leather; Frame: Solid Wood; Legs: Wood with protective finish"}',
    '["living-room","office","wingback","traditional","accent chair","modern furniture","wooden frame","textured fabric","living room chair","comfortable seating","stylish design","contemporary decor","reading nook","home office","beige upholstery","walnut wood","curved design","plush seat","durable construction","elegant chair","interior design","furniture","home decor","cozy seating","sophisticated style","natural finish","rounded edges","low-profile","textured pattern","solid color","warm tones","versatile use","easy maintenance","quality materials","stylish accent","modern aesthetics","Leather Wingback Chair","Classic Design Furniture","Modern Sophistication Chair","Upholstered Leather Chair","High Back Wing Chair","Elegant Living Room Chair","Comfortable Reading Chair","Luxury Furniture","Wooden Legs Chair","Rich Leather Upholstery","Stylish Home Decor","Curved Wingback Chair","Durable Wooden Frame","Timeless Accent Chair","Plush Seating Chair","Sophisticated Living Room","Contemporary Design Chair","Elegant Office Chair","Cozy Chair for Study","Home Furniture","Accent Chair with Wings","Classic Wingback Design","Luxury Seating","High Quality Leather Chair","Modern Home Furnishings","Interior Design Chair","Walnut Wood Finish","Textured Upholstery Chair","Natural Finish Furniture"]',
    '{"metaTitle":"Leather Wingback Chair - Classic Design & Modern Comfort","metaDescription":"Elevate your space with our Leather Wingback Chair. Experience timeless elegance and unparalleled comfort. Order now to add luxury to your home!","altText":"Leather Wingback Chair with high back, curved wings, and wooden legs.","keywords":["Leather Wingback Chair","Classic Design Furniture","Modern Sophistication Chair","Upholstered Leather Chair","High Back Wing Chair","Elegant Living Room Chair","Comfortable Reading Chair","Luxury Furniture","Wooden Legs Chair","Rich Leather Upholstery","Stylish Home Decor","Curved Wingback Chair","Durable Wooden Frame","Timeless Accent Chair","Plush Seating Chair","Sophisticated Living Room","Contemporary Design Chair","Elegant Office Chair","Cozy Chair for Study","Home Furniture","Accent Chair with Wings","Classic Wingback Design","Luxury Seating","High Quality Leather Chair","Modern Home Furnishings","Interior Design Chair","Walnut Wood Finish","Textured Upholstery Chair","Natural Finish Furniture"]}',
    FALSE,
    TRUE,
    4.8,
    156,
    TRUE,
    '2024-01-12T00:00:00Z',
    '2024-01-12T00:00:00Z'
FROM categories c
WHERE c.slug = 'furniture'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Modern Swivel Chair
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'FURN-CHR-003',
    'Modern Swivel Chair',
    'Contemporary swivel chair with chrome base',
    399.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'accent-chair' AND category_id = c.id),
    22,
    'in_stock'::stock_status,
    '{"color":["Olive Green","Warm Chestnut Brown"],"material":["Fabric","Solid Wood"],"style":["Modern","Contemporary"],"room":["Living Room","Bedroom"],"occasion":["Everyday","Relaxation"]}',
    '{"primaryColors":[{"name":"Olive Green","hex":"#808000","category":"primary"},{"name":"Warm Chestnut Brown","hex":"#8B4513","category":"accent"}],"pattern":"solid","texture":"textured","finish":"natural","shape":"curved","silhouette":"Low-profile with rounded edges"}',
    '{"short":"Experience luxury with our Modern Swivel Chair, featuring plush olive green upholstery and elegant curved wooden legs.","long":"Elevate your living space with our Modern Swivel Chair, a perfect blend of style and comfort. This chair boasts a sumptuous olive green fabric that envelops you in softness, providing an inviting spot to relax. The striking curved wooden legs not only offer sturdy support but also add a touch of sophistication to any room. Designed with a modern flair, its low-profile silhouette fits seamlessly into both contemporary and classic decors. Whether placed in a living room, bedroom, or reading nook, this chair invites you to unwind in style, making it an essential piece for those who appreciate quality craftsmanship and timeless design.","features":["Plush olive green upholstery","Elegant curved wooden legs","Modern low-profile silhouette","Textured fabric for a cozy feel","Versatile for living room or bedroom"],"careInstructions":"Spot clean with a damp cloth and mild detergent. Avoid direct sunlight to prevent upholstery fading.","materialComposition":"High-quality fabric upholstery with solid wood legs."}',
    '["living-room","office","swivel","modern","accent chair","olive green","modern furniture","living room","reading nook","comfortable seating","wooden legs","textured upholstery","home decor","stylish chair","compact design","plush seating","contemporary style","interior design","furniture","relaxation","cozy corner","elegant chair","soft fabric","natural finish","curved silhouette","modern swivel chair","olive green accent chair","living room furniture","reading nook chair","relaxation chair","soft fabric chair","solid wood legs","low-profile chair","quality craftsmanship","timeless design"]',
    '{"metaTitle":"Modern Swivel Chair - Stylish Comfort with Olive Green Fabric","metaDescription":"Transform your space with the Modern Swivel Chair. Its olive green fabric and curved wooden legs offer style and comfort. Shop now for timeless design!","altText":"Elegant olive green modern swivel chair with curved wooden legs, perfect for living room or reading nook.","keywords":["modern swivel chair","olive green accent chair","furniture","living room furniture","reading nook chair","comfortable seating","wooden legs","textured upholstery","home decor","stylish chair","compact design","plush seating","contemporary style","interior design","relaxation chair","cozy corner","elegant chair","soft fabric chair","natural finish","curved silhouette","modern furniture","solid wood legs","low-profile chair","quality craftsmanship","timeless design"]}',
    TRUE,
    FALSE,
    4.5,
    134,
    TRUE,
    '2024-01-15T00:00:00Z',
    '2024-01-15T00:00:00Z'
FROM categories c
WHERE c.slug = 'furniture'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Scandinavian Lounge Chair
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'FURN-CHR-005',
    'Scandinavian Lounge Chair',
    'Minimalist Scandinavian lounge chair',
    529.99,
    649.99,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'accent-chair' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Beige","Warm Chestnut Brown","Burnt Orange"],"material":["Linen","Solid Wood"],"style":["Scandinavian","Modern"],"room":["Living Room","Bedroom"],"occasion":["Everyday","Relaxing"]}',
    '{"primaryColors":[{"name":"Beige","hex":"#F5F5DC","category":"primary"},{"name":"Warm Chestnut Brown","hex":"#8B4513","category":"secondary"},{"name":"Burnt Orange","hex":"#CC5500","category":"accent"}],"pattern":"solid","texture":"textured","finish":"natural","shape":"curved","silhouette":"Curved with smooth lines and inviting form"}',
    '{"short":"Discover the ultimate comfort and style with our Scandinavian Lounge Chair.","long":"Sink into the plush comfort of our Scandinavian Lounge Chair, where modern design meets cozy elegance. Wrapped in a beautifully textured beige fabric, this chair radiates warmth and sophistication. Its gently curved silhouette and smooth wooden legs provide a minimalist charm that fits seamlessly into any living room or reading nook. The generous cushioning and supportive backrest promise a relaxing escape, while the included accent pillow adds a vibrant touch. Whether you''re unwinding after a long day or enjoying a good book, this chair offers an inviting sanctuary.","features":["Textured beige fabric for a cozy feel","Elegant curved silhouette","Durable smooth wooden legs","Plush cushioning for ultimate comfort","Accent pillow included for extra style","Supportive backrest for relaxation","Minimalist design complements any decor"],"careInstructions":"Spot clean with a damp cloth and mild detergent. Keep away from direct sunlight to prevent fabric fading.","materialComposition":"Upholstery: 100% Linen. Legs: Solid Wood."}',
    '["living-room","scandinavian","lounge","lounge chair","beige chair","modern furniture","living room seating","comfortable chair","accent chair","textured fabric","wooden legs","minimalist design","home decor","reading nook","cozy seating","interior design","stylish chair","plush cushion","supportive backrest","accent pillow","natural finish","curved silhouette","modern style","solid pattern","relaxing chair","bedroom furniture","warm tones","inviting design","elegant chair","functional furniture","decorative chair","high-quality materials","Scandinavian lounge chair"]',
    '{"metaTitle":"Scandinavian Lounge Chair - Cozy Elegance & Modern Design","metaDescription":"Experience unparalleled comfort with our Scandinavian Lounge Chair. Perfect for any living space, it offers style and relaxation. Order now for a cozy haven!","altText":"Elegant Scandinavian lounge chair with textured beige fabric and smooth wooden legs.","keywords":["Scandinavian lounge chair","modern furniture","beige chair","living room seating","comfortable chair","accent chair","textured fabric","wooden legs","minimalist design","home decor","reading nook","cozy seating","interior design","stylish chair","plush cushion","supportive backrest","accent pillow","natural finish","curved silhouette","modern style","solid pattern","relaxing chair","bedroom furniture","warm tones","inviting design","elegant chair","functional furniture","decorative chair","high-quality materials"]}',
    TRUE,
    TRUE,
    4.8,
    189,
    TRUE,
    '2024-01-20T00:00:00Z',
    '2024-01-20T00:00:00Z'
FROM categories c
WHERE c.slug = 'furniture'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Rattan Accent Chair
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'FURN-CHR-004',
    'Rattan Accent Chair',
    'Boho-style rattan chair for relaxed spaces',
    349.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'accent-chair' AND category_id = c.id),
    15,
    'in_stock'::stock_status,
    '{"color":["Forest Green","Warm Chestnut Brown"],"material":["Velvet","Solid Wood"],"style":["Mid-Century Modern","Contemporary"],"room":["Living Room","Bedroom","Reading Nook"],"occasion":["Everyday","Relaxation"]}',
    '{"primaryColors":[{"name":"Forest Green","hex":"#2C5F2D","category":"primary"},{"name":"Warm Chestnut Brown","hex":"#8B4513","category":"secondary"}],"pattern":"solid","texture":"velvet","finish":"matte","shape":"rectangular","silhouette":"Low-profile with clean lines"}',
    '{"short":"Stylish Rattan Accent Chair adds earthy charm and comfort to any space.","long":"Transform your living room or reading nook with the Rattan Accent Chair, a delightful blend of style and comfort. Crafted from natural rattan, this chair showcases an intricate weave that exudes rustic elegance. Its sturdy frame and supportive design promise long-lasting use, while the soft, cushioned seat invites you to unwind in cozy luxury. The chair''s organic texture and warm hue effortlessly complement various interior themes, from bohemian to coastal. With its airy silhouette and timeless appeal, this piece is perfect for creating a serene atmosphere. At $349.99, this chair is an investment in sophisticated relaxation.","features":["Natural rattan weave","Sturdy, supportive frame","Soft, cushioned seat","Earthy, warm hue","Versatile design for various themes","Intricate, rustic elegance","Lightweight and easy to move"],"careInstructions":"Dust regularly with a soft cloth. Avoid exposing to direct sunlight or moisture to maintain rattan integrity.","materialComposition":"100% Natural Rattan Frame, Foam Cushion"}',
    '["living-room","bedroom","boho","rattan","accent chair","velvet chair","green chair","mid-century modern","living room furniture","reading nook","comfortable seating","modern design","home decor","luxury chair","wooden frame","tapered legs","forest green","chic style","relaxation","cozy chair","elegant design","interior design","stylish furniture","home comfort","plush velvet","matching ottoman","neutral tones","sophisticated look","versatile chair","soft texture","spot clean","durable materials","quality craftsmanship","unique design","timeless appeal","classic style","functional furniture","decorative piece","high-quality chair","wood accents","comfortable lounging","reading corner","relaxing space","modern elegance","warm chestnut","Rattan Accent Chair","Furniture","Living Room Chair","Reading Nook Chair","Rustic Elegance","Natural Rattan","Cushioned Seat","Stylish Comfort","Bohemian Style","Coastal Decor","Organic Texture","Warm Hue","Serene Atmosphere","Sophisticated Relaxation","Home Decor","Interior Themes","Sturdy Frame","Supportive Design","Long-lasting Use","Investment Furniture","Timeless Appeal","Airy Silhouette","Comfortable Seating","Quality Craftsmanship","Decorative Piece","Elegant Design","Versatile Chair","Chic Style","Relaxation Chair"]',
    '{"metaTitle":"Rattan Accent Chair - Rustic Elegance & Comfort","metaDescription":"Enhance your space with the Rattan Accent Chair, blending rustic elegance and comfort. Shop now for a cozy, stylish addition to your home at $349.99!","altText":"Rattan Accent Chair featuring natural rattan weave and cushioned seat for stylish comfort.","keywords":["Rattan Accent Chair","Furniture","Living Room Chair","Reading Nook Chair","Rustic Elegance","Natural Rattan","Cushioned Seat","Stylish Comfort","Bohemian Style","Coastal Decor","Organic Texture","Warm Hue","Serene Atmosphere","Sophisticated Relaxation","Home Decor","Interior Themes","Sturdy Frame","Supportive Design","Long-lasting Use","Investment Furniture","Timeless Appeal","Airy Silhouette","Comfortable Seating","Quality Craftsmanship","Decorative Piece","Elegant Design","Versatile Chair","Chic Style","Relaxation Chair"]}',
    FALSE,
    FALSE,
    4.6,
    98,
    TRUE,
    '2024-01-18T00:00:00Z',
    '2024-01-18T00:00:00Z'
FROM categories c
WHERE c.slug = 'furniture'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Industrial Metal Chair
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'FURN-CHR-006',
    'Industrial Metal Chair',
    'Urban industrial accent chair',
    279.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'accent-chair' AND category_id = c.id),
    20,
    'in_stock'::stock_status,
    '{"color":["Light Gray","Warm Oak"],"material":["Solid Wood","Fabric"],"style":["Modern","Scandinavian"],"room":["Living Room","Bedroom","Office"],"occasion":["Everyday","Relaxation"]}',
    '{"primaryColors":[{"name":"Light Gray","hex":"#D3D3D3","category":"primary"},{"name":"Warm Oak","hex":"#C19A6B","category":"secondary"}],"pattern":"solid","texture":"smooth","finish":"natural","shape":"angular","silhouette":"Low-profile with clean lines"}',
    '{"short":"Industrial Metal Chair offers a rugged elegance with its sturdy metal frame and sleek design.","long":"The Industrial Metal Chair is a striking addition to any space, blending the robust charm of metal with a sleek, contemporary design. Perfect for lofts, modern homes, or eclectic spaces, this chair features a durable metal construction that promises longevity. Its clean lines and minimalist silhouette make it a versatile piece, while the metallic finish adds a touch of industrial flair. Imagine this chair accenting your dining room or adding character to your home office. With a seat designed for comfort, it’s not just about looks – it’s about functionality too. Priced at $279.99, it offers style and durability in one stunning package.","features":["Sturdy metal frame for durability","Elegant metallic finish","Minimalist silhouette","Comfortable seating design","Versatile use for various spaces","Industrial style appeal","Easy to clean surface"],"careInstructions":"Wipe clean with a damp cloth. Avoid abrasive cleaning products to protect the finish.","materialComposition":"100% high-grade metal construction"}',
    '["living-room","office","industrial","metal","accent chair","modern furniture","Scandinavian style","wooden chair","gray upholstery","living room","bedroom","minimalist design","comfortable seating","elegant chair","home decor","interior design","stylish chair","natural finish","solid wood","fabric upholstery","curved armrests","plush cushion","low-profile","clean lines","relaxation","everyday use","industrial metal chair","metal chair design","durable seating","contemporary chair","loft furniture","home office chair","metallic finish chair","minimalist chair","dining room chair","eclectic furniture","industrial style","metal chair for home","robust metal chair","sleek chair design","metal furniture","modern home decor","metal chair for office","metal chair for loft","industrial decor","metal chair with clean lines","metal chair accent","metal chair with longevity","metal chair for modern spaces","metal chair with functionality"]',
    '{"metaTitle":"Industrial Metal Chair - Durable & Stylish Seating","metaDescription":"Enhance your space with the Industrial Metal Chair. Durable metal construction and sleek design for $279.99. Buy now for style and comfort!","altText":"Industrial Metal Chair with robust metal construction and sleek design.","keywords":["industrial metal chair","modern furniture","metal chair design","durable seating","contemporary chair","loft furniture","home office chair","metallic finish chair","minimalist chair","stylish chair","comfortable seating","dining room chair","eclectic furniture","industrial style","metal chair for home","robust metal chair","sleek chair design","metal furniture","modern home decor","metal chair for office","metal chair for loft","industrial decor","metal chair with clean lines","metal chair accent","metal chair with longevity","metal chair for modern spaces","metal chair with functionality"]}',
    FALSE,
    FALSE,
    4.4,
    87,
    TRUE,
    '2024-01-22T00:00:00Z',
    '2024-01-22T00:00:00Z'
FROM categories c
WHERE c.slug = 'furniture'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Velvet Barrel Chair
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'FURN-CHR-007',
    'Velvet Barrel Chair',
    'Cozy barrel-shaped velvet chair',
    479.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'accent-chair' AND category_id = c.id),
    14,
    'in_stock'::stock_status,
    '{"color":["Terracotta"],"material":["Velvet","Wood"],"style":["Contemporary"],"room":["Living Room","Bedroom"],"occasion":["Everyday","Relaxation"]}',
    '{"primaryColors":[{"name":"Terracotta","hex":"#E2725B","category":"primary"}],"pattern":"solid","texture":"velvet","finish":"matte","shape":"angular","silhouette":"Low-profile with angular armrests"}',
    '{"short":"Elegant velvet barrel chair with angular armrests and solid wood frame.","long":"Introducing the Velvet Barrel Chair, a masterpiece of modern elegance that transforms any room into a statement of style. Wrapped in lush terracotta velvet, its warm hues create a welcoming ambiance. The chair''s angular armrests and robust wooden frame offer a blend of contemporary design and timeless sophistication. Sink into the plush cushioning, perfect for a cozy reading nook or as a chic accent in your living room. With durable construction and a low-profile silhouette, this chair promises both comfort and luxury. Elevate your home decor with this stunning piece, where form meets function in the most beautiful way.","features":["Luxurious terracotta velvet upholstery","Sturdy solid wood frame","Angular armrests for modern flair","Plush cushioning for ultimate comfort","Contemporary, low-profile design","Versatile for living rooms and bedrooms","Elegant matte finish"],"careInstructions":"Spot clean with a damp cloth and mild detergent. Avoid direct sunlight to prevent fading. Vacuum regularly to maintain the texture.","materialComposition":"Premium velvet upholstery with a solid wood frame"}',
    '["living-room","bedroom","barrel","velvet","velvet chair","barrel chair","contemporary furniture","living room seating","wooden frame","terracotta color","comfortable seating","accent chair","modern design","home decor","stylish chair","reading nook","plush cushioning","elegant furniture","interior design","cozy chair","furniture piece","warm tones","quality materials","durable construction","textured velvet","matte finish","angular silhouette","low-profile design","armchair","home seating","decorative chair","luxury seating","sophisticated style","wood and velvet","trendy furniture","velvet barrel chair","contemporary design","terracotta velvet","comfortable armchair","modern accent chair","cozy seating"]',
    '{"metaTitle":"Velvet Barrel Chair - Elegant Terracotta Design","metaDescription":"Discover the Velvet Barrel Chair, a blend of comfort and style. Perfect for your living room. Order now to elevate your home decor!","altText":"Elegant velvet barrel chair with terracotta upholstery and wooden frame, featuring angular armrests.","keywords":["velvet barrel chair","elegant furniture","contemporary design","terracotta velvet","wooden frame","living room seating","comfortable armchair","modern accent chair","home decor","plush cushioning","stylish chair","reading nook","interior design","cozy seating","quality materials","durable construction","textured velvet","matte finish","angular silhouette","low-profile design","luxury seating","sophisticated style","wood and velvet","trendy furniture","warm tones","decorative chair"]}',
    TRUE,
    FALSE,
    4.7,
    145,
    TRUE,
    '2024-01-25T00:00:00Z',
    '2024-01-25T00:00:00Z'
FROM categories c
WHERE c.slug = 'furniture'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Slipper Chair
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'FURN-CHR-008',
    'Slipper Chair',
    'Armless slipper chair for compact spaces',
    299.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'accent-chair' AND category_id = c.id),
    25,
    'in_stock'::stock_status,
    '{"color":["Vibrant Orange","Cream"],"material":["Linen-like Fabric","Wood"],"style":["Modern","Contemporary"],"room":["Living Room","Bedroom"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Vibrant Orange","hex":"#FF7F50","category":"primary"},{"name":"Cream","hex":"#FFFDD0","category":"secondary"}],"pattern":"abstract","texture":"textured","finish":"matte","shape":"rounded","silhouette":"Low-profile with rounded edges"}',
    '{"short":"Brighten your space with this vibrant slipper chair featuring a bold abstract pattern and plush comfort.","long":"Transform your living space with our stunning slipper chair, designed to add a splash of color and style to any room. Its vibrant orange and cream abstract pattern is both eye-catching and sophisticated, perfect for modern and contemporary settings. The chair''s armless design and tufted back not only enhance its sleek profile but also provide exceptional comfort, making it an ideal choice for compact areas. Sink into the rounded silhouette and enjoy the plush cushioning that invites relaxation. Upholstered in a linen-like fabric, this chair offers a textured touch that complements its bold aesthetic. Whether placed in your living room or bedroom, this piece promises to be a conversation starter and a favorite spot to unwind.","features":["Bold orange and cream abstract pattern","Armless design suited for compact spaces","Tufted back for added style and comfort","Plush cushioning for ultimate relaxation","Rounded silhouette enhances modern appeal","Linen-like fabric for textured sophistication"],"careInstructions":"Spot clean with a damp cloth and mild detergent. Avoid exposure to direct sunlight to prevent color fading.","materialComposition":"Linen-like fabric upholstery with a sturdy wooden frame"}',
    '["living-room","bedroom","slipper","compact","slipper chair","accent chair","modern furniture","abstract pattern","orange chair","cream chair","living room","compact spaces","tufted back","textured fabric","rounded design","comfortable seating","stylish decor","contemporary style","vibrant colors","home furniture","decorative chair","plush cushioning","unique design","interior design","statement piece","furniture","home accents","seating","armless chair","modern decor","bold pattern","colorful furniture","linen-like fabric","wooden frame","matte finish","tufted upholstery","low-profile chair","rounded edges","comfortable chair","stylish seating","home styling","furniture design","home improvement","room decor","home accessories","living room furniture","bedroom furniture"]',
    '{"metaTitle":"Slipper Chair with Abstract Pattern - Stylish & Comfy","metaDescription":"Enhance your space with our vibrant slipper chair, featuring a bold abstract pattern. Perfect for modern rooms. Shop now and transform your decor!","altText":"Vibrant slipper chair with orange and cream abstract pattern, armless design, tufted back.","keywords":["slipper chair","accent chair","modern furniture","abstract pattern","orange chair","cream chair","living room furniture","bedroom furniture","compact spaces","tufted back","textured fabric","rounded design","comfortable seating","stylish decor","contemporary style","vibrant colors","home furniture","decorative chair","plush cushioning","unique design","interior design","statement piece","furniture","home accents","seating","armless chair","modern decor","bold pattern","colorful furniture","linen-like fabric","wooden frame"]}',
    FALSE,
    TRUE,
    4.5,
    112,
    TRUE,
    '2024-01-28T00:00:00Z',
    '2024-01-28T00:00:00Z'
FROM categories c
WHERE c.slug = 'furniture'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Club Chair
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'FURN-CHR-009',
    'Club Chair',
    'Classic club chair with deep seating',
    599.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'accent-chair' AND category_id = c.id),
    8,
    'in_stock'::stock_status,
    '{"color":["Natural Rattan","Cream"],"material":["Rattan","Polyester"],"style":["Bohemian","Coastal"],"room":["Living Room","Patio","Sunroom"],"occasion":["Relaxation","Reading"]}',
    '{"primaryColors":[{"name":"Natural Rattan","hex":"#C2A378","category":"primary"},{"name":"Cream","hex":"#F5F5DC","category":"secondary"}],"pattern":"tufted","texture":"woven","finish":"natural","shape":"organic","silhouette":"Egg-shaped with a rounded base"}',
    '{"short":"Embrace comfort with our stylish Club Chair, featuring plush cushions and a chic design.","long":"Transform your living space with our luxurious Club Chair, priced at $599.99. This exquisite piece boasts a sophisticated design, melding comfort and style seamlessly. Enveloped in plush, inviting cushions, the chair is perfect for lounging or reading. Its robust construction assures longevity, while the elegant form adds a touch of class to any room. The neutral tones provide versatility, easily complementing various decor styles. Ideal for both indoor and outdoor settings, this chair is a must-have addition to your home. Whether you''re creating a cozy reading nook or enhancing your patio, the Club Chair is designed to elevate your space, offering the ultimate relaxation experience.","features":["Plush cushioned seating","Stylish and sophisticated design","Versatile neutral color palette","Sturdy and durable construction","Suitable for indoor and outdoor use","Enhances any decor style","Perfect for relaxation and reading"],"careInstructions":"For fabric care, spot clean using mild detergent or machine wash according to care label. Regularly dust the chair frame with a soft, dry cloth.","materialComposition":"Frame: Sturdy hardwood; Upholstery: High-quality polyester fabric; Cushions: Soft foam padding"}',
    '["living-room","office","club","leather","egg chair","rattan furniture","bohemian style","outdoor seating","indoor chair","comfortable seating","natural materials","woven texture","tufted cushions","neutral colors","patio furniture","sunroom decor","relaxation chair","reading nook","coastal decor","organic shape","durable construction","stylish design","versatile use","home decor","accent chair","modern bohemian","casual seating","egg-shaped chair","plush cushions","natural finish","woven rattan","comfort seating","indoor outdoor","club chair","luxurious chair","bohemian furniture","rattan chair","indoor outdoor chair","neutral tones","home accent chair","modern bohemian style"]',
    '{"metaTitle":"Luxurious Club Chair - Comfort & Style in Bohemian Design","metaDescription":"Elevate your space with our Club Chair, featuring plush cushions and a woven rattan frame. Perfect for indoor or outdoor use. Buy now for ultimate relaxation!","altText":"Egg-shaped club chair with woven rattan frame and plush tufted cushions in neutral tones.","keywords":["club chair","luxurious chair","bohemian furniture","rattan chair","plush cushions","comfortable seating","indoor outdoor chair","neutral tones","durable construction","egg-shaped chair","woven texture","natural materials","coastal decor","patio furniture","sunroom decor","reading nook","home accent chair","modern bohemian style","stylish design","versatile use","organic shape","natural finish","relaxation chair","casual seating"]}',
    FALSE,
    FALSE,
    4.8,
    167,
    TRUE,
    '2024-02-01T00:00:00Z',
    '2024-02-01T00:00:00Z'
FROM categories c
WHERE c.slug = 'furniture'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Papasan Chair
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'FURN-CHR-010',
    'Papasan Chair',
    'Cozy papasan bowl chair with cushion',
    249.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'accent-chair' AND category_id = c.id),
    30,
    'in_stock'::stock_status,
    '{"color":["Mustard Yellow","Warm Chestnut Brown"],"material":["Polyester","Solid Wood"],"style":["Contemporary","Eclectic"],"room":["Living Room","Bedroom"],"occasion":["Everyday","Relaxation"]}',
    '{"primaryColors":[{"name":"Mustard Yellow","hex":"#D4A23A","category":"primary"},{"name":"Warm Chestnut Brown","hex":"#8B5A2B","category":"secondary"}],"pattern":"solid","texture":"textured","finish":"matte","shape":"rectangular","silhouette":"Low-profile with rounded edges"}',
    '{"short":"Sink into the ultimate comfort with our Papasan Chair''s plush cushions and chic design.","long":"Transform your living space into a cozy retreat with our Papasan Chair, featuring an inviting mustard yellow cushion that exudes warmth and style. The generously padded, bowl-shaped seat cradles you in luxurious comfort, perfect for lounging or reading your favorite book. Supported by a robust solid wood frame in a rich chestnut brown finish, this chair is as durable as it is stylish. With its unique, eye-catching design, the Papasan Chair adds a playful yet sophisticated touch to any room, making it an ideal addition to both contemporary and eclectic decors.","features":["Mustard yellow, plush cushion for ultimate comfort","Sturdy solid wood frame for durability","Bowl-shaped seat design for a cozy experience","Rich chestnut brown finish adds warmth","Ideal for living rooms, bedrooms, or cozy nooks","Perfect blend of style and functionality"],"careInstructions":"Cushion: Spot clean with mild detergent. Frame: Wipe with a damp cloth and dry thoroughly.","materialComposition":"Cushion: Polyester; Frame: Solid Wood"}',
    '["living-room","bedroom","papasan","boho","accent chair","mustard yellow","contemporary","eclectic","living room","comfortable seating","modern design","stylish furniture","solid wood frame","plush cushions","home decor","interior design","cozy chair","textured fabric","rounded armrests","low-profile","durable","quality materials","easy maintenance","unique style","warm colors","trendy","fashionable","versatile","functional","decorative","relaxation","reading nook","seating","home improvement","furniture piece","room accent","space enhancer","Papasan Chair","mustard yellow chair","low-profile design","durable furniture","trendy furniture","fashionable chair","versatile seating","functional furniture","decorative chair","relaxation chair","reading nook chair","living room chair","bedroom chair"]',
    '{"metaTitle":"Papasan Chair - Mustard Yellow Comfort & Style","metaDescription":"Upgrade your living space with our Papasan Chair. Enjoy plush comfort and bold style. Order now for a cozy, stylish addition to any room.","altText":"Papasan Chair with mustard yellow cushion and solid wood frame, perfect for cozy living spaces.","keywords":["Papasan Chair","accent chair","mustard yellow chair","comfortable seating","modern design","stylish furniture","solid wood frame","plush cushions","home decor","interior design","cozy chair","textured fabric","rounded armrests","low-profile design","durable furniture","quality materials","easy maintenance","unique style","warm colors","trendy furniture","fashionable chair","versatile seating","functional furniture","decorative chair","relaxation chair","reading nook chair","living room chair","bedroom chair","space enhancer"]}',
    FALSE,
    TRUE,
    4.6,
    198,
    TRUE,
    '2024-02-05T00:00:00Z',
    '2024-02-05T00:00:00Z'
FROM categories c
WHERE c.slug = 'furniture'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Scandinavian Coffee Table
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'FURN-TBL-001',
    'Scandinavian Coffee Table',
    'Minimalist coffee table with clean lines',
    249.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'coffee-table' AND category_id = c.id),
    24,
    'in_stock'::stock_status,
    '{"color":["Warm Walnut"],"material":["Solid Wood"],"style":["Scandinavian","Minimalist"],"room":["Living Room"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Warm Walnut","hex":"#8B5A2B","category":"primary"}],"pattern":"solid","texture":"smooth","finish":"natural","shape":"rectangular","silhouette":"Low-profile with clean lines"}',
    '{"short":"Elegant Scandinavian coffee table with warm walnut tones and minimalist design for modern living rooms.","long":"Transform your living space with our Scandinavian Coffee Table, a masterpiece of minimalist elegance. This table features a sleek rectangular silhouette, highlighted by clean lines and a natural warm walnut finish that exudes sophistication. Crafted from solid wood, it promises durability and a robust structure, ideal for everyday use. The spacious tabletop offers ample room to display your favorite decor pieces, while the open shelf beneath provides practical storage for magazines or remote controls. Perfect for enhancing contemporary interiors, this coffee table seamlessly blends with various decor styles, adding a touch of understated luxury to your home.","features":["Sleek minimalist design","Warm walnut finish","Durable solid wood construction","Spacious tabletop for decor","Open shelf for additional storage","Rectangular shape with clean lines","Perfect for modern living rooms"],"careInstructions":"Wipe clean with a damp cloth; avoid using harsh chemicals to maintain its natural finish.","materialComposition":"Constructed from solid wood with a rich walnut finish"}',
    '["living-room","scandinavian","minimalist","coffee table","Scandinavian design","minimalist furniture","living room","solid wood","walnut finish","modern decor","functional storage","elegant design","home decor","interior design","stylish furniture","contemporary","clean lines","low-profile","rectangular table","natural finish","warm tones","durable","spacious surface","open shelf","solid construction","versatile","modern living room","decorative","furniture piece","home essentials","classic style","timeless design","wooden table","neutral tones","accent piece","quality craftsmanship","Scandinavian coffee table","living room table","solid wood coffee table","walnut finish table","modern decor table","functional storage table","elegant coffee table","home decor table","interior design table","contemporary table","clean lines furniture","low-profile table","rectangular coffee table","natural finish table","warm tones furniture","durable coffee table","spacious surface table","open shelf table","solid construction table","versatile furniture","modern living room table","decorative coffee table","home essentials table","classic style table","timeless design furniture","wooden coffee table"]',
    '{"metaTitle":"Scandinavian Coffee Table - Minimalist Design & Walnut Finish","metaDescription":"Elevate your living room with our Scandinavian Coffee Table. Featuring a minimalist design and warm walnut finish. Shop now for a touch of elegance!","altText":"Scandinavian coffee table with walnut finish and minimalist design.","keywords":["Scandinavian coffee table","minimalist furniture","living room table","solid wood coffee table","walnut finish table","modern decor table","functional storage table","elegant coffee table","home decor table","interior design table","stylish furniture","contemporary table","clean lines furniture","low-profile table","rectangular coffee table","natural finish table","warm tones furniture","durable coffee table","spacious surface table","open shelf table","solid construction table","versatile furniture","modern living room table","decorative coffee table","furniture piece","home essentials table","classic style table","timeless design furniture","wooden coffee table"]}',
    TRUE,
    TRUE,
    4.6,
    189,
    TRUE,
    '2024-01-08T00:00:00Z',
    '2024-01-08T00:00:00Z'
FROM categories c
WHERE c.slug = 'furniture'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Glass Top Coffee Table
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'FURN-TBL-002',
    'Glass Top Coffee Table',
    'Modern glass top with metal frame',
    349.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'coffee-table' AND category_id = c.id),
    16,
    'in_stock'::stock_status,
    '{"color":["Warm Chestnut Brown","Light Beige"],"material":["Wood Composite","Veneer"],"style":["Modern","Contemporary"],"room":["Living Room","Office"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Warm Chestnut Brown","hex":"#8B4513","category":"primary"},{"name":"Light Beige","hex":"#F5F5DC","category":"accent"}],"pattern":"solid","texture":"smooth","finish":"matte","shape":"round","silhouette":"low-profile with clean lines"}',
    '{"short":"Sophisticated glass top coffee table with sleek wooden accents.","long":"Elevate your living space with our Glass Top Coffee Table, a harmonious blend of modern elegance and functional design. The crystal-clear glass surface adds a touch of sophistication, allowing your decor to shine through while providing a sturdy platform for books, beverages, or decorative pieces. Supported by a robust wooden frame with a warm finish, this table offers both style and stability. Its minimalist lines make it a versatile centerpiece that complements any interior, from chic urban apartments to cozy suburban homes. Perfect for entertaining guests or enjoying quiet moments, this table is an essential addition to your home decor.","features":["Crystal-clear glass top for elegant display","Sturdy wooden frame with warm finish","Modern design with minimalist appeal","Ideal for displaying decor and serving refreshments","Versatile centerpiece for various interior styles","Durable construction ensures long-lasting use","Enhances any room with its modern elegance"],"careInstructions":"Clean the glass top with a glass cleaner. Use a soft, damp cloth for the wooden frame. Avoid harsh chemicals and direct sunlight.","materialComposition":"Tempered glass top with solid wood frame"}',
    '["living-room","glass","modern","coffee table","modern design","wood finish","living room furniture","round table","home decor","contemporary style","elegant","versatile","sturdy","smooth surface","matte finish","minimalist","office furniture","entertaining","low-profile","clean lines","accent table","beige","chestnut brown","home improvement","interior design","glass top coffee table","modern coffee table","elegant furniture","living room decor","home furniture","wood finish coffee table","round coffee table","minimalist table","contemporary design","sturdy coffee table","chic apartment furniture","suburban home decor","versatile centerpiece","entertaining furniture","stylish coffee table","warm chestnut brown","light beige accent","smooth surface table","matte finish furniture","low-profile table","clean lines furniture","office coffee table","modern aesthetic","wood composite table","veneer finish"]',
    '{"metaTitle":"Glass Top Coffee Table - Modern Elegance & Sturdy Design","metaDescription":"Elevate your living space with our Glass Top Coffee Table. Enjoy modern elegance and functional design. Shop now for style and stability in your home decor!","altText":"Elegant glass top coffee table with a sturdy wooden frame and warm chestnut brown finish.","keywords":["glass top coffee table","modern coffee table","elegant furniture","living room decor","home furniture","wood finish coffee table","round coffee table","minimalist table","contemporary design","sturdy coffee table","chic apartment furniture","suburban home decor","versatile centerpiece","entertaining furniture","stylish coffee table","warm chestnut brown","light beige accent","smooth surface table","matte finish furniture","low-profile table","clean lines furniture","office coffee table","accent table","home improvement","interior design","modern aesthetic","wood composite table","veneer finish"]}',
    FALSE,
    FALSE,
    4.5,
    134,
    TRUE,
    '2024-01-10T00:00:00Z',
    '2024-01-10T00:00:00Z'
FROM categories c
WHERE c.slug = 'furniture'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Rustic Wooden Coffee Table
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'FURN-TBL-003',
    'Rustic Wooden Coffee Table',
    'Solid wood farmhouse style coffee table',
    399.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'coffee-table' AND category_id = c.id),
    12,
    'in_stock'::stock_status,
    '{"color":["Warm Chestnut Brown"],"material":["Solid Wood"],"style":["Rustic","Farmhouse"],"room":["Living Room"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Warm Chestnut Brown","hex":"#8B5A2B","category":"primary"}],"pattern":"solid","texture":"natural","finish":"natural","shape":"rectangular","silhouette":"low-profile with smooth curves"}',
    '{"short":"Elegant rustic wooden coffee table with warm tones and smooth curves.","long":"Transform your living space with our Rustic Wooden Coffee Table, priced at $399.99. This exquisite piece boasts a warm chestnut brown finish, effortlessly blending into both modern and traditional settings. Crafted from 100% solid wood, it showcases natural grain textures that exude farmhouse charm. Its smooth, curved design provides a touch of elegance, while the low-profile silhouette offers versatility and style. Perfect for displaying decor or serving refreshments, this coffee table is a true centerpiece for cozy gatherings. Imagine the rich, earthy tones enhancing your room''s ambiance, making it a welcoming space for family and friends.","features":["Solid wood construction for durability","Warm chestnut brown finish","Smooth, curved silhouette","Versatile low-profile design","Natural wood grain texture","Elegant centerpiece for living spaces","Blends with modern and traditional decor"],"careInstructions":"Wipe with a damp cloth to maintain cleanliness. Avoid using harsh chemicals. Employ coasters to prevent stains and rings.","materialComposition":"100% solid wood"}',
    '["living-room","rustic","farmhouse","wood","rustic coffee table","wooden furniture","farmhouse decor","living room table","solid wood","natural finish","curved design","home decor","elegant furniture","low-profile table","warm brown","chestnut finish","cozy gatherings","versatile table","modern rustic","traditional style","centerpiece table","smooth texture","wood grain","solid construction","durable furniture","stylish coffee table","home essentials","decorative table","functional design","entertaining furniture","natural materials","quality craftsmanship","living room centerpiece","unique design","classic style","warm tones","easy maintenance","eco-friendly","handcrafted","artisan furniture","interior design","home improvement","luxury furniture","designer table","premium quality"]',
    '{"metaTitle":"Rustic Wooden Coffee Table - Solid Wood & Elegant Design","metaDescription":"Enhance your living space with our Rustic Wooden Coffee Table. Crafted from solid wood, its elegant curved design is perfect for modern and traditional settings. Order now!","altText":"Rustic wooden coffee table with a warm chestnut brown finish and smooth curved design.","keywords":["rustic coffee table","wooden furniture","farmhouse decor","living room table","solid wood","natural finish","curved design","home decor","elegant furniture","low-profile table","warm brown","chestnut finish","cozy gatherings","versatile table","modern rustic","traditional style","centerpiece table","smooth texture","wood grain","solid construction","durable furniture","stylish coffee table","home essentials","decorative table","functional design","entertaining furniture","natural materials","quality craftsmanship","living room centerpiece","unique design"]}',
    TRUE,
    TRUE,
    4.8,
    212,
    TRUE,
    '2024-01-12T00:00:00Z',
    '2024-01-12T00:00:00Z'
FROM categories c
WHERE c.slug = 'furniture'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Marble Top Coffee Table
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'FURN-TBL-004',
    'Marble Top Coffee Table',
    'Elegant marble top with brass legs',
    549.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'coffee-table' AND category_id = c.id),
    8,
    'in_stock'::stock_status,
    '{"color":["Warm Chestnut"],"material":["Solid Wood"],"style":["Contemporary","Organic"],"room":["Living Room"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Warm Chestnut","hex":"#A0522D","category":"primary"}],"pattern":"solid","texture":"smooth","finish":"natural","shape":"organic","silhouette":"Low-profile with curved legs"}',
    '{"short":"Elegantly crafted marble top coffee table with sleek gold accents.","long":"Elevate your living space with the exquisite Marble Top Coffee Table, priced at $549.99. This luxurious table boasts a smooth, cool marble surface that gleams with sophistication, perfectly complemented by sleek gold accents and sturdy legs. Ideal for modern and classic interiors, its minimalist design allows it to blend seamlessly while offering a statement piece. The marble''s natural veining adds unique character, ensuring that no two tables are alike. Whether you''re hosting elegant gatherings or enjoying quiet evenings, this coffee table combines beauty and functionality, offering a durable surface for your decor and beverages.","features":["Smooth marble top","Sleek gold accents","Unique natural veining","Sturdy construction","Modern minimalist design","Durable and functional","Statement piece"],"careInstructions":"Clean with a damp, soft cloth. Avoid abrasive cleaners. Use coasters to protect the marble surface.","materialComposition":"Top: Natural marble; Base: Metal with gold finish."}',
    '["living-room","marble","luxury","contemporary","coffee table","wooden","living room","organic design","curved legs","natural finish","solid wood","stylish","elegant","modern","home decor","furniture","centerpiece","warm chestnut","unique design","low-profile","casual gatherings","artistic","functional","marble coffee table","luxury furniture","gold accent table","modern coffee table","classic interior furniture","elegant coffee table","sophisticated table design","unique marble veining","living room centerpiece","durable coffee table","stylish table decor","home decor table","functional coffee table","statement furniture piece","marble tabletop","gold accented furniture","minimalist coffee table","hosting table","quiet evening table","marble surface table","sleek coffee table","designer coffee table","artistic furniture","solid wood construction","warm chestnut finish","organic shape table","contemporary style furniture","unique design coffee table","low-profile table","elegant gatherings table"]',
    '{"metaTitle":"Marble Top Coffee Table - Luxurious Gold Accents","metaDescription":"Discover the Marble Top Coffee Table at $549.99. Elevate your living space with its sophisticated marble and gold accents. Shop now for elegance and functionality!","altText":"Marble Top Coffee Table with sleek gold accents and sturdy legs, ideal for modern and classic interiors.","keywords":["marble coffee table","luxury furniture","gold accent table","modern coffee table","classic interior furniture","elegant coffee table","sophisticated table design","unique marble veining","living room centerpiece","durable coffee table","stylish table decor","home decor table","functional coffee table","statement furniture piece","marble tabletop","gold accented furniture","minimalist coffee table","hosting table","quiet evening table","marble surface table","sleek coffee table","designer coffee table","artistic furniture","solid wood construction","warm chestnut finish","organic shape table","contemporary style furniture","unique design coffee table","low-profile table","elegant gatherings table"]}',
    TRUE,
    FALSE,
    4.9,
    156,
    TRUE,
    '2024-01-15T00:00:00Z',
    '2024-01-15T00:00:00Z'
FROM categories c
WHERE c.slug = 'furniture'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Industrial Pipe Coffee Table
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'FURN-TBL-005',
    'Industrial Pipe Coffee Table',
    'Industrial style with pipe legs',
    299.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'coffee-table' AND category_id = c.id),
    18,
    'in_stock'::stock_status,
    '{"color":["Walnut Brown"],"material":["Solid Wood"],"style":["Modern","Contemporary"],"room":["Living Room"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Walnut Brown","hex":"#7E5A45","category":"primary"}],"pattern":"solid","texture":"smooth","finish":"natural","shape":"round","silhouette":"Low-profile with sculptural base"}',
    '{"short":"Sturdy coffee table with vintage industrial style and robust pipe detailing.","long":"The Industrial Pipe Coffee Table is a striking blend of rugged charm and modern functionality. Its robust design features a solid wood top with rich grain patterns, complemented by a distinctive pipe framework that adds a touch of vintage industrial flair. Ideal for loft spaces or modern homes, this table serves as a bold centerpiece, offering generous surface space for decor, books, or your favorite beverage. The harmonious mix of wood and metal effortlessly enhances your living room ambiance, creating a unique and inviting atmosphere.","features":["Durable solid wood top","Unique industrial pipe frame","Bold vintage aesthetic","Generous surface space","Perfect for loft and modern decor","Rich wood grain patterns","Sturdy construction"],"careInstructions":"Clean with a soft, damp cloth. Avoid harsh chemicals. Ensure metal frame is regularly dusted to prevent rust.","materialComposition":"Top: Solid Hardwood; Frame: Metal Pipes"}',
    '["living-room","industrial","pipe","coffee table","walnut","round table","modern design","living room furniture","elegant","contemporary","wood grain","organic shape","home decor","centerpiece","stylish","functional","versatile","warm tones","sculptural base","smooth finish","solid wood","natural finish","low-profile","sophisticated","interior design","decor","furniture","home","entertaining","everyday use","Industrial Pipe Coffee Table","rugged coffee table","modern coffee table","vintage flair furniture","solid wood table","pipe framework table","loft space furniture","living room centerpiece","bold coffee table","modern home decor","wood and metal table","unique coffee table","inviting atmosphere furniture","furniture for lofts","wood grain coffee table","vintage industrial table","elegant coffee table","round walnut table","sculptural base table","smooth wood finish","contemporary coffee table","versatile decor table","modern design furniture","elegant and modern style","solid walnut wood table","natural finish table","low-profile table","sophisticated coffee table"]',
    '{"metaTitle":"Industrial Pipe Coffee Table - Robust Design & Vintage Flair","metaDescription":"Transform your living room with the Industrial Pipe Coffee Table. Enjoy its rugged charm and modern functionality. Order now for a bold statement!","altText":"Industrial Pipe Coffee Table with solid wood top and pipe framework.","keywords":["Industrial Pipe Coffee Table","rugged coffee table","modern coffee table","vintage flair furniture","solid wood table","pipe framework table","loft space furniture","living room centerpiece","bold coffee table","modern home decor","wood and metal table","unique coffee table","inviting atmosphere furniture","furniture for lofts","wood grain coffee table","vintage industrial table","elegant coffee table","round walnut table","sculptural base table","smooth wood finish","contemporary coffee table","versatile decor table","modern design furniture","living room furniture","elegant and modern style","solid walnut wood table","natural finish table","low-profile table","sophisticated coffee table"]}',
    FALSE,
    FALSE,
    4.5,
    98,
    TRUE,
    '2024-01-18T00:00:00Z',
    '2024-01-18T00:00:00Z'
FROM categories c
WHERE c.slug = 'furniture'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Round Nesting Tables Set
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'FURN-TBL-006',
    'Round Nesting Tables Set',
    'Set of 2 nesting coffee tables',
    279.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'coffee-table' AND category_id = c.id),
    20,
    'in_stock'::stock_status,
    '{"color":["Warm Oak"],"material":["Solid Wood"],"style":["Modern","Contemporary"],"room":["Living Room"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Warm Oak","hex":"#C19A6B","category":"primary"}],"pattern":"solid","texture":"natural","finish":"natural","shape":"organic","silhouette":"Low-profile with a unique curved form"}',
    '{"short":"Sophisticated three-piece round nesting tables set, perfect for versatile home decor and functionality.","long":"Enhance your living space with the elegant Round Nesting Tables Set, a trio designed for both style and practicality. Crafted from rich, warm wood, these tables feature a smooth, circular silhouette that seamlessly fits into any room. Perfect for entertaining or everyday use, this set offers adaptable configurations to suit your needs. Stack them together for a compact look or spread them out for more surface area. Their minimalist design complements modern, contemporary, or even rustic decors, adding a touch of sophistication to your home. These tables are ideal for displaying your favorite decor pieces, serving guests, or simply enjoying a cozy cup of coffee.","features":["Three-piece nesting set for versatile use","Crafted from rich, warm wood","Smooth circular silhouette","Adaptable configuration options","Ideal for modern and contemporary decor","Compact and space-saving design","Minimalist aesthetic"],"careInstructions":"Clean with a soft, damp cloth; avoid abrasive cleaners to preserve the wood finish.","materialComposition":"Solid wood with a rich natural finish"}',
    '["living-room","nesting","round","set","coffee table","modern furniture","oak wood","living room","unique design","curved silhouette","natural finish","contemporary style","home decor","wooden table","elegant furniture","stylish","functional","storage","display","sophisticated","warm aesthetic","durable","natural texture","organic shape","low-profile","open design","solid wood","oak finish","interior design","decorative","centerpiece","versatile","minimalist","clean lines","neutral tones","home furnishing","quality craftsmanship","timeless","round nesting tables","nesting tables set","living room tables","wooden tables","oak wood tables","stackable tables","space-saving furniture","decorative tables","minimalist design","sophisticated furniture","versatile tables","compact furniture","stylish tables","functional tables","solid wood furniture","natural finish tables","modern home furniture","interior design tables","coffee tables set","entertaining tables","practical furniture","chic living room tables","rustic decor tables","adaptable furniture"]',
    '{"metaTitle":"Round Nesting Tables Set - Elegant & Versatile Furniture","metaDescription":"Upgrade your home with our Round Nesting Tables Set. Perfect for any decor, this elegant trio offers style and practicality. Order now for a chic living space!","altText":"Round Nesting Tables Set with a smooth, circular design in warm wood finish.","keywords":["round nesting tables","nesting tables set","elegant furniture","living room tables","wooden tables","modern furniture","contemporary style","oak wood tables","stackable tables","space-saving furniture","decorative tables","home decor","minimalist design","sophisticated furniture","versatile tables","compact furniture","stylish tables","functional tables","solid wood furniture","natural finish tables","quality craftsmanship","modern home furniture","interior design tables","coffee tables set","entertaining tables","practical furniture","chic living room tables","rustic decor tables","adaptable furniture"]}',
    FALSE,
    TRUE,
    4.6,
    145,
    TRUE,
    '2024-01-20T00:00:00Z',
    '2024-01-20T00:00:00Z'
FROM categories c
WHERE c.slug = 'furniture'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Lift Top Coffee Table
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'FURN-TBL-007',
    'Lift Top Coffee Table',
    'Functional lift top with storage',
    379.99,
    449.99,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'coffee-table' AND category_id = c.id),
    14,
    'in_stock'::stock_status,
    '{"color":["Warm Oak","Charcoal Gray"],"material":["Oak Wood","Metal"],"style":["Modern","Minimalist"],"room":["Living Room"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Warm Oak","hex":"#C19A6B","category":"primary"},{"name":"Charcoal Gray","hex":"#36454F","category":"accent"}],"pattern":"solid","texture":"natural","finish":"natural","shape":"rectangular","silhouette":"Low-profile with clean lines"}',
    '{"short":"Contemporary lift top coffee table in warm oak with sleek metal legs for modern interiors.","long":"Transform your living space with our Lift Top Coffee Table, a marvel of modern design and functionality. Crafted with a warm oak finish, this table exudes a natural elegance, while its sleek charcoal gray metal legs add a touch of contemporary flair. The ingenious lift top feature allows for easy access to hidden storage, perfect for stashing away remote controls, magazines, or coasters, keeping your living room tidy and clutter-free. Its minimalist profile seamlessly integrates into any modern decor, making it an ideal centerpiece for both entertaining guests and everyday relaxation. Durable and stylish, this coffee table promises to enhance your home''s aesthetic appeal while offering practical solutions for space-saving storage.","features":["Lift top design for concealed storage","Warm oak wood finish for natural elegance","Sleek charcoal gray metal legs for modern touch","Minimalist design complements any decor","Durable construction ensures long-lasting use","Space-saving solution for small living areas","Low-profile silhouette with clean lines"],"careInstructions":"Wipe clean with a damp cloth. Avoid using harsh chemicals or abrasive cleaners. Regularly check and tighten screws to maintain stability.","materialComposition":"Oak wood top, charcoal gray metal legs"}',
    '["living-room","lift-top","storage","functional","coffee table","lift top","modern","minimalist","oak wood","metal legs","living room","sleek design","durable","versatile","space-saving","home decor","furniture","contemporary","stylish","elegant","practical","easy access","warm finish","clean lines","low-profile","entertaining","everyday use","interior design","home improvement","best seller","on sale","featured","in stock","lift top coffee table","modern coffee table","oak coffee table","metal legs coffee table","minimalist coffee table","living room furniture","space-saving table","hidden storage table","elegant coffee table","contemporary coffee table","stylish coffee table","durable coffee table","versatile table","home decor table","practical coffee table","easy access storage","warm finish table","clean lines table","low-profile table","entertaining furniture","everyday use table","interior design coffee table","home improvement furniture","best seller coffee table","on sale coffee table","featured coffee table","in stock coffee table"]',
    '{"metaTitle":"Lift Top Coffee Table - Modern Design & Hidden Storage","metaDescription":"Enhance your living room with our Lift Top Coffee Table. Features hidden storage and sleek design. Perfect for modern homes. Shop now for elegance!","altText":"Modern lift top coffee table with sleek charcoal gray metal legs and warm oak finish.","keywords":["lift top coffee table","modern coffee table","oak coffee table","metal legs coffee table","minimalist coffee table","living room furniture","space-saving table","hidden storage table","elegant coffee table","contemporary coffee table","stylish coffee table","durable coffee table","versatile table","home decor table","practical coffee table","easy access storage","warm finish table","clean lines table","low-profile table","entertaining furniture","everyday use table","interior design coffee table","home improvement furniture","best seller coffee table","on sale coffee table","featured coffee table","in stock coffee table"]}',
    TRUE,
    TRUE,
    4.7,
    234,
    TRUE,
    '2024-01-22T00:00:00Z',
    '2024-01-22T00:00:00Z'
FROM categories c
WHERE c.slug = 'furniture'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Mid-Century Oval Table
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'FURN-TBL-008',
    'Mid-Century Oval Table',
    'Classic mid-century oval design',
    329.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'coffee-table' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Warm Walnut"],"material":["Solid Wood"],"style":["Mid-Century","Retro"],"room":["Living Room"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Warm Walnut","hex":"#8B5E3C","category":"primary"}],"pattern":"solid","texture":"smooth","finish":"natural","shape":"oval","silhouette":"Low-profile with sleek, tapered legs"}',
    '{"short":"Elegant mid-century oval table with a natural walnut finish.","long":"The Mid-Century Oval Table is a captivating centerpiece for any living room, blending elegance with timeless design. Its warm walnut finish envelops the solid wood structure, creating a smooth and inviting surface that beckons to be adorned with your favorite decor. The oval shape offers a generous area for entertaining or daily use, while the sleek, tapered legs add a touch of retro charm, ensuring the table remains a stylish staple for years to come. With its sturdy construction and classic silhouette, this table not only enhances your space with sophistication but also provides practical functionality.","features":["Mid-century design with retro charm","Smooth oval top for ample space","Crafted from solid wood for durability","Warm walnut finish for elegant appeal","Sleek, tapered legs for a stylish touch","Spacious surface for decor or daily use","Timeless piece for any home setting"],"careInstructions":"Wipe with a soft, damp cloth. Avoid using harsh chemicals to preserve the finish.","materialComposition":"Crafted entirely from solid wood with a rich walnut finish."}',
    '["living-room","mid-century","oval","retro","oval table","solid wood","walnut finish","living room","retro style","elegant design","tapered legs","natural finish","home decor","furniture","coffee table","classic style","smooth surface","sturdy construction","versatile","timeless piece","interior design","modern home","vintage charm","functional","stylish","spacious top","decorative","daily use","home furniture","wooden table","natural wood","elegant","simple design","warm tones","classic furniture","living space","home essentials","quality craftsmanship","durable","easy maintenance","contemporary","sophisticated","chic","home style","interior trend","fashionable","practical","comfortable","home improvement","luxury","affordable","mid-century table","solid wood furniture","walnut finish table","living room furniture","retro style table","elegant design table","tapered legs table","natural finish table","home decor table","classic style table","smooth surface table","sturdy construction table","versatile table","timeless piece table","interior design furniture","modern home table","vintage charm table","functional furniture","stylish table","spacious top table","decorative table","daily use furniture","natural wood table","elegant furniture","simple design table","warm tones table","living space furniture"]',
    '{"metaTitle":"Mid-Century Oval Table - Elegant Walnut Finish","metaDescription":"Enhance your living room with our Mid-Century Oval Table. Its elegant walnut finish and sturdy design make it a timeless centerpiece. Shop now!","altText":"Elegant mid-century oval table with warm walnut finish, tapered legs, and smooth surface.","keywords":["mid-century table","oval table","solid wood furniture","walnut finish table","living room furniture","retro style table","elegant design table","tapered legs table","natural finish table","home decor table","furniture","coffee table","classic style table","smooth surface table","sturdy construction table","versatile table","timeless piece table","interior design furniture","modern home table","vintage charm table","functional furniture","stylish table","spacious top table","decorative table","daily use furniture","home furniture","wooden table","natural wood table","elegant furniture","simple design table","warm tones table","classic furniture","living space furniture"]}',
    FALSE,
    FALSE,
    4.6,
    112,
    TRUE,
    '2024-01-25T00:00:00Z',
    '2024-01-25T00:00:00Z'
FROM categories c
WHERE c.slug = 'furniture'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Drum Coffee Table
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'FURN-TBL-009',
    'Drum Coffee Table',
    'Unique drum-shaped accent table',
    199.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'coffee-table' AND category_id = c.id),
    22,
    'in_stock'::stock_status,
    '{"color":["White","Natural Wood"],"material":["Metal","Wood"],"style":["Contemporary","Minimalist"],"room":["Living Room","Office"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"White","hex":"#FFFFFF","category":"primary"},{"name":"Natural Wood","hex":"#D2B48C","category":"secondary"}],"pattern":"solid","texture":"smooth","finish":"matte","shape":"round","silhouette":"Low-profile with clean lines"}',
    '{"short":"Sleek drum coffee table with a seamless blend of style and function.","long":"Elevate your space with the Drum Coffee Table, a stunning fusion of minimalist design and practicality. The smooth, round white top exudes modern elegance, while the natural wood legs add warmth and charm to your living room or office. Its neutral palette seamlessly integrates with diverse decor styles, making it a versatile centerpiece or accent table. Perfect for showcasing your favorite decor pieces or offering a convenient spot for coffee cups and books, this table is as functional as it is stylish.","features":["Smooth round white tabletop","Natural wood legs for warmth","Minimalist design for modern elegance","Versatile for various decor styles","Compact size fits small spaces","Easy-to-clean surface","Sturdy construction for durability"],"careInstructions":"Wipe clean with a soft, damp cloth. Avoid harsh chemicals and abrasive materials. Use coasters to prevent surface scratches.","materialComposition":"Crafted with a white painted metal top and sturdy natural wood legs."}',
    '["living-room","drum","accent","metallic","coffee table","living room","minimalist","contemporary","round table","white table","wood legs","modern decor","small space","versatile","home decor","office furniture","accent table","functional","stylish","neutral palette","clean lines","compact","easy to clean","centerpiece","drum coffee table","minimalist coffee table","round coffee table","white coffee table","wood leg coffee table","modern furniture","contemporary coffee table","living room table","office coffee table","stylish coffee table","small space furniture","neutral decor","versatile table","centerpiece table","easy to clean table","compact coffee table","minimalist design","wood and metal table","round white table","elegant coffee table","functional coffee table","smooth tabletop","matte finish table","natural wood legs","low-profile table","clean lines coffee table"]',
    '{"metaTitle":"Drum Coffee Table - Minimalist Design with Wood Legs","metaDescription":"Elevate your decor with the Drum Coffee Table. Modern elegance meets practicality. Shop now for a stylish centerpiece that complements any space!","altText":"Round drum coffee table with white top and natural wood legs, minimalist design.","keywords":["drum coffee table","minimalist coffee table","round coffee table","white coffee table","wood leg coffee table","modern furniture","contemporary coffee table","living room table","office coffee table","accent table","stylish coffee table","small space furniture","neutral decor","versatile table","home decor","centerpiece table","easy to clean table","compact coffee table","minimalist design","modern decor","wood and metal table","round white table","elegant coffee table","functional coffee table","smooth tabletop","matte finish table","natural wood legs","low-profile table","clean lines coffee table"]}',
    FALSE,
    FALSE,
    4.4,
    78,
    TRUE,
    '2024-01-28T00:00:00Z',
    '2024-01-28T00:00:00Z'
FROM categories c
WHERE c.slug = 'furniture'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Storage Ottoman Table
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'FURN-TBL-010',
    'Storage Ottoman Table',
    'Multifunctional ottoman with storage',
    259.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'coffee-table' AND category_id = c.id),
    26,
    'in_stock'::stock_status,
    '{"color":["Natural Wood"],"material":["Solid Wood"],"style":["Rustic","Modern"],"room":["Living Room"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Natural Wood","hex":"#D2B48C","category":"primary"}],"pattern":"solid","texture":"natural","finish":"natural","shape":"round","silhouette":"Low-profile with open structure"}',
    '{"short":"Rustic round ottoman table with natural wood finish and storage functionality.","long":"Bring a touch of rustic charm to your living space with the Storage Ottoman Table. Expertly crafted from solid wood, its round silhouette and natural wood finish offer an inviting warmth, ideal for both modern and farmhouse interiors. This multifunctional piece not only serves as a stunning centerpiece for your room but also provides practical storage space, perfect for magazines, throws, or other essentials. The smooth tabletop offers a pristine surface for decor or everyday items, enhancing your home''s aesthetic and functionality. With sturdy construction and an open design, this ottoman table is an elegant solution for any living room, blending style with utility seamlessly.","features":["Round shape for versatile placement","Natural wood finish complements various styles","Open storage design ideal for essentials","Rustic aesthetic enhances room ambiance","Smooth tabletop surface for decor display","Multifunctional use as table or ottoman","Sturdy construction ensures durability"],"careInstructions":"Wipe clean with a damp cloth. Avoid direct sunlight and excessive moisture to prevent damage.","materialComposition":"Crafted from high-quality solid wood for lasting durability."}',
    '["living-room","ottoman","storage","multifunctional","rustic table","wooden ottoman","living room furniture","storage solution","home decor","round coffee table","natural finish","modern design","farmhouse style","solid wood","unique design","decorative table","functional furniture","space-saving","cozy ambiance","earthy tones","sturdy construction","smooth surface","versatile use","interior styling","home improvement","practical storage","stylish accent","warm tones","natural aesthetics","open structure","decor display","living room centerpiece","wood craftsmanship","handcrafted look","artisan design","eco-friendly","storage ottoman table","rustic furniture","solid wood table","living room decor","multifunctional ottoman","natural wood finish","farmhouse style furniture","modern rustic design","home storage solutions","decorative ottoman","space-saving furniture","cozy living room","smooth tabletop surface","versatile home decor","stylish accent table","warm home ambiance","open storage design","eco-friendly furniture"]',
    '{"metaTitle":"Storage Ottoman Table - Rustic Charm & Practical Storage","metaDescription":"Elevate your living room with our rustic Storage Ottoman Table. Crafted from solid wood, it offers style and storage. Buy now for a cozy, functional space!","altText":"Rustic round storage ottoman table with natural wood finish and open storage design.","keywords":["storage ottoman table","rustic furniture","solid wood table","living room decor","multifunctional ottoman","round coffee table","natural wood finish","farmhouse style furniture","modern rustic design","home storage solutions","decorative ottoman","space-saving furniture","cozy living room","earthy tones","sturdy construction","smooth tabletop surface","versatile home decor","interior styling","home improvement","practical storage","stylish accent table","warm home ambiance","natural aesthetics","open storage design","living room centerpiece","wood craftsmanship","handcrafted look","artisan design","eco-friendly furniture"]}',
    FALSE,
    TRUE,
    4.5,
    167,
    TRUE,
    '2024-02-01T00:00:00Z',
    '2024-02-01T00:00:00Z'
FROM categories c
WHERE c.slug = 'furniture'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Modern Floating TV Stand
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'FURN-TV-001',
    'Modern Floating TV Stand',
    'Wall-mounted floating entertainment unit',
    399.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'tv-stand' AND category_id = c.id),
    15,
    'in_stock'::stock_status,
    '{"color":["Warm Chestnut Brown"],"material":["Solid Wood","Metal"],"style":["Modern","Contemporary"],"room":["Living Room"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Warm Chestnut Brown","hex":"#8B4513","category":"primary"}],"pattern":"textured","texture":"ribbed","finish":"natural","shape":"rectangular","silhouette":"sleek, low-profile with clean lines"}',
    '{"short":"Elevate your living room with this chic, ribbed wood modern floating TV stand.","long":"Transform your living space with the Modern Floating TV Stand, a stunning centerpiece that combines form and function. Its warm chestnut brown finish complements the ribbed wood texture, adding a touch of sophistication and depth to your decor. Crafted from solid wood, this sleek, wall-mounted design is perfect for those seeking a minimalist aesthetic with ample storage for media devices and accessories. The clean lines and contemporary silhouette make it an ideal choice for modern interiors, offering a stylish and organized solution for your entertainment needs. Bring elegance and practicality to your living room with this versatile piece.","features":["Sleek wall-mounted design","Ribbed wood texture for added elegance","Warm chestnut brown finish","Generous storage space for media equipment","Durable solid wood construction","Minimalist and contemporary silhouette","Ideal for modern living rooms"],"careInstructions":"Clean with a damp cloth. Avoid using harsh chemicals. Ensure secure attachment to the wall for safety.","materialComposition":"Constructed from solid wood with durable metal brackets for secure wall mounting."}',
    '["living-room","floating","wall-mounted","modern","TV stand","ribbed texture","chestnut brown","solid wood","contemporary","living room","sleek design","minimalist","media storage","entertainment unit","stylish","elegant","home decor","furniture","interior design","storage solution","organizer","clean lines","low-profile","warm finish","natural wood","durable","functional","space-saving","versatile","high-quality","easy maintenance","secure mounting","decorative","modern aesthetic","trendy","modern floating TV stand","wall-mounted TV stand","ribbed wood texture","chestnut brown TV stand","solid wood TV stand","contemporary TV stand","living room furniture","sleek TV stand design","minimalist TV stand","media storage unit","stylish TV stand","elegant home decor","interior design furniture","TV stand organizer","clean lines TV stand","low-profile TV stand","warm wood finish","natural wood TV stand","durable TV stand","functional TV stand","space-saving TV stand","versatile TV stand","high-quality TV stand","easy maintenance furniture","secure wall mounting","decorative TV stand","modern aesthetic furniture","trendy TV stand"]',
    '{"metaTitle":"Modern Floating TV Stand - Sleek Design with Ample Storage","metaDescription":"Upgrade your living room with our Modern Floating TV Stand. Enjoy sleek design and ample storage. Order now for a stylish and organized space!","altText":"Modern Floating TV Stand in chestnut brown with ribbed wood texture and ample storage.","keywords":["modern floating TV stand","wall-mounted TV stand","ribbed wood texture","chestnut brown TV stand","solid wood TV stand","contemporary TV stand","living room furniture","sleek TV stand design","minimalist TV stand","media storage unit","entertainment unit","stylish TV stand","elegant home decor","interior design furniture","storage solution","TV stand organizer","clean lines TV stand","low-profile TV stand","warm wood finish","natural wood TV stand","durable TV stand","functional TV stand","space-saving TV stand","versatile TV stand","high-quality TV stand","easy maintenance furniture","secure wall mounting","decorative TV stand","modern aesthetic furniture","trendy TV stand"]}',
    TRUE,
    TRUE,
    4.7,
    189,
    TRUE,
    '2024-01-05T00:00:00Z',
    '2024-01-05T00:00:00Z'
FROM categories c
WHERE c.slug = 'furniture'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Industrial TV Console
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'FURN-TV-002',
    'Industrial TV Console',
    'Industrial style with open shelving',
    349.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'tv-stand' AND category_id = c.id),
    18,
    'in_stock'::stock_status,
    '{"color":["Natural Oak"],"material":["Solid Wood"],"style":["Industrial","Modern"],"room":["Living Room"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Natural Oak","hex":"#C8A165","category":"primary"}],"pattern":"solid","texture":"smooth","finish":"natural","shape":"rectangular","silhouette":"Low-profile with clean lines"}',
    '{"short":"Stylish industrial TV console with natural wood finish and open shelving for modern spaces.","long":"Elevate your living room with our Industrial TV Console, a masterpiece of minimalist design and functionality. Crafted with a natural wood finish, this console exudes warmth, effortlessly blending into industrial and modern interiors. Its open shelving design offers generous space for your media devices and decorative pieces, making it as practical as it is aesthetically pleasing. The streamlined silhouette and sturdy construction promise durability and elegance, ensuring your space remains chic and tidy. Whether you''re hosting a movie night or enjoying a quiet evening, this console is the perfect addition to your home decor.","features":["Natural wood finish for a warm, inviting look","Open shelving for ample media and decor storage","Streamlined silhouette complements modern interiors","Sturdy construction ensures durability","Ideal for industrial and contemporary spaces","Low-profile design with clean lines","Easy to integrate into various decor styles"],"careInstructions":"Wipe with a soft, dry cloth to preserve finish. Avoid harsh chemicals or abrasive cleaners to maintain wood integrity.","materialComposition":"Crafted from solid wood with a smooth, natural finish"}',
    '["living-room","industrial","open-shelving","TV console","industrial style","modern design","open shelving","natural wood","living room furniture","media storage","minimalist","sleek design","durable construction","solid wood","natural finish","home entertainment","contemporary","elegant","functional","stylish","warm tones","clean lines","low-profile","versatile","decorative","practical","space-saving","sturdy","easy maintenance","neutral color","oak","furniture","home decor","interior design","Industrial TV Console","natural wood finish","minimalist design","sleek TV console","solid wood console","contemporary furniture","elegant TV stand","functional console","stylish media storage","warm tones furniture","clean lines console","low-profile TV stand","versatile furniture","decorative console","practical TV stand","space-saving console","sturdy construction","easy maintenance furniture","neutral color console","oak TV console","modern interiors","industrial interiors"]',
    '{"metaTitle":"Industrial TV Console - Natural Wood Finish, Open Shelving","metaDescription":"Elevate your space with our Industrial TV Console. Featuring a natural wood finish and open shelving, it''s perfect for modern and industrial decor. Buy now!","altText":"Sleek Industrial TV Console with natural wood finish and open shelving.","keywords":["Industrial TV Console","natural wood finish","open shelving","modern design","living room furniture","media storage","minimalist design","sleek TV console","durable construction","solid wood console","home entertainment","contemporary furniture","elegant TV stand","functional console","stylish media storage","warm tones furniture","clean lines console","low-profile TV stand","versatile furniture","decorative console","practical TV stand","space-saving console","sturdy construction","easy maintenance furniture","neutral color console","oak TV console","home decor","interior design","modern interiors","industrial interiors"]}',
    FALSE,
    TRUE,
    4.6,
    156,
    TRUE,
    '2024-01-08T00:00:00Z',
    '2024-01-08T00:00:00Z'
FROM categories c
WHERE c.slug = 'furniture'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Mid-Century Media Console
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'FURN-TV-003',
    'Mid-Century Media Console',
    'Retro-inspired media console with storage',
    449.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'tv-stand' AND category_id = c.id),
    12,
    'in_stock'::stock_status,
    '{"color":["Warm Walnut"],"material":["Walnut Wood"],"style":["Mid-Century Modern"],"room":["Living Room"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Warm Walnut","hex":"#7B5E57","category":"primary"}],"pattern":"solid","texture":"smooth","finish":"natural","shape":"rectangular","silhouette":"Low-profile with clean lines and tapered legs"}',
    '{"short":"Elegant mid-century media console with ample storage and sleek design.","long":"Transform your living room with the Mid-Century Media Console, a stylish blend of retro elegance and modern functionality. Crafted from rich walnut wood, its smooth, natural finish exudes warm tones that seamlessly fit into both contemporary and vintage-inspired interiors. This console is designed to accommodate all your electronics with multiple open shelves and spacious drawers, ensuring everything from gaming consoles to DVDs finds a perfect spot. The low-profile silhouette, complemented by tapered legs and clean lines, adds a touch of classic sophistication, making it an ideal centerpiece for any decor. Elevate your home with this timeless piece that combines aesthetic appeal and practical storage solutions.","features":["Mid-century modern design","Rich walnut wood with natural finish","Multiple open shelves for electronics","Spacious drawers for accessories","Low-profile silhouette with tapered legs","Sleek and clean lines","Versatile integration into modern and vintage decors"],"careInstructions":"Wipe with a soft, dry cloth regularly. Avoid exposure to harsh chemicals or abrasive cleaners to maintain its natural finish.","materialComposition":"Solid walnut wood construction"}',
    '["living-room","mid-century","retro","storage","media console","TV stand","walnut","living room","modern","vintage","furniture","home decor","elegant","stylish","functional","natural finish","wooden","clean lines","tapered legs","entertainment center","electronics storage","interior design","solid wood","warm tones","sleek design","versatile","spacious","drawer storage","open shelving","classic","timeless","high-quality","durable","easy maintenance","centerpiece","mid-century media console","walnut furniture","living room decor","retro design","modern functionality","vintage-inspired interiors","elegant furniture","stylish media console","solid wood console","spacious drawers","classic sophistication","timeless piece","high-quality furniture","durable media console","centerpiece furniture","warm walnut tones","versatile console","functional storage","low-profile silhouette"]',
    '{"metaTitle":"Mid-Century Media Console - Stylish Retro Elegance","metaDescription":"Transform your living room with the Mid-Century Media Console. Crafted from rich walnut wood, this elegant piece offers ample storage. Order now!","altText":"Mid-Century Media Console in walnut wood with open shelves and drawers, tapered legs.","keywords":["mid-century media console","TV stand","walnut furniture","living room decor","retro design","modern functionality","vintage-inspired interiors","elegant furniture","stylish media console","home decor","natural finish","solid wood console","electronics storage","entertainment center","clean lines","tapered legs","spacious drawers","open shelving","classic sophistication","timeless piece","high-quality furniture","durable media console","easy maintenance","centerpiece furniture","warm walnut tones","sleek design","versatile console","functional storage","low-profile silhouette"]}',
    TRUE,
    FALSE,
    4.8,
    201,
    TRUE,
    '2024-01-10T00:00:00Z',
    '2024-01-10T00:00:00Z'
FROM categories c
WHERE c.slug = 'furniture'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Fireplace TV Stand
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'FURN-TV-005',
    'Fireplace TV Stand',
    'TV stand with built-in electric fireplace',
    599.99,
    749.99,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'tv-stand' AND category_id = c.id),
    8,
    'in_stock'::stock_status,
    '{"color":["White","Warm Oak"],"material":["Wood","Metal"],"style":["Modern","Traditional"],"room":["Living Room"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"White","hex":"#FFFFFF","category":"primary"},{"name":"Warm Oak","hex":"#C19A6B","category":"accent"}],"pattern":"solid","texture":"smooth","finish":"matte","shape":"rectangular","silhouette":"Low-profile with clean lines"}',
    '{"short":"Elegant TV stand with a cozy electric fireplace, perfect for modern and traditional interiors.","long":"Transform your living room into a stylish and cozy retreat with our Fireplace TV Stand. This exquisite piece combines sleek modern design with traditional warmth, featuring a built-in electric fireplace that casts a comforting glow. Crafted from high-quality wood, it boasts a matte white finish complemented by warm oak accents. The spacious open shelves and closed cabinets provide ample storage for your media collection, electronics, and decorative accessories, making it both functional and elegant. Its low-profile silhouette and clean lines ensure it fits seamlessly into any decor style, enhancing your entertainment space while providing a welcoming ambiance.","features":["Built-in electric fireplace for warmth and ambiance","Spacious open shelving for easy access to media players","Closed cabinets to neatly store accessories and games","Matte white finish with warm oak accents for style","Compatible with modern and traditional decor","Low-profile design with clean lines for seamless integration","Durable wood construction with metal hardware"],"careInstructions":"Wipe with a soft, dry cloth. Avoid using harsh chemicals. Ensure the fireplace is turned off before cleaning.","materialComposition":"Constructed from premium quality wood with metal hardware and integrated electric components"}',
    '["living-room","fireplace","electric","cozy","TV stand","electric fireplace","living room furniture","modern design","traditional style","home entertainment","storage solution","cozy ambiance","white finish","wood accents","furniture","home decor","media console","entertainment center","stylish","functional","elegant","versatile","spacious","clean lines","matte finish","rectangular shape","smooth texture","low-profile","Fireplace TV Stand","modern TV stand","stylish furniture","functional TV stand","elegant design","versatile furniture","spacious shelving","low-profile silhouette","modern interior","furniture with fireplace","TV stand with storage","oak accents"]',
    '{"metaTitle":"Fireplace TV Stand - Modern Design with Cozy Fireplace","metaDescription":"Upgrade your living room with our Fireplace TV Stand. Enjoy sleek design and warmth with a built-in electric fireplace. Order now for style and comfort!","altText":"Elegant Fireplace TV Stand with built-in electric fireplace and storage shelves.","keywords":["Fireplace TV Stand","electric fireplace","modern TV stand","living room furniture","home entertainment","storage solution","cozy ambiance","white finish","wood accents","media console","entertainment center","stylish furniture","functional TV stand","elegant design","versatile furniture","spacious shelving","clean lines","matte finish","rectangular shape","smooth texture","low-profile silhouette","modern interior","traditional style","home decor","furniture with fireplace","TV stand with storage","oak accents"]}',
    TRUE,
    TRUE,
    4.9,
    278,
    TRUE,
    '2024-01-15T00:00:00Z',
    '2024-01-15T00:00:00Z'
FROM categories c
WHERE c.slug = 'furniture'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Scandinavian TV Bench
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'FURN-TV-007',
    'Scandinavian TV Bench',
    'Minimalist Scandinavian design bench',
    329.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'tv-stand' AND category_id = c.id),
    16,
    'in_stock'::stock_status,
    '{"color":["Warm Oak","Natural Beige"],"material":["Oak Wood","Metal"],"style":["Scandinavian","Minimalist"],"room":["Living Room"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Warm Oak","hex":"#C19A6B","category":"primary"},{"name":"Natural Beige","hex":"#D3B8A3","category":"secondary"}],"pattern":"ribbed","texture":"textured","finish":"natural","shape":"rectangular","silhouette":"Low-profile with clean lines"}',
    '{"short":"Stylish Scandinavian TV bench with warm oak finish and textured ribbed doors.","long":"Enhance your living space with the Scandinavian TV Bench, a perfect blend of minimalist charm and functional design. Crafted from high-quality oak wood, this bench showcases a warm and inviting finish that seamlessly fits into any decor style. Its ribbed cabinet doors add a touch of texture and sophistication, offering visual intrigue. Designed for practicality, the bench provides ample storage for media devices and accessories, ensuring your living area stays organized and uncluttered. With its sleek, low-profile silhouette, this piece is more than just furniture; it''s a statement of elegance that harmonizes with your home''s aesthetic.","features":["Minimalist Scandinavian design","Warm oak wood finish","Textured ribbed cabinet doors","Generous storage capacity","Sleek low-profile silhouette","Versatile decor integration","Durable metal hardware"],"careInstructions":"Clean with a damp cloth and mild soap. Avoid harsh chemicals to maintain the wood''s natural finish.","materialComposition":"Crafted from oak wood with sturdy metal hardware for durability."}',
    '["living-room","scandinavian","minimalist","bench","Scandinavian TV bench","oak wood furniture","ribbed design","minimalist style","living room storage","media console","natural wood finish","modern furniture","home decor","TV stand","entertainment center","stylish storage","functional design","elegant furniture","textured cabinet doors","versatile piece","clean lines","low-profile","organize media","interior design","contemporary furniture","wooden TV stand","metal hardware","natural aesthetic","home organization","sleek silhouette","warm tones","neutral colors","living room furniture","oak finish","modern home"]',
    '{"metaTitle":"Scandinavian TV Bench - Minimalist Charm & Ample Storage","metaDescription":"Elevate your living room with the Scandinavian TV Bench. Crafted from warm oak, it offers ample storage and a sleek design. Order now for a stylish upgrade!","altText":"Scandinavian TV bench with natural oak finish and ribbed cabinet doors, perfect for media storage.","keywords":["Scandinavian TV bench","oak wood furniture","ribbed design","minimalist style","living room storage","media console","natural wood finish","modern furniture","home decor","TV stand","entertainment center","stylish storage","functional design","elegant furniture","textured cabinet doors","versatile piece","clean lines","low-profile","organize media","interior design","contemporary furniture","wooden TV stand","metal hardware","natural aesthetic","home organization","sleek silhouette","warm tones","neutral colors","living room furniture","oak finish","modern home"]}',
    FALSE,
    TRUE,
    4.6,
    145,
    TRUE,
    '2024-01-20T00:00:00Z',
    '2024-01-20T00:00:00Z'
FROM categories c
WHERE c.slug = 'furniture'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Rustic Barn Door TV Stand
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'FURN-TV-008',
    'Rustic Barn Door TV Stand',
    'Farmhouse style with sliding barn doors',
    429.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'tv-stand' AND category_id = c.id),
    10,
    'in_stock'::stock_status,
    '{"color":["Warm Oak"],"material":["Solid Wood","Oak Veneer"],"style":["Rustic","Farmhouse"],"room":["Living Room","Family Room"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Warm Oak","hex":"#C19A6B","category":"primary"}],"pattern":"solid","texture":"smooth","finish":"natural","shape":"rectangular","silhouette":"low-profile with clean lines"}',
    '{"short":"Elegant rustic TV stand with sliding barn doors and storage.","long":"Transform your living space with the Rustic Barn Door TV Stand, a stunning blend of farmhouse charm and contemporary functionality. Its warm oak finish radiates a cozy atmosphere, perfect for enhancing modern rustic interiors. The sliding barn doors offer easy access to generous storage compartments, ideal for housing electronics and decor. Meticulously crafted from solid wood with an oak veneer, this TV stand promises durability and timeless style. A versatile piece, it complements any living room or family room setup, providing both aesthetic appeal and practical organization. Elevate your home entertainment area with this exquisite, sturdy piece that marries rustic elegance with modern design.","features":["Warm oak finish for a cozy ambiance","Sliding barn doors for easy access","Generous storage compartments","Durable solid wood construction","Oak veneer for a timeless look","Compliments rustic and modern interiors","Low-profile design with clean lines"],"careInstructions":"Dust regularly using a dry, soft cloth. Avoid using harsh chemicals or abrasive cleaners to protect the finish.","materialComposition":"Crafted from solid wood with an oak veneer finish"}',
    '["living-room","rustic","barn-door","farmhouse","TV stand","living room furniture","rustic style","farmhouse decor","oak finish","wooden furniture","storage solution","barn door design","home entertainment","solid wood","oak veneer","modern rustic","home decor","furniture","media console","stylish storage","durable construction","natural finish","rectangular shape","clean lines","low-profile design","easy access","warm tones","cozy charm","interior design","functional furniture","organizing solution","entertainment center","classic design","versatile piece","home organization","living room setup","decorative furniture","quality craftsmanship","elegant design","space-saving","trendsetting","popular choice","stylish addition","rustic elegance","farmhouse charm","home styling","furniture piece","room enhancement","decorative storage","Rustic Barn Door TV Stand","Farmhouse TV Stand","Living Room Furniture","Oak Finish TV Stand","Wooden TV Stand","Storage Solution","Barn Door Design","Home Entertainment","Solid Wood Furniture","Oak Veneer","Modern Rustic Style","Home Decor","Media Console","Stylish Storage","Durable Construction","Natural Finish","Rectangular Shape","Clean Lines","Low-Profile Design","Easy Access Storage","Warm Tones","Cozy Charm","Interior Design","Functional Furniture","Organizing Solution","Entertainment Center","Classic Design","Versatile Piece","Home Organization","Living Room Setup","Decorative Furniture","Quality Craftsmanship"]',
    '{"metaTitle":"Rustic Barn Door TV Stand - Farmhouse Style with Ample Storage","metaDescription":"Elevate your living space with the Rustic Barn Door TV Stand. Enjoy farmhouse charm and modern functionality. Shop now for stylish storage solutions!","altText":"Rustic Barn Door TV Stand with warm oak finish and sliding barn doors for ample storage.","keywords":["Rustic Barn Door TV Stand","Farmhouse TV Stand","Living Room Furniture","Oak Finish TV Stand","Wooden TV Stand","Storage Solution","Barn Door Design","Home Entertainment","Solid Wood Furniture","Oak Veneer","Modern Rustic Style","Home Decor","Media Console","Stylish Storage","Durable Construction","Natural Finish","Rectangular Shape","Clean Lines","Low-Profile Design","Easy Access Storage","Warm Tones","Cozy Charm","Interior Design","Functional Furniture","Organizing Solution","Entertainment Center","Classic Design","Versatile Piece","Home Organization","Living Room Setup","Decorative Furniture","Quality Craftsmanship"]}',
    TRUE,
    FALSE,
    4.7,
    167,
    TRUE,
    '2024-01-22T00:00:00Z',
    '2024-01-22T00:00:00Z'
FROM categories c
WHERE c.slug = 'furniture'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: LED Light TV Stand
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'FURN-TV-009',
    'LED Light TV Stand',
    'Modern stand with RGB LED lighting',
    359.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'tv-stand' AND category_id = c.id),
    22,
    'in_stock'::stock_status,
    '{"color":["Honey Oak"],"material":["Solid Wood","Metal"],"style":["Mid-Century Modern","Contemporary"],"room":["Living Room"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Honey Oak","hex":"#D8A165","category":"primary"}],"pattern":"solid","texture":"smooth","finish":"natural","shape":"rectangular","silhouette":"Low-profile with clean lines"}',
    '{"short":"Elevate your entertainment space with this chic LED Light TV Stand featuring customizable lighting and ample storage.","long":"Transform your living room into a modern oasis with the LED Light TV Stand. Crafted to blend contemporary style with functionality, this sleek stand features integrated LED lights that offer customizable colors to set the perfect ambiance. Its smooth, high-gloss finish complements any decor, while the spacious cabinets and open shelves provide ample storage for your media devices, gaming consoles, and decor. The stand’s sturdy construction ensures it will be a long-lasting addition to your home. Enhance your entertainment experience and impress guests with this stunning piece that combines style and practicality.","features":["Customizable LED lighting with remote control","High-gloss, smooth finish","Spacious cabinets and open shelves","Sturdy construction for lasting durability","Contemporary design that complements modern decor","Ample storage for media devices"],"careInstructions":"Dust regularly with a soft cloth. Clean with a damp cloth and mild detergent as needed. Avoid abrasive cleaners.","materialComposition":"Manufactured wood, tempered glass, and LED lighting components"}',
    '["living-room","led","rgb","gaming","TV stand","living room furniture","storage","media console","modern design","mid-century style","honey oak","home decor","entertainment center","wooden furniture","sleek design","contemporary","rustic charm","versatile storage","durable construction","elegant","stylish","interior design","furniture","home organization","media storage","decorative","functional","practical","quality materials","easy maintenance","warm finish","clean lines","low-profile","tapered legs","solid wood","metal hardware","LED Light TV Stand","modern TV stand","contemporary furniture","customizable LED lights","spacious storage","stylish TV stand","high-gloss finish","functional furniture","practical design","low-profile design","solid wood construction","elegant TV stand","decorative furniture"]',
    '{"metaTitle":"LED Light TV Stand - Modern Design with Ample Storage","metaDescription":"Upgrade your living room with our LED Light TV Stand featuring customizable LED lights and spacious storage. Order now to enhance your entertainment space!","altText":"Stylish LED Light TV Stand with modern design, ample storage, and customizable LED lights.","keywords":["LED Light TV Stand","modern TV stand","living room furniture","media console","entertainment center","contemporary furniture","home decor","sleek design","customizable LED lights","spacious storage","media storage","stylish TV stand","high-gloss finish","furniture","home organization","functional furniture","practical design","quality materials","easy maintenance","clean lines","low-profile design","solid wood construction","metal hardware","durable construction","tapered legs","elegant TV stand","interior design","decorative furniture"]}',
    FALSE,
    FALSE,
    4.5,
    89,
    TRUE,
    '2024-01-25T00:00:00Z',
    '2024-01-25T00:00:00Z'
FROM categories c
WHERE c.slug = 'furniture'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Corner TV Stand
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'FURN-TV-004',
    'Corner TV Stand',
    'Space-saving corner entertainment unit',
    299.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'tv-stand' AND category_id = c.id),
    20,
    'in_stock'::stock_status,
    '{"color":["Warm Oak","Natural Rattan"],"material":["Solid Wood","Rattan"],"style":["Contemporary","Mid-Century Modern"],"room":["Living Room"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Warm Oak","hex":"#C19A6B","category":"primary"},{"name":"Natural Rattan","hex":"#D2B48C","category":"accent"}],"pattern":"solid","texture":"natural","finish":"natural","shape":"rectangular","silhouette":"low-profile with rounded edges"}',
    '{"short":"Chic corner TV stand with elegant rattan details and spacious storage.","long":"Transform your living space with our Corner TV Stand, an epitome of style and functionality. Boasting a warm oak finish and captivating rattan accents, this piece merges contemporary flair with mid-century charm. Its graceful silhouette, defined by rounded edges and tapered legs, provides a sleek aesthetic to any room. The cleverly designed space-saving corner shape maximizes room utility, while the ample shelves and rattan sliding door offer generous storage for media devices and decorative pieces. Elevate your entertainment setup with this sophisticated addition that promises elegance and practicality.","features":["Efficient corner placement for space saving","Stylish warm oak and rattan finish","Graceful tapered wooden legs","Secure rounded edges for added safety","Generous storage with sliding door","Contemporary and mid-century modern style","Ideal for living rooms"],"careInstructions":"Clean regularly with a damp cloth. Avoid using harsh chemicals or abrasive materials to maintain the finish.","materialComposition":"Crafted from solid oak wood and detailed with natural rattan accents"}',
    '["living-room","corner","space-saving","compact","corner TV stand","space-saving furniture","oak finish","rattan accents","contemporary design","living room furniture","media storage","entertainment unit","stylish TV stand","compact design","modern furniture","home decor","furniture piece","TV console","storage solution","sleek design","wooden TV stand","natural materials","functional furniture","interior design","home entertainment","media console","furniture with rattan","oak wood","designer furniture","practical furniture","elegant TV stand","minimalist design","TV furniture","versatile storage"]',
    '{"metaTitle":"Corner TV Stand: Oak Finish & Rattan Accents","metaDescription":"Transform your living space with our Corner TV Stand. Stylish and functional, it features a warm oak finish and rattan accents. Shop now for elegance!","altText":"Corner TV stand with oak finish and rattan accents, featuring ample storage and stylish design.","keywords":["corner TV stand","space-saving furniture","oak finish","rattan accents","contemporary design","living room furniture","media storage","entertainment unit","stylish TV stand","compact design","modern furniture","home decor","TV console","storage solution","sleek design","wooden TV stand","natural materials","functional furniture","interior design","home entertainment","media console","furniture with rattan","oak wood","designer furniture","practical furniture","elegant TV stand","minimalist design","TV furniture","versatile storage"]}',
    FALSE,
    FALSE,
    4.4,
    98,
    TRUE,
    '2024-01-12T00:00:00Z',
    '2024-01-12T00:00:00Z'
FROM categories c
WHERE c.slug = 'furniture'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Open Shelf Entertainment Center
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'FURN-TV-010',
    'Open Shelf Entertainment Center',
    'Spacious open shelving entertainment center',
    499.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'tv-stand' AND category_id = c.id),
    6,
    'in_stock'::stock_status,
    '{"color":["Warm Walnut"],"material":["Solid Wood","Metal"],"style":["Contemporary"],"room":["Living Room"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Warm Walnut","hex":"#8B5A2B","category":"primary"}],"pattern":"slatted","texture":"textured","finish":"natural","shape":"rectangular","silhouette":"Low-profile with clean lines"}',
    '{"short":"Elegant open shelf entertainment center with a warm walnut finish and slatted door design.","long":"Transform your living room into a modern haven with our Open Shelf Entertainment Center. This exquisite piece boasts a warm walnut finish, perfectly complementing contemporary interiors. The open shelving is designed with versatility in mind, offering ample space for your media devices, books, and decorative accents. The slatted door design adds a chic touch, making it as stylish as it is functional. Crafted from solid wood with metal accents, this entertainment center ensures durability and long-lasting appeal. Its low-profile silhouette with clean lines creates a sleek, unobtrusive presence, making it the ideal centerpiece for your home entertainment setup.","features":["Open shelving for versatile storage","Warm walnut finish enhances decor","Chic slatted door design","Contemporary style fits modern homes","Durable construction of solid wood and metal","Low-profile silhouette with clean lines","Spacious design for ample media and decor storage"],"careInstructions":"To maintain its beauty, wipe with a damp cloth regularly. Avoid using harsh chemicals to preserve the finish.","materialComposition":"Constructed with a solid wood frame and complemented by metal accents for added durability."}',
    '["living-room","entertainment-center","open-shelf","large","entertainment center","TV stand","living room furniture","modern design","wooden furniture","media storage","home decor","contemporary style","slatted doors","open shelves","walnut finish","solid wood","metal accents","durable construction","stylish","functional","versatile","spacious","low-profile","clean lines","elegant","centerpiece","home entertainment","media console","furniture","storage solution","decorative","modern living","sleek design","natural finish","textured","rectangular shape","easy maintenance","high-quality","Open Shelf Entertainment Center"]',
    '{"metaTitle":"Open Shelf Entertainment Center - Walnut Finish & Versatile Storage","metaDescription":"Upgrade your living room with our Open Shelf Entertainment Center. Enjoy versatile storage and a chic walnut finish. Order now for a modern touch!","altText":"Stylish open shelf entertainment center with a warm walnut finish and slatted doors.","keywords":["Open Shelf Entertainment Center","TV stand","living room furniture","modern design","wooden furniture","media storage","home decor","contemporary style","slatted doors","open shelves","walnut finish","solid wood","metal accents","durable construction","stylish","functional","versatile","spacious","low-profile","clean lines","elegant","centerpiece","home entertainment","media console","furniture","storage solution","decorative","modern living","sleek design","natural finish"]}',
    FALSE,
    TRUE,
    4.8,
    198,
    TRUE,
    '2024-01-28T00:00:00Z',
    '2024-01-28T00:00:00Z'
FROM categories c
WHERE c.slug = 'furniture'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Glass Door TV Cabinet
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'FURN-TV-006',
    'Glass Door TV Cabinet',
    'Elegant cabinet with tempered glass doors',
    379.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'tv-stand' AND category_id = c.id),
    14,
    'in_stock'::stock_status,
    '{"color":["Pure White","Black"],"material":["Engineered Wood","Tempered Glass"],"style":["Modern","Minimalist"],"room":["Living Room","Media Room"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Pure White","hex":"#FFFFFF","category":"primary"},{"name":"Black","hex":"#000000","category":"accent"}],"pattern":"solid","texture":"smooth","finish":"matte","shape":"rectangular","silhouette":"Low-profile with clean lines"}',
    '{"short":"Elegant TV cabinet with tempered glass doors, perfect for modern living spaces.","long":"Discover a blend of style and functionality with our Glass Door TV Cabinet. Crafted for modern interiors, it boasts a sleek silhouette with clean lines and a refined matte white finish. The tempered glass doors lend sophistication, allowing a glimpse of your curated decor while offering easy access to spacious storage compartments. It serves as a versatile media console, accommodating your entertainment devices seamlessly. Built with durable engineered wood, this cabinet promises longevity while enhancing your living room''s aesthetic appeal. Elevate your home entertainment setup with a piece that combines practicality and elegance effortlessly.","features":["Tempered glass doors for a sophisticated look","Ample storage for media devices and decor","Modern minimalist design with clean lines","Sturdy construction ensures long-lasting use","Smooth matte white finish complements any decor","Cable management system for organized electronics","Versatile for living and media rooms"],"careInstructions":"To maintain its pristine condition, wipe the surface clean with a damp cloth regularly. Avoid using harsh chemicals or abrasive materials that may damage the finish.","materialComposition":"Constructed from high-quality engineered wood paired with tempered glass for enhanced durability and style."}',
    '["living-room","glass-door","cabinet","elegant","TV cabinet","modern furniture","glass doors","white cabinet","living room storage","media console","minimalist design","home entertainment","durable construction","elegant furniture","contemporary style","engineered wood","tempered glass","sleek design","clean lines","storage solution","functional furniture","stylish cabinet","space-saving","home decor","interior design","media storage","entertainment center","furniture piece","modern home","white finish","accent furniture","room organization","practical design","versatile cabinet","easy maintenance","high-quality materials","TV stand","cabinet with shelves","contemporary cabinet","living room furniture","Glass Door TV Cabinet"]',
    '{"metaTitle":"Glass Door TV Cabinet - Stylish & Functional Media Console","metaDescription":"Upgrade your living room with our Glass Door TV Cabinet. Sleek design, ample storage, and durable construction. Order now for a stylish home setup!","altText":"Modern Glass Door TV Cabinet with matte white finish and spacious storage compartments.","keywords":["Glass Door TV Cabinet","modern furniture","media console","living room storage","minimalist design","home entertainment","durable construction","elegant furniture","contemporary style","engineered wood","tempered glass","sleek design","clean lines","storage solution","functional furniture","stylish cabinet","space-saving","home decor","interior design","media storage","entertainment center","furniture piece","modern home","white finish","accent furniture","room organization","practical design","versatile cabinet","easy maintenance","high-quality materials"]}',
    FALSE,
    FALSE,
    4.5,
    112,
    TRUE,
    '2024-01-18T00:00:00Z',
    '2024-01-18T00:00:00Z'
FROM categories c
WHERE c.slug = 'furniture'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- ----------------------------------------------------------------------------
-- Rugs (25 products)
-- ----------------------------------------------------------------------------

-- Product: Modern Geometric Indoor Rug
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'RUG-IND-001',
    'Modern Geometric Indoor Rug',
    'Contemporary geometric pattern rug perfect for living spaces',
    189.99,
    249.99,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'indoor-rug' AND category_id = c.id),
    24,
    'in_stock'::stock_status,
    '{"color":["Forest Green","Olive Green","Cream"],"material":["Polypropylene"],"style":["Modern","Contemporary"],"room":["Living Room","Bedroom","Office"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Forest Green","hex":"#228B22","category":"primary"},{"name":"Olive Green","hex":"#808000","category":"secondary"},{"name":"Cream","hex":"#FFFDD0","category":"accent"}],"pattern":"geometric","texture":"smooth","finish":"matte","shape":"rectangular","silhouette":"Low-profile with flowing lines"}',
    '{"short":"Elevate your space with a modern rug featuring bold geometric patterns in soothing green tones.","long":"Transform your home with the Modern Geometric Indoor Rug, a striking piece that combines artistry and comfort. The bold geometric pattern dances across the surface in a harmonious blend of forest and olive greens, accented by soft cream touches. Crafted from high-quality polypropylene, this rug ensures durability while providing a plush, inviting texture underfoot. Its versatile design makes it a perfect fit for living rooms, bedrooms, or offices, injecting a dose of contemporary style and color into any setting. Whether you''re aiming for a chic, minimalist vibe or a cozy retreat, this rug is a statement piece that brings life and sophistication to your decor.","features":["Bold geometric design","Forest and olive green tones","Soft, plush texture","Durable polypropylene construction","Versatile for various rooms","Fade-resistant and easy to maintain","Non-slip backing"],"careInstructions":"Regular vacuuming and spot cleaning with mild detergent recommended. Avoid prolonged exposure to direct sunlight to maintain vibrant colors.","materialComposition":"100% Polypropylene"}',
    '["living-room","bedroom","geometric","modern","modern rug","geometric pattern","green rug","living room decor","bedroom rug","contemporary style","polypropylene rug","indoor rug","stylish rug","home decor","floor covering","soft texture","durable rug","easy maintenance","accent piece","rectangular rug","matte finish","low-profile rug","office decor","versatile rug","colorful rug","designer rug","trendy rug","fashionable rug","eco-friendly rug","machine-made rug","affordable rug","high-quality rug","decorative rug","unique design","eye-catching rug","comfortable rug","green tones","flowing lines","artistic rug","statement piece","easy to clean","fade-resistant","non-slip backing","5x7 rug","8x10 rug","sale rug","best seller rug","modern geometric rug","office rug","contemporary style rug","soft texture rug","accent piece rug","matte finish rug","unique design rug","statement piece rug","easy to clean rug","fade-resistant rug","non-slip backing rug"]',
    '{"metaTitle":"Modern Geometric Indoor Rug - Stylish & Durable Comfort","metaDescription":"Transform any room with the Modern Geometric Indoor Rug. Featuring bold green patterns and plush texture, it''s perfect for living rooms, bedrooms, or offices. Shop now!","altText":"Modern geometric indoor rug with bold green patterns and soft texture, perfect for stylish home decor.","keywords":["modern geometric rug","indoor rug","green rug","living room decor","bedroom rug","office rug","contemporary style rug","polypropylene rug","stylish rug","home decor","floor covering","durable rug","soft texture rug","accent piece rug","rectangular rug","matte finish rug","low-profile rug","versatile rug","colorful rug","designer rug","trendy rug","fashionable rug","eco-friendly rug","machine-made rug","affordable rug","high-quality rug","decorative rug","unique design rug","eye-catching rug","comfortable rug","statement piece rug","easy to clean rug","fade-resistant rug","non-slip backing rug"]}',
    TRUE,
    TRUE,
    4.8,
    312,
    TRUE,
    '2024-01-10T00:00:00Z',
    '2024-01-10T00:00:00Z'
FROM categories c
WHERE c.slug = 'rugs'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Traditional Persian Style Rug
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'RUG-IND-002',
    'Traditional Persian Style Rug',
    'Classic Persian-inspired design with intricate patterns',
    299.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'indoor-rug' AND category_id = c.id),
    18,
    'in_stock'::stock_status,
    '{"color":["Teal","Vibrant Orange","Sunny Yellow"],"material":["Synthetic Fibers"],"style":["Modern","Contemporary"],"room":["Living Room","Bedroom","Office"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Teal","hex":"#008080","category":"primary"},{"name":"Vibrant Orange","hex":"#FF4500","category":"secondary"},{"name":"Sunny Yellow","hex":"#FFD700","category":"accent"}],"pattern":"abstract","texture":"plush","finish":"matte","shape":"round","silhouette":"Bold and dynamic with flowing curves"}',
    '{"short":"Elegant Persian-style rug infused with intricate motifs and rich earthy tones.","long":"Enhance your home with the timeless beauty of our Traditional Persian Style Rug. This exquisite piece showcases intricately woven motifs and patterns that evoke the elegance and sophistication of Persian artistry. Rich earthy tones of deep red, golden beige, and lush greens blend seamlessly, creating an inviting ambiance that complements various decor styles. Crafted from premium wool, the rug offers a plush, soft texture underfoot and exceptional durability. Perfect for anchoring your living room, bedroom, or office, this rug adds a touch of opulence and warmth to any space.","features":["Intricate Persian motifs and designs","Rich earthy color palette with deep reds and greens","Made from premium wool for softness and durability","Suitable for living rooms, bedrooms, and offices","Adds warmth and elegance to any space","Classic design that complements various styles"],"careInstructions":"Vacuum regularly to prevent dust buildup. Professional cleaning recommended for deep stains. Rotate periodically to ensure even wear.","materialComposition":"100% premium wool"}',
    '["living-room","dining-room","persian","traditional","modern","contemporary","abstract","round rug","teal","orange","yellow","living room","bedroom","office","plush texture","durable","vibrant colors","centerpiece","synthetic fibers","bold design","decor","interior design","home decor","floor covering","artistic","colorful","unique","eye-catching","stylish","comfortable","soft","warm","accent piece","statement rug","dynamic","Traditional Persian rug","Persian style rug","intricate rug patterns","plush wool rug","elegant home decor","sophisticated rug","earthy tone rug","luxury rugs","living room rug","bedroom rug","office rug","premium wool rug","durable rugs","opulent rug design","timeless rug","Persian artistry rug","decorative floor covering","rich color rug","classic Persian rug","artistic rug design","soft texture rug","high-quality rug","warm home accents","timeless beauty rug","Persian motifs rug","elegant interior design","classic decor rug","plush texture rug","statement rug piece","inviting ambiance rug"]',
    '{"metaTitle":"Traditional Persian Style Rug - Plush Wool, Timeless Elegance","metaDescription":"Add opulence to your home with our Traditional Persian Style Rug. Enjoy intricate patterns and plush wool. Shop now for elegance and durability!","altText":"Traditional Persian Style Rug with intricate patterns in earthy tones.","keywords":["Traditional Persian rug","Persian style rug","intricate rug patterns","plush wool rug","elegant home decor","sophisticated rug","earthy tone rug","luxury rugs","living room rug","bedroom rug","office rug","premium wool rug","durable rugs","opulent rug design","timeless rug","Persian artistry rug","decorative floor covering","rich color rug","classic Persian rug","artistic rug design","soft texture rug","high-quality rug","warm home accents","timeless beauty rug","Persian motifs rug","elegant interior design","classic decor rug","plush texture rug","statement rug piece","inviting ambiance rug"]}',
    FALSE,
    TRUE,
    4.7,
    245,
    TRUE,
    '2024-01-12T00:00:00Z',
    '2024-01-12T00:00:00Z'
FROM categories c
WHERE c.slug = 'rugs'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Minimalist Solid Color Rug
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'RUG-IND-004',
    'Minimalist Solid Color Rug',
    'Clean solid color rug for minimalist interiors',
    149.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'indoor-rug' AND category_id = c.id),
    45,
    'in_stock'::stock_status,
    '{"color":["Warm Beige","Tan"],"material":["Cotton"],"style":["Minimalist","Modern"],"room":["Living Room","Bedroom","Office"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Warm Beige","hex":"#D8C3A5","category":"primary"},{"name":"Tan","hex":"#C19A6B","category":"secondary"}],"pattern":"geometric","texture":"smooth","finish":"matte","shape":"rectangular","silhouette":"Flat with clean geometric lines"}',
    '{"short":"Elevate your space with our Minimalist Solid Color Rug, offering a serene blend of beige and tan for modern elegance.","long":"Transform your home into a haven of tranquility with our Minimalist Solid Color Rug. This exquisite piece, expertly crafted from 100% cotton, comes in warm beige and tan tones that effortlessly blend with any decor. Its subtle geometric pattern and smooth texture add a modern touch, while the durable construction ensures it withstands the test of time. Ideal for living rooms, bedrooms, or offices, this rug brings a sophisticated yet calming ambiance to your space. Its minimalist design not only complements contemporary interiors but also serves as a versatile backdrop for your furniture. Priced at $149.99, this rug offers an affordable luxury that enhances your home’s aesthetic with understated elegance.","features":["Minimalist design with geometric pattern","Warm beige and tan color palette","Smooth, soft cotton texture","Durable and long-lasting construction","Perfect for modern and contemporary spaces","Versatile addition to living rooms, bedrooms, and offices"],"careInstructions":"Vacuum regularly to maintain appearance. Spot clean with a mild detergent as needed. Keep away from direct sunlight to prevent fading.","materialComposition":"100% Cotton"}',
    '["bedroom","living-room","minimalist","solid","modern","geometric","cotton rug","beige rug","tan rug","living room","office","soft texture","durable","rectangular rug","matte finish","clean lines","elegant","understated","sophisticated","versatile","calming ambiance","contemporary decor","indoor rug","home decor","floor covering","area rug","patterned rug","neutral colors","warm tones","easy care","vacuum regularly","spot clean","avoid sunlight","long-lasting","minimalist rug","solid color rug","geometric pattern rug","living room rug","bedroom rug","office rug","soft texture rug","durable rug","matte finish rug","clean lines rug","elegant rug","understated rug","sophisticated rug","versatile rug","calming ambiance rug","contemporary decor rug","home decor rug","floor covering rug","neutral colors rug","warm tones rug","easy care rug","vacuum regularly rug","spot clean rug"]',
    '{"metaTitle":"Minimalist Solid Color Rug - Geometric Pattern & Cotton","metaDescription":"Enhance your space with our Minimalist Solid Color Rug. Crafted from 100% cotton, its geometric pattern and warm tones offer elegance. Buy now for $149.99!","altText":"Minimalist rug with geometric patterns in warm beige and tan, crafted from cotton for modern interiors.","keywords":["minimalist rug","solid color rug","geometric pattern rug","cotton rug","beige rug","tan rug","living room rug","bedroom rug","office rug","soft texture rug","durable rug","rectangular rug","matte finish rug","clean lines rug","elegant rug","understated rug","sophisticated rug","versatile rug","calming ambiance rug","contemporary decor rug","indoor rug","home decor rug","floor covering rug","area rug","patterned rug","neutral colors rug","warm tones rug","easy care rug","vacuum regularly rug","spot clean rug"]}',
    FALSE,
    FALSE,
    4.5,
    156,
    TRUE,
    '2024-01-18T00:00:00Z',
    '2024-01-18T00:00:00Z'
FROM categories c
WHERE c.slug = 'rugs'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Bohemian Moroccan Shag Rug
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'RUG-IND-003',
    'Bohemian Moroccan Shag Rug',
    'Plush shag rug with bohemian Moroccan patterns',
    229.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'indoor-rug' AND category_id = c.id),
    30,
    'in_stock'::stock_status,
    '{"color":["Warm Beige","Cream"],"material":["Polyester"],"style":["Bohemian","Moroccan"],"room":["Living Room","Bedroom"],"occasion":["Everyday","Cozy gatherings"]}',
    '{"primaryColors":[{"name":"Warm Beige","hex":"#D3B8A6","category":"primary"},{"name":"Cream","hex":"#F5F5DC","category":"secondary"}],"pattern":"geometric","texture":"shag","finish":"matte","shape":"rectangular","silhouette":"Low-profile with intricate geometric patterns"}',
    '{"short":"Add elegance to your space with our Bohemian Moroccan Shag Rug, featuring timeless geometric patterns in warm tones.","long":"Transform your living space with the Bohemian Moroccan Shag Rug, a perfect blend of style and comfort. This exquisite rug showcases intricate geometric patterns in soothing warm beige and cream hues, ideal for creating a cozy and inviting atmosphere. The plush shag texture provides an indulgent softness underfoot, making it a delightful addition to your living room or bedroom. Crafted from high-quality polyester, this rug is not only durable but also easy to maintain, ensuring it remains a staple in your home decor for years to come. Its bohemian charm and eclectic appeal make it a versatile piece that complements a wide range of interior styles. Elevate your home''s aesthetic and embrace the comfort of this beautiful shag rug.","features":["Bohemian Moroccan design with unique charm","Soft, plush shag texture for added comfort","Intricate geometric patterns","Crafted from durable, easy-care polyester","Warm beige and cream color palette","Versatile for living rooms and bedrooms","Complements bohemian and eclectic styles"],"careInstructions":"Vacuum regularly to maintain appearance. Spot clean with a mild detergent as needed. Avoid direct sunlight to prevent fading.","materialComposition":"100% Polyester"}',
    '["bedroom","living-room","bohemian","shag","Moroccan","shag rug","geometric","indoor rug","living room","cozy","warm tones","polyester","durable","easy maintenance","decor","home","style","comfort","elegant","plush","patterned","fringed","rectangular","matte finish","low-profile","soft texture","warm beige","cream","accent piece","floor covering","textured","Bohemian Moroccan shag rug","geometric pattern rug","plush shag rug","beige and cream rug","living room rug","bedroom rug","cozy rug","soft texture rug","durable polyester rug","easy maintenance rug","elegant home decor","bohemian style rug","Moroccan design rug","warm tones rug","fringed edges rug","rectangular shag rug","matte finish rug","low-profile rug","accent piece rug","floor covering rug","textured rug","polyester shag rug","soft underfoot rug","home aesthetic rug"]',
    '{"metaTitle":"Bohemian Moroccan Shag Rug - Plush Comfort & Style","metaDescription":"Elevate your decor with the Bohemian Moroccan Shag Rug. Enjoy plush comfort and intricate patterns. Shop now for a cozy, stylish home!","altText":"Bohemian Moroccan shag rug with geometric patterns in beige and cream.","keywords":["Bohemian Moroccan shag rug","geometric pattern rug","plush shag rug","beige and cream rug","living room rug","bedroom rug","cozy rug","soft texture rug","indoor rug","durable polyester rug","easy maintenance rug","elegant home decor","bohemian style rug","Moroccan design rug","warm tones rug","fringed edges rug","rectangular shag rug","matte finish rug","low-profile rug","accent piece rug","floor covering rug","textured rug","polyester shag rug","soft underfoot rug","home aesthetic rug"]}',
    TRUE,
    FALSE,
    4.6,
    189,
    TRUE,
    '2024-01-15T00:00:00Z',
    '2024-01-15T00:00:00Z'
FROM categories c
WHERE c.slug = 'rugs'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Abstract Art Deco Indoor Rug
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'RUG-IND-005',
    'Abstract Art Deco Indoor Rug',
    'Stunning abstract pattern with art deco influences',
    279.99,
    349.99,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'indoor-rug' AND category_id = c.id),
    12,
    'in_stock'::stock_status,
    '{"color":["Warm Chestnut","Cream"],"material":["Wool"],"style":["Art Deco","Modern"],"room":["Living Room","Dining Room"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Warm Chestnut","hex":"#8B5A2B","category":"primary"},{"name":"Cream","hex":"#FFFDD0","category":"secondary"}],"pattern":"abstract","texture":"soft","finish":"matte","shape":"rectangular","silhouette":"Flat with intricate line patterns"}',
    '{"short":"Elegant rug with abstract Art Deco pattern in warm tones.","long":"Infuse your living space with sophistication using the Abstract Art Deco Indoor Rug. This captivating piece presents a mesmerizing blend of intricate lines and shapes, painted in warm chestnut and cream tones. Perfectly crafted from 100% high-quality wool, it provides a plush, soft texture underfoot while ensuring long-lasting durability. The rug’s abstract design adds visual interest, making it an ideal centerpiece for modern living rooms or dining areas. Its matte finish and rectangular silhouette make it a versatile addition to any home, enhancing contemporary decor styles with elegance and flair.","features":["Captivating abstract Art Deco design","Warm chestnut and cream colors","Soft and plush wool texture","Durable, high-quality construction","Matte finish for modern aesthetics","Rectangular shape for versatile placement","Ideal for living rooms and dining areas"],"careInstructions":"Vacuum regularly to maintain appearance. Spot clean with mild detergent for minor spills. Professional cleaning recommended for heavy stains.","materialComposition":"100% Wool"}',
    '["living-room","dining-room","abstract","art-deco","art deco","indoor rug","living room","dining room","modern decor","wool rug","elegant design","warm chestnut","cream","soft texture","durable","high quality","6x9 rug","8x10 rug","home decor","floor covering","patterned rug","matte finish","rectangular shape","sophisticated style","visual interest","comfortable","luxury rug","designer rug","unique pattern","artistic design","contemporary","stylish","versatile","easy maintenance","highly rated","best seller","abstract rug","art deco rug","living room rug","dining room rug","warm chestnut rug","cream rug","soft texture rug","durable rug","high quality rug","home decor rug","matte finish rug","rectangular shape rug","sophisticated style rug","visual interest rug","comfortable rug","unique pattern rug","artistic design rug","contemporary rug","stylish rug","versatile rug","easy maintenance rug","highly rated rug","best seller rug"]',
    '{"metaTitle":"Abstract Art Deco Indoor Rug - Soft Wool & Elegant Design","metaDescription":"Elevate your space with the Abstract Art Deco Indoor Rug. Crafted from plush wool, this elegant rug combines durability with sophisticated style. Shop now!","altText":"Elegant Abstract Art Deco Indoor Rug in warm chestnut and cream tones, made from soft wool.","keywords":["abstract rug","art deco rug","indoor rug","living room rug","dining room rug","modern decor","wool rug","elegant design","warm chestnut rug","cream rug","soft texture rug","durable rug","high quality rug","6x9 rug","8x10 rug","home decor rug","floor covering","patterned rug","matte finish rug","rectangular shape rug","sophisticated style rug","visual interest rug","comfortable rug","luxury rug","designer rug","unique pattern rug","artistic design rug","contemporary rug","stylish rug","versatile rug","easy maintenance rug","highly rated rug","best seller rug"]}',
    TRUE,
    TRUE,
    4.9,
    278,
    TRUE,
    '2024-01-20T00:00:00Z',
    '2024-01-20T00:00:00Z'
FROM categories c
WHERE c.slug = 'rugs'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Vintage Distressed Indoor Rug
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'RUG-IND-006',
    'Vintage Distressed Indoor Rug',
    'Vintage-style rug with distressed finish',
    199.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'indoor-rug' AND category_id = c.id),
    22,
    'in_stock'::stock_status,
    '{"color":["Warm Orange","Cream"],"material":["Polypropylene"],"style":["Modern","Contemporary"],"room":["Hallway","Living Room"],"occasion":["Everyday","Decorative"]}',
    '{"primaryColors":[{"name":"Warm Orange","hex":"#D35400","category":"primary"},{"name":"Cream","hex":"#F5F5DC","category":"accent"}],"pattern":"geometric","texture":"smooth","finish":"matte","shape":"organic","silhouette":"Long runner with wavy edges"}',
    '{"short":"Add vintage charm with our elegant distressed rug, featuring warm, earthy tones.","long":"Transform your living space with the Vintage Distressed Indoor Rug, a masterpiece that marries timeless elegance with modern design. This rug radiates warmth through its earthy palette of deep browns and muted blues, capturing the essence of vintage charm. The distressed pattern not only adds character but also a sense of history and depth to your decor. It''s crafted from high-quality polypropylene, ensuring durability and longevity, making it perfect for high-traffic areas like the living room or hallway. The soft texture underfoot invites comfort and coziness, making every step feel indulgent. This rug seamlessly fits into both classic and contemporary settings, offering a versatile piece that elevates any room.","features":["Distressed vintage pattern","Warm earthy tones of brown and blue","High-quality polypropylene for durability","Soft texture for added comfort","Ideal for high-traffic areas","Versatile design suits various decor styles","Fade-resistant for long-lasting appeal"],"careInstructions":"Vacuum regularly to maintain appearance. Spot clean with mild detergent as needed. Avoid excessive moisture and direct sunlight to prevent fading.","materialComposition":"100% Polypropylene"}',
    '["living-room","bedroom","vintage","distressed","rug","runner","hallway","modern","contemporary","geometric","orange","cream","wavy","decorative","polypropylene","smooth","matte","organic shape","stylish","eye-catching","interior design","home decor","floor covering","long runner","durable","easy care","vacuum","spot clean","fade resistant","warm tones","dynamic design","narrow spaces","bold design","vintage rug","distressed indoor rug","elegant rugs","modern design rugs","earthy palette rug","deep brown rug","muted blue rug","high-quality polypropylene rug","durable rugs","living room rug","hallway rug","soft texture rug","cozy rugs","classic style rug","contemporary rug","versatile rugs","home decor rugs","stylish rugs","wavy pattern rug","warm orange rug","cream colored rug","geometric pattern rug","modern style rug","easy care rug","fade resistant rug","dynamic design rug","bold design rug","eye-catching rug"]',
    '{"metaTitle":"Vintage Distressed Indoor Rug - Timeless Elegance & Durability","metaDescription":"Elevate your space with the Vintage Distressed Indoor Rug. Enjoy its timeless charm and durability. Perfect for living rooms or hallways. Shop now!","altText":"Vintage Distressed Indoor Rug with earthy tones and a wavy pattern.","keywords":["vintage rug","distressed indoor rug","elegant rugs","modern design rugs","earthy palette rug","deep brown rug","muted blue rug","high-quality polypropylene rug","durable rugs","living room rug","hallway rug","soft texture rug","cozy rugs","classic style rug","contemporary rug","versatile rugs","home decor rugs","floor covering","stylish rugs","wavy pattern rug","warm orange rug","cream colored rug","geometric pattern rug","modern style rug","easy care rug","fade resistant rug","dynamic design rug","bold design rug","eye-catching rug"]}',
    FALSE,
    TRUE,
    4.6,
    198,
    TRUE,
    '2024-01-22T00:00:00Z',
    '2024-01-22T00:00:00Z'
FROM categories c
WHERE c.slug = 'rugs'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Plush Velvet Indoor Rug
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'RUG-IND-007',
    'Plush Velvet Indoor Rug',
    'Luxurious velvet-feel rug for ultimate comfort',
    259.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'indoor-rug' AND category_id = c.id),
    16,
    'in_stock'::stock_status,
    '{"color":["Emerald Green","Burgundy","Navy Blue","Warm Beige","Golden Yellow"],"material":["Polyester"],"style":["Modern","Contemporary"],"room":["Living Room","Bedroom"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Emerald Green","hex":"#50C878","category":"primary"},{"name":"Burgundy","hex":"#800020","category":"secondary"},{"name":"Navy Blue","hex":"#000080","category":"accent"},{"name":"Warm Beige","hex":"#D3B8A3","category":"accent"},{"name":"Golden Yellow","hex":"#FFD700","category":"accent"}],"pattern":"abstract","texture":"velvet","finish":"matte","shape":"organic","silhouette":"Flowing organic form with vibrant curves"}',
    '{"short":"Luxurious velvet indoor rug with vibrant abstract design.","long":"Transform your living space with the Plush Velvet Indoor Rug, a masterpiece of modern design and comfort. Its abstract pattern, featuring deep hues of emerald, burgundy, and navy, creates a striking focal point in any room. Imagined as an organic silhouette, this rug complements contemporary interiors with its flowing curves and vibrant colors. The velvet-like texture offers an indulgent softness underfoot, inviting you to experience a touch of luxury every day. Perfect for living rooms or bedrooms, this rug not only elevates style but also provides practical comfort, making it a versatile choice for any home.","features":["Captivating abstract design with rich colors","Luxurious velvet-like texture","Organic silhouette for modern appeal","Enhances comfort and style","Ideal for living rooms and bedrooms","Vibrant hues: emerald, burgundy, navy"],"careInstructions":"Regular vacuuming is recommended. Spot clean with a mild detergent. Keep away from direct sunlight to prevent color fading.","materialComposition":"Crafted from 100% Polyester with a velvet-like finish"}',
    '["bedroom","living-room","plush","velvet","abstract rug","velvet rug","modern decor","living room rug","bedroom rug","plush texture","colorful rug","indoor rug","luxury rug","home decor","floor covering","soft rug","designer rug","unique shape","comfort","style","polyester rug","easy care","vibrant colors","decorative rug","fashionable","trendy","artistic","statement piece","luxurious feel","warm tones","eye-catching","Plush Velvet Indoor Rug","fashionable rug","trendy rug","artistic rug","eye-catching rug","comfort rug","style rug","easy care rug","modern style rug","organic shape rug"]',
    '{"metaTitle":"Plush Velvet Indoor Rug - Luxurious Abstract Design","metaDescription":"Elevate your space with the Plush Velvet Indoor Rug. Experience luxury with its soft texture and vibrant abstract design. Perfect for living rooms or bedrooms. Shop now!","altText":"Plush Velvet Indoor Rug with abstract design in emerald, burgundy, and navy.","keywords":["Plush Velvet Indoor Rug","abstract rug","velvet rug","modern decor","living room rug","bedroom rug","luxury rug","home decor","soft rug","designer rug","unique shape","polyester rug","vibrant colors","decorative rug","fashionable rug","trendy rug","artistic rug","statement piece","luxurious feel","warm tones","eye-catching rug","colorful rug","indoor rug","floor covering","comfort rug","style rug","easy care rug","modern style rug","organic shape rug"]}',
    TRUE,
    FALSE,
    4.7,
    167,
    TRUE,
    '2024-01-25T00:00:00Z',
    '2024-01-25T00:00:00Z'
FROM categories c
WHERE c.slug = 'rugs'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Striped Indoor/Outdoor Rug
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'RUG-IO-001',
    'Striped Indoor/Outdoor Rug',
    'Durable striped rug perfect for patios and living areas',
    129.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'indoor-outdoor-rug' AND category_id = c.id),
    35,
    'in_stock'::stock_status,
    '{"color":["Black","Taupe","Brown"],"material":["Polypropylene"],"style":["Modern","Contemporary"],"room":["Living Room","Entryway"],"occasion":["Everyday","Decorative"]}',
    '{"primaryColors":[{"name":"Black","hex":"#000000","category":"primary"},{"name":"Taupe","hex":"#B38B6D","category":"secondary"},{"name":"Brown","hex":"#8B4513","category":"accent"}],"pattern":"abstract","texture":"plush","finish":"matte","shape":"organic","silhouette":"Layered with smooth, flowing lines"}',
    '{"short":"Versatile striped rug suitable for both indoor and outdoor use, perfect for adding texture and elegance to any space.","long":"Transform your space with the Striped Indoor/Outdoor Rug, a versatile piece that combines functionality and style. This rug''s sophisticated striped pattern in earthy tones effortlessly complements any decor, creating a welcoming ambiance. Whether it''s gracing your living room or enhancing your patio, its durable construction ensures it withstands the elements while maintaining its charm. The texture feels soft underfoot, providing comfort and warmth. Ideal for high-traffic areas, this rug is as practical as it is visually appealing, bringing a touch of elegance to indoor and outdoor settings alike.","features":["Durable for indoor and outdoor use","Elegant striped pattern","Earthy color tones","Soft texture underfoot","Suitable for high-traffic areas","Weather-resistant construction","Enhances decor with sophistication"],"careInstructions":"Vacuum regularly to remove dust and debris. For outdoor use, hose down and air dry. Spot clean with mild soap as needed.","materialComposition":"Crafted from 100% polypropylene for durability and weather resistance."}',
    '["outdoor","living-room","entryway","striped","coastal","modern","abstract","neutral","living room","contemporary","plush","decorative","organic","layered","black","taupe","brown","durable","synthetic","soft","cozy","stylish","home decor","interior design","floor covering","rug","matte finish","unique","artistic","geometric","patterned","versatile","comfortable","warm","inviting","textured","quality","fashionable","striped rug","indoor outdoor rug","versatile rug","earthy tones rug","sophisticated stripe pattern","durable rug","high-traffic rug","living room rug","patio rug","comfortable rug","elegant rug","modern rug","contemporary rug","abstract design rug","organic shapes rug","neutral color rug","plush texture rug","cozy rug","home decor rug","interior design rug","matte finish rug","unique rug","geometric pattern rug","stylish rug","quality rug","fashionable rug","inviting rug","textured rug"]',
    '{"metaTitle":"Striped Indoor/Outdoor Rug - Durable & Stylish Design","metaDescription":"Enhance your space with the Striped Indoor/Outdoor Rug. Durable and stylish, perfect for high-traffic areas. Order now for elegance and comfort!","altText":"Striped Indoor/Outdoor Rug with earthy tones and sophisticated pattern","keywords":["striped rug","indoor outdoor rug","versatile rug","earthy tones rug","sophisticated stripe pattern","durable rug","high-traffic rug","living room rug","patio rug","comfortable rug","elegant rug","modern rug","contemporary rug","abstract design rug","organic shapes rug","neutral color rug","plush texture rug","cozy rug","home decor rug","interior design rug","floor covering","matte finish rug","unique rug","geometric pattern rug","stylish rug","quality rug","fashionable rug","inviting rug","textured rug"]}',
    TRUE,
    TRUE,
    4.6,
    289,
    TRUE,
    '2024-01-08T00:00:00Z',
    '2024-01-08T00:00:00Z'
FROM categories c
WHERE c.slug = 'rugs'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Geometric Indoor/Outdoor Rug
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'RUG-IO-002',
    'Geometric Indoor/Outdoor Rug',
    'Weather-resistant rug with bold geometric pattern',
    159.99,
    199.99,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'indoor-outdoor-rug' AND category_id = c.id),
    28,
    'in_stock'::stock_status,
    '{"color":["Sage Green","Cream"],"material":["Polypropylene"],"style":["Modern"],"room":["Living Room","Patio","Entryway"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Sage Green","hex":"#9CAF88","category":"primary"},{"name":"Cream","hex":"#F5F5DC","category":"accent"}],"pattern":"geometric","texture":"textured","finish":"matte","shape":"rectangular","silhouette":"Low-profile with clean geometric lines"}',
    '{"short":"Elevate your indoor or outdoor space with our modern geometric rug, crafted for durability and style.","long":"Transform your living room, patio, or entryway with the Geometric Indoor/Outdoor Rug, featuring a captivating geometric pattern in soothing sage green and cream hues. Crafted from 100% polypropylene, this rug offers unparalleled durability and weather resistance, making it perfect for both indoor and outdoor settings. Its low-profile design seamlessly integrates into any decor style, while the textured surface adds depth and character. Whether you''re entertaining guests or enjoying a quiet evening, this rug provides a stylish yet functional backdrop to your home.","features":["Striking geometric pattern","Soft sage green and cream color palette","Weather-resistant for versatile use","100% polypropylene construction for durability","Low-profile design for easy integration","Textured surface for added visual interest","Ideal for living rooms, patios, and entryways"],"careInstructions":"Vacuum regularly to remove dust and debris. Spot clean with mild soap and water as needed. Avoid prolonged exposure to moisture to maintain quality.","materialComposition":"100% Polypropylene"}',
    '["outdoor","entryway","geometric","modern","indoor","rug","sage green","cream","polypropylene","weather-resistant","patio","living room","durable","stylish","matte finish","textured","low-profile","clean lines","versatile","easy care","vacuum","spot clean","mild soap","water","elegant","functional","design","home decor","floor covering","accent piece","indoor rug","outdoor rug","geometric rug","modern rug","sage green rug","cream rug","polypropylene rug","weather-resistant rug","entryway rug","patio rug","living room rug","durable rug","stylish rug","matte finish rug","textured rug","low-profile rug","clean lines rug","versatile rug","easy care rug","vacuum rug","spot clean rug","mild soap rug","elegant rug","functional rug","home decor rug","accent piece rug"]',
    '{"metaTitle":"Geometric Indoor/Outdoor Rug - Durable & Stylish Design","metaDescription":"Enhance your space with the Geometric Indoor/Outdoor Rug. Durable, weather-resistant, and stylish, perfect for any decor. Shop now for elegance!","altText":"Stylish indoor/outdoor rug with modern geometric pattern in sage green and cream.","keywords":["indoor rug","outdoor rug","geometric rug","modern rug","sage green rug","cream rug","polypropylene rug","weather-resistant rug","entryway rug","patio rug","living room rug","durable rug","stylish rug","matte finish rug","textured rug","low-profile rug","clean lines rug","versatile rug","easy care rug","vacuum rug","spot clean rug","mild soap rug","elegant rug","functional rug","home decor rug","floor covering","accent piece rug"]}',
    FALSE,
    TRUE,
    4.5,
    234,
    TRUE,
    '2024-01-10T00:00:00Z',
    '2024-01-10T00:00:00Z'
FROM categories c
WHERE c.slug = 'rugs'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Tropical Palm Indoor/Outdoor Rug
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'RUG-IO-003',
    'Tropical Palm Indoor/Outdoor Rug',
    'Tropical palm leaf design for indoor and outdoor spaces',
    179.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'indoor-outdoor-rug' AND category_id = c.id),
    20,
    'in_stock'::stock_status,
    '{"color":["Forest Green"],"material":["Polypropylene"],"style":["Coastal","Tropical"],"room":["Living Room","Patio","Sunroom"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Forest Green","hex":"#228B22","category":"primary"}],"pattern":"textured","texture":"smooth","finish":"matte","shape":"rectangular","silhouette":"Flat with embossed leaf patterns"}',
    '{"short":"Lush green tropical palm rug perfect for any indoor or outdoor space, enhancing nature-inspired decor.","long":"Transform your living space into a serene tropical paradise with our Tropical Palm Indoor/Outdoor Rug. Featuring a vibrant forest green hue adorned with embossed palm leaf patterns, this rug brings a lush and inviting atmosphere to your surroundings. Crafted from durable polypropylene, it stands resilient against the elements, making it suitable for both indoor and outdoor use. Its smooth texture and subtle design add elegance and style, effortlessly complementing coastal and tropical themes. Ideal for living rooms, patios, or sunrooms, this rug is both functional and visually appealing.","features":["Vibrant forest green color","Embossed palm leaf patterns","Durable polypropylene construction","Suitable for indoor and outdoor use","Smooth texture with subtle design","Weather-resistant and easy maintenance","Enhances coastal and tropical decor"],"careInstructions":"Vacuum regularly to remove dust and debris. Spot clean with mild detergent and water. Avoid prolonged exposure to direct sunlight to maintain color vibrancy.","materialComposition":"100% Polypropylene"}',
    '["outdoor","living-room","tropical","palm","indoor","rug","green","coastal","nature-inspired","polypropylene","durable","easy care","living room","patio","sunroom","textured","matte finish","5x7","6x9","rectangular","embossed design","smooth texture","modern","stylish","versatile","decor","floor covering","home","garden","porch","balcony","eco-friendly","easy maintenance","high quality","affordable","comfortable","soft underfoot","weather-resistant","tropical palm rug","indoor outdoor rug","green rug","coastal rug","tropical decor","polypropylene rug","durable rug","easy care rug","living room rug","patio rug","sunroom rug","textured rug","matte finish rug","rectangular rug","embossed design rug","smooth texture rug","modern rug","stylish rug","versatile rug","home decor rug","eco-friendly rug","easy maintenance rug","weather-resistant rug","nature-inspired rug","high quality rug","affordable rug","comfortable rug","soft underfoot rug"]',
    '{"metaTitle":"Tropical Palm Indoor/Outdoor Rug - Vibrant & Durable","metaDescription":"Enhance your space with our Tropical Palm Rug. Perfect for indoor/outdoor use, its vibrant green and durable design is a must-have. Shop now!","altText":"Vibrant green Tropical Palm Indoor/Outdoor Rug with embossed palm leaf design","keywords":["tropical palm rug","indoor outdoor rug","green rug","coastal rug","tropical decor","polypropylene rug","durable rug","easy care rug","living room rug","patio rug","sunroom rug","textured rug","matte finish rug","rectangular rug","embossed design rug","smooth texture rug","modern rug","stylish rug","versatile rug","home decor rug","floor covering","eco-friendly rug","easy maintenance rug","weather-resistant rug","nature-inspired rug","high quality rug","affordable rug","comfortable rug","soft underfoot rug"]}',
    TRUE,
    FALSE,
    4.7,
    178,
    TRUE,
    '2024-01-14T00:00:00Z',
    '2024-01-14T00:00:00Z'
FROM categories c
WHERE c.slug = 'rugs'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Medallion Indoor/Outdoor Rug
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'RUG-IO-004',
    'Medallion Indoor/Outdoor Rug',
    'Classic medallion pattern suitable for any space',
    149.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'indoor-outdoor-rug' AND category_id = c.id),
    25,
    'in_stock'::stock_status,
    '{"color":["Forest Green"],"material":["Polypropylene"],"style":["Traditional"],"room":["Living Room","Patio","Entryway"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Forest Green","hex":"#228B22","category":"primary"}],"pattern":"floral","texture":"textured","finish":"matte","shape":"rectangular","silhouette":"Low-profile with embossed detailing"}',
    '{"short":"Elegant green rug with a floral embossed pattern, perfect for indoor and outdoor spaces.","long":"Transform your living space with the Medallion Indoor/Outdoor Rug, a perfect blend of elegance and durability. Crafted in a rich forest green, this rug features a sophisticated embossed floral pattern that adds depth and texture to any area. Made from high-quality polypropylene, it is resistant to wear and ideal for both indoor and outdoor use, adapting beautifully to any setting. Whether gracing your living room, enhancing your patio, or welcoming guests in your entryway, this rug provides a soft, comfortable underfoot experience. Its traditional style effortlessly complements a variety of decor themes, ensuring a seamless addition to your home. With easy maintenance and weather-resistant properties, it''s the perfect choice for any stylish, functional space.","features":["Embossed floral pattern for added texture","Made from durable polypropylene material","Suitable for both indoor and outdoor use","Rich forest green color adds elegance","Traditional style complements various decors","Soft underfoot for added comfort","Weather-resistant and easy to maintain"],"careInstructions":"Vacuum regularly and spot clean with mild detergent. Suitable for outdoor use; store indoors during extreme weather.","materialComposition":"100% Polypropylene"}',
    '["outdoor","entryway","medallion","traditional","indoor rug","outdoor rug","floral pattern","green rug","traditional decor","polypropylene","textured rug","living room rug","patio rug","entryway rug","easy maintenance","durable rug","elegant design","comfortable underfoot","versatile style","matte finish","low-profile","embossed detailing","forest green","classic style","home decor","soft texture","decorative rug","rug for all spaces","stylish rug","high-quality material","easy to clean","weather resistant","multi-use rug","5x7 size","8x10 size","Medallion rug","floral pattern rug","traditional decor rug","polypropylene rug","easy maintenance rug","elegant design rug","comfortable underfoot rug","versatile style rug","matte finish rug","low-profile rug","embossed detailing rug","forest green rug","classic style rug","home decor rug","soft texture rug","high-quality material rug","easy to clean rug","weather resistant rug"]',
    '{"metaTitle":"Medallion Indoor/Outdoor Rug - Elegant & Durable Design","metaDescription":"Enhance any space with the Medallion Indoor/Outdoor Rug''s elegant floral pattern. Shop now for a durable, stylish addition to your home decor!","altText":"Forest green rug with embossed floral pattern, suitable for indoor and outdoor use.","keywords":["Medallion rug","indoor rug","outdoor rug","floral pattern rug","green rug","traditional decor rug","polypropylene rug","textured rug","living room rug","patio rug","entryway rug","easy maintenance rug","durable rug","elegant design rug","comfortable underfoot rug","versatile style rug","matte finish rug","low-profile rug","embossed detailing rug","forest green rug","classic style rug","home decor rug","soft texture rug","decorative rug","rug for all spaces","stylish rug","high-quality material rug","easy to clean rug","weather resistant rug","multi-use rug"]}',
    FALSE,
    FALSE,
    4.4,
    145,
    TRUE,
    '2024-01-16T00:00:00Z',
    '2024-01-16T00:00:00Z'
FROM categories c
WHERE c.slug = 'rugs'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Chevron Indoor/Outdoor Rug
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'RUG-IO-005',
    'Chevron Indoor/Outdoor Rug',
    'Modern chevron pattern for versatile placement',
    139.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'indoor-outdoor-rug' AND category_id = c.id),
    32,
    'in_stock'::stock_status,
    '{"color":["Navy Blue","White"],"material":["Polypropylene"],"style":["Modern"],"room":["Living Room","Patio","Deck"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Navy Blue","hex":"#000080","category":"primary"},{"name":"White","hex":"#FFFFFF","category":"secondary"}],"pattern":"geometric","texture":"smooth","finish":"matte","shape":"rectangular","silhouette":"Flat with clean lines"}',
    '{"short":"Stylish chevron rug with a modern flair, perfect for both indoor and outdoor spaces.","long":"Elevate your home decor with the Chevron Indoor/Outdoor Rug, a stylish blend of functionality and modern design. Featuring a dynamic chevron pattern in sophisticated navy and crisp white, this rug breathes life into any space, be it your cozy living room or a breezy patio. Made from robust polypropylene, it stands resilient against the elements, ensuring longevity and color retention. The low pile height offers hassle-free maintenance, making it ideal for high-traffic areas. Whether you''re hosting a backyard gathering or relaxing indoors, this rug adds an elegant touch to your decor, creating an inviting ambiance.","features":["Contemporary chevron design","Resilient polypropylene construction","Perfect for indoor and outdoor settings","Elegant navy and white color palette","Low pile for easy cleaning and durability","Weather-resistant and fade-resistant","Ideal for high-traffic areas"],"careInstructions":"Spot clean with mild soap and water. Avoid prolonged exposure to moisture. Rotate periodically to ensure even wear.","materialComposition":"100% Polypropylene"}',
    '["outdoor","living-room","chevron","modern","indoor","rug","polypropylene","navy","white","living room","patio","deck","durable","stylish","easy maintenance","versatile","geometric","smooth texture","matte finish","rectangular","low pile","clean lines","sophisticated","decor","foundation","elements","design","pattern","Chevron rug","Indoor outdoor rug","Modern rug design","Polypropylene rug","Navy and white rug","Durable rug","Easy maintenance rug","Living room rug","Patio rug","Deck rug","Stylish rug","Geometric pattern rug","Smooth texture rug","Matte finish rug","Rectangular rug","Low pile rug","Sophisticated decor rug","Versatile rug","Outdoor decor","Indoor decor","Rug for high-traffic areas","Rug for backyard","Rug for entertaining","Rug with clean lines","Navy rug","White rug","Home decor rug","Rug for elements"]',
    '{"metaTitle":"Chevron Indoor/Outdoor Rug - Modern Design & Durability","metaDescription":"Enhance your decor with the Chevron Indoor/Outdoor Rug. Stylish, durable, and easy to maintain. Perfect for living rooms and patios. Shop now!","altText":"Chevron Indoor/Outdoor Rug with navy and white modern pattern.","keywords":["Chevron rug","Indoor outdoor rug","Modern rug design","Polypropylene rug","Navy and white rug","Durable rug","Easy maintenance rug","Living room rug","Patio rug","Deck rug","Stylish rug","Geometric pattern rug","Smooth texture rug","Matte finish rug","Rectangular rug","Low pile rug","Sophisticated decor rug","Versatile rug","Outdoor decor","Indoor decor","Rug for high-traffic areas","Rug for backyard","Rug for entertaining","Rug with clean lines","Navy rug","White rug","Home decor rug","Rug for elements"]}',
    FALSE,
    TRUE,
    4.6,
    201,
    TRUE,
    '2024-01-18T00:00:00Z',
    '2024-01-18T00:00:00Z'
FROM categories c
WHERE c.slug = 'rugs'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Solid Indoor/Outdoor Rug
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'RUG-IO-006',
    'Solid Indoor/Outdoor Rug',
    'Simple solid color rug for indoor and outdoor use',
    99.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'indoor-outdoor-rug' AND category_id = c.id),
    50,
    'in_stock'::stock_status,
    '{"color":["Warm Beige","Slate Gray","Muted Blue"],"material":["Polypropylene"],"style":["Minimalist","Contemporary"],"room":["Living Room","Patio","Entryway"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Warm Beige","hex":"#D3B8A6","category":"primary"},{"name":"Slate Gray","hex":"#7A7A7A","category":"secondary"},{"name":"Muted Blue","hex":"#6A7B8C","category":"accent"}],"pattern":"abstract","texture":"soft","finish":"matte","shape":"rectangular","silhouette":"Low-profile with clean edges"}',
    '{"short":"Versatile indoor/outdoor rug with a subtle abstract pattern.","long":"Enhance your living space with our Solid Indoor/Outdoor Rug, a versatile masterpiece that effortlessly marries style and functionality. This rug showcases a sophisticated blend of warm beige, slate gray, and muted blue tones, woven into an abstract pattern that adds a touch of elegance to any room or patio. Crafted from durable polypropylene, it is designed to withstand the elements, making it perfect for both indoor and outdoor settings. The soft texture provides comfort underfoot, ideal for high-traffic areas such as entryways, patios, and living rooms. With its minimalist and contemporary style, this rug is a chic addition to modern and minimalist decor, offering a weather-resistant and easy-to-clean solution for your home.","features":["Abstract pattern with subtle color variations","Durable polypropylene construction","Suitable for indoor and outdoor use","Soft texture for comfort","Ideal for high-traffic areas","Weather-resistant and easy to clean","Versatile design for modern and minimalist decor"],"careInstructions":"Regularly vacuum to remove dirt and debris. Spot clean with mild detergent and water. Avoid prolonged exposure to moisture.","materialComposition":"100% Polypropylene"}',
    '["outdoor","entryway","solid","minimalist","indoor rug","outdoor rug","abstract design","minimalist style","polypropylene","durable","entryway decor","patio rug","modern rug","soft texture","beige rug","gray rug","blue accents","rectangular rug","matte finish","low-profile","contemporary design","high-traffic area","easy care","versatile","stylish","elegant","functional","decorative","comfortable","neutral tones","weather-resistant","easy to clean","3x5 rug","5x7 rug","8x10 rug","living room rug","entryway rug","patio decor","durable rug","easy care rug","versatile rug","stylish rug","elegant rug","functional rug","decorative rug","comfortable rug","weather-resistant rug","easy to clean rug"]',
    '{"metaTitle":"Solid Indoor/Outdoor Rug - Durable & Stylish Abstract Design","metaDescription":"Upgrade your space with our Solid Indoor/Outdoor Rug. Durable polypropylene, elegant abstract pattern, perfect for high-traffic areas. Shop now for comfort & style!","altText":"Solid Indoor/Outdoor Rug featuring a blend of beige, gray, and blue tones in an abstract pattern.","keywords":["indoor rug","outdoor rug","abstract design","minimalist style","polypropylene","durable rug","entryway decor","patio rug","modern rug","soft texture","beige rug","gray rug","blue accents","rectangular rug","matte finish","low-profile","contemporary design","high-traffic area","easy care rug","versatile rug","stylish rug","elegant rug","functional rug","decorative rug","comfortable rug","neutral tones","weather-resistant rug","easy to clean rug","living room rug","entryway rug","patio decor"]}',
    FALSE,
    FALSE,
    4.3,
    123,
    TRUE,
    '2024-01-20T00:00:00Z',
    '2024-01-20T00:00:00Z'
FROM categories c
WHERE c.slug = 'rugs'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Two-Tone Reversible Area Rug
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'RUG-REV-001',
    'Two-Tone Reversible Area Rug',
    'Versatile two-tone rug that can be flipped for a new look',
    169.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'reversible-rug' AND category_id = c.id),
    28,
    'in_stock'::stock_status,
    '{"color":["Black","Orange","Yellow","Cream"],"material":["Cotton"],"style":["Modern"],"room":["Living Room","Office"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Black","hex":"#000000","category":"primary"},{"name":"Orange","hex":"#FFA500","category":"accent"},{"name":"Yellow","hex":"#FFD700","category":"accent"},{"name":"Cream","hex":"#FFFDD0","category":"secondary"}],"pattern":"abstract","texture":"soft","finish":"matte","shape":"organic","silhouette":"Flowing organic form with vibrant color sections"}',
    '{"short":"Enhance your space with our Two-Tone Reversible Area Rug, featuring vibrant colors and an organic shape for dynamic decor.","long":"Transform your living space with the Two-Tone Reversible Area Rug, a modern masterpiece designed to captivate. Its vibrant palette of black, orange, yellow, and cream is masterfully woven into an organic shape that adds a touch of artistic flair to any room. Made from 100% cotton, this rug offers a plush, soft texture underfoot, making it a cozy addition to your living room or office. The reversible design allows you to effortlessly switch up your decor, providing two looks in one. Whether you''re adding a bold splash of color or complementing existing decor, this rug is the perfect choice for contemporary enthusiasts looking to elevate their interior style.","features":["Reversible design for two stylish looks","Organic shape for added visual intrigue","Vibrant color palette: black, orange, yellow, cream","Soft, plush cotton material","Ideal for modern and contemporary spaces","Easy to switch and refresh room aesthetics","Perfect for living rooms and office decor"],"careInstructions":"Vacuum regularly to maintain freshness. Spot clean with mild detergent when necessary. Keep out of direct sunlight to prevent color fading.","materialComposition":"100% Cotton"}',
    '["living-room","bedroom","reversible","two-tone","reversible rug","modern decor","abstract design","colorful rug","cotton rug","living room rug","office decor","soft texture","organic shape","vibrant colors","black rug","orange accents","yellow highlights","cream details","matte finish","stylish rug","versatile design","eye-catching","comfortable","unique shape","decorative rug","floor covering","home accessory","interior design","contemporary style","artistic rug","soft underfoot","easy to clean","durable","high-quality","cotton material","accent piece","room enhancement","visual interest","color splash","personality","Two-Tone Reversible Area Rug"]',
    '{"metaTitle":"Two-Tone Reversible Area Rug - Vibrant & Versatile Design","metaDescription":"Elevate your decor with the Two-Tone Reversible Area Rug. Enjoy vibrant colors and a plush cotton texture. Shop now for a stylish, cozy living space!","altText":"Two-Tone Reversible Area Rug with vibrant colors and organic shape, perfect for modern interiors.","keywords":["Two-Tone Reversible Area Rug","modern decor","abstract design","colorful rug","cotton rug","living room rug","office decor","soft texture","organic shape","vibrant colors","black rug","orange accents","yellow highlights","cream details","matte finish","stylish rug","versatile design","eye-catching","comfortable","unique shape","decorative rug","floor covering","home accessory","interior design","contemporary style","artistic rug","soft underfoot","easy to clean","durable","high-quality","cotton material","accent piece","room enhancement","visual interest","color splash","personality"]}',
    TRUE,
    TRUE,
    4.7,
    234,
    TRUE,
    '2024-01-05T00:00:00Z',
    '2024-01-05T00:00:00Z'
FROM categories c
WHERE c.slug = 'rugs'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Patterned Reversible Flatweave
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'RUG-REV-002',
    'Patterned Reversible Flatweave',
    'Flatweave rug with different patterns on each side',
    199.99,
    259.99,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'reversible-rug' AND category_id = c.id),
    15,
    'in_stock'::stock_status,
    '{"color":["Navy Blue","Warm Beige","Rich Red","Earthy Brown"],"material":["Cotton","Wool"],"style":["Bohemian","Traditional"],"room":["Living Room","Dining Room"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Navy Blue","hex":"#001F54","category":"primary"},{"name":"Warm Beige","hex":"#F5F5DC","category":"secondary"},{"name":"Rich Red","hex":"#8B0000","category":"accent"},{"name":"Earthy Brown","hex":"#8B4513","category":"accent"}],"pattern":"floral","texture":"woven","finish":"natural","shape":"rectangular","silhouette":"Flat with intricate border detailing"}',
    '{"short":"Elegant reversible flatweave rug with intricate floral patterns and rich colors.","long":"Elevate your home decor with the Patterned Reversible Flatweave Rug, a masterpiece of intricate floral designs and rich, harmonious colors. This elegant rug, crafted from a durable cotton and wool blend, offers a soft texture that feels luxurious underfoot. Its reversible nature allows you to effortlessly switch styles, making it a versatile addition to any living room or dining area. The sophisticated blend of navy, warm beige, and accenting reds and browns creates a visual symphony that enriches any space with warmth and elegance. Whether you''re hosting a dinner party or enjoying a quiet evening at home, this rug provides the perfect foundation for comfort and style.","features":["Reversible design for versatile styling","Intricate floral patterns","Durable cotton and wool construction","Soft texture for comfort","Ideal for living and dining rooms","Rich, harmonious color palette","Easy to integrate into various decor styles"],"careInstructions":"Vacuum regularly and spot clean with mild detergent. Avoid direct sunlight to prevent fading.","materialComposition":"Cotton and wool blend"}',
    '["living-room","dining-room","reversible","flatweave","reversible rug","bohemian style","traditional design","floral pattern","living room decor","dining room rug","cotton wool blend","durable rug","soft texture","elegant rug","versatile styling","intricate design","home decor","floor covering","textile art","patterned rug","woven texture","natural finish","rectangular shape","border detailing","rich colors","navy blue rug","beige rug","red accent","brown accent","comfortable underfoot","easy maintenance","vacuum regularly","spot clean","prevent fading","high-quality materials","stylish rug","practical design","elegant appearance","home styling","interior design","flatweave rug","bohemian style rug","traditional design rug","floral pattern rug","cotton wool blend rug","soft texture rug","versatile styling rug","intricate design rug","home decor rug","floor covering rug","textile art rug","woven texture rug","natural finish rug","rectangular shape rug","border detailing rug","rich colors rug","red accent rug","brown accent rug","comfortable underfoot rug","easy maintenance rug","vacuum regularly rug","spot clean rug"]',
    '{"metaTitle":"Patterned Reversible Flatweave Rug - Elegant Floral Design","metaDescription":"Enhance your decor with our Patterned Reversible Flatweave Rug. Enjoy luxurious comfort and versatile style. Shop now to transform your space!","altText":"Elegant reversible flatweave rug with intricate floral patterns in navy, beige, red, and brown.","keywords":["reversible rug","flatweave rug","bohemian style rug","traditional design rug","floral pattern rug","living room decor","dining room rug","cotton wool blend rug","durable rug","soft texture rug","elegant rug","versatile styling rug","intricate design rug","home decor rug","floor covering rug","textile art rug","patterned rug","woven texture rug","natural finish rug","rectangular shape rug","border detailing rug","rich colors rug","navy blue rug","beige rug","red accent rug","brown accent rug","comfortable underfoot rug","easy maintenance rug","vacuum regularly rug","spot clean rug"]}',
    TRUE,
    FALSE,
    4.8,
    189,
    TRUE,
    '2024-01-08T00:00:00Z',
    '2024-01-08T00:00:00Z'
FROM categories c
WHERE c.slug = 'rugs'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Geometric Reversible Rug
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'RUG-REV-003',
    'Geometric Reversible Rug',
    'Bold geometric design reversible rug',
    179.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'reversible-rug' AND category_id = c.id),
    22,
    'in_stock'::stock_status,
    '{"color":["Jet Black","Warm Beige"],"material":["Cotton"],"style":["Modern"],"room":["Living Room","Bedroom"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Jet Black","hex":"#343434","category":"primary"},{"name":"Warm Beige","hex":"#D3B8A5","category":"secondary"}],"pattern":"geometric","texture":"plush","finish":"matte","shape":"rectangular","silhouette":"Low-profile with undulating wave patterns"}',
    '{"short":"Elevate your space with a chic, reversible geometric rug in black and beige.","long":"Transform your living area with the Geometric Reversible Rug, a masterpiece of modern design that marries style and functionality. Featuring bold geometric waves in contrasting jet black and warm beige, this rug offers a sophisticated aesthetic that enhances any room. Crafted from 100% soft cotton, its plush texture invites comfort and luxury underfoot. The reversible feature doubles its lifespan while allowing for effortless decor versatility. Whether placed in a living room or bedroom, this rug serves as a striking focal point, complementing contemporary furnishings with its sleek, matte finish and low-profile silhouette.","features":["Reversible design for extended use and decor flexibility","Striking geometric wave pattern in black and beige","Crafted from plush, 100% soft cotton","Modern style perfect for contemporary interiors","Available in multiple sizes to suit your space","Matte finish adds a sophisticated touch","Durable and stylish addition to any room"],"careInstructions":"To maintain its beauty, vacuum regularly and spot clean with a mild detergent. Keep out of direct sunlight to prevent fading.","materialComposition":"100% Cotton"}',
    '["living-room","bedroom","reversible","geometric","reversible rug","geometric design","modern style","black and beige rug","cotton rug","living room decor","bedroom accessory","home decor","soft texture","wave pattern","rectangular rug","plush rug","contemporary rug","durable rug","stylish rug","versatile rug","decorative rug","elegant rug","contrast colors","floor covering","interior design","textured rug","matte finish","easy care","vacuum friendly","spot clean","fade resistant","high quality","comfortable rug","accent piece","room focal point","adaptable decor","decor switch","geometric reversible rug","modern cotton rug","soft texture rug","wave pattern rug","contrast colors rug","interior design rug","matte finish rug","easy care rug","vacuum friendly rug","spot clean rug","fade resistant rug","high quality rug","accent piece rug","room focal point rug","adaptable decor rug","decor switch rug"]',
    '{"metaTitle":"Geometric Reversible Rug - Modern Cotton Design","metaDescription":"Elevate your space with the Geometric Reversible Rug. Enjoy style and comfort with its bold design. Shop now for a versatile and luxurious addition!","altText":"Elegant reversible rug with bold geometric waves in black and beige.","keywords":["geometric reversible rug","modern cotton rug","black and beige rug","living room decor","bedroom accessory","soft texture rug","wave pattern rug","contemporary rug","durable rug","stylish rug","versatile rug","decorative rug","elegant rug","contrast colors rug","floor covering","interior design rug","textured rug","matte finish rug","easy care rug","vacuum friendly rug","spot clean rug","fade resistant rug","high quality rug","comfortable rug","accent piece rug","room focal point rug","adaptable decor rug","decor switch rug"]}',
    FALSE,
    TRUE,
    4.6,
    167,
    TRUE,
    '2024-01-12T00:00:00Z',
    '2024-01-12T00:00:00Z'
FROM categories c
WHERE c.slug = 'rugs'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Moroccan Reversible Rug
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'RUG-REV-005',
    'Moroccan Reversible Rug',
    'Moroccan-inspired reversible area rug',
    219.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'reversible-rug' AND category_id = c.id),
    18,
    'in_stock'::stock_status,
    '{"color":["Cream","Taupe"],"material":["Wool","Cotton"],"style":["Moroccan","Bohemian"],"room":["Living Room","Bedroom"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Cream","hex":"#F5F5DC","category":"primary"},{"name":"Taupe","hex":"#B38B6D","category":"secondary"}],"pattern":"abstract","texture":"textured","finish":"matte","shape":"round","silhouette":"Round with flowing abstract lines"}',
    '{"short":"Elegant Moroccan-inspired reversible rug with a flowing abstract pattern.","long":"This Moroccan-inspired reversible rug features a captivating abstract pattern in a soothing palette of cream and taupe. Its round shape and intricate design make it a versatile addition to any room, offering both style and comfort. Crafted from a blend of wool and cotton, this rug is soft yet durable, perfect for high-traffic areas. The reversible feature allows for extended use and easy maintenance, making it a practical choice for modern homes.","features":["Reversible design for extended use","Abstract pattern with flowing lines","Soft wool and cotton blend","Round shape for versatile placement","Durable and suitable for high-traffic areas"],"careInstructions":"Vacuum regularly on a low setting. Spot clean with mild detergent and water. Avoid direct sunlight to prevent fading.","materialComposition":"70% Wool, 30% Cotton"}',
    '["living-room","bedroom","reversible","moroccan","Moroccan rug","reversible rug","abstract pattern","round rug","wool rug","cotton rug","living room decor","bedroom decor","bohemian style","textured rug","durable rug","soft rug","high-traffic rug","modern home","versatile rug","cream rug","taupe rug","elegant rug","flowing lines","matte finish","comfortable rug","easy maintenance","vacuum regularly","spot clean","avoid sunlight","home decor","floor covering","interior design","soft texture","decorative rug","stylish rug"]',
    '{"metaTitle":"Moroccan Reversible Rug - Abstract Pattern & Comfort","metaDescription":"Discover the Moroccan Reversible Rug with an elegant abstract design in cream and taupe. Perfect for any room, offering style and durability. Shop now!","altText":"Elegant Moroccan-inspired reversible rug with abstract pattern in cream and taupe.","keywords":["Moroccan rug","reversible rug","abstract pattern","round rug","wool rug","cotton rug","living room decor","bedroom decor","bohemian style","textured rug","durable rug","soft rug","high-traffic rug","modern home","versatile rug","cream rug","taupe rug","elegant rug","flowing lines","matte finish","comfortable rug","easy maintenance","vacuum regularly","spot clean","home decor","floor covering","interior design","soft texture","decorative rug","stylish rug"]}',
    TRUE,
    FALSE,
    4.7,
    178,
    TRUE,
    '2024-01-18T00:00:00Z',
    '2024-01-18T00:00:00Z'
FROM categories c
WHERE c.slug = 'rugs'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Striped Reversible Cotton Rug
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'RUG-REV-004',
    'Striped Reversible Cotton Rug',
    'Classic striped reversible rug in soft cotton',
    149.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'reversible-rug' AND category_id = c.id),
    35,
    'in_stock'::stock_status,
    '{"color":["Cream","Beige","Light Brown"],"material":["Cotton"],"style":["Farmhouse","Contemporary"],"room":["Living Room","Bedroom","Entryway"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Cream","hex":"#F5F5DC","category":"primary"},{"name":"Beige","hex":"#F5F5F5","category":"secondary"},{"name":"Light Brown","hex":"#D2B48C","category":"accent"}],"pattern":"geometric","texture":"textured","finish":"matte","shape":"rectangular","silhouette":"Low-profile with clean lines"}',
    '{"short":"Elegant reversible cotton rug with geometric stripes, perfect for contemporary or farmhouse decor.","long":"Transform your living space with our Striped Reversible Cotton Rug, a harmonious blend of style and functionality. This exquisite rug boasts a sophisticated geometric stripe pattern in soothing cream, beige, and light brown tones, making it an ideal choice for both farmhouse and contemporary interiors. Crafted from high-quality cotton, it provides a soft, comforting feel underfoot, while the reversible design allows you to effortlessly alternate looks. Whether gracing your living room, bedroom, or entryway, this rug enhances any area with its understated elegance. With its low-profile and clean lines, it seamlessly integrates with your existing decor, offering both aesthetic appeal and practical versatility.","features":["Reversible design for dual styling options","Elegant geometric stripe pattern","Soft, comfortable cotton texture","Neutral cream, beige, and light brown tones","Versatile for farmhouse and contemporary decor","Low-profile silhouette with clean lines","Durable and stylish for high-traffic areas"],"careInstructions":"Vacuum regularly to remove dust and debris. Spot clean with a mild detergent as needed. Avoid prolonged exposure to direct sunlight to prevent fading.","materialComposition":"100% Cotton"}',
    '["bedroom","entryway","reversible","striped","reversible rug","cotton rug","geometric stripes","neutral tones","farmhouse style","contemporary decor","living room rug","bedroom rug","entryway rug","textured rug","matte finish","rectangular rug","soft underfoot","versatile design","high-quality cotton","elegant rug","modern rug","striped rug","beige rug","cream rug","light brown accents","durable rug","easy to clean","vacuum regularly","spot clean","avoid direct sunlight","comfortable texture","stylish rug","functional rug","decorative rug","striped reversible cotton rug","geometric stripe rug","neutral tone rug","farmhouse style rug","contemporary decor rug","living room cotton rug","bedroom cotton rug","textured cotton rug","matte finish rug","soft underfoot rug","versatile design rug","high-quality cotton rug","elegant modern rug","beige and cream rug","light brown accent rug","durable cotton rug","easy to clean rug","vacuum regular rug","spot clean rug","comfortable texture rug","stylish decorative rug","functional cotton rug","reversible design rug"]',
    '{"metaTitle":"Striped Reversible Cotton Rug - Elegant Geometric Design","metaDescription":"Enhance your home with our Striped Reversible Cotton Rug. Enjoy its stylish geometric pattern and soft comfort. Perfect for any decor. Buy now!","altText":"Striped reversible cotton rug with geometric pattern in neutral tones.","keywords":["striped reversible cotton rug","geometric stripe rug","neutral tone rug","farmhouse style rug","contemporary decor rug","living room cotton rug","bedroom cotton rug","entryway rug","textured cotton rug","matte finish rug","rectangular rug","soft underfoot rug","versatile design rug","high-quality cotton rug","elegant modern rug","beige and cream rug","light brown accent rug","durable cotton rug","easy to clean rug","vacuum regular rug","spot clean rug","comfortable texture rug","stylish decorative rug","functional cotton rug","reversible design rug"]}',
    FALSE,
    FALSE,
    4.5,
    145,
    TRUE,
    '2024-01-15T00:00:00Z',
    '2024-01-15T00:00:00Z'
FROM categories c
WHERE c.slug = 'rugs'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Hand-Woven Jute Area Rug
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'RUG-NAT-001',
    'Hand-Woven Jute Area Rug',
    'Natural hand-woven jute rug with organic texture',
    189.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'natural-fiber-rug' AND category_id = c.id),
    20,
    'in_stock'::stock_status,
    '{"color":["Crimson Red","Cream","Dark Navy"],"material":["Jute"],"style":["Traditional","Bohemian"],"room":["Living Room","Dining Room"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Crimson Red","hex":"#DC143C","category":"primary"},{"name":"Cream","hex":"#FFFDD0","category":"secondary"},{"name":"Dark Navy","hex":"#000080","category":"accent"}],"pattern":"floral","texture":"smooth","finish":"matte","shape":"rectangular","silhouette":"Flat with intricate borders"}',
    '{"short":"Elevate your space with this vibrant, hand-woven jute rug featuring intricate floral patterns and rich colors.","long":"Transform your living or dining area with the Hand-Woven Jute Area Rug, priced at $189.99. This exquisite rug boasts a captivating blend of crimson red, cream, and dark navy hues, woven into intricate floral and geometric patterns. Its traditional design adds a touch of elegance, while the smooth texture ensures durability, making it perfect for high-traffic areas. The fringed edges and intricate border design enhance its bohemian charm, serving as a stunning centerpiece that radiates warmth and sophistication. Experience the beauty and durability of eco-friendly jute, ideal for everyday use or entertaining guests.","features":["Captivating floral and geometric patterns","Rich crimson red, cream, and dark navy colors","Smooth, durable texture perfect for high-traffic","Elegant traditional design with fringed edges","Eco-friendly hand-woven craftsmanship","Flat silhouette with intricate borders","Versatile for living and dining rooms"],"careInstructions":"Vacuum regularly to keep the rug clean. Spot clean with a damp cloth for stains. Keep away from direct sunlight to prevent fading.","materialComposition":"100% Natural Jute"}',
    '["living-room","dining-room","natural","jute","eco-friendly","hand-woven","floral rug","traditional design","vibrant colors","living room rug","dining room rug","home decor","elegant rug","bohemian style","jute rug","durable","high-traffic","centerpiece","intricate patterns","smooth texture","fringed edges","matte finish","rectangular rug","crimson red","cream","dark navy","hand-woven rug","jute area rug","floral patterns","eco-friendly rug","durable rug","high-traffic rug","living room decor","centerpiece rug","crimson red rug","cream rug","dark navy rug","rug for entertaining","rug with intricate borders","rug with fringed edges","rug for everyday use","rug with geometric patterns"]',
    '{"metaTitle":"Hand-Woven Jute Area Rug - Elegant & Durable Design","metaDescription":"Enhance your space with the Hand-Woven Jute Area Rug. Elegant floral patterns, eco-friendly jute, perfect for high-traffic areas. Buy now for $189.99!","altText":"Vibrant hand-woven jute area rug featuring intricate floral and geometric patterns in crimson red, cream, and dark navy.","keywords":["hand-woven rug","jute area rug","floral patterns","traditional design","bohemian style","eco-friendly rug","durable rug","high-traffic rug","living room decor","dining room rug","elegant rug","vibrant colors","centerpiece rug","smooth texture","fringed edges","matte finish","rectangular rug","crimson red rug","cream rug","dark navy rug","home decor","rug for entertaining","rug with intricate borders","rug with fringed edges","rug for everyday use","rug with geometric patterns"]}',
    TRUE,
    TRUE,
    4.7,
    256,
    TRUE,
    '2024-01-03T00:00:00Z',
    '2024-01-03T00:00:00Z'
FROM categories c
WHERE c.slug = 'rugs'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Solid Color Reversible Rug
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'RUG-REV-006',
    'Solid Color Reversible Rug',
    'Simple solid reversible rug with contrasting sides',
    129.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'reversible-rug' AND category_id = c.id),
    40,
    'in_stock'::stock_status,
    '{"color":["Ivory","Navy Blue","Crimson Red","Beige"],"material":["Cotton"],"style":["Traditional","Classic"],"room":["Living Room","Bedroom","Dining Room"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Ivory","hex":"#FFFFF0","category":"primary"},{"name":"Navy Blue","hex":"#000080","category":"secondary"},{"name":"Crimson Red","hex":"#DC143C","category":"accent"},{"name":"Beige","hex":"#F5F5DC","category":"secondary"}],"pattern":"floral","texture":"woven","finish":"matte","shape":"rectangular","silhouette":"Low-profile with intricate border"}',
    '{"short":"Stylish reversible rug offering dual color options for versatile home decor.","long":"Elevate your living space with our Solid Color Reversible Rug, the epitome of style and versatility. Priced at $129.99, this rug features a minimalist design with a sophisticated solid color palette, perfect for modern or traditional settings. Its reversible nature offers two stylish looks in one, allowing you to effortlessly switch up your decor. Crafted with premium materials, this rug is both soft underfoot and durable enough to withstand high-traffic areas, making it ideal for your living room, bedroom, or dining area. The low-profile silhouette ensures it fits seamlessly under furniture, while the rich textures add a touch of warmth and elegance to any room. Transform your home with this easy-to-maintain, versatile piece that promises to be a staple in your decor for years to come.","features":["Reversible design for dual styling options","Solid color palette for a modern look","Durable construction for high-traffic areas","Soft texture for comfort underfoot","Low-profile silhouette fits under furniture","Versatile for living room, bedroom, or dining room"],"careInstructions":"Vacuum regularly to maintain appearance. Spot clean with mild detergent and water. Avoid direct sunlight to preserve color vibrancy.","materialComposition":"100% high-quality cotton with a tightly woven texture"}',
    '["bedroom","living-room","reversible","solid","floral rug","traditional design","reversible rug","elegant decor","living room rug","bedroom rug","dining room rug","cotton rug","woven texture","classic style","home decor","interior design","patterned rug","colorful rug","high-traffic area","durable rug","versatile styling","sophisticated look","rich colors","detailed weaving","matte finish","rectangular shape","low-profile","solid color rug","minimalist rug","modern rug","traditional rug","soft rug","high-traffic rug","low-profile rug","elegant rug","stylish rug","versatile rug","easy-to-maintain rug","premium materials rug","home decor rug","interior design rug","solid color palette","rug under furniture","rug with rich textures","rug for modern settings","rug for traditional settings","rug transformation","rug staple decor"]',
    '{"metaTitle":"Solid Color Reversible Rug - Stylish & Versatile Design","metaDescription":"Transform your space with our Solid Color Reversible Rug. Enjoy two stylish looks in one. Shop now for $129.99 and elevate your decor effortlessly!","altText":"Solid Color Reversible Rug featuring a minimalist design and sophisticated palette.","keywords":["solid color rug","reversible rug","minimalist rug","modern rug","traditional rug","living room rug","bedroom rug","dining room rug","soft rug","durable rug","high-traffic rug","low-profile rug","elegant rug","stylish rug","versatile rug","easy-to-maintain rug","premium materials rug","home decor rug","interior design rug","solid color palette","rug under furniture","rug with rich textures","rug for modern settings","rug for traditional settings","rug transformation","rug staple decor"]}',
    FALSE,
    TRUE,
    4.4,
    134,
    TRUE,
    '2024-01-20T00:00:00Z',
    '2024-01-20T00:00:00Z'
FROM categories c
WHERE c.slug = 'rugs'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Sisal Herringbone Rug
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'RUG-NAT-002',
    'Sisal Herringbone Rug',
    'Durable sisal rug with elegant herringbone pattern',
    229.99,
    289.99,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'natural-fiber-rug' AND category_id = c.id),
    14,
    'in_stock'::stock_status,
    '{"color":["Slate Blue","Vibrant Orange","Charcoal Gray"],"material":["Synthetic Fiber"],"style":["Modern","Contemporary"],"room":["Living Room","Office"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Slate Blue","hex":"#6A7B8D","category":"primary"},{"name":"Vibrant Orange","hex":"#FF5733","category":"accent"},{"name":"Charcoal Gray","hex":"#36454F","category":"secondary"}],"pattern":"abstract","texture":"smooth","finish":"matte","shape":"rectangular","silhouette":"Low-profile with clean lines"}',
    '{"short":"Natural sisal herringbone rug adds texture and warmth to any room.","long":"Transform your space with the Sisal Herringbone Rug, a natural beauty that brings organic texture and elegant warmth to any room. Crafted from eco-friendly sisal fibers, this rug features a timeless herringbone pattern that complements both modern and traditional decor styles. Its neutral tones blend seamlessly with your interior palette, creating an inviting atmosphere. The rug''s sturdy weave ensures durability, making it perfect for high-traffic areas like living rooms or entryways. Experience the comforting underfoot feel while enjoying the aesthetic appeal of natural materials.","features":["Eco-friendly sisal fibers","Timeless herringbone pattern","Neutral tones for versatile decor","Durable weave for high-traffic areas","Natural texture and warmth","Perfect for modern and traditional spaces","Comforting underfoot feel"],"careInstructions":"Regularly vacuum and rotate to maintain even wear. Spot clean with mild soap and water. Avoid saturating with water.","materialComposition":"100% natural sisal fibers woven into a durable herringbone pattern."}',
    '["living-room","entryway","natural","sisal","herringbone","modern rug","abstract design","blue rug","living room decor","contemporary style","accent rug","home decor","office rug","durable","comfortable","medium pile","stylish","artistic","vibrant colors","slate blue","orange accents","rectangular rug","smooth texture","matte finish","low-profile","Sisal Herringbone Rug","eco-friendly rug","durable rugs","natural texture rug","herringbone pattern rug","living room rug","entryway rug","organic texture rug","neutral tone rug","high-traffic area rug","elegant rugs","sustainable home decor","modern decor rug","traditional decor rug","comfortable underfoot rug","natural material rug","sisal fiber rug","timeless rug design","interior palette rug","inviting atmosphere rug","sturdy weave rug","home transformation rug","warmth adding rug","room enhancing rug","decor complementing rug","rug for modern homes","rug for traditional homes"]',
    '{"metaTitle":"Sisal Herringbone Rug - Eco-Friendly & Durable Design","metaDescription":"Enhance your home with the Sisal Herringbone Rug. Eco-friendly and durable, perfect for high-traffic areas. Shop now for elegance and comfort!","altText":"Sisal Herringbone Rug with natural texture and herringbone pattern for modern and traditional decor.","keywords":["Sisal Herringbone Rug","eco-friendly rug","durable rugs","natural texture rug","herringbone pattern rug","living room rug","entryway rug","organic texture rug","neutral tone rug","high-traffic area rug","elegant rugs","sustainable home decor","modern decor rug","traditional decor rug","comfortable underfoot rug","natural material rug","sisal fiber rug","timeless rug design","interior palette rug","inviting atmosphere rug","sturdy weave rug","home transformation rug","warmth adding rug","room enhancing rug","decor complementing rug","rug for modern homes","rug for traditional homes"]}',
    TRUE,
    FALSE,
    4.8,
    198,
    TRUE,
    '2024-01-06T00:00:00Z',
    '2024-01-06T00:00:00Z'
FROM categories c
WHERE c.slug = 'rugs'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Seagrass Round Rug
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'RUG-NAT-003',
    'Seagrass Round Rug',
    'Round seagrass rug for a natural coastal look',
    159.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'natural-fiber-rug' AND category_id = c.id),
    25,
    'in_stock'::stock_status,
    '{"color":["Natural"],"material":["Seagrass"],"style":["Coastal","Bohemian"],"room":["Living Room","Bedroom"],"occasion":["Everyday","Relaxation"]}',
    '{"primaryColors":[{"name":"Natural","hex":"#D2B48C","category":"primary"}],"pattern":"solid","texture":"textured","finish":"natural","shape":"round","silhouette":"Low-profile with a natural, organic form"}',
    '{"short":"Embrace coastal elegance with our Seagrass Round Rug.","long":"Transform your living space into a serene coastal retreat with the Seagrass Round Rug. Crafted from natural seagrass fibers, this rug exudes an earthy charm that seamlessly blends with both contemporary and rustic decor. The textured surface adds a tactile layer of depth, inviting guests to experience its unique woven feel. Perfect for living rooms or bedrooms, its neutral tones complement a variety of color palettes, offering versatility and timeless style. Durable and eco-friendly, it is an ideal choice for those who appreciate sustainable beauty.","features":["Made from 100% natural seagrass","Round, low-profile design fits any room","Textured surface provides tactile interest","Neutral tones for versatile styling","Eco-friendly and sustainable material","Durable construction for long-lasting use","Perfect for coastal and bohemian decor"],"careInstructions":"Regularly vacuum to remove dust and debris. Spot clean using a damp cloth when necessary. Keep away from direct sunlight to avoid fading.","materialComposition":"100% Seagrass"}',
    '["living-room","bedroom","natural","seagrass","round","round rug","coastal decor","bohemian style","living room","eco-friendly","textured rug","neutral tones","organic","durable","versatile","earthy","natural fibers","home decor","interior design","sustainable","floor covering","woven","handmade","beach house","rustic","casual","soft underfoot","easy maintenance","vacuum friendly","spot clean","fade resistant","natural finish","low-profile","organic form","textured surface","eco-conscious","Seagrass Round Rug","natural seagrass rug","coastal decor rug","bohemian style rug","eco-friendly rug","neutral tone rug","rustic decor rug","living room rug","bedroom rug","sustainable rug","organic floor covering","woven rug","handmade rug","beach house decor","durable seagrass rug","versatile rug","earthy rug","home decor rug","interior design rug","natural fibers rug","low-profile rug","fade resistant rug","easy maintenance rug","vacuum friendly rug","spot clean rug","natural finish rug","organic form rug","textured surface rug"]',
    '{"metaTitle":"Seagrass Round Rug - Eco-Friendly Coastal Charm","metaDescription":"Transform your space with our Seagrass Round Rug. Eco-friendly and durable, it offers a coastal vibe. Shop now for a touch of natural elegance!","altText":"Seagrass Round Rug with natural fibers and textured surface for a coastal style.","keywords":["Seagrass Round Rug","natural seagrass rug","coastal decor rug","bohemian style rug","eco-friendly rug","textured rug","neutral tone rug","rustic decor rug","living room rug","bedroom rug","sustainable rug","organic floor covering","woven rug","handmade rug","beach house decor","durable seagrass rug","versatile rug","earthy rug","home decor rug","interior design rug","natural fibers rug","low-profile rug","fade resistant rug","easy maintenance rug","vacuum friendly rug","spot clean rug","natural finish rug","organic form rug","textured surface rug"]}',
    FALSE,
    TRUE,
    4.6,
    167,
    TRUE,
    '2024-01-10T00:00:00Z',
    '2024-01-10T00:00:00Z'
FROM categories c
WHERE c.slug = 'rugs'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Braided Jute Runner
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'RUG-NAT-004',
    'Braided Jute Runner',
    'Braided jute runner perfect for hallways and entryways',
    89.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'natural-fiber-rug' AND category_id = c.id),
    45,
    'in_stock'::stock_status,
    '{"color":["Deep Red","Earthy Brown","Soft Cream"],"material":["Jute"],"style":["Traditional","Bohemian"],"room":["Living Room","Entryway","Hallway"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Deep Red","hex":"#8B0000","category":"primary"},{"name":"Earthy Brown","hex":"#A0522D","category":"secondary"},{"name":"Soft Cream","hex":"#FFFDD0","category":"accent"}],"pattern":"geometric","texture":"woven","finish":"natural","shape":"rectangular","silhouette":"Low-profile with intricate patterns"}',
    '{"short":"Transform your space with the rustic charm of the Braided Jute Runner, perfect for adding texture and warmth.","long":"The Braided Jute Runner is a quintessential piece for any home seeking a touch of natural elegance. Crafted from durable jute, this runner boasts a rich, earthy texture that enhances the rustic ambiance of your living room, hallway, or entryway. Its intricate braiding provides a visual feast of texture, inviting you to experience the serene comfort underfoot. Measuring at a practical length, it effortlessly complements any space while its eco-friendly materials promise longevity and sustainability. Ideal for high-traffic areas, this runner is both functional and stylish, making it a must-have addition to your home decor.","features":["Crafted from durable jute","Intricate braiding adds texture","Eco-friendly and sustainable materials","Perfect for high-traffic areas","Adds rustic charm to any room","Comfortable underfoot experience"],"careInstructions":"Spot clean with a damp cloth. Avoid prolonged exposure to moisture and direct sunlight. Regularly shake out to remove debris.","materialComposition":"100% natural jute fibers"}',
    '["entryway","hallway","natural","jute","runner","geometric rug","traditional style","bohemian decor","warm tones","woven texture","fringe detailing","entryway rug","living room centerpiece","durable jute","cultural flair","high-traffic areas","comfortable underfoot","elegant design","earthy colors","soft cream accents","deep red highlights","natural finish","rectangular shape","low-profile rug","Braided Jute Runner","eco-friendly rugs","sustainable home decor","rustic ambiance","hallway runner","natural elegance","jute rug","textured runner","home decor upgrade","sustainable materials"]',
    '{"metaTitle":"Braided Jute Runner - Durable, Eco-Friendly Elegance","metaDescription":"Enhance your home with the Braided Jute Runner. Experience natural elegance and durability. Order now for a stylish and sustainable decor upgrade!","altText":"Braided Jute Runner with geometric patterns in warm tones, ideal for entryways.","keywords":["Braided Jute Runner","geometric rug","traditional style","bohemian decor","warm tones","woven texture","fringe detailing","entryway rug","living room centerpiece","durable jute","cultural flair","high-traffic areas","comfortable underfoot","elegant design","earthy colors","soft cream accents","deep red highlights","natural finish","rectangular shape","low-profile rug","eco-friendly rugs","sustainable home decor","rustic ambiance","hallway runner","natural elegance","jute rug","textured runner","home decor upgrade","sustainable materials"]}',
    FALSE,
    FALSE,
    4.5,
    145,
    TRUE,
    '2024-01-14T00:00:00Z',
    '2024-01-14T00:00:00Z'
FROM categories c
WHERE c.slug = 'rugs'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Chunky Wool Natural Rug
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'RUG-NAT-005',
    'Chunky Wool Natural Rug',
    'Thick chunky wool rug with natural undyed fibers',
    349.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'natural-fiber-rug' AND category_id = c.id),
    12,
    'in_stock'::stock_status,
    '{"color":["Multicolored","Bright Red","Lime Green","Sky Blue"],"material":["Cotton","Synthetic Fibers"],"style":["Eclectic","Bohemian"],"room":["Living Room","Bedroom"],"occasion":["Everyday","Decorative"]}',
    '{"primaryColors":[{"name":"Multicolored","hex":"#D2691E","category":"primary"},{"name":"Bright Red","hex":"#FF4500","category":"accent"},{"name":"Lime Green","hex":"#32CD32","category":"accent"},{"name":"Sky Blue","hex":"#87CEEB","category":"accent"}],"pattern":"geometric","texture":"woven","finish":"natural","shape":"round","silhouette":"Round with braided spiral and fringed edges"}',
    '{"short":"Add cozy charm to any room with our Chunky Wool Natural Rug, offering warmth and texture for a serene ambiance.","long":"Transform your living space with the luxurious Chunky Wool Natural Rug. Handcrafted from 100% natural wool, this rug embodies the essence of cozy elegance. Its thick, chunky weave invites you to sink your feet into its plush texture, making it a perfect addition for those chilly mornings. The neutral hues of creamy whites and soft beiges seamlessly blend with any decor style, from minimalist Scandinavian to rustic farmhouse. This rug not only enhances the aesthetic of your space but also provides excellent insulation, keeping your feet warm and your room stylishly comfortable. Perfectly suited for living rooms, bedrooms, or any area needing a touch of warmth and sophistication.","features":["Handcrafted from 100% natural wool","Thick, chunky weave for plush texture","Neutral hues complement various decor styles","Provides excellent insulation","Enhances warmth and sophistication in any room","Ideal for living rooms and bedrooms","Eco-friendly and sustainable material"],"careInstructions":"Vacuum regularly on a low-power setting to maintain the wool''s texture. Spot clean spills immediately with a clean, damp cloth. Avoid exposure to direct sunlight to prevent fading.","materialComposition":"100% natural wool"}',
    '["living-room","bedroom","natural","wool","chunky","round rug","braided rug","multicolored","fringed edges","eclectic style","bohemian decor","living room rug","bedroom rug","vibrant rug","colorful rug","decorative rug","textured rug","woven rug","spiral pattern","cotton rug","synthetic fibers","unique rug","statement piece","home decor","floor covering","interior design","accent rug","handmade look","artistic rug","playful design","eye-catching","bold colors","textile art","boho chic","modern eclectic","colorful home","Chunky Wool Rug","Natural Wool Rug","Handcrafted Wool Rug","Luxury Wool Rug","Cozy Wool Rug","Neutral Tone Rug","Thick Wool Rug","Warm Wool Rug","Elegant Wool Rug","Scandinavian Rug","Farmhouse Rug","Living Room Rug","Bedroom Rug","Wool Floor Rug","Insulating Rug","Plush Wool Rug","Stylish Wool Rug","Comfortable Wool Rug","Home Decor Rug","Warmth and Sophistication","Natural Fiber Rug","High-Quality Wool Rug","Rug for Chilly Mornings","Minimalist Rug","Rustic Rug","Wool Area Rug","Eco-Friendly Rug","Rug for Any Decor","Woolen Rug"]',
    '{"metaTitle":"Chunky Wool Natural Rug - Cozy Elegance & Insulation","metaDescription":"Elevate your home with the Chunky Wool Natural Rug. Crafted from 100% natural wool, this plush, neutral-toned rug adds warmth and sophistication. Shop now!","altText":"Chunky Wool Natural Rug with thick weave in creamy whites and soft beiges.","keywords":["Chunky Wool Rug","Natural Wool Rug","Handcrafted Wool Rug","Luxury Wool Rug","Cozy Wool Rug","Neutral Tone Rug","Thick Wool Rug","Warm Wool Rug","Elegant Wool Rug","Scandinavian Rug","Farmhouse Rug","Living Room Rug","Bedroom Rug","Wool Floor Rug","Insulating Rug","Plush Wool Rug","Stylish Wool Rug","Comfortable Wool Rug","Home Decor Rug","Warmth and Sophistication","Natural Fiber Rug","High-Quality Wool Rug","Rug for Chilly Mornings","Minimalist Rug","Rustic Rug","Wool Area Rug","Eco-Friendly Rug","Rug for Any Decor","Woolen Rug"]}',
    TRUE,
    FALSE,
    4.9,
    189,
    TRUE,
    '2024-01-18T00:00:00Z',
    '2024-01-18T00:00:00Z'
FROM categories c
WHERE c.slug = 'rugs'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- Product: Mixed Fiber Natural Rug
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    'RUG-NAT-006',
    'Mixed Fiber Natural Rug',
    'Beautiful blend of natural fibers for unique texture',
    219.99,
    NULL,
    'USD',
    c.id,
    (SELECT id FROM product_types WHERE slug = 'natural-fiber-rug' AND category_id = c.id),
    18,
    'in_stock'::stock_status,
    '{"color":["Deep Ocean Blue","Crimson Red","Natural Beige","Forest Green","Sunset Orange"],"material":["Jute","Cotton"],"style":["Bohemian","Coastal"],"room":["Living Room","Dining Room"],"occasion":["Everyday","Entertaining"]}',
    '{"primaryColors":[{"name":"Deep Ocean Blue","hex":"#004f7c","category":"primary"},{"name":"Crimson Red","hex":"#9e1b1b","category":"accent"},{"name":"Natural Beige","hex":"#d3b8a1","category":"secondary"},{"name":"Forest Green","hex":"#2e6b2d","category":"accent"},{"name":"Sunset Orange","hex":"#d87f3e","category":"accent"}],"pattern":"geometric","texture":"textured","finish":"natural","shape":"rectangular","silhouette":"Flat-weave with fringe edges"}',
    '{"short":"Vibrant natural fiber rug with geometric patterns and fringe detailing.","long":"Introducing the Mixed Fiber Natural Rug, a stunning fusion of eco-friendly materials and artistic design. This rug features a rich tapestry of deep ocean blue, crimson red, forest green, and sunset orange woven into intricate geometric patterns, making it a centerpiece for any room. Crafted from a durable blend of jute and cotton, it offers both resilience and a soft, textured feel underfoot. The playful fringe edges add a whimsical touch, complementing its bohemian and coastal vibes. Perfect for living rooms or dining spaces, this rug not only enhances your decor with vibrant colors but also reflects a commitment to sustainable living. Elevate your home with this unique masterpiece and enjoy a harmonious blend of style and comfort.","features":["Vibrant geometric patterns","Playful fringe edges","Eco-friendly jute and cotton materials","Durable and textured","Bohemian and coastal style","Rich color palette: blues, reds, greens, oranges","Sustainable and artisan-crafted"],"careInstructions":"Vacuum regularly to maintain cleanliness. Spot clean with mild detergent as needed. Avoid direct sunlight to prevent color fading.","materialComposition":"70% Jute, 30% Cotton"}',
    '["living-room","dining-room","natural","mixed-fiber","eco-friendly","bohemian","geometric","fringe","natural fibers","jute","cotton","living room","dining room","colorful","durable","textured","patterned","decorative","sustainable","handmade","artisan","unique","vibrant","modern","coastal","home decor","floor covering","rug","mixed fiber","5x7","6x9","8x10","soft","comfortable","warm","inviting","stylish","versatile","high quality","easy care","non-toxic","environmentally friendly","artistic","eye-catching","multi-color","handcrafted","woven","Mixed Fiber Natural Rug","eco-friendly rug","bohemian rug","geometric rug","jute cotton rug","vibrant rug","living room rug","dining room rug","colorful rug","sustainable rug","handmade rug","artisan rug","coastal style rug","natural fiber rug","textured rug","patterned rug","decorative rug","durable rug","fringe edge rug","modern rug","home decor rug","floor covering rug","unique rug design","artistic rug","eye-catching rug","multi-color rug","woven rug","soft comfortable rug","high quality rug"]',
    '{"metaTitle":"Mixed Fiber Natural Rug - Eco-Friendly & Vibrant Design","metaDescription":"Discover the Mixed Fiber Natural Rug, a blend of jute & cotton with vibrant geometric patterns. Perfect for living rooms. Shop now for style & sustainability!","altText":"Mixed Fiber Natural Rug with vibrant geometric patterns and fringe edges.","keywords":["Mixed Fiber Natural Rug","eco-friendly rug","bohemian rug","geometric rug","jute cotton rug","vibrant rug","living room rug","dining room rug","colorful rug","sustainable rug","handmade rug","artisan rug","coastal style rug","natural fiber rug","textured rug","patterned rug","decorative rug","durable rug","fringe edge rug","modern rug","home decor rug","floor covering rug","unique rug design","artistic rug","eye-catching rug","multi-color rug","woven rug","soft comfortable rug","high quality rug"]}',
    FALSE,
    TRUE,
    4.6,
    156,
    TRUE,
    '2024-01-22T00:00:00Z',
    '2024-01-22T00:00:00Z'
FROM categories c
WHERE c.slug = 'rugs'
ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    compare_at_price = EXCLUDED.compare_at_price,
    attributes = EXCLUDED.attributes,
    visual_attributes = EXCLUDED.visual_attributes,
    enriched_description = EXCLUDED.enriched_description,
    tags = EXCLUDED.tags,
    seo = EXCLUDED.seo,
    is_featured = EXCLUDED.is_featured,
    is_bestseller = EXCLUDED.is_bestseller,
    avg_rating = EXCLUDED.avg_rating,
    review_count = EXCLUDED.review_count,
    updated_at = NOW();

-- ============================================================================
-- PRODUCT IMAGES
-- ============================================================================

-- Lighting Images
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'ceiling-light-1.jpeg', 'Elegant modern globe pendant light featuring frosted glass globes and warm brass accents.', TRUE, 0
FROM products WHERE sku = 'LGT-CL-001'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'ceiling-light-2.jpeg', 'Industrial Cage Pendant with matte black finish and exposed bulb design.', TRUE, 0
FROM products WHERE sku = 'LGT-CL-002'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'ceiling-light-3.jpeg', 'Rattan Dome Pendant light fixture with modern layered design and warm ambient glow.', TRUE, 0
FROM products WHERE sku = 'LGT-CL-003'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'ceiling-light-4.jpg', 'Elegant crystal chandelier with a luxurious chrome finish and sparkling crystals.', TRUE, 0
FROM products WHERE sku = 'LGT-CL-004'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'ceiling-light-5.jpg', 'Minimalist Flush Mount with sleek design and warm glow for modern decor.', TRUE, 0
FROM products WHERE sku = 'LGT-CL-005'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'ceiling-light-6.jpg', 'Elegant Sputnik chandelier with reflective metallic spheres in copper gold finish.', TRUE, 0
FROM products WHERE sku = 'LGT-CL-006'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'ceiling-light-7.jpg', 'Fabric Drum Pendant with a sleek metal frame and warm fabric shade.', TRUE, 0
FROM products WHERE sku = 'LGT-CL-007'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'ceiling-light-8.jpg', 'Geometric metal pendant light with angular design, matte black and gold finish, drum shade casting shadows.', TRUE, 0
FROM products WHERE sku = 'LGT-CL-008'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'floor-lamp-1.jpeg', 'Arc Floor Lamp with elegant sculptural design and warm ambient glow, perfect for modern interiors.', TRUE, 0
FROM products WHERE sku = 'LGT-FL-001'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'floor-lamp-2.jpeg', 'Elegant tripod floor lamp with matte black base and beige linen shade', TRUE, 0
FROM products WHERE sku = 'LGT-FL-002'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'floor-lamp-3.jpeg', 'Industrial Task Floor Lamp with adjustable arm and matte black finish for precise lighting in modern interiors.', TRUE, 0
FROM products WHERE sku = 'LGT-FL-003'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'floor-lamp-4.jpeg', 'Elegant torchiere floor lamp with a warm golden finish and pleated shade, offering ambient lighting.', TRUE, 0
FROM products WHERE sku = 'LGT-FL-004'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'floor-lamp-5.jpeg', 'Rattan Floor Lamp with a woven rattan shade and sleek metal stand, casting a warm glow.', TRUE, 0
FROM products WHERE sku = 'LGT-FL-005'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'floor-lamp-6.jpg', 'LED Tree Floor Lamp with sculptural tree-like design and ambient glow', TRUE, 0
FROM products WHERE sku = 'LGT-FL-006'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'floor-lamp-7.jpg', 'Japanese-inspired paper lantern floor lamp with rice paper shade and wooden base.', TRUE, 0
FROM products WHERE sku = 'LGT-FL-007'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'floor-lamp-8.jpg', 'Sleek Pharmacy Floor Lamp with angular geometric shades and modern design in jet black finish.', TRUE, 0
FROM products WHERE sku = 'LGT-FL-008'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'floor-lamp-9.jpg', 'Elegant floor lamp with a marble base and adjustable metal arm in brass finish', TRUE, 0
FROM products WHERE sku = 'LGT-FL-009'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'table-lamp-1.jpeg', 'Modern ceramic table lamp with cube-shaped design and warm ambient glow, perfect for living room or bedroom.', TRUE, 0
FROM products WHERE sku = 'LGT-TL-001'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'table-lamp-2.jpeg', 'Crystal Base Table Lamp with white shade, offering a warm glow and elegant design.', TRUE, 0
FROM products WHERE sku = 'LGT-TL-002'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'table-lamp-3.jpeg', 'Industrial desk lamp with adjustable arm and black matte finish on a desk.', TRUE, 0
FROM products WHERE sku = 'LGT-TL-003'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'table-lamp-4.jpeg', 'Elegant Glass Orb Table Lamp with a polished metal base and warm glow.', TRUE, 0
FROM products WHERE sku = 'LGT-TL-004'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'table-lamp-5.jpeg', 'Elegant Wooden Accent Table Lamp with a rustic wooden base and beige fabric shade.', TRUE, 0
FROM products WHERE sku = 'LGT-TL-005'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'table-lamp-6.jpg', 'Modern table lamp with ribbed off-white shade and integrated planter on a sleek gray frame.', TRUE, 0
FROM products WHERE sku = 'LGT-TL-006'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'table-lamp-7.jpg', 'Tiffany Style Table Lamp with stained glass shade and antique finish', TRUE, 0
FROM products WHERE sku = 'LGT-TL-007'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'table-lamp-8.jpg', 'Elegant touch dimmer table lamp with cream shade and adjustable brass neck for versatile lighting.', TRUE, 0
FROM products WHERE sku = 'LGT-TL-008'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'table-lamp-9.jpg', 'Stylish teal table lamp with adjustable arm and modern design, perfect for task lighting.', TRUE, 0
FROM products WHERE sku = 'LGT-TL-009'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'wall-sconce-1.jpeg', 'Industrial swing arm sconce with olive green shade and brass arm on wooden mount.', TRUE, 0
FROM products WHERE sku = 'LGT-WS-001'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'wall-sconce-2.jpeg', 'Elegant Crystal Wall Sconce with organic wooden base and frosted glass globe emitting warm ambient light.', TRUE, 0
FROM products WHERE sku = 'LGT-WS-002'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'wall-sconce-3.jpeg', 'Modern Globe Sconce with brass accents and pleated shade, ideal for ambient lighting in various rooms.', TRUE, 0
FROM products WHERE sku = 'LGT-WS-003'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'wall-sconce-4.jpeg', 'Elegant Art Deco sconce with frosted glass globes and gold finish.', TRUE, 0
FROM products WHERE sku = 'LGT-WS-004'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'wall-sconce-5.jpeg', 'Elegant wall sconce with warm bronze finish and fabric shade for ambient lighting.', TRUE, 0
FROM products WHERE sku = 'LGT-WS-005'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'wall-sconce-6.jpeg', 'Elegant LED picture light with spherical white glass shade and warm wood arm for ambient lighting.', TRUE, 0
FROM products WHERE sku = 'LGT-WS-006'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'wall-sconce-7.jpg', 'Elegant black outdoor lantern sconce with clear glass panels and weather-resistant design.', TRUE, 0
FROM products WHERE sku = 'LGT-WS-007'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'wall-sconce-8.jpg', 'Sleek modern up-down wall light with matte black finish, LED illumination', TRUE, 0
FROM products WHERE sku = 'LGT-WS-008'
ON CONFLICT DO NOTHING;

-- Decor Images
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'vase-2.jpeg', 'Elegant terracotta floor vase with a smooth, natural finish, ideal for dried arrangements in Bohemian and Mediterranean styles.', TRUE, 0
FROM products WHERE sku = 'DEC-DECOR-VASE-002'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'vase-1.jpeg', 'Elegant ceramic bud vase with textured matte finish, ideal for modern and minimalist decor.', TRUE, 0
FROM products WHERE sku = 'DEC-DECOR-VASE-001'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'vase-3.jpeg', 'Glass Cylinder Vase showcasing floral arrangements, ideal for modern and traditional decor settings.', TRUE, 0
FROM products WHERE sku = 'DEC-DECOR-VASE-003'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'vase-4.jpeg', 'Ribbed ceramic vase in warm beige and soft taupe, ideal for modern decor.', TRUE, 0
FROM products WHERE sku = 'DEC-DECOR-VASE-004'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'candle-1.jpeg', 'Hand-poured soy wax pillar candle with warm vanilla scent in a vintage brass holder.', TRUE, 0
FROM products WHERE sku = 'DEC-DECOR-CANDLE-001'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'vase-5.jpeg', 'Elegant brass metallic vase with a brushed finish and organic shape, perfect for modern decor.', TRUE, 0
FROM products WHERE sku = 'DEC-DECOR-VASE-005'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'candle-2.jpeg', 'Set of three concrete candle holders with a smooth matte finish and modern design.', TRUE, 0
FROM products WHERE sku = 'DEC-DECOR-CANDLE-002'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'candle-3.jpeg', 'Glass Jar Candle in a sleek transparent jar, offering a warm glow and soothing aroma.', TRUE, 0
FROM products WHERE sku = 'DEC-DECOR-CANDLE-003'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'candle-4.jpeg', 'Elegant brass candle stick pair with fluted design, perfect for sophisticated decor.', TRUE, 0
FROM products WHERE sku = 'DEC-DECOR-CANDLE-004'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'object-1.jpeg', 'Elegant marble bookends with natural veining, providing stylish support for books.', TRUE, 0
FROM products WHERE sku = 'DEC-DECOR-OBJECT-001'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'object-2.jpeg', 'Elegant hand-carved wooden sculpture with abstract design, warm chestnut brown color.', TRUE, 0
FROM products WHERE sku = 'DEC-DECOR-OBJECT-002'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'object-4.jpeg', 'Set of four ceramic geometric sculptures with matte black accents.', TRUE, 0
FROM products WHERE sku = 'DEC-DECOR-OBJECT-004'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'object-5.jpeg', 'Brass Chain Link Decor featuring interlocking polished brass links for elegant interior styling.', TRUE, 0
FROM products WHERE sku = 'DEC-DECOR-OBJECT-005'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'object-6.jpeg', 'Three stone spheres of varying sizes with natural textures and shades of gray and beige.', TRUE, 0
FROM products WHERE sku = 'DEC-DECOR-OBJECT-006'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'pillow-1.jpeg', 'Warm beige velvet throw pillow with textured grid pattern and fringe detailing, perfect for modern decor.', TRUE, 0
FROM products WHERE sku = 'DEC-DECOR-PILLOW-001'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'object-3.jpeg', 'Set of ceramic decorative balls in neutral tones with a textured finish.', TRUE, 0
FROM products WHERE sku = 'DEC-DECOR-OBJECT-003'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'pillow-2.jpeg', 'Linen lumbar pillow with frayed edges in warm beige for bohemian decor.', TRUE, 0
FROM products WHERE sku = 'DEC-DECOR-PILLOW-002'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'pillow-3.jpeg', 'Luxurious textured cotton pillow with geometric pattern in ivory and cream tones.', TRUE, 0
FROM products WHERE sku = 'DEC-DECOR-PILLOW-003'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'pillow-4.jpeg', 'Elegant bouclé accent pillow in warm cream with black trim, perfect for modern decor.', TRUE, 0
FROM products WHERE sku = 'DEC-DECOR-PILLOW-004'
ON CONFLICT DO NOTHING;

-- Art & Mirrors Images
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'mirror-1.jpeg', 'Round Sunburst Mirror with dazzling sunburst design and intricate frame, reflecting light to brighten any room.', TRUE, 0
FROM products WHERE sku = 'ART-ART-MIRROR-001'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'mirror-2.jpg', 'Arched floor mirror with a sleek black metal frame, enhancing room decor.', TRUE, 0
FROM products WHERE sku = 'ART-ART-MIRROR-002'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'mirror-3.jpeg', 'Venetian Style Ornate Mirror with organic wooden frame and smooth finish.', TRUE, 0
FROM products WHERE sku = 'ART-ART-MIRROR-003'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'mirror-4.jpeg', 'Elegant organic-shaped mirror with asymmetrical design and warm chestnut wood frame.', TRUE, 0
FROM products WHERE sku = 'ART-ART-MIRROR-004'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'mirror-6.webp', 'Rattan Frame Mirror with intricate woven design, perfect for entryways or living spaces.', TRUE, 0
FROM products WHERE sku = 'ART-ART-MIRROR-006'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'mirror-5.jpg', 'Round mirror with sleek industrial pipe frame in matte black finish, perfect for modern decor.', TRUE, 0
FROM products WHERE sku = 'ART-ART-MIRROR-005'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'mirror-7.webp', 'Hexagon Wall Mirror Set featuring sleek frames and geometric design, perfect for modern home decor.', TRUE, 0
FROM products WHERE sku = 'ART-ART-MIRROR-007'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'mirror-8.webp', 'Minimalist Rectangle Mirror with bold red frame, ideal for modern and contemporary home decor.', TRUE, 0
FROM products WHERE sku = 'ART-ART-MIRROR-008'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'mirror-9.webp', 'Ornate Carved Mirror with elegant floral motifs on a wooden frame, enhancing room decor.', TRUE, 0
FROM products WHERE sku = 'ART-ART-MIRROR-009'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'mirror-10.webp', 'Art Deco Fan Mirror with a gold frame and fan-shaped design.', TRUE, 0
FROM products WHERE sku = 'ART-ART-MIRROR-010'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'art-1.jpeg', 'Large abstract canvas print with deep forest green and neutral tones, gallery-wrapped finish.', TRUE, 0
FROM products WHERE sku = 'ART-ART-WALL-001'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'art-2.jpeg', 'Botanical Print Set featuring elegant black frames and intricate nature illustrations.', TRUE, 0
FROM products WHERE sku = 'ART-ART-WALL-002'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'art-3.jpeg', 'Minimalist Line Art featuring bold black lines on a white background.', TRUE, 0
FROM products WHERE sku = 'ART-ART-WALL-003'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'art-4.jpeg', 'Modern wall sculpture with abstract geometric shapes in terracotta, teal, and beige.', TRUE, 0
FROM products WHERE sku = 'ART-ART-WALL-004'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'art-5.jpeg', 'Abstract geometric photography print in warm ochre, framed in natural oak.', TRUE, 0
FROM products WHERE sku = 'ART-ART-WALL-005'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'art-6.jpg', 'Graffiti-style metal wall art with a whimsical cat on a vivid orange canvas.', TRUE, 0
FROM products WHERE sku = 'ART-ART-WALL-006'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'art-7.jpg', 'Elegant handwoven macramé wall hanging made of natural cotton with intricate knots and tassels.', TRUE, 0
FROM products WHERE sku = 'ART-ART-WALL-007'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'art-8.jpg', 'Set of 5 elegant gallery frames in matte black, perfect for personalized photo displays and art arrangements.', TRUE, 0
FROM products WHERE sku = 'ART-ART-WALL-008'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'art-9.jpg', 'Oversized canvas art with bold abstract design featuring vivid yellow, deep teal, and fiery red colors.', TRUE, 0
FROM products WHERE sku = 'ART-ART-WALL-009'
ON CONFLICT DO NOTHING;

-- Bedding & Textiles Images
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'bedding-1.jpeg', 'Elegant linen duvet set in soft white with cozy, textured look, includes cover and pillowcases.', TRUE, 0
FROM products WHERE sku = 'BED-BEDDING-SET-001'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'bedding-2.jpeg', 'Charcoal gray cotton sateen sheet set with a silky smooth finish and 400-thread count.', TRUE, 0
FROM products WHERE sku = 'BED-BEDDING-SET-002'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'bedding-4.jpeg', 'Deep navy velvet duvet cover with button closure and interior ties, luxurious and elegant bedding.', TRUE, 0
FROM products WHERE sku = 'BED-BEDDING-SET-004'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'bedding-3.jpeg', 'Elegant quilted coverlet set in soothing sage green with matching shams.', TRUE, 0
FROM products WHERE sku = 'BED-BEDDING-SET-003'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'bedding-5.jpeg', 'Organic Cotton Bundle featuring cream duvet cover and sage green throw blanket.', TRUE, 0
FROM products WHERE sku = 'BED-BEDDING-SET-005'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'bedding-6.jpeg', 'Elegant percale sheet set with intricate embroidery in soft white.', TRUE, 0
FROM products WHERE sku = 'BED-BEDDING-SET-006'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'curtain-2.jpeg', 'Emerald green velvet thermal curtains offering insulation and sound-dampening properties.', TRUE, 0
FROM products WHERE sku = 'BED-CURTAIN-002'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'curtain-1.jpeg', 'Elegant sage green linen blackout curtains with a soft drape for complete privacy and style.', TRUE, 0
FROM products WHERE sku = 'BED-CURTAIN-001'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'curtain-3.jpeg', 'Elegant light gray cotton curtains with brushed nickel grommets, perfect for modern spaces.', TRUE, 0
FROM products WHERE sku = 'BED-CURTAIN-003'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'curtain-4.jpeg', 'Elegant sheer voile panels in warm neutral tones, filtering light in a living room.', TRUE, 0
FROM products WHERE sku = 'BED-CURTAIN-004'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'curtain-5.jpeg', 'Elegant jacquard curtains with geometric pattern in gold and cream hues.', TRUE, 0
FROM products WHERE sku = 'BED-CURTAIN-005'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'curtain-6.webp', 'Elegant cream Boho Tassel Curtains with hand-knotted tassels, made from soft cotton.', TRUE, 0
FROM products WHERE sku = 'BED-CURTAIN-006'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'curtain-7.webp', 'Elegant room darkening drapes in soft beige, featuring pleated design for modern interiors.', TRUE, 0
FROM products WHERE sku = 'BED-CURTAIN-007'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'curtain-8.webp', 'Warm beige Stripe Linen Curtains with a textured weave, full-length design for light control.', TRUE, 0
FROM products WHERE sku = 'BED-CURTAIN-008'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'blanket-1.jpeg', 'Luxurious chunky knit throw in soft cream, hand-knitted for warmth and style.', TRUE, 0
FROM products WHERE sku = 'BED-BLANKET-001'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'blanket-2.jpeg', 'Cashmere blend throw with geometric pattern in gray tones and fringed burnt orange edges.', TRUE, 0
FROM products WHERE sku = 'BED-BLANKET-002'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'blanket-3.jpeg', 'Cotton waffle blanket with navy blue, light gray, and cream stripes, perfect for modern decor.', TRUE, 0
FROM products WHERE sku = 'BED-BLANKET-003'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'blanket-4.jpeg', 'Luxurious faux fur throw blanket in soft cream, perfect for cozying up.', TRUE, 0
FROM products WHERE sku = 'BED-BLANKET-004'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'blanket-5.webp', 'Luxurious Herringbone Wool Throw in neutral tones, perfect for draping over furniture.', TRUE, 0
FROM products WHERE sku = 'BED-BLANKET-005'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'blanket-6.webp', 'Luxurious sherpa fleece blanket with reversible design and textured pattern in warm taupe.', TRUE, 0
FROM products WHERE sku = 'BED-BLANKET-006'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'blanket-7.webp', 'Luxurious charcoal gray linen summer throw blanket with textured surface.', TRUE, 0
FROM products WHERE sku = 'BED-BLANKET-007'
ON CONFLICT DO NOTHING;

-- Furniture Images
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'sofa-3.jpg', 'Mid-century tufted sofa in warm terracotta fabric with sleek black legs and plush cushions.', TRUE, 0
FROM products WHERE sku = 'FURN-SOF-003'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'sofa-2.jpg', 'Contemporary leather sofa in olive green with wooden legs and plush seating.', TRUE, 0
FROM products WHERE sku = 'FURN-SOF-002'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'sofa-1.jpg', 'Elegant modern 3-seater sofa in light gray velvet with wooden frame', TRUE, 0
FROM products WHERE sku = 'FURN-SOF-001'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'sofa-6.jpg', 'Industrial Loft Sofa with gray fabric and black metal legs, featuring a sectional design.', TRUE, 0
FROM products WHERE sku = 'FURN-SOF-006'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'sofa-5.jpg', 'Elegant cream minimalist loveseat with integrated wooden side table.', TRUE, 0
FROM products WHERE sku = 'FURN-SOF-005'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'sofa-4.jpg', 'Elegant Scandinavian L-shaped sectional with textured grayish-blue fabric and wooden frame.', TRUE, 0
FROM products WHERE sku = 'FURN-SOF-004'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'sofa-7.jpg', 'Coastal White Slipcovered Sofa with plush cushions and easy-care slipcover.', TRUE, 0
FROM products WHERE sku = 'FURN-SOF-007'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'sofa-9.jpg', 'Organic-shaped modular sleeper sofa in olive green with rattan accents, ideal for modern living spaces.', TRUE, 0
FROM products WHERE sku = 'FURN-SOF-009'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'sofa-8.jpg', 'Chesterfield Tufted Sofa with deep button tufting and rolled arms in a living room.', TRUE, 0
FROM products WHERE sku = 'FURN-SOF-008'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'accent-chair-1.jpg', 'Luxurious tufted velvet accent chair with camel-colored upholstery and tapered wooden legs.', TRUE, 0
FROM products WHERE sku = 'FURN-CHR-001'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'sofa-10.jpg', 'Rustic Farmhouse Sofa with plush cushions and solid wood frame in a country-style living room.', TRUE, 0
FROM products WHERE sku = 'FURN-SOF-010'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'accent-chair-2.jpg', 'Leather Wingback Chair with high back, curved wings, and wooden legs.', TRUE, 0
FROM products WHERE sku = 'FURN-CHR-002'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'accent-chair-3.jpg', 'Elegant olive green modern swivel chair with curved wooden legs, perfect for living room or reading nook.', TRUE, 0
FROM products WHERE sku = 'FURN-CHR-003'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'accent-chair-5.jpg', 'Elegant Scandinavian lounge chair with textured beige fabric and smooth wooden legs.', TRUE, 0
FROM products WHERE sku = 'FURN-CHR-005'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'accent-chair-4.jpg', 'Rattan Accent Chair featuring natural rattan weave and cushioned seat for stylish comfort.', TRUE, 0
FROM products WHERE sku = 'FURN-CHR-004'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'accent-chair-6.jpg', 'Industrial Metal Chair with robust metal construction and sleek design.', TRUE, 0
FROM products WHERE sku = 'FURN-CHR-006'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'accent-chair-7.jpg', 'Elegant velvet barrel chair with terracotta upholstery and wooden frame, featuring angular armrests.', TRUE, 0
FROM products WHERE sku = 'FURN-CHR-007'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'accent-chair-8.jpg', 'Vibrant slipper chair with orange and cream abstract pattern, armless design, tufted back.', TRUE, 0
FROM products WHERE sku = 'FURN-CHR-008'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'accent-chair-9.jpg', 'Egg-shaped club chair with woven rattan frame and plush tufted cushions in neutral tones.', TRUE, 0
FROM products WHERE sku = 'FURN-CHR-009'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'accent-chair-10.jpg', 'Papasan Chair with mustard yellow cushion and solid wood frame, perfect for cozy living spaces.', TRUE, 0
FROM products WHERE sku = 'FURN-CHR-010'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'coffee-table-1.jpg', 'Scandinavian coffee table with walnut finish and minimalist design.', TRUE, 0
FROM products WHERE sku = 'FURN-TBL-001'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'coffee-table-2.jpg', 'Elegant glass top coffee table with a sturdy wooden frame and warm chestnut brown finish.', TRUE, 0
FROM products WHERE sku = 'FURN-TBL-002'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'coffee-table-3.jpg', 'Rustic wooden coffee table with a warm chestnut brown finish and smooth curved design.', TRUE, 0
FROM products WHERE sku = 'FURN-TBL-003'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'coffee-table-4.jpg', 'Marble Top Coffee Table with sleek gold accents and sturdy legs, ideal for modern and classic interiors.', TRUE, 0
FROM products WHERE sku = 'FURN-TBL-004'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'coffee-table-5.jpg', 'Industrial Pipe Coffee Table with solid wood top and pipe framework.', TRUE, 0
FROM products WHERE sku = 'FURN-TBL-005'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'coffee-table-6.jpg', 'Round Nesting Tables Set with a smooth, circular design in warm wood finish.', TRUE, 0
FROM products WHERE sku = 'FURN-TBL-006'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'coffee-table-7.jpg', 'Modern lift top coffee table with sleek charcoal gray metal legs and warm oak finish.', TRUE, 0
FROM products WHERE sku = 'FURN-TBL-007'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'coffee-table-8.jpg', 'Elegant mid-century oval table with warm walnut finish, tapered legs, and smooth surface.', TRUE, 0
FROM products WHERE sku = 'FURN-TBL-008'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'coffee-table-9.jpg', 'Round drum coffee table with white top and natural wood legs, minimalist design.', TRUE, 0
FROM products WHERE sku = 'FURN-TBL-009'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'coffee-table-10.jpg', 'Rustic round storage ottoman table with natural wood finish and open storage design.', TRUE, 0
FROM products WHERE sku = 'FURN-TBL-010'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'tv-stand-1.jpg', 'Modern Floating TV Stand in chestnut brown with ribbed wood texture and ample storage.', TRUE, 0
FROM products WHERE sku = 'FURN-TV-001'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'tv-stand-2.jpg', 'Sleek Industrial TV Console with natural wood finish and open shelving.', TRUE, 0
FROM products WHERE sku = 'FURN-TV-002'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'tv-stand-3.jpg', 'Mid-Century Media Console in walnut wood with open shelves and drawers, tapered legs.', TRUE, 0
FROM products WHERE sku = 'FURN-TV-003'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'tv-stand-5.jpg', 'Elegant Fireplace TV Stand with built-in electric fireplace and storage shelves.', TRUE, 0
FROM products WHERE sku = 'FURN-TV-005'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'tv-stand-7.webp', 'Scandinavian TV bench with natural oak finish and ribbed cabinet doors, perfect for media storage.', TRUE, 0
FROM products WHERE sku = 'FURN-TV-007'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'tv-stand-8.jpg', 'Rustic Barn Door TV Stand with warm oak finish and sliding barn doors for ample storage.', TRUE, 0
FROM products WHERE sku = 'FURN-TV-008'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'tv-stand-9.webp', 'Stylish LED Light TV Stand with modern design, ample storage, and customizable LED lights.', TRUE, 0
FROM products WHERE sku = 'FURN-TV-009'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'tv-stand-4.jpg', 'Corner TV stand with oak finish and rattan accents, featuring ample storage and stylish design.', TRUE, 0
FROM products WHERE sku = 'FURN-TV-004'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'tv-stand-10.webp', 'Stylish open shelf entertainment center with a warm walnut finish and slatted doors.', TRUE, 0
FROM products WHERE sku = 'FURN-TV-010'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'tv-stand-6.jpg', 'Modern Glass Door TV Cabinet with matte white finish and spacious storage compartments.', TRUE, 0
FROM products WHERE sku = 'FURN-TV-006'
ON CONFLICT DO NOTHING;

-- Rugs Images
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'rug-1.jpeg', 'Modern geometric indoor rug with bold green patterns and soft texture, perfect for stylish home decor.', TRUE, 0
FROM products WHERE sku = 'RUG-IND-001'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'rug-2.jpeg', 'Traditional Persian Style Rug with intricate patterns in earthy tones.', TRUE, 0
FROM products WHERE sku = 'RUG-IND-002'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'rug-4.jpeg', 'Minimalist rug with geometric patterns in warm beige and tan, crafted from cotton for modern interiors.', TRUE, 0
FROM products WHERE sku = 'RUG-IND-004'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'rug-3.jpeg', 'Bohemian Moroccan shag rug with geometric patterns in beige and cream.', TRUE, 0
FROM products WHERE sku = 'RUG-IND-003'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'rug-5.jpeg', 'Elegant Abstract Art Deco Indoor Rug in warm chestnut and cream tones, made from soft wool.', TRUE, 0
FROM products WHERE sku = 'RUG-IND-005'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'rug-6.jpeg', 'Vintage Distressed Indoor Rug with earthy tones and a wavy pattern.', TRUE, 0
FROM products WHERE sku = 'RUG-IND-006'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'rug-7.jpeg', 'Plush Velvet Indoor Rug with abstract design in emerald, burgundy, and navy.', TRUE, 0
FROM products WHERE sku = 'RUG-IND-007'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'rug-8.jpeg', 'Striped Indoor/Outdoor Rug with earthy tones and sophisticated pattern', TRUE, 0
FROM products WHERE sku = 'RUG-IO-001'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'rug-9.jpeg', 'Stylish indoor/outdoor rug with modern geometric pattern in sage green and cream.', TRUE, 0
FROM products WHERE sku = 'RUG-IO-002'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'rug-10.jpeg', 'Vibrant green Tropical Palm Indoor/Outdoor Rug with embossed palm leaf design', TRUE, 0
FROM products WHERE sku = 'RUG-IO-003'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'rug-11.jpeg', 'Forest green rug with embossed floral pattern, suitable for indoor and outdoor use.', TRUE, 0
FROM products WHERE sku = 'RUG-IO-004'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'rug-12.jpeg', 'Chevron Indoor/Outdoor Rug with navy and white modern pattern.', TRUE, 0
FROM products WHERE sku = 'RUG-IO-005'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'rug-13.jpeg', 'Solid Indoor/Outdoor Rug featuring a blend of beige, gray, and blue tones in an abstract pattern.', TRUE, 0
FROM products WHERE sku = 'RUG-IO-006'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'rug-14.jpeg', 'Two-Tone Reversible Area Rug with vibrant colors and organic shape, perfect for modern interiors.', TRUE, 0
FROM products WHERE sku = 'RUG-REV-001'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'rug-15.jpeg', 'Elegant reversible flatweave rug with intricate floral patterns in navy, beige, red, and brown.', TRUE, 0
FROM products WHERE sku = 'RUG-REV-002'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'rug-16.jpeg', 'Elegant reversible rug with bold geometric waves in black and beige.', TRUE, 0
FROM products WHERE sku = 'RUG-REV-003'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'rug-18.jpeg', 'Elegant Moroccan-inspired reversible rug with abstract pattern in cream and taupe.', TRUE, 0
FROM products WHERE sku = 'RUG-REV-005'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'rug-17.jpeg', 'Striped reversible cotton rug with geometric pattern in neutral tones.', TRUE, 0
FROM products WHERE sku = 'RUG-REV-004'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'rug-20.jpg', 'Vibrant hand-woven jute area rug featuring intricate floral and geometric patterns in crimson red, cream, and dark navy.', TRUE, 0
FROM products WHERE sku = 'RUG-NAT-001'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'rug-19.jpg', 'Solid Color Reversible Rug featuring a minimalist design and sophisticated palette.', TRUE, 0
FROM products WHERE sku = 'RUG-REV-006'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'rug-21.jpg', 'Sisal Herringbone Rug with natural texture and herringbone pattern for modern and traditional decor.', TRUE, 0
FROM products WHERE sku = 'RUG-NAT-002'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'rug-22.jpg', 'Seagrass Round Rug with natural fibers and textured surface for a coastal style.', TRUE, 0
FROM products WHERE sku = 'RUG-NAT-003'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'rug-23.jpg', 'Braided Jute Runner with geometric patterns in warm tones, ideal for entryways.', TRUE, 0
FROM products WHERE sku = 'RUG-NAT-004'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'rug-24.jpg', 'Chunky Wool Natural Rug with thick weave in creamy whites and soft beiges.', TRUE, 0
FROM products WHERE sku = 'RUG-NAT-005'
ON CONFLICT DO NOTHING;
INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, 'rug-25.jpg', 'Mixed Fiber Natural Rug with vibrant geometric patterns and fringe edges.', TRUE, 0
FROM products WHERE sku = 'RUG-NAT-006'
ON CONFLICT DO NOTHING;

-- ============================================================================
-- SEED DATA SUMMARY
-- ============================================================================
-- Total Products: 158
-- Total Images: 158
-- Categories: 6
--
-- Product Counts by Category:
--   Lighting: 34
--   Decor: 19
--   Art & Mirrors: 19
--   Bedding & Textiles: 21
--   Furniture: 40
--   Rugs: 25
--
-- Generated: 2026-01-29T22:22:42.845Z
-- ============================================================================

