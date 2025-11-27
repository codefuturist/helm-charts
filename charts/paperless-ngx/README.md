# Paperless-ngx Helm Chart

A Helm chart for deploying [Paperless-ngx](https://github.com/paperless-ngx/paperless-ngx), a community-supported supercharged version of paperless based on paperless-ng. This chart provides a production-ready deployment with support for external PostgreSQL and Redis dependencies, separate worker deployments, and comprehensive configuration options.

## Features

- 🚀 **Production-ready deployment** with security best practices
- 🔄 **Separate worker deployment** for Celery task processing
- 🧱 **Bundled Bitnami PostgreSQL & Redis subcharts** or switch to fully external services at any time
- 💾 **Multiple persistence volumes** (data, media, consume, export)
- 🤖 **Paperless-AI companion service** (optional) for automated tagging, classification, and RAG chat backed by OpenAI/Ollama
- 🧠 **Paperless-GPT conversational service** (optional) for summarization, chat, and GPT-powered workflows
- 🔐 **Flexible secret management** (inline or existing secrets)
- 📊 **Monitoring support** with Prometheus ServiceMonitor
- 🌐 **Ingress support** with modern networking.k8s.io/v1 API
- 🛡️ **Network policies** for enhanced security
- ⚡ **Autoscaling** with HorizontalPodAutoscaler
- 🎯 **Pod disruption budgets** for high availability

## Prerequisites

- Kubernetes 1.21+
- Helm 3.0+
- PV provisioner support in the underlying infrastructure
- PostgreSQL 12+ **or** enable the bundled Bitnami PostgreSQL subchart (enabled by default)
- Redis 6.0+ **or** enable the bundled Bitnami Redis subchart (enabled by default)

## Installing the Chart

### With External Database (Recommended)

First, ensure you have PostgreSQL and Redis running (or disable the bundled subcharts). Then install the chart:

```bash
helm install paperless-ngx ./paperless-ngx \
  --set database.postgresql.host=postgresql.default.svc.cluster.local \
  --set database.postgresql.password=your-db-password \
  --set redis.host=redis.default.svc.cluster.local \
  --set config.secretKey=your-secret-key
```

### Using Existing Secrets

```bash
# Create secret with required keys
kubectl create secret generic paperless-secrets \
  --from-literal=secret-key=your-secret-key \
  --from-literal=database-password=your-db-password \
  --from-literal=redis-password=your-redis-password

# Install chart with existing secret
helm install paperless-ngx ./paperless-ngx \
  --set config.existingSecret=paperless-secrets \
  --set database.postgresql.host=postgresql.default.svc.cluster.local \
  --set database.postgresql.existingSecret=paperless-secrets \
  --set redis.host=redis.default.svc.cluster.local \
  --set redis.existingSecret=paperless-secrets
```

### With Ingress

```bash
helm install paperless-ngx ./paperless-ngx \
  --set ingress.enabled=true \
  --set ingress.className=nginx \
  --set "ingress.hosts[0].host=paperless.example.com" \
  --set "ingress.hosts[0].paths[0].path=/" \
  --set "ingress.hosts[0].paths[0].pathType=Prefix" \
  --set config.url=https://paperless.example.com \
  --set "config.csrfTrustedOrigins[0]=https://paperless.example.com"
```

## Uninstalling the Chart

```bash
helm uninstall paperless-ngx
```

This removes all Kubernetes components associated with the chart and deletes the release. Note that PersistentVolumeClaims are not deleted automatically.

## Configuration

The chart aims to expose the same breadth of configuration described in the [upstream Paperless-ngx documentation](https://docs.paperless-ngx.com/configuration/). The highlights below are grouped similarly to the upstream docs. Refer to `values.yaml` for the authoritative/complete list of options.

### Global Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `global.imageRegistry` | Global Docker image registry | `""` |
| `global.imagePullSecrets` | Global Docker registry secret names as an array | `[]` |

### Common Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `nameOverride` | String to partially override paperless-ngx.name | `""` |
| `fullnameOverride` | String to fully override paperless-ngx.fullname | `""` |
| `commonLabels` | Labels to add to all deployed objects | `{}` |
| `commonAnnotations` | Annotations to add to all deployed objects | `{}` |

### Image Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `image.registry` | Paperless-ngx image registry | `ghcr.io` |
| `image.repository` | Paperless-ngx image repository | `paperless-ngx/paperless-ngx` |
| `image.tag` | Paperless-ngx image tag | `""` (uses Chart.AppVersion) |
| `image.pullPolicy` | Paperless-ngx image pull policy | `IfNotPresent` |
| `image.pullSecrets` | Paperless-ngx image pull secrets | `[]` |

### Paperless-ngx Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `config.secretKey` | Secret key for Django application | `""` (auto-generated) |
| `config.existingSecret` | Name of existing secret | `""` |
| `config.adminUser` | Admin username | `"admin"` |
| `config.adminMail` | Admin email | `"admin@localhost"` |
| `config.adminPassword` | Admin password | `""` |
| `config.url` | Paperless-ngx URL | `""` |
| `config.csrfTrustedOrigins` | CSRF trusted origins | `[]` |
| `config.allowedHosts` | Django allowed hosts | `[]` |
| `config.corsAllowedHosts` | CORS allowed hosts | `[]` |
| `config.timeZone` | Timezone | `"UTC"` |
| `config.ocrLanguage` | OCR language | `"eng"` |
| `config.ocrMode` | OCR mode | `"skip"` |
| `config.enableHttpRemoteUser` | Enable HTTP remote user auth | `false` |
| `config.enableHttpRemoteUserAPI` | Enable remote user auth for API | `false` |
| `config.httpRemoteUserHeaderName` | Remote user header name | `HTTP_REMOTE_USER` |
| `config.cookiePrefix` | Cookie prefix (multi-instance auth) | `""` |
| `config.enableFlowerDebug` | Start Flower dashboard | `false` |
| `config.logrotateMaxSize` | Max log size before rotation | `"1024k"` |
| `config.logrotateMaxBackups` | Number of rotated logs to keep | `20` |

### Path & Storage Overrides

| Parameter | Description | Default |
|-----------|-------------|---------|
| `config.dataDir` | Override PAPERLESS_DATA_DIR | `""` |
| `config.mediaRoot` | Override PAPERLESS_MEDIA_ROOT | `""` |
| `config.consumptionDir` | Override PAPERLESS_CONSUMPTION_DIR | `""` |
| `config.exportDir` | Override PAPERLESS_EXPORT_DIR | `""` |
| `config.staticDir` | Override PAPERLESS_STATICDIR | `""` |
| `config.emptyTrashDir` | Override PAPERLESS_EMPTY_TRASH_DIR | `""` |
| `config.loggingDir` | Override PAPERLESS_LOGGING_DIR | `""` |
| `config.nltkDir` | Override PAPERLESS_NLTK_DIR | `""` |
| `config.modelFile` | Override PAPERLESS_MODEL_FILE | `""` |

### Authentication, Hosting & SSO

| Parameter | Description | Default |
|-----------|-------------|---------|
| `config.autoLoginUsername` | Auto-login username (kiosk setups) | `""` |
| `config.disableRegularLogin` | Disable username/password login | `false` |
| `config.redirectLoginToSSO` | Auto-redirect to SSO | `false` |
| `config.trustedProxies` | Trusted proxy list | `[]` |
| `config.logoutRedirectUrl` | Post-logout redirect URL | `""` |
| `config.forceScriptName` | Host Paperless under sub-path | `""` |
| `config.staticUrl` | Custom STATIC_URL | `/static/` |
| `config.useXForwardedHost` | Respect X-Forwarded-Host | `false` |
| `config.useXForwardedPort` | Respect X-Forwarded-Port | `false` |
| `config.proxySslHeader` | SECURE_PROXY_SSL_HEADER tuple | `[]` |
| `config.accountAllowSignups` | Enable local signup | `false` |
| `config.accountDefaultGroups` | Default groups for signups | `[]` |
| `config.socialAccountAllowSignups` | Allow social signups | `true` |
| `config.socialAutoSignup` | Auto-create social accounts | `false` |
| `config.socialAccountSyncGroups` | Sync IdP groups | `false` |
| `config.socialAccountDefaultGroups` | Groups for social signups | `[]` |
| `config.accountSessionRemember` | Persistent sessions | `true` |
| `config.sessionCookieAge` | Session cookie age (seconds) | `1209600` |
| `config.accountEmailVerification` | Email verification mode | `optional` |
| `config.accountEmailUnknownAccounts` | Allow password reset for unknown accounts | `true` |
| `config.accountDefaultHttpProtocol` | Preferred protocol for auth callbacks | `https` |

### OCR, Workers & Runtime

| Parameter | Description | Default |
|-----------|-------------|---------|
| `config.ocrOutputType` | OCR output type | `"pdfa"` |
| `config.ocrPages` | Max pages to OCR (0 = all) | `0` |
| `config.ocrImageDpi` | OCR preprocessing DPI | `300` |
| `config.taskWorkers` | Paperless task workers | `1` |
| `config.threadsPerWorker` | Threads per worker | `1` |
| `config.workerTimeout` | Worker timeout (seconds) | `1800` |
| `config.enableCompression` | Enable document compression | `true` |
| `config.convertMemoryLimit` | ImageMagick memory limit | `"0"` |
| `config.convertTmpdir` | Temp dir for conversions | `""` |
| `config.optimize` | Optimize converted files | `true` |
| `config.webserverWorkers` | Gunicorn workers | `1` |
| `config.bindAddr` | Gunicorn bind address | `"0.0.0.0"` |
| `config.port` | Gunicorn port | `8000` |

### Document Consumption & NLP

| Parameter | Description | Default |
|-----------|-------------|---------|
| `config.enableNltk` | Enable NLP matching | `true` |
| `config.dateParserLanguages` | Date parser languages | `""` |
| `config.dateOrder` | Preferred date order | `""` |
| `config.numberOfSuggestedDates` | Suggested dates in UI | `3` |
| `config.ignoreDates` | Dates to ignore during parsing | `""` |
| `config.enableGpgDecryptor` | Enable GPG decryptor | `false` |
| `config.consumerDisable` | Disable filesystem consumer | `false` |
| `config.consumerDeleteDuplicates` | Delete duplicates on consume | `false` |
| `config.consumerRecursive` | Recurse consume directory | `false` |
| `config.consumerSubdirsAsTags` | Use subdirectories as tags | `false` |
| `config.consumerPolling` | Polling interval (seconds) | `0` |
| `config.consumerPollingRetryCount` | Polling retries before consume | `5` |
| `config.consumerPollingDelay` | Delay between retries | `5` |
| `config.consumerInotifyDelay` | Inotify debounce (seconds) | `0.5` |

### Filenames & Formatting

| Parameter | Description | Default |
|-----------|-------------|---------|
| `config.filenameFormat` | Filename template for stored docs | `""` |
| `config.filenameFormatRemoveNone` | Strip "none" placeholder segments | `false` |

### Database Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `database.type` | Database engine (`postgresql` or `mariadb`) | `postgresql` |
| `database.postgresql.host` | PostgreSQL host (when subchart disabled) | `""` |
| `database.postgresql.port` | PostgreSQL port | `5432` |
| `database.postgresql.database` | PostgreSQL database name | `"paperless"` |
| `database.postgresql.username` | PostgreSQL username | `"paperless"` |
| `database.postgresql.password` | PostgreSQL password | `""` |
| `database.postgresql.existingSecret` | Existing secret for PostgreSQL password | `""` |
| `database.postgresql.passwordKey` | Secret key for PostgreSQL password | `"password"` |
| `database.postgresql.sslMode` | PostgreSQL SSL mode | `"prefer"` |
| `database.mariadb.host` | MariaDB host (when `database.type=mariadb`) | `""` |
| `database.mariadb.port` | MariaDB port | `3306` |
| `database.mariadb.database` | MariaDB database name | `"paperless"` |
| `database.mariadb.username` | MariaDB username | `"paperless"` |
| `database.mariadb.password` | MariaDB password | `""` |
| `database.mariadb.existingSecret` | Existing secret for MariaDB password | `""` |
| `database.mariadb.passwordKey` | Secret key for MariaDB password | `"password"` |
| `database.mariadb.sslMode` | MariaDB SSL mode | `"PREFERRED"` |
| `database.timeout` | DB connection timeout | `""` |
| `database.poolSize` | DB connection pool size | `""` |
| `database.sslRootCert` | Path to SSL root cert | `""` |
| `database.sslCert` | Path to SSL client cert | `""` |
| `database.sslKey` | Path to SSL client key | `""` |
| `database.readCache.enabled` | Enable Redis read cache | `false` |
| `database.readCache.ttl` | Read cache TTL (seconds) | `3600` |
| `database.readCache.redisUrl` | Alternate Redis URL for cache | `""` |

### Redis Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `redis.enabled` | Enable bundled Redis subchart | `true` |
| `redis.host` | External Redis host (when subchart disabled) | `""` |
| `redis.port` | Redis port | `6379` |
| `redis.database` | Redis database number | `0` |
| `redis.prefix` | Redis key prefix | `""` |
| `redis.password` | Redis password | `""` |
| `redis.existingSecret` | Name of existing secret | `""` |
| `redis.passwordKey` | Key in existing secret | `"password"` |
| `redis.ssl` | Enable SSL | `false` |
| `redis.auth.enabled` | Enable auth for Bitnami subchart | `false` |
| `redis.auth.password` | Subchart password (auto-generated by default) | `""` |
| `redis.auth.existingSecret` | Subchart secret override | `""` |

### Optional Services & Scheduled Tasks

| Parameter | Description | Default |
|-----------|-------------|---------|
| `emailParsing.defaultLayout` | Default email parsing layout | `1` |
| `tika.enabled` | Enable Apache Tika/Gotenberg integration | `false` |
| `tika.endpoint` | Tika endpoint URL | `http://localhost:9998` |
| `tika.gotenbergEndpoint` | Gotenberg endpoint URL | `http://localhost:3000` |
| `tasks.email` | Cron for email fetch | `*/10 * * * *` |
| `tasks.train` | Cron for classifier training | `5 */1 * * *` |
| `tasks.index` | Cron for index refresh | `0 0 * * *` |
| `tasks.sanity` | Cron for sanity checks | `30 0 * * sun` |
| `tasks.emptyTrash` | Cron for emptying trash | `0 1 * * *` |

### Worker Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `worker.enabled` | Enable separate worker deployment | `true` |
| `worker.replicaCount` | Number of worker replicas | `1` |
| `worker.resources.limits` | Worker resource limits | `{cpu: 2000m, memory: 2Gi}` |
| `worker.resources.requests` | Worker resource requests | `{cpu: 500m, memory: 512Mi}` |

### Persistence Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `persistence.data.enabled` | Enable data persistence | `true` |
| `persistence.data.size` | Data volume size | `8Gi` |
| `persistence.media.enabled` | Enable media persistence | `true` |
| `persistence.media.size` | Media volume size | `10Gi` |
| `persistence.consume.enabled` | Enable consume persistence | `true` |
| `persistence.consume.size` | Consume volume size | `5Gi` |

### Service Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `service.type` | Kubernetes service type | `ClusterIP` |
| `service.port` | Service HTTP port | `80` |
| `service.annotations` | Service annotations | `{}` |

### Paperless-AI Integration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `paperlessAi.enabled` | Deploy the optional Paperless-AI automation/RAG service | `false` |
| `paperlessAi.configMode` | `managed` renders the `.env` file from Helm values, `ui` keeps the volume writable for in-app setup | `managed` |
| `paperlessAi.env` | Key/value map written into the managed `.env` file (non-secret settings) | `{}` |
| `paperlessAi.extraEnv` | Additional `env` entries (supports `valueFrom` for secrets) | `[]` |
| `paperlessAi.extraEnvFrom` | Extra `envFrom` blocks (ConfigMap/Secret references) | `[]` |
| `paperlessAi.persistence.enabled` | Enable a dedicated PVC for `/app/data` (Paperless-AI stores `.env`, DB + embeddings here) | `true` |
| `paperlessAi.persistence.size` | Size of the Paperless-AI PVC | `5Gi` |
| `paperlessAi.service.type` | Service type for the Paperless-AI UI/API | `ClusterIP` |
| `paperlessAi.service.port` | UI/API service port | `3000` |
| `paperlessAi.service.exposeRagPort` | Publish the internal RAG backend on its own service port | `false` |
| `paperlessAi.ingress.enabled` | Create a dedicated ingress for the Paperless-AI UI/API | `false` |
| `paperlessAi.resources.requests` | Resource requests for the Paperless-AI pod | `{}` |
| `paperlessAi.resources.limits` | Resource limits for the Paperless-AI pod | `{}` |

#### Managed vs UI configuration

Applies to both Paperless-AI and Paperless-GPT companion services.

- `managed` mode mounts a read-only `.env` file that Helm keeps in sync with `paperlessAi.env`. This is ideal for GitOps-style rollouts where configuration is declarative. Sensitive values should still come from Kubernetes Secrets via `paperlessAi.extraEnv`/`paperlessAi.extraEnvFrom`.
- `ui` mode skips the managed `.env` and leaves `/app/data/.env` writable so you can complete setup inside the Paperless-AI web UI. Provide the Paperless API token (and optional LLM API keys) via `paperlessAi.extraEnv`/Secrets so the service can talk to Paperless immediately.

### Paperless-GPT Integration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `paperlessGpt.enabled` | Deploy the optional Paperless-GPT conversational/RAG service | `false` |
| `paperlessGpt.configMode` | `managed` renders the `.env` file, `ui` leaves it editable in the container | `managed` |
| `paperlessGpt.env` | Key/value map written into the managed `.env` file (non-secret settings) | `{}` |
| `paperlessGpt.extraEnv` | Additional container env entries (supports secret references) | `[]` |
| `paperlessGpt.extraEnvFrom` | Extra `envFrom` blocks (ConfigMap/Secret refs) | `[]` |
| `paperlessGpt.envFromSecrets` | Convenience list of Secret names to add to `envFrom` | `[]` |
| `paperlessGpt.persistence.enabled` | Enable dedicated PVC for `/app/data` | `true` |
| `paperlessGpt.service.port` | UI/API service port | `3100` |
| `paperlessGpt.service.exposeRagPort` | Publish the internal RAG backend on an additional port | `false` |
| `paperlessGpt.ingress.enabled` | Create a dedicated ingress for Paperless-GPT | `false` |
| `paperlessGpt.resources.requests` | Resource requests for the Paperless-GPT pod | `{}` |
| `paperlessGpt.resources.limits` | Resource limits for the Paperless-GPT pod | `{}` |

### Ingress Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `ingress.enabled` | Enable ingress | `false` |
| `ingress.className` | Ingress class name | `""` |
| `ingress.annotations` | Ingress annotations | `{}` |
| `ingress.hosts` | Ingress hosts configuration | `[{host: paperless-ngx.local, paths: [{path: /, pathType: Prefix}]}]` |
| `ingress.tls` | Ingress TLS configuration | `[]` |

### Security Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `podSecurityContext.enabled` | Enable pod security context | `true` |
| `podSecurityContext.fsGroup` | Group ID for volumes | `1000` |
| `containerSecurityContext.enabled` | Enable container security context | `true` |
| `containerSecurityContext.runAsUser` | User ID to run container | `1000` |
| `containerSecurityContext.runAsNonRoot` | Run as non-root | `true` |
| `containerSecurityContext.readOnlyRootFilesystem` | Read-only root filesystem | `false` |

### Resource Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `resources.limits.cpu` | CPU limit | `1000m` |
| `resources.limits.memory` | Memory limit | `1Gi` |
| `resources.requests.cpu` | CPU request | `250m` |
| `resources.requests.memory` | Memory request | `512Mi` |

### Autoscaling Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `autoscaling.enabled` | Enable autoscaling | `false` |
| `autoscaling.minReplicas` | Minimum replicas | `1` |
| `autoscaling.maxReplicas` | Maximum replicas | `10` |
| `autoscaling.targetCPU` | Target CPU utilization | `80` |
| `autoscaling.targetMemory` | Target memory utilization | `80` |

### Monitoring Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `metrics.enabled` | Enable metrics | `false` |
| `metrics.serviceMonitor.enabled` | Create ServiceMonitor | `false` |
| `metrics.serviceMonitor.interval` | Scrape interval | `30s` |

See `values.yaml` for the complete list of configurable parameters.

## Examples

### Minimal Configuration

```yaml
config:
  secretKey: "your-long-random-secret-key"

database:
  postgresql:
    host: postgresql.default.svc.cluster.local
    password: your-db-password

redis:
  host: redis.default.svc.cluster.local
```

### Production Configuration

```yaml
replicaCount: 2

config:
  secretKey: "your-long-random-secret-key"
  url: https://paperless.example.com
  csrfTrustedOrigins:
    - https://paperless.example.com
  timeZone: America/New_York
  ocrLanguage: eng+deu+fra

database:
  postgresql:
    host: postgresql.prod.svc.cluster.local
    existingSecret: paperless-secrets
    passwordKey: database-password

redis:
  host: redis.prod.svc.cluster.local
  existingSecret: paperless-secrets
  passwordKey: redis-password

worker:
  enabled: true
  replicaCount: 3
  resources:
    limits:
      cpu: 4000m
      memory: 4Gi
    requests:
      cpu: 1000m
      memory: 1Gi

persistence:
  data:
    size: 20Gi
  media:
    size: 100Gi
  consume:
    size: 20Gi

ingress:
  enabled: true
  className: nginx
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt-prod
    nginx.ingress.kubernetes.io/proxy-body-size: "0"
  hosts:
    - host: paperless.example.com
      paths:
        - path: /
          pathType: Prefix
  tls:
    - secretName: paperless-tls
      hosts:
        - paperless.example.com

autoscaling:
  enabled: true
  minReplicas: 2
  maxReplicas: 10
  targetCPU: 70

podDisruptionBudget:
  enabled: true
  minAvailable: 1

networkPolicy:
  enabled: true
  allowExternal: true

metrics:
  enabled: true
  serviceMonitor:
    enabled: true
```

### Paperless-AI Companion

```yaml
paperlessAi:
  enabled: true
  configMode: managed
  env:
    AI_PROVIDER: "openai"
    OPENAI_MODEL: "gpt-4o-mini"
    SCAN_INTERVAL: "*/15 * * * *"
  extraEnv:
    - name: PAPERLESS_API_TOKEN
      valueFrom:
        secretKeyRef:
          name: paperless-ai-secrets
          key: paperless-api-token
    - name: OPENAI_API_KEY
      valueFrom:
        secretKeyRef:
          name: paperless-ai-secrets
          key: openai-api-key
  persistence:
    enabled: true
    storageClass: fast-ssd
    size: 20Gi
  ingress:
    enabled: true
    className: nginx
    hosts:
      - host: ai.paperless.example.com
        paths:
          - path: /
            pathType: Prefix
    tls:
      - secretName: paperless-ai-tls
        hosts:
          - ai.paperless.example.com
```

### Paperless-GPT Companion

```yaml
paperlessGpt:
  enabled: true
  configMode: managed
  env:
    GPT_PROVIDER: "openai"
    GPT_MODEL: "gpt-4o-mini"
    STREAMING_ENABLED: "true"
    CHAT_HISTORY_WINDOW: "25"
  extraEnv:
    - name: PAPERLESS_API_TOKEN
      valueFrom:
        secretKeyRef:
          name: paperless-gpt-secrets
          key: paperless-api-token
    - name: OPENAI_API_KEY
      valueFrom:
        secretKeyRef:
          name: paperless-gpt-secrets
          key: openai-api-key
  persistence:
    enabled: true
    storageClass: fast-ssd
    size: 20Gi
  ingress:
    enabled: true
    className: nginx
    hosts:
      - host: gpt.paperless.example.com
        paths:
          - path: /
            pathType: Prefix
    tls:
      - secretName: paperless-gpt-tls
        hosts:
          - gpt.paperless.example.com
```

## Troubleshooting

### Database Connection Issues

Ensure PostgreSQL is accessible and credentials are correct:

```bash
kubectl exec -it <paperless-pod> -- env | grep PAPERLESS_DB
```

### Worker Not Processing Documents

Check worker logs:

```bash
kubectl logs -l app.kubernetes.io/component=worker
```

Ensure Redis is accessible:

```bash
kubectl exec -it <paperless-pod> -- redis-cli -h <redis-host> ping
```

### OCR Languages

To use additional OCR languages, update the configuration:

```yaml
config:
  ocrLanguage: eng+deu+fra+spa
```

The image includes Tesseract with support for many languages.

## Upgrading

### To 0.2.0

No breaking changes.

## Support

For issues specific to this Helm chart, please open an issue in the chart repository.

For Paperless-ngx application issues, refer to the [official documentation](https://docs.paperless-ngx.com/).

## License

This Helm chart is licensed under the MIT License. See the Paperless-ngx project for its license.
