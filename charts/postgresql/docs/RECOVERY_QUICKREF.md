# PostgreSQL Recovery - Quick Reference

One-page cheat sheet for common recovery operations.

## 🚀 Quick Recovery Commands

### Interactive Recovery (Easiest)
```bash
cd charts/postgresql
./scripts/recover.sh recover my-postgres
```

### Full Restore (Latest Backup)
```bash
./scripts/recover.sh recover-full my-postgres
```

### Full Restore (Specific Backup)
```bash
./scripts/recover.sh recover-full my-postgres default backup-2024-11-12-02-00-00.sql.gz
```

### Point-in-Time Recovery
```bash
# Restore to 30 minutes ago
TARGET=$(date -u -d '30 minutes ago' '+%Y-%m-%d %H:%M:%S')
./scripts/recover.sh recover-pitr my-postgres "$TARGET"

# Restore to specific time
./scripts/recover.sh recover-pitr my-postgres "2024-11-12 14:30:00"
```

## 📋 Utility Commands

### List Available Backups
```bash
./scripts/recover.sh list my-postgres
```

### Check Recovery Status
```bash
./scripts/recover.sh status my-postgres
```

### View Recovery Logs
```bash
./scripts/recover.sh logs my-postgres
```

## 📝 Common Scenarios

| Scenario | Command |
|----------|---------|
| **Accidental deletion** | `./scripts/recover.sh recover-pitr my-postgres "$(date -u -d '1 hour ago' '+%Y-%m-%d %H:%M:%S')"` |
| **Database corruption** | `./scripts/recover.sh recover-full my-postgres` |
| **Failed migration** | `./scripts/recover.sh recover-pitr my-postgres "2024-11-12 09:59:00"` |
| **Test data in prod** | `./scripts/recover.sh recover-pitr my-postgres "[time before script]"` |
| **Restore yesterday** | `./scripts/recover.sh recover-full my-postgres default backup-$(date -d yesterday +%Y-%m-%d)-02-00-00.sql.gz` |

## 🔧 Helm-Based Recovery

### Full Restore
```yaml
# recovery-values.yaml
recovery:
  enabled: true
  mode: "full"
  source: "backup"
```

```bash
helm upgrade my-postgres . -f recovery-values.yaml
kubectl logs -f job/my-postgres-postgresql-recovery
```

### PITR Restore
```yaml
# pitr-values.yaml
recovery:
  enabled: true
  mode: "pitr"
  source: "backup"
  targetTime: "2024-11-12 14:30:00"

backup:
  wal:
    enabled: true
```

```bash
helm upgrade my-postgres . -f pitr-values.yaml
kubectl logs -f job/my-postgres-postgresql-recovery
```

## 🐛 Troubleshooting

### Recovery Job Failed
```bash
# Check job status
kubectl get job my-postgres-postgresql-recovery

# View logs
kubectl logs job/my-postgres-postgresql-recovery

# Delete and retry
kubectl delete job my-postgres-postgresql-recovery
helm upgrade my-postgres . -f recovery-values.yaml
```

### No Backups Found
```bash
# Check backup PVC
POD=$(kubectl get pod -l app.kubernetes.io/instance=my-postgres -o name | head -1)
kubectl exec $POD -- ls -lht /backups/

# Verify backup CronJob
kubectl get cronjob
kubectl get jobs | grep backup
```

### Out of Disk Space
```yaml
# Increase temp storage
recovery:
  tempStorageSize: "100Gi"  # Increase from 50Gi
```

### Wrong Time Zone
```bash
# Always use UTC
date -u  # Current UTC time

# Convert local to UTC
date -u -d "2024-11-12 14:30:00 EST" '+%Y-%m-%d %H:%M:%S'
```

## ✅ Verification After Recovery

### Check PostgreSQL is Running
```bash
kubectl get pods
kubectl logs my-postgres-0
```

### Verify Data
```bash
# Connect to database
kubectl exec -it my-postgres-0 -- psql -U postgres

# Check tables
\dt

# Check row counts
SELECT schemaname, tablename, n_live_tup
FROM pg_stat_user_tables
ORDER BY n_live_tup DESC;

# Check recent data
SELECT * FROM your_table ORDER BY created_at DESC LIMIT 10;
```

### Test Queries
```bash
# Run application queries
kubectl exec -it my-postgres-0 -- psql -U postgres -d mydb -c "
  SELECT count(*) FROM users WHERE created_at > NOW() - INTERVAL '7 days';
"
```

## 🎯 Best Practices

1. **Test Monthly**: Run recovery tests in separate namespace
2. **Document**: Record target times and reasons
3. **Verify**: Always check data after recovery
4. **Disable**: Turn off recovery mode after completion
5. **Monitor**: Track recovery times for RTO planning

## 📚 More Information

- **Full Guide**: [RECOVERY_GUIDE.md](./RECOVERY_GUIDE.md)
- **WAL Archiving**: [WAL_ARCHIVING.md](./WAL_ARCHIVING.md)
- **Backup Config**: [README.md#backup-configuration](./README.md#backup-configuration)

## 🆘 Quick Help

```bash
# Recovery script help
./scripts/recover.sh help

# List all commands
./scripts/recover.sh
```

---

**Recovery Time Estimates:**

| Database Size | Full Recovery | PITR Recovery |
|---------------|---------------|---------------|
| 1 GB | ~2 minutes | ~3 minutes |
| 10 GB | ~5 minutes | ~8 minutes |
| 100 GB | ~25 minutes | ~35 minutes |
| 1 TB | ~3 hours | ~4 hours |

**Note:** Times vary based on hardware, storage speed, and WAL volume.
