# actualbudget

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 25.11.0](https://img.shields.io/badge/AppVersion-25.11.0-informational?style=flat-square)

A Helm chart for Actual Budget - A local-first personal finance app

**Homepage:** <https://actualbudget.org>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| codefuturist | <58808821+codefuturist@users.noreply.github.com> |  |

## Source Code

* <https://github.com/actualbudget/actual>
* <https://github.com/codefuturist/helm-charts>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://../../libs/common | common | 2.x.x |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.imageRegistry | string | `""` |  |
| global.imagePullSecrets | list | `[]` |  |
| nameOverride | string | `""` |  |
| fullnameOverride | string | `""` |  |
| namespaceOverride | string | `""` |  |
| kubeVersion | string | `""` |  |
| clusterDomain | string | `"cluster.local"` |  |
| commonLabels | object | `{}` |  |
| commonAnnotations | object | `{}` |  |
| diagnosticMode.enabled | bool | `false` |  |
| diagnosticMode.command[0] | string | `"sleep"` |  |
| diagnosticMode.args[0] | string | `"infinity"` |  |
| image.registry | string | `"ghcr.io"` |  |
| image.repository | string | `"alexta69/metube"` |  |
| image.tag | string | `"2025.11.29"` |  |
| image.digest | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.pullSecrets | list | `[]` |  |
| image.debug | bool | `false` |  |
| config.downloadMode | string | `"limited"` |  |
| config.maxConcurrentDownloads | int | `3` |  |
| config.deleteFileOnTrashcan | bool | `false` |  |
| config.defaultOptionPlaylistStrictMode | bool | `false` |  |
| config.defaultOptionPlaylistItemLimit | int | `0` |  |
| config.customDirs | bool | `true` |  |
| config.createCustomDirs | bool | `true` |  |
| config.customDirsExcludeRegex | string | `"(^|/)[.@].*$"` |  |
| config.downloadDirsIndexable | bool | `false` |  |
| config.outputTemplate | string | `"%(title)s.%(ext)s"` |  |
| config.outputTemplateChapter | string | `"%(title)s - %(section_number)s %(section_title)s.%(ext)s"` |  |
| config.outputTemplatePlaylist | string | `"%(playlist_title)s/%(title)s.%(ext)s"` |  |
| config.ytdlOptions | string | `""` |  |
| config.urlPrefix | string | `"/"` |  |
| config.publicHostUrl | string | `""` |  |
| config.publicHostAudioUrl | string | `""` |  |
| config.uid | int | `1000` |  |
| config.gid | int | `1000` |  |
| config.umask | string | `"022"` |  |
| config.defaultTheme | string | `"auto"` |  |
| config.loglevel | string | `"INFO"` |  |
| config.enableAccesslog | bool | `false` |  |
| storage.downloadDir | string | `"/downloads"` |  |
| storage.audioDownloadDir | string | `""` |  |
| storage.stateDir | string | `""` |  |
| storage.tempDir | string | `""` |  |
| cookies.enabled | bool | `false` |  |
| cookies.content | string | `""` |  |
| cookies.existingSecret | string | `""` |  |
| tls.enabled | bool | `false` |  |
| tls.certFile | string | `""` |  |
| tls.keyFile | string | `""` |  |
| tls.existingSecret | string | `""` |  |
| replicaCount | int | `1` |  |
| updateStrategy.type | string | `"Recreate"` |  |
| podLabels | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext.enabled | bool | `true` |  |
| podSecurityContext.fsGroup | int | `1000` |  |
| podSecurityContext.fsGroupChangePolicy | string | `"Always"` |  |
| containerSecurityContext.enabled | bool | `true` |  |
| containerSecurityContext.runAsUser | int | `1000` |  |
| containerSecurityContext.runAsGroup | int | `1000` |  |
| containerSecurityContext.runAsNonRoot | bool | `true` |  |
| containerSecurityContext.allowPrivilegeEscalation | bool | `false` |  |
| containerSecurityContext.capabilities.drop[0] | string | `"ALL"` |  |
| containerPort | int | `8081` |  |
| livenessProbe.enabled | bool | `true` |  |
| livenessProbe.initialDelaySeconds | int | `30` |  |
| livenessProbe.periodSeconds | int | `10` |  |
| livenessProbe.timeoutSeconds | int | `5` |  |
| livenessProbe.failureThreshold | int | `6` |  |
| livenessProbe.successThreshold | int | `1` |  |
| readinessProbe.enabled | bool | `true` |  |
| readinessProbe.initialDelaySeconds | int | `15` |  |
| readinessProbe.periodSeconds | int | `10` |  |
| readinessProbe.timeoutSeconds | int | `3` |  |
| readinessProbe.failureThreshold | int | `3` |  |
| readinessProbe.successThreshold | int | `1` |  |
| startupProbe.enabled | bool | `true` |  |
| startupProbe.initialDelaySeconds | int | `10` |  |
| startupProbe.periodSeconds | int | `10` |  |
| startupProbe.timeoutSeconds | int | `3` |  |
| startupProbe.failureThreshold | int | `30` |  |
| startupProbe.successThreshold | int | `1` |  |
| resourcesPreset | string | `"micro"` |  |
| resources | object | `{}` |  |
| command | list | `[]` |  |
| args | list | `[]` |  |
| extraEnvVars | list | `[]` |  |
| extraEnvVarsCM | string | `""` |  |
| extraEnvVarsSecret | string | `""` |  |
| service.type | string | `"ClusterIP"` |  |
| service.ports.http | int | `8081` |  |
| service.nodePorts.http | string | `""` |  |
| service.clusterIP | string | `""` |  |
| service.loadBalancerIP | string | `""` |  |
| service.loadBalancerSourceRanges | list | `[]` |  |
| service.externalTrafficPolicy | string | `"Cluster"` |  |
| service.annotations | object | `{}` |  |
| service.sessionAffinity | string | `"None"` |  |
| service.sessionAffinityConfig | object | `{}` |  |
| ingress.enabled | bool | `false` |  |
| ingress.pathType | string | `"ImplementationSpecific"` |  |
| ingress.apiVersion | string | `""` |  |
| ingress.ingressClassName | string | `""` |  |
| ingress.hostname | string | `"metube.local"` |  |
| ingress.path | string | `"/"` |  |
| ingress.annotations | object | `{}` |  |
| ingress.tls | bool | `false` |  |
| ingress.selfSigned | bool | `false` |  |
| ingress.extraHosts | list | `[]` |  |
| ingress.extraPaths | list | `[]` |  |
| ingress.extraTls | list | `[]` |  |
| ingress.secrets | list | `[]` |  |
| ingress.extraRules | list | `[]` |  |
| persistence.enabled | bool | `true` |  |
| persistence.storageClass | string | `""` |  |
| persistence.annotations | object | `{}` |  |
| persistence.accessModes[0] | string | `"ReadWriteOnce"` |  |
| persistence.size | string | `"10Gi"` |  |
| persistence.existingClaim | string | `""` |  |
| persistence.selector | object | `{}` |  |
| persistence.dataSource | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| serviceAccount.automountServiceAccountToken | bool | `false` |  |
| serviceAccount.annotations | object | `{}` |  |
| pdb.enabled | bool | `false` |  |
| pdb.minAvailable | int | `1` |  |
| pdb.maxUnavailable | string | `""` |  |
| networkPolicy.enabled | bool | `false` |  |
| networkPolicy.ingress.enabled | bool | `true` |  |
| networkPolicy.egress.enabled | bool | `true` |  |
| networkPolicy.egress.allowExternal | bool | `true` |  |
| metrics.enabled | bool | `false` |  |
| metrics.serviceMonitor.enabled | bool | `false` |  |
| metrics.serviceMonitor.namespace | string | `""` |  |
| metrics.serviceMonitor.interval | string | `"30s"` |  |
| metrics.serviceMonitor.scrapeTimeout | string | `"10s"` |  |
| metrics.serviceMonitor.labels | object | `{}` |  |
| metrics.serviceMonitor.selector | object | `{}` |  |
| metrics.serviceMonitor.relabelings | list | `[]` |  |
| metrics.serviceMonitor.metricRelabelings | list | `[]` |  |
