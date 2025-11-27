# home-assistant

![Version: 1.0.1](https://img.shields.io/badge/Version-1.0.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2024.11.1](https://img.shields.io/badge/AppVersion-2024.11.1-informational?style=flat-square)

A comprehensive Helm chart for Home Assistant - Open source home automation that puts local control and privacy first

**Homepage:** <https://www.home-assistant.io/>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| codefuturist | <58808821+codefuturist@users.noreply.github.com> |  |

## Source Code

* <https://github.com/home-assistant/core>
* <https://github.com/codefuturist/helm-charts>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalLabels | object | `{}` | Additional labels for all resources |
| additionalServices | list | `[]` | Additional services to create Useful for custom integrations that need separate service ports |
| affinity | object | `{}` | Affinity rules |
| autoscaling.enabled | bool | `false` | Enable horizontal pod autoscaling |
| autoscaling.maxReplicas | int | `1` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| autoscaling.targetMemoryUtilizationPercentage | int | `80` |  |
| codeserver.enabled | bool | `false` | Enable code-server sidecar |
| codeserver.env | object | `{"PASSWORD":""}` | Code server environment variables |
| codeserver.image.pullPolicy | string | `"IfNotPresent"` |  |
| codeserver.image.repository | string | `"codercom/code-server"` |  |
| codeserver.image.tag | string | `"4.19.1"` |  |
| codeserver.ingress.annotations | object | `{}` |  |
| codeserver.ingress.className | string | `""` |  |
| codeserver.ingress.enabled | bool | `false` | Enable separate ingress for code-server |
| codeserver.ingress.hosts[0].host | string | `"code.home-assistant.local"` |  |
| codeserver.ingress.hosts[0].paths[0].path | string | `"/"` |  |
| codeserver.ingress.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| codeserver.ingress.tls | list | `[]` |  |
| codeserver.port | int | `8080` | Code server port |
| codeserver.resources | object | `{"limits":{},"requests":{"cpu":"10m","memory":"64Mi"}}` | Resources for code-server Minimal requests to allow scheduling, no limits to allow bursting |
| configuration.enabled | bool | `false` | Enable automated configuration setup When enabled, creates ConfigMaps and init container to manage HA config files |
| configuration.forceInit | bool | `false` | Force initialization on every start Merges default config with existing config.yaml (keeps 10 most recent backups) |
| configuration.initContainer | object | `{"image":"mikefarah/yq:4","name":"setup-config","securityContext":{"runAsUser":0},"volumeMounts":[]}` | Init container configuration |
| configuration.initContainer.image | string | `"mikefarah/yq:4"` | Init container image (needs yq tool) |
| configuration.initContainer.name | string | `"setup-config"` | Init container name |
| configuration.initContainer.securityContext | object | `{"runAsUser":0}` | Init container security context |
| configuration.initContainer.volumeMounts | list | `[]` | Additional volume mounts for init container |
| configuration.initScript | string | `"#!/bin/bash\nset -e\n\n# Create configuration file if it doesn't exist\nif [ ! -f /config/configuration.yaml ]; then\n  echo \\\"Configuration file not found, creating from template\\\"\n  cp /config-templates/configuration.yaml /config/configuration.yaml\nfi\n\n# Handle forceInit mode\nforceInit=\\\"{{ .Values.configuration.forceInit }}\\\"\nif [ \\\"$forceInit\\\" = \\\"true\\\" ]; then\n  echo \\\"Force init enabled, merging configuration\\\"\n  current_time=$(date +%Y%m%d_%H%M%S)\n  echo \\\"Backing up current config to configuration.yaml.$current_time\\\"\n  cp /config/configuration.yaml /config/configuration.yaml.$current_time\n\n  echo \\\"Cleaning up old backups (keeping 10 most recent)\\\"\n  ls -t /config/configuration.yaml.* 2>/dev/null | tail -n +11 | xargs -r rm\n\n  if [[ ! -s /config/configuration.yaml ]]; then\n    cat /config-templates/configuration.yaml > /config/configuration.yaml\n  else\n    yq eval-all --inplace 'select(fileIndex == 0) *d select(fileIndex == 1)' /config/configuration.yaml /config-templates/configuration.yaml\n  fi\nfi\n\n# Create required YAML files if missing\nfor file in automations.yaml scripts.yaml scenes.yaml; do\n  if [ ! -f /config/$file ]; then\n    echo \\\"Creating $file\\\"\n    echo \\\"[]\\\" > /config/$file\n  fi\ndone"` | Init script for configuration management Executed before Home Assistant starts |
| configuration.templateConfig | string | `"# Loads default set of integrations. Do not remove.\ndefault_config:\n\n{{- if or .Values.ingress.enabled }}\nhttp:\n  use_x_forwarded_for: true\n  trusted_proxies:\n    {{- range .Values.configuration.trusted_proxies }}\n    - {{ . }}\n    {{- end }}\n{{- end }}\n\n# Load frontend themes from the themes folder\nfrontend:\n  themes: !include_dir_merge_named themes\n\nautomation: !include automations.yaml\nscript: !include scripts.yaml\nscene: !include scenes.yaml"` | Template for configuration.yaml file Uses Go templating with access to .Values |
| configuration.trusted_proxies | list | `["10.0.0.0/8","172.16.0.0/12","192.168.0.0/16","127.0.0.0/8"]` | Trusted proxy CIDR ranges for reverse proxy setups Add your ingress controller or load balancer IP ranges |
| controller.deploymentAnnotations | object | `{}` | Annotations for Deployment |
| controller.statefulSetAnnotations | object | `{}` | Annotations for StatefulSet |
| controller.type | string | `"Deployment"` | Controller type: StatefulSet or Deployment StatefulSet: Provides stable network identity and ordered deployment/scaling Deployment: Simpler, better for stateless or when using external storage |
| database.postgresql.database | string | `"homeassistant"` | Database name |
| database.postgresql.existingSecret | string | `""` | Existing secret name for database credentials |
| database.postgresql.host | string | `""` | PostgreSQL host |
| database.postgresql.passwordKey | string | `"password"` | Key in existing secret for password |
| database.postgresql.poolSize | string | `"5"` | Connection pool size |
| database.postgresql.port | int | `5432` | PostgreSQL port |
| database.postgresql.sslMode | bool | `"prefer"` | Use SSL for connection |
| database.postgresql.username | string | `"homeassistant"` | Database username |
| database.type | string | `"sqlite"` | Database type: sqlite or postgresql |
| devices.enabled | list | `false` | Host devices to mount (e.g., Zigbee/Z-Wave controllers) Each device should be an object with hostPath and containerPath |
| devices.list | list | `[]` |  |
| dnsConfig | object | `{}` | Custom DNS configuration Useful for reducing DNS load (set ndots: 0) or custom nameservers |
| dnsPolicy | string | `""` | DNS policy for the pod Options: ClusterFirst, ClusterFirstWithHostNet, Default, None |
| extraContainers | list | `[]` | Sidecar containers |
| extraVolumeMounts | object | `[]` | Extra volume mounts |
| extraVolumes | object | `[]` | Extra volumes |
| fullnameOverride | string | `""` | Override the full name |
| homeassistant.configuration | object | `{}` | configuration.yaml content (merged with auto-generated config) |
| homeassistant.env | object | `{}` | Environment variables |
| homeassistant.envFrom | object | `[]` | Environment variables from ConfigMap or Secret |
| homeassistant.existingConfigMap | bool | `""` | Use existing ConfigMap for configuration |
| homeassistant.secrets | object | `{}` | secrets.yaml content |
| hostNetwork.enabled | bool | `false` | Enable host network mode |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.repository | string | `"ghcr.io/home-assistant/home-assistant"` | Home Assistant image repository |
| image.tag | string | `""` | Override the image tag (default is appVersion from Chart.yaml) Common tags: 'stable' (latest stable), '2024.11.1' (specific version), 'latest' (bleeding edge) |
| imagePullSecrets | list | `[]` | Image pull secrets |
| ingress.annotations | object | `{}` | Ingress annotations |
| ingress.className | string | `""` | Ingress class name |
| ingress.enabled | bool | `false` | Enable ingress |
| ingress.hosts | list | `[{"host":"home-assistant.local","paths":[{"path":"/","pathType":"Prefix"}]}]` | Ingress hosts configuration |
| ingress.tls | list | `[]` | Ingress TLS configuration |
| initContainers | list | `[]` | Init containers |
| livenessProbe.enabled | bool | `true` | Enable liveness probe |
| livenessProbe.failureThreshold | int | `6` |  |
| livenessProbe.httpGet.path | string | `"/"` |  |
| livenessProbe.httpGet.port | string | `"http"` |  |
| livenessProbe.initialDelaySeconds | int | `60` |  |
| livenessProbe.periodSeconds | int | `10` |  |
| livenessProbe.timeoutSeconds | int | `5` |  |
| mqtt.config | object | `{}` | MQTT configuration |
| mqtt.enabled | bool | `false` | Enable MQTT sidecar (Eclipse Mosquitto) |
| mqtt.image.pullPolicy | string | `"IfNotPresent"` |  |
| mqtt.image.repository | string | `"eclipse-mosquitto"` |  |
| mqtt.image.tag | string | `"2.0"` |  |
| mqtt.persistence.enabled | bool | `false` | Enable MQTT persistence |
| mqtt.persistence.size | string | `"1Gi"` |  |
| mqtt.port | int | `1883` | MQTT port |
| mqtt.resources | object | `{"limits":{},"requests":{"cpu":"10m","memory":"32Mi"}}` | Resources for MQTT Minimal requests to allow scheduling, no limits to allow bursting |
| nameOverride | string | `""` | Override the name |
| namespaceOverride | string | `""` | Override the namespace for all resources. |
| nodeSelector | object | `{}` |  |
| persistence.accessMode | string | `"ReadWriteOnce"` | Access mode |
| persistence.annotations | object | `{}` | Annotations for PVC |
| persistence.backup.accessMode | string | `"ReadWriteOnce"` | Access mode |
| persistence.backup.enabled | bool | `false` | Enable backup persistence |
| persistence.backup.existingClaim | string | `""` | Existing claim |
| persistence.backup.size | string | `"5Gi"` | Storage size |
| persistence.backup.storageClassName | string | `""` | Storage class |
| persistence.enabled | bool | `false` | Enable persistence (uses emptyDir if disabled - data lost on restart) |
| persistence.existingClaim | string | `""` | Existing claim name (if using existing PVC) |
| persistence.media.accessMode | string | `"ReadWriteOnce"` | Access mode |
| persistence.media.enabled | bool | `false` | Enable media persistence |
| persistence.media.existingClaim | string | `""` | Existing claim |
| persistence.media.size | string | `"10Gi"` | Storage size |
| persistence.media.storageClassName | string | `""` | Storage class |
| persistence.retain | bool | `true` | Retain PVC on uninstall |
| persistence.size | string | `"5Gi"` | Storage size for configuration |
| persistence.storageClassName | string | `""` | Storage class name |
| podAnnotations | object | `{}` | Pod annotations |
| podDisruptionBudget.enabled | bool | `false` | Enable PodDisruptionBudget |
| podDisruptionBudget.minAvailable | int | `1` |  |
| podSecurityContext.fsGroup | int | `0` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsNonRoot | bool | `false` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| podSecurityContext.seccompProfile | object | `{"type":"RuntimeDefault"}` | Seccomp profile |
| priorityClassName | string | `""` | Priority class name for pod scheduling priority |
| rbac.create | bool | `true` | Create RBAC resources |
| readinessProbe.enabled | bool | `true` | Enable readiness probe |
| readinessProbe.failureThreshold | int | `3` |  |
| readinessProbe.httpGet.path | string | `"/"` |  |
| readinessProbe.httpGet.port | string | `"http"` |  |
| readinessProbe.initialDelaySeconds | int | `30` |  |
| readinessProbe.periodSeconds | int | `10` |  |
| readinessProbe.timeoutSeconds | int | `5` |  |
| replicaCount | int | `1` | Number of replicas (Home Assistant is typically single instance due to state) |
| resources.limits | object | `{}` | Resource limits |
| resources.requests | object | `{"cpu":"10m","memory":"128Mi"}` | Resource requests |
| securityContext.allowPrivilegeEscalation | bool | `false` | Allow privilege escalation |
| securityContext.capabilities | object | `{"add":["NET_ADMIN","NET_RAW","SYS_ADMIN"],"drop":["ALL"]}` | Capabilities |
| securityContext.privileged | bool | `false` | Run as privileged container (grants all capabilities) WARNING: Only enable if you need Bluetooth or full D-Bus system access SECURITY: This grants extensive permissions - use specific capabilities instead To enable privileged mode, set: privileged: true and capabilities.add: [] |
| securityContext.readOnlyRootFilesystem | bool | `false` | Read-only root filesystem |
| service.annotations | object | `{}` | Additional annotations for service |
| service.externalTrafficPolicy | string | `""` | External traffic policy |
| service.labels | object | `{}` | Additional labels for service |
| service.loadBalancerIP | string | `""` | Load balancer IP (if type is LoadBalancer) |
| service.loadBalancerSourceRanges | list | `[]` | Load balancer source ranges |
| service.nodePort | string | `""` | Node port (if type is NodePort) |
| service.port | int | `8123` | Service port |
| service.targetPort | int | `8123` | Target container port |
| service.type | string | `"ClusterIP"` | Service type |
| serviceAccount.annotations | object | `{}` | Annotations for service account |
| serviceAccount.create | bool | `true` | Create service account |
| serviceAccount.name | string | `""` | Service account name |
| serviceMonitor.bearerToken | object | `{"secretKey":"","secretName":""}` | Bearer token authentication configuration Requires Home Assistant Prometheus integration: https://www.home-assistant.io/integrations/prometheus/ |
| serviceMonitor.bearerToken.secretKey | string | `""` | Key in the secret containing the bearer token |
| serviceMonitor.bearerToken.secretName | string | `""` | Name of the secret containing the bearer token |
| serviceMonitor.enabled | bool | `false` | Enable ServiceMonitor for Prometheus |
| serviceMonitor.interval | string | `"30s"` | Scrape interval |
| serviceMonitor.labels | object | `{}` | Additional labels |
| serviceMonitor.namespace | string | `""` | Namespace for ServiceMonitor |
| serviceMonitor.path | string | `"/api/prometheus"` | Metrics path |
| serviceMonitor.scrapeTimeout | string | `"10s"` | Scrape timeout |
| startupProbe.enabled | bool | `true` | Enable startup probe |
| startupProbe.failureThreshold | int | `30` |  |
| startupProbe.httpGet.path | string | `"/"` |  |
| startupProbe.httpGet.port | string | `"http"` |  |
| startupProbe.initialDelaySeconds | int | `10` |  |
| startupProbe.periodSeconds | int | `10` |  |
| startupProbe.timeoutSeconds | int | `5` |  |
| strategy.type | string | `"Recreate"` | Deployment strategy type (Recreate or RollingUpdate) Recreate: All old pods are killed before new ones are created (safer for single instance) RollingUpdate: Gradual replacement (use with replicaCount > 1) |
| systemVolumes.dbus.enabled | bool | `false` | Mount /run/dbus from host |
| systemVolumes.dbus.hostPath | string | `"/run/dbus"` | Path to dbus socket on host |
| systemVolumes.localtime.enabled | bool | `false` | Mount /etc/localtime from host |
| systemVolumes.localtime.hostPath | string | `"/etc/localtime"` | Path to localtime on host |
| tolerations | list | `[]` | Tolerations |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
