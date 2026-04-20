# protonpass-eso-provider

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

A Proton Pass webhook provider for External Secrets Operator that fetches secrets from Proton Pass vaults using pass-cli

**Homepage:** <https://github.com/codefuturist/helm-charts>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| codefuturist | <58808821+codefuturist@users.noreply.github.com> |  |

## Source Code

* <https://github.com/codefuturist/helm-charts>
* <https://github.com/protonpass/pass-cli>
* <https://protonpass.github.io/pass-cli/>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://../../libs/common | common | 2.x.x |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalLabels | object | `{}` | Additional labels for all resources |
| admin.enabled | bool | `false` | Enable admin endpoints (/api/v1/vaults, /api/v1/items, /api/v1/cache) |
| affinity | object | `{}` | Affinity |
| api.existingSecret | object | `{"key":"token","name":""}` | Use an existing secret for the ESO webhook bearer token |
| api.existingSecret.key | string | `"token"` | Key in the secret containing the token |
| api.existingSecret.name | string | `""` | Name of the existing secret (leave empty to auto-generate) |
| api.token | string | `""` | Token value (leave empty to auto-generate a random 32-char token) |
| externalSecretsOperator.createSecretStore | bool | `true` | Create a SecretStore/ClusterSecretStore for ESO |
| externalSecretsOperator.namespaced | bool | `false` | Create a namespaced SecretStore instead of ClusterSecretStore |
| externalSecretsOperator.secretStore.annotations | object | `{}` | Additional annotations |
| externalSecretsOperator.secretStore.labels | object | `{}` | Additional labels |
| externalSecretsOperator.secretStore.name | string | `"protonpass"` | Name of the SecretStore/ClusterSecretStore |
| externalSecretsOperator.timeout | string | `"10s"` | Webhook timeout for ESO requests |
| extraEnv | list | `[]` | Extra environment variables |
| extraVolumeMounts | list | `[]` | Extra volume mounts |
| extraVolumes | list | `[]` | Extra volumes |
| global | object | `{}` | Global values (for common library) |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.registry | string | `"ghcr.io"` | Image registry |
| image.repository | string | `"codefuturist/protonpass-eso-provider"` | Image repository |
| image.tag | string | `""` | Image tag (defaults to chart appVersion) |
| imagePullSecrets | list | `[]` | Image pull secrets |
| livenessProbe.failureThreshold | int | `3` |  |
| livenessProbe.initialDelaySeconds | int | `15` |  |
| livenessProbe.periodSeconds | int | `20` |  |
| livenessProbe.timeoutSeconds | int | `5` |  |
| logLevel | string | `"info"` | Log level (debug, info, warn, error) |
| metrics.enabled | bool | `false` | Enable Prometheus metrics endpoint |
| metrics.serviceMonitor.enabled | bool | `false` | Create a ServiceMonitor resource |
| metrics.serviceMonitor.interval | string | `"30s"` | Scrape interval |
| metrics.serviceMonitor.labels | object | `{}` | Additional labels for ServiceMonitor |
| metrics.serviceMonitor.namespace | string | `""` | ServiceMonitor namespace (defaults to release namespace) |
| metrics.serviceMonitor.scrapeTimeout | string | `""` | Scrape timeout |
| networkPolicy.egress | list | `[{"ports":[{"port":443,"protocol":"TCP"},{"port":53,"protocol":"TCP"},{"port":53,"protocol":"UDP"}],"to":[]}]` | Egress rules (provider needs HTTPS to Proton API + DNS) |
| networkPolicy.enabled | bool | `false` | Enable network policy |
| networkPolicy.ingress | list | `[{"from":[{"namespaceSelector":{"matchLabels":{"kubernetes.io/metadata.name":"external-secrets"}}}],"ports":[{"port":8080,"protocol":"TCP"}]}]` | Ingress rules (who can reach the provider) |
| nodeSelector | object | `{}` | Node selector |
| podAnnotations | object | `{}` | Pod annotations |
| podDisruptionBudget.enabled | bool | `false` | Enable PDB |
| podDisruptionBudget.maxUnavailable | string | `""` | Maximum unavailable pods |
| podDisruptionBudget.minAvailable | int | `1` | Minimum available pods |
| podLabels | object | `{}` | Pod labels |
| podSecurityContext | object | `{"fsGroup":1000,"runAsNonRoot":true}` | Pod security context |
| protonpass.auth.credentials | object | `{"password":"","username":""}` | Credentials to create a new secret (NOT recommended for production) For production, pre-create a Secret (encrypted with SOPS) and reference it above |
| protonpass.auth.credentials.password | string | `""` | Proton account password |
| protonpass.auth.credentials.username | string | `""` | Proton account email address |
| protonpass.auth.existingSecret | object | `{"name":"","passwordKey":"password","usernameKey":"username"}` | Use an existing Kubernetes secret for Proton Pass credentials If set, the chart will NOT create a credentials secret |
| protonpass.auth.existingSecret.name | string | `""` | Name of the existing secret |
| protonpass.auth.existingSecret.passwordKey | string | `"password"` | Key in the secret containing the password |
| protonpass.auth.existingSecret.usernameKey | string | `"username"` | Key in the secret containing the username/email |
| protonpass.cache.enabled | bool | `true` | Enable in-memory secret caching |
| protonpass.cache.maxEntries | int | `1000` | Maximum cached entries |
| protonpass.cache.ttlSeconds | int | `300` | Cache time-to-live in seconds |
| protonpass.keyProvider | string | `"fs"` | pass-cli key provider for session encryption Options: fs (filesystem - for containers), env (environment variable), keyring (OS keyring - not for containers) |
| protonpass.vaults.allowed | list | `[]` | Allowed vaults (empty = all accessible vaults) |
| protonpass.vaults.denied | list | `[]` | Denied vaults (these vaults will never be accessed) |
| protonpass.vaults.shared | string | `""` | Default/shared company vault name or Share ID |
| readinessProbe.failureThreshold | int | `3` |  |
| readinessProbe.initialDelaySeconds | int | `10` |  |
| readinessProbe.periodSeconds | int | `10` |  |
| readinessProbe.timeoutSeconds | int | `5` |  |
| replicaCount | int | `1` | Number of replicas |
| resources.limits.cpu | string | `"200m"` |  |
| resources.limits.memory | string | `"256Mi"` |  |
| resources.requests.cpu | string | `"50m"` |  |
| resources.requests.memory | string | `"128Mi"` |  |
| securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"readOnlyRootFilesystem":false,"runAsNonRoot":true,"runAsUser":1000}` | Container security context |
| service.annotations | object | `{}` | Additional service annotations |
| service.labels | object | `{}` | Additional service labels |
| service.port | int | `8080` | Service port |
| service.type | string | `"ClusterIP"` | Service type |
| serviceAccount.annotations | object | `{}` | Service account annotations |
| serviceAccount.automount | bool | `false` | Automount service account token |
| serviceAccount.create | bool | `true` | Create a service account |
| serviceAccount.name | string | `""` | Service account name (defaults to fullname) |
| tolerations | list | `[]` | Tolerations |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
