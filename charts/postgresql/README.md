# PostgreSQL Helm Chart

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/codefuturist)](https://artifacthub.io/packages/helm/codefuturist/postgresql)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

A production-ready Helm chart for deploying PostgreSQL on Kubernetes with advanced features including replication, automated backups, monitoring, and security best practices.

## Features

### Core Features
- ✅ **PostgreSQL 16** - Latest stable version with Alpine Linux base
- ✅ **High Availability** - StatefulSet with streaming replication and automatic setup
- ✅ **Read Scaling** - Load-balanced read-only service for replicas
- ✅ **Automated Backups** - Full backups + WAL archiving for point-in-time recovery
- ✅ **Monitoring** - Built-in Prometheus metrics with replication lag alerts
- ✅ **Security** - Pod security contexts, network policies, RBAC
- ✅ **TLS/SSL** - cert-manager integration for certificate management
- ✅ **Connection Pooling** - PgBouncer support (optional)
- ✅ **Persistence** - PVC support with configurable storage classes
- ✅ **Init Scripts** - SQL scripts for database initialization
- ✅ **Custom Configuration** - Full postgresql.conf and pg_hba.conf customization

### Advanced Features
- 🔄 **Streaming Replication** - Automated primary/replica setup with physical replication slots
- 💾 **WAL Archiving** - 4 methods (simple, wal-g, wal-e, pgbackrest) with compression
- 🔙 **Easy Recovery** - Interactive script and Helm-based recovery from backups
- 📊 **ServiceMonitor** - Prometheus Operator integration with replication metrics
- 📈 **PrometheusRule** - Pre-configured alerting rules for replication lag and failures
- 🎯 **Pod Disruption Budget** - High availability guarantees
- 🔄 **Horizontal/Vertical Pod Autoscaling** - Resource optimization
- 🔐 **External Secrets** - Integration with external secret managers
- 🌐 **Network Policies** - Network isolation and security
- 📦 **Resource Management** - CPU and memory limits/requests
- 🚀 **Multiple Deployment Options** - Deployment or StatefulSet

## Prerequisites

- Kubernetes 1.21+
- Helm 3.8+
- PV provisioner support in the underlying infrastructure (optional)
- cert-manager (optional, for TLS)
- Prometheus Operator (optional, for monitoring)

## Installation

### Add Helm Repository

```bash
helm repo add codefuturist https://codefuturist.github.io/helm-charts
helm repo update
```

### Install Chart

```bash
# Basic installation
helm install my-postgresql codefuturist/postgresql

# With custom values
helm install my-postgresql codefuturist/postgresql -f values.yaml

# With inline values
helm install my-postgresql codefuturist/postgresql \
  --set postgresql.database=mydb \
  --set postgresql.username=myuser \
  --set postgresql.password=mypassword
```

## Quick Start Examples

### Minimal Installation

```bash
helm install my-postgresql codefuturist/postgresql \
  --set postgresql.database=mydb \
  --set postgresql.username=myuser \
  --set postgresql.password=changeme \
  --set persistence.size=10Gi
```

### Production Installation

```bash
helm install my-postgresql codefuturist/postgresql \
  -f examples/values-production.yaml \
  --set postgresql.existingSecret=my-postgres-secret
```

### Development Installation

```bash
helm install my-postgresql codefuturist/postgresql \
  -f examples/values-dev.yaml
```

## Configuration

### Global Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `namespaceOverride` | Override namespace for all resources | `""` |
| `componentOverride` | Override component label | `""` |
| `partOfOverride` | Override partOf label | `""` |
| `applicationName` | Application name | `{{ .Chart.Name }}` |
| `additionalLabels` | Additional labels for all resources | `{}` |
| `additionalAnnotations` | Additional annotations for all resources | `{}` |

### PostgreSQL Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `postgresql.version` | PostgreSQL version | `"16.4"` |
| `postgresql.image.repository` | PostgreSQL image repository | `postgres` |
| `postgresql.image.tag` | PostgreSQL image tag | `"16.4-alpine"` |
| `postgresql.image.pullPolicy` | Image pull policy | `IfNotPresent` |
| `postgresql.database` | Database name | `"postgres"` |
| `postgresql.username` | Database username | `"postgres"` |
| `postgresql.password` | Database password | `""` |
| `postgresql.existingSecret` | Existing secret with password | `""` |
| `postgresql.config` | PostgreSQL configuration parameters | See values.yaml |
| `postgresql.customConfig` | Custom postgresql.conf content | `""` |
| `postgresql.customPgHba` | Custom pg_hba.conf content | `""` |
| `postgresql.initScripts` | Init SQL scripts | `{}` |
| `postgresql.extensions` | PostgreSQL extensions to enable | `[pg_stat_statements, pgcrypto]` |
| `postgresql.additionalDatabases` | Additional databases to create | `[]` |
| `postgresql.additionalUsers` | Additional users to create | `[]` |
| `postgresql.externalResources.enabled` | Read databases/users from external resources | `false` |
| `postgresql.externalResources.databasesConfigMap.name` | ConfigMap with database definitions | `""` |
| `postgresql.externalResources.usersConfigMap.name` | ConfigMap with user definitions | `""` |
| `postgresql.externalResources.usersSecret.name` | Secret with user passwords | `""` |

### Deployment Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `deployment.replicas` | Number of replicas | `1` |
| `deployment.strategy` | Deployment strategy | `Recreate` |
| `deployment.resources` | Resource limits/requests | See values.yaml |
| `deployment.securityContext` | Container security context | See values.yaml |
| `deployment.livenessProbe` | Liveness probe configuration | See values.yaml |
| `deployment.readinessProbe` | Readiness probe configuration | See values.yaml |
| `deployment.startupProbe` | Startup probe configuration | See values.yaml |

### Persistence Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `persistence.enabled` | Enable persistent storage | `true` |
| `persistence.existingClaim` | Use existing PVC | `""` |
| `persistence.storageClass` | Storage class name | `""` |
| `persistence.accessModes` | Access modes | `[ReadWriteOnce]` |
| `persistence.size` | Volume size | `8Gi` |

### Service Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `service.enabled` | Enable service | `true` |
| `service.type` | Service type | `ClusterIP` |
| `service.port` | PostgreSQL service port | `5432` |
| `service.annotations` | Service annotations | `{}` |

### Backup Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `backup.enabled` | Enable automated backups | `false` |
| `backup.schedule` | Backup schedule (cron) | `"0 2 * * *"` |
| `backup.retentionDays` | Backup retention in days | `7` |
| `backup.persistence.enabled` | Enable backup PVC | `true` |
| `backup.persistence.size` | Backup volume size | `10Gi` |

### Monitoring Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `metrics.enabled` | Enable metrics exporter | `false` |
| `metrics.port` | Metrics port | `9187` |
| `monitoring.serviceMonitor.enabled` | Enable ServiceMonitor | `false` |
| `monitoring.prometheusRule.enabled` | Enable PrometheusRule | `false` |
| `monitoring.grafanaDashboard.enabled` | Enable Grafana dashboard | `false` |

### Replication Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `replication.enabled` | Enable replication | `false` |
| `replication.readReplicas` | Number of read replicas | `1` |
| `replication.user` | Replication user | `"replicator"` |
| `replication.synchronousCommit` | Enable synchronous commit | `false` |
| `statefulset.enabled` | Use StatefulSet (required for replication) | `false` |

### Security Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `serviceAccount.create` | Create service account | `true` |
| `rbac.create` | Create RBAC resources | `false` |
| `networkPolicy.enabled` | Enable network policy | `false` |
| `pdb.enabled` | Enable Pod Disruption Budget | `false` |
| `tls.enabled` | Enable TLS | `false` |

## Usage Examples

### Connecting to PostgreSQL

After installation, get the connection details:

```bash
# Get PostgreSQL password
export POSTGRES_PASSWORD=$(kubectl get secret --namespace default my-postgresql -o jsonpath="{.data.postgresql-password}" | base64 -d)

# Connect using kubectl run
kubectl run my-postgresql-client --rm --tty -i --restart='Never' \
  --namespace default \
  --image postgres:16.4-alpine \
  --env="PGPASSWORD=$POSTGRES_PASSWORD" \
  --command -- psql --host my-postgresql -U postgres -d postgres -p 5432

# Port forward to local machine
kubectl port-forward --namespace default svc/my-postgresql 5432:5432 &
PGPASSWORD="$POSTGRES_PASSWORD" psql --host 127.0.0.1 --port 5432 -U postgres -d postgres
```

### Using Existing Secrets

Create a secret with your PostgreSQL passwords:

```bash
kubectl create secret generic my-postgres-secret \
  --from-literal=postgresql-password=mypassword \
  --from-literal=postgresql-postgres-password=postgrespassword
```

Install with existing secret:

```yaml
postgresql:
  existingSecret: my-postgres-secret
  existingSecretPasswordKey: postgresql-password
  existingPostgresSecret: my-postgres-secret
  existingPostgresPasswordKey: postgresql-postgres-password
```

### Custom PostgreSQL Configuration

```yaml
postgresql:
  config:
    max_connections: "200"
    shared_buffers: "512MB"
    effective_cache_size: "2GB"

  customConfig: |
    # Additional custom configuration
    listen_addresses = '*'

  customPgHba: |
    # Custom pg_hba.conf
    host all all 0.0.0.0/0 scram-sha-256
```

### Creating Additional Databases and Users

The chart supports creating additional databases and users during initialization, either through configuration or by reading from external Kubernetes resources.

**Key Feature:** Database ownership is **automatically assigned** to the first user with `ALL` privileges on that database. This follows PostgreSQL best practices for application database ownership.

#### Method 1: Direct Configuration

Define databases and users directly in your values.yaml:

```yaml
postgresql:
  # Create additional databases
  additionalDatabases:
    - name: myapp_db
      # owner automatically set to myapp_user (first user with ALL privileges)
      encoding: UTF8
      lc_collate: en_US.UTF-8
      lc_ctype: en_US.UTF-8
      template: template0
    - name: analytics_db
      owner: postgres  # Explicitly set owner (optional override)
      encoding: UTF8
    - name: shared_db
      # owner automatically set to myapp_user

  # Create additional users with privileges
  additionalUsers:
    - username: myapp_user
      existingSecret: myapp-user-secret  # Recommended: store password in secret
      databases:
        - myapp_db
        - shared_db
      privileges: ALL  # Gets ownership of myapp_db and shared_db
      superuser: false
      createdb: false
      createrole: false

    - username: readonly_user
      existingSecret: readonly-secret
      databases:
        - myapp_db
        - analytics_db
        - shared_db
      privileges: SELECT  # Read-only, does NOT get ownership
      superuser: false
```

**Important:** Always use `existingSecret` for production. If you must specify passwords directly, use:

```yaml
additionalUsers:
  - username: myapp_user
    password: "changeme"  # Not recommended for production
    databases:
      - myapp_db
    privileges: ALL
```

#### Method 2: External Kubernetes Resources

Read database and user definitions from ConfigMaps and Secrets. This approach is ideal for GitOps workflows and separation of concerns.

**Step 1:** Create a ConfigMap with database definitions:

```yaml
# databases-config.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: postgresql-databases
data:
  databases.yaml: |
    - name: myapp_db
      owner: myapp_user
      encoding: UTF8
    - name: analytics_db
      owner: postgres
```

**Step 2:** Create a ConfigMap with user definitions:

```yaml
# users-config.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: postgresql-users
data:
  users.yaml: |
    - username: myapp_user
      databases:
        - myapp_db
      privileges: ALL
      superuser: false
    - username: readonly_user
      databases:
        - myapp_db
        - analytics_db
      privileges: SELECT
```

**Step 3:** Create a Secret with user passwords:

```yaml
# users-secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: postgresql-user-passwords
type: Opaque
stringData:
  myapp-password: "strong_password_123"
  readonly-password: "readonly_pass_456"
```

**Step 4:** Configure the chart to use external resources:

```yaml
postgresql:
  externalResources:
    enabled: true

    databasesConfigMap:
      name: postgresql-databases
      key: databases.yaml

    usersConfigMap:
      name: postgresql-users
      key: users.yaml

    usersSecret:
      name: postgresql-user-passwords
      passwordKeys:
        myapp_user: myapp-password
        readonly_user: readonly-password
```

**Step 5:** Apply and install:

```bash
kubectl apply -f databases-config.yaml
kubectl apply -f users-config.yaml
kubectl apply -f users-secret.yaml
helm install my-postgresql . -f values.yaml
```

#### User Privileges

The `privileges` field supports:

- `ALL` - Full access to the database
- `SELECT` - Read-only access
- `INSERT` - Insert permission
- `UPDATE` - Update permission
- `DELETE` - Delete permission
- `TRUNCATE` - Truncate permission
- `REFERENCES` - References permission
- `TRIGGER` - Trigger permission
- `CREATE` - Create permission
- `CONNECT` - Connection permission
- `TEMPORARY` - Temporary objects permission
- `EXECUTE` - Execute permission

You can combine multiple privileges: `privileges: "SELECT, INSERT, UPDATE"`

#### User Attributes

Available user attributes:

- `superuser` - PostgreSQL superuser (default: false)
- `createdb` - Can create databases (default: false)
- `createrole` - Can create roles (default: false)
- `replication` - Can perform replication (default: false)

#### Multi-Tenant Example

See `examples/values-multitenant.yaml` for a complete multi-tenant setup with multiple databases and users.

#### Security Best Practices

1. **Never commit passwords** to version control
2. **Use Kubernetes Secrets** for password storage
3. **Use existingSecret** parameter for user passwords
4. **Grant minimal privileges** required for each user
5. **Use separate users** for different applications/services
6. **Enable audit logging** with pgaudit extension
7. **Use scram-sha-256** authentication method (default)

### Init Scripts

```yaml
postgresql:
  initScripts:
    01-create-extensions.sql: |
      CREATE EXTENSION IF NOT EXISTS pg_stat_statements;
      CREATE EXTENSION IF NOT EXISTS pgcrypto;

    02-create-schema.sql: |
      CREATE SCHEMA IF NOT EXISTS myapp;
      CREATE TABLE IF NOT EXISTS myapp.users (
        id SERIAL PRIMARY KEY,
        username VARCHAR(50) UNIQUE NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      );
```

### High Availability with Replication

The chart provides enterprise-grade streaming replication with automated setup and monitoring.

#### Quick Start - Async Replication

```yaml
replication:
  enabled: true
  readReplicas: 2              # Creates 2 read replicas (3 total pods)
  user: replicator
  password: "changeme-replication"

  # Automatic replication setup
  slots:
    enabled: true
    autoCreate: true           # Auto-creates physical replication slots

  # Load-balanced read service
  replicaService:
    enabled: true
    type: ClusterIP           # Or LoadBalancer for external access
    sessionAffinity: true      # Sticky sessions

# Highly recommended
persistence:
  enabled: true
  size: 20Gi
```

**Access pattern:**
- **Writes**: `postgresql.default.svc.cluster.local:5432` → Primary (pod-0)
- **Reads**: `postgresql-read.default.svc.cluster.local:5432` → Replicas (pods 1-N)

#### Synchronous Replication (Zero Data Loss)

For critical workloads requiring zero data loss:

```yaml
replication:
  enabled: true
  readReplicas: 2
  user: replicator
  password: "changeme-replication"

  # Synchronous mode
  synchronousCommit: "on"      # Options: off, on, remote_write, remote_apply
  numSynchronousReplicas: 1    # Wait for 1 replica to confirm writes

  slots:
    enabled: true
    autoCreate: true

  monitoring:
    enabled: true
    lagThresholdSeconds: 10    # Alert if >10s lag

pdb:
  enabled: true
  minAvailable: 2              # Keep at least 2 pods available
```

#### Full HA Configuration

Production-ready setup with monitoring and backups:

```yaml
replication:
  enabled: true
  readReplicas: 3
  user: replicator
  password: "changeme-replication"
  synchronousCommit: "remote_write"  # Balance safety & performance
  numSynchronousReplicas: 1

  slots:
    enabled: true
    autoCreate: true

  replicaService:
    enabled: true
    type: LoadBalancer
    sessionAffinity: true

  monitoring:
    enabled: true
    lagThresholdSeconds: 30
    lagThresholdBytes: 100

  advanced:
    maxWalSenders: 10
    maxReplicationSlots: 10
    walKeepSize: "2GB"

monitoring:
  serviceMonitor:
    enabled: true
  prometheusRule:
    enabled: true              # Replication lag alerts

persistence:
  enabled: true
  size: 100Gi
  storageClass: fast-ssd

pdb:
  enabled: true
  minAvailable: 2
```

**Features:**
- 🔄 **Automated Setup**: Replicas automatically clone from primary and configure streaming
- 📊 **Built-in Monitoring**: Replication lag metrics and alerts
- 🎯 **Read Load Balancing**: Dedicated service for read-only queries
- 💪 **Physical Replication Slots**: Prevents WAL deletion while replicas catch up
- ⚡ **Sync/Async Modes**: Choose between performance and data safety

**See also:**
- [Complete Replication Guide](REPLICATION.md) - Architecture, monitoring, failover procedures
- [Examples](examples/):
  - `values-replication-async.yaml` - Async replication for best performance
  - `values-replication-sync.yaml` - Sync replication for zero data loss
  - `values-replication-ha.yaml` - Full HA setup with monitoring and backups

### Backup Configuration

Enable automated backups with S3 support:

```yaml
backup:
  enabled: true
  schedule: "0 2 * * *"  # Daily at 2 AM
  retentionDays: 30

  persistence:
    enabled: true
    size: 100Gi

  s3:
    enabled: true
    bucket: my-postgres-backups
    region: us-east-1
    existingSecret: aws-credentials
```

#### WAL Archiving (Incremental Backups)

Enable WAL archiving for continuous incremental backups and point-in-time recovery (PITR):

```yaml
backup:
  enabled: true

  # WAL archiving for incremental backups
  wal:
    enabled: true
    method: "simple"        # Options: simple, wal-g, wal-e, pgbackrest
    compression: "gzip"     # Options: none, gzip, lz4, zstd
    retentionDays: 14       # Keep WAL archives for 14 days

    persistence:
      enabled: true
      size: 100Gi

    cleanup:
      enabled: true
      schedule: "0 3 * * *"  # Daily cleanup at 3 AM
```

**Key Features**:
- 🔄 **Continuous Backup**: Captures all database changes in real-time
- ⏱️ **Point-in-Time Recovery**: Restore to any specific moment
- 💾 **Space Efficient**: Only stores changes, not full database copies
- 🛠️ **Multiple Methods**: Simple file-based, WAL-G, WAL-E, or pgBackRest

**Learn More**: See [WAL_ARCHIVING.md](./WAL_ARCHIVING.md) for detailed documentation.

### Easy Database Recovery

Restore your database from backups in minutes with user-friendly tools:

```bash
# Interactive recovery wizard (easiest)
./scripts/recover.sh recover my-postgres

# Quick full restore from latest backup
./scripts/recover.sh recover-full my-postgres

# Point-in-time recovery to specific moment
./scripts/recover.sh recover-pitr my-postgres "2024-11-12 14:30:00"
```

**Or use Helm for declarative recovery:**

```yaml
recovery:
  enabled: true
  mode: "pitr"                    # 'full' or 'pitr'
  source: "backup"                # 'backup' or 's3'
  targetTime: "2024-11-12 14:30:00"  # For PITR
  backupFile: ""                  # Optional: specific backup
  tempStorageSize: "50Gi"
```

**Key Features**:
- 🎯 **One-Command Recovery**: Interactive script guides you through the process
- ⏱️ **PITR Support**: Restore to any point in time (with WAL archiving)
- 📋 **List Backups**: View available backups before recovery
- 📊 **Progress Monitoring**: Real-time recovery status and logs
- ✅ **Verification**: Built-in data integrity checks

**Learn More**: See [RECOVERY_GUIDE.md](./RECOVERY_GUIDE.md) for complete recovery documentation.

### Monitoring Setup

Enable Prometheus monitoring:

```yaml
metrics:
  enabled: true

monitoring:
  enabled: true

  serviceMonitor:
    enabled: true
    interval: 30s
    labels:
      prometheus: kube-prometheus

  prometheusRule:
    enabled: true
    labels:
      prometheus: kube-prometheus
```

### TLS/SSL Configuration

Enable TLS with cert-manager:

```yaml
tls:
  enabled: true

  certificate:
    enabled: true
    issuerRef:
      name: letsencrypt-prod
      kind: ClusterIssuer
    dnsNames:
      - postgresql.example.com

postgresql:
  config:
    ssl: "on"
```

## Best Practices

### Production Checklist

- ✅ Use external secrets (never hardcode passwords)
- ✅ Enable persistence with appropriate storage class
- ✅ Configure resource limits and requests
- ✅ Enable automated backups
- ✅ Set up monitoring and alerting
- ✅ Use Pod Disruption Budgets
- ✅ Configure network policies
- ✅ Enable security contexts
- ✅ Use affinity rules for HA
- ✅ Enable TLS/SSL for connections

### Performance Tuning

Adjust PostgreSQL configuration based on your workload:

```yaml
postgresql:
  config:
    # For OLTP workloads
    max_connections: "200"
    shared_buffers: "25% of RAM"
    effective_cache_size: "75% of RAM"
    maintenance_work_mem: "2GB"
    checkpoint_completion_target: "0.9"
    wal_buffers: "16MB"
    random_page_cost: "1.1"  # For SSD
    effective_io_concurrency: "200"
    work_mem: "5MB"
```

### Security Hardening

```yaml
deployment:
  podSecurityContext:
    fsGroup: 999
    runAsNonRoot: true

  securityContext:
    runAsUser: 999
    runAsNonRoot: true
    allowPrivilegeEscalation: false
    readOnlyRootFilesystem: false
    capabilities:
      drop:
        - ALL

networkPolicy:
  enabled: true
  ingress:
    - from:
      - namespaceSelector:
          matchLabels:
            name: production
      ports:
      - protocol: TCP
        port: 5432
```

## Security Best Practices

### Security Checklist

- [ ] **Use External Secrets**: Never store passwords in `values.yaml`
- [ ] **Enable TLS**: Always use TLS for production deployments
- [ ] **Network Policies**: Restrict network access to PostgreSQL pods
- [ ] **RBAC**: Use minimal RBAC permissions
- [ ] **Pod Security**: Run as non-root user with dropped capabilities
- [ ] **Regular Updates**: Keep PostgreSQL and chart versions up to date
- [ ] **Backup Encryption**: Encrypt backups at rest and in transit
- [ ] **Audit Logging**: Enable pgAudit extension for compliance
- [ ] **Connection Limits**: Set appropriate `max_connections`
- [ ] **Strong Authentication**: Use `scram-sha-256` authentication

### Authentication Methods

Configure authentication method via `postgresql.hostAuthMethod`:

```yaml
postgresql:
  hostAuthMethod: "scram-sha-256"  # Recommended for production
  # Options: scram-sha-256, md5, password, trust
```

### pgAudit Extension

Enable audit logging for compliance:

```yaml
postgresql:
  extensions:
    - pgaudit
  config:
    shared_preload_libraries: "pgaudit"
    pgaudit.log: "all"
    pgaudit.log_catalog: "off"
```

## Performance Tuning

### Workload-Specific Configurations

#### OLTP (Transactional) Workload

```yaml
postgresql:
  config:
    max_connections: "200"
    shared_buffers: "2GB"
    effective_cache_size: "6GB"
    work_mem: "10MB"
    maintenance_work_mem: "512MB"
    random_page_cost: "1.1"
    effective_io_concurrency: "200"
```

#### OLAP (Analytical) Workload

```yaml
postgresql:
  config:
    max_connections: "50"
    shared_buffers: "8GB"
    effective_cache_size: "24GB"
    work_mem: "50MB"
    maintenance_work_mem: "2GB"
    max_parallel_workers_per_gather: "4"
    max_parallel_workers: "8"
```

#### Mixed Workload

```yaml
postgresql:
  config:
    max_connections: "100"
    shared_buffers: "4GB"
    effective_cache_size: "12GB"
    work_mem: "20MB"
    maintenance_work_mem: "1GB"
```

## Disaster Recovery

### Backup Strategy

1. **Automated Backups**: Enable daily backups with retention
2. **Pre-Upgrade Backups**: Automatic backups before helm upgrades
3. **Point-in-Time Recovery**: Configure WAL archiving
4. **Off-site Backups**: Store backups in S3 or similar

### Manual Backup

```bash
# Create manual backup
kubectl exec -n default my-postgresql-0 -- \
  pg_dump -U postgres -d mydb | gzip > backup-$(date +%Y%m%d).sql.gz

# Backup all databases
kubectl exec -n default my-postgresql-0 -- \
  pg_dumpall -U postgres | gzip > full-backup-$(date +%Y%m%d).sql.gz
```

### Restore from Backup

```bash
# Restore single database
gunzip < backup.sql.gz | kubectl exec -i -n default my-postgresql-0 -- \
  psql -U postgres -d mydb

# Restore all databases
gunzip < full-backup.sql.gz | kubectl exec -i -n default my-postgresql-0 -- \
  psql -U postgres
```

### Recovery Procedures

1. **Pod Failure**: Kubernetes automatically restarts the pod
2. **Node Failure**: Pod reschedules to healthy node (data preserved via PVC)
3. **Data Corruption**: Restore from latest backup
4. **Region Failure**: Restore from off-site backup in different region

## Troubleshooting

### Common Issues

#### Pod Not Starting

Check pod logs:
```bash
kubectl logs -n default my-postgresql-0
kubectl describe pod -n default my-postgresql-0
```

Check PVC status:
```bash
kubectl get pvc -n default
```

#### Connection Issues

Verify service:
```bash
kubectl get svc -n default my-postgresql
```

Test connection from within cluster:
```bash
kubectl run -it --rm debug --image=postgres:16.4-alpine --restart=Never -- \
  psql -h my-postgresql -U postgres -d postgres
```

#### Backup Failures

Check CronJob status:
```bash
kubectl get cronjobs -n default
kubectl get jobs -n default
kubectl logs -n default job/my-postgresql-backup-xxxxx
```

## Upgrading

### Chart Upgrades

The chart includes automatic pre-upgrade backup hooks to protect your data:

```bash
# Standard upgrade
helm upgrade my-postgresql codefuturist/postgresql -f values.yaml

# Upgrade with specific version
helm upgrade my-postgresql codefuturist/postgresql --version 1.1.0 -f values.yaml

# Dry-run to test upgrade
helm upgrade my-postgresql codefuturist/postgresql -f values.yaml --dry-run --debug
```

### Zero-Downtime Upgrades

For minimal disruption:

1. **Enable PDB**: Ensure Pod Disruption Budget is configured
2. **Use StatefulSet**: For rolling updates with replicas
3. **Test in Staging**: Always test upgrades in non-production first
4. **Monitor**: Watch pod status during upgrade

```yaml
pdb:
  enabled: true
  minAvailable: 1

statefulset:
  enabled: true
  updateStrategy:
    type: RollingUpdate
```

### Breaking Changes

#### From 0.x to 1.x

- Secret management now uses `lookup` function to preserve passwords
- StatefulSet now uses volumeClaimTemplates instead of shared PVC
- New `hostAuthMethod` parameter (defaults to `scram-sha-256`)
- Extensions must be explicitly listed in `postgresql.extensions`

### Migration Guide

#### From Bitnami PostgreSQL Chart

1. Export data from existing installation
2. Create new installation with this chart
3. Import data into new installation
4. Update application connection strings
5. Verify functionality
6. Remove old installation

### Major Version Upgrade

For PostgreSQL major version upgrades:

1. Back up your database
2. Create a logical dump:
```bash
kubectl exec -it my-postgresql-0 -- pg_dumpall -U postgres > backup.sql
```
3. Update the chart with new version
4. Restore the dump if needed

## Uninstallation

```bash
# Uninstall the release
helm uninstall my-postgresql

# Delete PVCs (if you want to remove data)
kubectl delete pvc -l app.kubernetes.io/instance=my-postgresql
```

## Development

### Testing

```bash
# Lint the chart
helm lint charts/postgresql

# Render templates
helm template my-postgresql charts/postgresql -f values.yaml

# Install with dry-run
helm install my-postgresql charts/postgresql --dry-run --debug
```

## Contributing

Contributions welcome! Please see [CONTRIBUTING.md](../../docs/CONTRIBUTING.md).

## Support

For bug reports, feature requests, and general questions:

- **GitHub Issues**: [Report a bug or request a feature](https://github.com/codefuturist/helm-charts/issues)
- **GitHub Discussions**: [Ask questions and discuss ideas](https://github.com/codefuturist/helm-charts/discussions)
- **PostgreSQL Documentation**: [Official PostgreSQL Documentation](https://www.postgresql.org/docs/)

## License

This Helm chart is licensed under the [Apache License 2.0](../../LICENSE).

## Maintainers

| Name | Email | GitHub |
|------|-------|--------|
| codefuturist | - | [@codefuturist](https://github.com/codefuturist) |

## Source Code

- **Chart Repository**: <https://github.com/codefuturist/helm-charts/tree/main/charts/postgresql>

## Credits

This chart was inspired by and follows best practices from:
- [Bitnami PostgreSQL Chart](https://github.com/bitnami/charts/tree/main/bitnami/postgresql)
- [PostgreSQL Official Documentation](https://www.postgresql.org/docs/)
- [Kubernetes Best Practices](https://kubernetes.io/docs/concepts/configuration/overview/)

## Changelog

See [CHANGELOG.md](../../docs/CHANGELOG.md) for version history and changes.
