# Restic Backup Chart - Architecture

## Overview

This Helm chart provides a complete backup solution for Kubernetes workloads using restic, a fast, secure, and efficient backup program. The architecture is designed for production use with emphasis on reliability, security, and operational simplicity.

## Architecture Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                        Kubernetes Cluster                        │
│                                                                  │
│  ┌────────────────────────────────────────────────────────────┐ │
│  │                    Backup Namespace                         │ │
│  │                                                             │ │
│  │  ┌──────────────────┐      ┌───────────────────┐         │ │
│  │  │  CronJob: Backup │─────▶│  Job: Backup Pod  │         │ │
│  │  │  Schedule: Daily │      │  ┌──────────────┐ │         │ │
│  │  └──────────────────┘      │  │ Restic       │ │         │ │
│  │                             │  │ Container    │ │         │ │
│  │  ┌──────────────────┐      │  └──────────────┘ │         │ │
│  │  │  CronJob: Check  │      │        ▲          │         │ │
│  │  │  Schedule: Weekly│      │        │          │         │ │
│  │  └──────────────────┘      │        │ Mount    │         │ │
│  │                             │        │          │         │ │
│  │  ┌──────────────────┐      │  ┌─────▼────────┐ │         │ │
│  │  │  Job: Init       │      │  │   PVC(s)     │ │         │ │
│  │  │  (Helm Hook)     │      │  │  to Backup   │ │         │ │
│  │  └──────────────────┘      │  └──────────────┘ │         │ │
│  │                             └───────────────────┘         │ │
│  │                                                             │ │
│  │  ┌──────────────────┐      ┌───────────────────┐         │ │
│  │  │  ServiceAccount  │      │  Secret           │         │ │
│  │  │  + RBAC          │      │  Credentials      │         │ │
│  │  └──────────────────┘      └───────────────────┘         │ │
│  │                                                             │ │
│  │  ┌──────────────────┐                                     │ │
│  │  │  NetworkPolicy   │                                     │ │
│  │  │  (Optional)      │                                     │ │
│  │  └──────────────────┘                                     │ │
│  └────────────────────────────────────────────────────────────┘ │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
                               │
                               │ Encrypted Connection
                               ▼
                   ┌──────────────────────┐
                   │  Storage Backend     │
                   │  ┌────────────────┐  │
                   │  │  S3 / Azure /  │  │
                   │  │  GCS / B2 /    │  │
                   │  │  SFTP / Local  │  │
                   │  └────────────────┘  │
                   │                      │
                   │  ┌────────────────┐  │
                   │  │  Encrypted     │  │
                   │  │  Snapshots     │  │
                   │  └────────────────┘  │
                   └──────────────────────┘
```

## Components

### 1. CronJob: Backup

**Purpose**: Scheduled execution of backup operations

**Key Features**:

- Configurable schedule (default: daily at 2 AM)
- Mounts specified PVCs read-only
- Executes restic backup with retention policy
- Automatic pruning of old snapshots
- Supports pre/post backup hooks
- Webhook notifications on success/failure

**Resource Usage**:

- Default: 100m CPU / 128Mi RAM (requests)
- Configurable based on data volume

### 2. CronJob: Check

**Purpose**: Periodic repository integrity verification

**Key Features**:

- Configurable schedule (default: weekly)
- Verifies repository structure
- Optional data verification (slower but thorough)
- Reports repository statistics

**Resource Usage**:

- Similar to backup job
- Higher resources if `readData: true`

### 3. Job: Init

**Purpose**: One-time repository initialization

**Key Features**:

- Runs as Helm post-install/post-upgrade hook
- Creates restic repository if not exists
- Idempotent (safe to run multiple times)
- Validates credentials

### 4. Job: Restore

**Purpose**: Optional one-time restore operation

**Key Features**:

- Manually enabled via values
- Restores specific snapshot to target PVC
- Optional integrity verification
- Supports partial restores

### 5. ServiceAccount & RBAC

**Purpose**: Security and permissions

**Permissions**:

- Read PVCs (to mount for backup)
- Read secrets (for credentials)
- List pods (for operations)

**Features**:

- Cloud provider IAM integration (AWS, Azure, GCP)
- Minimal required permissions
- Customizable additional rules

### 6. Secret Management

**Options**:

1. **Chart-managed secret**: Create from values (development)
2. **Existing secret**: Reference external secret (production)
3. **External Secrets Operator**: Pull from vault
4. **Cloud provider secrets**: AWS Secrets Manager, Azure Key Vault, GCP Secret Manager

**Required Keys**:

- `RESTIC_REPOSITORY`: Backup destination
- `RESTIC_PASSWORD`: Encryption password
- Backend-specific credentials (AWS_ACCESS_KEY_ID, etc.)

### 7. NetworkPolicy (Optional)

**Purpose**: Network-level security

**Default Rules**:

- Allow DNS (TCP/UDP 53)
- Allow egress to backup destination
- Block AWS metadata endpoint
- No ingress (backup pods don't accept connections)

## Data Flow

### Backup Flow

```
1. CronJob triggers at scheduled time
   ↓
2. Job creates Pod with restic container
   ↓
3. [Optional] Pre-backup hooks execute (e.g., database dumps)
   ↓
4. Restic mounts PVCs (read-only)
   ↓
5. Restic reads credentials from Secret
   ↓
6. Restic scans mounted volumes for changes
   ↓
7. Data is chunked, deduplicated, and encrypted
   ↓
8. Encrypted chunks sent to storage backend
   ↓
9. Snapshot metadata saved
   ↓
10. Retention policy applied (old snapshots pruned)
    ↓
11. [Optional] Post-backup hooks execute
    ↓
12. [Optional] Webhook notification sent
    ↓
13. Job completes, Pod terminates
```

### Restore Flow

```
1. User enables restore in values.yaml
   ↓
2. Helm creates restore Job
   ↓
3. Restic lists available snapshots
   ↓
4. Restic retrieves specified snapshot metadata
   ↓
5. Encrypted chunks downloaded from storage
   ↓
6. Data decrypted and reassembled
   ↓
7. Files restored to target PVC
   ↓
8. [Optional] Integrity verification
   ↓
9. Job completes
```

## Security Architecture

### Defense in Depth

1. **Encryption at Rest**: All backups encrypted with AES-256
2. **Encryption in Transit**: HTTPS/TLS to storage backend
3. **Secret Management**: Kubernetes Secrets with optional external integration
4. **Network Policies**: Restrict pod network access
5. **RBAC**: Minimal required permissions
6. **Security Context**: Run as non-root when possible
7. **Read-Only Mounts**: PVCs mounted read-only
8. **Immutable Containers**: Read-only root filesystem

### Authentication Methods

| Backend      | Authentication                        |
| ------------ | ------------------------------------- |
| AWS S3       | IAM roles (IRSA) or access keys       |
| Azure Blob   | Managed Identity or storage keys      |
| Google GCS   | Workload Identity or service accounts |
| Backblaze B2 | Application keys                      |
| SFTP         | SSH keys or password                  |
| REST Server  | HTTP basic auth or token              |

## Scalability Considerations

### Horizontal Scaling

- Multiple backup schedules for different volume groups
- Separate charts for different namespaces/applications
- Dedicated backup infrastructure per environment

### Vertical Scaling

| Data Size  | CPU   | Memory | Notes                          |
| ---------- | ----- | ------ | ------------------------------ |
| < 10 GB    | 100m  | 128Mi  | Default config                 |
| 10-100 GB  | 500m  | 512Mi  | Medium workload                |
| 100-500 GB | 1000m | 1Gi    | Large workload                 |
| > 500 GB   | 2000m | 2Gi    | Very large, consider splitting |

### Performance Optimization

1. **Deduplication**: Restic automatically deduplicates data
2. **Compression**: Enable `compression: auto` in options
3. **Parallel Processing**: Restic handles concurrency internally
4. **Incremental Backups**: Only changed data backed up
5. **Local Caching**: Restic maintains local cache for metadata

## High Availability

### Backup HA

- CronJobs are inherently HA (Kubernetes manages scheduling)
- `concurrencyPolicy: Forbid` prevents overlapping backups
- Failed jobs automatically retried by Kubernetes
- Multiple retention periods ensure recovery points

### Storage HA

| Backend      | HA Features                                        |
| ------------ | -------------------------------------------------- |
| AWS S3       | 99.999999999% durability, cross-region replication |
| Azure Blob   | LRS/GRS/RA-GRS replication options                 |
| Google GCS   | Multi-regional storage classes                     |
| Backblaze B2 | Distributed storage, 99.9% durability              |

### Disaster Recovery

1. **Multiple Repositories**: Backup to multiple backends
2. **Cross-Region**: Store backups in different geographic regions
3. **Regular Testing**: Automated restore verification
4. **Retention Policies**: Multiple recovery points (daily, weekly, monthly)

## Monitoring & Observability

### Metrics

When ServiceMonitor is enabled:

- Backup job success/failure rate
- Backup duration
- Backup size
- Repository size
- Snapshot count
- Deduplication ratio

### Logs

All operations logged with structured output:

- Backup start/completion
- Files processed
- Data transferred
- Errors and warnings
- Retention policy actions

### Alerts (Recommended)

```yaml
# Example Prometheus alerts
- alert: BackupJobFailed
  expr: kube_job_status_failed{job_name=~"restic-backup.*"} > 0
  annotations:
    summary: "Restic backup job failed"

- alert: BackupNotRunning
  expr: time() - kube_job_status_completion_time{job_name=~"restic-backup.*"} > 86400
  annotations:
    summary: "No successful backup in 24 hours"
```

## Best Practices

### Operational

1. **Test Restores**: Regularly verify restore procedures
2. **Monitor Jobs**: Track backup success/failure
3. **Rotate Credentials**: Regular credential rotation
4. **Document Recovery**: Maintain recovery runbooks
5. **Capacity Planning**: Monitor storage growth

### Security

1. **Use External Secrets**: Vault, AWS Secrets Manager, etc.
2. **Enable Network Policies**: Restrict network access
3. **Minimal RBAC**: Only required permissions
4. **Read-Only Mounts**: Mount volumes read-only
5. **Secure Repository Password**: Strong, randomly generated

### Performance

1. **Schedule Off-Peak**: Run backups during low-traffic periods
2. **Right-Size Resources**: Allocate adequate CPU/memory
3. **Use Exclude Patterns**: Skip unnecessary files
4. **Enable Compression**: Reduce storage and bandwidth
5. **Local Storage for Cache**: Fast local disk for restic cache

## Limitations

1. **Volume Mount Permissions**: Backup pod may need root permissions to read volumes
2. **Single Namespace**: Chart backs up PVCs in same namespace (create multiple releases for multiple namespaces)
3. **No Application-Aware Backups**: Use pre-backup hooks for consistent application state
4. **Storage Backend Dependency**: Backups inaccessible if backend unavailable
5. **Kubernetes Version**: Requires Kubernetes 1.19+ for CronJob API

## Future Enhancements

- [ ] Automatic restore testing job
- [ ] Multi-namespace backup support
- [ ] Backup verification dashboard
- [ ] Integration with Velero for cluster-wide backups
- [ ] S3 bucket versioning support
- [ ] Backup data encryption key rotation
- [ ] WebUI for backup management

## References

- [Restic Documentation](https://restic.readthedocs.io/)
- [Restic Design Principles](https://restic.readthedocs.io/en/latest/design.html)
- [Kubernetes CronJob Documentation](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/)
- [Kubernetes Security Best Practices](https://kubernetes.io/docs/concepts/security/overview/)
