# restic-backup

![Version: 1.2.1](https://img.shields.io/badge/Version-1.2.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.17.3](https://img.shields.io/badge/AppVersion-0.17.3-informational?style=flat-square)

A user-friendly Helm chart for automated Kubernetes volume backups using restic with support for multiple storage backends and flexible scheduling

**Homepage:** <https://restic.net>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| codefuturist | <58808821+codefuturist@users.noreply.github.com> |  |

## Source Code

* <https://github.com/restic/restic>
* <https://github.com/codefuturist/helm-charts>

## Values

### Global Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalLabels | tpl/object | `{}` | Additional labels for all resources. |
| applicationName | string | `{{ .Chart.Name }}` | Application name. |
| componentOverride | string | `""` | Override the component label for all resources. |
| namespaceOverride | string | `""` | Override the namespace for all resources. |
| partOfOverride | string | `""` | Override the partOf label for all resources. |

### Backup Volume Configuration

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| backupVolume.custom | object | `{}` | Custom volume specification (when type is custom). Allows defining any Kubernetes volume type |
| backupVolume.emptyDir | object | `{"sizeLimit":"10Gi"}` | EmptyDir configuration (when type is emptyDir). Note: Not recommended for production as data is ephemeral |
| backupVolume.enabled | bool | `true` | Enable dedicated volume for backup repository storage. When enabled, a volume will be automatically mounted at the repository path. This is recommended for local backups and provides out-of-the-box functionality. |
| backupVolume.hostPath | object | `{"path":"/mnt/backup-repository","type":"DirectoryOrCreate"}` | HostPath configuration (when type is hostPath). |
| backupVolume.mountPath | string | `"/backup-repository"` | Mount path for the backup repository volume. Should match the restic.repository path for local backups |
| backupVolume.nfs | object | `{"path":"/backup-repository","readOnly":false,"server":""}` | NFS configuration (when type is nfs). |
| backupVolume.pvc | object | `{"accessModes":["ReadWriteOnce"],"annotations":{},"existingClaim":"","selector":{},"size":"10Gi","storageClassName":""}` | PersistentVolumeClaim configuration for backup repository. |
| backupVolume.type | string | `"pvc"` | Type of volume to use for backup repository. Options: pvc, hostPath, emptyDir, nfs, custom |

### CronJob Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cronjob.activeDeadlineSeconds | int | `3600` | Optional deadline in seconds for job completion (timeout). Set this to prevent long-running backups from running indefinitely |
| cronjob.additionalLabels | object | `{}` | Additional labels for CronJob. |
| cronjob.additionalPodAnnotations | object | `{}` | Additional pod annotations. |
| cronjob.affinity | object | `{}` | Affinity rules for backup pods. |
| cronjob.annotations | object | `{}` | Annotations for CronJob. |
| cronjob.concurrencyPolicy | string | `"Forbid"` | Concurrency policy for backup jobs. Options: Allow, Forbid, Replace |
| cronjob.containerSecurityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"readOnlyRootFilesystem":true,"runAsNonRoot":false}` | Container security context. |
| cronjob.nodeSelector | object | `{}` | Node selector for backup pods. |
| cronjob.resources | object | `{"limits":{},"requests":{"cpu":"10m","memory":"64Mi"}}` | Resource limits and requests. Minimal requests to allow scheduling, no limits to allow bursting |
| cronjob.restartPolicy | string | `"OnFailure"` | Restart policy for backup pods. |
| cronjob.securityContext | object | `{"fsGroup":0,"runAsGroup":0,"runAsNonRoot":false,"runAsUser":0}` | Pod security context. |
| cronjob.startingDeadlineSeconds | int | `300` | Deadline in seconds for starting the job. |
| cronjob.tolerations | list | `[]` | Tolerations for backup pods. |
| cronjob.ttlSecondsAfterFinished | int | `86400` | Optional TTL in seconds for finished jobs (auto-cleanup). |

### Advanced Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| dnsConfig | object | `{}` | DNS configuration for backup pods. |
| dnsPolicy | string | `"ClusterFirst"` | DNS policy for backup pods. |
| envFrom | object | `[]` | Additional environment variables from secrets/configmaps. |
| extraVolumeMounts | list | `[]` | Additional volume mounts for backup container. |
| extraVolumes | list | `[]` | Additional volumes to mount. |
| hostNetwork | bool | `false` | Enable host network mode. |
| priorityClassName | object | `""` | Priority class for backup pods. |

### Hooks Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| hooks.postBackup | object | `[]` | Commands to run after backup. |
| hooks.preBackup | object | `[]` | Commands to run before backup. |

### Image Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| image.imagePullSecrets | list | `[]` | Image pull secrets. |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy. |
| image.repository | string | `"restic/restic"` | Restic image repository. |
| image.tag | string | `""` | Image tag (overrides appVersion from Chart.yaml). |

### Metrics Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| metrics.additionalLabels | object | `{}` | Additional labels for metrics deployment. |
| metrics.affinity | object | `{}` | Affinity rules for metrics exporter. |
| metrics.annotations | object | `{}` | Annotations for metrics deployment. |
| metrics.containerSecurityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"readOnlyRootFilesystem":true,"runAsNonRoot":true}` | Container security context for metrics exporter. |
| metrics.enabled | bool | `false` | Enable metrics exporter for Prometheus monitoring. |
| metrics.image | object | `{"pullPolicy":"IfNotPresent","repository":"python","tag":"3.11-alpine"}` | Metrics exporter image configuration. |
| metrics.nodeSelector | object | `{}` | Node selector for metrics exporter. |
| metrics.podAnnotations | object | `{}` | Additional pod annotations for metrics exporter. |
| metrics.port | int | `9092` | Port for metrics endpoint. |
| metrics.resources | object | `{"limits":{},"requests":{"cpu":"5m","memory":"16Mi"}}` | Resource limits and requests for metrics exporter. Minimal requests to allow scheduling, no limits to allow bursting |
| metrics.scrapeInterval | int | `60` | Interval between metrics collection in seconds. |
| metrics.securityContext | object | `{"fsGroup":65534,"runAsGroup":65534,"runAsNonRoot":true,"runAsUser":65534}` | Security context for metrics exporter pod. |
| metrics.service | object | `{"additionalLabels":{},"annotations":{},"clusterIP":"","port":9092,"type":"ClusterIP"}` | Service configuration for metrics. |
| metrics.tolerations | list | `[]` | Tolerations for metrics exporter. |

### Network Policy Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| networkPolicy.egress | object | `[{"ports":[{"port":53,"protocol":"TCP"},{"port":53,"protocol":"UDP"}],"to":[{"namespaceSelector":{}}]},{"to":[{"namespaceSelector":{}},{"ipBlock":{"cidr":"0.0.0.0/0","except":["169.254.169.254/32"]}}]}]` | Egress rules for network policy. |
| networkPolicy.enabled | bool | `false` | Enable network policy. |
| networkPolicy.ingress | object | `[]` | Ingress rules for network policy. |

### Notifications Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| notifications.email | object | `{"enabled":false,"from":"restic-backup@example.com","smtpHost":"","smtpPasswordSecret":"","smtpPort":587,"smtpUser":"","to":[]}` | Email configuration for notifications. |
| notifications.enabled | bool | `false` | Enable notifications on backup completion/failure. |
| notifications.webhook | object | `{"url":""}` | Webhook configuration for notifications. |

### RBAC Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| rbac.additionalRules | list | `[]` | Additional rules to add to the role. |
| rbac.create | bool | `true` | Create RBAC resources (Role, RoleBinding). |

### Restic Configuration

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| restic.backendEnv | object | `{}` | Backend-specific environment variables. |
| restic.backup | object | `{"enabled":true,"excludes":["*.tmp","*.cache",".DS_Store","lost+found"],"failedJobsHistoryLimit":1,"options":{},"retention":{"enabled":true,"keepDaily":14,"keepLast":7,"keepMonthly":12,"keepWeekly":8,"keepYearly":3},"schedule":"0 2 * * *","successfulJobsHistoryLimit":3,"tags":["kubernetes","automated"]}` | Backup job configuration. |
| restic.backup.excludes | list | `["*.tmp","*.cache",".DS_Store","lost+found"]` | Exclude patterns for backup. |
| restic.backup.failedJobsHistoryLimit | int | `1` | Number of failed jobs to keep. |
| restic.backup.options | object | `{}` | Additional restic backup options. |
| restic.backup.retention | object | `{"enabled":true,"keepDaily":14,"keepLast":7,"keepMonthly":12,"keepWeekly":8,"keepYearly":3}` | Retention policy for backups. |
| restic.backup.schedule | string | `"0 2 * * *"` | Cron schedule for backup job (default: daily at 2 AM). |
| restic.backup.successfulJobsHistoryLimit | int | `3` | Number of successful jobs to keep. |
| restic.backup.tags | list | `["kubernetes","automated"]` | List of tags to apply to backups. |
| restic.check | object | `{"enabled":true,"readData":false,"schedule":"0 3 * * 0"}` | Repository check job configuration. |
| restic.existingSecret | object | `""` | Reference to existing secret containing restic credentials. Keys required: RESTIC_REPOSITORY, RESTIC_PASSWORD Optional backend-specific keys: AWS_ACCESS_KEY_ID, AZURE_ACCOUNT_NAME, etc. |
| restic.init | object | `{"enabled":true}` | Repository initialization job. |
| restic.password | string | `"changeme-to-a-secure-password"` | Restic repository password. Required for encryption. IMPORTANT: Use external secret management in production |
| restic.repository | string | `"/backup-repository"` | Restic repository URL. Supports multiple backends. Examples:   S3: s3:s3.amazonaws.com/bucket-name/path   Azure: azure:container-name:/path   GCS: gs:bucket-name:/path   B2: b2:bucket-name:/path   SFTP: sftp:user@host:/path   REST: rest:http://host:8000/path   Local/PVC: /backup-repository (requires backup volume) |

### Restore Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| restore.enabled | bool | `false` | Enable one-time restore job. |
| restore.snapshotId | string | `"latest"` | Snapshot ID to restore (latest if not specified). |
| restore.targetPath | string | `"/"` | Target path within the volume. |
| restore.targetVolume | string | `""` | Target volume for restore (PVC name - for backward compatibility). |
| restore.targetVolumeConfig | object | `{}` | Target volume configuration for restore (advanced). Supports the same volume types as the main volumes configuration |
| restore.verify | bool | `true` | Verify restored data integrity. |

### Scripts Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| scripts.useConfigMap | bool | `true` | Use ConfigMap for backup scripts instead of inline commands. Enables better maintainability and customization of backup scripts |

### ServiceAccount Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| serviceAccount.annotations | object | `{}` | Annotations for service account. |
| serviceAccount.automountServiceAccountToken | bool | `true` | Automount service account token. |
| serviceAccount.create | bool | `true` | Create service account. |
| serviceAccount.name | string | `""` | Name of existing service account to use. |

### Monitoring Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| serviceMonitor.additionalLabels | object | `{}` | Additional labels for ServiceMonitor. |
| serviceMonitor.enabled | bool | `false` | Enable Prometheus ServiceMonitor. Requires metrics.enabled to be true |
| serviceMonitor.interval | string | `"30s"` | Scrape interval. |
| serviceMonitor.metricRelabelings | list | `[]` | Metric relabeling rules (optional). |
| serviceMonitor.namespace | string | `""` | Namespace for ServiceMonitor (defaults to release namespace). |
| serviceMonitor.path | string | `"/metrics"` | Metrics path (optional). |
| serviceMonitor.relabelings | list | `[]` | Relabeling rules (optional). |
| serviceMonitor.scheme | string | `"http"` | Scheme (http or https). |
| serviceMonitor.scrapeTimeout | string | `"10s"` | Scrape timeout. |
| serviceMonitor.tlsConfig | object | `{}` | TLS configuration (optional). |

### Volumes Configuration

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| volumes | list | `[]` | List of volumes to backup. Supports multiple volume types. |

### Other Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| backupVolume.pvc.accessModes | string | `["ReadWriteOnce"]` | Access mode for the PVC. |
| backupVolume.pvc.annotations | object | `{}` | Additional PVC annotations. |
| backupVolume.pvc.existingClaim | string | `""` | Name of existing PVC to use (leave empty to create new one). |
| backupVolume.pvc.selector | object | `{}` | Resource selector for PVC. |
| backupVolume.pvc.size | string | `"10Gi"` | Storage size for backup repository. |
| backupVolume.pvc.storageClassName | string | `""` | Storage class for the PVC (uses cluster default if empty). |
| cronjob.securityContext.runAsNonRoot | bool | `false` | Run as non-root user when possible. |
| metrics.service.additionalLabels | object | `{}` | Additional labels for service. |
| metrics.service.annotations | object | `{}` | Annotations for service. |
| metrics.service.clusterIP | string | `""` | Cluster IP (optional). |
| metrics.service.port | int | `9092` | Service port. |
| metrics.service.type | string | `"ClusterIP"` | Service type. |
| restic.backup.enabled | bool | `true` | Enable backup job. |
| restic.backup.retention.enabled | bool | `true` | Enable automatic pruning of old backups. |
| restic.backup.retention.keepDaily | int | `14` | Keep daily snapshots for N days. |
| restic.backup.retention.keepLast | int | `7` | Keep last N snapshots. |
| restic.backup.retention.keepMonthly | int | `12` | Keep monthly snapshots for N months. |
| restic.backup.retention.keepWeekly | int | `8` | Keep weekly snapshots for N weeks. |
| restic.backup.retention.keepYearly | int | `3` | Keep yearly snapshots for N years. |
| restic.check.enabled | bool | `true` | Enable repository check job. |
| restic.check.readData | bool | `false` | Read all data packs to verify integrity (slower but thorough). |
| restic.check.schedule | string | `"0 3 * * 0"` | Cron schedule for check job (default: weekly on Sunday at 3 AM). |
| restic.init.enabled | bool | `true` | Enable repository initialization job. |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
