# Azure CLI Reference Guide - PostgreSQL Flexible Server

**Created:** 2026-01-29
**Project:** GaiEcom E-commerce Platform
**Purpose:** Comprehensive Azure CLI commands for PostgreSQL Flexible Server management

---

## Table of Contents

1. [Prerequisites & Setup](#prerequisites--setup)
2. [Resource Group Management](#resource-group-management)
3. [PostgreSQL Server Management](#postgresql-server-management)
4. [Database Management](#database-management)
5. [Firewall & Networking](#firewall--networking)
6. [Server Parameters & Extensions](#server-parameters--extensions)
7. [Backup & Restore](#backup--restore)
8. [Monitoring & Diagnostics](#monitoring--diagnostics)
9. [Cost Management](#cost-management)
10. [Complete Setup Script](#complete-setup-script)
11. [Portal Equivalent Steps](#portal-equivalent-steps)

---

## Prerequisites & Setup

### Install Azure CLI

```bash
# macOS (using Homebrew)
brew update && brew install azure-cli

# Windows (using winget)
winget install -e --id Microsoft.AzureCLI

# Linux (Debian/Ubuntu)
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Verify installation
az --version
```

### Login & Subscription

```bash
# Login to Azure (opens browser)
az login

# Login with device code (for remote/headless)
az login --use-device-code

# List available subscriptions
az account list --output table

# Set active subscription
az account set --subscription "<subscription-name-or-id>"

# Verify current subscription
az account show --output table
```

### Set Default Values (Optional)

```bash
# Set default resource group (avoids --resource-group in every command)
az configure --defaults group=rg-gaiecom-dev

# Set default location
az configure --defaults location=eastus

# View current defaults
az configure --list-defaults
```

---

## Resource Group Management

### Create Resource Group

```bash
# Purpose: Container for all Azure resources
# When: First step before creating any resources

az group create \
  --name rg-gaiecom-dev \
  --location eastus \
  --tags project=gaiecom environment=dev

# Example output:
# {
#   "id": "/subscriptions/.../resourceGroups/rg-gaiecom-dev",
#   "location": "eastus",
#   "name": "rg-gaiecom-dev"
# }
```

### List Resource Groups

```bash
# List all resource groups
az group list --output table

# List with specific tag
az group list --tag project=gaiecom --output table
```

### Delete Resource Group

```bash
# WARNING: Deletes ALL resources in the group
# Purpose: Clean up all resources at once

az group delete \
  --name rg-gaiecom-dev \
  --yes \
  --no-wait
```

---

## PostgreSQL Server Management

### Create Flexible Server

```bash
# Purpose: Create the PostgreSQL Flexible Server instance
# When: Initial setup of database infrastructure

# Development configuration (Burstable B2s)
az postgres flexible-server create \
  --resource-group rg-gaiecom-dev \
  --name gaiecom-db-dev \
  --location eastus \
  --admin-user gaiecom_admin \
  --admin-password '<YourSecurePassword123!>' \
  --sku-name Standard_B2s \
  --tier Burstable \
  --storage-size 32 \
  --version 16 \
  --high-availability Disabled \
  --backup-retention 7 \
  --geo-redundant-backup Disabled \
  --public-access 0.0.0.0 \
  --tags project=gaiecom environment=dev

# Parameters explained:
# --sku-name: Compute size (Standard_B2s = 2 vCores, 4GB RAM)
# --tier: Burstable, GeneralPurpose, or MemoryOptimized
# --storage-size: In GiB (32-32767 for Premium SSD)
# --version: PostgreSQL version (14, 15, 16)
# --public-access: 0.0.0.0 enables public, None for private only
```

### Create with Private Access (Production)

```bash
# Purpose: Create server with private endpoint (more secure)
# When: Production deployments

az postgres flexible-server create \
  --resource-group rg-gaiecom-prod \
  --name gaiecom-db-prod \
  --location eastus \
  --admin-user gaiecom_admin \
  --admin-password '<YourSecurePassword123!>' \
  --sku-name Standard_D2ds_v5 \
  --tier GeneralPurpose \
  --storage-size 128 \
  --version 16 \
  --high-availability ZoneRedundant \
  --backup-retention 14 \
  --geo-redundant-backup Enabled \
  --vnet my-vnet \
  --subnet my-subnet \
  --private-dns-zone my-dns-zone \
  --tags project=gaiecom environment=prod
```

### List Servers

```bash
# List all flexible servers in subscription
az postgres flexible-server list --output table

# List servers in specific resource group
az postgres flexible-server list \
  --resource-group rg-gaiecom-dev \
  --output table
```

### Show Server Details

```bash
# Purpose: View server configuration and status
# When: Verify settings, check status

az postgres flexible-server show \
  --resource-group rg-gaiecom-dev \
  --name gaiecom-db-dev \
  --output table

# Detailed JSON output
az postgres flexible-server show \
  --resource-group rg-gaiecom-dev \
  --name gaiecom-db-dev
```

### Update Server (Scale Up/Down)

```bash
# Purpose: Change compute tier or SKU
# When: Need more/less resources

# Scale up to B4ms
az postgres flexible-server update \
  --resource-group rg-gaiecom-dev \
  --name gaiecom-db-dev \
  --sku-name Standard_B4ms \
  --tier Burstable

# Scale to General Purpose
az postgres flexible-server update \
  --resource-group rg-gaiecom-dev \
  --name gaiecom-db-dev \
  --sku-name Standard_D2ds_v5 \
  --tier GeneralPurpose

# Increase storage (can only increase, not decrease)
az postgres flexible-server update \
  --resource-group rg-gaiecom-dev \
  --name gaiecom-db-dev \
  --storage-size 64
```

### Stop Server (Save Costs)

```bash
# Purpose: Stop compute to save money (storage still billed)
# When: Development/test environments not in use

az postgres flexible-server stop \
  --resource-group rg-gaiecom-dev \
  --name gaiecom-db-dev

# Note: Server auto-starts after 7 days if not manually started
```

### Start Server

```bash
# Purpose: Resume a stopped server
# When: Ready to use the database again

az postgres flexible-server start \
  --resource-group rg-gaiecom-dev \
  --name gaiecom-db-dev
```

### Restart Server

```bash
# Purpose: Restart server (applies some parameter changes)
# When: After changing certain server parameters

az postgres flexible-server restart \
  --resource-group rg-gaiecom-dev \
  --name gaiecom-db-dev
```

### Delete Server

```bash
# WARNING: Permanently deletes server and all databases
# Purpose: Remove server completely

az postgres flexible-server delete \
  --resource-group rg-gaiecom-dev \
  --name gaiecom-db-dev \
  --yes
```

---

## Database Management

### Create Database

```bash
# Purpose: Create a new database on the server
# When: Setting up application database

az postgres flexible-server db create \
  --resource-group rg-gaiecom-dev \
  --server-name gaiecom-db-dev \
  --database-name gaiecom

# With specific charset and collation
az postgres flexible-server db create \
  --resource-group rg-gaiecom-dev \
  --server-name gaiecom-db-dev \
  --database-name gaiecom \
  --charset UTF8 \
  --collation en_US.utf8
```

### List Databases

```bash
# Purpose: View all databases on server
az postgres flexible-server db list \
  --resource-group rg-gaiecom-dev \
  --server-name gaiecom-db-dev \
  --output table
```

### Delete Database

```bash
# WARNING: Permanently deletes database and all data
az postgres flexible-server db delete \
  --resource-group rg-gaiecom-dev \
  --server-name gaiecom-db-dev \
  --database-name gaiecom \
  --yes
```

### Connect to Database

```bash
# Purpose: Interactive psql session
# When: Manual database administration

az postgres flexible-server connect \
  --resource-group rg-gaiecom-dev \
  --server-name gaiecom-db-dev \
  --database-name gaiecom \
  --admin-user gaiecom_admin \
  --interactive

# Or use standard psql with connection string
psql "host=gaiecom-db-dev.postgres.database.azure.com \
      port=5432 \
      dbname=gaiecom \
      user=gaiecom_admin \
      sslmode=require"
```

### Execute SQL Query

```bash
# Purpose: Run SQL without interactive session
# When: Scripted operations

az postgres flexible-server execute \
  --resource-group rg-gaiecom-dev \
  --server-name gaiecom-db-dev \
  --database-name gaiecom \
  --admin-user gaiecom_admin \
  --admin-password '<password>' \
  --querytext "SELECT version();"
```

---

## Firewall & Networking

### Add Firewall Rule (Single IP)

```bash
# Purpose: Allow specific IP to connect
# When: Adding developer access

az postgres flexible-server firewall-rule create \
  --resource-group rg-gaiecom-dev \
  --name gaiecom-db-dev \
  --rule-name allow-my-ip \
  --start-ip-address 203.0.113.50 \
  --end-ip-address 203.0.113.50
```

### Add Firewall Rule (IP Range)

```bash
# Purpose: Allow range of IPs (e.g., office network)
az postgres flexible-server firewall-rule create \
  --resource-group rg-gaiecom-dev \
  --name gaiecom-db-dev \
  --rule-name allow-office \
  --start-ip-address 203.0.113.0 \
  --end-ip-address 203.0.113.255
```

### Allow Azure Services

```bash
# Purpose: Allow all Azure services to connect
# When: App Services, Functions need access

az postgres flexible-server firewall-rule create \
  --resource-group rg-gaiecom-dev \
  --name gaiecom-db-dev \
  --rule-name allow-azure-services \
  --start-ip-address 0.0.0.0 \
  --end-ip-address 0.0.0.0
```

### Add Current Client IP

```bash
# Purpose: Quickly add your current IP
# When: Setting up local development access

# Get your public IP
MY_IP=$(curl -s ifconfig.me)

az postgres flexible-server firewall-rule create \
  --resource-group rg-gaiecom-dev \
  --name gaiecom-db-dev \
  --rule-name allow-my-current-ip \
  --start-ip-address $MY_IP \
  --end-ip-address $MY_IP
```

### List Firewall Rules

```bash
az postgres flexible-server firewall-rule list \
  --resource-group rg-gaiecom-dev \
  --name gaiecom-db-dev \
  --output table
```

### Delete Firewall Rule

```bash
az postgres flexible-server firewall-rule delete \
  --resource-group rg-gaiecom-dev \
  --name gaiecom-db-dev \
  --rule-name allow-my-ip \
  --yes
```

---

## Server Parameters & Extensions

### Enable Required Extensions

```bash
# Purpose: Allow PostgreSQL extensions (REQUIRED for GaiEcom schema)
# When: Before running schema migration

# Enable UUID-OSSP, PGCRYPTO, and PG_TRGM
az postgres flexible-server parameter set \
  --resource-group rg-gaiecom-dev \
  --server-name gaiecom-db-dev \
  --name azure.extensions \
  --value "UUID-OSSP,PGCRYPTO,PG_TRGM"

# Note: Extension names are case-insensitive
# After setting, create extensions in database:
# CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
# CREATE EXTENSION IF NOT EXISTS "pgcrypto";
# CREATE EXTENSION IF NOT EXISTS "pg_trgm";
```

### List All Parameters

```bash
# Purpose: View all server configuration parameters
az postgres flexible-server parameter list \
  --resource-group rg-gaiecom-dev \
  --server-name gaiecom-db-dev \
  --output table
```

### Show Specific Parameter

```bash
# Purpose: Check current value of a parameter
az postgres flexible-server parameter show \
  --resource-group rg-gaiecom-dev \
  --server-name gaiecom-db-dev \
  --name azure.extensions
```

### Common Parameters to Configure

```bash
# Max connections (based on tier)
az postgres flexible-server parameter set \
  --resource-group rg-gaiecom-dev \
  --server-name gaiecom-db-dev \
  --name max_connections \
  --value 100

# Timezone
az postgres flexible-server parameter set \
  --resource-group rg-gaiecom-dev \
  --server-name gaiecom-db-dev \
  --name timezone \
  --value "America/New_York"

# Log slow queries (useful for debugging)
az postgres flexible-server parameter set \
  --resource-group rg-gaiecom-dev \
  --server-name gaiecom-db-dev \
  --name log_min_duration_statement \
  --value 1000  # Log queries taking > 1 second

# Work memory (for complex queries)
az postgres flexible-server parameter set \
  --resource-group rg-gaiecom-dev \
  --server-name gaiecom-db-dev \
  --name work_mem \
  --value 16384  # 16MB
```

---

## Backup & Restore

### Show Backup Configuration

```bash
az postgres flexible-server show \
  --resource-group rg-gaiecom-dev \
  --name gaiecom-db-dev \
  --query "{backupRetentionDays:backup.backupRetentionDays, geoRedundantBackup:backup.geoRedundantBackup}"
```

### Update Backup Retention

```bash
# Purpose: Change backup retention period
# When: Adjusting backup policy

az postgres flexible-server update \
  --resource-group rg-gaiecom-dev \
  --name gaiecom-db-dev \
  --backup-retention 14
```

### Point-in-Time Restore

```bash
# Purpose: Restore database to a specific point in time
# When: Recovery from accidental data loss

az postgres flexible-server restore \
  --resource-group rg-gaiecom-dev \
  --name gaiecom-db-dev-restored \
  --source-server gaiecom-db-dev \
  --restore-time "2026-01-28T10:00:00Z"
```

### Geo-Restore (from geo-redundant backup)

```bash
# Purpose: Restore to different region
# When: Disaster recovery

az postgres flexible-server geo-restore \
  --resource-group rg-gaiecom-dr \
  --name gaiecom-db-dr \
  --source-server gaiecom-db-prod \
  --location westus2
```

---

## Monitoring & Diagnostics

### Get Connection String

```bash
# Purpose: Get connection string for application
az postgres flexible-server show \
  --resource-group rg-gaiecom-dev \
  --name gaiecom-db-dev \
  --query "fullyQualifiedDomainName" \
  --output tsv

# Full connection string format:
# postgresql://gaiecom_admin:<password>@gaiecom-db-dev.postgres.database.azure.com:5432/gaiecom?sslmode=require
```

### Show Server Metrics

```bash
# Purpose: View performance metrics
# When: Monitoring server health

# CPU percentage (last hour)
az monitor metrics list \
  --resource "/subscriptions/<sub-id>/resourceGroups/rg-gaiecom-dev/providers/Microsoft.DBforPostgreSQL/flexibleServers/gaiecom-db-dev" \
  --metric "cpu_percent" \
  --interval PT1H

# Memory percentage
az monitor metrics list \
  --resource "/subscriptions/<sub-id>/resourceGroups/rg-gaiecom-dev/providers/Microsoft.DBforPostgreSQL/flexibleServers/gaiecom-db-dev" \
  --metric "memory_percent" \
  --interval PT1H

# Storage used
az monitor metrics list \
  --resource "/subscriptions/<sub-id>/resourceGroups/rg-gaiecom-dev/providers/Microsoft.DBforPostgreSQL/flexibleServers/gaiecom-db-dev" \
  --metric "storage_used" \
  --interval PT1H
```

### Create Alert Rule

```bash
# Purpose: Get notified when CPU is high
# When: Setting up monitoring

az monitor metrics alert create \
  --resource-group rg-gaiecom-dev \
  --name "High CPU Alert" \
  --scopes "/subscriptions/<sub-id>/resourceGroups/rg-gaiecom-dev/providers/Microsoft.DBforPostgreSQL/flexibleServers/gaiecom-db-dev" \
  --condition "avg cpu_percent > 80" \
  --window-size 5m \
  --evaluation-frequency 1m \
  --action-group "/subscriptions/<sub-id>/resourceGroups/rg-gaiecom-dev/providers/microsoft.insights/actionGroups/email-alerts"
```

---

## Cost Management

### View Current Costs

```bash
# Purpose: Check spending on the resource group
az consumption usage list \
  --resource-group rg-gaiecom-dev \
  --start-date 2026-01-01 \
  --end-date 2026-01-31 \
  --output table
```

### Budget Alert

```bash
# Purpose: Set spending limit alert
az consumption budget create \
  --resource-group rg-gaiecom-dev \
  --budget-name gaiecom-monthly-budget \
  --amount 50 \
  --category Cost \
  --time-grain Monthly \
  --start-date 2026-01-01 \
  --end-date 2026-12-31
```

---

## Complete Setup Script

### Full Development Environment Setup

```bash
#!/bin/bash
# GaiEcom PostgreSQL Development Environment Setup
# Run: chmod +x setup-dev-db.sh && ./setup-dev-db.sh

set -e  # Exit on error

# Configuration
RESOURCE_GROUP="rg-gaiecom-dev"
LOCATION="eastus"
SERVER_NAME="gaiecom-db-dev"
DB_NAME="gaiecom"
ADMIN_USER="gaiecom_admin"
ADMIN_PASSWORD="<YourSecurePassword123!>"  # Change this!
SKU="Standard_B2s"
TIER="Burstable"
STORAGE_SIZE=32
PG_VERSION=16

echo "=== GaiEcom Database Setup ==="

# 1. Create Resource Group
echo "Creating resource group..."
az group create \
  --name $RESOURCE_GROUP \
  --location $LOCATION \
  --tags project=gaiecom environment=dev

# 2. Create PostgreSQL Flexible Server
echo "Creating PostgreSQL server (this may take several minutes)..."
az postgres flexible-server create \
  --resource-group $RESOURCE_GROUP \
  --name $SERVER_NAME \
  --location $LOCATION \
  --admin-user $ADMIN_USER \
  --admin-password "$ADMIN_PASSWORD" \
  --sku-name $SKU \
  --tier $TIER \
  --storage-size $STORAGE_SIZE \
  --version $PG_VERSION \
  --high-availability Disabled \
  --backup-retention 7 \
  --geo-redundant-backup Disabled \
  --public-access 0.0.0.0 \
  --tags project=gaiecom environment=dev

# 3. Add current IP to firewall
echo "Adding firewall rule for current IP..."
MY_IP=$(curl -s ifconfig.me)
az postgres flexible-server firewall-rule create \
  --resource-group $RESOURCE_GROUP \
  --name $SERVER_NAME \
  --rule-name allow-my-ip \
  --start-ip-address $MY_IP \
  --end-ip-address $MY_IP

# 4. Allow Azure services
echo "Allowing Azure services..."
az postgres flexible-server firewall-rule create \
  --resource-group $RESOURCE_GROUP \
  --name $SERVER_NAME \
  --rule-name allow-azure \
  --start-ip-address 0.0.0.0 \
  --end-ip-address 0.0.0.0

# 5. Enable required extensions
echo "Enabling PostgreSQL extensions..."
az postgres flexible-server parameter set \
  --resource-group $RESOURCE_GROUP \
  --server-name $SERVER_NAME \
  --name azure.extensions \
  --value "UUID-OSSP,PGCRYPTO,PG_TRGM"

# 6. Create application database
echo "Creating database..."
az postgres flexible-server db create \
  --resource-group $RESOURCE_GROUP \
  --server-name $SERVER_NAME \
  --database-name $DB_NAME

# 7. Get connection info
FQDN=$(az postgres flexible-server show \
  --resource-group $RESOURCE_GROUP \
  --name $SERVER_NAME \
  --query "fullyQualifiedDomainName" \
  --output tsv)

echo ""
echo "=== Setup Complete ==="
echo ""
echo "Server FQDN: $FQDN"
echo "Database: $DB_NAME"
echo "Admin User: $ADMIN_USER"
echo ""
echo "Connection String:"
echo "postgresql://${ADMIN_USER}:<password>@${FQDN}:5432/${DB_NAME}?sslmode=require"
echo ""
echo "Next steps:"
echo "1. Connect using psql or your preferred client"
echo "2. Run: CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\";"
echo "3. Run: CREATE EXTENSION IF NOT EXISTS \"pgcrypto\";"
echo "4. Run: CREATE EXTENSION IF NOT EXISTS \"pg_trgm\";"
echo "5. Load schema: psql -h $FQDN -U $ADMIN_USER -d $DB_NAME -f schema/001_initial_schema.sql"
```

### Cleanup Script

```bash
#!/bin/bash
# Delete all GaiEcom dev resources
# WARNING: This is destructive!

read -p "Are you sure you want to delete all resources? (yes/no): " confirm
if [ "$confirm" = "yes" ]; then
  echo "Deleting resource group and all resources..."
  az group delete --name rg-gaiecom-dev --yes --no-wait
  echo "Deletion initiated (runs in background)"
else
  echo "Cancelled"
fi
```

---

## Portal Equivalent Steps

For those who prefer the Azure Portal UI:

### Step 1: Create Resource Group

1. Go to [Azure Portal](https://portal.azure.com)
2. Search for "Resource groups"
3. Click "+ Create"
4. Fill in:
   - Subscription: Your subscription
   - Resource group: `rg-gaiecom-dev`
   - Region: `East US`
5. Click "Review + create" → "Create"

### Step 2: Create PostgreSQL Server

1. Search for "Azure Database for PostgreSQL flexible servers"
2. Click "+ Create"
3. **Basics tab:**
   - Subscription: Your subscription
   - Resource group: `rg-gaiecom-dev`
   - Server name: `gaiecom-db-dev`
   - Region: `East US`
   - PostgreSQL version: `16`
   - Workload type: `Development` (auto-selects Burstable)
   - Compute + storage: Click "Configure server"
     - Compute tier: `Burstable`
     - Compute size: `Standard_B2s (2 vCores, 4 GiB memory)`
     - Storage size: `32 GiB`
     - Storage Auto-growth: `Enabled`
   - Admin username: `gaiecom_admin`
   - Password: Your secure password

4. **Networking tab:**
   - Connectivity method: `Public access`
   - Allow public access: `Yes`
   - Add current client IP: `Yes`
   - Allow Azure services: `Yes`

5. **Security tab:**
   - Leave defaults

6. **Tags tab:**
   - Name: `project`, Value: `gaiecom`
   - Name: `environment`, Value: `dev`

7. Click "Review + create" → "Create"
8. Wait for deployment (5-10 minutes)

### Step 3: Enable Extensions

1. Go to your PostgreSQL server
2. Left menu → Settings → Server parameters
3. Search for `azure.extensions`
4. Click the value field
5. Select: `UUID-OSSP`, `PGCRYPTO`, `PG_TRGM`
6. Click "Save"

### Step 4: Create Database

1. Go to your PostgreSQL server
2. Left menu → Settings → Databases
3. Click "+ Add"
4. Database name: `gaiecom`
5. Click "Save"

### Step 5: Connect and Run Schema

1. Go to your PostgreSQL server
2. Left menu → Overview
3. Copy "Server name" (FQDN)
4. Use psql or pgAdmin to connect
5. Run schema file

---

## Quick Reference Card

```
┌─────────────────────────────────────────────────────────────────┐
│                    AZURE CLI QUICK REFERENCE                     │
├─────────────────────────────────────────────────────────────────┤
│ LOGIN                                                            │
│   az login                                                       │
│   az account set --subscription "<name>"                         │
├─────────────────────────────────────────────────────────────────┤
│ SERVER MANAGEMENT                                                │
│   az postgres flexible-server create ...                         │
│   az postgres flexible-server show -g <rg> -n <name>            │
│   az postgres flexible-server stop -g <rg> -n <name>            │
│   az postgres flexible-server start -g <rg> -n <name>           │
│   az postgres flexible-server update -g <rg> -n <name> ...      │
│   az postgres flexible-server delete -g <rg> -n <name> --yes    │
├─────────────────────────────────────────────────────────────────┤
│ DATABASE                                                         │
│   az postgres flexible-server db create -g <rg> -s <srv> -d <db>│
│   az postgres flexible-server db list -g <rg> -s <srv>          │
│   az postgres flexible-server connect -g <rg> -s <srv> -d <db>  │
├─────────────────────────────────────────────────────────────────┤
│ FIREWALL                                                         │
│   az postgres flexible-server firewall-rule create ...           │
│   az postgres flexible-server firewall-rule list -g <rg> -n <n> │
├─────────────────────────────────────────────────────────────────┤
│ EXTENSIONS                                                       │
│   az postgres flexible-server parameter set \                    │
│     -g <rg> -s <srv> --name azure.extensions \                  │
│     --value "UUID-OSSP,PGCRYPTO,PG_TRGM"                        │
├─────────────────────────────────────────────────────────────────┤
│ SHORTCUTS                                                        │
│   -g = --resource-group                                          │
│   -n = --name                                                    │
│   -s = --server-name                                             │
│   -d = --database-name                                           │
│   -o = --output (table, json, tsv, yaml)                        │
└─────────────────────────────────────────────────────────────────┘
```

---

## Version History

| Date | Changes |
|------|---------|
| 2026-01-29 | Initial CLI reference for GaiEcom project |
