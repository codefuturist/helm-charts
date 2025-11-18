# bitwarden-eso-provider

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

A Bitwarden webhook provider for External Secrets Operator that works with personal/organizational vaults using the Bitwarden CLI

**Homepage:** <https://github.com/codefuturist/helm-charts>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| codefuturist | <58808821+codefuturist@users.noreply.github.com> |  |

## Source Code

* <https://github.com/codefuturist/helm-charts>
* <https://github.com/codefuturist/helm-charts/tree/main/apps/bitwarden-eso-provider-app>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{"podAntiAffinity":{"preferredDuringSchedulingIgnoredDuringExecution":[{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["bitwarden-eso-provider"]}]},"topologyKey":"kubernetes.io/hostname"},"weight":100}]}}` | Affinity rules |
| api.existingSecret.key | string | `"token"` | Key in secret containing API token |
| api.existingSecret.name | string | `""` | Name of existing secret with API token |
| api.port | int | `8080` | API server port |
| api.token | string | `""` | API token for webhook authentication If empty, a random token will be generated |
| api.tokenFile.enabled | bool | `false` | Enable reading token from file |
| api.tokenFile.path | string | `"/etc/secrets/api-token"` | Path to token file (will be mounted at /etc/secrets/api-token) |
| api.tokenFile.secretKey | string | `"token"` | Key in secret containing the token |
| api.tokenFile.secretName | string | `""` | Name of secret containing the token file |
| autoscaling.behavior | object | `{}` | HPA scaling behavior |
| autoscaling.enabled | bool | `false` | Enable HorizontalPodAutoscaler |
| autoscaling.maxReplicas | int | `10` | Maximum replicas |
| autoscaling.minReplicas | int | `2` | Minimum replicas |
| autoscaling.targetCPUUtilizationPercentage | int | `80` | Target CPU utilization percentage |
| autoscaling.targetMemoryUtilizationPercentage | int | `nil` | Target memory utilization percentage |
| bitwarden.auth.credentials.clientId | string | `""` | Bitwarden client ID (API key auth) |
| bitwarden.auth.credentials.clientSecret | string | `""` | Bitwarden client secret (API key auth) |
| bitwarden.auth.credentials.email | string | `""` | Bitwarden email (password auth) |
| bitwarden.auth.credentials.password | string | `""` | Bitwarden master password (password auth) |
| bitwarden.auth.existingSecret.clientIdKey | string | `"clientId"` | Key in secret containing client ID (for API key auth) |
| bitwarden.auth.existingSecret.clientSecretKey | string | `"clientSecret"` | Key in secret containing client secret (for API key auth) |
| bitwarden.auth.existingSecret.emailKey | string | `"email"` | Key in secret containing email (for password auth) |
| bitwarden.auth.existingSecret.name | string | `""` | Name of existing secret with Bitwarden credentials |
| bitwarden.auth.existingSecret.passwordKey | string | `"password"` | Key in secret containing master password (for password auth) |
| bitwarden.auth.useApiKey | bool | `true` | Use API key authentication (recommended) |
| bitwarden.auth.usePassword | bool | `false` | Use password authentication (less secure, for testing) |
| bitwarden.server | string | `https://vault.bitwarden.com` | Bitwarden server URL |
| bitwarden.sessionTTL | int | `3600` | Session TTL in seconds |
| bitwarden.syncInterval | int | `300` | Vault sync interval in seconds |
| cache.enabled | bool | `true` | Enable secret caching |
| cache.maxSize | int | `1000` | Maximum cache size (number of items) |
| cache.ttl | int | `60` | Cache TTL in seconds |
| externalSecretsOperator.createClusterSecretStore | bool | `true` | Create ClusterSecretStore resource |
| externalSecretsOperator.namespaced | bool | `false` | Create namespaced SecretStore (if false, creates ClusterSecretStore) |
| externalSecretsOperator.secretStore.annotations | object | `{}` | Additional annotations |
| externalSecretsOperator.secretStore.labels | object | `{}` | Additional labels |
| externalSecretsOperator.secretStore.name | string | `"bitwarden"` | SecretStore/ClusterSecretStore name |
| fullnameOverride | string | `""` | Override full release name |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.repository | string | `"ghcr.io/codefuturist/bitwarden-eso-provider"` | Container image repository |
| image.tag | string | `"1.0.0"` | Image tag (defaults to chart appVersion) |
| imagePullSecrets | list | `[]` | Image pull secrets |
| livenessProbe.httpGet.path | string | `"/healthz"` |  |
| livenessProbe.httpGet.port | string | `"http"` |  |
| livenessProbe.initialDelaySeconds | int | `10` |  |
| livenessProbe.periodSeconds | int | `30` |  |
| livenessProbe.timeoutSeconds | int | `5` |  |
| logging.format | string | `"json"` | Log format (json, text) |
| logging.level | string | `"info"` | Log level (debug, info, warning, error) |
| metrics.enabled | bool | `false` | Enable Prometheus metrics endpoint |
| metrics.serviceMonitor.annotations | object | `{}` | ServiceMonitor annotations |
| metrics.serviceMonitor.enabled | bool | `false` | Create ServiceMonitor resource (requires Prometheus Operator) |
| metrics.serviceMonitor.interval | string | `"30s"` | Scrape interval |
| metrics.serviceMonitor.labels | object | `{}` | Additional ServiceMonitor labels |
| metrics.serviceMonitor.metricRelabelings | list | `[]` | Metric relabelings for ServiceMonitor |
| metrics.serviceMonitor.relabelings | list | `[]` | Relabelings for ServiceMonitor |
| metrics.serviceMonitor.scrapeTimeout | string | `nil` | Scrape timeout |
| nameOverride | string | `""` | Override release name |
| networkPolicy.egress | list | `[{"ports":[{"port":443,"protocol":"TCP"}],"to":[{"namespaceSelector":{}}]},{"ports":[{"port":53,"protocol":"TCP"},{"port":53,"protocol":"UDP"}],"to":[{"namespaceSelector":{}}]}]` | Egress rules (allow Bitwarden API) |
| networkPolicy.enabled | bool | `false` | Enable network policy |
| networkPolicy.ingress | list | `[{"from":[{"namespaceSelector":{}}]}]` | Ingress rules |
| nodeSelector | object | `{}` | Node selector |
| podAnnotations | object | `{}` |  |
| podDisruptionBudget.enabled | bool | `false` | Enable PodDisruptionBudget |
| podDisruptionBudget.maxUnavailable | int | `nil` | Maximum unavailable pods (use this OR minAvailable) |
| podDisruptionBudget.minAvailable | int | `1` | Minimum available pods (use this OR maxUnavailable) |
| podDisruptionBudget.unhealthyPodEvictionPolicy | string | `nil` | Unhealthy pod eviction policy (IfHealthyBudget, AlwaysAllow) |
| podSecurityContext.fsGroup | int | `1000` |  |
| podSecurityContext.runAsNonRoot | bool | `true` |  |
| podSecurityContext.runAsUser | int | `1000` |  |
| podSecurityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| priorityClassName | string | `""` | Priority class name for pod scheduling |
| readinessProbe.httpGet.path | string | `"/readyz"` |  |
| readinessProbe.httpGet.port | string | `"http"` |  |
| readinessProbe.initialDelaySeconds | int | `5` |  |
| readinessProbe.periodSeconds | int | `10` |  |
| readinessProbe.timeoutSeconds | int | `5` |  |
| replicaCount | int | `2` |  |
| resources.limits.cpu | string | `"200m"` |  |
| resources.limits.memory | string | `"256Mi"` |  |
| resources.requests.cpu | string | `"100m"` |  |
| resources.requests.memory | string | `"128Mi"` |  |
| securityContext.allowPrivilegeEscalation | bool | `false` |  |
| securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| securityContext.readOnlyRootFilesystem | bool | `true` |  |
| service.annotations | object | `{}` | Service annotations |
| service.port | int | `8080` | Service port |
| service.type | string | `"ClusterIP"` | Service type |
| serviceAccount.annotations | object | `{}` | Service account annotations |
| serviceAccount.create | bool | `true` | Create service account |
| serviceAccount.name | string | `""` | Service account name |
| startupProbe.failureThreshold | int | `30` |  |
| startupProbe.httpGet.path | string | `"/healthz"` |  |
| startupProbe.httpGet.port | string | `"http"` |  |
| startupProbe.initialDelaySeconds | int | `0` |  |
| startupProbe.periodSeconds | int | `5` |  |
| startupProbe.timeoutSeconds | int | `3` |  |
| tolerations | list | `[]` | Tolerations |
| topologySpreadConstraints | list | `[]` | Topology spread constraints for better pod distribution |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
