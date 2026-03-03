# GaiEcom - Azure CLI Commands

## Create PostgreSQL Flexible Server

```bash
az postgres flexible-server create \
  --resource-group rg-gaiecom-dev \
  --name ecomdb \
  --location westus \
  --admin-user azEcomadmin \
  --admin-password "$DB_ADMIN_PASSWORD" \
  --sku-name Standard_B2s \
  --tier Burstable \
  --storage-size 32 \
  --version 16 \
  --high-availability Disabled \
  --backup-retention 7 \
  --geo-redundant-backup Disabled \
  --public-access 0.0.0.0 \
  --tags project=gaiecom environment=dev
```

## Enable Extensions

```bash
az postgres flexible-server parameter set \
  --resource-group rg-gaiecom-dev \
  --server-name ecomdb \
  --name azure.extensions \
  --value "UUID-OSSP,PGCRYPTO,PG_TRGM"
```

| Parameter | Value | Meaning |
|-----------|-------|---------|
| `--server-name` | ecomdb | Target server |
| `--name` | azure.extensions | Parameter to modify |
| `--value` | UUID-OSSP,PGCRYPTO,PG_TRGM | Extensions to allow |

## Create Database

```bash
az postgres flexible-server db create \
  --resource-group rg-gaiecom-dev \
  --server-name ecomdb \
  --database-name gaiecom
```

| Parameter | Value | Meaning |
|-----------|-------|---------|
| `--server-name` | ecomdb | Target server |
| `--database-name` | gaiecom | Name of database to create |

