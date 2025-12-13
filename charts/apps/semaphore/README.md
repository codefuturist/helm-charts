# semaphore

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2.10.32](https://img.shields.io/badge/AppVersion-2.10.32-informational?style=flat-square)

Modern UI for Ansible, Terraform, OpenTofu, Bash, and Pulumi - task automation and infrastructure orchestration

**Homepage:** <https://semaphoreui.com>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| codefuturist | <58808821+codefuturist@users.noreply.github.com> |  |

## Source Code

* <https://github.com/semaphoreui/semaphore>
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
| controller.ansible.hostKeyChecking | bool | `false` |  |
| controller.args | list | `[]` |  |
| controller.command | list | `[]` |  |
| controller.env | list | `[]` |  |
| controller.envFrom | list | `[]` |  |
| controller.existingSecret | string | `""` |  |
| controller.lifecycle | object | `{}` |  |
| controller.podManagementPolicy | string | `"OrderedReady"` |  |
| controller.replicas | int | `1` |  |
| controller.strategy.rollingUpdate.maxSurge | int | `1` |  |
| controller.strategy.rollingUpdate.maxUnavailable | int | `0` |  |
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
| image.repository | string | `"semaphoreui/semaphore"` |  |
| image.tag | string | `"v2.10.32"` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0].host | string | `"semaphore.example.com"` |  |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| ingress.tls | list | `[]` |  |
| initContainers.dbMigration.command[0] | string | `"semaphore"` |  |
| initContainers.dbMigration.command[0] | string | `"semaphore"` |  |
| initContainers.dbMigration.command[1] | string | `"migrate"` |  |
| initContainers.dbMigration.command[1] | string | `"migrate"` |  |
| initContainers.dbMigration.command[2] | string | `"--config"` |  |
| initContainers.dbMigration.command[2] | string | `"--config"` |  |
| initContainers.dbMigration.command[3] | string | `"/etc/semaphore/config.json"` |  |
| initContainers.dbMigration.command[3] | string | `"/etc/semaphore/config.json"` |  |
| initContainers.dbMigration.enabled | bool | `false` |  |
| initContainers.dbMigration.enabled | bool | `false` |  |
| initContainers.dbMigration.image.pullPolicy | string | `"IfNotPresent"` |  |
| initContainers.dbMigration.image.pullPolicy | string | `"IfNotPresent"` |  |
| initContainers.dbMigration.image.repository | string | `"semaphoreui/semaphore"` |  |
| initContainers.dbMigration.image.repository | string | `"semaphoreui/semaphore"` |  |
| initContainers.dbMigration.image.tag | string | `""` |  |
| initContainers.dbMigration.image.tag | string | `""` |  |
| initContainers.dbMigration.resources.limits | object | `{}` |  |
| initContainers.dbMigration.resources.limits | object | `{}` |  |
| initContainers.dbMigration.resources.requests.cpu | string | `"10m"` |  |
| initContainers.dbMigration.resources.requests.cpu | string | `"10m"` |  |
| initContainers.dbMigration.resources.requests.memory | string | `"64Mi"` |  |
| initContainers.dbMigration.resources.requests.memory | string | `"64Mi"` |  |
| initContainers.extra | list | `[]` |  |
| livenessProbe.enabled | bool | `true` |  |
| livenessProbe.failureThreshold | int | `6` |  |
| livenessProbe.httpGet.path | string | `"/api/ping"` |  |
| livenessProbe.httpGet.port | string | `"http"` |  |
| livenessProbe.httpGet.scheme | string | `"HTTP"` |  |
| livenessProbe.initialDelaySeconds | int | `30` |  |
| livenessProbe.periodSeconds | int | `10` |  |
| livenessProbe.successThreshold | int | `1` |  |
| livenessProbe.timeoutSeconds | int | `5` |  |
| monitoring.prometheusRule.annotations | object | `{}` |  |
| monitoring.prometheusRule.enabled | bool | `false` |  |
| monitoring.prometheusRule.labels | object | `{}` |  |
| monitoring.prometheusRule.rules[0].alert | string | `"SemaphoreHighMemory"` |  |
| monitoring.prometheusRule.rules[0].annotations.description | string | `"Memory usage is above 85% for 5 minutes. Current: {{ $value | humanizePercentage }}"` |  |
| monitoring.prometheusRule.rules[0].annotations.summary | string | `"Semaphore high memory usage (instance {{ $labels.pod }})"` |  |
| monitoring.prometheusRule.rules[0].expr | string | `"container_memory_working_set_bytes{pod=~\"semaphore-.*\"} /\ncontainer_spec_memory_limit_bytes{pod=~\"semaphore-.*\"} > 0.85\n"` |  |
| monitoring.prometheusRule.rules[0].for | string | `"5m"` |  |
| monitoring.prometheusRule.rules[0].labels.severity | string | `"warning"` |  |
| monitoring.prometheusRule.rules[1].alert | string | `"SemaphoreHighCPU"` |  |
| monitoring.prometheusRule.rules[1].annotations.description | string | `"CPU usage is above 80% for 5 minutes. Current: {{ $value | humanizePercentage }}"` |  |
| monitoring.prometheusRule.rules[1].annotations.summary | string | `"Semaphore high CPU usage (instance {{ $labels.pod }})"` |  |
| monitoring.prometheusRule.rules[1].expr | string | `"rate(container_cpu_usage_seconds_total{pod=~\"semaphore-.*\"}[5m]) > 0.8\n"` |  |
| monitoring.prometheusRule.rules[1].for | string | `"5m"` |  |
| monitoring.prometheusRule.rules[1].labels.severity | string | `"warning"` |  |
| monitoring.prometheusRule.rules[2].alert | string | `"SemaphorePodNotReady"` |  |
| monitoring.prometheusRule.rules[2].annotations.description | string | `"Pod has been in a non-ready state for 5 minutes"` |  |
| monitoring.prometheusRule.rules[2].annotations.summary | string | `"Semaphore pod not ready (instance {{ $labels.pod }})"` |  |
| monitoring.prometheusRule.rules[2].expr | string | `"kube_pod_status_ready{condition=\"true\",pod=~\"semaphore-.*\"} == 0\n"` |  |
| monitoring.prometheusRule.rules[2].for | string | `"5m"` |  |
| monitoring.prometheusRule.rules[2].labels.severity | string | `"critical"` |  |
| monitoring.prometheusRule.rules[3].alert | string | `"SemaphoreHighRestartRate"` |  |
| monitoring.prometheusRule.rules[3].annotations.description | string | `"Pod is restarting frequently. Check logs for errors."` |  |
| monitoring.prometheusRule.rules[3].annotations.summary | string | `"Semaphore frequent restarts (instance {{ $labels.pod }})"` |  |
| monitoring.prometheusRule.rules[3].expr | string | `"rate(kube_pod_container_status_restarts_total{pod=~\"semaphore-.*\"}[15m]) > 0\n"` |  |
| monitoring.prometheusRule.rules[3].for | string | `"5m"` |  |
| monitoring.prometheusRule.rules[3].labels.severity | string | `"warning"` |  |
| monitoring.prometheusRule.rules[4].alert | string | `"SemaphorePVAlmostFull"` |  |
| monitoring.prometheusRule.rules[4].annotations.description | string | `"Less than 15% space remaining. Consider increasing volume size."` |  |
| monitoring.prometheusRule.rules[4].annotations.summary | string | `"Semaphore PV almost full ({{ $labels.persistentvolumeclaim }})"` |  |
| monitoring.prometheusRule.rules[4].expr | string | `"kubelet_volume_stats_available_bytes{persistentvolumeclaim=~\".*semaphore.*\"} /\nkubelet_volume_stats_capacity_bytes{persistentvolumeclaim=~\".*semaphore.*\"} < 0.15\n"` |  |
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
| networkPolicy.egress[0].ports[0].port | int | `53` |  |
| networkPolicy.egress[0].ports[0].protocol | string | `"UDP"` |  |
| networkPolicy.egress[0].to[0].namespaceSelector.matchLabels.name | string | `"kube-system"` |  |
| networkPolicy.egress[1].ports[0].port | int | `443` |  |
| networkPolicy.egress[1].ports[0].protocol | string | `"TCP"` |  |
| networkPolicy.egress[1].to[0].podSelector | object | `{}` |  |
| networkPolicy.egress[2].ports[0].port | int | `22` |  |
| networkPolicy.egress[2].ports[0].protocol | string | `"TCP"` |  |
| networkPolicy.egress[2].to[0].podSelector | object | `{}` |  |
| networkPolicy.enabled | bool | `false` |  |
| networkPolicy.ingress | list | `[]` |  |
| networkPolicy.policyTypes[0] | string | `"Ingress"` |  |
| networkPolicy.policyTypes[1] | string | `"Egress"` |  |
| nodeSelector | object | `{}` |  |
| pdb.enabled | bool | `false` |  |
| pdb.maxUnavailable | string | `""` |  |
| pdb.minAvailable | int | `1` |  |
| persistence.config.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.config.annotations | object | `{}` |  |
| persistence.config.enabled | bool | `false` |  |
| persistence.config.existingClaim | string | `""` |  |
| persistence.config.mountPath | string | `"/etc/semaphore"` |  |
| persistence.config.size | string | `"100Mi"` |  |
| persistence.config.storageClassName | string | `""` |  |
| persistence.data.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.data.annotations | object | `{}` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.existingClaim | string | `""` |  |
| persistence.data.mountPath | string | `"/var/lib/semaphore"` |  |
| persistence.data.size | string | `"5Gi"` |  |
| persistence.data.storageClassName | string | `""` |  |
| persistence.tmp.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.tmp.annotations | object | `{}` |  |
| persistence.tmp.enabled | bool | `true` |  |
| persistence.tmp.existingClaim | string | `""` |  |
| persistence.tmp.mountPath | string | `"/tmp/semaphore"` |  |
| persistence.tmp.size | string | `"10Gi"` |  |
| persistence.tmp.storageClassName | string | `""` |  |
| persistence.volumeClaimTemplates.config.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.volumeClaimTemplates.config.size | string | `"100Mi"` |  |
| persistence.volumeClaimTemplates.config.storageClassName | string | `""` |  |
| persistence.volumeClaimTemplates.data.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.volumeClaimTemplates.data.size | string | `"5Gi"` |  |
| persistence.volumeClaimTemplates.data.storageClassName | string | `""` |  |
| persistence.volumeClaimTemplates.enabled | bool | `false` |  |
| persistence.volumeClaimTemplates.tmp.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.volumeClaimTemplates.tmp.size | string | `"10Gi"` |  |
| persistence.volumeClaimTemplates.tmp.storageClassName | string | `""` |  |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| podSecurityContext.fsGroup | int | `1001` |  |
| podSecurityContext.fsGroupChangePolicy | string | `"OnRootMismatch"` |  |
| podSecurityContext.runAsGroup | int | `1001` |  |
| podSecurityContext.runAsNonRoot | bool | `true` |  |
| podSecurityContext.runAsUser | int | `1001` |  |
| podSecurityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| priorityClassName | string | `""` |  |
| rbac.create | bool | `true` |  |
| readinessProbe.enabled | bool | `true` |  |
| readinessProbe.failureThreshold | int | `3` |  |
| readinessProbe.httpGet.path | string | `"/api/ping"` |  |
| readinessProbe.httpGet.port | string | `"http"` |  |
| readinessProbe.httpGet.scheme | string | `"HTTP"` |  |
| readinessProbe.initialDelaySeconds | int | `10` |  |
| readinessProbe.periodSeconds | int | `10` |  |
| readinessProbe.successThreshold | int | `1` |  |
| readinessProbe.timeoutSeconds | int | `5` |  |
| resources.limits | object | `{}` |  |
| resources.requests.cpu | string | `"10m"` |  |
| resources.requests.memory | string | `"64Mi"` |  |
| runnerDeployment.affinity | object | `{}` |  |
| runnerDeployment.ansible.hostKeyChecking | bool | `false` |  |
| runnerDeployment.config.alreadyRegistered | bool | `false` |  |
| runnerDeployment.config.privateKeyFile | string | `"/var/lib/semaphore/runner.key"` |  |
| runnerDeployment.enabled | bool | `false` |  |
| runnerDeployment.env | list | `[]` |  |
| runnerDeployment.envFrom | list | `[]` |  |
| runnerDeployment.extraContainers | list | `[]` |  |
| runnerDeployment.extraVolumeMounts | list | `[]` |  |
| runnerDeployment.extraVolumes | list | `[]` |  |
| runnerDeployment.image.digest | string | `""` |  |
| runnerDeployment.image.pullPolicy | string | `"IfNotPresent"` |  |
| runnerDeployment.image.repository | string | `"semaphoreui/runner"` |  |
| runnerDeployment.image.tag | string | `"v2.16.43"` |  |
| runnerDeployment.initContainers | list | `[]` |  |
| runnerDeployment.livenessProbe.enabled | bool | `true` |  |
| runnerDeployment.livenessProbe.exec.command[0] | string | `"pgrep"` |  |
| runnerDeployment.livenessProbe.exec.command[1] | string | `"-f"` |  |
| runnerDeployment.livenessProbe.exec.command[2] | string | `"semaphore-runner"` |  |
| runnerDeployment.livenessProbe.failureThreshold | int | `6` |  |
| runnerDeployment.livenessProbe.initialDelaySeconds | int | `30` |  |
| runnerDeployment.livenessProbe.periodSeconds | int | `10` |  |
| runnerDeployment.livenessProbe.successThreshold | int | `1` |  |
| runnerDeployment.livenessProbe.timeoutSeconds | int | `5` |  |
| runnerDeployment.nodeSelector | object | `{}` |  |
| runnerDeployment.persistence.config.accessMode | string | `"ReadWriteOnce"` |  |
| runnerDeployment.persistence.config.enabled | bool | `false` |  |
| runnerDeployment.persistence.config.existingClaim | string | `""` |  |
| runnerDeployment.persistence.config.mountPath | string | `"/etc/semaphore"` |  |
| runnerDeployment.persistence.config.size | string | `"100Mi"` |  |
| runnerDeployment.persistence.config.storageClassName | string | `""` |  |
| runnerDeployment.persistence.data.accessMode | string | `"ReadWriteOnce"` |  |
| runnerDeployment.persistence.data.enabled | bool | `true` |  |
| runnerDeployment.persistence.data.existingClaim | string | `""` |  |
| runnerDeployment.persistence.data.mountPath | string | `"/var/lib/semaphore"` |  |
| runnerDeployment.persistence.data.size | string | `"5Gi"` |  |
| runnerDeployment.persistence.data.storageClassName | string | `""` |  |
| runnerDeployment.persistence.tmp.accessMode | string | `"ReadWriteOnce"` |  |
| runnerDeployment.persistence.tmp.enabled | bool | `true` |  |
| runnerDeployment.persistence.tmp.existingClaim | string | `""` |  |
| runnerDeployment.persistence.tmp.mountPath | string | `"/tmp/semaphore"` |  |
| runnerDeployment.persistence.tmp.size | string | `"10Gi"` |  |
| runnerDeployment.persistence.tmp.storageClassName | string | `""` |  |
| runnerDeployment.podAnnotations | object | `{}` |  |
| runnerDeployment.podLabels | object | `{}` |  |
| runnerDeployment.podSecurityContext.fsGroup | int | `1001` |  |
| runnerDeployment.podSecurityContext.fsGroupChangePolicy | string | `"OnRootMismatch"` |  |
| runnerDeployment.podSecurityContext.runAsGroup | int | `1001` |  |
| runnerDeployment.podSecurityContext.runAsNonRoot | bool | `true` |  |
| runnerDeployment.podSecurityContext.runAsUser | int | `1001` |  |
| runnerDeployment.podSecurityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| runnerDeployment.priorityClassName | string | `""` |  |
| runnerDeployment.privateKeys | list | `[]` |  |
| runnerDeployment.readinessProbe.enabled | bool | `true` |  |
| runnerDeployment.readinessProbe.exec.command[0] | string | `"pgrep"` |  |
| runnerDeployment.readinessProbe.exec.command[1] | string | `"-f"` |  |
| runnerDeployment.readinessProbe.exec.command[2] | string | `"semaphore-runner"` |  |
| runnerDeployment.readinessProbe.failureThreshold | int | `3` |  |
| runnerDeployment.readinessProbe.initialDelaySeconds | int | `10` |  |
| runnerDeployment.readinessProbe.periodSeconds | int | `10` |  |
| runnerDeployment.readinessProbe.successThreshold | int | `1` |  |
| runnerDeployment.readinessProbe.timeoutSeconds | int | `5` |  |
| runnerDeployment.replicas | int | `1` |  |
| runnerDeployment.resources.limits | object | `{}` |  |
| runnerDeployment.resources.requests.cpu | string | `"10m"` |  |
| runnerDeployment.resources.requests.memory | string | `"64Mi"` |  |
| runnerDeployment.runtimeClassName | string | `""` |  |
| runnerDeployment.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| runnerDeployment.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| runnerDeployment.securityContext.readOnlyRootFilesystem | bool | `false` |  |
| runnerDeployment.securityContext.runAsGroup | int | `1001` |  |
| runnerDeployment.securityContext.runAsNonRoot | bool | `true` |  |
| runnerDeployment.securityContext.runAsUser | int | `1001` |  |
| runnerDeployment.server.existingSecret | string | `""` |  |
| runnerDeployment.server.existingSecretKey | string | `"runner-token"` |  |
| runnerDeployment.server.registrationToken | string | `""` |  |
| runnerDeployment.server.webRoot | string | `"http://semaphore:3000"` |  |
| runnerDeployment.serviceAccount.annotations | object | `{}` |  |
| runnerDeployment.serviceAccount.automount | bool | `true` |  |
| runnerDeployment.serviceAccount.create | bool | `true` |  |
| runnerDeployment.serviceAccount.name | string | `""` |  |
| runnerDeployment.startupProbe.enabled | bool | `true` |  |
| runnerDeployment.startupProbe.exec.command[0] | string | `"pgrep"` |  |
| runnerDeployment.startupProbe.exec.command[1] | string | `"-f"` |  |
| runnerDeployment.startupProbe.exec.command[2] | string | `"semaphore-runner"` |  |
| runnerDeployment.startupProbe.failureThreshold | int | `30` |  |
| runnerDeployment.startupProbe.initialDelaySeconds | int | `0` |  |
| runnerDeployment.startupProbe.periodSeconds | int | `5` |  |
| runnerDeployment.startupProbe.successThreshold | int | `1` |  |
| runnerDeployment.startupProbe.timeoutSeconds | int | `3` |  |
| runnerDeployment.strategy.rollingUpdate.maxSurge | int | `1` |  |
| runnerDeployment.strategy.rollingUpdate.maxUnavailable | int | `0` |  |
| runnerDeployment.strategy.type | string | `"RollingUpdate"` |  |
| runnerDeployment.terminationGracePeriodSeconds | int | `30` |  |
| runnerDeployment.tolerations | list | `[]` |  |
| runtimeClassName | string | `""` |  |
| securityContext.allowPrivilegeEscalation | bool | `false` |  |
| securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsGroup | int | `1001` |  |
| securityContext.runAsNonRoot | bool | `true` |  |
| securityContext.runAsUser | int | `1001` |  |
| semaphore.admin.email | string | `"admin@localhost"` |  |
| semaphore.admin.name | string | `"Admin"` |  |
| semaphore.admin.password | string | `"changeme"` |  |
| semaphore.admin.username | string | `"admin"` |  |
| semaphore.ansible.hostKeyChecking | bool | `false` |  |
| semaphore.apps | object | `{}` |  |
| semaphore.database.dialect | string | `"postgres"` |  |
| semaphore.database.host | string | `"postgresql"` |  |
| semaphore.database.name | string | `"semaphore"` |  |
| semaphore.database.options | object | `{}` |  |
| semaphore.database.password | string | `"changeme"` |  |
| semaphore.database.port | string | `"5432"` |  |
| semaphore.database.sslMode | string | `"require"` |  |
| semaphore.database.user | string | `"semaphore"` |  |
| semaphore.email.enabled | bool | `false` |  |
| semaphore.email.host | string | `""` |  |
| semaphore.email.password | string | `""` |  |
| semaphore.email.port | string | `""` |  |
| semaphore.email.secure | bool | `false` |  |
| semaphore.email.sender | string | `""` |  |
| semaphore.email.tls | bool | `false` |  |
| semaphore.email.tlsMinVersion | string | `""` |  |
| semaphore.email.username | string | `""` |  |
| semaphore.envVars | object | `{}` |  |
| semaphore.existingSecret | string | `""` |  |
| semaphore.forwardedEnvVars | list | `[]` |  |
| semaphore.gitClient | string | `"cmd_git"` |  |
| semaphore.interface | string | `""` |  |
| semaphore.ldap.bindDn | string | `""` |  |
| semaphore.ldap.bindPassword | string | `""` |  |
| semaphore.ldap.enabled | bool | `false` |  |
| semaphore.ldap.mappingCn | string | `""` |  |
| semaphore.ldap.mappingDn | string | `""` |  |
| semaphore.ldap.mappingMail | string | `""` |  |
| semaphore.ldap.mappingUid | string | `""` |  |
| semaphore.ldap.needTls | bool | `false` |  |
| semaphore.ldap.searchDn | string | `""` |  |
| semaphore.ldap.searchFilter | string | `""` |  |
| semaphore.ldap.server | string | `""` |  |
| semaphore.maxParallelTasks | string | `""` |  |
| semaphore.maxTaskDurationSec | string | `""` |  |
| semaphore.maxTasksPerTemplate | string | `""` |  |
| semaphore.messengers.dingtalk.enabled | bool | `false` |  |
| semaphore.messengers.dingtalk.url | string | `""` |  |
| semaphore.messengers.gotify.enabled | bool | `false` |  |
| semaphore.messengers.gotify.url | string | `""` |  |
| semaphore.messengers.microsoftTeams.enabled | bool | `false` |  |
| semaphore.messengers.microsoftTeams.url | string | `""` |  |
| semaphore.messengers.rocketchat.enabled | bool | `false` |  |
| semaphore.messengers.rocketchat.url | string | `""` |  |
| semaphore.messengers.slack.enabled | bool | `false` |  |
| semaphore.messengers.slack.url | string | `""` |  |
| semaphore.messengers.telegram.chat | string | `""` |  |
| semaphore.messengers.telegram.enabled | bool | `false` |  |
| semaphore.messengers.telegram.token | string | `""` |  |
| semaphore.nonAdminCanCreateProject | bool | `false` |  |
| semaphore.passwordLoginDisabled | bool | `false` |  |
| semaphore.port | int | `3000` |  |
| semaphore.process.chroot | string | `""` |  |
| semaphore.process.gid | string | `""` |  |
| semaphore.process.uid | string | `""` |  |
| semaphore.process.user | string | `""` |  |
| semaphore.runner.enabled | bool | `false` |  |
| semaphore.runner.registrationToken | string | `""` |  |
| semaphore.scheduleTimezone | string | `""` |  |
| semaphore.security.accessKeyEncryption | string | `"changeme-access-key-encryption"` |  |
| semaphore.security.cookieEncryption | string | `"changeme-cookie-encryption"` |  |
| semaphore.security.cookieHash | string | `"changeme-cookie-hash-32-chars"` |  |
| semaphore.tls.certFile | string | `""` |  |
| semaphore.tls.enabled | bool | `false` |  |
| semaphore.tls.httpRedirectPort | string | `""` |  |
| semaphore.tls.keyFile | string | `""` |  |
| semaphore.tmpPath | string | `""` |  |
| semaphore.totp.allowRecovery | bool | `false` |  |
| semaphore.totp.enabled | bool | `false` |  |
| semaphore.webRoot | string | `""` |  |
| service.annotations | object | `{}` |  |
| service.clusterIP | string | `""` |  |
| service.externalTrafficPolicy | string | `""` |  |
| service.labels | object | `{}` |  |
| service.loadBalancerIP | string | `""` |  |
| service.loadBalancerSourceRanges | list | `[]` |  |
| service.nodePort | string | `""` |  |
| service.port | int | `3000` |  |
| service.sessionAffinity | string | `"None"` |  |
| service.sessionAffinityConfig | object | `{}` |  |
| service.targetPort | int | `3000` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.automount | bool | `true` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| startupProbe.enabled | bool | `true` |  |
| startupProbe.failureThreshold | int | `30` |  |
| startupProbe.httpGet.path | string | `"/api/ping"` |  |
| startupProbe.httpGet.port | string | `"http"` |  |
| startupProbe.httpGet.scheme | string | `"HTTP"` |  |
| startupProbe.initialDelaySeconds | int | `0` |  |
| startupProbe.periodSeconds | int | `5` |  |
| startupProbe.successThreshold | int | `1` |  |
| startupProbe.timeoutSeconds | int | `3` |  |
| tolerations | list | `[]` |  |
| topologySpreadConstraints | list | `[]` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
