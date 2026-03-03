/**
 * Generate PostgreSQL seed SQL from JSON product data
 *
 * Usage: node generate-seed-sql.js > ../seeds/002_products.sql
 */

const fs = require('fs');
const path = require('path');

const DATA_DIR = path.join(__dirname, '../../gai-ecom/src/data');

// Category definitions with their product type mappings
const CATEGORIES = {
  lighting: {
    name: 'Lighting',
    slug: 'lighting',
    description: 'Illuminate your space with our curated lighting collection',
    synonyms: ['lights', 'lamps', 'fixtures', 'illumination'],
    productTypes: {
      'ceiling-light': { name: 'Ceiling Light', synonyms: ['ceiling fixture', 'overhead light', 'ceiling lamp', 'flush mount'] },
      'floor-lamp': { name: 'Floor Lamp', synonyms: ['standing lamp', 'floor light', 'tall lamp'] },
      'table-lamp': { name: 'Table Lamp', synonyms: ['desk lamp', 'bedside lamp', 'accent lamp'] },
      'wall-sconce': { name: 'Wall Sconce', synonyms: ['wall light', 'sconce', 'wall fixture'] },
      'pendant': { name: 'Pendant Light', synonyms: ['pendant lamp', 'hanging light', 'drop light'] }
    }
  },
  decor: {
    name: 'Decor',
    slug: 'decor',
    description: 'Decorative accents to personalize your home',
    synonyms: ['decorations', 'accessories', 'accents', 'home decor'],
    productTypes: {
      'vase': { name: 'Vase', synonyms: ['flower vase', 'decorative vase', 'planter'] },
      'candle': { name: 'Candle', synonyms: ['candles', 'candle holder', 'tealight'] },
      'tray': { name: 'Decorative Tray', synonyms: ['serving tray', 'accent tray'] },
      'decorative-object': { name: 'Decorative Object', synonyms: ['sculpture', 'figurine', 'accent piece'] }
    }
  },
  art: {
    name: 'Art & Mirrors',
    slug: 'art',
    description: 'Wall art and mirrors to transform any room',
    synonyms: ['artwork', 'wall art', 'mirrors', 'paintings', 'prints'],
    productTypes: {
      'wall-art': { name: 'Wall Art', synonyms: ['wall decor', 'art print', 'poster'] },
      'canvas': { name: 'Canvas Art', synonyms: ['canvas print', 'canvas painting'] },
      'mirror': { name: 'Mirror', synonyms: ['wall mirror', 'decorative mirror', 'accent mirror'] },
      'framed-print': { name: 'Framed Print', synonyms: ['framed art', 'framed picture'] }
    }
  },
  bedding: {
    name: 'Bedding & Textiles',
    slug: 'bedding',
    description: 'Luxurious bedding and curtains for ultimate comfort',
    synonyms: ['bed linens', 'sheets', 'comforters', 'textiles'],
    productTypes: {
      'duvet': { name: 'Duvet Cover', synonyms: ['duvet', 'comforter cover', 'duvet set'] },
      'bedding-set': { name: 'Bedding Set', synonyms: ['bed set', 'sheet set', 'linen set'] },
      'sheets': { name: 'Sheet Set', synonyms: ['bed sheets', 'fitted sheet', 'flat sheet'] },
      'quilt': { name: 'Quilt', synonyms: ['quilts', 'coverlet', 'bedspread'] },
      'curtain': { name: 'Curtain', synonyms: ['curtains', 'drapes', 'window panel'] },
      'throw': { name: 'Throw Blanket', synonyms: ['blanket', 'throw', 'afghan'] },
      'pillow': { name: 'Pillow', synonyms: ['pillows', 'cushion', 'decorative pillow'] }
    }
  },
  furniture: {
    name: 'Furniture',
    slug: 'furniture',
    description: 'Stylish furniture for every room',
    synonyms: ['furnishings', 'seating', 'tables'],
    productTypes: {
      'sofa': { name: 'Sofa', synonyms: ['couch', 'settee', 'loveseat', 'sectional'] },
      'accent-chair': { name: 'Accent Chair', synonyms: ['armchair', 'lounge chair', 'side chair'] },
      'coffee-table': { name: 'Coffee Table', synonyms: ['cocktail table', 'center table'] },
      'tv-stand': { name: 'TV Stand', synonyms: ['media console', 'entertainment center'] },
      'nightstand': { name: 'Nightstand', synonyms: ['bedside table', 'night table'] },
      'bookcase': { name: 'Bookcase', synonyms: ['bookshelf', 'shelving unit'] }
    }
  },
  rugs: {
    name: 'Rugs',
    slug: 'rugs',
    description: 'Beautiful rugs to anchor your space',
    synonyms: ['carpets', 'floor coverings', 'area rugs', 'mats'],
    productTypes: {
      'indoor-rug': { name: 'Indoor Rug', synonyms: ['area rug', 'living room rug'] },
      'indoor-outdoor-rug': { name: 'Indoor/Outdoor Rug', synonyms: ['outdoor rug', 'patio rug'] },
      'natural-fiber-rug': { name: 'Natural Fiber Rug', synonyms: ['jute rug', 'sisal rug'] },
      'reversible-rug': { name: 'Reversible Rug', synonyms: ['double-sided rug'] }
    }
  }
};

function escapeString(str) {
  if (!str) return 'NULL';
  return `'${str.replace(/'/g, "''")}'`;
}

function escapeJson(obj) {
  if (!obj || (typeof obj === 'object' && Object.keys(obj).length === 0)) {
    return "'{}'";
  }
  if (Array.isArray(obj) && obj.length === 0) {
    return "'[]'";
  }
  return `'${JSON.stringify(obj).replace(/'/g, "''")}'`;
}

function generateCategoriesSQL() {
  let sql = `-- ============================================================================
-- GaiEcom Seed Data: Categories & Product Types
-- Generated from JSON data files
-- ============================================================================

-- Clear existing data (careful in production!)
-- TRUNCATE categories, product_types CASCADE;

-- ============================================================================
-- CATEGORIES
-- ============================================================================

`;

  for (const [slug, cat] of Object.entries(CATEGORIES)) {
    sql += `INSERT INTO categories (name, slug, description, synonyms, display_order, is_active)
VALUES (
    ${escapeString(cat.name)},
    ${escapeString(slug)},
    ${escapeString(cat.description)},
    ${escapeJson(cat.synonyms)},
    ${Object.keys(CATEGORIES).indexOf(slug) + 1},
    TRUE
) ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    synonyms = EXCLUDED.synonyms;\n\n`;
  }

  sql += `-- ============================================================================
-- PRODUCT TYPES (Subcategories)
-- ============================================================================

`;

  for (const [catSlug, cat] of Object.entries(CATEGORIES)) {
    for (const [typeSlug, type] of Object.entries(cat.productTypes)) {
      sql += `INSERT INTO product_types (category_id, name, slug, synonyms)
SELECT id, ${escapeString(type.name)}, ${escapeString(typeSlug)}, ${escapeJson(type.synonyms)}
FROM categories WHERE slug = ${escapeString(catSlug)}
ON CONFLICT (category_id, slug) DO UPDATE SET
    name = EXCLUDED.name,
    synonyms = EXCLUDED.synonyms;\n\n`;
    }
  }

  return sql;
}

function generateProductSQL(product, categorySlug) {
  // Generate SKU if missing
  const sku = product.sku || `${categorySlug.toUpperCase().slice(0, 3)}-${product.id}`.toUpperCase();

  // Determine product type slug from taxonomy
  let productTypeSlug = null;
  if (product.taxonomy?.subcategory?.slug) {
    productTypeSlug = product.taxonomy.subcategory.slug;
  }

  // Determine stock status
  let stockStatus = 'in_stock';
  const stockQty = product.metadata?.stockQuantity ?? 10;
  if (product.metadata?.inStock === false || stockQty === 0) {
    stockStatus = 'out_of_stock';
  } else if (stockQty < 5) {
    stockStatus = 'low_stock';
  }

  // Build attributes JSON
  const attributes = product.attributes || {};

  // Build visual attributes JSON
  const visualAttributes = product.visualAttributes || {};

  // Build enriched description JSON
  const enrichedDescription = product.enrichedDescription || {};

  // Build tags array
  const tags = product.tags || [];

  // Build SEO JSON
  const seo = product.seo || {};

  return `-- Product: ${product.name}
INSERT INTO products (
    sku, name, description, price, compare_at_price, currency,
    category_id, product_type_id,
    stock_quantity, stock_status,
    attributes, visual_attributes, enriched_description, tags, seo,
    is_featured, is_bestseller, avg_rating, review_count,
    is_active, published_at, created_at
)
SELECT
    ${escapeString(sku)},
    ${escapeString(product.name)},
    ${escapeString(product.description)},
    ${product.price || 0},
    ${product.compareAtPrice || 'NULL'},
    ${escapeString(product.currency || 'USD')},
    c.id,
    ${productTypeSlug ? `(SELECT id FROM product_types WHERE slug = ${escapeString(productTypeSlug)} AND category_id = c.id)` : 'NULL'},
    ${stockQty},
    '${stockStatus}'::stock_status,
    ${escapeJson(attributes)},
    ${escapeJson(visualAttributes)},
    ${escapeJson(enrichedDescription)},
    ${escapeJson(tags)},
    ${escapeJson(seo)},
    ${product.metadata?.featured ? 'TRUE' : 'FALSE'},
    ${product.metadata?.bestSeller ? 'TRUE' : 'FALSE'},
    ${product.metadata?.rating || 0},
    ${product.metadata?.reviewCount || 0},
    TRUE,
    ${product.metadata?.createdAt ? escapeString(product.metadata.createdAt) : 'NOW()'},
    ${product.metadata?.createdAt ? escapeString(product.metadata.createdAt) : 'NOW()'}
FROM categories c
WHERE c.slug = ${escapeString(categorySlug)}
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

`;
}

function generateProductImagesSQL(product) {
  const sku = product.sku || `${product.taxonomy?.category?.slug?.toUpperCase().slice(0, 3) || 'PRD'}-${product.id}`.toUpperCase();
  const images = product.images || [];
  const primaryImage = product.primaryImage;

  if (images.length === 0) return '';

  let sql = '';
  images.forEach((img, idx) => {
    const isPrimary = img === primaryImage;
    const altText = product.seo?.altText || `${product.name} image ${idx + 1}`;

    sql += `INSERT INTO product_images (product_id, url, alt_text, is_primary, display_order)
SELECT id, ${escapeString(img)}, ${escapeString(altText)}, ${isPrimary ? 'TRUE' : 'FALSE'}, ${idx}
FROM products WHERE sku = ${escapeString(sku)}
ON CONFLICT DO NOTHING;
`;
  });

  return sql;
}

function main() {
  const categoryFiles = {
    lighting: 'lighting.json',
    decor: 'decor.json',
    art: 'art.json',
    bedding: 'bedding.json',
    furniture: 'furniture.json',
    rugs: 'rugs.json'
  };

  // Generate categories SQL
  let sql = generateCategoriesSQL();

  // Track product counts
  const productCounts = {};
  let totalProducts = 0;
  let totalImages = 0;

  sql += `-- ============================================================================
-- PRODUCTS
-- ============================================================================

`;

  // Process each category
  for (const [categorySlug, filename] of Object.entries(categoryFiles)) {
    const filePath = path.join(DATA_DIR, filename);

    if (!fs.existsSync(filePath)) {
      console.error(`Warning: ${filename} not found`);
      continue;
    }

    const products = JSON.parse(fs.readFileSync(filePath, 'utf-8'));
    productCounts[categorySlug] = products.length;
    totalProducts += products.length;

    sql += `-- ----------------------------------------------------------------------------
-- ${CATEGORIES[categorySlug].name} (${products.length} products)
-- ----------------------------------------------------------------------------

`;

    for (const product of products) {
      sql += generateProductSQL(product, categorySlug);
      totalImages += (product.images || []).length;
    }
  }

  // Generate product images
  sql += `-- ============================================================================
-- PRODUCT IMAGES
-- ============================================================================

`;

  for (const [categorySlug, filename] of Object.entries(categoryFiles)) {
    const filePath = path.join(DATA_DIR, filename);

    if (!fs.existsSync(filePath)) continue;

    const products = JSON.parse(fs.readFileSync(filePath, 'utf-8'));

    sql += `-- ${CATEGORIES[categorySlug].name} Images
`;

    for (const product of products) {
      sql += generateProductImagesSQL(product);
    }
    sql += '\n';
  }

  // Add summary comment
  sql += `-- ============================================================================
-- SEED DATA SUMMARY
-- ============================================================================
-- Total Products: ${totalProducts}
-- Total Images: ${totalImages}
-- Categories: ${Object.keys(categoryFiles).length}
--
-- Product Counts by Category:
`;

  for (const [cat, count] of Object.entries(productCounts)) {
    sql += `--   ${CATEGORIES[cat].name}: ${count}\n`;
  }

  sql += `--
-- Generated: ${new Date().toISOString()}
-- ============================================================================
`;

  console.log(sql);
}

main();
