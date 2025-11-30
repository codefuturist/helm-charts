# compass-web

![Version: 1.0.1](https://img.shields.io/badge/Version-1.0.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.3.1](https://img.shields.io/badge/AppVersion-0.3.1-informational?style=flat-square)

A production-ready Helm chart for MongoDB Compass Web - MongoDB database management and administration tool

**Homepage:** <https://github.com/haohanyang/compass-web>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| codefuturist | <58808821+codefuturist@users.noreply.github.com> |  |

## Source Code

* <https://github.com/haohanyang/compass-web>
* <https://github.com/codefuturist/helm-charts>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalAnnotations | object | `{}` | Additional annotations to add to all resources |
| additionalLabels | object | `{}` | Additional labels to add to all resources |
| affinity | object | `{}` | Affinity for pod assignment |
| compassWeb.appName | string | `"Compass Web"` | Application name displayed in the UI |
| compassWeb.basicAuth | object | `{"enabled":false,"existingSecret":"","existingSecretPasswordKey":"password","existingSecretUsernameKey":"username","password":"","username":""}` | Basic HTTP authentication configuration |
| compassWeb.basicAuth.enabled | bool | `false` | Enable basic authentication |
| compassWeb.basicAuth.existingSecret | string | `""` | Name of existing secret containing basic auth credentials |
| compassWeb.basicAuth.existingSecretPasswordKey | string | `"password"` | Key in existingSecret for password |
| compassWeb.basicAuth.existingSecretUsernameKey | string | `"username"` | Key in existingSecret for username |
| compassWeb.basicAuth.password | string | `""` | Password for basic auth |
| compassWeb.basicAuth.username | string | `""` | Username for basic auth |
| compassWeb.clusterId | string | `"default-cluster-id"` | Cluster ID associated with the connection |
| compassWeb.config | object | `{}` | Additional Compass Web configuration as environment variables All variables are prefixed with CW_ in the container |
| compassWeb.existingSecret | string | `""` | Name of an existing secret containing MongoDB connection string The secret must contain a key 'mongoUri' with the connection string(s) |
| compassWeb.existingSecretKey | string | `"mongoUri"` | Key in existingSecret that contains the MongoDB URI |
| compassWeb.genAI | object | `{"aggregationSystemPrompt":"","apiKey":"","enableSampleDocuments":false,"enabled":false,"existingSecret":"","existingSecretKey":"apiKey","model":"gpt-4o-mini","querySystemPrompt":""}` | GenAI features configuration (requires OpenAI API key) |
| compassWeb.genAI.aggregationSystemPrompt | string | `""` | Custom system prompt for aggregation generation |
| compassWeb.genAI.apiKey | string | `""` | OpenAI API key |
| compassWeb.genAI.enableSampleDocuments | bool | `false` | Enable uploading sample documents to GenAI service |
| compassWeb.genAI.enabled | bool | `false` | Enable GenAI features |
| compassWeb.genAI.existingSecret | string | `""` | Name of existing secret containing OpenAI API key |
| compassWeb.genAI.existingSecretKey | string | `"apiKey"` | Key in existingSecret for API key |
| compassWeb.genAI.model | string | `"gpt-4o-mini"` | OpenAI model to use |
| compassWeb.genAI.querySystemPrompt | string | `""` | Custom system prompt for query generation |
| compassWeb.mongoUri | string | `""` | MongoDB connection string(s) (required) Can be a single URI or multiple URIs separated by whitespace Example: "mongodb://localhost:27017" Example multiple: "mongodb://localhost:27017 mongodb+srv://user:pass@cluster.mongodb.net/" |
| compassWeb.orgId | string | `"default-org-id"` | Organization ID associated with the connection |
| compassWeb.projectId | string | `"default-project-id"` | Project ID associated with the connection |
| controller.args | list | `[]` | Args override for the main container |
| controller.command | list | `[]` | Command override for the main container |
| controller.lifecycle | object | `{}` | Lifecycle hooks for the main container |
| controller.podManagementPolicy | string | `"OrderedReady"` | Pod management policy (only used if controller.type is statefulset) |
| controller.replicas | int | `1` | Number of replicas |
| controller.strategy | object | `{"type":"Recreate"}` | Deployment update strategy |
| controller.terminationGracePeriodSeconds | int | `30` | Termination grace period in seconds |
| controller.type | string | `"deployment"` | Controller type (deployment or statefulset) |
| controller.updateStrategy | object | `{"type":"RollingUpdate"}` | StatefulSet update strategy (only used if controller.type is statefulset) |
| controller.workingDir | string | `""` | Working directory for the main container |
| diagnosticMode.args | list | `["infinity"]` | Args override for diagnostic mode |
| diagnosticMode.command | list | `["sleep"]` | Command override for diagnostic mode |
| diagnosticMode.enabled | bool | `false` | Enable diagnostic mode (disables probes, overrides command) Useful for debugging container startup issues |
| dnsConfig | object | `{}` | DNS config |
| dnsPolicy | string | `"ClusterFirst"` | DNS policy |
| extraContainers | list | `[]` | Extra sidecar containers |
| extraEnv | list | `[]` | Extra environment variables |
| extraEnvFrom | list | `[]` | Extra environment variables from ConfigMaps or Secrets |
| extraVolumeMounts | list | `[]` | Extra volume mounts |
| extraVolumes | list | `[]` | Extra volumes |
| fullnameOverride | string | `""` | Override the full name of the chart |
| hostAliases | list | `[]` | Host aliases |
| hpa | object | `{"customMetrics":[],"enabled":false,"maxReplicas":3,"minReplicas":1,"targetCPUUtilizationPercentage":80,"targetMemoryUtilizationPercentage":80}` | Horizontal Pod Autoscaler configuration |
| hpa.customMetrics | list | `[]` | Custom metrics for autoscaling |
| hpa.enabled | bool | `false` | Enable HorizontalPodAutoscaler |
| hpa.maxReplicas | int | `3` | Maximum number of replicas |
| hpa.minReplicas | int | `1` | Minimum number of replicas |
| hpa.targetCPUUtilizationPercentage | int | `80` | Target CPU utilization percentage |
| hpa.targetMemoryUtilizationPercentage | int | `80` | Target memory utilization percentage |
| image.digest | string | `""` | Image digest (overrides tag if set) |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.repository | string | `"haohanyang/compass-web"` | MongoDB Compass Web Docker image repository |
| image.tag | string | Chart appVersion | MongoDB Compass Web Docker image tag |
| imagePullSecrets | list | `[]` | Image pull secrets for private registries |
| ingress.annotations | object | `{}` | Ingress annotations Example for nginx ingress: annotations:   cert-manager.io/cluster-issuer: "letsencrypt-prod"   nginx.ingress.kubernetes.io/backend-protocol: "HTTP" |
| ingress.className | string | `""` | Ingress class name |
| ingress.enabled | bool | `false` | Enable ingress |
| ingress.hosts | list | `[]` | Ingress hosts configuration Example: hosts:   - host: compass.example.com     paths:       - path: /         pathType: Prefix |
| ingress.tls | list | `[]` | Ingress TLS configuration Example: tls:   - secretName: compass-tls     hosts:       - compass.example.com |
| initContainers | list | `[]` | Init containers to run before the main container |
| livenessProbe | object | `{"enabled":true,"failureThreshold":6,"httpGet":{"path":"/","port":"http"},"initialDelaySeconds":30,"periodSeconds":10,"successThreshold":1,"timeoutSeconds":5}` | Liveness probe configuration |
| monitoring.prometheusRule.enabled | bool | `false` | Enable PrometheusRule for alerting |
| monitoring.prometheusRule.labels | object | `{}` | Additional labels for the PrometheusRule |
| monitoring.prometheusRule.namespace | string | `""` | Namespace for the PrometheusRule (defaults to the release namespace) |
| monitoring.prometheusRule.rules | list | `[]` | Alert rules |
| monitoring.serviceMonitor.annotations | object | `{}` | Additional annotations for the ServiceMonitor |
| monitoring.serviceMonitor.enabled | bool | `false` | Enable ServiceMonitor for Prometheus Operator |
| monitoring.serviceMonitor.interval | string | `"30s"` | Interval at which metrics should be scraped |
| monitoring.serviceMonitor.labels | object | `{}` | Additional labels for the ServiceMonitor |
| monitoring.serviceMonitor.metricRelabelings | list | `[]` | Metric relabelings |
| monitoring.serviceMonitor.namespace | string | `""` | Namespace for the ServiceMonitor (defaults to the release namespace) |
| monitoring.serviceMonitor.relabelings | list | `[]` | Relabelings |
| monitoring.serviceMonitor.scrapeTimeout | string | `"10s"` | Timeout for scraping metrics |
| nameOverride | string | `""` | Override the name of the chart |
| namespaceOverride | string | `.Release.Namespace` | Override the namespace for all resources |
| networkPolicy.egress | list | `[{"ports":[{"port":27017,"protocol":"TCP"}],"to":[{"namespaceSelector":{}}]},{"ports":[{"port":27017,"protocol":"TCP"},{"port":27018,"protocol":"TCP"},{"port":27019,"protocol":"TCP"}],"to":[{"namespaceSelector":{}}]},{"ports":[{"port":53,"protocol":"UDP"}],"to":[{"namespaceSelector":{}}]},{"ports":[{"port":443,"protocol":"TCP"}],"to":[{"namespaceSelector":{}}]}]` | Egress rules By default, allow egress to MongoDB port and DNS |
| networkPolicy.enabled | bool | `false` | Enable network policy |
| networkPolicy.ingress | list | `[]` | Ingress rules Example to allow traffic from specific namespaces: ingress:   - from:     - namespaceSelector:         matchLabels:           name: ingress-nginx     ports:     - protocol: TCP       port: 8080 |
| networkPolicy.policyTypes | list | `["Ingress","Egress"]` | Policy types |
| nodeSelector | object | `{}` | Node selector for pod assignment |
| pdb.enabled | bool | `false` | Enable PodDisruptionBudget |
| pdb.maxUnavailable | string | `""` | Maximum number of pods that can be unavailable |
| pdb.minAvailable | int | `1` | Minimum number of pods that must be available |
| persistence.accessMode | string | `"ReadWriteOnce"` | Access mode for the persistent volume |
| persistence.annotations | object | `{}` | Annotations for the PVC |
| persistence.enabled | bool | `false` | Enable persistent storage for Compass Web data Note: Compass Web is mostly stateless, persistence is optional |
| persistence.existingClaim | string | `""` | Name of an existing PVC to use |
| persistence.size | string | `"1Gi"` | Size of the persistent volume |
| persistence.storageClassName | string | Default storage class | Storage class name |
| podAnnotations | object | `{}` | Pod annotations |
| podLabels | object | `{}` | Pod labels |
| podSecurityContext | object | `{"fsGroup":1000,"fsGroupChangePolicy":"OnRootMismatch","runAsNonRoot":true,"runAsUser":1000,"seccompProfile":{"type":"RuntimeDefault"}}` | Pod security context |
| priorityClassName | string | `""` | Priority class name for the pod |
| rbac.create | bool | `true` | Create RBAC resources |
| rbac.rules | list | `[]` | Additional RBAC rules |
| readinessProbe | object | `{"enabled":true,"failureThreshold":3,"httpGet":{"path":"/","port":"http"},"initialDelaySeconds":15,"periodSeconds":10,"successThreshold":1,"timeoutSeconds":3}` | Readiness probe configuration |
| resources | object | `{"limits":{},"requests":{"cpu":"10m","memory":"64Mi"}}` | Resource limits and requests Minimal requests to allow scheduling, no limits to allow bursting |
| runtimeClassName | string | `""` | Runtime class name |
| securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"readOnlyRootFilesystem":false,"runAsNonRoot":true,"runAsUser":1000}` | Container security context |
| service.annotations | object | `{}` | Service annotations |
| service.clusterIP | string | `""` | Cluster IP (set to None for headless service) |
| service.externalTrafficPolicy | string | `""` | External traffic policy (only used if type is LoadBalancer or NodePort) |
| service.labels | object | `{}` | Service labels |
| service.loadBalancerIP | string | `""` | Load balancer IP (only used if type is LoadBalancer) |
| service.loadBalancerSourceRanges | list | `[]` | Load balancer source ranges (only used if type is LoadBalancer) |
| service.nodePort | string | `""` | Node port (only used if type is NodePort) |
| service.port | int | `8080` | Service port |
| service.sessionAffinity | string | `"None"` | Session affinity |
| service.sessionAffinityConfig | object | `{}` | Session affinity config |
| service.targetPort | int | `8080` | Service target port (container port) |
| service.type | string | `"ClusterIP"` | Service type |
| serviceAccount.annotations | object | `{}` | Service account annotations |
| serviceAccount.create | bool | `true` | Create a service account |
| serviceAccount.name | string | `""` | Service account name (generated if not set and create is true) |
| startupProbe | object | `{"enabled":true,"failureThreshold":30,"httpGet":{"path":"/","port":"http"},"initialDelaySeconds":10,"periodSeconds":10,"successThreshold":1,"timeoutSeconds":3}` | Startup probe configuration |
| tolerations | list | `[]` | Tolerations for pod assignment |
| topologySpreadConstraints | list | `[]` | Topology spread constraints for pod distribution |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
