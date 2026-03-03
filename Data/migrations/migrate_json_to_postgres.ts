/**
 * GaiEcom Data Migration Script
 * Migrates existing JSON product data to PostgreSQL
 *
 * Usage:
 *   npx ts-node migrations/migrate_json_to_postgres.ts
 */

import { Pool } from 'pg';
import * as fs from 'fs';
import * as path from 'path';

// Configuration
const config = {
  connectionString: process.env.DATABASE_URL || 'postgres://localhost:5432/gaiecom',
  jsonDataPath: path.join(__dirname, '../../gai-ecom/src/data'),
};

// Category mapping
const categoryFiles: Record<string, string> = {
  lighting: 'lighting.json',
  decor: 'decor.json',
  art: 'art.json',
  bedding: 'bedding.json',
  furniture: 'furniture.json',
  rugs: 'rugs.json',
};

interface JsonProduct {
  id: string;
  sku: string;
  name: string;
  description: string;
  price: number;
  currency?: string;
  images: string[];
  primaryImage: string;
  taxonomy: {
    category: { name: string; slug: string };
    subcategory: { name: string; slug: string };
    productType: string;
  };
  attributes: Record<string, unknown>;
  tags: string[];
  metadata: {
    featured?: boolean;
    bestSeller?: boolean;
    onSale?: boolean;
    inStock?: boolean;
    stockQuantity?: number;
    rating?: number;
    reviewCount?: number;
    createdAt?: string;
  };
  enrichedDescription?: {
    short?: string;
    long?: string;
    features?: string[];
    careInstructions?: string;
    materialComposition?: string;
  };
  visualAttributes?: Record<string, unknown>;
  seo?: Record<string, unknown>;
}

async function main() {
  const pool = new Pool({ connectionString: config.connectionString });

  try {
    console.log('Starting migration...\n');

    // 1. Get category IDs
    const categoryResult = await pool.query('SELECT id, slug FROM categories');
    const categoryMap = new Map(categoryResult.rows.map((r) => [r.slug, r.id]));

    // 2. Get product type IDs
    const productTypeResult = await pool.query(
      'SELECT id, slug, category_id FROM product_types'
    );
    const productTypeMap = new Map(
      productTypeResult.rows.map((r) => [`${r.category_id}:${r.slug}`, r.id])
    );

    let totalProducts = 0;
    let totalImages = 0;

    // 3. Process each category file
    for (const [categorySlug, filename] of Object.entries(categoryFiles)) {
      const filePath = path.join(config.jsonDataPath, filename);

      if (!fs.existsSync(filePath)) {
        console.log(`Skipping ${filename} - file not found`);
        continue;
      }

      const jsonData = JSON.parse(fs.readFileSync(filePath, 'utf-8')) as JsonProduct[];
      console.log(`Processing ${filename}: ${jsonData.length} products`);

      const categoryId = categoryMap.get(categorySlug);
      if (!categoryId) {
        console.log(`  Warning: Category '${categorySlug}' not found in database`);
        continue;
      }

      for (const product of jsonData) {
        try {
          // Find product type ID
          const productTypeSlug = product.taxonomy?.subcategory?.slug;
          const productTypeId = productTypeSlug
            ? productTypeMap.get(`${categoryId}:${productTypeSlug}`)
            : null;

          // Determine stock status
          let stockStatus = 'in_stock';
          if (!product.metadata?.inStock) {
            stockStatus = 'out_of_stock';
          } else if ((product.metadata?.stockQuantity || 0) < 5) {
            stockStatus = 'low_stock';
          }

          // Insert product
          const insertResult = await pool.query(
            `
            INSERT INTO products (
              sku, name, description, price, currency,
              category_id, product_type_id,
              stock_quantity, stock_status,
              attributes, visual_attributes, enriched_description, tags, seo,
              is_featured, is_bestseller, avg_rating, review_count,
              created_at
            ) VALUES (
              $1, $2, $3, $4, $5,
              $6, $7,
              $8, $9::stock_status,
              $10, $11, $12, $13, $14,
              $15, $16, $17, $18,
              $19
            )
            ON CONFLICT (sku) DO UPDATE SET
              name = EXCLUDED.name,
              description = EXCLUDED.description,
              price = EXCLUDED.price,
              attributes = EXCLUDED.attributes,
              visual_attributes = EXCLUDED.visual_attributes,
              enriched_description = EXCLUDED.enriched_description,
              tags = EXCLUDED.tags,
              seo = EXCLUDED.seo,
              updated_at = NOW()
            RETURNING id
            `,
            [
              product.sku,
              product.name,
              product.description,
              product.price,
              product.currency || 'USD',
              categoryId,
              productTypeId,
              product.metadata?.stockQuantity || 0,
              stockStatus,
              JSON.stringify(product.attributes || {}),
              JSON.stringify(product.visualAttributes || {}),
              JSON.stringify(product.enrichedDescription || {}),
              JSON.stringify(product.tags || []),
              JSON.stringify(product.seo || {}),
              product.metadata?.featured || false,
              product.metadata?.bestSeller || false,
              product.metadata?.rating || 0,
              product.metadata?.reviewCount || 0,
              product.metadata?.createdAt || new Date().toISOString(),
            ]
          );

          const productId = insertResult.rows[0].id;
          totalProducts++;

          // Insert images
          if (product.images && product.images.length > 0) {
            for (let i = 0; i < product.images.length; i++) {
              const imageName = product.images[i];
              const isPrimary = imageName === product.primaryImage;

              await pool.query(
                `
                INSERT INTO product_images (product_id, url, is_primary, display_order)
                VALUES ($1, $2, $3, $4)
                ON CONFLICT DO NOTHING
                `,
                [productId, imageName, isPrimary, i]
              );
              totalImages++;
            }
          }
        } catch (err) {
          console.error(`  Error processing product ${product.sku}:`, err);
        }
      }

      console.log(`  Completed ${filename}`);
    }

    console.log(`\n✓ Migration complete!`);
    console.log(`  Products: ${totalProducts}`);
    console.log(`  Images: ${totalImages}`);
  } catch (error) {
    console.error('Migration failed:', error);
    process.exit(1);
  } finally {
    await pool.end();
  }
}

main();
