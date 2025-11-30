# WAL Archiving and Incremental Backups

This guide explains how to configure PostgreSQL WAL (Write-Ahead Log) archiving for incremental backups and point-in-time recovery (PITR).

## Table of Contents

1. [Overview](#overview)
2. [Architecture](#architecture)
3. [Quick Start](#quick-start)
4. [Configuration](#configuration)
5. [Backup Methods](#backup-methods)
6. [Point-in-Time Recovery](#point-in-time-recovery)
7. [Best Practices](#best-practices)
8. [Troubleshooting](#troubleshooting)

## Overview

### What is WAL Archiving?

Write-Ahead Logging (WAL) is PostgreSQL's mechanism for ensuring data integrity. WAL archiving captures these log files, enabling:

- **Incremental Backups**: Only changes since the last full backup
- **Point-in-Time Recovery (PITR)**: Restore to any specific moment
- **Continuous Backup**: No data loss between full backups
- **Faster Recovery**: Combine full backup + WAL replay

### Full Backup vs WAL Archiving

| Feature | Full Backup | WAL Archiving |
|---------|-------------|---------------|
| **Frequency** | Scheduled (daily) | Continuous |
| **Size** | Complete database | Only changes |
| **Recovery Point** | Backup time | Any point in time |
| **Storage** | ~1x database size | Grows over time |
| **CPU Impact** | High during backup | Low continuous |

**Best Practice**: Use both together! Full backups provide base restore points, WAL archiving fills the gaps.

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    PostgreSQL Pod                           │
│                                                             │
│  ┌──────────────┐                                          │
│  │  PostgreSQL  │                                          │
│  │   Process    │                                          │
│  │              │                                          │
│  │  WAL Writer ────────┐                                  │
│  └──────────────┘      │                                  │
│                        │                                  │
│                        ▼                                  │
│              ┌─────────────────┐                         │
│              │   archive_command │                         │
│              │   (gzip/cp/wal-g) │                         │
│              └─────────────────┘                         │
│                        │                                  │
└────────────────────────┼──────────────────────────────────┘
                         │
                         ▼
          ┌──────────────────────────┐
          │   WAL Archive Storage    │
          │   (PVC / S3 / GCS)       │
          │                          │
          │  000000010000000000000001│
          │  000000010000000000000002│
          │  000000010000000000000003│
          │  ...                     │
          └──────────────────────────┘
                         │
                         ▼
          ┌──────────────────────────┐
          │   Cleanup CronJob        │
          │   (Remove old WAL files) │
          └──────────────────────────┘
```

## Quick Start

### Simple File-Based WAL Archiving

This method uses `gzip` compression and stores WAL files on a PVC:

```yaml
backup:
  enabled: true
  schedule: "0 2 * * *"
  retentionDays: 7

  wal:
    enabled: true
    method: "simple"
    compression: "gzip"
    retentionDays: 14

    persistence:
      enabled: true
      size: 100Gi

    cleanup:
      enabled: true
      schedule: "0 3 * * *"
```

### Install the Chart

```bash
helm install my-postgres . -f examples/values-wal-archiving.yaml
```

### Verify WAL Archiving

```bash
# Check if archive_mode is enabled
kubectl exec -it my-postgres-0 -- psql -U postgres -c "SHOW archive_mode;"

# Check archive_command
kubectl exec -it my-postgres-0 -- psql -U postgres -c "SHOW archive_command;"

# List archived WAL files
kubectl exec -it my-postgres-0 -- ls -lh /wal-archive/

# Check archiver process
kubectl exec -it my-postgres-0 -- psql -U postgres -c "SELECT * FROM pg_stat_archiver;"
```

## Configuration

### Required PostgreSQL Settings

These are automatically configured when `backup.wal.enabled: true`:

```yaml
postgresql:
  config:
    wal_level: "replica"        # Required for archiving
    archive_mode: "on"          # Enable archiving
    archive_command: "..."      # Set based on method
    archive_timeout: "300"      # Archive every 5 minutes
```

### WAL Configuration Parameters

#### `backup.wal.enabled`
- **Type**: `boolean`
- **Default**: `false`
- **Description**: Enable WAL archiving

#### `backup.wal.method`
- **Type**: `string`
- **Default**: `"simple"`
- **Options**: `simple`, `wal-g`, `wal-e`, `pgbackrest`
- **Description**: WAL archive method

#### `backup.wal.compression`
- **Type**: `string`
- **Default**: `"gzip"`
- **Options**: `none`, `gzip`, `lz4`, `zstd`
- **Description**: Compression algorithm for WAL files

**Compression Comparison**:
| Method | Ratio | Speed | CPU |
|--------|-------|-------|-----|
| none | 1:1 | Fastest | Lowest |
| gzip | ~5:1 | Slow | High |
| lz4 | ~3:1 | Fast | Low |
| zstd | ~4:1 | Medium | Medium |

#### `backup.wal.retentionDays`
- **Type**: `integer`
- **Default**: `14`
- **Description**: Days to keep WAL archives
- **Best Practice**: Should be ≥ full backup retention

#### `backup.wal.persistence`
Storage for WAL archives (simple method):

```yaml
backup:
  wal:
    persistence:
      enabled: true
      storageClass: ""
      size: 100Gi              # Size depends on change rate
      mountPath: /wal-archive
      accessModes:
        - ReadWriteOnce
```

**Sizing Guide**:
- Low activity: 5-10 GB per week
- Medium activity: 20-50 GB per week
- High activity: 100-500 GB per week

## Backup Methods

### 1. Simple (File-Based)

**When to use**: Small to medium databases, simple setup

```yaml
backup:
  wal:
    enabled: true
    method: "simple"
    compression: "gzip"
```

**Archive Command**:
```bash
# gzip compression
gzip < %p > /wal-archive/%f.gz

# lz4 compression
lz4 -q -z %p /wal-archive/%f.lz4

# No compression
cp %p /wal-archive/%f
```

**Pros**:
- ✅ Simple setup
- ✅ No external dependencies
- ✅ Works with any storage

**Cons**:
- ❌ Manual cloud upload
- ❌ Basic retention management
- ❌ No encryption

### 2. WAL-G (Recommended for Cloud)

**When to use**: Cloud storage (S3/GCS/Azure), advanced features

```yaml
backup:
  wal:
    enabled: true
    method: "wal-g"

    storage:
      type: "s3"
      s3:
        bucket: "my-backups"
        region: "us-east-1"
        prefix: "wal-archive"
        existingSecret: "wal-g-credentials"

    walg:
      image:
        repository: wal-g/wal-g
        tag: "v3.0.0"
      env:
        WALG_COMPRESSION_METHOD: "lz4"
        WALG_DELTA_MAX_STEPS: "6"
```

**Archive Command**:
```bash
/usr/local/bin/wal-g wal-push %p
```

**Pros**:
- ✅ Cloud storage support
- ✅ Delta backups
- ✅ Encryption
- ✅ Active development

**Cons**:
- ❌ More complex setup
- ❌ External dependency

### 3. pgBackRest

**When to use**: Enterprise features, advanced recovery

```yaml
backup:
  wal:
    enabled: true
    method: "pgbackrest"

    pgbackrest:
      image:
        repository: pgbackrest/pgbackrest
        tag: "2.49"
      config:
        repo1-retention-full: "2"
        repo1-retention-diff: "7"
```

**Archive Command**:
```bash
pgbackrest --stanza=my-postgres archive-push %p
```

**Pros**:
- ✅ Enterprise-grade
- ✅ Parallel processing
- ✅ Delta backups
- ✅ Verification

**Cons**:
- ❌ Complex configuration
- ❌ Steeper learning curve

## Point-in-Time Recovery

### Recovery Architecture

```
Full Backup          WAL Archives              Recovery Point
(Day 1, 2AM)    (Continuous)                 (Day 3, 10:15 AM)
     │                 │                            │
     ▼                 ▼                            ▼
┌─────────┐    ┌──────────────┐              ┌──────────┐
│ Base    │ +  │ WAL 000001   │  =  Restore  │ Database │
│ Backup  │    │ WAL 000002   │   ========>  │ at exact │
│ (20GB)  │    │ WAL 000003   │              │ moment   │
└─────────┘    └──────────────┘              └──────────┘
```

### Performing PITR

1. **Stop the Database** (if running):
```bash
kubectl scale statefulset my-postgres --replicas=0
```

2. **Restore Full Backup**:
```bash
# From backup PVC
kubectl exec -it my-postgres-backup-pod -- \
  pg_restore -U postgres -d postgres /backups/backup-YYYY-MM-DD.sql.gz
```

3. **Configure Recovery**:

Create `recovery.conf` (PostgreSQL < 12) or add to `postgresql.conf`:

```bash
kubectl exec -it my-postgres-0 -- bash -c 'cat > /var/lib/postgresql/data/recovery.signal'

kubectl exec -it my-postgres-0 -- bash -c 'cat >> /var/lib/postgresql/data/postgresql.auto.conf <<EOF
restore_command = "gunzip < /wal-archive/%f.gz > %p"
recovery_target_time = "2024-01-15 10:15:00"
recovery_target_action = "promote"
EOF'
```

4. **Start Database**:
```bash
kubectl scale statefulset my-postgres --replicas=1
```

5. **Monitor Recovery**:
```bash
kubectl logs -f my-postgres-0

# Check recovery status
kubectl exec -it my-postgres-0 -- \
  psql -U postgres -c "SELECT pg_is_in_recovery();"
```

### Recovery Time Examples

| Database Size | Full Backup | + WAL Replay | Total Time |
|---------------|-------------|--------------|------------|
| 10 GB | 2 minutes | 30 seconds | **2.5 min** |
| 100 GB | 20 minutes | 5 minutes | **25 min** |
| 1 TB | 3 hours | 30 minutes | **3.5 hours** |

## Best Practices

### 1. Storage Sizing

**Formula**: `WAL Storage = Daily Change Rate × Retention Days × 1.5`

Example:
- Daily changes: 10 GB
- Retention: 14 days
- Storage: 10 × 14 × 1.5 = **210 GB**

### 2. Retention Policy

```yaml
backup:
  # Full backups: 7 days
  retentionDays: 7

  wal:
    # WAL archives: 14 days (2x full backup retention)
    retentionDays: 14
```

**Why longer WAL retention?**
- Provides recovery window beyond last full backup
- Allows PITR to any point in 14 days
- Safety margin for delayed restores

### 3. Monitoring

Monitor these metrics:

```sql
-- Archive status
SELECT * FROM pg_stat_archiver;

-- WAL generation rate
SELECT pg_wal_lsn_diff(pg_current_wal_lsn(), '0/0') / 1024 / 1024 AS mb_generated;

-- Pending WAL files
SELECT count(*) FROM pg_ls_waldir() WHERE name ~ '^[0-9A-F]{24}$';
```

### 4. Testing

**Monthly Recovery Test**:
```bash
# 1. Create test namespace
kubectl create namespace postgres-recovery-test

# 2. Restore full backup
# 3. Apply WAL archives
# 4. Verify data
# 5. Cleanup
kubectl delete namespace postgres-recovery-test
```

### 5. Security

```yaml
backup:
  wal:
    storage:
      s3:
        # Use existing secret for credentials
        existingSecret: "wal-archive-s3-credentials"

# Create secret
kubectl create secret generic wal-archive-s3-credentials \
  --from-literal=AWS_ACCESS_KEY_ID=xxx \
  --from-literal=AWS_SECRET_ACCESS_KEY=yyy \
  --from-literal=AWS_DEFAULT_REGION=us-east-1
```

### 6. Performance Tuning

```yaml
postgresql:
  config:
    # Increase WAL buffers for high-write workloads
    wal_buffers: "16MB"

    # Checkpoint tuning
    checkpoint_completion_target: "0.9"
    max_wal_size: "4GB"
    min_wal_size: "1GB"

    # Archive timeout (balance between PITR granularity and overhead)
    archive_timeout: "300"  # 5 minutes
```

## Troubleshooting

### WAL Archive Queue Growing

**Symptom**: `pg_stat_archiver.failed_count` increasing

**Causes**:
- Storage full
- Slow storage
- Archive command failing

**Solution**:
```bash
# Check disk space
kubectl exec -it my-postgres-0 -- df -h /wal-archive

# Check archive status
kubectl exec -it my-postgres-0 -- \
  psql -U postgres -c "SELECT * FROM pg_stat_archiver;"

# Check archive command
kubectl logs my-postgres-0 | grep archive
```

### Archive Command Failing

**Check logs**:
```bash
kubectl logs my-postgres-0 | grep -i archive

# PostgreSQL logs
kubectl exec -it my-postgres-0 -- tail -f /var/lib/postgresql/data/log/postgresql-*.log
```

**Common Errors**:

1. **Permission denied**:
```bash
# Fix permissions
kubectl exec -it my-postgres-0 -- chmod 755 /wal-archive
```

2. **Disk full**:
```bash
# Increase PVC size or run cleanup
kubectl exec -it my-postgres-0 -- \
  find /wal-archive -mtime +14 -delete
```

### Recovery Failing

**Check recovery.conf**:
```bash
kubectl exec -it my-postgres-0 -- \
  cat /var/lib/postgresql/data/postgresql.auto.conf
```

**Test restore_command**:
```bash
kubectl exec -it my-postgres-0 -- bash -c \
  'gunzip < /wal-archive/000000010000000000000001.gz'
```

### Slow WAL Archiving

**Monitor archive rate**:
```sql
SELECT
  archived_count,
  last_archived_wal,
  last_archived_time,
  failed_count,
  last_failed_wal,
  last_failed_time
FROM pg_stat_archiver;
```

**Optimization**:
1. Use faster compression (`lz4` instead of `gzip`)
2. Increase storage IOPS
3. Use local SSD for WAL archive staging

## Examples

See these example configurations:

- [examples/values-wal-archiving.yaml](./examples/values-wal-archiving.yaml) - Complete WAL setup
- [examples/values-production.yaml](./examples/values-production.yaml) - Production config with HA
- [examples/values-ha.yaml](./examples/values-ha.yaml) - High availability setup

## Additional Resources

- [PostgreSQL WAL Archiving Documentation](https://www.postgresql.org/docs/current/continuous-archiving.html)
- [WAL-G Documentation](https://github.com/wal-g/wal-g)
- [pgBackRest Documentation](https://pgbackrest.org/)
- [Point-in-Time Recovery Guide](https://www.postgresql.org/docs/current/continuous-archiving.html#BACKUP-PITR-RECOVERY)
