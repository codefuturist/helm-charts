# netbootxyz

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.7.6-nbxyz10](https://img.shields.io/badge/AppVersion-0.7.6--nbxyz10-informational?style=flat-square)

netboot.xyz is a network boot environment that allows PXE booting various operating system installers or utilities from a central location.

**Homepage:** <https://netboot.xyz>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| codefuturist |  | <https://github.com/codefuturist> |

## Source Code

* <https://github.com/netbootxyz/netboot.xyz>
* <https://github.com/netbootxyz/docker-netbootxyz>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://../common | common | 2.x.x |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| args | list | `[]` |  |
| command | list | `[]` |  |
| commonAnnotations | object | `{}` |  |
| commonLabels | object | `{}` |  |
| config.menuVersion | string | `""` |  |
| config.nginxPort | int | `80` |  |
| config.pgid | int | `1000` |  |
| config.puid | int | `1000` |  |
| config.tftpdOpts | string | `""` |  |
| config.webAppPort | int | `3000` |  |
| containerPorts.assets | int | `80` |  |
| containerPorts.tftp | int | `69` |  |
| containerPorts.webapp | int | `3000` |  |
| containerSecurityContext.allowPrivilegeEscalation | bool | `false` |  |
| containerSecurityContext.capabilities.add[0] | string | `"NET_BIND_SERVICE"` |  |
| containerSecurityContext.capabilities.add[1] | string | `"SETGID"` |  |
| containerSecurityContext.capabilities.add[2] | string | `"SETUID"` |  |
| containerSecurityContext.capabilities.drop[0] | string | `"ALL"` |  |
| containerSecurityContext.enabled | bool | `false` |  |
| containerSecurityContext.readOnlyRootFilesystem | bool | `false` |  |
| containerSecurityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| customLivenessProbe | object | `{}` |  |
| customReadinessProbe | object | `{}` |  |
| customStartupProbe | object | `{}` |  |
| diagnosticMode.args[0] | string | `"infinity"` |  |
| diagnosticMode.command[0] | string | `"sleep"` |  |
| diagnosticMode.enabled | bool | `false` |  |
| dnsConfig | object | `{}` |  |
| dnsPolicy | string | `""` |  |
| extraDeploy | list | `[]` |  |
| extraEnvVars | list | `[]` |  |
| extraEnvVarsCM | string | `""` |  |
| extraEnvVarsSecret | string | `""` |  |
| extraVolumeMounts | list | `[]` |  |
| extraVolumes | list | `[]` |  |
| fullnameOverride | string | `""` |  |
| global.imagePullSecrets | list | `[]` |  |
| global.imageRegistry | string | `""` |  |
| global.storageClass | string | `""` |  |
| hostAliases | list | `[]` |  |
| hostNetwork | bool | `false` |  |
| image.digest | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.pullSecrets | list | `[]` |  |
| image.registry | string | `"ghcr.io"` |  |
| image.repository | string | `"netbootxyz/netbootxyz"` |  |
| image.tag | string | `""` |  |
| ingress.annotations | object | `{}` |  |
| ingress.enabled | bool | `false` |  |
| ingress.extraHosts | list | `[]` |  |
| ingress.extraPaths | list | `[]` |  |
| ingress.extraRules | list | `[]` |  |
| ingress.extraTls | list | `[]` |  |
| ingress.hostname | string | `"netboot.local"` |  |
| ingress.ingressClassName | string | `""` |  |
| ingress.path | string | `"/"` |  |
| ingress.pathType | string | `"Prefix"` |  |
| ingress.secrets | list | `[]` |  |
| ingress.selfSigned | bool | `false` |  |
| ingress.tls | bool | `false` |  |
| initContainers | list | `[]` |  |
| livenessProbe.enabled | bool | `true` |  |
| livenessProbe.failureThreshold | int | `10` |  |
| livenessProbe.initialDelaySeconds | int | `60` |  |
| livenessProbe.periodSeconds | int | `15` |  |
| livenessProbe.successThreshold | int | `1` |  |
| livenessProbe.timeoutSeconds | int | `5` |  |
| nameOverride | string | `""` |  |
| namespaceOverride | string | `""` |  |
| networkPolicy.allowExternal | bool | `true` |  |
| networkPolicy.allowExternalEgress | bool | `true` |  |
| networkPolicy.enabled | bool | `false` |  |
| networkPolicy.extraEgress | list | `[]` |  |
| networkPolicy.extraIngress | list | `[]` |  |
| networkPolicy.ingressNSMatchLabels | object | `{}` |  |
| networkPolicy.ingressNSPodMatchLabels | object | `{}` |  |
| nodeAffinityPreset.key | string | `""` |  |
| nodeAffinityPreset.type | string | `""` |  |
| nodeAffinityPreset.values | list | `[]` |  |
| nodeSelector | object | `{}` |  |
| pdb.create | bool | `false` |  |
| pdb.maxUnavailable | int | `1` |  |
| pdb.minAvailable | string | `""` |  |
| persistence.assets.accessModes[0] | string | `"ReadWriteOnce"` |  |
| persistence.assets.annotations | object | `{}` |  |
| persistence.assets.enabled | bool | `false` |  |
| persistence.assets.existingClaim | string | `""` |  |
| persistence.assets.selector | object | `{}` |  |
| persistence.assets.size | string | `"50Gi"` |  |
| persistence.assets.storageClass | string | `""` |  |
| persistence.config.accessModes[0] | string | `"ReadWriteOnce"` |  |
| persistence.config.annotations | object | `{}` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.existingClaim | string | `""` |  |
| persistence.config.selector | object | `{}` |  |
| persistence.config.size | string | `"1Gi"` |  |
| persistence.config.storageClass | string | `""` |  |
| podAffinityPreset | string | `""` |  |
| podAnnotations | object | `{}` |  |
| podAntiAffinityPreset | string | `"soft"` |  |
| podLabels | object | `{}` |  |
| podSecurityContext.enabled | bool | `false` |  |
| podSecurityContext.fsGroup | int | `1000` |  |
| podSecurityContext.fsGroupChangePolicy | string | `"OnRootMismatch"` |  |
| priorityClassName | string | `""` |  |
| readinessProbe.enabled | bool | `true` |  |
| readinessProbe.failureThreshold | int | `6` |  |
| readinessProbe.initialDelaySeconds | int | `30` |  |
| readinessProbe.periodSeconds | int | `10` |  |
| readinessProbe.successThreshold | int | `1` |  |
| readinessProbe.timeoutSeconds | int | `5` |  |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| resourcesPreset | string | `"nano"` |  |
| revisionHistoryLimit | int | `10` |  |
| schedulerName | string | `""` |  |
| service.annotations | object | `{}` |  |
| service.clusterIP | string | `""` |  |
| service.externalTrafficPolicy | string | `"Cluster"` |  |
| service.extraPorts | list | `[]` |  |
| service.loadBalancerClass | string | `""` |  |
| service.loadBalancerIP | string | `""` |  |
| service.loadBalancerSourceRanges | list | `[]` |  |
| service.nodePorts.assets | string | `""` |  |
| service.nodePorts.webapp | string | `""` |  |
| service.ports.assets | int | `80` |  |
| service.ports.webapp | int | `3000` |  |
| service.sessionAffinity | string | `"None"` |  |
| service.sessionAffinityConfig | object | `{}` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.automountServiceAccountToken | bool | `false` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| sidecars | list | `[]` |  |
| startupProbe.enabled | bool | `false` |  |
| startupProbe.failureThreshold | int | `30` |  |
| startupProbe.initialDelaySeconds | int | `0` |  |
| startupProbe.periodSeconds | int | `10` |  |
| startupProbe.successThreshold | int | `1` |  |
| startupProbe.timeoutSeconds | int | `5` |  |
| terminationGracePeriodSeconds | string | `""` |  |
| tftp.hostPort.enabled | bool | `false` |  |
| tftp.hostPort.port | int | `69` |  |
| tftp.service.annotations | object | `{}` |  |
| tftp.service.enabled | bool | `true` |  |
| tftp.service.externalTrafficPolicy | string | `"Local"` |  |
| tftp.service.loadBalancerClass | string | `""` |  |
| tftp.service.loadBalancerIP | string | `""` |  |
| tftp.service.loadBalancerSourceRanges | list | `[]` |  |
| tftp.service.nodePort | string | `""` |  |
| tftp.service.port | int | `69` |  |
| tftp.service.type | string | `"NodePort"` |  |
| tolerations | list | `[]` |  |
| topologySpreadConstraints | list | `[]` |  |
| updateStrategy.rollingUpdate | object | `{}` |  |
| updateStrategy.type | string | `"Recreate"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
