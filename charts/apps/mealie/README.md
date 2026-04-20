# mealie

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 3.5.0](https://img.shields.io/badge/AppVersion-3.5.0-informational?style=flat-square)

A Helm chart for mealie

**Homepage:** <https://mealie.io>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| codefuturist | <58808821+codefuturist@users.noreply.github.com> |  |

## Source Code

* <https://github.com/mealie-recipes/mealie>
* <https://github.com/codefuturist/helm-charts>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://../../libs/common | common | 2.x.x |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalLabels | object | `{}` |  |
| applicationName | string | `""` |  |
| componentOverride | string | `""` |  |
| configMap.data | object | `{}` |  |
| configMap.enabled | bool | `false` |  |
| database.engine | string | `"postgres"` |  |
| database.host | string | `""` |  |
| database.name | string | `"mealie"` |  |
| database.password | string | `"mealie"` |  |
| database.port | string | `"5432"` |  |
| database.sqliteWalMode | bool | `false` |  |
| database.user | string | `"mealie"` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts | list | `[]` |  |
| ingress.tls | list | `[]` |  |
| mealie.additionalLabels | object | `{}` |  |
| mealie.additionalPodAnnotations | object | `{}` |  |
| mealie.affinity | object | `{}` |  |
| mealie.annotations | object | `{}` |  |
| mealie.autoscaling.enabled | bool | `false` |  |
| mealie.autoscaling.maxReplicas | int | `10` |  |
| mealie.autoscaling.minReplicas | int | `1` |  |
| mealie.autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| mealie.enabled | bool | `true` |  |
| mealie.env.ALLOW_SIGNUP.value | string | `"false"` |  |
| mealie.env.BASE_URL.value | string | `"https://mealie.yourdomain.com"` |  |
| mealie.env.PGID.value | string | `"1000"` |  |
| mealie.env.PUID.value | string | `"1000"` |  |
| mealie.env.TZ.value | string | `"America/Anchorage"` |  |
| mealie.image.digest | string | `""` |  |
| mealie.image.imagePullPolicy | string | `"IfNotPresent"` |  |
| mealie.image.repository | string | `"ghcr.io/mealie-recipes/mealie"` |  |
| mealie.image.tag | string | `"v3.4.0"` |  |
| mealie.imagePullSecrets | list | `[]` |  |
| mealie.livenessProbe.failureThreshold | int | `3` |  |
| mealie.livenessProbe.httpGet.path | string | `"/api/app/about"` |  |
| mealie.livenessProbe.httpGet.port | int | `9000` |  |
| mealie.livenessProbe.initialDelaySeconds | int | `30` |  |
| mealie.livenessProbe.periodSeconds | int | `10` |  |
| mealie.livenessProbe.timeoutSeconds | int | `5` |  |
| mealie.logging.config | object | `{}` |  |
| mealie.logging.configPath | string | `"/app/logging-config.yaml"` |  |
| mealie.logging.enabled | bool | `false` |  |
| mealie.nodeSelector | object | `{}` |  |
| mealie.podLabels | object | `{}` |  |
| mealie.ports[0].containerPort | int | `9000` |  |
| mealie.ports[0].name | string | `"port-9000"` |  |
| mealie.ports[0].protocol | string | `"TCP"` |  |
| mealie.readinessProbe.failureThreshold | int | `3` |  |
| mealie.readinessProbe.httpGet.path | string | `"/api/app/about"` |  |
| mealie.readinessProbe.httpGet.port | int | `9000` |  |
| mealie.readinessProbe.initialDelaySeconds | int | `10` |  |
| mealie.readinessProbe.periodSeconds | int | `5` |  |
| mealie.readinessProbe.timeoutSeconds | int | `3` |  |
| mealie.reloadOnChange | bool | `true` |  |
| mealie.replicas | int | `1` |  |
| mealie.resources.limits | object | `{}` |  |
| mealie.resources.requests.cpu | string | `"10m"` |  |
| mealie.resources.requests.memory | string | `"64Mi"` |  |
| mealie.strategy.type | string | `"RollingUpdate"` |  |
| mealie.tolerations | list | `[]` |  |
| mealie.topologySpreadConstraints | list | `[]` |  |
| mealie.volumes[0].mountPath | string | `"/app/data/"` |  |
| mealie.volumes[0].name | string | `"mealie-data"` |  |
| mealie.volumes[0].readOnly | bool | `false` |  |
| mealie.volumes[0].type | string | `"persistentVolumeClaim"` |  |
| namespaceOverride | string | `""` |  |
| partOfOverride | string | `""` |  |
| persistence.mealie-data.accessModes[0] | string | `"ReadWriteOnce"` |  |
| persistence.mealie-data.annotations | object | `{}` |  |
| persistence.mealie-data.enabled | bool | `true` |  |
| persistence.mealie-data.size | string | `"10Gi"` |  |
| persistence.mealie-data.storageClass | string | `""` |  |
| persistence.mealie-pgdata.accessModes[0] | string | `"ReadWriteOnce"` |  |
| persistence.mealie-pgdata.annotations | object | `{}` |  |
| persistence.mealie-pgdata.enabled | bool | `false` |  |
| persistence.mealie-pgdata.size | string | `"10Gi"` |  |
| persistence.mealie-pgdata.storageClass | string | `""` |  |
| postgres.additionalLabels | object | `{}` |  |
| postgres.additionalPodAnnotations | object | `{}` |  |
| postgres.affinity | object | `{}` |  |
| postgres.annotations | object | `{}` |  |
| postgres.autoscaling.enabled | bool | `false` |  |
| postgres.autoscaling.maxReplicas | int | `10` |  |
| postgres.autoscaling.minReplicas | int | `1` |  |
| postgres.autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| postgres.enabled | bool | `false` |  |
| postgres.env.PGUSER.value | string | `"mealie"` |  |
| postgres.env.POSTGRES_DB.value | string | `"mealie"` |  |
| postgres.env.POSTGRES_PASSWORD.value | string | `"mealie"` |  |
| postgres.env.POSTGRES_USER.value | string | `"mealie"` |  |
| postgres.image.digest | string | `""` |  |
| postgres.image.imagePullPolicy | string | `"IfNotPresent"` |  |
| postgres.image.repository | string | `"postgres"` |  |
| postgres.image.tag | string | `"17"` |  |
| postgres.imagePullSecrets | list | `[]` |  |
| postgres.livenessProbe.exec.command[0] | string | `"pg_isready"` |  |
| postgres.livenessProbe.exec.command[1] | string | `"-U"` |  |
| postgres.livenessProbe.exec.command[2] | string | `"mealie"` |  |
| postgres.livenessProbe.failureThreshold | int | `3` |  |
| postgres.livenessProbe.initialDelaySeconds | int | `30` |  |
| postgres.livenessProbe.periodSeconds | int | `30` |  |
| postgres.livenessProbe.timeoutSeconds | int | `20` |  |
| postgres.nodeSelector | object | `{}` |  |
| postgres.podLabels | object | `{}` |  |
| postgres.ports[0].containerPort | int | `5432` |  |
| postgres.ports[0].name | string | `"postgresql"` |  |
| postgres.ports[0].protocol | string | `"TCP"` |  |
| postgres.readinessProbe.exec.command[0] | string | `"pg_isready"` |  |
| postgres.readinessProbe.exec.command[1] | string | `"-U"` |  |
| postgres.readinessProbe.exec.command[2] | string | `"mealie"` |  |
| postgres.readinessProbe.failureThreshold | int | `3` |  |
| postgres.readinessProbe.initialDelaySeconds | int | `5` |  |
| postgres.readinessProbe.periodSeconds | int | `10` |  |
| postgres.readinessProbe.timeoutSeconds | int | `5` |  |
| postgres.reloadOnChange | bool | `true` |  |
| postgres.replicas | int | `1` |  |
| postgres.resources.limits | object | `{}` |  |
| postgres.resources.requests.cpu | string | `"10m"` |  |
| postgres.resources.requests.memory | string | `"64Mi"` |  |
| postgres.strategy.type | string | `"RollingUpdate"` |  |
| postgres.tolerations | list | `[]` |  |
| postgres.topologySpreadConstraints | list | `[]` |  |
| postgres.volumes[0].mountPath | string | `"/var/lib/postgresql/data"` |  |
| postgres.volumes[0].name | string | `"mealie-pgdata"` |  |
| postgres.volumes[0].readOnly | bool | `false` |  |
| postgres.volumes[0].subPath | string | `"pgdata"` |  |
| postgres.volumes[0].type | string | `"persistentVolumeClaim"` |  |
| secret.data | object | `{}` |  |
| secret.enabled | bool | `false` |  |
| service.annotations | object | `{}` |  |
| service.port | int | `80` |  |
| service.type | string | `"ClusterIP"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
