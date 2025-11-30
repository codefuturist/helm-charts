# bitwarden-eso-provider

![Version: 1.0.2](https://img.shields.io/badge/Version-1.0.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

A Bitwarden webhook provider for External Secrets Operator that works with personal/organizational vaults using the Bitwarden CLI

**Homepage:** <https://github.com/codefuturist/helm-charts>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| codefuturist | <58808821+codefuturist@users.noreply.github.com> |  |

## Source Code

* <https://github.com/codefuturist/helm-charts>
* <https://github.com/codefuturist/helm-charts/tree/main/apps/bitwarden-eso-provider-app>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://../../libs/common | common | 2.x.x |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| externalSecretsOperator.createClusterSecretStore | bool | `true` | Create ClusterSecretStore resource |
| externalSecretsOperator.namespaced | bool | `false` | Create namespaced SecretStore (if false, creates ClusterSecretStore) |
| externalSecretsOperator.secretStore.name | string | `"bitwarden"` | SecretStore/ClusterSecretStore name |
| externalSecretsOperator.secretStore.annotations | object | `{}` | Additional annotations |
| externalSecretsOperator.secretStore.labels | object | `{}` | Additional labels |
| networkPolicy.enabled | bool | `false` | Enable network policy |
| networkPolicy.ingress | list | `[{"from":[{"namespaceSelector":{}}]}]` | Ingress rules |
| networkPolicy.egress | list | `[{"ports":[{"port":443,"protocol":"TCP"}],"to":[{"namespaceSelector":{}}]},{"ports":[{"port":53,"protocol":"TCP"},{"port":53,"protocol":"UDP"}],"to":[{"namespaceSelector":{}}]}]` | Egress rules (allow Bitwarden API) |
| metrics.enabled | bool | `false` | Enable Prometheus metrics endpoint |
| metrics.serviceMonitor.enabled | bool | `false` | Create ServiceMonitor resource (requires Prometheus Operator) |
| metrics.serviceMonitor.annotations | object | `{}` | ServiceMonitor annotations |
| metrics.serviceMonitor.labels | object | `{}` | Additional ServiceMonitor labels |
| metrics.serviceMonitor.interval | string | `"30s"` | Scrape interval |
| metrics.serviceMonitor.scrapeTimeout | string | `nil` | Scrape timeout |
| metrics.serviceMonitor.relabelings | list | `[]` | Relabelings for ServiceMonitor |
| metrics.serviceMonitor.metricRelabelings | list | `[]` | Metric relabelings for ServiceMonitor |
