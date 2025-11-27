# metube

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: latest](https://img.shields.io/badge/AppVersion-latest-informational?style=flat-square)

A production-ready Helm chart for MeTube - YouTube downloader with web interface powered by yt-dlp

**Homepage:** <https://github.com/alexta69/metube>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| codefuturist | <58808821+codefuturist@users.noreply.github.com> |  |

## Source Code

* <https://github.com/alexta69/metube>
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
| controller.replicas | int | `1` | Number of MeTube replicas Note: Multiple replicas share the same storage, ensure your storage supports ReadWriteMany if scaling |
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
| hpa | object | `{"customMetrics":[],"enabled":false,"maxReplicas":3,"minReplicas":1,"targetCPUUtilizationPercentage":80,"targetMemoryUtilizationPercentage":80}` | Horizontal Pod Autoscaler configuration Note: HPA may not be ideal for MeTube as downloads benefit from consistent resources |
| hpa.customMetrics | list | `[]` | Custom metrics for autoscaling |
| hpa.enabled | bool | `false` | Enable HorizontalPodAutoscaler |
| hpa.maxReplicas | int | `3` | Maximum number of replicas |
| hpa.minReplicas | int | `1` | Minimum number of replicas |
| hpa.targetCPUUtilizationPercentage | int | `80` | Target CPU utilization percentage |
| hpa.targetMemoryUtilizationPercentage | int | `80` | Target memory utilization percentage |
| image.digest | string | `""` | Image digest (overrides tag if set) |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.repository | string | `"ghcr.io/alexta69/metube"` | MeTube Docker image repository |
| image.tag | string | Chart appVersion | MeTube Docker image tag |
| imagePullSecrets | list | `[]` | Image pull secrets for private registries |
| ingress.annotations | object | `{}` | Ingress annotations Example for nginx ingress: annotations:   cert-manager.io/cluster-issuer: "letsencrypt-prod"   nginx.ingress.kubernetes.io/backend-protocol: "HTTP"   nginx.ingress.kubernetes.io/proxy-body-size: "0" |
| ingress.className | string | `""` | Ingress class name |
| ingress.enabled | bool | `false` | Enable ingress |
| ingress.hosts | list | `[]` | Ingress hosts configuration Example: hosts:   - host: metube.example.com     paths:       - path: /         pathType: Prefix |
| ingress.tls | list | `[]` | Ingress TLS configuration Example: tls:   - secretName: metube-tls     hosts:       - metube.example.com |
| initContainers | list | `[]` | Init containers to run before the main container |
| livenessProbe | object | `{"enabled":true,"failureThreshold":6,"httpGet":{"path":"/","port":"http"},"initialDelaySeconds":30,"periodSeconds":10,"successThreshold":1,"timeoutSeconds":5}` | Liveness probe configuration |
| metube.certFile | string | `""` | Path to SSL certificate file (mounted via secret) |
| metube.cookies | object | `{"cookieFile":"","enabled":false,"existingSecret":""}` | Cookie file support for authenticated downloads |
| metube.cookies.cookieFile | string | `""` | Cookie file content (cookies.txt format) Format: Netscape cookie file |
| metube.cookies.enabled | bool | `false` | Enable cookie file support |
| metube.cookies.existingSecret | string | `""` | Name of existing secret containing cookies.txt Secret must contain key: cookies.txt |
| metube.createCustomDirs | bool | `true` | Allow creating new custom directories on the fly |
| metube.customDirs | bool | `true` | Enable custom directories for organizing downloads |
| metube.customDirsExcludeRegex | string | `"(^|/)[.@].*$"` | Regular expression to exclude directories from dropdown Default excludes hidden directories and those starting with @ |
| metube.defaultOptionPlaylistItemLimit | int | `0` | Maximum playlist items to download (0 = no limit) |
| metube.defaultOptionPlaylistStrictMode | bool | `false` | Enable strict playlist mode by default In strict mode, playlists download only if URL strictly points to playlist |
| metube.defaultTheme | string | `"auto"` | Default UI theme (light, dark, auto) |
| metube.deleteFileOnTrashcan | bool | `false` | Delete files from server when trashed in UI |
| metube.downloadDirsIndexable | bool | `false` | Make download directories indexable on web server |
| metube.downloadMode | string | `"limited"` | Download behavior mode (sequential, concurrent, limited) sequential: One download at a time concurrent: Unlimited simultaneous downloads limited: Controlled concurrency (see maxConcurrentDownloads) |
| metube.enableAccesslog | bool | `false` | Enable access log |
| metube.existingRobotsTxtConfigMap | string | `""` | Name of existing ConfigMap containing robots.txt |
| metube.existingTlsSecret | string | `""` | Name of existing secret containing SSL certificate and key Secret must contain keys: tls.crt and tls.key |
| metube.existingYtdlOptionsConfigMap | string | `""` | Name of existing ConfigMap containing ytdl_options.json |
| metube.gid | int | `1000` | Group ID to run MeTube as |
| metube.https | bool | `false` | Enable HTTPS mode (requires certFile and keyFile) |
| metube.keyFile | string | `""` | Path to SSL key file (mounted via secret) |
| metube.loglevel | string | `"INFO"` | Log level (DEBUG, INFO, WARNING, ERROR, CRITICAL, NONE) |
| metube.maxConcurrentDownloads | int | `3` | Maximum concurrent downloads (only used with downloadMode: limited) |
| metube.outputTemplate | string | `"%(title)s.%(ext)s"` | Output filename template for yt-dlp See: https://github.com/yt-dlp/yt-dlp#output-template |
| metube.outputTemplateChapter | string | `"%(title)s - %(section_number)s %(section_title)s.%(ext)s"` | Output filename template for chapters |
| metube.outputTemplatePlaylist | string | `"%(playlist_title)s/%(title)s.%(ext)s"` | Output filename template for playlists (empty uses outputTemplate) |
| metube.publicHostAudioUrl | string | `""` | Base URL for audio download links |
| metube.publicHostUrl | string | `""` | Base URL for download links in the UI Leave empty to serve files through MeTube itself |
| metube.robotsTxt | string | `""` | Path to robots.txt file (mounted via ConfigMap) |
| metube.uid | int | `1000` | User ID to run MeTube as |
| metube.umask | string | `"022"` | Umask for created files and directories |
| metube.urlPrefix | string | `"/"` | URL prefix for reverse proxy subdirectory hosting Example: /metube for hosting at https://example.com/metube |
| metube.ytdlOptions | string | `""` | Additional yt-dlp options in JSON format See: https://github.com/yt-dlp/yt-dlp#usage-and-options Example: '{"format": "bestvideo+bestaudio", "writesubtitles": true}' |
| metube.ytdlOptionsFile | string | `""` | Path to JSON file with yt-dlp options (mounted via ConfigMap) Takes precedence over ytdlOptions if both are set |
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
| networkPolicy.egress | list | `[{"ports":[{"port":443,"protocol":"TCP"},{"port":80,"protocol":"TCP"}],"to":[{"namespaceSelector":{}}]},{"ports":[{"port":53,"protocol":"UDP"}],"to":[{"namespaceSelector":{}}]}]` | Egress rules MeTube needs internet access to download videos |
| networkPolicy.enabled | bool | `false` | Enable network policy |
| networkPolicy.ingress | list | `[]` | Ingress rules Example to allow traffic from ingress controller: ingress:   - from:     - namespaceSelector:         matchLabels:           name: ingress-nginx     ports:     - protocol: TCP       port: 8081 |
| networkPolicy.policyTypes | list | `["Ingress","Egress"]` | Policy types |
| nodeSelector | object | `{}` | Node selector for pod assignment |
| pdb.enabled | bool | `false` | Enable PodDisruptionBudget |
| pdb.maxUnavailable | string | `""` | Maximum number of pods that can be unavailable |
| pdb.minAvailable | int | `1` | Minimum number of pods that must be available |
| persistence.accessMode | string | `"ReadWriteOnce"` | Access mode for the persistent volume Use ReadWriteMany if running multiple replicas |
| persistence.additionalVolumes | list | `[]` | Additional volumes for specific use cases |
| persistence.annotations | object | `{}` | Annotations for the PVC |
| persistence.enabled | bool | `true` | Enable persistent storage for downloads |
| persistence.existingClaim | string | `""` | Name of an existing PVC to use |
| persistence.size | string | `"10Gi"` | Size of the persistent volume for downloads Recommended: 50Gi-100Gi for typical usage |
| persistence.storageClassName | string | Default storage class | Storage class name |
| podAnnotations | object | `{}` | Pod annotations |
| podLabels | object | `{}` | Pod labels |
| podSecurityContext | object | `{"fsGroup":1000,"runAsGroup":1000,"runAsNonRoot":true,"runAsUser":1000}` | Pod security context |
| priorityClassName | string | `""` | Priority class name for the pod |
| rbac.create | bool | `true` | Create RBAC resources |
| rbac.rules | list | `[]` | Additional RBAC rules |
| readinessProbe | object | `{"enabled":true,"failureThreshold":3,"httpGet":{"path":"/","port":"http"},"initialDelaySeconds":15,"periodSeconds":10,"successThreshold":1,"timeoutSeconds":3}` | Readiness probe configuration |
| resources | object | `{"limits":{},"requests":{"cpu":"10m","memory":"64Mi"}}` | Resource limits and requests Downloads can be CPU intensive during transcoding Minimal requests to allow scheduling, no limits to allow bursting |
| runtimeClassName | string | `""` | Runtime class name |
| securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"readOnlyRootFilesystem":false}` | Container security context |
| service.annotations | object | `{}` | Service annotations |
| service.clusterIP | string | `""` | Cluster IP (set to None for headless service) |
| service.externalTrafficPolicy | string | `""` | External traffic policy (only used if type is LoadBalancer or NodePort) |
| service.labels | object | `{}` | Service labels |
| service.loadBalancerIP | string | `""` | Load balancer IP (only used if type is LoadBalancer) |
| service.loadBalancerSourceRanges | list | `[]` | Load balancer source ranges (only used if type is LoadBalancer) |
| service.nodePort | string | `""` | Node port (only used if type is NodePort) |
| service.port | int | `8081` | Service port |
| service.sessionAffinity | string | `"None"` | Session affinity |
| service.sessionAffinityConfig | object | `{}` | Session affinity config |
| service.targetPort | int | `8081` | Service target port (container port) |
| service.type | string | `"ClusterIP"` | Service type |
| serviceAccount.annotations | object | `{}` | Service account annotations |
| serviceAccount.create | bool | `true` | Create a service account |
| serviceAccount.name | string | `""` | Service account name (generated if not set and create is true) |
| startupProbe | object | `{"enabled":true,"failureThreshold":30,"httpGet":{"path":"/","port":"http"},"initialDelaySeconds":10,"periodSeconds":10,"successThreshold":1,"timeoutSeconds":3}` | Startup probe configuration |
| storage.audioDownloadDir | string | `""` | Audio-only download directory (empty = same as downloadDir) |
| storage.downloadDir | string | `"/downloads"` | Main download directory path inside container |
| storage.stateDir | string | /downloads/.metube | State directory for queue persistence |
| storage.tempDir | string | `""` | Temporary directory for intermediate files Consider using tmpfs for better performance |
| tolerations | list | `[]` | Tolerations for pod assignment |
| topologySpreadConstraints | list | `[]` | Topology spread constraints for pod distribution |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
