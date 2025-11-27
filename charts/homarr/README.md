# homarr

![Version: 1.0.2](https://img.shields.io/badge/Version-1.0.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: latest](https://img.shields.io/badge/AppVersion-latest-informational?style=flat-square)

A Helm chart for Homarr - A simple, yet powerful dashboard for your server

**Homepage:** <https://homarr.dev>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| codefuturist | <58808821+codefuturist@users.noreply.github.com> |  |

## Source Code

* <https://github.com/homarr-labs/homarr>

## Values

### Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalLabels | tpl/object | `{}` | Additional labels for all resources. |
| applicationName | string | `{{ .Chart.Name }}` | Application name. |
| componentOverride | string | `""` | Override the component label for all resources. |
| extraObjects | list | `[]` | Extra K8s manifests to deploy. |
| namespaceOverride | string | `""` | Override the namespace for all resources. |
| partOfOverride | string | `""` | Override the partOf label for all resources. |

### AlertmanagerConfig Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| alertmanagerConfig.enabled | bool | `false` | Deploy an AlertmanagerConfig resource. |
| alertmanagerConfig.selectionLabels | object | `{"alertmanagerConfig":"workload"}` | Labels to be picked up by Alertmanager. |
| alertmanagerConfig.spec | object | `{"inhibitRules":[],"receivers":[],"route":null}` | AlertmanagerConfig spec. |

### Autoscaling Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| autoscaling.additionalLabels | object | `{}` | Additional labels for HPA. |
| autoscaling.annotations | object | `{}` | Annotations for HPA. |
| autoscaling.enabled | bool | `false` | Enable Horizontal Pod Autoscaling. |
| autoscaling.maxReplicas | int | `10` | Maximum number of replicas. |
| autoscaling.metrics | list | `[{"resource":{"name":"cpu","target":{"averageUtilization":60,"type":"Utilization"}},"type":"Resource"},{"resource":{"name":"memory","target":{"averageUtilization":60,"type":"Utilization"}},"type":"Resource"}]` | Metrics used for autoscaling. |
| autoscaling.minReplicas | int | `1` | Minimum number of replicas. |

### Backup Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| backup.additionalLabels | object | `{}` | Additional labels for Backup. |
| backup.annotations | object | `{}` | Annotations for Backup. |
| backup.defaultVolumesToRestic | bool | `true` | Use Restic for backups. |
| backup.enabled | bool | `false` | Deploy a Backup resource. |
| backup.excludedResources | list | `[]` | Excluded resources. |
| backup.includedNamespaces | list | `[]` | Included namespaces. |
| backup.includedResources | list | `[]` | Included resources. |
| backup.namespace | string | `""` | Namespace for Backup. |
| backup.snapshotVolumes | bool | `true` | Snapshot volumes. |
| backup.storageLocation | string | `""` | Storage location. |
| backup.ttl | string | `"1h0m0s"` | TTL for backup. |

### Certificate Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| certificate.additionalLabels | object | `{}` | Additional labels for Certificate. |
| certificate.annotations | object | `{}` | Annotations for Certificate. |
| certificate.dnsNames | tpl/list | `["homarr.local"]` | DNS names for the certificate. |
| certificate.duration | string | `"8760h0m0s"` | Duration of the certificate. |
| certificate.enabled | bool | `false` | Deploy a cert-manager Certificate resource. |
| certificate.issuerRef.group | string | `"cert-manager.io"` | Group of the issuer. |
| certificate.issuerRef.kind | string | `"ClusterIssuer"` | Kind of the issuer. |
| certificate.issuerRef.name | string | `"ca-issuer"` | Name of the issuer. |
| certificate.renewBefore | string | `"720h0m0s"` | Renew before duration. |
| certificate.secretName | tpl/string | `"homarr-tls"` | Secret name for the certificate. |

### ConfigMap Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| configMap.additionalLabels | object | `{}` | Additional labels for ConfigMaps. |
| configMap.annotations | object | `{}` | Annotations for ConfigMaps. |
| configMap.enabled | bool | `false` | Deploy additional ConfigMaps. |
| configMap.files | object | `{}` | Map of ConfigMaps. |

### CronJob Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cronJob.enabled | bool | `false` | Deploy CronJob resources. |
| cronJob.jobs | object | `{}` | Map of CronJob resources. |

### Deployment Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| deployment.additionalContainers | list | `[]` | Additional containers. |
| deployment.additionalLabels | object | `{}` | Additional labels for Deployment. |
| deployment.additionalPodAnnotations | object | `{}` | Additional pod annotations. |
| deployment.affinity | object | `{}` | Affinity for the pods. |
| deployment.annotations | object | `{}` | Annotations for Deployment. |
| deployment.args | list | `[]` | Args for the app container. |
| deployment.command | list | `[]` | Command for the app container. |
| deployment.containerSecurityContext | object | `{"readOnlyRootFilesystem":false,"runAsGroup":0,"runAsNonRoot":false,"runAsUser":0}` | Security Context at Container Level. |
| deployment.dnsConfig | object | `{}` | DNS config for the pods. |
| deployment.dnsPolicy | object | `""` | DNS Policy. |
| deployment.enabled | bool | `true` | Enable Deployment. |
| deployment.env | object | `nil` | Environment variables to be added to the pod. |
| deployment.envFrom | object | `{}` | Mount environment variables from ConfigMap or Secret to the pod. |
| deployment.fluentdConfigAnnotations | object | `{}` | Fluentd configuration annotations. |
| deployment.hostAliases | list | `[]` | Host aliases. |
| deployment.image.digest | tpl/string | `""` | Image digest. If resolved to a non-empty value, digest takes precedence on the tag. |
| deployment.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy. |
| deployment.image.repository | tpl/string | `"ghcr.io/homarr-labs/homarr"` | Repository. |
| deployment.image.tag | tpl/string | `"latest"` | Tag. |
| deployment.imagePullSecrets | list | `[]` | List of secrets to be used for pulling the images. |
| deployment.initContainers | object | `{}` | Init containers. |
| deployment.livenessProbe | object | `{"enabled":true,"exec":{},"failureThreshold":3,"httpGet":{"path":"/api/health/live","port":"http"},"initialDelaySeconds":10,"periodSeconds":20,"successThreshold":1,"tcpSocket":{},"timeoutSeconds":5}` | Liveness probe. |
| deployment.livenessProbe.enabled | bool | `true` | Enable Liveness probe. |
| deployment.livenessProbe.exec | object | `{}` | Exec probe. |
| deployment.livenessProbe.failureThreshold | int | `3` | Number of retries before marking the pod as failed. |
| deployment.livenessProbe.httpGet | object | `{"path":"/api/health/live","port":"http"}` | HTTP Get probe. |
| deployment.livenessProbe.initialDelaySeconds | int | `10` | Initial delay before probe starts. |
| deployment.livenessProbe.periodSeconds | int | `20` | Time between retries. |
| deployment.livenessProbe.successThreshold | int | `1` | Number of successful probes before marking the pod as ready. |
| deployment.livenessProbe.tcpSocket | object | `{}` | TCP Socket probe. |
| deployment.livenessProbe.timeoutSeconds | int | `5` | Time before the probe times out. |
| deployment.nodeSelector | object | `{}` | Select the node where the pods should be scheduled. |
| deployment.openshiftOAuthProxy | object | `{"disableTLSArg":false,"enabled":false,"image":"openshift/oauth-proxy:latest","port":7575,"secretName":"openshift-oauth-proxy-tls"}` | OpenShift OAuth Proxy configuration. |
| deployment.podLabels | object | `{}` | Additional pod labels which are used in Service's Label Selector. |
| deployment.ports | list | `[{"containerPort":3000,"name":"http","protocol":"TCP"}]` | List of ports for the app container. |
| deployment.priorityClassName | string | `""` | Define the priority class for the pod. |
| deployment.readinessProbe | object | `{"enabled":true,"exec":{},"failureThreshold":3,"httpGet":{"path":"/api/health/ready","port":"http"},"initialDelaySeconds":10,"periodSeconds":10,"successThreshold":1,"tcpSocket":{},"timeoutSeconds":5}` | Readiness probe. |
| deployment.readinessProbe.enabled | bool | `true` | Enable Readiness probe. |
| deployment.readinessProbe.exec | object | `{}` | Exec probe. |
| deployment.readinessProbe.failureThreshold | int | `3` | Number of retries before marking the pod as failed. |
| deployment.readinessProbe.httpGet | object | `{"path":"/api/health/ready","port":"http"}` | HTTP Get probe. |
| deployment.readinessProbe.initialDelaySeconds | int | `10` | Initial delay before probe starts. |
| deployment.readinessProbe.periodSeconds | int | `10` | Time between retries. |
| deployment.readinessProbe.successThreshold | int | `1` | Number of successful probes before marking the pod as ready. |
| deployment.readinessProbe.tcpSocket | object | `{}` | TCP Socket probe. |
| deployment.readinessProbe.timeoutSeconds | int | `5` | Time before the probe times out. |
| deployment.reloadOnChange | bool | `true` | Reload deployment if attached Secret/ConfigMap changes. |
| deployment.replicas | int | `1` | Number of replicas. |
| deployment.resources | object | `{"limits":{},"requests":{"cpu":"10m","memory":"64Mi"}}` | Resource limits and requests for the pod. Minimal requests to allow scheduling, no limits to allow bursting |
| deployment.revisionHistoryLimit | int | `2` | Number of ReplicaSet revisions to retain. |
| deployment.securityContext | object | `{"fsGroup":0}` | Security Context for the pod. |
| deployment.startupProbe | object | `{"enabled":true,"exec":{},"failureThreshold":30,"httpGet":{"path":"/api/health/live","port":"http"},"periodSeconds":10,"successThreshold":1,"tcpSocket":{},"timeoutSeconds":5}` | Startup probe. |
| deployment.startupProbe | object | `{"enabled":false,"exec":{},"failureThreshold":30,"httpGet":{},"periodSeconds":10,"successThreshold":1,"tcpSocket":{},"timeoutSeconds":1}` | Startup probe. |
| deployment.startupProbe.enabled | bool | `true` | Enable Startup probe. |
| deployment.startupProbe.enabled | bool | `false` | Enable Startup probe. |
| deployment.startupProbe.exec | object | `{}` | Exec probe. |
| deployment.startupProbe.exec | object | `{}` | Exec probe. |
| deployment.startupProbe.failureThreshold | int | `30` | Number of retries before marking the pod as failed. |
| deployment.startupProbe.failureThreshold | int | `30` | Number of retries before marking the pod as failed. |
| deployment.startupProbe.httpGet | object | `{"path":"/api/health/live","port":"http"}` | HTTP Get probe. |
| deployment.startupProbe.httpGet | object | `{}` | HTTP Get probe. |
| deployment.startupProbe.periodSeconds | int | `10` | Time between retries. |
| deployment.startupProbe.periodSeconds | int | `10` | Time between retries. |
| deployment.startupProbe.successThreshold | int | `1` | Number of successful probes before marking the pod as ready. |
| deployment.startupProbe.successThreshold | int | `1` | Number of successful probes before marking the pod as ready. |
| deployment.startupProbe.tcpSocket | object | `{}` | TCP Socket probe. |
| deployment.startupProbe.tcpSocket | object | `{}` | TCP Socket probe. |
| deployment.startupProbe.timeoutSeconds | int | `1` | Time before the probe times out. |
| deployment.startupProbe.timeoutSeconds | int | `5` | Time before the probe times out. |
| deployment.strategy.type | string | `"RollingUpdate"` | Type of deployment strategy. |
| deployment.tolerations | list | `[]` | Taint tolerations for the pods. |
| deployment.topologySpreadConstraints | list | `[]` | Topology spread constraints for the pods. |
| deployment.volumeMounts | object | `nil` | Mount path for Volumes. |
| deployment.volumes | object | `nil` | Volumes to be added to the pod. |

### EndpointMonitor Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| endpointMonitor.additionalLabels | object | `{}` | Additional labels for EndpointMonitor. |
| endpointMonitor.annotations | object | `{}` | Annotations for EndpointMonitor. |
| endpointMonitor.enabled | bool | `false` | Deploy an EndpointMonitor resource. |

### ExternalSecret Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| externalSecret.additionalLabels | object | `{}` | Additional labels for ExternalSecret. |
| externalSecret.annotations | object | `{}` | Annotations for ExternalSecret. |
| externalSecret.enabled | bool | `false` | Deploy ExternalSecret resources. |
| externalSecret.files | object | `{}` | List of ExternalSecret entries. |
| externalSecret.refreshInterval | string | `"1m"` | RefreshInterval for ExternalSecret. |
| externalSecret.secretStore | object | `{"kind":"SecretStore","name":"tenant-vault-secret-store"}` | Default values for the SecretStore. |

### ForecastleApp Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| forecastle.additionalLabels | object | `{}` | Additional labels for ForecastleApp. |
| forecastle.displayName | string | `"Homarr"` | Application Name. |
| forecastle.enabled | bool | `false` | Deploy a ForecastleApp resource. |
| forecastle.group | string | `{{ .Release.Namespace }}` | Application Group. |
| forecastle.icon | string | `"https://homarr.dev/img/logo.png"` | Icon URL. |
| forecastle.networkRestricted | bool | `false` | Is application network restricted?. |
| forecastle.properties | object | `{}` | Custom properties. |

### GrafanaDashboard Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| grafanaDashboard.additionalLabels | object | `{}` | Additional labels for GrafanaDashboard. |
| grafanaDashboard.annotations | object | `{}` | Annotations for GrafanaDashboard. |
| grafanaDashboard.contents | object | `{}` | List of GrafanaDashboard entries. |
| grafanaDashboard.enabled | bool | `false` | Deploy GrafanaDashboard resources. |

### HTTPRoute Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| httpRoute.additionalLabels | object | `{}` | Additional labels for HTTPRoute. |
| httpRoute.annotations | object | `{}` | Annotations for HTTPRoute. |
| httpRoute.enabled | bool | `false` | Enable HTTPRoute (Gateway API). |
| httpRoute.gatewayNamespace | string | `""` | Gateway namespace. |
| httpRoute.hostnames | list | `[]` | Hostnames for the HTTPRoute. |
| httpRoute.parentRefs | list | `[]` | Parent references for the HTTPRoute. |
| httpRoute.rules | list | `[]` | Rules for HTTPRoute. |
| httpRoute.useDefaultGateways | string | `""` | Gateway scope. |

### Ingress Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| ingress.additionalLabels | object | `{}` | Additional labels for ingress. |
| ingress.annotations | object | `{}` | Annotations for ingress. |
| ingress.enabled | bool | `false` | Enable Ingress. |
| ingress.hosts[0].host | tpl/string | `"homarr.local"` | Hostname. |
| ingress.hosts[0].paths[0].path | string | `"/"` | Path. |
| ingress.hosts[0].paths[0].pathType | string | `"Prefix"` | Path type. |
| ingress.ingressClassName | string | `""` | Name of the ingress class. |
| ingress.tls | list | `[]` | TLS configuration for ingress. |

### Job Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| job.enabled | bool | `false` | Deploy Job resources. |
| job.jobs | object | `{}` | Map of Job resources. |

### NetworkPolicy Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| networkPolicy.additionalLabels | object | `{}` | Additional labels for NetworkPolicy. |
| networkPolicy.annotations | object | `{}` | Annotations for NetworkPolicy. |
| networkPolicy.egress | list | `[]` | Egress rules for NetworkPolicy. |
| networkPolicy.enabled | bool | `false` | Deploy NetworkPolicy resource. |
| networkPolicy.ingress | list | `[]` | Ingress rules for NetworkPolicy. |
| networkPolicy.podSelector | list | `{"matchLabels":{}}` | Pod Selector for NetworkPolicy. |

### PDB Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| pdb.additionalLabels | object | `{}` | Additional labels for PDB. |
| pdb.annotations | object | `{}` | Annotations for PDB. |
| pdb.enabled | bool | `false` | Enable Pod Disruption Budget. |
| pdb.maxUnavailable | int | `nil` | Maximum unavailable pods. |
| pdb.minAvailable | int | `1` | Minimum available pods. |

### Persistence Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| persistence.accessMode | string | `"ReadWriteOnce"` | Access mode for volume. |
| persistence.additionalLabels | object | `{}` | Additional labels for persistent volume. |
| persistence.annotations | object | `{}` | Annotations for persistent volume. |
| persistence.enabled | bool | `true` | Enable persistence. |
| persistence.mountPVC | bool | `true` | Whether to mount the created PVC to the deployment. |
| persistence.mountPath | string | `"/appdata"` | Where to mount the volume in the containers. |
| persistence.name | string | `{{ include "application.name" $ }}-data` | Name of the PVC. |
| persistence.storageClass | string | `nil` | Storage class for volume. |
| persistence.storageSize | string | `"1Gi"` | Size of the persistent volume. |

### PrometheusRule Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| prometheusRule.additionalLabels | object | `{}` | Additional labels for PrometheusRule. |
| prometheusRule.enabled | bool | `false` | Deploy a PrometheusRule resource. |
| prometheusRule.groups | list | `[]` | Groups with alerting rules. |

### RBAC Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| rbac.enabled | bool | `true` | Enable RBAC. |
| rbac.roles | list | `[]` | Namespaced Roles. |
| rbac.serviceAccount.additionalLabels | object | `{}` | Additional labels for Service Account. |
| rbac.serviceAccount.annotations | object | `{}` | Annotations for Service Account. |
| rbac.serviceAccount.enabled | bool | `true` | Deploy Service Account. |
| rbac.serviceAccount.name | string | `{{ include "application.name" $ }}` | Service Account Name. |

### Route Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| route.additionalLabels | object | `{}` | Additional labels for Route. |
| route.annotations | object | `{}` | Annotations for Route. |
| route.enabled | bool | `false` | Deploy a Route (OpenShift) resource. |
| route.host | string | `""` | Explicit host. |
| route.path | string | `""` | Path. |
| route.port | object | `{"targetPort":"http"}` | Service port. |
| route.tls.insecureEdgeTerminationPolicy | string | `"Redirect"` | TLS insecure termination policy. |
| route.tls.termination | string | `"edge"` | TLS termination strategy. |
| route.to.weight | int | `100` | Service weight. |
| route.wildcardPolicy | string | `"None"` | Wildcard policy. |

### SealedSecret Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| sealedSecret.additionalLabels | object | `{}` | Additional labels for SealedSecret. |
| sealedSecret.annotations | object | `{}` | Annotations for SealedSecret. |
| sealedSecret.enabled | bool | `false` | Deploy SealedSecret resources. |
| sealedSecret.files | object | `{}` | List of SealedSecret entries. |

### Secret Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| secret.additionalLabels | object | `{}` | Additional labels for Secrets. |
| secret.annotations | object | `{}` | Annotations for Secrets. |
| secret.enabled | bool | `false` | Deploy additional Secrets. |
| secret.files | object | `{}` | Map of Secrets. |

### SecretProviderClass Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| secretProviderClass.enabled | bool | `false` | Deploy a SecretProviderClass resource. |
| secretProviderClass.name | string | `""` | Name of the SecretProviderClass. |
| secretProviderClass.objects | list | `[]` | Objects definitions. |
| secretProviderClass.provider | string | `""` | Name of the provider. |
| secretProviderClass.roleName | string | `""` | Vault Role Name. |
| secretProviderClass.secretObjects | list | `[]` | Objects mapping. |
| secretProviderClass.vaultAddress | string | `""` | Vault Address. |

### Service Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| service.additionalLabels | object | `{}` | Additional labels for service. |
| service.annotations | object | `{}` | Annotations for service. |
| service.enabled | bool | `true` | Enable Service. |
| service.ports | list | `[{"name":"http","port":7575,"protocol":"TCP","targetPort":"http"}]` | Ports for applications service. |
| service.type | string | `"ClusterIP"` | Type of service. |

### ServiceMonitor Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| servicemonitor.additionalLabels | object | `{}` | Additional labels for ServiceMonitor. |
| servicemonitor.annotations | object | `{}` | Annotations for ServiceMonitor. |
| servicemonitor.enabled | bool | `false` | Deploy ServiceMonitor (Prometheus Operator) resource. |
| servicemonitor.endpoints | list | `[{"interval":"30s","path":"/metrics","port":"http"}]` | Endpoints for ServiceMonitor. |

### VPA Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| vpa.additionalLabels | object | `{}` | Additional labels for VPA. |
| vpa.annotations | object | `{}` | Annotations for VPA. |
| vpa.containerPolicies | list | `[]` | Container policies for individual containers. |
| vpa.enabled | bool | `false` | Enable Vertical Pod Autoscaling. |
| vpa.updatePolicy | object | `{"updateMode":"Auto"}` | Update policy. |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
