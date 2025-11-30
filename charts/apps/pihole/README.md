# pihole

![Version: 0.2.0](https://img.shields.io/badge/Version-0.2.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2024.07.0](https://img.shields.io/badge/AppVersion-2024.07.0-informational?style=flat-square)

A Helm chart for Pi-hole DNS ad blocker with Kubernetes best practices

**Homepage:** <https://pi-hole.net/>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Your Name | <your.email@example.com> |  |

## Source Code

* <https://github.com/pi-hole/pi-hole>
* <https://docs.pi-hole.net/docker/configuration/>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| namespaceOverride | string | `""` |  |
| componentOverride | string | `""` |  |
| partOfOverride | string | `""` |  |
| applicationName | string | `""` |  |
| additionalLabels | object | `{}` |  |
| serviceAccount.enabled | bool | `true` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.name | string | `""` |  |
| serviceAccount.imagePullSecrets | list | `[]` |  |
| networkPolicy.enabled | bool | `false` |  |
| networkPolicy.ingress[0].from[0].namespaceSelector.matchLabels.name | string | `"ingress-nginx"` |  |
| networkPolicy.ingress[0].ports[0].protocol | string | `"TCP"` |  |
| networkPolicy.ingress[0].ports[0].port | int | `80` |  |
| networkPolicy.ingress[0].ports[1].protocol | string | `"TCP"` |  |
| networkPolicy.ingress[0].ports[1].port | int | `443` |  |
| networkPolicy.ingress[1].from[0].podSelector | object | `{}` |  |
| networkPolicy.ingress[1].ports[0].protocol | string | `"UDP"` |  |
| networkPolicy.ingress[1].ports[0].port | int | `53` |  |
| networkPolicy.ingress[1].ports[1].protocol | string | `"TCP"` |  |
| networkPolicy.ingress[1].ports[1].port | int | `53` |  |
| networkPolicy.egress[0].to[0].namespaceSelector | object | `{}` |  |
| networkPolicy.egress[0].ports[0].protocol | string | `"UDP"` |  |
| networkPolicy.egress[0].ports[0].port | int | `53` |  |
| networkPolicy.egress[0].ports[1].protocol | string | `"TCP"` |  |
| networkPolicy.egress[0].ports[1].port | int | `53` |  |
| networkPolicy.egress[1].to[0].podSelector.matchLabels.k8s-app | string | `"kube-dns"` |  |
| networkPolicy.egress[1].ports[0].protocol | string | `"UDP"` |  |
| networkPolicy.egress[1].ports[0].port | int | `53` |  |
| podDisruptionBudget.enabled | bool | `false` |  |
| podDisruptionBudget.maxUnavailable | int | `1` |  |
| serviceMonitor.enabled | bool | `false` |  |
| serviceMonitor.additionalLabels | object | `{}` |  |
| serviceMonitor.interval | string | `"30s"` |  |
| serviceMonitor.scrapeTimeout | string | `"10s"` |  |
| serviceMonitor.path | string | `"/admin/api.php?summaryRaw"` |  |
| serviceMonitor.portName | string | `"port-80-tcp"` |  |
| serviceMonitor.scheme | string | `"http"` |  |
| serviceMonitor.tlsConfig | object | `{}` |  |
| serviceMonitor.relabelings | list | `[]` |  |
| serviceMonitor.metricRelabelings | list | `[]` |  |
| deployment.enabled | bool | `true` |  |
| deployment.additionalLabels | object | `{}` |  |
| deployment.podLabels | object | `{}` |  |
| deployment.annotations | object | `{}` |  |
| deployment.additionalPodAnnotations | object | `{}` |  |
| deployment.reloadOnChange | bool | `true` |  |
| deployment.replicas | int | `1` |  |
| deployment.strategy.type | string | `"RollingUpdate"` |  |
| deployment.strategy.rollingUpdate.maxSurge | int | `1` |  |
| deployment.strategy.rollingUpdate.maxUnavailable | int | `0` |  |
| deployment.autoscaling.enabled | bool | `false` |  |
| deployment.autoscaling.minReplicas | int | `1` |  |
| deployment.autoscaling.maxReplicas | int | `10` |  |
| deployment.autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| deployment.autoscaling.targetMemoryUtilizationPercentage | int | `80` |  |
| deployment.autoscaling.customMetrics | list | `[]` |  |
| deployment.autoscaling.behavior.scaleDown.stabilizationWindowSeconds | int | `300` |  |
| deployment.autoscaling.behavior.scaleDown.policies[0].type | string | `"Percent"` |  |
| deployment.autoscaling.behavior.scaleDown.policies[0].value | int | `50` |  |
| deployment.autoscaling.behavior.scaleDown.policies[0].periodSeconds | int | `60` |  |
| deployment.autoscaling.behavior.scaleUp.stabilizationWindowSeconds | int | `0` |  |
| deployment.autoscaling.behavior.scaleUp.policies[0].type | string | `"Percent"` |  |
| deployment.autoscaling.behavior.scaleUp.policies[0].value | int | `100` |  |
| deployment.autoscaling.behavior.scaleUp.policies[0].periodSeconds | int | `15` |  |
| deployment.autoscaling.behavior.scaleUp.policies[1].type | string | `"Pods"` |  |
| deployment.autoscaling.behavior.scaleUp.policies[1].value | int | `2` |  |
| deployment.autoscaling.behavior.scaleUp.policies[1].periodSeconds | int | `60` |  |
| deployment.autoscaling.behavior.scaleUp.selectPolicy | string | `"Max"` |  |
| deployment.priorityClassName | string | `""` |  |
| deployment.dnsPolicy | string | `"ClusterFirst"` |  |
| deployment.dnsConfig | object | `{}` |  |
| deployment.podSecurityContext | object | `{}` |  |
| deployment.securityContext | object | `{}` |  |
| deployment.imagePullSecrets | list | `[]` |  |
| deployment.nodeSelector | object | `{}` |  |
| deployment.tolerations | list | `[]` |  |
| deployment.affinity | object | `{}` |  |
| deployment.topologySpreadConstraints | list | `[]` |  |
| deployment.image.repository | string | `"pihole/pihole"` |  |
| deployment.image.tag | string | `"latest"` |  |
| deployment.image.digest | string | `""` |  |
| deployment.image.imagePullPolicy | string | `"IfNotPresent"` |  |
| deployment.env.TZ.value | string | `"Europe/Zurich"` |  |
| deployment.env.FTLCONF_webserver_api_password.value | string | `"correct_horse_battery_staple"` |  |
| deployment.env.FTLCONF_dns_listeningMode.value | string | `"all"` |  |
| deployment.env.FTLCONF_dns_upstreams.value | string | `"8.8.8.8;8.8.4.4;1.1.1.1"` |  |
| deployment.env.FTLCONF_dns_dnssec.value | string | `"true"` |  |
| deployment.env.FTLCONF_database_DBfile.value | string | `"/etc/pihole/pihole-FTL.db"` |  |
| deployment.env.FTLCONF_webserver_port.value | string | `"80o,[::]:80o,443os,[::]:443os"` |  |
| deployment.env.PIHOLE_UID.value | string | `"1000"` |  |
| deployment.env.PIHOLE_GID.value | string | `"1000"` |  |
| deployment.ports[0].name | string | `"port-53-tcp"` |  |
| deployment.ports[0].containerPort | int | `53` |  |
| deployment.ports[0].protocol | string | `"TCP"` |  |
| deployment.ports[1].name | string | `"port-53-udp"` |  |
| deployment.ports[1].containerPort | int | `53` |  |
| deployment.ports[1].protocol | string | `"UDP"` |  |
| deployment.ports[2].name | string | `"port-80-tcp"` |  |
| deployment.ports[2].containerPort | int | `80` |  |
| deployment.ports[2].protocol | string | `"TCP"` |  |
| deployment.ports[3].name | string | `"port-443-tcp"` |  |
| deployment.ports[3].containerPort | int | `443` |  |
| deployment.ports[3].protocol | string | `"TCP"` |  |
| deployment.ports[4].name | string | `"port-67-udp"` |  |
| deployment.ports[4].containerPort | int | `67` |  |
| deployment.ports[4].protocol | string | `"UDP"` |  |
| deployment.resources.limits.cpu | string | `"2"` |  |
| deployment.resources.limits.memory | string | `"512M"` |  |
| deployment.resources.requests.cpu | string | `"0.5"` |  |
| deployment.resources.requests.memory | string | `"256M"` |  |
| deployment.startupProbe.exec.command[0] | string | `"dig"` |  |
| deployment.startupProbe.exec.command[1] | string | `"+short"` |  |
| deployment.startupProbe.exec.command[2] | string | `"+norecurse"` |  |
| deployment.startupProbe.exec.command[3] | string | `"+retry=0"` |  |
| deployment.startupProbe.exec.command[4] | string | `"@127.0.0.1"` |  |
| deployment.startupProbe.exec.command[5] | string | `"pi.hole"` |  |
| deployment.startupProbe.initialDelaySeconds | int | `0` |  |
| deployment.startupProbe.periodSeconds | int | `5` |  |
| deployment.startupProbe.timeoutSeconds | int | `3` |  |
| deployment.startupProbe.failureThreshold | int | `30` |  |
| deployment.startupProbe.successThreshold | int | `1` |  |
| deployment.livenessProbe.exec.command[0] | string | `"dig"` |  |
| deployment.livenessProbe.exec.command[1] | string | `"+short"` |  |
| deployment.livenessProbe.exec.command[2] | string | `"+norecurse"` |  |
| deployment.livenessProbe.exec.command[3] | string | `"+retry=0"` |  |
| deployment.livenessProbe.exec.command[4] | string | `"@127.0.0.1"` |  |
| deployment.livenessProbe.exec.command[5] | string | `"pi.hole"` |  |
| deployment.livenessProbe.initialDelaySeconds | int | `60` |  |
| deployment.livenessProbe.periodSeconds | int | `30` |  |
| deployment.livenessProbe.timeoutSeconds | int | `10` |  |
| deployment.livenessProbe.failureThreshold | int | `3` |  |
| deployment.livenessProbe.successThreshold | int | `1` |  |
| deployment.readinessProbe.exec.command[0] | string | `"dig"` |  |
| deployment.readinessProbe.exec.command[1] | string | `"+short"` |  |
| deployment.readinessProbe.exec.command[2] | string | `"+norecurse"` |  |
| deployment.readinessProbe.exec.command[3] | string | `"+retry=0"` |  |
| deployment.readinessProbe.exec.command[4] | string | `"@127.0.0.1"` |  |
| deployment.readinessProbe.exec.command[5] | string | `"pi.hole"` |  |
| deployment.readinessProbe.initialDelaySeconds | int | `30` |  |
| deployment.readinessProbe.periodSeconds | int | `10` |  |
| deployment.readinessProbe.timeoutSeconds | int | `5` |  |
| deployment.readinessProbe.failureThreshold | int | `3` |  |
| deployment.readinessProbe.successThreshold | int | `1` |  |
| deployment.volumes[0].name | string | `"etc-pihole"` |  |
| deployment.volumes[0].type | string | `"hostPath"` |  |
| deployment.volumes[0].mountPath | string | `"/etc/pihole"` |  |
| deployment.volumes[0].hostPath | string | `"./etc-pihole"` |  |
| deployment.volumes[0].readOnly | bool | `false` |  |
| deployment.volumes[1].name | string | `"etc-dnsmasq-d"` |  |
| deployment.volumes[1].type | string | `"hostPath"` |  |
| deployment.volumes[1].mountPath | string | `"/etc/dnsmasq.d"` |  |
| deployment.volumes[1].hostPath | string | `"./etc-dnsmasq.d"` |  |
| deployment.volumes[1].readOnly | bool | `false` |  |
| persistence.etc-pihole.enabled | bool | `false` |  |
| persistence.etc-pihole.storageClass | string | `""` |  |
| persistence.etc-pihole.accessModes[0] | string | `"ReadWriteOnce"` |  |
| persistence.etc-pihole.size | string | `"1Gi"` |  |
| persistence.etc-pihole.annotations | object | `{}` |  |
| persistence.etc-dnsmasq.enabled | bool | `false` |  |
| persistence.etc-dnsmasq.storageClass | string | `""` |  |
| persistence.etc-dnsmasq.accessModes[0] | string | `"ReadWriteOnce"` |  |
| persistence.etc-dnsmasq.size | string | `"500Mi"` |  |
| persistence.etc-dnsmasq.annotations | object | `{}` |  |
| service.type | string | `"ClusterIP"` |  |
| service.port | int | `80` |  |
| service.annotations | object | `{}` |  |
| ingress.enabled | bool | `false` |  |
| ingress.className | string | `""` |  |
| ingress.annotations | object | `{}` |  |
| ingress.hosts | list | `[]` |  |
| ingress.tls | list | `[]` |  |
| configMap.enabled | bool | `false` |  |
| configMap.data | object | `{}` |  |
| secret.enabled | bool | `false` |  |
| secret.data | object | `{}` |  |
| secret.existingSecret | string | `""` |  |
| secret.existingSecretKeys.webPassword | string | `"WEBPASSWORD"` |  |
| secret.existingSecretKeys.apiPassword | string | `"FTLCONF_webserver_api_password"` |  |
| externalSecrets.enabled | bool | `false` |  |
| externalSecrets.secretStoreName | string | `""` |  |
| externalSecrets.secretStoreKind | string | `"SecretStore"` |  |
| externalSecrets.refreshInterval | string | `"1h"` |  |
| externalSecrets.target.name | string | `""` |  |
| externalSecrets.target.creationPolicy | string | `"Owner"` |  |
| externalSecrets.target.deletionPolicy | string | `"Retain"` |  |
| externalSecrets.data | list | `[]` |  |
| externalSecrets.template.engineVersion | string | `"v2"` |  |
| externalSecrets.template.data | object | `{}` |  |
| sealedSecrets.enabled | bool | `false` |  |
| sealedSecrets.encryptedData | object | `{}` |  |
| sealedSecrets.scope | string | `"strict"` |  |
| sealedSecrets.annotations | object | `{}` |  |
| secretProviderClass.enabled | bool | `false` |  |
| secretProviderClass.name | string | `""` |  |
| secretProviderClass.provider | string | `""` |  |
| secretProviderClass.parameters | object | `{}` |  |
| secretProviderClass.secretObjects | list | `[]` |  |
