# nginx

![Version: 22.1.0](https://img.shields.io/badge/Version-22.1.0-informational?style=flat-square) ![AppVersion: 1.29.1](https://img.shields.io/badge/AppVersion-1.29.1-informational?style=flat-square)

NGINX Open Source is a web server that can be also used as a reverse proxy, load balancer, and HTTP cache. Recommended for high-demanding sites due to its ability to provide faster content.

**Homepage:** <https://bitnami.com>

## Maintainers

| Name                                | Email | Url                                 |
| ----------------------------------- | ----- | ----------------------------------- |
| Broadcom, Inc. All Rights Reserved. |       | <https://github.com/bitnami/charts> |

## Source Code

- <https://github.com/bitnami/charts/tree/main/bitnami/nginx>

## Requirements

| Repository                               | Name   | Version |
| ---------------------------------------- | ------ | ------- |
| oci://registry-1.docker.io/bitnamicharts | common | 2.x.x   |

## Values

| Key                                                 | Type   | Default                                | Description |
| --------------------------------------------------- | ------ | -------------------------------------- | ----------- |
| affinity                                            | object | `{}`                                   |             |
| args                                                | list   | `[]`                                   |             |
| automountServiceAccountToken                        | bool   | `false`                                |             |
| autoscaling.enabled                                 | bool   | `false`                                |             |
| autoscaling.maxReplicas                             | string | `""`                                   |             |
| autoscaling.minReplicas                             | string | `""`                                   |             |
| autoscaling.targetCPU                               | string | `""`                                   |             |
| autoscaling.targetMemory                            | string | `""`                                   |             |
| cloneStaticSiteFromGit.branch                       | string | `""`                                   |             |
| cloneStaticSiteFromGit.enabled                      | bool   | `false`                                |             |
| cloneStaticSiteFromGit.extraEnvVars                 | list   | `[]`                                   |             |
| cloneStaticSiteFromGit.extraEnvVarsSecret           | string | `""`                                   |             |
| cloneStaticSiteFromGit.extraVolumeMounts            | list   | `[]`                                   |             |
| cloneStaticSiteFromGit.gitClone.args                | list   | `[]`                                   |             |
| cloneStaticSiteFromGit.gitClone.command             | list   | `[]`                                   |             |
| cloneStaticSiteFromGit.gitSync.args                 | list   | `[]`                                   |             |
| cloneStaticSiteFromGit.gitSync.command              | list   | `[]`                                   |             |
| cloneStaticSiteFromGit.gitSync.resources            | object | `{}`                                   |             |
| cloneStaticSiteFromGit.gitSync.resourcesPreset      | string | `"nano"`                               |             |
| cloneStaticSiteFromGit.image.digest                 | string | `""`                                   |             |
| cloneStaticSiteFromGit.image.pullPolicy             | string | `"IfNotPresent"`                       |             |
| cloneStaticSiteFromGit.image.pullSecrets            | list   | `[]`                                   |             |
| cloneStaticSiteFromGit.image.registry               | string | `"docker.io"`                          |             |
| cloneStaticSiteFromGit.image.repository             | string | `"bitnami/git"`                        |             |
| cloneStaticSiteFromGit.image.tag                    | string | `"2.51.0-debian-12-r0"`                |             |
| cloneStaticSiteFromGit.interval                     | int    | `60`                                   |             |
| cloneStaticSiteFromGit.repository                   | string | `""`                                   |             |
| clusterDomain                                       | string | `"cluster.local"`                      |             |
| command                                             | list   | `[]`                                   |             |
| commonAnnotations                                   | object | `{}`                                   |             |
| commonLabels                                        | object | `{}`                                   |             |
| containerPorts.http                                 | int    | `8080`                                 |             |
| containerPorts.https                                | int    | `8443`                                 |             |
| containerSecurityContext.allowPrivilegeEscalation   | bool   | `false`                                |             |
| containerSecurityContext.capabilities.drop[0]       | string | `"ALL"`                                |             |
| containerSecurityContext.enabled                    | bool   | `true`                                 |             |
| containerSecurityContext.privileged                 | bool   | `false`                                |             |
| containerSecurityContext.readOnlyRootFilesystem     | bool   | `true`                                 |             |
| containerSecurityContext.runAsGroup                 | int    | `1001`                                 |             |
| containerSecurityContext.runAsNonRoot               | bool   | `true`                                 |             |
| containerSecurityContext.runAsUser                  | int    | `1001`                                 |             |
| containerSecurityContext.seLinuxOptions             | object | `{}`                                   |             |
| containerSecurityContext.seccompProfile.type        | string | `"RuntimeDefault"`                     |             |
| contextIncludes.events                              | string | `""`                                   |             |
| contextIncludes.http                                | string | `""`                                   |             |
| contextIncludes.main                                | string | `""`                                   |             |
| customLivenessProbe                                 | object | `{}`                                   |             |
| customReadinessProbe                                | object | `{}`                                   |             |
| customStartupProbe                                  | object | `{}`                                   |             |
| diagnosticMode.args[0]                              | string | `"infinity"`                           |             |
| diagnosticMode.command[0]                           | string | `"sleep"`                              |             |
| diagnosticMode.enabled                              | bool   | `false`                                |             |
| dnsConfig                                           | object | `{}`                                   |             |
| dnsPolicy                                           | string | `""`                                   |             |
| enableDefaultInitContainers                         | bool   | `true`                                 |             |
| existingContextEventsConfigmaps                     | list   | `[]`                                   |             |
| existingContextHttpConfigmaps                       | list   | `[]`                                   |             |
| existingContextMainConfigmaps                       | list   | `[]`                                   |             |
| existingServerBlockConfigmap                        | string | `""`                                   |             |
| existingStreamServerBlockConfigmap                  | string | `""`                                   |             |
| extraContainerPorts                                 | list   | `[]`                                   |             |
| extraDeploy                                         | list   | `[]`                                   |             |
| extraEnvVars                                        | list   | `[]`                                   |             |
| extraEnvVarsCM                                      | string | `""`                                   |             |
| extraEnvVarsSecret                                  | string | `""`                                   |             |
| extraVolumeMounts                                   | list   | `[]`                                   |             |
| extraVolumes                                        | list   | `[]`                                   |             |
| fullnameOverride                                    | string | `""`                                   |             |
| global.compatibility.openshift.adaptSecurityContext | string | `"auto"`                               |             |
| global.imagePullSecrets                             | list   | `[]`                                   |             |
| global.imageRegistry                                | string | `""`                                   |             |
| global.security.allowInsecureImages                 | bool   | `false`                                |             |
| healthIngress.annotations                           | object | `{}`                                   |             |
| healthIngress.enabled                               | bool   | `false`                                |             |
| healthIngress.extraHosts                            | list   | `[]`                                   |             |
| healthIngress.extraPaths                            | list   | `[]`                                   |             |
| healthIngress.extraRules                            | list   | `[]`                                   |             |
| healthIngress.extraTls                              | list   | `[]`                                   |             |
| healthIngress.hostname                              | string | `"example.local"`                      |             |
| healthIngress.ingressClassName                      | string | `""`                                   |             |
| healthIngress.path                                  | string | `"/"`                                  |             |
| healthIngress.pathType                              | string | `"ImplementationSpecific"`             |             |
| healthIngress.secrets                               | list   | `[]`                                   |             |
| healthIngress.selfSigned                            | bool   | `false`                                |             |
| healthIngress.tls                                   | bool   | `false`                                |             |
| hostAliases                                         | list   | `[]`                                   |             |
| hostIPC                                             | bool   | `false`                                |             |
| hostNetwork                                         | bool   | `false`                                |             |
| image.debug                                         | bool   | `false`                                |             |
| image.digest                                        | string | `""`                                   |             |
| image.pullPolicy                                    | string | `"IfNotPresent"`                       |             |
| image.pullSecrets                                   | list   | `[]`                                   |             |
| image.registry                                      | string | `"docker.io"`                          |             |
| image.repository                                    | string | `"bitnami/nginx"`                      |             |
| image.tag                                           | string | `"1.29.1-debian-12-r0"`                |             |
| ingress.annotations                                 | object | `{}`                                   |             |
| ingress.apiVersion                                  | string | `""`                                   |             |
| ingress.enabled                                     | bool   | `false`                                |             |
| ingress.extraHosts                                  | list   | `[]`                                   |             |
| ingress.extraPaths                                  | list   | `[]`                                   |             |
| ingress.extraRules                                  | list   | `[]`                                   |             |
| ingress.extraTls                                    | list   | `[]`                                   |             |
| ingress.hostname                                    | string | `"nginx.local"`                        |             |
| ingress.ingressClassName                            | string | `""`                                   |             |
| ingress.path                                        | string | `"/"`                                  |             |
| ingress.pathType                                    | string | `"ImplementationSpecific"`             |             |
| ingress.secrets                                     | list   | `[]`                                   |             |
| ingress.selfSigned                                  | bool   | `false`                                |             |
| ingress.tls                                         | bool   | `false`                                |             |
| ingress.tlsWwwPrefix                                | bool   | `false`                                |             |
| initContainers                                      | list   | `[]`                                   |             |
| kubeVersion                                         | string | `""`                                   |             |
| lifecycleHooks                                      | object | `{}`                                   |             |
| livenessProbe.enabled                               | bool   | `true`                                 |             |
| livenessProbe.failureThreshold                      | int    | `6`                                    |             |
| livenessProbe.initialDelaySeconds                   | int    | `30`                                   |             |
| livenessProbe.periodSeconds                         | int    | `10`                                   |             |
| livenessProbe.successThreshold                      | int    | `1`                                    |             |
| livenessProbe.timeoutSeconds                        | int    | `5`                                    |             |
| metrics.containerPorts.metrics                      | int    | `9113`                                 |             |
| metrics.customLivenessProbe                         | object | `{}`                                   |             |
| metrics.customReadinessProbe                        | object | `{}`                                   |             |
| metrics.customStartupProbe                          | object | `{}`                                   |             |
| metrics.enabled                                     | bool   | `false`                                |             |
| metrics.extraArgs                                   | list   | `[]`                                   |             |
| metrics.image.digest                                | string | `""`                                   |             |
| metrics.image.pullPolicy                            | string | `"IfNotPresent"`                       |             |
| metrics.image.pullSecrets                           | list   | `[]`                                   |             |
| metrics.image.registry                              | string | `"docker.io"`                          |             |
| metrics.image.repository                            | string | `"bitnami/nginx-exporter"`             |             |
| metrics.image.tag                                   | string | `"1.4.2-debian-12-r9"`                 |             |
| metrics.livenessProbe.enabled                       | bool   | `true`                                 |             |
| metrics.livenessProbe.failureThreshold              | int    | `2`                                    |             |
| metrics.livenessProbe.initialDelaySeconds           | int    | `30`                                   |             |
| metrics.livenessProbe.periodSeconds                 | int    | `10`                                   |             |
| metrics.livenessProbe.successThreshold              | int    | `1`                                    |             |
| metrics.livenessProbe.timeoutSeconds                | int    | `5`                                    |             |
| metrics.podAnnotations                              | object | `{}`                                   |             |
| metrics.port                                        | string | `""`                                   |             |
| metrics.prometheusRule.additionalLabels             | object | `{}`                                   |             |
| metrics.prometheusRule.enabled                      | bool   | `false`                                |             |
| metrics.prometheusRule.namespace                    | string | `""`                                   |             |
| metrics.prometheusRule.rules                        | list   | `[]`                                   |             |
| metrics.readinessProbe.enabled                      | bool   | `true`                                 |             |
| metrics.readinessProbe.failureThreshold             | int    | `2`                                    |             |
| metrics.readinessProbe.initialDelaySeconds          | int    | `5`                                    |             |
| metrics.readinessProbe.periodSeconds                | int    | `30`                                   |             |
| metrics.readinessProbe.successThreshold             | int    | `1`                                    |             |
| metrics.readinessProbe.timeoutSeconds               | int    | `3`                                    |             |
| metrics.resources                                   | object | `{}`                                   |             |
| metrics.resourcesPreset                             | string | `"nano"`                               |             |
| metrics.securityContext.enabled                     | bool   | `false`                                |             |
| metrics.securityContext.runAsUser                   | int    | `1001`                                 |             |
| metrics.securityContext.seLinuxOptions              | object | `{}`                                   |             |
| metrics.service.annotations."prometheus.io/port"    | string | `"{{ .Values.metrics.service.port }}"` |             |
| metrics.service.annotations."prometheus.io/scrape"  | string | `"true"`                               |             |
| metrics.service.port                                | int    | `9113`                                 |             |
| metrics.serviceMonitor.enabled                      | bool   | `false`                                |             |
| metrics.serviceMonitor.honorLabels                  | bool   | `false`                                |             |
| metrics.serviceMonitor.interval                     | string | `""`                                   |             |
| metrics.serviceMonitor.jobLabel                     | string | `""`                                   |             |
| metrics.serviceMonitor.labels                       | object | `{}`                                   |             |
| metrics.serviceMonitor.metricRelabelings            | list   | `[]`                                   |             |
| metrics.serviceMonitor.namespace                    | string | `""`                                   |             |
| metrics.serviceMonitor.relabelings                  | list   | `[]`                                   |             |
| metrics.serviceMonitor.scrapeTimeout                | string | `""`                                   |             |
| metrics.serviceMonitor.selector                     | object | `{}`                                   |             |
| metrics.serviceMonitor.tlsConfig                    | object | `{}`                                   |             |
| metrics.startupProbe.enabled                        | bool   | `false`                                |             |
| metrics.startupProbe.failureThreshold               | int    | `10`                                   |             |
| metrics.startupProbe.initialDelaySeconds            | int    | `5`                                    |             |
| metrics.startupProbe.periodSeconds                  | int    | `5`                                    |             |
| metrics.startupProbe.successThreshold               | int    | `1`                                    |             |
| metrics.startupProbe.timeoutSeconds                 | int    | `3`                                    |             |
| nameOverride                                        | string | `""`                                   |             |
| namespaceOverride                                   | string | `""`                                   |             |
| networkPolicy.allowExternal                         | bool   | `true`                                 |             |
| networkPolicy.allowExternalEgress                   | bool   | `true`                                 |             |
| networkPolicy.enabled                               | bool   | `true`                                 |             |
| networkPolicy.extraEgress                           | list   | `[]`                                   |             |
| networkPolicy.extraIngress                          | list   | `[]`                                   |             |
| networkPolicy.ingressNSMatchLabels                  | object | `{}`                                   |             |
| networkPolicy.ingressNSPodMatchLabels               | object | `{}`                                   |             |
| nodeAffinityPreset.key                              | string | `""`                                   |             |
| nodeAffinityPreset.type                             | string | `""`                                   |             |
| nodeAffinityPreset.values                           | list   | `[]`                                   |             |
| nodeSelector                                        | object | `{}`                                   |             |
| pdb.create                                          | bool   | `true`                                 |             |
| pdb.maxUnavailable                                  | string | `""`                                   |             |
| pdb.minAvailable                                    | string | `""`                                   |             |
| podAffinityPreset                                   | string | `""`                                   |             |
| podAnnotations                                      | object | `{}`                                   |             |
| podAntiAffinityPreset                               | string | `"soft"`                               |             |
| podLabels                                           | object | `{}`                                   |             |
| podSecurityContext.enabled                          | bool   | `true`                                 |             |
| podSecurityContext.fsGroup                          | int    | `1001`                                 |             |
| podSecurityContext.fsGroupChangePolicy              | string | `"Always"`                             |             |
| podSecurityContext.supplementalGroups               | list   | `[]`                                   |             |
| podSecurityContext.sysctls                          | list   | `[]`                                   |             |
| priorityClassName                                   | string | `""`                                   |             |
| readinessProbe.enabled                              | bool   | `true`                                 |             |
| readinessProbe.failureThreshold                     | int    | `3`                                    |             |
| readinessProbe.initialDelaySeconds                  | int    | `5`                                    |             |
| readinessProbe.path                                 | string | `"/"`                                  |             |
| readinessProbe.periodSeconds                        | int    | `5`                                    |             |
| readinessProbe.successThreshold                     | int    | `1`                                    |             |
| readinessProbe.timeoutSeconds                       | int    | `3`                                    |             |
| replicaCount                                        | int    | `1`                                    |             |
| resources                                           | object | `{}`                                   |             |
| resourcesPreset                                     | string | `"nano"`                               |             |
| revisionHistoryLimit                                | int    | `10`                                   |             |
| schedulerName                                       | string | `""`                                   |             |
| serverBlock                                         | string | `""`                                   |             |
| service.annotations                                 | object | `{}`                                   |             |
| service.clusterIP                                   | string | `""`                                   |             |
| service.externalTrafficPolicy                       | string | `"Cluster"`                            |             |
| service.extraPorts                                  | list   | `[]`                                   |             |
| service.loadBalancerClass                           | string | `""`                                   |             |
| service.loadBalancerIP                              | string | `""`                                   |             |
| service.loadBalancerSourceRanges                    | list   | `[]`                                   |             |
| service.nodePorts.http                              | string | `""`                                   |             |
| service.nodePorts.https                             | string | `""`                                   |             |
| service.ports.http                                  | int    | `80`                                   |             |
| service.ports.https                                 | int    | `443`                                  |             |
| service.sessionAffinity                             | string | `"None"`                               |             |
| service.sessionAffinityConfig                       | object | `{}`                                   |             |
| service.targetPort.http                             | string | `"http"`                               |             |
| service.targetPort.https                            | string | `"https"`                              |             |
| service.type                                        | string | `"LoadBalancer"`                       |             |
| serviceAccount.annotations                          | object | `{}`                                   |             |
| serviceAccount.automountServiceAccountToken         | bool   | `false`                                |             |
| serviceAccount.create                               | bool   | `true`                                 |             |
| serviceAccount.name                                 | string | `""`                                   |             |
| sidecarSingleProcessNamespace                       | bool   | `false`                                |             |
| sidecars                                            | list   | `[]`                                   |             |
| startupProbe.enabled                                | bool   | `false`                                |             |
| startupProbe.failureThreshold                       | int    | `6`                                    |             |
| startupProbe.initialDelaySeconds                    | int    | `30`                                   |             |
| startupProbe.periodSeconds                          | int    | `10`                                   |             |
| startupProbe.successThreshold                       | int    | `1`                                    |             |
| startupProbe.timeoutSeconds                         | int    | `5`                                    |             |
| staticSiteConfigmap                                 | string | `""`                                   |             |
| staticSitePVC                                       | string | `""`                                   |             |
| streamServerBlock                                   | string | `""`                                   |             |
| terminationGracePeriodSeconds                       | string | `""`                                   |             |
| tls.autoGenerated                                   | bool   | `true`                                 |             |
| tls.ca                                              | string | `""`                                   |             |
| tls.cert                                            | string | `""`                                   |             |
| tls.certCAFilename                                  | string | `"ca.crt"`                             |             |
| tls.certFilename                                    | string | `"tls.crt"`                            |             |
| tls.certKeyFilename                                 | string | `"tls.key"`                            |             |
| tls.enabled                                         | bool   | `true`                                 |             |
| tls.existingSecret                                  | string | `""`                                   |             |
| tls.key                                             | string | `""`                                   |             |
| tolerations                                         | list   | `[]`                                   |             |
| topologySpreadConstraints                           | list   | `[]`                                   |             |
| updateStrategy.rollingUpdate                        | object | `{}`                                   |             |
| updateStrategy.type                                 | string | `"RollingUpdate"`                      |             |

---

Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
