# mailrise

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.4.0](https://img.shields.io/badge/AppVersion-1.4.0-informational?style=flat-square)

An SMTP gateway for Apprise notifications - convert emails to 60+ notification services

**Homepage:** <https://github.com/YoRyan/mailrise>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| codefuturist | <58808821+codefuturist@users.noreply.github.com> |  |

## Source Code

* <https://github.com/YoRyan/mailrise>
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
| controller.replicas | int | `1` |  |
| controller.strategy.type | string | `"RollingUpdate"` |  |
| controller.terminationGracePeriodSeconds | int | `30` |  |
| controller.type | string | `"deployment"` |  |
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
| image.repository | string | `"yoryan/mailrise"` |  |
| image.tag | string | `"1.4.0"` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0].host | string | `"mailrise.example.com"` |  |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| ingress.tls | list | `[]` |  |
| initContainers | list | `[]` |  |
| livenessProbe.enabled | bool | `true` |  |
| livenessProbe.failureThreshold | int | `3` |  |
| livenessProbe.initialDelaySeconds | int | `10` |  |
| livenessProbe.periodSeconds | int | `10` |  |
| livenessProbe.successThreshold | int | `1` |  |
| livenessProbe.tcpSocket.port | string | `"smtp"` |  |
| livenessProbe.timeoutSeconds | int | `5` |  |
| mailrise.auth.enabled | bool | `false` |  |
| mailrise.auth.existingSecret | string | `""` |  |
| mailrise.auth.users | object | `{}` |  |
| mailrise.config.configs.alerts.urls[0] | string | `"discord://WEBHOOK_ID/WEBHOOK_TOKEN"` |  |
| mailrise.config.configs.alerts.urls[1] | string | `"tgram://BOT_TOKEN/CHAT_ID"` |  |
| mailrise.config.configs.assistant.urls[0] | string | `"hasio://HOST/ACCESS_TOKEN"` |  |
| mailrise.config.listen.host | string | `"0.0.0.0"` |  |
| mailrise.config.listen.port | int | `8025` |  |
| mailrise.config.tls.mode | string | `"off"` |  |
| mailrise.existingConfigMap | string | `""` |  |
| mailrise.existingConfigMapKey | string | `"mailrise.conf"` |  |
| mailrise.tls.certKey | string | `"tls.crt"` |  |
| mailrise.tls.enabled | bool | `false` |  |
| mailrise.tls.existingSecret | string | `""` |  |
| mailrise.tls.keyKey | string | `"tls.key"` |  |
| monitoring.prometheusRule.annotations | object | `{}` |  |
| monitoring.prometheusRule.enabled | bool | `false` |  |
| monitoring.prometheusRule.labels | object | `{}` |  |
| monitoring.prometheusRule.rules | list | `[]` |  |
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
| persistence.annotations | object | `{}` |  |
| persistence.enabled | bool | `false` |  |
| persistence.existingClaim | string | `""` |  |
| persistence.size | string | `"1Gi"` |  |
| persistence.storageClassName | string | `""` |  |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| podSecurityContext.fsGroup | int | `999` |  |
| podSecurityContext.fsGroupChangePolicy | string | `"OnRootMismatch"` |  |
| podSecurityContext.runAsGroup | int | `999` |  |
| podSecurityContext.runAsNonRoot | bool | `true` |  |
| podSecurityContext.runAsUser | int | `999` |  |
| podSecurityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| priorityClassName | string | `""` |  |
| rbac.create | bool | `true` |  |
| readinessProbe.enabled | bool | `true` |  |
| readinessProbe.failureThreshold | int | `3` |  |
| readinessProbe.initialDelaySeconds | int | `5` |  |
| readinessProbe.periodSeconds | int | `5` |  |
| readinessProbe.successThreshold | int | `1` |  |
| readinessProbe.tcpSocket.port | string | `"smtp"` |  |
| readinessProbe.timeoutSeconds | int | `3` |  |
| resources.limits | object | `{}` |  |
| resources.requests.cpu | string | `"10m"` |  |
| resources.requests.memory | string | `"32Mi"` |  |
| runtimeClassName | string | `""` |  |
| securityContext.allowPrivilegeEscalation | bool | `false` |  |
| securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| securityContext.readOnlyRootFilesystem | bool | `true` |  |
| securityContext.runAsGroup | int | `999` |  |
| securityContext.runAsNonRoot | bool | `true` |  |
| securityContext.runAsUser | int | `999` |  |
| service.annotations | object | `{}` |  |
| service.clusterIP | string | `""` |  |
| service.externalTrafficPolicy | string | `""` |  |
| service.labels | object | `{}` |  |
| service.loadBalancerIP | string | `""` |  |
| service.loadBalancerSourceRanges | list | `[]` |  |
| service.nodePort | string | `""` |  |
| service.port | int | `8025` |  |
| service.sessionAffinity | string | `"None"` |  |
| service.sessionAffinityConfig | object | `{}` |  |
| service.targetPort | int | `8025` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.automount | bool | `true` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| startupProbe.enabled | bool | `true` |  |
| startupProbe.failureThreshold | int | `30` |  |
| startupProbe.initialDelaySeconds | int | `0` |  |
| startupProbe.periodSeconds | int | `5` |  |
| startupProbe.successThreshold | int | `1` |  |
| startupProbe.tcpSocket.port | string | `"smtp"` |  |
| startupProbe.timeoutSeconds | int | `3` |  |
| tolerations | list | `[]` |  |
| topologySpreadConstraints | list | `[]` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
