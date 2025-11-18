# PostgreSQL Replication Guide

This guide covers the complete setup and management of PostgreSQL streaming replication in the Helm chart.

## Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Quick Start](#quick-start)
- [Configuration](#configuration)
- [Deployment](#deployment)
- [Monitoring](#monitoring)
- [Failover](#failover)
- [Troubleshooting](#troubleshooting)
- [Best Practices](#best-practices)

## Overview

The PostgreSQL Helm chart provides enterprise-grade streaming replication support with the following features:

- **Automated Setup**: Replicas automatically clone from primary and configure streaming replication
- **Physical Replication Slots**: Ensures WAL segments are retained for connected replicas
- **Read-Only Service**: Load-balanced endpoint for distributing read queries across replicas
- **Synchronous/Asynchronous Modes**: Choose between performance and data safety
- **Comprehensive Monitoring**: Built-in alerts for replication lag, broken connections, and slot issues
- **Hot Standby**: Replicas accept read-only queries while streaming changes

## Architecture

### Pod Layout

```
postgresql-0 (Primary)
  ├─ Accepts read/write queries
  ├─ Creates replication slots
  ├─ Streams WAL to replicas
  └─ Service: postgresql (read-write)

postgresql-1 (Replica)
  ├─ Streams WAL from primary
  ├─ Accepts read-only queries
  └─ Service: postgresql-read

postgresql-2 (Replica)
  ├─ Streams WAL from primary
  ├─ Accepts read-only queries
  └─ Service: postgresql-read
```

### Replication Flow

1. **Initial Setup** (Init Container):
   - Pod-0 detects it's primary and creates replication user + slots
   - Pods 1-N detect they're replicas and run `pg_basebackup` from primary
   - Replicas configure `standby.signal` and recovery settings

2. **Streaming Replication**:
   - Replicas connect to primary using replication protocol
   - WAL changes stream continuously to replicas
   - Replicas apply changes and update replay position

3. **Read Distribution**:
   - Primary service (`postgresql`) routes to pod-0 for writes
   - Replica service (`postgresql-read`) load-balances reads across pods 1-N

## Quick Start

### Basic Asynchronous Replication

Deploy a primary with 2 read replicas:

```yaml
# values-replication-basic.yaml
replication:
  enabled: true
  readReplicas: 2
  user: replicator
  password: "changeme-replication"

persistence:
  enabled: true
  size: 10Gi
```

```bash
helm install my-postgres ./postgresql -f values-replication-basic.yaml
```

### Synchronous Replication (Zero Data Loss)

For critical workloads requiring zero data loss:

```yaml
# values-replication-sync.yaml
replication:
  enabled: true
  readReplicas: 2
  user: replicator
  password: "changeme-replication"
  synchronousCommit: "on"
  numSynchronousReplicas: 1  # Wait for 1 replica to confirm

persistence:
  enabled: true
  size: 10Gi
```

### High Availability Setup

Full HA configuration with monitoring:

```yaml
# values-replication-ha.yaml
replication:
  enabled: true
  readReplicas: 3
  user: replicator
  password: "changeme-replication"
  synchronousCommit: "remote_write"
  numSynchronousReplicas: 1

  # Replication slots for reliability
  slots:
    enabled: true
    autoCreate: true

  # Read-only service
  replicaService:
    enabled: true
    type: LoadBalancer
    sessionAffinity: true

  # Monitoring
  monitoring:
    enabled: true
    lagThresholdSeconds: 30
    lagThresholdBytes: 100

# Enable monitoring
monitoring:
  serviceMonitor:
    enabled: true
  prometheusRule:
    enabled: true

persistence:
  enabled: true
  size: 20Gi
  storageClass: fast-ssd
```

## Configuration

### Replication Settings

#### Basic Settings

```yaml
replication:
  enabled: true                    # Enable replication
  readReplicas: 2                  # Number of read replicas (pods 1-N)
  user: replicator                 # Replication user name
  password: "changeme"             # Replication user password (use secret!)
  existingSecret: ""               # Use existing secret for password
```

#### Replication Slots

Physical replication slots ensure WAL segments aren't removed while replicas need them:

```yaml
replication:
  slots:
    enabled: true                  # Use replication slots
    autoCreate: true               # Automatically create slots for replicas
    prefix: "replica"              # Slot name prefix (creates replica_1, replica_2, etc.)
```

#### Synchronous vs Asynchronous

**Asynchronous (Default)**:
```yaml
replication:
  synchronousCommit: "off"         # Don't wait for replica confirmation
```
- **Pros**: Best performance, writes complete immediately
- **Cons**: Possible data loss on primary failure
- **Use case**: Development, analytics, non-critical workloads

**Synchronous**:
```yaml
replication:
  synchronousCommit: "on"          # Wait for replica to write and flush to disk
  numSynchronousReplicas: 1        # Number of replicas that must confirm
```
- **Pros**: Zero data loss, confirmed writes are durable
- **Cons**: Higher write latency, depends on replica availability
- **Use case**: Financial transactions, critical data

**Remote Write** (Recommended for HA):
```yaml
replication:
  synchronousCommit: "remote_write"  # Wait for replica to receive and write (not flush)
  numSynchronousReplicas: 1
```
- **Pros**: Balance between safety and performance
- **Cons**: Very small data loss window if replica crashes
- **Use case**: Production HA setups

#### Replica Configuration

Fine-tune replica behavior:

```yaml
replication:
  replica:
    hotStandbyFeedback: true       # Send feedback to prevent query conflicts
    maxStandbyStreamingDelay: 30s  # Max delay before canceling conflicting queries
    walReceiverStatusInterval: 10s # How often to report replay position
    walReceiverTimeout: 60s        # Timeout for receiving WAL
```

#### Read-Only Service

Load-balanced service for read queries:

```yaml
replication:
  replicaService:
    enabled: true
    type: ClusterIP                # ClusterIP, LoadBalancer, or NodePort
    port: 5432
    sessionAffinity: true          # Stick client connections to same replica
    sessionAffinityTimeout: 10800  # 3 hours
    annotations: {}
```

Access pattern:
```bash
# Write to primary
psql -h postgresql.default.svc.cluster.local -U postgres

# Read from replicas
psql -h postgresql-read.default.svc.cluster.local -U postgres
```

#### Monitoring & Alerts

```yaml
replication:
  monitoring:
    enabled: true
    scrapeInterval: 30s
    lagThresholdSeconds: 60        # Alert if replica is >60s behind
    lagThresholdBytes: 100         # Alert if replica is >100MB behind
    alertFor: 5m                   # Alert after threshold exceeded for 5 min
```

#### Advanced Settings

```yaml
replication:
  advanced:
    maxWalSenders: 10              # Max concurrent WAL sender processes
    maxReplicationSlots: 10        # Max replication slots
    walKeepSize: "1GB"             # Minimum WAL to retain on primary
```

## Deployment

### Step-by-Step Deployment

1. **Create values file**:
```bash
cat > values-my-replication.yaml <<EOF
replication:
  enabled: true
  readReplicas: 2
  password: "$(openssl rand -base64 32)"

  slots:
    enabled: true
    autoCreate: true

  replicaService:
    enabled: true

persistence:
  enabled: true
  size: 10Gi
EOF
```

2. **Deploy**:
```bash
helm install postgres ./postgresql -f values-my-replication.yaml
```

3. **Watch pods start**:
```bash
kubectl get pods -l app.kubernetes.io/name=postgresql -w
```

Expected sequence:
- `postgresql-0`: Starts first (primary)
- `postgresql-1`: Clones from postgresql-0, starts streaming
- `postgresql-2`: Clones from postgresql-0, starts streaming

4. **Verify replication**:
```bash
# Check on primary
kubectl exec postgresql-0 -- psql -U postgres -c "SELECT * FROM pg_stat_replication;"

# Check on replica
kubectl exec postgresql-1 -- psql -U postgres -c "SELECT pg_is_in_recovery();"
```

### Scaling Replicas

Add more replicas:
```bash
# Update values
helm upgrade postgres ./postgresql --set replication.readReplicas=3

# New pods will automatically clone and start replicating
kubectl get pods -w
```

Remove replicas:
```bash
# Scale down (removes highest numbered pods)
helm upgrade postgres ./postgresql --set replication.readReplicas=1

# Manually clean up replication slots if needed
kubectl exec postgresql-0 -- psql -U postgres -c "SELECT pg_drop_replication_slot('replica_3');"
```

## Monitoring

### Replication Status

**On Primary** - View all connected replicas:
```bash
kubectl exec postgresql-0 -- psql -U postgres -c "
SELECT
  application_name,
  client_addr,
  state,
  sync_state,
  pg_wal_lsn_diff(pg_current_wal_lsn(), replay_lsn) AS lag_bytes,
  replay_lag
FROM pg_stat_replication;
"
```

Output:
```
 application_name | client_addr |   state   | sync_state | lag_bytes | replay_lag
------------------+-------------+-----------+------------+-----------+------------
 replica_1        | 10.244.1.3  | streaming | async      |         0 | 00:00:00
 replica_2        | 10.244.1.4  | streaming | async      |         0 | 00:00:00
```

**On Replica** - View replication lag:
```bash
kubectl exec postgresql-1 -- psql -U postgres -c "
SELECT
  pg_is_in_recovery() AS is_replica,
  pg_last_wal_receive_lsn() AS last_received,
  pg_last_wal_replay_lsn() AS last_applied,
  pg_wal_lsn_diff(pg_last_wal_receive_lsn(), pg_last_wal_replay_lsn()) AS lag_bytes;
"
```

### Using Replication Scripts

The chart includes helpful scripts mounted in each pod:

```bash
# Check replication status
kubectl exec postgresql-0 -- /scripts/replication-status.sh

# Health check (exits 0 if healthy)
kubectl exec postgresql-1 -- /scripts/check-replication.sh
```

### Prometheus Metrics

When monitoring is enabled, replication metrics are exposed:

- `pg_stat_replication_state`: Replication connection state (1=streaming, 0=disconnected)
- `pg_stat_replication_replay_lag_bytes`: Bytes behind primary
- `pg_replication_lag`: Seconds behind primary
- `pg_replication_slots_active`: Slot active status

### Grafana Dashboard

Import the replication dashboard (included in chart) for visual monitoring:

- Replication lag over time
- Replica health status
- WAL sender activity
- Slot disk usage

## Failover

### Manual Failover

If the primary fails, promote a replica:

1. **Stop the primary** (if still running):
```bash
kubectl delete pod postgresql-0
```

2. **Promote a replica**:
```bash
# Connect to replica
kubectl exec -it postgresql-1 -- bash

# Promote to primary
pg_ctl promote -D /var/lib/postgresql/data/pgdata
```

3. **Update other replicas** to point to new primary:
```bash
# On each remaining replica
kubectl exec postgresql-2 -- psql -U postgres -c "
ALTER SYSTEM SET primary_conninfo = 'host=postgresql-1.postgresql-headless.default.svc.cluster.local port=5432 user=replicator password=changeme';
SELECT pg_reload_conf();
"
```

4. **Update application connection** to point to new primary.

### Automatic Failover (Future)

For automatic failover, consider integrating:
- **Patroni**: Distributed consensus-based failover
- **Stolon**: Kubernetes-native HA manager
- **pg_auto_failover**: PostgreSQL extension for automatic failover

These tools handle:
- Automatic leader election
- Replica promotion
- Service endpoint updates
- Split-brain prevention

## Troubleshooting

### Replica Not Starting

**Symptom**: Replica pod in CrashLoopBackOff

**Check logs**:
```bash
kubectl logs postgresql-1
```

**Common causes**:
1. Primary not ready:
   ```bash
   kubectl exec postgresql-0 -- pg_isready
   ```

2. Replication password incorrect:
   ```bash
   kubectl get secret postgresql -o jsonpath='{.data.replication-password}' | base64 -d
   ```

3. Network connectivity:
   ```bash
   kubectl exec postgresql-1 -- nc -zv postgresql-0.postgresql-headless 5432
   ```

### Replication Lag

**Symptom**: Replica falling behind primary

**Check lag**:
```bash
kubectl exec postgresql-0 -- psql -U postgres -c "
SELECT application_name, pg_wal_lsn_diff(pg_current_wal_lsn(), replay_lsn) AS lag_bytes
FROM pg_stat_replication;
"
```

**Common causes**:
1. **Heavy query load on replica**: Queries blocking WAL replay
   - Increase `max_standby_streaming_delay`
   - Enable `hot_standby_feedback: true`

2. **Network bandwidth**: WAL streaming slower than generation
   - Check network between pods
   - Consider synchronous replication

3. **Disk I/O**: Replica disk too slow
   - Upgrade storage class
   - Monitor disk performance

### Replication Slot Filling Disk

**Symptom**: Primary disk usage growing, `wal_keep_size` exceeded

**Check slots**:
```bash
kubectl exec postgresql-0 -- psql -U postgres -c "
SELECT slot_name, active, restart_lsn,
       pg_wal_lsn_diff(pg_current_wal_lsn(), restart_lsn) AS retained_bytes
FROM pg_replication_slots;
"
```

**Solutions**:
1. **Inactive slot** (replica down):
   ```sql
   SELECT pg_drop_replication_slot('replica_2');
   ```

2. **Stuck replica**:
   ```bash
   # Restart replica
   kubectl delete pod postgresql-2
   ```

3. **Increase WAL retention**:
   ```yaml
   replication:
     advanced:
       walKeepSize: "2GB"  # Increase if needed
   ```

### Split-Brain Scenario

**Symptom**: Multiple pods think they're primary

**Prevention**:
- Use replication slots (enabled by default)
- Deploy only 1 primary (pod-0)
- Use StatefulSet (guarantees ordered startup)

**Recovery**:
1. Identify the true primary (most recent WAL position)
2. Shut down other "primaries"
3. Re-clone from true primary:
   ```bash
   kubectl exec postgresql-1 -- bash -c "rm -rf /var/lib/postgresql/data/pgdata/* && /scripts/setup-replication.sh"
   ```

## Best Practices

### Production Recommendations

1. **Use Replication Slots**:
   ```yaml
   replication:
     slots:
       enabled: true
       autoCreate: true
   ```
   Prevents WAL deletion while replica is catching up.

2. **Deploy at least 3 replicas** for HA:
   ```yaml
   replication:
     readReplicas: 2  # Total of 3 pods (1 primary + 2 replicas)
   ```

3. **Use Synchronous Replication** for critical data:
   ```yaml
   replication:
     synchronousCommit: "remote_write"
     numSynchronousReplicas: 1
   ```

4. **Enable Monitoring**:
   ```yaml
   replication:
     monitoring:
       enabled: true
   monitoring:
     serviceMonitor:
       enabled: true
     prometheusRule:
       enabled: true
   ```

5. **Separate Read/Write Services**:
   ```yaml
   replication:
     replicaService:
       enabled: true
   ```
   Route reads to `postgresql-read`, writes to `postgresql`.

6. **Use Fast Storage**:
   ```yaml
   persistence:
     storageClass: fast-ssd  # Use SSD-backed storage
     size: 50Gi
   ```

7. **Enable Hot Standby Feedback**:
   ```yaml
   replication:
     replica:
       hotStandbyFeedback: true
   ```
   Reduces query cancellations on replicas.

8. **Set Resource Limits**:
   ```yaml
   deployment:
     resources:
       requests:
         memory: "2Gi"
         cpu: "1000m"
       limits:
         memory: "4Gi"
         cpu: "2000m"
   ```

9. **Regular Backups** (replication is NOT backup):
   ```yaml
   backup:
     wal:
       enabled: true
       method: wal-g
   ```

10. **Test Failover Procedures** regularly:
    ```bash
    # Simulate primary failure
    kubectl delete pod postgresql-0 --grace-period=0 --force

    # Verify replicas continue serving reads
    kubectl exec postgresql-1 -- psql -U postgres -c "SELECT 1"
    ```

### Development Recommendations

For development/test environments:

```yaml
replication:
  enabled: true
  readReplicas: 1                  # Just 1 replica
  synchronousCommit: "off"         # Async for speed

  slots:
    enabled: false                 # Don't need slots in dev

  monitoring:
    enabled: false                 # Skip monitoring in dev

persistence:
  enabled: false                   # Use emptyDir for speed
```

### Scaling Recommendations

| Workload | Replicas | Sync Mode | Use Case |
|----------|----------|-----------|----------|
| Development | 0-1 | async | Local testing |
| Staging | 1-2 | async | Pre-production validation |
| Production (Low) | 2 | remote_write | Standard production |
| Production (High) | 3-4 | remote_write | High availability |
| Production (Critical) | 3-5 | on | Financial/critical data |

## Next Steps

- [WAL Archiving Guide](WAL_ARCHIVING.md) - Enable continuous archiving with replication
- [Recovery Guide](RECOVERY_GUIDE.md) - Restore backups and perform PITR
- [Monitoring Guide](README.md#monitoring) - Set up comprehensive monitoring
- [Architecture](ARCHITECTURE.md) - Understand the chart design

## Support

For issues or questions:
- Open an issue on GitHub
- Check existing examples in `examples/values-replication-*.yaml`
- Review PostgreSQL replication docs: https://www.postgresql.org/docs/current/warm-standby.html
