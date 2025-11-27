# postgresql

![Version: 1.7.0](https://img.shields.io/badge/Version-1.7.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 16.4](https://img.shields.io/badge/AppVersion-16.4-informational?style=flat-square)

A production-ready Helm chart for PostgreSQL database with advanced features including replication, backups, monitoring, and security

**Homepage:** <https://www.postgresql.org/>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| codefuturist | <58808821+codefuturist@users.noreply.github.com> |  |

## Source Code

* <https://github.com/postgres/postgres>
* <https://github.com/codefuturist/helm-charts>

## Values

### Global Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| namespaceOverride | string | `""` | Override the namespace for all resources. |
| componentOverride | string | `""` | Override the component label for all resources. |
| partOfOverride | string | `""` | Override the partOf label for all resources. |
| applicationName | string | `{{ .Chart.Name }}` | Application name. |
| additionalLabels | tpl/object | `{}` | Additional labels for all resources. |
| additionalAnnotations | tpl/object | `{}` | Additional annotations for all resources. |
| diagnosticMode | object | `{"args":["infinity"],"command":["sleep"],"enabled":false}` | Diagnostic mode configuration |

### PostgreSQL Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| postgresql.version | string | `"16.4"` | PostgreSQL version/image tag |
| postgresql.image | string | `{"digest":"","pullPolicy":"IfNotPresent","repository":"postgres","tag":"16.4-alpine"}` | PostgreSQL image repository |
| postgresql.imagePullSecrets | object | `[]` | Image pull secrets |
| postgresql.database | string | `"postgres"` | PostgreSQL database name |
| postgresql.username | string | `"postgres"` | PostgreSQL username |
| postgresql.password | string | `""` | PostgreSQL password (if not using existingSecret) |
| postgresql.hostAuthMethod | string | `"scram-sha-256"` | PostgreSQL host authentication method Options: scram-sha-256, md5, password, trust |
| postgresql.existingSecret | string | `""` | Reference to existing secret containing PostgreSQL password |
| postgresql.existingSecretPasswordKey | string | `"postgresql-password"` | Key in existing secret containing the password |
| postgresql.postgresPassword | string | `""` | PostgreSQL postgres user password (superuser) |
| postgresql.existingPostgresSecret | string | `""` | Reference to existing secret containing postgres password |
| postgresql.existingPostgresPasswordKey | string | `"postgresql-postgres-password"` | Key in existing secret containing the postgres password |
| postgresql.auth | object | `{"passwordFilesPath":"/opt/bitnami/postgresql/secrets","usePasswordFiles":true}` | Password security configuration |
| postgresql.preInitScripts | object | `{}` | Pre-initialization scripts (run BEFORE database initialization) |
| postgresql.config | object | `{"checkpoint_completion_target":"0.9","default_statistics_target":"100","effective_cache_size":"1GB","effective_io_concurrency":"200","hot_standby":"on","hot_standby_feedback":"on","huge_pages":"try","log_autovacuum_min_duration":"0","log_checkpoints":"on","log_connections":"on","log_destination":"stderr","log_disconnections":"on","log_error_verbosity":"default","log_line_prefix":"%m [%p] %q%u@%d ","log_lock_waits":"on","log_min_duration_statement":"1000","log_temp_files":"0","logging_collector":"off","maintenance_work_mem":"64MB","max_connections":"100","max_parallel_maintenance_workers":"2","max_parallel_workers":"4","max_parallel_workers_per_gather":"2","max_replication_slots":"10","max_wal_senders":"10","max_wal_size":"4GB","max_worker_processes":"4","min_wal_size":"1GB","password_encryption":"scram-sha-256","random_page_cost":"1.1","shared_buffers":"256MB","ssl":"off","wal_buffers":"16MB","wal_level":"replica","work_mem":"2621kB"}` | PostgreSQL configuration parameters IMPORTANT: For dynamic user sync (CronJob) or external connections, set listen_addresses: "*" |
| postgresql.customConfig | string | `""` | Custom PostgreSQL configuration (postgresql.conf) |
| postgresql.customPgHba | string | `""` | Custom pg_hba.conf configuration |
| postgresql.extensions | array | `["pg_stat_statements","pgcrypto"]` | PostgreSQL extensions to enable |
| postgresql.initScripts | array | `{}` | Init scripts to run on first boot |
| postgresql.additionalDatabases | array | `[]` | Additional databases to create on first boot |
| postgresql.additionalUsers | array | `[]` | Additional users to create on first boot |
| postgresql.externalResources | object | `{"databasesConfigMap":{"key":"databases.yaml","name":"","namespace":""},"enabled":false,"usersConfigMap":{"key":"users.yaml","name":"","namespace":""},"usersSecret":{"name":"","namespace":"","passwordKeys":{}}}` | External Kubernetes resources to read databases/users from |
| postgresql.env | array | `[]` | Additional environment variables |
| postgresql.envFrom | object | `[]` | Additional environment variables from secrets or configmaps |

### Deployment Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| deployment.replicas | int | `1` | Number of PostgreSQL replicas |
| deployment.strategy | string | `{"type":"Recreate"}` | Deployment strategy |
| deployment.podAnnotations | object | `{"configmap.reloader.stakater.com/reload":"postgresql-config","prometheus.io/path":"/metrics","prometheus.io/port":"9187","prometheus.io/scrape":"false","secret.reloader.stakater.com/reload":"postgresql"}` | Pod annotations |
| deployment.podLabels | object | `{"app.kubernetes.io/component":"database","app.kubernetes.io/part-of":"postgresql"}` | Pod labels |
| deployment.podSecurityContext | object | `{"fsGroup":999,"fsGroupChangePolicy":"OnRootMismatch"}` | Security context for the pod |
| deployment.securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"readOnlyRootFilesystem":false,"runAsGroup":999,"runAsNonRoot":true,"runAsUser":999}` | Security context for the container |
| deployment.resources | object | `{"limits":{},"requests":{"cpu":"10m","memory":"128Mi"}}` | Resource limits and requests Minimal requests to allow scheduling, no limits to allow bursting |
| deployment.livenessProbe | object | `{"enabled":true,"exec":{"command":["/bin/sh","-c","exec pg_isready -U ${POSTGRES_USER} -d ${POSTGRES_DB} -q"]},"failureThreshold":6,"initialDelaySeconds":30,"periodSeconds":10,"successThreshold":1,"timeoutSeconds":5}` | Liveness probe configuration |
| deployment.readinessProbe | object | `{"enabled":true,"exec":{"command":["/bin/sh","-c","exec pg_isready -U ${POSTGRES_USER} -d ${POSTGRES_DB} -q"]},"failureThreshold":6,"initialDelaySeconds":5,"periodSeconds":10,"successThreshold":1,"timeoutSeconds":5}` | Readiness probe configuration |
| deployment.startupProbe | object | `{"enabled":true,"exec":{"command":["/bin/sh","-c","exec pg_isready -U ${POSTGRES_USER} -d ${POSTGRES_DB} -q"]},"failureThreshold":30,"initialDelaySeconds":0,"periodSeconds":10,"successThreshold":1,"timeoutSeconds":5}` | Startup probe configuration |
| deployment.nodeSelector | object | `{}` | Node selector |
| deployment.tolerations | array | `[]` | Tolerations |
| deployment.affinity | object | `{}` | Affinity rules |
| deployment.priorityClassName | string | `""` | Priority class name |
| deployment.serviceAccountName | string | `""` | Service account name |
| deployment.terminationGracePeriodSeconds | int | `30` | Termination grace period |
| deployment.topologySpreadConstraints | array | `[]` | Topology spread constraints |
| deployment.dnsPolicy | string | `"ClusterFirst"` | DNS policy |
| deployment.dnsConfig | object | `{}` | DNS config |
| deployment.hostAliases | array | `[]` | Host aliases |
| deployment.initContainers | array | `[]` | Init containers |
| deployment.sidecarContainers | array | `[]` | Sidecar containers |
| deployment.lifecycle | object | `{"preStop":{"exec":{"command":["/bin/sh","-c","# Wait for active connections to close gracefully\npg_ctl stop -D ${PGDATA} -m smart -t 60 || pg_ctl stop -D ${PGDATA} -m fast -t 30\n"]}}}` | Lifecycle hooks for graceful shutdown |

### StatefulSet Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| statefulset.enabled | bool | `false` | Use StatefulSet instead of Deployment |
| statefulset.serviceName | string | `"postgresql"` | Service name for StatefulSet |
| statefulset.podManagementPolicy | string | `"OrderedReady"` | Pod management policy |
| statefulset.updateStrategy | object | `{"type":"RollingUpdate"}` | Update strategy |

### Persistence Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| persistence.enabled | bool | `true` | Enable persistence using PVC |
| persistence.existingClaim | string | `""` | Use existing PVC |
| persistence.storageClass | string | `""` | Storage class name |
| persistence.accessModes | array | `["ReadWriteOnce"]` | Access modes |
| persistence.size | string | `"2Gi"` | Size of the volume |
| persistence.annotations | object | `{}` | Annotations for PVC |
| persistence.selector | object | `{}` | Selector for PVC |
| persistence.mountPath | string | `"/var/lib/postgresql/data"` | Mount path for data |
| persistence.subPath | string | `""` | Sub path inside the volume |
| persistence.retentionPolicy | object | `{"enabled":false,"whenDeleted":"Retain","whenScaled":"Retain"}` | PVC retention policy (requires Kubernetes 1.23+) |

### Service Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| service.enabled | bool | `true` | Enable service |
| service.type | string | `"ClusterIP"` | Service type |
| service.port | int | `5432` | PostgreSQL service port |
| service.targetPort | int | `5432` | PostgreSQL container port |
| service.nodePort | int | `""` | Node port (if service type is NodePort) |
| service.loadBalancerIP | string | `""` | Load balancer IP (if service type is LoadBalancer) |
| service.loadBalancerSourceRanges | array | `[]` | Load balancer source ranges |
| service.externalTrafficPolicy | string | `""` | External traffic policy |
| service.clusterIP | string | `""` | Cluster IP |
| service.annotations | object | `{}` | Service annotations |
| service.labels | object | `{}` | Service labels |
| service.sessionAffinity | string | `"None"` | Session affinity |
| service.sessionAffinityConfig | object | `{}` | Session affinity config |

### ServiceAccount Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| serviceAccount.create | bool | `true` | Create service account |
| serviceAccount.name | string | `""` | Service account name |
| serviceAccount.annotations | object | `{}` | Service account annotations |
| serviceAccount.automountServiceAccountToken | bool | `false` | Automount service account token |

### RBAC Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| rbac.create | bool | `false` | Create RBAC resources |
| rbac.rules | array | `[]` | Additional rules for the role |

### NetworkPolicy Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| networkPolicy.enabled | bool | `false` | Enable network policy |
| networkPolicy.ingress | array | `[]` | Ingress rules |
| networkPolicy.egress | array | `[]` | Egress rules |

### PDB Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| pdb.enabled | bool | `false` | Enable PodDisruptionBudget |
| pdb.minAvailable | int | `1` | Minimum available pods |
| pdb.maxUnavailable | string | `""` | Maximum unavailable pods |

### HPA Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| hpa.enabled | bool | `false` | Enable HPA (not recommended for databases) |
| hpa.minReplicas | int | `1` | Minimum replicas |
| hpa.maxReplicas | int | `3` | Maximum replicas |
| hpa.targetCPUUtilizationPercentage | int | `80` | Target CPU utilization percentage |
| hpa.targetMemoryUtilizationPercentage | int | `80` | Target memory utilization percentage |

### VPA Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| vpa.enabled | bool | `false` | Enable VPA |
| vpa.updateMode | string | `"Auto"` | Update mode (Off, Initial, Recreate, Auto) |
| vpa.resourcePolicy | object | `{}` | Resource policy |

### Monitoring Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| monitoring.enabled | bool | `false` | Enable monitoring |
| monitoring.serviceMonitor.enabled | bool | `false` | Enable ServiceMonitor for Prometheus Operator |
| monitoring.serviceMonitor.namespace | string | `""` | Namespace for ServiceMonitor |
| monitoring.serviceMonitor.interval | string | `"30s"` | Scrape interval |
| monitoring.serviceMonitor.scrapeTimeout | string | `"10s"` | Scrape timeout |
| monitoring.serviceMonitor.labels | object | `{}` | Additional labels |
| monitoring.serviceMonitor.metricRelabelings | object | `[]` | Metric relabelings |
| monitoring.serviceMonitor.relabelings | object | `[]` | Relabelings |
| monitoring.prometheusRule.enabled | bool | `false` | Enable PrometheusRule for alerts |
| monitoring.prometheusRule.namespace | string | `""` | Namespace for PrometheusRule |
| monitoring.prometheusRule.labels | object | `{}` | Additional labels |
| monitoring.prometheusRule.rules | array | `[]` | Alert rules |
| monitoring.grafanaDashboard.enabled | bool | `false` | Enable Grafana Dashboard ConfigMap |
| monitoring.grafanaDashboard.namespace | string | `""` | Namespace for Grafana Dashboard |
| monitoring.grafanaDashboard.labels | object | `{"grafana_dashboard":"1"}` | Additional labels |

### Backup Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| backup.enabled | bool | `false` | Enable automated backups |
| backup.schedule | string | `"0 2 * * *"` | Backup schedule (cron format) |
| backup.successfulJobsHistoryLimit | int | `3` | Number of successful backups to keep |
| backup.failedJobsHistoryLimit | int | `1` | Number of failed backups to keep |
| backup.image | object | `{"pullPolicy":"IfNotPresent","repository":"postgres","tag":"16.4-alpine"}` | Backup image configuration |
| backup.resources | object | `{"limits":{},"requests":{"cpu":"10m","memory":"64Mi"}}` | Backup resources Minimal requests to allow scheduling, no limits to allow bursting |
| backup.persistence | object | `{"accessModes":["ReadWriteOnce"],"annotations":{},"enabled":true,"mountPath":"/backups","size":"10Gi","storageClass":""}` | Backup persistence configuration |
| backup.s3 | object | `{"accessKeyId":"","bucket":"","enabled":false,"endpoint":"","existingSecret":"","region":"us-east-1","secretAccessKey":""}` | S3 backup configuration |
| backup.retentionDays | string | `7` | Backup retention (days) |
| backup.wal | object | `{"archiveCommand":"","cleanup":{"enabled":true,"failedJobsHistoryLimit":1,"schedule":"0 3 * * *","successfulJobsHistoryLimit":1},"compression":"gzip","enabled":false,"method":"simple","persistence":{"accessModes":["ReadWriteOnce"],"annotations":{},"enabled":true,"mountPath":"/wal-archive","size":"20Gi","storageClass":""},"pgbackrest":{"config":{},"image":{"pullPolicy":"IfNotPresent","repository":"pgbackrest/pgbackrest","tag":"2.49"},"resources":{"limits":{},"requests":{"cpu":"10m","memory":"32Mi"}}},"restoreCommand":"","retentionDays":14,"storage":{"azure":{"container":"","existingSecret":"","prefix":"wal-archive","storageAccount":""},"gcs":{"bucket":"","credentialsSecret":"","prefix":"wal-archive"},"s3":{"accessKeyId":"","bucket":"","endpoint":"","existingSecret":"","prefix":"wal-archive","region":"us-east-1","secretAccessKey":""},"type":"s3"},"walg":{"env":{},"image":{"pullPolicy":"IfNotPresent","repository":"wal-g/wal-g","tag":"v3.0.0"},"resources":{"limits":{},"requests":{"cpu":"10m","memory":"32Mi"}}}}` | WAL (Write-Ahead Log) archiving for incremental backups |

### Recovery Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| recovery.enabled | bool | `false` | Enable recovery mode WARNING: This will restore from backup on install/upgrade! |
| recovery.mode | string | `"full"` | Recovery mode: 'full' or 'pitr' full: Restore from full backup only pitr: Point-in-Time Recovery using full backup + WAL archives |
| recovery.source | string | `"backup"` | Recovery source: 'backup' (PVC) or 's3' |
| recovery.backupFile | string | `""` | Specific backup file to restore (optional) If not specified, uses the latest backup Example: "backup-2024-11-12-02-00-00.sql.gz" |
| recovery.targetTime | string | `""` | Target time for PITR (mode: pitr only) Format: 'YYYY-MM-DD HH:MM:SS' (UTC) Example: "2024-11-12 14:30:00" |
| recovery.tempStorageSize | string | `"50Gi"` | Temporary storage size for recovery process Should be >= database size |
| recovery.s3 | object | `{"backupFile":""}` | S3 recovery configuration (source: s3) |

### TLS Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| tls.enabled | bool | `false` | Enable TLS |
| tls.certificateSecret | string | `""` | Certificate secret name |
| tls.certFile | string | `"tls.crt"` | Certificate file name in secret |
| tls.certKeyFile | string | `"tls.key"` | Certificate key file name in secret |
| tls.caCertFile | string | `"ca.crt"` | CA certificate file name in secret |
| tls.certificate | object | `{"dnsNames":[],"duration":"2160h","enabled":false,"issuerRef":{"kind":"ClusterIssuer","name":""},"renewBefore":"360h"}` | Certificate configuration for cert-manager |

### Replication Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| replication.enabled | bool | `false` | Enable replication (requires StatefulSet) |
| replication.readReplicas | int | `1` | Number of read replicas |
| replication.user | string | `"replicator"` | Replication user |
| replication.password | string | `""` | Replication password |
| replication.existingSecret | string | `""` | Existing secret for replication credentials |
| replication.synchronousCommit | bool | `false` | Synchronous commit |
| replication.numSynchronousReplicas | int | `0` | Number of synchronous replicas |
| replication.slots | object | `{"autoCreate":true,"enabled":true,"prefix":"replica"}` | Replication slot configuration |
| replication.replica | object | `{"hotStandbyFeedback":true,"maxStandbyArchiveDelay":30000,"maxStandbyStreamingDelay":30000,"walReceiverStatusInterval":10,"walReceiverTimeout":60000}` | Replica configuration |
| replication.primary | object | `{"createService":true,"serviceName":"","servicePort":5432}` | Primary server configuration |
| replication.replicaService | object | `{"annotations":{},"enabled":true,"labels":{},"loadBalancerSourceRanges":[],"nameSuffix":"read","port":5432,"type":"ClusterIP"}` | Replica service configuration |
| replication.monitoring | object | `{"delayThresholdSeconds":30,"enabled":true,"lagThresholdMB":100}` | Replication monitoring |
| replication.failover | object | `{"enabled":true,"triggerFileEnabled":false,"triggerFilePath":"/tmp/postgresql.trigger"}` | Automatic failover preparation |
| replication.advanced | object | `{"archiveModeOnReplicas":false,"maxReplicationSlots":10,"maxWalSenders":10,"walKeepSize":1024}` | Advanced replication settings |

### Metrics Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| metrics.enabled | bool | `false` | Enable PostgreSQL metrics exporter |
| metrics.image | object | `{"pullPolicy":"IfNotPresent","repository":"quay.io/prometheuscommunity/postgres-exporter","tag":"v0.18.1"}` | Metrics exporter image |
| metrics.port | int | `9187` | Metrics port |
| metrics.resources | object | `{"limits":{},"requests":{"cpu":"5m","memory":"32Mi"}}` | Metrics exporter resources Minimal requests to allow scheduling, no limits to allow bursting |
| metrics.customQueries | object | `{}` | Custom queries for metrics |

### PgBouncer Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| pgbouncer.enabled | bool | `false` | Enable PgBouncer connection pooler |
| pgbouncer.replicas | int | `1` | Number of PgBouncer replicas |
| pgbouncer.image | object | `{"pullPolicy":"IfNotPresent","repository":"edoburu/pgbouncer","tag":"1.21.0"}` | PgBouncer image |
| pgbouncer.port | int | `5432` | PgBouncer port |
| pgbouncer.config | object | `{"default_pool_size":25,"max_client_conn":1000,"max_db_connections":100,"max_user_connections":100,"min_pool_size":5,"pool_mode":"transaction","reserve_pool_size":5,"reserve_pool_timeout":3}` | PgBouncer configuration |
| pgbouncer.resources | object | `{"limits":{},"requests":{"cpu":"10m","memory":"32Mi"}}` | PgBouncer resources Minimal requests to allow scheduling, no limits to allow bursting |

### Service Mesh Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| serviceMesh.enabled | bool | `false` | Enable service mesh integration |
| serviceMesh.provider | string | `"istio"` | Service mesh provider (istio, linkerd, consul) |
| serviceMesh.istio | object | `{"injection":true,"mtls":{"mode":"PERMISSIVE"},"trafficPolicy":{"connectionPool":{"http":{"http1MaxPendingRequests":100,"http2MaxRequests":100},"tcp":{"maxConnections":100}},"loadBalancer":{"simple":"LEAST_CONN"}}}` | Istio-specific configuration |
| serviceMesh.linkerd | object | `{"injection":true,"skipInboundPorts":"","skipOutboundPorts":""}` | Linkerd-specific configuration |

### Kubernetes Integration Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| kubernetesIntegration.autoReload | bool | `{"enabled":false}` | Enable automatic config reload on ConfigMap/Secret changes |
| kubernetesIntegration.disruptionWindows | object | `{"enabled":false}` | Pod disruption windows for maintenance |
| kubernetesIntegration.enhancedEvents | bool | `true` | Enable enhanced Kubernetes event generation |
| kubernetesIntegration.resourceRecommendations | object | `{"enabled":false,"updateMode":"Off"}` | Resource recommendations via VPA |

### User Management Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| userManagement.dynamicSync | object | `{"configMapName":"","enabled":false,"failedJobsHistoryLimit":3,"podAnnotations":{},"resources":{"limits":{},"requests":{"cpu":"5m","memory":"16Mi"}},"schedule":"*/15 * * * *","successfulJobsHistoryLimit":3,"suspend":false,"watchExternalResources":{"configMaps":[],"enabled":false}}` | Dynamic user synchronization without pod restart |

### Extra Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| extraObjects.objects | array | `[]` | Extra Kubernetes objects to create |

### Other Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| diagnosticMode.enabled | bool | `false` | Enable diagnostic mode (disables probes, overrides command) Useful for debugging container startup issues |
| diagnosticMode.command | array | `["sleep"]` | Command override for diagnostic mode |
| diagnosticMode.args | array | `["infinity"]` | Args override for diagnostic mode |
| postgresql.auth.usePasswordFiles | bool | `true` | Use password files instead of environment variables (more secure) When enabled, passwords are mounted as files from secrets instead of being exposed as env vars This prevents password exposure in process lists and kubectl describe output |
| postgresql.auth.passwordFilesPath | string | `"/opt/bitnami/postgresql/secrets"` | Path where password files will be mounted |
| postgresql.externalResources.enabled | bool | `false` | Enable reading from external ConfigMaps/Secrets |
| postgresql.externalResources.databasesConfigMap | object | `{"key":"databases.yaml","name":"","namespace":""}` | ConfigMap containing database definitions |
| postgresql.externalResources.usersConfigMap | object | `{"key":"users.yaml","name":"","namespace":""}` | ConfigMap containing user definitions |
| postgresql.externalResources.usersSecret | object | `{"name":"","namespace":"","passwordKeys":{}}` | Secret containing user passwords |
| persistence.retentionPolicy.enabled | bool | `false` | Enable PVC retention policy |
| persistence.retentionPolicy.whenScaled | string | `"Retain"` | Volume retention behavior when the replica count is reduced Options: Retain (keep PVCs), Delete (remove PVCs) |
| persistence.retentionPolicy.whenDeleted | string | `"Retain"` | Volume retention behavior when the StatefulSet is deleted Options: Retain (keep PVCs), Delete (remove PVCs) |
| backup.wal.enabled | bool | `false` | Enable WAL archiving for incremental backups |
| backup.wal.method | string | `"simple"` | WAL archive method: 'simple' (cp command), 'wal-g', 'wal-e', 'pgbackrest' simple: Copy WAL files to PVC storage wal-g: Modern tool with cloud storage support (recommended) wal-e: Legacy tool with S3 support pgbackrest: Advanced backup and restore tool |
| backup.wal.compression | string | `"gzip"` | Compression for WAL files: 'none', 'gzip', 'lz4', 'zstd' |
| backup.wal.retentionDays | int | `14` | WAL retention period in days |
| backup.wal.persistence | object | `{"accessModes":["ReadWriteOnce"],"annotations":{},"enabled":true,"mountPath":"/wal-archive","size":"20Gi","storageClass":""}` | WAL archive persistence (used with 'simple' method) |
| backup.wal.storage | object | `{"azure":{"container":"","existingSecret":"","prefix":"wal-archive","storageAccount":""},"gcs":{"bucket":"","credentialsSecret":"","prefix":"wal-archive"},"s3":{"accessKeyId":"","bucket":"","endpoint":"","existingSecret":"","prefix":"wal-archive","region":"us-east-1","secretAccessKey":""},"type":"s3"}` | Cloud storage configuration (for wal-g, wal-e, pgbackrest) |
| backup.wal.storage.type | string | `"s3"` | Storage type: 's3', 'gcs', 'azure', 'file' |
| backup.wal.storage.s3 | object | `{"accessKeyId":"","bucket":"","endpoint":"","existingSecret":"","prefix":"wal-archive","region":"us-east-1","secretAccessKey":""}` | S3 configuration |
| backup.wal.storage.gcs | object | `{"bucket":"","credentialsSecret":"","prefix":"wal-archive"}` | GCS configuration |
| backup.wal.storage.azure | object | `{"container":"","existingSecret":"","prefix":"wal-archive","storageAccount":""}` | Azure configuration |
| backup.wal.walg | object | `{"env":{},"image":{"pullPolicy":"IfNotPresent","repository":"wal-g/wal-g","tag":"v3.0.0"},"resources":{"limits":{},"requests":{"cpu":"10m","memory":"32Mi"}}}` | WAL-G specific configuration |
| backup.wal.walg.image | string | `{"pullPolicy":"IfNotPresent","repository":"wal-g/wal-g","tag":"v3.0.0"}` | WAL-G image |
| backup.wal.walg.resources | object | `{"limits":{},"requests":{"cpu":"10m","memory":"32Mi"}}` | WAL-G resources Minimal requests to allow scheduling, no limits to allow bursting |
| backup.wal.walg.env | object | `{}` | Additional environment variables for WAL-G |
| backup.wal.pgbackrest | object | `{"config":{},"image":{"pullPolicy":"IfNotPresent","repository":"pgbackrest/pgbackrest","tag":"2.49"},"resources":{"limits":{},"requests":{"cpu":"10m","memory":"32Mi"}}}` | pgBackRest specific configuration |
| backup.wal.pgbackrest.image | string | `{"pullPolicy":"IfNotPresent","repository":"pgbackrest/pgbackrest","tag":"2.49"}` | pgBackRest image |
| backup.wal.pgbackrest.resources | object | `{"limits":{},"requests":{"cpu":"10m","memory":"32Mi"}}` | pgBackRest resources Minimal requests to allow scheduling, no limits to allow bursting |
| backup.wal.pgbackrest.config | object | `{}` | pgBackRest configuration |
| backup.wal.archiveCommand | string | `""` | Archive command override (advanced users) Leave empty to use method-specific default |
| backup.wal.restoreCommand | string | `""` | Restore command override (advanced users) Leave empty to use method-specific default |
| backup.wal.cleanup | object | `{"enabled":true,"failedJobsHistoryLimit":1,"schedule":"0 3 * * *","successfulJobsHistoryLimit":1}` | WAL archiving job schedule (cleanup old WAL files) |
| backup.wal.cleanup.enabled | bool | `true` | Enable WAL cleanup job |
| backup.wal.cleanup.schedule | string | `"0 3 * * *"` | Cleanup schedule (cron format) |
| backup.wal.cleanup.successfulJobsHistoryLimit | int | `1` | Number of successful cleanup jobs to keep |
| backup.wal.cleanup.failedJobsHistoryLimit | int | `1` | Number of failed cleanup jobs to keep |
| recovery.s3.backupFile | string | `""` | Specific S3 backup file (optional) |
| replication.slots.enabled | bool | `true` | Enable replication slots for reliable streaming |
| replication.slots.prefix | string | `"replica"` | Replication slot name prefix |
| replication.slots.autoCreate | bool | `true` | Auto-create replication slots |
| replication.replica.maxStandbyStreamingDelay | int | `30000` | Max standby streaming delay in milliseconds |
| replication.replica.maxStandbyArchiveDelay | int | `30000` | Max standby archive delay in milliseconds |
| replication.replica.hotStandbyFeedback | bool | `true` | Enable hot standby feedback |
| replication.replica.walReceiverTimeout | int | `60000` | WAL receiver timeout in milliseconds |
| replication.replica.walReceiverStatusInterval | int | `10` | WAL receiver status interval in seconds |
| replication.primary.serviceName | string | `""` | Service name for primary server Leave empty to auto-generate based on release name |
| replication.primary.servicePort | int | `5432` | Service port for primary server |
| replication.primary.createService | bool | `true` | Create dedicated primary service |
| replication.replicaService.enabled | bool | `true` | Create read-only service for replicas |
| replication.replicaService.type | string | `"ClusterIP"` | Service type |
| replication.replicaService.port | int | `5432` | Service port |
| replication.replicaService.nameSuffix | string | `"read"` | Service name suffix Full name will be: <release-name>-postgresql-read |
| replication.replicaService.annotations | object | `{}` | Service annotations |
| replication.replicaService.labels | object | `{}` | Service labels |
| replication.replicaService.loadBalancerSourceRanges | string | `[]` | Load balancer source ranges |
| replication.monitoring.enabled | bool | `true` | Enable replication lag monitoring |
| replication.monitoring.lagThresholdMB | int | `100` | Alert threshold for replication lag in MB |
| replication.monitoring.delayThresholdSeconds | int | `30` | Alert threshold for replication delay in seconds |
| replication.failover.enabled | bool | `true` | Enable automatic promotion configuration Configures replicas to be able to promote automatically |
| replication.failover.triggerFileEnabled | bool | `false` | Create trigger file for manual promotion |
| replication.failover.triggerFilePath | string | `"/tmp/postgresql.trigger"` | Trigger file path |
| replication.advanced.maxReplicationSlots | int | `10` | Maximum number of replication slots |
| replication.advanced.maxWalSenders | int | `10` | Maximum WAL senders |
| replication.advanced.walKeepSize | int | `1024` | WAL keep size in MB |
| replication.advanced.archiveModeOnReplicas | bool | `false` | Enable archive mode for replicas |
| userManagement.dynamicSync.enabled | bool | `false` | Enable dynamic user/database synchronization via CronJob |
| userManagement.dynamicSync.schedule | string | `"*/15 * * * *"` | Cron schedule for sync job Examples: - "*/5 * * * *" - Every 5 minutes - "0 * * * *" - Every hour - "@hourly" - Every hour Can also be triggered manually: kubectl create job --from=cronjob/<name> <job-name> |
| userManagement.dynamicSync.suspend | bool | `false` | Suspend the CronJob (useful for manual-only execution) |
| userManagement.dynamicSync.successfulJobsHistoryLimit | int | `3` | Number of successful jobs to keep |
| userManagement.dynamicSync.failedJobsHistoryLimit | int | `3` | Number of failed jobs to keep |
| userManagement.dynamicSync.configMapName | string | `""` | ConfigMap containing SQL scripts for user/database sync The ConfigMap should contain .sql files that will be executed Scripts should be idempotent (use IF NOT EXISTS checks) |
| userManagement.dynamicSync.watchExternalResources | object | `{"configMaps":[],"enabled":false}` | Watch external ConfigMaps for user/database definitions (cross-namespace) |
| userManagement.dynamicSync.podAnnotations | object | `{}` | Pod annotations for the sync job |
| userManagement.dynamicSync.resources | object | `{"limits":{},"requests":{"cpu":"5m","memory":"16Mi"}}` | Resources for the sync job container Minimal requests to allow scheduling, no limits to allow bursting |

