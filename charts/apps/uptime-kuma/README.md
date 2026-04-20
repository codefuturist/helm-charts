# uptime-kuma

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2.0.0](https://img.shields.io/badge/AppVersion-2.0.0-informational?style=flat-square)

A self-hosted monitoring tool - monitor uptime for HTTP(s) / TCP / HTTP(s) Keyword / Ping / DNS Record / Push / Steam Game Server

**Homepage:** <https://github.com/louislam/uptime-kuma>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| codefuturist | <58808821+codefuturist@users.noreply.github.com> |  |

## Source Code

* <https://github.com/louislam/uptime-kuma>
* <https://github.com/codefuturist/helm-charts>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://../../libs/common | common | 2.x.x |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalAnnotations | object | `{}` |  |
| additionalLabels | object | `{}` |  |
| affinity | object | `{}` |  |
| controller.args | list | `[]` |  |
| controller.command | list | `[]` |  |
| controller.lifecycle | object | `{}` |  |
| controller.podManagementPolicy | string | `"OrderedReady"` |  |
| controller.replicas | int | `1` |  |
| controller.strategy.type | string | `"RollingUpdate"` |  |
| controller.terminationGracePeriodSeconds | int | `30` |  |
| controller.type | string | `"deployment"` |  |
| controller.updateStrategy.type | string | `"RollingUpdate"` |  |
| controller.workingDir | string | `""` |  |
| diagnosticMode.args[0] | string | `"-c"` |  |
| diagnosticMode.args[1] | string | `"sleep infinity"` |  |
| diagnosticMode.command[0] | string | `"/bin/sh"` |  |
| diagnosticMode.enabled | bool | `false` |  |
| dnsConfig | object | `{}` |  |
| dnsPolicy | string | `"ClusterFirst"` |  |
| extraContainers | list | `[]` |  |
| extraEnv | list | `[]` |  |
| extraEnvFrom | list | `[]` |  |
| extraVolumeMounts | list | `[]` |  |
| extraVolumes | list | `[]` |  |
| fullnameOverride | string | `""` |  |
| hostNetwork | bool | `false` |  |
| hpa.enabled | bool | `false` |  |
| hpa.maxReplicas | int | `10` |  |
| hpa.minReplicas | int | `1` |  |
| hpa.targetCPUUtilizationPercentage | int | `80` |  |
| hpa.targetMemoryUtilizationPercentage | int | `80` |  |
| image.digest | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"louislam/uptime-kuma"` |  |
| image.tag | string | `"2.0.2"` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0].host | string | `"uptime.example.com"` |  |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| ingress.tls | list | `[]` |  |
| initContainers | list | `[]` |  |
| livenessProbe.enabled | bool | `true` |  |
| livenessProbe.failureThreshold | int | `3` |  |
| livenessProbe.httpGet.path | string | `"/"` |  |
| livenessProbe.httpGet.port | string | `"http"` |  |
| livenessProbe.httpGet.scheme | string | `"HTTP"` |  |
| livenessProbe.initialDelaySeconds | int | `30` |  |
| livenessProbe.periodSeconds | int | `10` |  |
| livenessProbe.successThreshold | int | `1` |  |
| livenessProbe.timeoutSeconds | int | `5` |  |
| monitoring.prometheusRule.annotations | object | `{}` |  |
| monitoring.prometheusRule.enabled | bool | `false` |  |
| monitoring.prometheusRule.labels | object | `{}` |  |
| monitoring.prometheusRule.rules[0].alert | string | `"UptimeKumaHighMemory"` |  |
| monitoring.prometheusRule.rules[0].annotations.description | string | `"Memory usage is above 85% for 5 minutes. Current: {{ $value | humanizePercentage }}"` |  |
| monitoring.prometheusRule.rules[0].annotations.summary | string | `"Uptime Kuma high memory usage (instance {{ $labels.pod }})"` |  |
| monitoring.prometheusRule.rules[0].expr | string | `"container_memory_working_set_bytes{pod=~\"uptime-kuma-.*\"} /\ncontainer_spec_memory_limit_bytes{pod=~\"uptime-kuma-.*\"} > 0.85\n"` |  |
| monitoring.prometheusRule.rules[0].for | string | `"5m"` |  |
| monitoring.prometheusRule.rules[0].labels.severity | string | `"warning"` |  |
| monitoring.prometheusRule.rules[1].alert | string | `"UptimeKumaHighCPU"` |  |
| monitoring.prometheusRule.rules[1].annotations.description | string | `"CPU usage is above 80% for 5 minutes. Current: {{ $value | humanizePercentage }}"` |  |
| monitoring.prometheusRule.rules[1].annotations.summary | string | `"Uptime Kuma high CPU usage (instance {{ $labels.pod }})"` |  |
| monitoring.prometheusRule.rules[1].expr | string | `"rate(container_cpu_usage_seconds_total{pod=~\"uptime-kuma-.*\"}[5m]) > 0.8\n"` |  |
| monitoring.prometheusRule.rules[1].for | string | `"5m"` |  |
| monitoring.prometheusRule.rules[1].labels.severity | string | `"warning"` |  |
| monitoring.prometheusRule.rules[2].alert | string | `"UptimeKumaPodNotReady"` |  |
| monitoring.prometheusRule.rules[2].annotations.description | string | `"Pod has been in a non-ready state for 5 minutes"` |  |
| monitoring.prometheusRule.rules[2].annotations.summary | string | `"Uptime Kuma pod not ready (instance {{ $labels.pod }})"` |  |
| monitoring.prometheusRule.rules[2].expr | string | `"kube_pod_status_ready{condition=\"true\",pod=~\"uptime-kuma-.*\"} == 0\n"` |  |
| monitoring.prometheusRule.rules[2].for | string | `"5m"` |  |
| monitoring.prometheusRule.rules[2].labels.severity | string | `"critical"` |  |
| monitoring.prometheusRule.rules[3].alert | string | `"UptimeKumaHighRestartRate"` |  |
| monitoring.prometheusRule.rules[3].annotations.description | string | `"Pod is restarting frequently. Check logs for errors."` |  |
| monitoring.prometheusRule.rules[3].annotations.summary | string | `"Uptime Kuma frequent restarts (instance {{ $labels.pod }})"` |  |
| monitoring.prometheusRule.rules[3].expr | string | `"rate(kube_pod_container_status_restarts_total{pod=~\"uptime-kuma-.*\"}[15m]) > 0\n"` |  |
| monitoring.prometheusRule.rules[3].for | string | `"5m"` |  |
| monitoring.prometheusRule.rules[3].labels.severity | string | `"warning"` |  |
| monitoring.prometheusRule.rules[4].alert | string | `"UptimeKumaPVAlmostFull"` |  |
| monitoring.prometheusRule.rules[4].annotations.description | string | `"Less than 15% space remaining. Consider increasing volume size."` |  |
| monitoring.prometheusRule.rules[4].annotations.summary | string | `"Uptime Kuma PV almost full ({{ $labels.persistentvolumeclaim }})"` |  |
| monitoring.prometheusRule.rules[4].expr | string | `"kubelet_volume_stats_available_bytes{persistentvolumeclaim=~\".*uptime-kuma.*\"} /\nkubelet_volume_stats_capacity_bytes{persistentvolumeclaim=~\".*uptime-kuma.*\"} < 0.15\n"` |  |
| monitoring.prometheusRule.rules[4].for | string | `"5m"` |  |
| monitoring.prometheusRule.rules[4].labels.severity | string | `"warning"` |  |
| monitoring.serviceMonitor.annotations | object | `{}` |  |
| monitoring.serviceMonitor.enabled | bool | `false` |  |
| monitoring.serviceMonitor.honorLabels | bool | `false` |  |
| monitoring.serviceMonitor.interval | string | `"60s"` |  |
| monitoring.serviceMonitor.labels | object | `{}` |  |
| monitoring.serviceMonitor.scrapeTimeout | string | `"30s"` |  |
| nameOverride | string | `""` |  |
| namespaceOverride | string | `""` |  |
| networkPolicy.egress[0] | object | `{}` |  |
| networkPolicy.enabled | bool | `false` |  |
| networkPolicy.ingress | list | `[]` |  |
| networkPolicy.policyTypes[0] | string | `"Ingress"` |  |
| networkPolicy.policyTypes[1] | string | `"Egress"` |  |
| nodeSelector | object | `{}` |  |
| pdb.enabled | bool | `false` |  |
| pdb.maxUnavailable | string | `""` |  |
| pdb.minAvailable | int | `1` |  |
| persistence.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.annotations."backup.velero.io/backup-volumes" | string | `"data"` |  |
| persistence.annotations."k10.kasten.io/appname" | string | `"uptime-kuma"` |  |
| persistence.annotations."k10.kasten.io/forcegenericbackup" | string | `"true"` |  |
| persistence.enabled | bool | `true` |  |
| persistence.existingClaim | string | `""` |  |
| persistence.size | string | `"4Gi"` |  |
| persistence.storageClassName | string | `""` |  |
| persistence.volumeClaimTemplate.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.volumeClaimTemplate.enabled | bool | `false` |  |
| persistence.volumeClaimTemplate.size | string | `"4Gi"` |  |
| persistence.volumeClaimTemplate.storageClassName | string | `""` |  |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| podSecurityContext.fsGroup | int | `1000` |  |
| podSecurityContext.fsGroupChangePolicy | string | `"OnRootMismatch"` |  |
| podSecurityContext.runAsGroup | int | `1000` |  |
| podSecurityContext.runAsNonRoot | bool | `true` |  |
| podSecurityContext.runAsUser | int | `1000` |  |
| podSecurityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| priorityClassName | string | `""` |  |
| rbac.create | bool | `true` |  |
| readinessProbe.enabled | bool | `true` |  |
| readinessProbe.failureThreshold | int | `3` |  |
| readinessProbe.httpGet.path | string | `"/"` |  |
| readinessProbe.httpGet.port | string | `"http"` |  |
| readinessProbe.httpGet.scheme | string | `"HTTP"` |  |
| readinessProbe.initialDelaySeconds | int | `10` |  |
| readinessProbe.periodSeconds | int | `5` |  |
| readinessProbe.successThreshold | int | `1` |  |
| readinessProbe.timeoutSeconds | int | `3` |  |
| resources.limits | object | `{}` |  |
| resources.requests.cpu | string | `"10m"` |  |
| resources.requests.memory | string | `"64Mi"` |  |
| runtimeClassName | string | `""` |  |
| securityContext.allowPrivilegeEscalation | bool | `false` |  |
| securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsGroup | int | `1000` |  |
| securityContext.runAsNonRoot | bool | `true` |  |
| securityContext.runAsUser | int | `1000` |  |
| service.annotations | object | `{}` |  |
| service.clusterIP | string | `""` |  |
| service.externalTrafficPolicy | string | `""` |  |
| service.labels | object | `{}` |  |
| service.loadBalancerIP | string | `""` |  |
| service.loadBalancerSourceRanges | list | `[]` |  |
| service.nodePort | string | `""` |  |
| service.port | int | `3001` |  |
| service.sessionAffinity | string | `"None"` |  |
| service.sessionAffinityConfig | object | `{}` |  |
| service.targetPort | int | `3001` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.automount | bool | `true` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| startupProbe.enabled | bool | `true` |  |
| startupProbe.failureThreshold | int | `60` |  |
| startupProbe.httpGet.path | string | `"/"` |  |
| startupProbe.httpGet.port | string | `"http"` |  |
| startupProbe.httpGet.scheme | string | `"HTTP"` |  |
| startupProbe.initialDelaySeconds | int | `0` |  |
| startupProbe.periodSeconds | int | `5` |  |
| startupProbe.successThreshold | int | `1` |  |
| startupProbe.timeoutSeconds | int | `3` |  |
| tolerations | list | `[]` |  |
| topologySpreadConstraints | list | `[]` |  |
| uptimeKuma.basePath | string | `""` |  |
| uptimeKuma.dockerSocket.enabled | bool | `false` |  |
| uptimeKuma.dockerSocket.hostPath | string | `"/var/run/docker.sock"` |  |
| uptimeKuma.env | list | `[]` |  |
| uptimeKuma.envFrom | list | `[]` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
