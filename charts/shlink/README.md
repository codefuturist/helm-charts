# shlink

![Version: 1.0.1](https://img.shields.io/badge/Version-1.0.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 4.2.4](https://img.shields.io/badge/AppVersion-4.2.4-informational?style=flat-square)

A production-ready Helm chart for Shlink - Self-hosted URL shortener with analytics and web UI

**Homepage:** <https://shlink.io/>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| codefuturist | <58808821+codefuturist@users.noreply.github.com> |  |

## Source Code

* <https://github.com/shlinkio/shlink>
* <https://github.com/shlinkio/shlink-web-client>
* <https://github.com/codefuturist/helm-charts>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | postgresql | ~16.2.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalAnnotations | object | `{}` | Additional annotations to add to all resources |
| additionalLabels | object | `{}` | Additional labels to add to all resources |
| affinity | object | `{}` | Affinity and anti-affinity rules |
| autoscaling.behavior | object | `{}` | Behavior configuration for scaling |
| autoscaling.enabled | bool | `false` | Enable Horizontal Pod Autoscaler |
| autoscaling.maxReplicas | int | `10` | Maximum number of replicas |
| autoscaling.minReplicas | int | `1` | Minimum number of replicas |
| autoscaling.targetCPUUtilizationPercentage | int | `80` | Target CPU utilization percentage |
| autoscaling.targetMemoryUtilizationPercentage | int | `80` | Target memory utilization percentage |
| controller.podManagementPolicy | string | `"OrderedReady"` | StatefulSet pod management policy |
| controller.replicaCount | int | `1` | Number of replicas (ignored for statefulsets, use autoscaling or set directly) |
| controller.strategy | object | `{"rollingUpdate":{"maxSurge":1,"maxUnavailable":0},"type":"RollingUpdate"}` | Deployment strategy / StatefulSet update strategy |
| controller.type | string | `"deployment"` | Controller type (deployment or statefulset) |
| database.existingSecret | string | `""` | Name of existing secret containing database credentials The secret must contain keys for username and password |
| database.existingSecretPasswordKey | string | `"password"` | Key in existingSecret for database password |
| database.existingSecretUserKey | string | `"username"` | Key in existingSecret for database username |
| database.host | string | "shlink-postgresql" when postgresql.enabled=true | Database host (use subchart service name if postgresql.enabled=true) |
| database.name | string | `"shlink"` | Database name |
| database.options | object | `{}` | Database connection options |
| database.password | string | `"changeme"` | Database password (only used if existingSecret is not set) |
| database.port | int | `5432` | Database port |
| database.type | string | `"postgres"` | Database type (postgres, mysql, maria, mssql) |
| database.user | string | `"shlink"` | Database username |
| diagnosticMode.args | list | `["infinity"]` | Arguments for diagnostic mode command |
| diagnosticMode.command | list | `["sleep"]` | Command to run in diagnostic mode |
| diagnosticMode.enabled | bool | `false` | Enable diagnostic mode (sleep infinity instead of running application) |
| dnsConfig | object | `{}` | DNS config for pods |
| dnsPolicy | string | `"ClusterFirst"` | DNS policy for pods |
| extraContainers | list | `[]` | Additional containers to run alongside main container |
| extraVolumeMounts | list | `[]` | Additional volume mounts for main container |
| extraVolumes | list | `[]` | Additional volumes |
| fullnameOverride | string | `""` | Override the full name of the chart |
| hostAliases | list | `[]` | Host aliases for pods |
| image.digest | string | `""` | Image digest (overrides tag if set) |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.repository | string | `"shlinkio/shlink"` | Shlink backend API Docker image repository |
| image.tag | string | Chart appVersion | Shlink backend API Docker image tag |
| imagePullSecrets | list | `[]` | Image pull secrets for private registries |
| ingress.backend | object | `{"annotations":{},"className":"","enabled":false,"hosts":[{"host":"short.example.com","paths":[{"path":"/","pathType":"Prefix"}]}],"tls":[]}` | Backend API ingress configuration |
| ingress.backend.annotations | object | `{}` | Annotations for backend ingress |
| ingress.backend.className | string | `""` | Ingress class name |
| ingress.backend.enabled | bool | `false` | Enable ingress for backend API |
| ingress.backend.hosts | list | `[{"host":"short.example.com","paths":[{"path":"/","pathType":"Prefix"}]}]` | Ingress hosts configuration |
| ingress.backend.tls | list | `[]` | TLS configuration |
| ingress.webClient | object | `{"annotations":{},"className":"","enabled":false,"hosts":[{"host":"shlink-admin.example.com","paths":[{"path":"/","pathType":"Prefix"}]}],"tls":[]}` | Web client ingress configuration |
| ingress.webClient.annotations | object | `{}` | Annotations for web client ingress |
| ingress.webClient.className | string | `""` | Ingress class name |
| ingress.webClient.enabled | bool | `false` | Enable ingress for web client |
| ingress.webClient.hosts | list | `[{"host":"shlink-admin.example.com","paths":[{"path":"/","pathType":"Prefix"}]}]` | Ingress hosts configuration |
| ingress.webClient.tls | list | `[]` | TLS configuration |
| initContainers | list | `[]` | Init containers to run before main containers |
| livenessProbe | object | `{"enabled":true,"failureThreshold":3,"httpGet":{"path":"/rest/health","port":8080},"initialDelaySeconds":30,"periodSeconds":10,"successThreshold":1,"timeoutSeconds":5}` | Liveness probe configuration for Shlink backend |
| monitoring.prometheusRule | object | `{"enabled":false,"labels":{},"namespace":"","rules":[]}` | PrometheusRule configuration for alerting |
| monitoring.prometheusRule.enabled | bool | `false` | Enable PrometheusRule |
| monitoring.prometheusRule.labels | object | `{}` | Additional labels for PrometheusRule |
| monitoring.prometheusRule.namespace | string | `""` | Namespace for PrometheusRule (defaults to release namespace) |
| monitoring.prometheusRule.rules | list | `[]` | Alert rules |
| monitoring.serviceMonitor | object | `{"enabled":false,"interval":"30s","labels":{},"metricRelabelings":[],"namespace":"","path":"/rest/v3/metrics","relabelings":[],"scheme":"http","scrapeTimeout":"10s","tlsConfig":{}}` | ServiceMonitor configuration for Prometheus Operator |
| monitoring.serviceMonitor.enabled | bool | `false` | Enable ServiceMonitor |
| monitoring.serviceMonitor.interval | string | `"30s"` | Interval for scraping metrics |
| monitoring.serviceMonitor.labels | object | `{}` | Additional labels for ServiceMonitor |
| monitoring.serviceMonitor.metricRelabelings | list | `[]` | Metric relabeling configs |
| monitoring.serviceMonitor.namespace | string | `""` | Namespace for ServiceMonitor (defaults to release namespace) |
| monitoring.serviceMonitor.path | string | `"/rest/v3/metrics"` | HTTP path to scrape metrics from |
| monitoring.serviceMonitor.relabelings | list | `[]` | Relabeling configs |
| monitoring.serviceMonitor.scheme | string | `"http"` | Scheme for metrics endpoint (http or https) |
| monitoring.serviceMonitor.scrapeTimeout | string | `"10s"` | Timeout for scraping metrics |
| monitoring.serviceMonitor.tlsConfig | object | `{}` | TLS config for metrics endpoint |
| nameOverride | string | `""` | Override the name of the chart |
| namespaceOverride | string | `.Release.Namespace` | Override the namespace for all resources |
| networkPolicy.egress | list | `[]` | Egress rules |
| networkPolicy.enabled | bool | `false` | Enable network policy |
| networkPolicy.ingress | list | `[]` | Ingress rules |
| networkPolicy.policyTypes | list | `["Ingress","Egress"]` | Policy types to enforce |
| nodeName | string | `""` | Node name for pod assignment |
| nodeSelector | object | `{}` | Node selector for pod assignment |
| persistence.accessModes | list | `["ReadWriteOnce"]` | Access modes for PersistentVolumeClaim |
| persistence.annotations | object | `{}` | Annotations for PersistentVolumeClaim |
| persistence.dataSource | object | `{}` | Data source for PersistentVolumeClaim |
| persistence.enabled | bool | `true` | Enable persistence for Shlink data |
| persistence.existingClaim | string | `""` | Existing PersistentVolumeClaim name (if set, no new PVC will be created) |
| persistence.selector | object | `{}` | Selector for PersistentVolumeClaim |
| persistence.size | string | `"1Gi"` | Size of PersistentVolumeClaim |
| persistence.storageClass | string | default storage class | Storage class for PersistentVolumeClaim |
| podAnnotations | object | `{}` | Additional annotations for pods |
| podDisruptionBudget.enabled | bool | `false` | Enable Pod Disruption Budget |
| podDisruptionBudget.maxUnavailable | string | `""` | Maximum unavailable pods (alternative to minAvailable) |
| podDisruptionBudget.minAvailable | int | `1` | Minimum available pods |
| podLabels | object | `{}` | Additional labels for pods |
| podSecurityContext | object | `{"fsGroup":1001,"runAsGroup":1001,"runAsNonRoot":true,"runAsUser":1001}` | Pod security context for Shlink backend |
| postgresql | object | `{"architecture":"standalone","auth":{"database":"shlink","existingSecret":"","password":"changeme","username":"shlink"},"enabled":true,"image":{"tag":"latest"},"primary":{"persistence":{"enabled":true,"size":"8Gi"},"resources":{}}}` | PostgreSQL subchart configuration See https://github.com/bitnami/charts/tree/main/bitnami/postgresql for all options |
| postgresql.architecture | string | `"standalone"` | PostgreSQL architecture (standalone or replication) |
| postgresql.auth | object | `{"database":"shlink","existingSecret":"","password":"changeme","username":"shlink"}` | PostgreSQL authentication configuration |
| postgresql.auth.database | string | `"shlink"` | PostgreSQL database name |
| postgresql.auth.existingSecret | string | `""` | Existing secret with PostgreSQL credentials |
| postgresql.auth.password | string | `"changeme"` | PostgreSQL password |
| postgresql.auth.username | string | `"shlink"` | PostgreSQL username |
| postgresql.enabled | bool | `true` | Enable PostgreSQL subchart |
| postgresql.image | object | `{"tag":"latest"}` | PostgreSQL image configuration Override to use available image tag |
| postgresql.primary | object | `{"persistence":{"enabled":true,"size":"8Gi"},"resources":{}}` | PostgreSQL primary configuration |
| postgresql.primary.persistence | object | `{"enabled":true,"size":"8Gi"}` | Persistence configuration for primary |
| postgresql.primary.resources | object | `{}` | Resource limits for primary |
| priorityClassName | string | `""` | Priority class name for pods |
| rbac.create | bool | `false` | Enable RBAC resources |
| rbac.rules | list | `[]` | Rules for the Role/ClusterRole |
| readinessProbe | object | `{"enabled":true,"failureThreshold":3,"httpGet":{"path":"/rest/health","port":8080},"initialDelaySeconds":10,"periodSeconds":5,"successThreshold":1,"timeoutSeconds":3}` | Readiness probe configuration for Shlink backend |
| resources | object | `{}` | Resource limits and requests for Shlink backend |
| securityContext | object | `{}` | Security context for Shlink backend container |
| service.backend | object | `{"annotations":{},"labels":{},"nodePort":"","port":8080,"targetPort":8080,"type":"ClusterIP"}` | Backend API service configuration |
| service.backend.annotations | object | `{}` | Annotations for backend service |
| service.backend.labels | object | `{}` | Labels for backend service |
| service.backend.nodePort | string | `""` | Node port for backend API (only for NodePort/LoadBalancer) |
| service.backend.port | int | `8080` | Service port for backend API |
| service.backend.targetPort | int | `8080` | Target port for backend API |
| service.backend.type | string | `"ClusterIP"` | Service type for backend API |
| service.webClient | object | `{"annotations":{},"labels":{},"nodePort":"","port":80,"targetPort":8080,"type":"ClusterIP"}` | Web client service configuration |
| service.webClient.annotations | object | `{}` | Annotations for web client service |
| service.webClient.labels | object | `{}` | Labels for web client service |
| service.webClient.nodePort | string | `""` | Node port for web client (only for NodePort/LoadBalancer) |
| service.webClient.port | int | `80` | Service port for web client |
| service.webClient.targetPort | int | `8080` | Target port for web client |
| service.webClient.type | string | `"ClusterIP"` | Service type for web client |
| serviceAccount.annotations | object | `{}` | Annotations for service account |
| serviceAccount.automountServiceAccountToken | bool | `false` | Automatically mount service account token |
| serviceAccount.create | bool | `true` | Enable service account creation |
| serviceAccount.name | string | `""` | Name of service account to use (if not created by chart) |
| shareProcessNamespace | bool | `false` | Share process namespace |
| shlink.anonymizeRemoteAddr | bool | `true` | Enable anonymizing IP addresses when collecting visits |
| shlink.defaultDomain | string | `"short.example.com"` | Default domain for short URLs (e.g., short.example.com) This is the primary domain where your short links will be accessible |
| shlink.defaultSchema | string | `"https"` | URL schema for short URLs (http or https) |
| shlink.deleteShortUrlThreshold | int | `-1` | Delete threshold for short URLs (number of visits) Set to prevent deletion of short URLs with more than X visits |
| shlink.existingSecret | string | `""` | Name of an existing secret containing Shlink configuration The secret can contain keys for initialApiKey, geoLiteLicenseKey |
| shlink.existingSecretApiKeyKey | string | `"initial-api-key"` | Key in existingSecret that contains the initial API key |
| shlink.existingSecretGeoLiteKey | string | `"geolite-license-key"` | Key in existingSecret that contains the GeoLite license key |
| shlink.extraEnv | list | `[]` | Additional environment variables for Shlink backend See https://shlink.io/documentation/environment-variables/ |
| shlink.geoLiteLicenseKey | string | `""` | GeoLite2 license key for geolocation features Get your free key from https://www.maxmind.com/en/geolite2/signup |
| shlink.initialApiKey | string | `""` | Initial API key for bootstrapping Leave empty to auto-generate on first startup IMPORTANT: For production, create API keys through the CLI after deployment |
| shlink.orphanVisitsLogging | bool | `true` | Enable orphan visits logging (visits to non-existent short codes) |
| shlink.redirect | object | `{"cacheLifetime":30,"statusCode":302}` | Configure redirect behavior |
| shlink.redirect.cacheLifetime | int | `30` | Enable caching redirects (not recommended for analytics) |
| shlink.redirect.statusCode | int | `302` | Status code for redirects (301 or 302) |
| shlink.redirectsLogging | bool | `true` | Enable redirects logging (keep visit history) |
| shlink.redis | object | `{"enabled":false,"servers":""}` | Redis configuration for caching (optional but recommended for production) |
| shlink.redis.enabled | bool | `false` | Enable Redis caching |
| shlink.redis.servers | string | `""` | Redis server(s) - can be comma-separated for multiple servers Format: host:port or redis://host:port or redis://password@host:port |
| shlink.urlShortener | object | `{"domain":{"hostname":"","schema":"https"}}` | URL shortener configuration |
| shlink.urlShortener.domain | object | `{"hostname":"","schema":"https"}` | Domain configuration for multiple domains |
| shlink.urlShortener.domain.hostname | string | `""` | Hostname for domain resolution |
| shlink.urlShortener.domain.schema | string | `"https"` | Schema for domain resolution |
| shlink.worker | object | `{"count":16}` | Task worker configuration |
| shlink.worker.count | int | `16` | Number of task workers |
| startupProbe | object | `{"enabled":true,"failureThreshold":30,"httpGet":{"path":"/rest/health","port":8080},"initialDelaySeconds":0,"periodSeconds":5,"successThreshold":1,"timeoutSeconds":3}` | Startup probe configuration for Shlink backend |
| terminationGracePeriodSeconds | int | `30` | Termination grace period in seconds |
| tolerations | list | `[]` | Tolerations for pod assignment |
| topologySpreadConstraints | list | `[]` | Topology spread constraints |
| webClient.autoscaling | object | `{"enabled":false,"maxReplicas":10,"minReplicas":2,"targetCPUUtilizationPercentage":80,"targetMemoryUtilizationPercentage":80}` | Autoscaling configuration for web client |
| webClient.defaultServer | object | `{"apiKey":"","apiKeySecretRef":{"key":"","name":""},"enabled":false,"forwardCredentials":false,"name":"","url":""}` | Automatically generate a servers.json entry from env vars (shlink-web-client 3.2+) WARNING: Enabling this also exposes credentials to every user of the web client. |
| webClient.defaultServer.apiKey | string | `""` | API key with permissions for the web client (avoid inlining secrets when possible) |
| webClient.defaultServer.apiKeySecretRef | object | `{"key":"","name":""}` | Reference an existing secret containing the API key |
| webClient.defaultServer.enabled | bool | `false` | Enable default server injection through SHLINK_SERVER_* env vars |
| webClient.defaultServer.forwardCredentials | bool | `false` | Forward cookies/client certs to backend (requires restrictive CORS) |
| webClient.defaultServer.name | string | `""` | Display name (defaults to "Shlink" when empty) |
| webClient.defaultServer.url | string | `""` | Backend URL that the web client will call |
| webClient.enabled | bool | `true` | Enable Shlink Web Client deployment |
| webClient.extraEnv | list | `[]` | Additional environment variables for web client |
| webClient.image | object | `{"digest":"","pullPolicy":"IfNotPresent","repository":"shlinkio/shlink-web-client","tag":"4.2.1"}` | Web client image configuration |
| webClient.image.digest | string | `""` | Image digest (overrides tag if set) |
| webClient.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| webClient.image.repository | string | `"shlinkio/shlink-web-client"` | Shlink Web Client Docker image repository |
| webClient.image.tag | string | `"4.2.1"` | Shlink Web Client Docker image tag |
| webClient.podSecurityContext | object | `{"fsGroup":101,"runAsGroup":101,"runAsNonRoot":true,"runAsUser":101}` | Pod security context for web client |
| webClient.replicaCount | int | `2` | Number of web client replicas |
| webClient.resources | object | `{}` | Resource limits and requests for web client |
| webClient.securityContext | object | `{}` | Security context for web client container |
| webClient.servers | list | `[]` | Pre-configured server definitions for web client These servers will be available in the web UI immediately WARNING: These entries expose API keys to every browser that can load the          web client. Only use in trusted environments. |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
