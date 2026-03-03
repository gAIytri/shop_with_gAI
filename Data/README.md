# GaiEcom Database

PostgreSQL database schema for the GaiEcom e-commerce platform. Designed for deployment on Azure Database for PostgreSQL (Flexible Server).

## Quick Start

### 1. Prerequisites

- PostgreSQL 14+ installed (or Azure Database for PostgreSQL)
- `psql` command-line tool

### 2. Create Database

```bash
# Local development
createdb gaiecom

# Azure PostgreSQL - use Azure Portal or CLI
az postgres flexible-server db create \
  --resource-group <rg-name> \
  --server-name <server-name> \
  --database-name gaiecom
```

### 3. Run Schema

```bash
psql -d gaiecom -f schema/001_initial_schema.sql
```

### 4. Load Seed Data

```bash
# Load all categories, product types, and 158 products
psql -d gaiecom -f seeds/002_products.sql
```

### 5. Regenerate Seed Data (optional)

If you modify the JSON product files and need to regenerate the seed SQL:

```bash
cd database
node scripts/generate-seed-sql.js > seeds/002_products.sql
```

## Directory Structure

```
database/
├── schema/
│   └── 001_initial_schema.sql    # Main schema (21 tables)
├── seeds/
│   └── 002_products.sql          # All data: 6 categories, 30 product types, 158 products
├── scripts/
│   └── generate-seed-sql.js      # Regenerate seeds from JSON
├── migrations/
│   └── migrate_json_to_postgres.ts    # TypeScript migrator (alternative)
├── archive/
│   └── nlu/                           # Archived NLU components (for future use)
├── docs/
│   └── SCHEMA.md                      # Full documentation
└── README.md
```

## Key Tables

| Module | Tables |
|--------|--------|
| Users | `users`, `addresses`, `user_auth_providers` |
| Products | `products`, `categories`, `product_types`, `product_images`, `product_variants`, `product_relations` |
| Cart | `carts`, `cart_items`, `wishlists`, `wishlist_items` |
| Orders | `orders`, `order_items`, `payments`, `refunds` |
| Reviews | `reviews`, `review_images` |
| Promotions | `promotions`, `coupons`, `coupon_usages` |
| Navigation | `navigation_menus`, `pages` |

**Total Tables:** 21

## Archived Components

NLU (Natural Language Understanding) components have been archived for future integration. When ready to add conversational AI features, see the `archive/nlu/` folder which contains:

- `nlu_schema.sql` - Tables for intents, entities, conversations, search logs
- `nlu_seed_data.sql` - Training data for 15 intents and 8 entity types
- `NLU_DOCUMENTATION.md` - Integration guide

## Useful Commands

```bash
# Connect to database
psql -d gaiecom

# List tables
\dt

# Describe a table
\d products

# Search products (example)
SELECT * FROM v_product_search
WHERE category_slug = 'lighting'
AND styles @> '"Modern"'
LIMIT 10;

# Get products with category info
SELECT * FROM v_products_with_category LIMIT 10;

# Order summary
SELECT * FROM v_order_summary WHERE user_id = '<uuid>';
```

## Environment Variables

```bash
# Local development
DATABASE_URL=postgres://user:pass@localhost:5432/gaiecom

# Azure PostgreSQL
DATABASE_URL=postgres://user:pass@<server>.postgres.database.azure.com:5432/gaiecom?sslmode=require
```

## Azure PostgreSQL Setup

For Azure deployment:

1. Create Azure Database for PostgreSQL Flexible Server
2. Configure networking (private endpoint or firewall rules)
3. Store connection string in Azure Key Vault
4. Enable required extensions: `uuid-ossp`, `pgcrypto`, `pg_trgm`

See the main project documentation for detailed Azure setup instructions.

## Documentation

| Document | Description |
|----------|-------------|
| [docs/SCHEMA.md](docs/SCHEMA.md) | Database schema documentation, ERD, common queries |
| [docs/azure/PRICING_ANALYSIS.md](docs/azure/PRICING_ANALYSIS.md) | Azure PostgreSQL pricing tiers, cost analysis, recommendations |
| [docs/azure/AZURE_CLI_REFERENCE.md](docs/azure/AZURE_CLI_REFERENCE.md) | Complete Azure CLI commands reference with examples |

### Quick Links

- **Schema ERD & Tables:** [SCHEMA.md](docs/SCHEMA.md)
- **Azure Pricing & Config:** [PRICING_ANALYSIS.md](docs/azure/PRICING_ANALYSIS.md)
- **Azure CLI Commands:** [AZURE_CLI_REFERENCE.md](docs/azure/AZURE_CLI_REFERENCE.md)
- **Archived NLU Components:** [archive/nlu/](archive/nlu/)
