# Restic Backup Helm Chart

A production-ready Helm chart for automated Kubernetes volume backups using [restic](https://restic.net/), featuring multiple storage backends, flexible scheduling, retention policies, and comprehensive monitoring.

## Features

✨ **Key Features:**

- 🔄 **Automated Backups**: Scheduled CronJob-based backups with configurable intervals
- 📦 **Multiple Storage Backends**: Support for S3, Azure, Google Cloud, B2, SFTP, REST, and local storage
- 🗂️ **Flexible Volume Types**: PVC, HostPath, EmptyDir, ConfigMap, Secret, NFS, and custom volumes
- 🔐 **Encryption**: Built-in AES-256 encryption for all backups
- 📅 **Retention Policies**: Flexible retention rules (daily, weekly, monthly, yearly)
- ♻️ **Automatic Pruning**: Remove old backups based on retention policy
- 🔍 **Repository Checks**: Scheduled integrity verification
- 📊 **Monitoring**: Prometheus ServiceMonitor support
- 🔔 **Notifications**: Webhook support for backup success/failure alerts
- 🛡️ **Security**: NetworkPolicy, RBAC, and SecurityContext support
- 🚀 **Easy Restore**: Built-in restore job configuration
- 📦 **Multi-Volume Support**: Back up multiple volumes in a single job
- 🔧 **Pre/Post Hooks**: Execute commands before/after backups

## Prerequisites

- Kubernetes 1.19+
- Helm 3.0+
- Persistent Volume Claims (PVCs) to backup
- Storage backend (S3, Azure, GCS, etc.) credentials

## Installation

### Quick Start (Local Backups)

The chart works out of the box with local backup storage. A dedicated PersistentVolumeClaim is automatically created for storing backups.

1. **Add the Helm repository** (if published):

```bash
helm repo add codefuturist https://codefuturist.github.io/helm-charts
helm repo update
```

2. **Create a minimal values file** (`my-values.yaml`):

```yaml
restic:
  # Local repository (default) - automatically uses dedicated backup volume
  repository: "/backup-repository"
  password: "your-secure-restic-password"

# Backup volume is enabled by default with a 10Gi PVC
# Adjust size if needed:
backupVolume:
  enabled: true  # default
  pvc:
    size: 20Gi   # adjust based on your needs

volumes:
  - name: app-data
    claimName: myapp-pvc
    mountPath: /data
```

3. **Install the chart**:

```bash
helm install restic-backup codefuturist/restic-backup \
  -f my-values.yaml \
  --namespace backups \
  --create-namespace
```

### Using Remote Storage (S3, Azure, GCS)

For remote backups, disable the local backup volume:

```yaml
restic:
  repository: "s3:s3.amazonaws.com/my-backup-bucket/k8s-backups"
  password: "your-secure-restic-password"
  backendEnv:
    AWS_ACCESS_KEY_ID: "your-aws-key"
    AWS_SECRET_ACCESS_KEY: "your-aws-secret"
    AWS_DEFAULT_REGION: "us-east-1"

# Disable local backup volume when using remote storage
backupVolume:
  enabled: false

volumes:
  - name: app-data
    claimName: myapp-pvc
    mountPath: /data
```

### Using Existing Secrets (Recommended for Production)

For better security, use an existing Kubernetes secret:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: restic-credentials
  namespace: backups
type: Opaque
stringData:
  RESTIC_REPOSITORY: "/backup-repository"
  RESTIC_PASSWORD: "your-restic-password"
```

Then reference it in your values:

```yaml
restic:
  existingSecret: "restic-credentials"

volumes:
  - name: app-data
    claimName: myapp-pvc
    mountPath: /data
```

## Configuration

### Backup Volume Configuration

The chart automatically provisions a dedicated volume for local backups. This is enabled by default for ease of use.

#### Default Configuration (Recommended)

```yaml
backupVolume:
  enabled: true          # Enabled by default
  type: pvc              # PersistentVolumeClaim
  mountPath: /backup-repository
  pvc:
    size: 10Gi           # Adjust based on backup size
    storageClassName: "" # Uses cluster default
    accessModes:
      - ReadWriteOnce
```

#### Using Existing PVC

```yaml
backupVolume:
  enabled: true
  type: pvc
  pvc:
    existingClaim: "my-backup-pvc"  # Use existing PVC
```

#### Using HostPath (for single-node clusters)

```yaml
backupVolume:
  enabled: true
  type: hostPath
  hostPath:
    path: /mnt/backup-storage
    type: DirectoryOrCreate
```

#### Using NFS

```yaml
backupVolume:
  enabled: true
  type: nfs
  nfs:
    server: nfs-server.example.com
    path: /exports/backups
```

#### Disable for Remote Storage

When using S3, Azure, GCS, or other remote backends:

```yaml
backupVolume:
  enabled: false

restic:
  repository: "s3:s3.amazonaws.com/bucket/path"
  # ... backend credentials ...
```

### Storage Backends

#### AWS S3

```yaml
restic:
  repository: "s3:s3.amazonaws.com/bucket-name/path"
  password: "your-password"
  backendEnv:
    AWS_ACCESS_KEY_ID: "key"
    AWS_SECRET_ACCESS_KEY: "secret"
    AWS_DEFAULT_REGION: "us-east-1"
```

#### Azure Blob Storage

```yaml
restic:
  repository: "azure:container-name:/path"
  password: "your-password"
  backendEnv:
    AZURE_ACCOUNT_NAME: "storageaccount"
    AZURE_ACCOUNT_KEY: "key"
```

#### Google Cloud Storage

```yaml
restic:
  repository: "gs:bucket-name:/path"
  password: "your-password"
  backendEnv:
    GOOGLE_PROJECT_ID: "project-id"
    GOOGLE_APPLICATION_CREDENTIALS: "/credentials/gcp-key.json"

extraVolumes:
  - name: gcp-credentials
    secret:
      secretName: gcp-sa-key

extraVolumeMounts:
  - name: gcp-credentials
    mountPath: /credentials
    readOnly: true
```

#### Backblaze B2

```yaml
restic:
  repository: "b2:bucket-name:/path"
  password: "your-password"
  backendEnv:
    B2_ACCOUNT_ID: "account-id"
    B2_ACCOUNT_KEY: "account-key"
```

#### SFTP

```yaml
restic:
  repository: "sftp:user@host:/path"
  password: "your-password"
```

### Backup Schedule

```yaml
restic:
  backup:
    enabled: true
    schedule: "0 2 * * *"  # Daily at 2 AM
    tags:
      - kubernetes
      - production
    excludes:
      - "*.tmp"
      - "*.cache"
      - ".DS_Store"
```

### Retention Policy

```yaml
restic:
  backup:
    retention:
      enabled: true
      keepLast: 7        # Keep last 7 snapshots
      keepDaily: 14      # Keep daily for 14 days
      keepWeekly: 8      # Keep weekly for 8 weeks
      keepMonthly: 12    # Keep monthly for 12 months
      keepYearly: 3      # Keep yearly for 3 years
```

### Multiple Volumes

```yaml
volumes:
  - name: app-data
    claimName: myapp-pvc
    mountPath: /app-data

  - name: database
    claimName: postgres-data
    mountPath: /pgdata
    readOnly: true  # Mount read-only for safety

  - name: config
    claimName: config-pvc
    mountPath: /config
    subPath: production  # Only backup specific subpath
```

### Pre/Post Backup Hooks

```yaml
hooks:
  preBackup:
    - name: database-dump
      image: postgres:16
      command: ["pg_dump"]
      args: ["-h", "postgres", "-U", "user", "-d", "mydb", "-f", "/backup/dump.sql"]
      volumeMounts:
        - name: backup-staging
          mountPath: /backup

  postBackup:
    - name: cleanup
      image: busybox
      command: ["rm", "-rf", "/backup/temp"]
      volumeMounts:
        - name: backup-staging
          mountPath: /backup
```

### Notifications

#### Webhook Notifications

```yaml
notifications:
  enabled: true
  webhook:
    url: "https://hooks.slack.com/services/YOUR/WEBHOOK/URL"
```

### Monitoring

```yaml
serviceMonitor:
  enabled: true
  additionalLabels:
    release: prometheus-stack
  interval: 30s
```

### Security

```yaml
networkPolicy:
  enabled: true
  egress:
    - to:
      - namespaceSelector: {}
      ports:
      - protocol: TCP
        port: 443

serviceAccount:
  annotations:
    eks.amazonaws.com/role-arn: "arn:aws:iam::ACCOUNT:role/restic-backup-role"

cronjob:
  securityContext:
    runAsUser: 1000
    runAsGroup: 1000
    fsGroup: 1000
    runAsNonRoot: true
```

## Operations

### Manual Backup

Trigger a backup manually:

```bash
kubectl create job -n backups \
  --from=cronjob/restic-backup-backup \
  manual-backup-$(date +%s)
```

### List Snapshots

```bash
kubectl run -n backups restic-shell -it --rm \
  --image=restic/restic:0.17.3 \
  --env=RESTIC_REPOSITORY=<repo> \
  --env=RESTIC_PASSWORD=<password> \
  -- restic snapshots
```

### Restore from Backup

Enable restore in values:

```yaml
restore:
  enabled: true
  snapshotId: "latest"  # or specific snapshot ID
  targetVolume: "restore-pvc"
  targetPath: "/restore"
  verify: true
```

Then upgrade the release:

```bash
helm upgrade restic-backup codefuturist/restic-backup -f values.yaml
```

### View Backup Logs

```bash
# View recent backup logs
kubectl logs -n backups -l app.kubernetes.io/component=backup-job --tail=100

# Follow backup in progress
kubectl logs -n backups -l app.kubernetes.io/component=backup-job -f
```

### Check Repository Health

```bash
# View check job schedule
kubectl get cronjob -n backups restic-backup-check

# Trigger manual check
kubectl create job -n backups \
  --from=cronjob/restic-backup-check \
  manual-check-$(date +%s)
```

## Examples

See the [`examples/`](./examples/) directory for:

- [`values-minimal.yaml`](./examples/values-minimal.yaml) - Minimal configuration
- [`values-production.yaml`](./examples/values-production.yaml) - Production setup with monitoring
- [`values-multi-volume.yaml`](./examples/values-multi-volume.yaml) - Multiple volume backups
- [`values-azure.yaml`](./examples/values-azure.yaml) - Azure Blob Storage backend
- [`values-gcs.yaml`](./examples/values-gcs.yaml) - Google Cloud Storage backend

## Architecture

For detailed architecture information, see [ARCHITECTURE.md](./docs/ARCHITECTURE.md).

## Troubleshooting

### Backup Job Fails

1. Check job logs:
   ```bash
   kubectl logs -n backups -l app.kubernetes.io/component=backup-job
   ```

2. Verify credentials:
   ```bash
   kubectl get secret -n backups restic-backup-credentials -o yaml
   ```

3. Test repository access:
   ```bash
   kubectl run -n backups restic-test -it --rm \
     --image=restic/restic:0.17.3 \
     --env=RESTIC_REPOSITORY=<repo> \
     --env=RESTIC_PASSWORD=<password> \
     -- restic snapshots
   ```

### Volume Mount Issues

Ensure the backup pod has permissions to read the PVC:

```yaml
cronjob:
  securityContext:
    runAsUser: 0
    fsGroup: 0
```

### Repository Not Initialized

The chart automatically initializes the repository via a Helm hook. If it fails:

```bash
# Check init job logs
kubectl logs -n backups -l app.kubernetes.io/component=init-job

# Manually initialize
kubectl run -n backups restic-init -it --rm \
  --image=restic/restic:0.17.3 \
  --env=RESTIC_REPOSITORY=<repo> \
  --env=RESTIC_PASSWORD=<password> \
  -- restic init
```

## Security Best Practices

1. **Use External Secrets**: Integrate with External Secrets Operator or Vault
2. **Enable Network Policies**: Restrict network access
3. **Read-Only Mounts**: Mount volumes as read-only when possible
4. **Rotate Credentials**: Regularly rotate storage backend credentials
5. **Secure Repository Password**: Use strong, randomly generated passwords
6. **Test Restores**: Regularly test restore procedures
7. **Enable Monitoring**: Track backup success/failure metrics

## Values Reference

See the complete [values.yaml](./values.yaml) file for all available configuration options.

## Contributing

Contributions welcome! Please see [CONTRIBUTING.md](../../docs/CONTRIBUTING.md).

## Support

For bug reports, feature requests, and general questions:

- **GitHub Issues**: [Report a bug or request a feature](https://github.com/codefuturist/helm-charts/issues)
- **GitHub Discussions**: [Ask questions and discuss ideas](https://github.com/codefuturist/helm-charts/discussions)
- **Restic Documentation**: [Official Restic Documentation](https://restic.readthedocs.io/)

## License

This Helm chart is licensed under the [Apache License 2.0](../../LICENSE).

## Maintainers

| Name | Email | GitHub |
|------|-------|--------|
| codefuturist | - | [@codefuturist](https://github.com/codefuturist) |

## Source Code

- **Chart Repository**: <https://github.com/codefuturist/helm-charts/tree/main/charts/restic-backup>

## Acknowledgments

- [Restic](https://restic.net/) - The backup program powering this chart
- [Kubernetes](https://kubernetes.io/) - Container orchestration platform
- [Helm](https://helm.sh/) - Package manager for Kubernetes
