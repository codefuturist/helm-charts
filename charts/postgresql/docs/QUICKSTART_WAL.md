# WAL Archiving Quick Start Guide

This guide will help you set up PostgreSQL with WAL archiving in 5 minutes.

## What You'll Get

✅ **Continuous incremental backups** - No data loss between full backups  
✅ **Point-in-Time Recovery (PITR)** - Restore to any specific moment  
✅ **Production-ready setup** - Automated cleanup and monitoring

## Prerequisites

- Kubernetes 1.21+
- Helm 3.8+
- 150 GB available storage (50 GB database + 100 GB WAL archives)

## Step 1: Create Values File

Create `my-values.yaml`:

```yaml
postgresql:
  enabled: true
  database: "myapp"
  username: "myapp"

  config:
    wal_level: "replica"

persistence:
  enabled: true
  size: 20Gi

deployment:
  type: "statefulset"
  replicaCount: 1

# Full backups
backup:
  enabled: true
  schedule: "0 2 * * *"  # 2 AM daily
  retentionDays: 7

  persistence:
    enabled: true
    size: 50Gi

  # Incremental backups via WAL archiving
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
      schedule: "0 3 * * *"  # 3 AM daily
```

## Step 2: Install

```bash
# Add repository (if not already added)
helm repo add my-charts .
helm repo update

# Install
helm install my-postgres . -f my-values.yaml

# Wait for pod to be ready
kubectl wait --for=condition=ready pod/my-postgres-0 --timeout=300s
```

## Step 3: Verify Setup

### Check PostgreSQL is Running

```bash
kubectl get pods
# NAME              READY   STATUS    RESTARTS   AGE
# my-postgres-0     1/1     Running   0          2m
```

### Verify WAL Archiving is Enabled

```bash
# Check archive_mode
kubectl exec -it my-postgres-0 -- psql -U myapp -d myapp -c "SHOW archive_mode;"
#  archive_mode
# --------------
#  on
# (1 row)

# Check archive_command
kubectl exec -it my-postgres-0 -- psql -U myapp -d myapp -c "SHOW archive_command;"
#               archive_command  
# --------------------------------------------
#  gzip < %p > /wal-archive/%f.gz
# (1 row)

# Check archiver statistics
kubectl exec -it my-postgres-0 -- psql -U myapp -d myapp -c "SELECT * FROM pg_stat_archiver;"
```

### Check WAL Files are Being Archived

```bash
# Wait a few minutes for WAL files to accumulate
sleep 300

# List archived WAL files
kubectl exec -it my-postgres-0 -- ls -lh /wal-archive/
# -rw------- 1 postgres postgres  1.2M Jan 15 14:23 000000010000000000000001.gz
# -rw------- 1 postgres postgres  1.1M Jan 15 14:28 000000010000000000000002.gz
# -rw------- 1 postgres postgres  987K Jan 15 14:33 000000010000000000000003.gz
```

## Step 4: Test Recovery

### Create Test Data

```bash
kubectl exec -it my-postgres-0 -- psql -U myapp -d myapp <<EOF
CREATE TABLE test_recovery (
  id SERIAL PRIMARY KEY,
  created_at TIMESTAMP DEFAULT NOW(),
  data TEXT
);

INSERT INTO test_recovery (data) VALUES ('Before disaster');

SELECT * FROM test_recovery;
EOF
```

### Simulate Data Loss

```bash
kubectl exec -it my-postgres-0 -- psql -U myapp -d myapp <<EOF
-- Simulate accidental deletion
DELETE FROM test_recovery;
SELECT * FROM test_recovery;
-- (0 rows)
EOF
```

### Perform Point-in-Time Recovery

```bash
# 1. Get the time before deletion
TARGET_TIME=$(date -u -d '5 minutes ago' '+%Y-%m-%d %H:%M:%S')
echo "Recovery target: $TARGET_TIME"

# 2. Stop PostgreSQL
kubectl scale statefulset my-postgres --replicas=0

# 3. Wait for pod to terminate
kubectl wait --for=delete pod/my-postgres-0 --timeout=60s

# 4. Start PostgreSQL with recovery configuration
kubectl scale statefulset my-postgres --replicas=1

# 5. Configure recovery (once pod is running)
kubectl wait --for=condition=ready pod/my-postgres-0 --timeout=300s

kubectl exec -it my-postgres-0 -- bash <<'RECOVERY'
# Stop PostgreSQL
su - postgres -c "pg_ctl -D /var/lib/postgresql/data/pgdata stop"

# Create recovery signal
touch /var/lib/postgresql/data/pgdata/recovery.signal

# Configure recovery
cat >> /var/lib/postgresql/data/pgdata/postgresql.auto.conf <<EOF
restore_command = 'gunzip < /wal-archive/%f.gz > %p'
recovery_target_time = '$TARGET_TIME'
recovery_target_action = 'promote'
EOF

# Start PostgreSQL
su - postgres -c "pg_ctl -D /var/lib/postgresql/data/pgdata start"
RECOVERY

# 6. Verify recovery
sleep 30
kubectl exec -it my-postgres-0 -- psql -U myapp -d myapp -c "SELECT * FROM test_recovery;"
#  id |         created_at         |      data  
# ----+----------------------------+-----------------
#   1 | 2024-01-15 14:20:15.123456 | Before disaster
# (1 row)
```

## Step 5: Monitor

### Check Backup Jobs

```bash
# List CronJobs
kubectl get cronjobs
# NAME                           SCHEDULE      SUSPEND   ACTIVE
# my-postgres-backup             0 2 * * *     False     0
# my-postgres-wal-cleanup        0 3 * * *     False     0

# Check last backup job
kubectl get jobs --sort-by=.metadata.creationTimestamp | tail -5

# View backup logs
kubectl logs job/my-postgres-backup-<timestamp>
```

### Monitor WAL Archive Growth

```bash
# Check disk usage
kubectl exec -it my-postgres-0 -- df -h /wal-archive
# Filesystem      Size  Used Avail Use% Mounted on
# /dev/sdb       100G   15G   85G  15% /wal-archive

# Count archived files
kubectl exec -it my-postgres-0 -- find /wal-archive -type f | wc -l
# 2847

# Total archive size
kubectl exec -it my-postgres-0 -- du -sh /wal-archive
# 15G     /wal-archive
```

### Check Archive Statistics

```bash
kubectl exec -it my-postgres-0 -- psql -U myapp -d myapp -c "
SELECT
  archived_count,
  last_archived_wal,
  last_archived_time,
  failed_count,
  last_failed_wal,
  last_failed_time,
  stats_reset
FROM pg_stat_archiver;
"
```

## Troubleshooting

### WAL Archive Queue Growing

If `failed_count` is increasing:

```bash
# Check logs for errors
kubectl logs my-postgres-0 | grep -i archive

# Check disk space
kubectl exec -it my-postgres-0 -- df -h

# Check permissions
kubectl exec -it my-postgres-0 -- ls -la /wal-archive
```

### Archive Command Failing

```bash
# Test archive command manually
kubectl exec -it my-postgres-0 -- bash -c '
WAL_FILE=$(ls /var/lib/postgresql/data/pgdata/pg_wal/0000* | head -1)
gzip < $WAL_FILE > /wal-archive/test.gz
ls -lh /wal-archive/test.gz
rm /wal-archive/test.gz
'
```

### Recovery Not Working

```bash
# Test restore command
kubectl exec -it my-postgres-0 -- bash -c '
ARCHIVE_FILE=$(ls /wal-archive/*.gz | head -1)
gunzip < $ARCHIVE_FILE > /tmp/test-wal
file /tmp/test-wal
rm /tmp/test-wal
'
```

## Next Steps

### Optimize for Your Workload

**High-write applications**:
```yaml
postgresql:
  config:
    wal_buffers: "32MB"
    max_wal_size: "8GB"
    checkpoint_completion_target: "0.9"

backup:
  wal:
    compression: "lz4"  # Faster than gzip
    persistence:
      size: 200Gi  # More space for WAL
```

**Low-write applications**:
```yaml
postgresql:
  config:
    archive_timeout: "600"  # 10 minutes

backup:
  wal:
    compression: "gzip"  # Better compression
    retentionDays: 30  # Longer retention
```

### Add Cloud Storage

For S3/GCS/Azure storage, see [WAL_ARCHIVING.md](./WAL_ARCHIVING.md#2-wal-g-recommended-for-cloud).

### Set Up Monitoring

Enable Prometheus metrics:

```yaml
metrics:
  enabled: true

monitoring:
  enabled: true
  serviceMonitor:
    enabled: true
  prometheusRule:
    enabled: true
```

### Configure Alerts

Add alerts for:
- WAL archive failures
- Disk space low
- Recovery time objective (RTO) breaches

See [MONITORING.md](./MONITORING.md) for details.

## Summary

You now have:

✅ **Continuous incremental backups** via WAL archiving  
✅ **Daily full backups** at 2 AM  
✅ **14-day WAL retention** for PITR  
✅ **Automated cleanup** of old archives  
✅ **Production-ready configuration**

**Recovery Point Objective (RPO)**: Near-zero (continuous)  
**Recovery Time Objective (RTO)**: Minutes (depending on database size)

## Learn More

- 📖 [Complete WAL Archiving Documentation](./WAL_ARCHIVING.md)
- 📖 [Backup Strategy Guide](./README.md#backup-strategy)
- 📖 [PostgreSQL PITR Documentation](https://www.postgresql.org/docs/current/continuous-archiving.html)

## Support

Having issues? Check:

1. [Troubleshooting Section](#troubleshooting)
2. [WAL_ARCHIVING.md Troubleshooting](./WAL_ARCHIVING.md#troubleshooting)
3. [GitHub Issues](https://github.com/codefuturist/helm-charts/issues)
