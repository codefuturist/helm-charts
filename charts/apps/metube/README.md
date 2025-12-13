# metube

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2025.11.29](https://img.shields.io/badge/AppVersion-2025.11.29-informational?style=flat-square)

A Helm chart for MeTube - YouTube downloader with web interface powered by yt-dlp

**Homepage:** <https://github.com/alexta69/metube>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| codefuturist | <58808821+codefuturist@users.noreply.github.com> |  |

## Source Code

* <https://github.com/alexta69/metube>
* <https://github.com/codefuturist/helm-charts>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://../../libs/common | common | 2.x.x |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| args | list | `[]` |  |
| clusterDomain | string | `"cluster.local"` |  |
| command | list | `[]` |  |
| commonAnnotations | object | `{}` |  |
| commonLabels | object | `{}` |  |
| config.createCustomDirs | bool | `true` |  |
| config.customDirs | bool | `true` |  |
| config.customDirsExcludeRegex | string | `"(^|/)[.@].*$"` |  |
| config.defaultOptionPlaylistItemLimit | int | `0` |  |
| config.defaultOptionPlaylistStrictMode | bool | `false` |  |
| config.defaultTheme | string | `"auto"` |  |
| config.deleteFileOnTrashcan | bool | `false` |  |
| config.downloadDirsIndexable | bool | `false` |  |
| config.downloadMode | string | `"limited"` |  |
| config.enableAccesslog | bool | `false` |  |
| config.gid | int | `1000` |  |
| config.loglevel | string | `"INFO"` |  |
| config.maxConcurrentDownloads | int | `3` |  |
| config.outputTemplate | string | `"%(title)s.%(ext)s"` |  |
| config.outputTemplateChapter | string | `"%(title)s - %(section_number)s %(section_title)s.%(ext)s"` |  |
| config.outputTemplatePlaylist | string | `"%(playlist_title)s/%(title)s.%(ext)s"` |  |
| config.publicHostAudioUrl | string | `""` |  |
| config.publicHostUrl | string | `""` |  |
| config.uid | int | `1000` |  |
| config.umask | string | `"022"` |  |
| config.urlPrefix | string | `"/"` |  |
| config.ytdlOptions | string | `""` |  |
| containerPort | int | `8081` |  |
| containerSecurityContext.allowPrivilegeEscalation | bool | `false` |  |
| containerSecurityContext.capabilities.drop[0] | string | `"ALL"` |  |
| containerSecurityContext.enabled | bool | `true` |  |
| containerSecurityContext.runAsGroup | int | `1000` |  |
| containerSecurityContext.runAsNonRoot | bool | `true` |  |
| containerSecurityContext.runAsUser | int | `1000` |  |
| cookies.content | string | `""` |  |
| cookies.enabled | bool | `false` |  |
| cookies.existingSecret | string | `""` |  |
| diagnosticMode.args[0] | string | `"infinity"` |  |
| diagnosticMode.command[0] | string | `"sleep"` |  |
| diagnosticMode.enabled | bool | `false` |  |
| extraEnvVars | list | `[]` |  |
| extraEnvVarsCM | string | `""` |  |
| extraEnvVarsSecret | string | `""` |  |
| fullnameOverride | string | `""` |  |
| global.imagePullSecrets | list | `[]` |  |
| global.imageRegistry | string | `""` |  |
| image.debug | bool | `false` |  |
| image.digest | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.pullSecrets | list | `[]` |  |
| image.registry | string | `"ghcr.io"` |  |
| image.repository | string | `"alexta69/metube"` |  |
| image.tag | string | `"2025.11.29"` |  |
| ingress.annotations | object | `{}` |  |
| ingress.apiVersion | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.extraHosts | list | `[]` |  |
| ingress.extraPaths | list | `[]` |  |
| ingress.extraRules | list | `[]` |  |
| ingress.extraTls | list | `[]` |  |
| ingress.hostname | string | `"metube.local"` |  |
| ingress.ingressClassName | string | `""` |  |
| ingress.path | string | `"/"` |  |
| ingress.pathType | string | `"ImplementationSpecific"` |  |
| ingress.secrets | list | `[]` |  |
| ingress.selfSigned | bool | `false` |  |
| ingress.tls | bool | `false` |  |
| kubeVersion | string | `""` |  |
| livenessProbe.enabled | bool | `true` |  |
| livenessProbe.failureThreshold | int | `6` |  |
| livenessProbe.initialDelaySeconds | int | `30` |  |
| livenessProbe.periodSeconds | int | `10` |  |
| livenessProbe.successThreshold | int | `1` |  |
| livenessProbe.timeoutSeconds | int | `5` |  |
| metrics.enabled | bool | `false` |  |
| metrics.serviceMonitor.enabled | bool | `false` |  |
| metrics.serviceMonitor.interval | string | `"30s"` |  |
| metrics.serviceMonitor.labels | object | `{}` |  |
| metrics.serviceMonitor.metricRelabelings | list | `[]` |  |
| metrics.serviceMonitor.namespace | string | `""` |  |
| metrics.serviceMonitor.relabelings | list | `[]` |  |
| metrics.serviceMonitor.scrapeTimeout | string | `"10s"` |  |
| metrics.serviceMonitor.selector | object | `{}` |  |
| nameOverride | string | `""` |  |
| namespaceOverride | string | `""` |  |
| networkPolicy.egress.allowExternal | bool | `true` |  |
| networkPolicy.egress.enabled | bool | `true` |  |
| networkPolicy.enabled | bool | `false` |  |
| networkPolicy.ingress.enabled | bool | `true` |  |
| pdb.enabled | bool | `false` |  |
| pdb.maxUnavailable | string | `""` |  |
| pdb.minAvailable | int | `1` |  |
| persistence.accessModes[0] | string | `"ReadWriteOnce"` |  |
| persistence.annotations | object | `{}` |  |
| persistence.dataSource | object | `{}` |  |
| persistence.enabled | bool | `true` |  |
| persistence.existingClaim | string | `""` |  |
| persistence.selector | object | `{}` |  |
| persistence.size | string | `"10Gi"` |  |
| persistence.storageClass | string | `""` |  |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| podSecurityContext.enabled | bool | `true` |  |
| podSecurityContext.fsGroup | int | `1000` |  |
| podSecurityContext.fsGroupChangePolicy | string | `"Always"` |  |
| readinessProbe.enabled | bool | `true` |  |
| readinessProbe.failureThreshold | int | `3` |  |
| readinessProbe.initialDelaySeconds | int | `15` |  |
| readinessProbe.periodSeconds | int | `10` |  |
| readinessProbe.successThreshold | int | `1` |  |
| readinessProbe.timeoutSeconds | int | `3` |  |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| resourcesPreset | string | `"small"` |  |
| service.annotations | object | `{}` |  |
| service.clusterIP | string | `""` |  |
| service.externalTrafficPolicy | string | `"Cluster"` |  |
| service.loadBalancerIP | string | `""` |  |
| service.loadBalancerSourceRanges | list | `[]` |  |
| service.nodePorts.http | string | `""` |  |
| service.ports.http | int | `8081` |  |
| service.sessionAffinity | string | `"None"` |  |
| service.sessionAffinityConfig | object | `{}` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.automountServiceAccountToken | bool | `false` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| startupProbe.enabled | bool | `true` |  |
| startupProbe.failureThreshold | int | `30` |  |
| startupProbe.initialDelaySeconds | int | `10` |  |
| startupProbe.periodSeconds | int | `10` |  |
| startupProbe.successThreshold | int | `1` |  |
| startupProbe.timeoutSeconds | int | `3` |  |
| storage.audioDownloadDir | string | `""` |  |
| storage.downloadDir | string | `"/downloads"` |  |
| storage.stateDir | string | `""` |  |
| storage.tempDir | string | `""` |  |
| tls.certFile | string | `""` |  |
| tls.enabled | bool | `false` |  |
| tls.existingSecret | string | `""` |  |
| tls.keyFile | string | `""` |  |
| updateStrategy.type | string | `"Recreate"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
