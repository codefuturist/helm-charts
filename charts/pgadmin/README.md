# pgadmin

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 9.10.0](https://img.shields.io/badge/AppVersion-9.10.0-informational?style=flat-square)

A production-ready Helm chart for pgAdmin 4 - PostgreSQL management and administration tool

**Homepage:** <https://www.pgadmin.org/>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| codefuturist | <58808821+codefuturist@users.noreply.github.com> |  |

## Source Code

* <https://github.com/pgadmin-org/pgadmin4>
* <https://github.com/codefuturist/helm-charts>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalAnnotations | object | `{}` | Additional annotations to add to all resources |
| additionalLabels | object | `{}` | Additional labels to add to all resources |
| affinity | object | `{}` | Affinity for pod assignment |
| controller.args | list | `[]` | Args override for the main container |
| controller.command | list | `[]` | Command override for the main container |
| controller.lifecycle | object | `{}` | Lifecycle hooks for the main container |
| controller.podManagementPolicy | string | `"OrderedReady"` | Pod management policy (only used if controller.type is statefulset) |
| controller.replicas | int | `1` | Number of pgAdmin replicas |
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
| hpa | object | `{"customMetrics":[],"enabled":false,"maxReplicas":3,"minReplicas":1,"targetCPUUtilizationPercentage":80,"targetMemoryUtilizationPercentage":80}` | Horizontal Pod Autoscaler configuration Note: HPA is generally not recommended for pgAdmin as it's typically single-instance |
| hpa.customMetrics | list | `[]` | Custom metrics for autoscaling |
| hpa.enabled | bool | `false` | Enable HorizontalPodAutoscaler |
| hpa.maxReplicas | int | `3` | Maximum number of replicas |
| hpa.minReplicas | int | `1` | Minimum number of replicas |
| hpa.targetCPUUtilizationPercentage | int | `80` | Target CPU utilization percentage |
| hpa.targetMemoryUtilizationPercentage | int | `80` | Target memory utilization percentage |
| image.digest | string | `""` | Image digest (overrides tag if set) |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.repository | string | `"dpage/pgadmin4"` | pgAdmin 4 Docker image repository |
| image.tag | string | Chart appVersion | pgAdmin 4 Docker image tag |
| imagePullSecrets | list | `[]` | Image pull secrets for private registries |
| ingress.annotations | object | `{}` | Ingress annotations Example for nginx ingress: annotations:   cert-manager.io/cluster-issuer: "letsencrypt-prod"   nginx.ingress.kubernetes.io/backend-protocol: "HTTP" |
| ingress.className | string | `""` | Ingress class name |
| ingress.enabled | bool | `false` | Enable ingress |
| ingress.hosts | list | `[]` | Ingress hosts configuration Example: hosts:   - host: pgadmin.example.com     paths:       - path: /         pathType: Prefix |
| ingress.tls | list | `[]` | Ingress TLS configuration Example: tls:   - secretName: pgadmin-tls     hosts:       - pgadmin.example.com |
| initContainers | list | `[]` | Init containers to run before the main container |
| livenessProbe | object | `{"enabled":true,"failureThreshold":6,"httpGet":{"path":"/misc/ping","port":"http"},"initialDelaySeconds":30,"periodSeconds":10,"successThreshold":1,"timeoutSeconds":5}` | Liveness probe configuration |
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
| networkPolicy.egress | list | `[{"ports":[{"port":5432,"protocol":"TCP"}],"to":[{"namespaceSelector":{}}]},{"ports":[{"port":53,"protocol":"UDP"}],"to":[{"namespaceSelector":{}}]}]` | Egress rules By default, allow egress to PostgreSQL port |
| networkPolicy.enabled | bool | `false` | Enable network policy |
| networkPolicy.ingress | list | `[]` | Ingress rules Example to allow traffic from specific namespaces: ingress:   - from:     - namespaceSelector:         matchLabels:           name: ingress-nginx     ports:     - protocol: TCP       port: 80 |
| networkPolicy.policyTypes | list | `["Ingress","Egress"]` | Policy types |
| nodeSelector | object | `{}` | Node selector for pod assignment |
| pdb.enabled | bool | `false` | Enable PodDisruptionBudget |
| pdb.maxUnavailable | string | `""` | Maximum number of pods that can be unavailable |
| pdb.minAvailable | int | `1` | Minimum number of pods that must be available |
| persistence.accessMode | string | `"ReadWriteOnce"` | Access mode for the persistent volume |
| persistence.annotations | object | `{}` | Annotations for the PVC |
| persistence.enabled | bool | `false` | Enable persistent storage for pgAdmin data Data includes user preferences, sessions, and saved queries |
| persistence.existingClaim | string | `""` | Name of an existing PVC to use |
| persistence.size | string | `"1Gi"` | Size of the persistent volume |
| persistence.storageClassName | string | Default storage class | Storage class name |
| pgadmin.config | object | `{"PGADMIN_CONFIG_CONSOLE_LOG_LEVEL":"10","PGADMIN_CONFIG_ENHANCED_COOKIE_PROTECTION":"True","PGADMIN_CONFIG_SESSION_COOKIE_NAME":"pgadmin4_session","PGADMIN_LISTEN_PORT":"80"}` | pgAdmin configuration settings as environment variables See https://www.pgadmin.org/docs/pgadmin4/latest/container_deployment.html |
| pgadmin.configLocal | string | `""` | Custom config_local.py content for advanced pgAdmin configuration This Python file is loaded after config.py and can override any settings Example: configLocal: |   MASTER_PASSWORD_REQUIRED = False   SESSION_EXPIRATION_TIME = 1   ENHANCED_COOKIE_PROTECTION = True |
| pgadmin.disablePostfix | bool | `false` | Disable internal Postfix server (set to any value to disable) Useful when using external SMTP server or in environments that prevent sudo |
| pgadmin.email | string | `"admin@example.com"` | Default pgAdmin login email address (required if existingSecret is not set) |
| pgadmin.existingConfigLocalConfigMap | string | `""` | Name of an existing ConfigMap containing config_local.py |
| pgadmin.existingPgpassSecret | string | `""` | Name of an existing Secret containing pgpass file The secret must contain a key 'pgpass' with the pgpass file content |
| pgadmin.existingSecret | string | `""` | Name of an existing secret containing pgAdmin credentials The secret must contain keys for email and password (see existingSecretEmailKey and existingSecretPasswordKey) |
| pgadmin.existingSecretEmailKey | string | `"email"` | Key in existingSecret that contains the email address |
| pgadmin.existingSecretPasswordKey | string | `"password"` | Key in existingSecret that contains the password |
| pgadmin.existingServerDefinitionsConfigMap | string | `""` | Name of an existing ConfigMap containing server definitions (servers.json) If set, this takes precedence over serverDefinitions |
| pgadmin.gunicorn | object | `{"accessLogfile":"-","limitRequestLine":8190,"threads":25}` | Gunicorn configuration |
| pgadmin.gunicorn.accessLogfile | string | `"-"` | Access log file path (- for stdout, empty to disable) |
| pgadmin.gunicorn.limitRequestLine | int | `8190` | Maximum size of HTTP request line in bytes (0 for unlimited, not recommended) |
| pgadmin.gunicorn.threads | int | `25` | Number of threads per Gunicorn worker |
| pgadmin.ldap | object | `{"bindDN":"","bindPassword":"","enabled":false,"groupBaseDN":"","server":"","userBaseDN":""}` | LDAP/OAuth integration configuration |
| pgadmin.ldap.bindDN | string | `""` | LDAP bind DN |
| pgadmin.ldap.bindPassword | string | `""` | LDAP bind password |
| pgadmin.ldap.enabled | bool | `false` | Enable LDAP authentication |
| pgadmin.ldap.groupBaseDN | string | `""` | LDAP group base DN |
| pgadmin.ldap.server | string | `""` | LDAP server URI |
| pgadmin.ldap.userBaseDN | string | `""` | LDAP user base DN |
| pgadmin.password | string | (must be set or use existingSecret) | Default pgAdmin login password (required if existingSecret is not set) |
| pgadmin.pgpassFile | string | `""` | pgpass file content for automatic PostgreSQL authentication Format: hostname:port:database:username:password (one entry per line) Example: pgpassFile: |   postgresql.default.svc.cluster.local:5432:*:postgres:password123   postgresql-prod.database.svc:5432:production:dbuser:secret |
| pgadmin.replaceServersOnStartup | bool | `false` | Replace server definitions on every startup (not just first launch) When true, server definitions from serverDefinitions or existingServerDefinitionsConfigMap are reloaded on each start |
| pgadmin.scriptName | string | `""` | Script name for reverse proxy subdirectory hosting Set this when hosting pgAdmin under a subdirectory (e.g., /pgadmin4) This sets the SCRIPT_NAME environment variable |
| pgadmin.serverDefinitions | object | `{}` | Pre-configured PostgreSQL server definitions This will create a servers.json file mounted into pgAdmin Example: serverDefinitions:   servers:     1:       Name: "Production PostgreSQL"       Group: "Production"       Host: "postgresql.default.svc.cluster.local"       Port: 5432       MaintenanceDB: "postgres"       Username: "postgres"       SSLMode: "prefer" |
| pgadmin.smtp | object | `{"enabled":false,"existingSecret":"","existingSecretPasswordKey":"smtp-password","existingSecretUsernameKey":"smtp-username","fromAddress":"pgadmin@example.com","password":"","port":587,"server":"","useSSL":false,"useTLS":true,"username":""}` | SMTP/Email configuration for notifications and user management |
| pgadmin.smtp.enabled | bool | `false` | Enable SMTP configuration |
| pgadmin.smtp.existingSecret | string | `""` | Name of existing secret containing SMTP credentials |
| pgadmin.smtp.existingSecretPasswordKey | string | `"smtp-password"` | Key in existingSecret for SMTP password |
| pgadmin.smtp.existingSecretUsernameKey | string | `"smtp-username"` | Key in existingSecret for SMTP username |
| pgadmin.smtp.fromAddress | string | `"pgadmin@example.com"` | Email sender address |
| pgadmin.smtp.password | string | `""` | SMTP password |
| pgadmin.smtp.port | int | `587` | SMTP server port |
| pgadmin.smtp.server | string | `""` | SMTP server host |
| pgadmin.smtp.useSSL | bool | `false` | Use SSL for SMTP |
| pgadmin.smtp.useTLS | bool | `true` | Use TLS for SMTP |
| pgadmin.smtp.username | string | `""` | SMTP username |
| podAnnotations | object | `{}` | Pod annotations |
| podLabels | object | `{}` | Pod labels |
| podSecurityContext | object | `{"fsGroup":5050,"fsGroupChangePolicy":"OnRootMismatch","runAsNonRoot":true,"runAsUser":5050,"seccompProfile":{"type":"RuntimeDefault"}}` | Pod security context pgAdmin runs as user 5050 by default |
| priorityClassName | string | `""` | Priority class name for the pod |
| rbac.create | bool | `true` | Create RBAC resources |
| rbac.rules | list | `[]` | Additional RBAC rules |
| readinessProbe | object | `{"enabled":true,"failureThreshold":3,"httpGet":{"path":"/misc/ping","port":"http"},"initialDelaySeconds":15,"periodSeconds":10,"successThreshold":1,"timeoutSeconds":3}` | Readiness probe configuration |
| resources | object | `{"limits":{"cpu":"1000m","memory":"512Mi"},"requests":{"cpu":"100m","memory":"256Mi"}}` | Resource limits and requests |
| runtimeClassName | string | `""` | Runtime class name |
| securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"readOnlyRootFilesystem":false,"runAsNonRoot":true,"runAsUser":5050}` | Container security context |
| service.annotations | object | `{}` | Service annotations |
| service.clusterIP | string | `""` | Cluster IP (set to None for headless service) |
| service.externalTrafficPolicy | string | `""` | External traffic policy (only used if type is LoadBalancer or NodePort) |
| service.labels | object | `{}` | Service labels |
| service.loadBalancerIP | string | `""` | Load balancer IP (only used if type is LoadBalancer) |
| service.loadBalancerSourceRanges | list | `[]` | Load balancer source ranges (only used if type is LoadBalancer) |
| service.nodePort | string | `""` | Node port (only used if type is NodePort) |
| service.port | int | `80` | Service port |
| service.sessionAffinity | string | `"None"` | Session affinity |
| service.sessionAffinityConfig | object | `{}` | Session affinity config |
| service.targetPort | int | `80` | Service target port (container port) |
| service.type | string | `"ClusterIP"` | Service type |
| serviceAccount.annotations | object | `{}` | Service account annotations |
| serviceAccount.create | bool | `true` | Create a service account |
| serviceAccount.name | string | `""` | Service account name (generated if not set and create is true) |
| startupProbe | object | `{"enabled":true,"failureThreshold":30,"httpGet":{"path":"/misc/ping","port":"http"},"initialDelaySeconds":10,"periodSeconds":10,"successThreshold":1,"timeoutSeconds":3}` | Startup probe configuration |
| tolerations | list | `[]` | Tolerations for pod assignment |
| topologySpreadConstraints | list | `[]` | Topology spread constraints for pod distribution |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
