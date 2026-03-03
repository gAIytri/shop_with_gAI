# Azure PostgreSQL Flexible Server - Pricing & Configuration Analysis

**Created:** 2026-01-29
**Project:** GaiEcom E-commerce Platform
**Purpose:** Document pricing tiers, configuration options, and cost optimization strategies

---

## Table of Contents

1. [Pricing Tiers Overview](#pricing-tiers-overview)
2. [Burstable Tier Details](#burstable-tier-details)
3. [General Purpose Tier Details](#general-purpose-tier-details)
4. [Memory Optimized Tier Details](#memory-optimized-tier-details)
5. [Storage Options & Pricing](#storage-options--pricing)
6. [Recommended Configuration for GaiEcom](#recommended-configuration-for-gaiecom)
7. [Cost Optimization Strategies](#cost-optimization-strategies)
8. [Scaling Path](#scaling-path)
9. [Configuration Checklist](#configuration-checklist)

---

## Pricing Tiers Overview

Azure Database for PostgreSQL Flexible Server offers three compute tiers:

| Tier | Best For | vCores | Memory | Monthly Cost Range |
|------|----------|--------|--------|-------------------|
| **Burstable** | Dev/Test, Low traffic, POC | 1-20 | 2-80 GiB | $12 - $993 |
| **General Purpose** | Production workloads | 2-192 | 8-768 GiB | $100 - $8,000+ |
| **Memory Optimized** | High-performance OLTP, Analytics | 2-192 | 16-1,832 GiB | $150 - $10,000+ |

### Key Differences

| Feature | Burstable | General Purpose | Memory Optimized |
|---------|-----------|-----------------|------------------|
| CPU Model | Credit-based bursting | Consistent performance | Consistent performance |
| Memory/vCore | Variable | 4 GiB | 6.75-9.5 GiB |
| Use Case | Intermittent workloads | Balanced workloads | Memory-intensive |
| Production Ready | No (not recommended) | Yes | Yes |
| Cost Efficiency | Highest (for dev) | Moderate | Lowest |

---

## Burstable Tier Details

**Best for:** Development, testing, proof-of-concept, low-traffic applications

### Available SKUs

| SKU | vCores | Memory | Max IOPS | Max I/O Bandwidth | Est. Monthly Cost |
|-----|--------|--------|----------|-------------------|-------------------|
| **B1ms** | 1 | 2 GiB | 640 | 10 MiB/sec | ~$12.41 |
| **B2s** | 2 | 4 GiB | 1,280 | 15 MiB/sec | ~$25 |
| **B2ms** | 2 | 8 GiB | 1,920 | 22.5 MiB/sec | ~$50 |
| **B4ms** | 4 | 16 GiB | 2,880 | 35 MiB/sec | ~$100 |
| **B8ms** | 8 | 32 GiB | 4,320 | 50 MiB/sec | ~$200 |
| **B12ms** | 12 | 48 GiB | 4,320 | 50 MiB/sec | ~$300 |
| **B16ms** | 16 | 64 GiB | 4,320 | 50 MiB/sec | ~$400 |
| **B20ms** | 20 | 80 GiB | 4,320 | 50 MiB/sec | ~$993 |

### Important: CPU Credit Model

Burstable tier uses a **credit-based CPU model**:
- Credits accumulate when CPU usage is below baseline
- Credits are consumed when CPU usage exceeds baseline
- When credits deplete, server is restricted to baseline CPU

**Warning Signs:**
- Connection timeouts
- Slow query performance
- Transient failures

**Monitoring:** Set up Azure Monitor alerts for "CPU Credits Remaining"

---

## General Purpose Tier Details

**Best for:** Most production workloads, web/mobile apps, enterprise applications

### Available Series

| Series | vCore Options | Memory per vCore | Notes |
|--------|---------------|------------------|-------|
| Ddsv6 | 2-192 | 4 GiB | Latest, best price-performance |
| Dadsv6 | 2-192 | 4 GiB | AMD processors |
| Ddsv5 | 2-96 | 4 GiB | Previous generation |
| Dadsv5 | 2-96 | 4 GiB | AMD, previous gen |
| Ddsv4 | 2-64 | 4 GiB | Older generation |
| Dsv3 | 2-64 | 4 GiB | Oldest supported |

### Sample SKUs

| SKU | vCores | Memory | Max IOPS | Est. Monthly Cost |
|-----|--------|--------|----------|-------------------|
| D2s_v3 | 2 | 8 GiB | 3,200 | ~$100 |
| D4ds_v5 | 4 | 16 GiB | 6,400 | ~$200 |
| D4ds_v6 | 4 | 16 GiB | 8,333 | ~$180 |
| D8ds_v6 | 8 | 32 GiB | 16,667 | ~$350 |
| D16ds_v6 | 16 | 64 GiB | 33,333 | ~$700 |

---

## Memory Optimized Tier Details

**Best for:** High-performance databases, real-time processing, analytics

### Available Series

| Series | vCore Options | Memory per vCore | Notes |
|--------|---------------|------------------|-------|
| Edsv6 | 2-192 | ~8 GiB | Latest generation |
| Eadsv6 | 2-192 | ~8 GiB | AMD processors |
| Edsv5 | 2-96 | ~8 GiB | Previous generation |
| Eadsv5 | 2-96 | ~8 GiB | AMD, previous gen |
| Edsv4 | 2-64 | ~8 GiB | Older generation |

### Sample SKUs

| SKU | vCores | Memory | Max IOPS | Est. Monthly Cost |
|-----|--------|--------|----------|-------------------|
| E2ds_v6 | 2 | 16 GiB | 4,167 | ~$150 |
| E4ds_v6 | 4 | 32 GiB | 8,333 | ~$300 |
| E8ds_v6 | 8 | 64 GiB | 16,667 | ~$600 |
| E16ds_v6 | 16 | 128 GiB | 33,333 | ~$1,200 |

---

## Storage Options & Pricing

### Storage Types Comparison

| Feature | Premium SSD | Premium SSD v2 |
|---------|-------------|----------------|
| Max Size | 32 TiB | 64 TiB |
| Max IOPS | 20,000 | 80,000 |
| Max Throughput | 900 MB/s | 1,200 MB/s |
| Pricing Model | Fixed per size | Granular (1 GiB increments) |
| Free IOPS | Based on size | 3,000 IOPS included |
| Best For | Consistent workloads | Variable workloads |
| Cost | ~$0.115/GiB/month | ~$0.08/GiB/month |

### Storage Pricing Examples

| Size | Premium SSD Cost | Premium SSD v2 Cost |
|------|------------------|---------------------|
| 32 GiB | ~$3.68/month | ~$2.56/month |
| 64 GiB | ~$7.36/month | ~$5.12/month |
| 128 GiB | ~$14.72/month | ~$10.24/month |
| 256 GiB | ~$29.44/month | ~$20.48/month |
| 512 GiB | ~$58.88/month | ~$40.96/month |

### IOPS Scaling

| Disk Size | Premium SSD IOPS | Premium SSD v2 IOPS |
|-----------|------------------|---------------------|
| 32 GiB | 120 (burst to 3,500) | 3,000 free |
| 64 GiB | 240 (burst to 3,500) | 3,000 free |
| 128 GiB | 500 (burst to 3,500) | 3,000 free |
| 512 GiB | 2,300 (burst to 3,500) | 12,000 free |
| 1 TiB | 5,000 | 12,000 free |

### Backup Storage

- **Free:** Up to 100% of provisioned server storage
- **Excess:** Charged per GiB/month
- **Example:** 32 GiB server = 32 GiB free backup storage

---

## Recommended Configuration for GaiEcom

### Development Phase (Current)

```
┌─────────────────────────────────────────────────────────────┐
│  RECOMMENDED: Burstable B2s                                 │
├─────────────────────────────────────────────────────────────┤
│  Compute:     B2s (2 vCores, 4 GiB RAM)                    │
│  Storage:     32 GiB Premium SSD v2                        │
│  Backup:      7 days retention                             │
│  HA:          Disabled                                      │
│  Region:      East US (cost-effective)                     │
├─────────────────────────────────────────────────────────────┤
│  ESTIMATED MONTHLY COST:                                    │
│  • Compute:  ~$25/month                                     │
│  • Storage:  ~$3/month                                      │
│  • Backup:   FREE                                           │
│  ─────────────────────────────────────                     │
│  TOTAL:      ~$28-30/month                                 │
└─────────────────────────────────────────────────────────────┘
```

### Why B2s Over B1ms?

| Factor | B1ms | B2s | Winner |
|--------|------|-----|--------|
| Memory | 2 GiB | 4 GiB | B2s (PostgreSQL needs RAM) |
| Max Connections | ~50 | ~100 | B2s |
| IOPS | 640 | 1,280 | B2s (2x) |
| Cost | ~$12/mo | ~$25/mo | B1ms |
| For 21 tables + indexes | Tight | Comfortable | B2s |
| **Recommendation** | POC only | Dev/Test | **B2s** |

### Why B2s Over B2ms?

| Factor | B2s | B2ms | Winner |
|--------|-----|------|--------|
| Memory | 4 GiB | 8 GiB | B2ms |
| IOPS | 1,280 | 1,920 | B2ms |
| Cost | ~$25/mo | ~$50/mo | B2s |
| For GaiEcom Dev | Sufficient | Overkill | **B2s** |

---

## Cost Optimization Strategies

### 1. Stop/Start Server (Biggest Savings)

When server is stopped:
- **Compute billing:** STOPS immediately
- **Storage billing:** Continues
- **Backup billing:** Continues

**Potential savings:** Up to 100% compute costs during idle

### 2. Reserved Capacity

| Commitment | Savings vs Pay-as-you-go |
|------------|--------------------------|
| 1 Year | Up to 40% |
| 3 Years | Up to 60% |

**When to use:** After stable production deployment

### 3. Right-Size Resources

- Monitor actual CPU/memory usage
- Scale down if consistently under-utilized
- Use Azure Advisor recommendations

### 4. Disable Unnecessary Features

| Feature | Cost Impact | When to Disable |
|---------|-------------|-----------------|
| High Availability | 2x compute cost | Dev/Test environments |
| Geo-redundant backup | ~30% storage | Non-critical data |
| Long backup retention | Storage cost | Dev environments |

### 5. Choose Cost-Effective Region

Lower cost regions (US):
- East US
- West US 2
- South Central US

Higher cost regions:
- West Europe
- Southeast Asia

### 6. Use Premium SSD v2

- ~30% cheaper than Premium SSD
- 3,000 IOPS included free
- Better for variable workloads

---

## Scaling Path

### GaiEcom Growth Stages

```
Stage 1: Development
├── SKU: B2s (2 vCores, 4 GiB)
├── Storage: 32 GiB
├── Cost: ~$30/month
└── Handles: Development, testing, <100 concurrent users

        ↓ (Product launch)

Stage 2: Beta/Soft Launch
├── SKU: B4ms (4 vCores, 16 GiB)
├── Storage: 64 GiB
├── Cost: ~$110/month
└── Handles: Beta users, <500 concurrent users

        ↓ (Growing traffic)

Stage 3: Production
├── SKU: D2ds_v5 (2 vCores, 8 GiB) - General Purpose
├── Storage: 128 GiB
├── HA: Enabled (zone-redundant)
├── Cost: ~$250/month
└── Handles: Production traffic, <2000 concurrent users

        ↓ (Scale requirements)

Stage 4: High Traffic
├── SKU: D4ds_v6 (4 vCores, 16 GiB)
├── Storage: 256 GiB + read replicas
├── HA: Enabled
├── Cost: ~$500+/month
└── Handles: High traffic, thousands of users
```

### Scaling Considerations

| Metric | Action Threshold | Scaling Direction |
|--------|------------------|-------------------|
| CPU > 80% sustained | 15+ minutes | Scale up vCores |
| Memory > 85% | Consistent | Scale up memory tier |
| Storage > 80% | Approaching limit | Increase storage |
| IOPS maxed | Frequent | Upgrade storage tier |
| Connection limit | Near max | Scale up compute |

---

## Configuration Checklist

### Before Creation

- [ ] Decide on region (cost vs latency)
- [ ] Choose compute tier and SKU
- [ ] Determine storage size (can only grow)
- [ ] Plan networking (public vs private)
- [ ] List required extensions

### During Creation (Azure Portal)

```yaml
Basics:
  - [ ] Server name: gaiecom-db-{env}
  - [ ] Region: East US
  - [ ] PostgreSQL version: 16
  - [ ] Workload type: Development

Compute + Storage:
  - [ ] Tier: Burstable
  - [ ] SKU: Standard_B2s
  - [ ] Storage: 32 GiB
  - [ ] Storage type: Premium SSD v2
  - [ ] Auto-growth: Enabled

High Availability:
  - [ ] HA: Disabled (for dev)

Backup:
  - [ ] Retention: 7 days
  - [ ] Geo-redundant: No

Networking:
  - [ ] Method: Public access (dev) / Private endpoint (prod)
  - [ ] Allow Azure services: Yes
  - [ ] Add client IP: Yes

Authentication:
  - [ ] Method: PostgreSQL authentication
  - [ ] Admin username: gaiecom_admin
  - [ ] Password: (stored in Key Vault)
```

### After Creation

- [ ] Enable required extensions (azure.extensions parameter)
- [ ] Configure firewall rules
- [ ] Create application database
- [ ] Create application user (non-admin)
- [ ] Test connectivity
- [ ] Run schema migration
- [ ] Set up monitoring alerts

---

## Required Extensions for GaiEcom

| Extension | Purpose | Required |
|-----------|---------|----------|
| UUID-OSSP | `uuid_generate_v4()` for primary keys | Yes |
| PGCRYPTO | Password hashing functions | Yes |
| PG_TRGM | Fuzzy text search, trigram indexes | Yes |

---

## References

- [Azure PostgreSQL Flexible Server Pricing](https://azure.microsoft.com/en-us/pricing/details/postgresql/flexible-server/)
- [Compute Options](https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-compute)
- [Storage Options](https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-storage)
- [Cost Optimization Guide](https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/how-to-cost-optimization)
- [Extensions](https://learn.microsoft.com/en-us/azure/postgresql/extensions/how-to-allow-extensions)

---

## Version History

| Date | Changes |
|------|---------|
| 2026-01-29 | Initial analysis for GaiEcom project |
