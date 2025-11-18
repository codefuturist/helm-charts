# PostgreSQL Recovery Guide

Easy-to-use recovery methods for restoring your PostgreSQL database from backups.

## Table of Contents

1. [Quick Recovery](#quick-recovery)
2. [Recovery Methods](#recovery-methods)
3. [Recovery Script](#recovery-script)
4. [Manual Recovery](#manual-recovery)
5. [Helm-Based Recovery](#helm-based-recovery)
6. [Common Scenarios](#common-scenarios)
7. [Troubleshooting](#troubleshooting)

## Quick Recovery

### Method 1: Interactive Recovery Script (Easiest) ⭐

```bash
# Navigate to chart directory
cd charts/postgresql

# Run interactive recovery wizard
./scripts/recover.sh recover my-postgres

# Follow the prompts:
# 1. Choose recovery type (full or PITR)
# 2. Select backup file (or use latest)
# 3. Confirm recovery
```

### Method 2: One-Line Full Recovery

```bash
# Recover from latest backup
./scripts/recover.sh recover-full my-postgres

# Recover from specific backup
./scripts/recover.sh recover-full my-postgres default backup-2024-11-12-02-00-00.sql.gz
```

### Method 3: Point-in-Time Recovery

```bash
# Recover to specific point in time
./scripts/recover.sh recover-pitr my-postgres "2024-11-12 14:30:00"
```

## Recovery Methods

### Available Recovery Options

| Method | Use Case | Requirements | Recovery Time |
|--------|----------|--------------|---------------|
| **Full Backup** | Complete restore | Backup PVC | 5-30 minutes |
| **Point-in-Time (PITR)** | Restore to exact moment | Backup PVC + WAL archives | 10-45 minutes |
| **S3 Recovery** | Cloud backup restore | S3 bucket + credentials | 10-60 minutes |

## Recovery Script

### Installation

The recovery script is included in `scripts/recover.sh`. Make it executable:

```bash
chmod +x scripts/recover.sh
```

### Commands

#### List Available Backups

```bash
./scripts/recover.sh list <release-name> [namespace]

# Example
./scripts/recover.sh list my-postgres
./scripts/recover.sh list my-postgres production
```

**Output:**
```
ℹ Available backups:

-rw-r--r-- 1 postgres postgres 125M Nov 12 02:00 backup-2024-11-12-02-00-00.sql.gz
-rw-r--r-- 1 postgres postgres 123M Nov 11 02:00 backup-2024-11-11-02-00-00.sql.gz
-rw-r--r-- 1 postgres postgres 121M Nov 10 02:00 backup-2024-11-10-02-00-00.sql.gz
```

#### Interactive Recovery

```bash
./scripts/recover.sh recover <release-name> [namespace]

# Example
./scripts/recover.sh recover my-postgres
```

**Interactive Prompts:**
1. **Recovery type selection**: Full or PITR
2. **Backup selection**: Choose specific backup or use latest
3. **Confirmation**: Review and confirm recovery
4. **Monitoring**: Shows job progress

#### Full Backup Recovery

```bash
./scripts/recover.sh recover-full <release-name> [namespace] [backup-file]

# Latest backup
./scripts/recover.sh recover-full my-postgres

# Specific backup
./scripts/recover.sh recover-full my-postgres default backup-2024-11-12-02-00-00.sql.gz

# Different namespace
./scripts/recover.sh recover-full my-postgres production backup-2024-11-12-02-00-00.sql.gz
```

#### Point-in-Time Recovery (PITR)

```bash
./scripts/recover.sh recover-pitr <release-name> <target-time> [namespace] [backup-file]

# Recover to specific time (latest backup)
./scripts/recover.sh recover-pitr my-postgres "2024-11-12 14:30:00"

# Recover to specific time (specific backup)
./scripts/recover.sh recover-pitr my-postgres "2024-11-12 14:30:00" default backup-2024-11-12-02-00-00.sql.gz

# Different namespace
./scripts/recover.sh recover-pitr my-postgres "2024-11-12 14:30:00" production
```

**Time Format:** `YYYY-MM-DD HH:MM:SS` (UTC)

#### Check Recovery Status

```bash
./scripts/recover.sh status <release-name> [namespace]

# Example
./scripts/recover.sh status my-postgres
```

**Output:**
```
✓ Recovery completed successfully!
```

or

```
ℹ Recovery in progress...
```

#### View Recovery Logs

```bash
./scripts/recover.sh logs <release-name> [namespace]

# Example
./scripts/recover.sh logs my-postgres
```

**Output:**
```
============================================
PostgreSQL Recovery Preparation
============================================

Recovery Mode: full
Recovery Source: backup

Step 1: Restoring from full backup...
Using backup: backup-2024-11-12-02-00-00.sql.gz
Backup size: 125M
Extracting backup...
✓ Backup extracted successfully

============================================
Recovery preparation completed successfully
============================================
```

## Manual Recovery

### Using kubectl Directly

#### 1. List Backups

```bash
RELEASE="my-postgres"
NAMESPACE="default"
POD=$(kubectl get pod -n $NAMESPACE -l app.kubernetes.io/instance=$RELEASE -o jsonpath='{.items[0].metadata.name}')

kubectl exec -n $NAMESPACE $POD -- ls -lht /backups/
```

#### 2. Copy Backup Locally (Optional)

```bash
kubectl cp $NAMESPACE/$POD:/backups/backup-2024-11-12-02-00-00.sql.gz ./backup.sql.gz
```

#### 3. Stop PostgreSQL

```bash
kubectl scale statefulset $RELEASE-postgresql --replicas=0 -n $NAMESPACE
```

#### 4. Start Recovery Pod

```bash
kubectl run -n $NAMESPACE postgres-recovery \
  --image=postgres:16.4-alpine \
  --restart=Never \
  --overrides='
{
  "spec": {
    "containers": [{
      "name": "postgres-recovery",
      "image": "postgres:16.4-alpine",
      "command": ["sleep", "3600"],
      "volumeMounts": [{
        "name": "backup",
        "mountPath": "/backups"
      }]
    }],
    "volumes": [{
      "name": "backup",
      "persistentVolumeClaim": {
        "claimName": "'$RELEASE'-postgresql-backup"
      }
    }]
  }
}'
```

#### 5. Restore Database

```bash
kubectl exec -n $NAMESPACE postgres-recovery -- bash -c '
  # Extract backup
  gunzip -c /backups/backup-2024-11-12-02-00-00.sql.gz > /tmp/restore.sql

  # Initialize PostgreSQL
  initdb -D /tmp/pgdata -U postgres

  # Start PostgreSQL
  pg_ctl -D /tmp/pgdata -l /tmp/logfile start

  # Restore
  psql -U postgres -d postgres -f /tmp/restore.sql

  # Stop PostgreSQL
  pg_ctl -D /tmp/pgdata stop
'
```

#### 6. Copy Recovered Data

```bash
# Copy from recovery pod to data PVC
kubectl exec -n $NAMESPACE $POD -- bash -c '
  rm -rf /var/lib/postgresql/data/pgdata/*
  cp -a /tmp/pgdata/* /var/lib/postgresql/data/pgdata/
'
```

#### 7. Restart PostgreSQL

```bash
kubectl scale statefulset $RELEASE-postgresql --replicas=1 -n $NAMESPACE
```

#### 8. Cleanup

```bash
kubectl delete pod -n $NAMESPACE postgres-recovery
```

## Helm-Based Recovery

### Full Backup Recovery

Create `recovery-values.yaml`:

```yaml
recovery:
  enabled: true
  mode: "full"
  source: "backup"
  backupFile: ""  # Leave empty for latest
  tempStorageSize: "50Gi"
```

Apply recovery:

```bash
helm upgrade my-postgres . -n default -f recovery-values.yaml
```

### Point-in-Time Recovery

Create `pitr-values.yaml`:

```yaml
recovery:
  enabled: true
  mode: "pitr"
  source: "backup"
  targetTime: "2024-11-12 14:30:00"
  backupFile: ""  # Leave empty for latest
  tempStorageSize: "50Gi"

backup:
  wal:
    enabled: true
```

Apply recovery:

```bash
helm upgrade my-postgres . -n default -f pitr-values.yaml
```

### Monitor Recovery

```bash
# Watch job
kubectl get jobs -w

# View logs
kubectl logs -f job/my-postgres-postgresql-recovery

# Check completion
kubectl get job my-postgres-postgresql-recovery
```

### Disable Recovery Mode

After successful recovery, disable recovery mode:

```yaml
recovery:
  enabled: false
```

```bash
helm upgrade my-postgres . -n default -f values.yaml
```

## Common Scenarios

### Scenario 1: Accidental Data Deletion

**Problem:** Accidentally deleted important data 30 minutes ago.

**Solution:** Point-in-Time Recovery

```bash
# Calculate target time (30 minutes ago)
TARGET_TIME=$(date -u -d '30 minutes ago' '+%Y-%m-%d %H:%M:%S')

# Recover
./scripts/recover.sh recover-pitr my-postgres "$TARGET_TIME"
```

### Scenario 2: Database Corruption

**Problem:** Database corrupted, need to restore from last good backup.

**Solution:** Full Backup Recovery

```bash
# List backups
./scripts/recover.sh list my-postgres

# Recover from latest
./scripts/recover.sh recover-full my-postgres

# Or specific backup
./scripts/recover.sh recover-full my-postgres default backup-2024-11-11-02-00-00.sql.gz
```

### Scenario 3: Ransomware Attack

**Problem:** Database encrypted by ransomware.

**Solution:** Recover from backup before attack

```bash
# Determine attack time: 2024-11-12 13:00:00
# Use backup from before that time

./scripts/recover.sh recover-pitr my-postgres "2024-11-12 12:50:00"
```

### Scenario 4: Failed Migration

**Problem:** Database migration failed, need to rollback.

**Solution:** Recover to point before migration

```bash
# Migration started at 2024-11-12 15:00:00
# Recover to just before

./scripts/recover.sh recover-pitr my-postgres "2024-11-12 14:59:00"
```

### Scenario 5: Test Data in Production

**Problem:** Accidentally ran test script against production database.

**Solution:** PITR to before the mistake

```bash
# Script ran at 2024-11-12 16:30:00
./scripts/recover.sh recover-pitr my-postgres "2024-11-12 16:29:00"
```

### Scenario 6: Disaster Recovery

**Problem:** Entire cluster lost, need to restore from S3.

**Solution:** S3 Recovery

```yaml
recovery:
  enabled: true
  mode: "full"
  source: "s3"
  tempStorageSize: "100Gi"

backup:
  s3:
    enabled: true
    bucket: "my-postgres-backups"
    region: "us-east-1"
    existingSecret: "postgres-backup-s3"
```

```bash
helm install my-postgres . -f disaster-recovery-values.yaml
```

## Troubleshooting

### Recovery Job Fails

**Check job status:**
```bash
kubectl get job my-postgres-postgresql-recovery
```

**View logs:**
```bash
kubectl logs job/my-postgres-postgresql-recovery
```

**Common errors:**

1. **No backup found**
   ```
   ERROR: No backup file found!
   ```
   **Solution:** Check backup PVC has files:
   ```bash
   kubectl exec $POD -- ls -l /backups/
   ```

2. **Out of space**
   ```
   ERROR: No space left on device
   ```
   **Solution:** Increase `recovery.tempStorageSize`:
   ```yaml
   recovery:
     tempStorageSize: "100Gi"  # Increase this
   ```

3. **WAL files missing**
   ```
   WARNING: No WAL files found. PITR may not work.
   ```
   **Solution:** Check WAL archive PVC:
   ```bash
   kubectl exec $POD -- ls -l /wal-archive/
   ```

### Recovery Hangs

**Check pod status:**
```bash
kubectl get pods | grep recovery
```

**Check events:**
```bash
kubectl get events --sort-by='.lastTimestamp' | grep recovery
```

**Force restart:**
```bash
kubectl delete job my-postgres-postgresql-recovery
helm upgrade my-postgres . -f recovery-values.yaml
```

### Wrong Backup Restored

**Solution:** Re-run recovery with correct backup:
```bash
./scripts/recover.sh recover-full my-postgres default backup-2024-11-11-02-00-00.sql.gz
```

### PITR Target Time Out of Range

**Error:**
```
ERROR: Target time is outside available WAL range
```

**Solution:**
1. Check WAL retention:
   ```bash
   kubectl exec $POD -- ls -l /wal-archive/ | head -1
   kubectl exec $POD -- ls -l /wal-archive/ | tail -1
   ```

2. Use time within WAL range or use full backup recovery

### Verification Failed

**Check database after recovery:**
```bash
kubectl exec -it my-postgres-0 -- psql -U postgres -c "SELECT version();"
kubectl exec -it my-postgres-0 -- psql -U postgres -c "\dt"
kubectl exec -it my-postgres-0 -- psql -U postgres -c "SELECT count(*) FROM your_table;"
```

## Best Practices

### 1. Test Recovery Monthly

Schedule regular recovery tests:

```bash
# Create test namespace
kubectl create namespace postgres-recovery-test

# Test recovery
./scripts/recover.sh recover-full test-postgres postgres-recovery-test

# Verify
kubectl exec -n postgres-recovery-test test-postgres-0 -- psql -U postgres -c "\dt"

# Cleanup
kubectl delete namespace postgres-recovery-test
```

### 2. Document Target Times

When performing PITR, document the reason:

```bash
# Good
./scripts/recover.sh recover-pitr my-postgres "2024-11-12 14:30:00"
echo "Recovered due to accidental deletion at 14:31" >> recovery-log.txt

# Better - use ticket number
./scripts/recover.sh recover-pitr my-postgres "2024-11-12 14:30:00"
echo "Recovered for incident INC-12345" >> recovery-log.txt
```

### 3. Verify After Recovery

Always verify data integrity:

```bash
# Check row counts
kubectl exec -it my-postgres-0 -- psql -U postgres -d mydb -c "
  SELECT
    schemaname,
    tablename,
    n_live_tup as row_count
  FROM pg_stat_user_tables
  ORDER BY n_live_tup DESC;
"

# Check recent data
kubectl exec -it my-postgres-0 -- psql -U postgres -d mydb -c "
  SELECT * FROM your_table
  ORDER BY created_at DESC
  LIMIT 10;
"
```

### 4. Keep Recovery Scripts Updated

Update scripts with your chart:

```bash
git pull origin main
chmod +x scripts/recover.sh
```

### 5. Monitor Recovery Time

Track recovery times to plan RTO:

```bash
START=$(date +%s)
./scripts/recover.sh recover-full my-postgres
END=$(date +%s)
DURATION=$((END - START))
echo "Recovery took $DURATION seconds" >> recovery-metrics.txt
```

## Additional Resources

- [WAL Archiving Documentation](./WAL_ARCHIVING.md)
- [Backup Configuration](./README.md#backup-configuration)
- [PostgreSQL PITR](https://www.postgresql.org/docs/current/continuous-archiving.html)
- [Recovery Script Source](./scripts/recover.sh)

## Support

For issues or questions:

1. Check [Troubleshooting](#troubleshooting) section
2. Review logs: `kubectl logs job/my-postgres-postgresql-recovery`
3. Open issue: [GitHub Issues](https://github.com/codefuturist/helm-charts/issues)
