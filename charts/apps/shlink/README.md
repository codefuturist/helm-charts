# shlink

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 4.2.4](https://img.shields.io/badge/AppVersion-4.2.4-informational?style=flat-square)

A production-ready Helm chart for Shlink - Self-hosted URL shortener with analytics and web UI

**Homepage:** <https://shlink.io/>

## Maintainers

| Name         | Email                                            | Url |
| ------------ | ------------------------------------------------ | --- |
| codefuturist | <58808821+codefuturist@users.noreply.github.com> |     |

## Source Code

- <https://github.com/shlinkio/shlink>
- <https://github.com/shlinkio/shlink-web-client>
- <https://github.com/codefuturist/helm-charts>

## Requirements

| Repository                         | Name       | Version |
| ---------------------------------- | ---------- | ------- |
| file://../../libs/common           | common     | 2.x.x   |
| https://charts.bitnami.com/bitnami | postgresql | ~16.2.0 |

## Values

| Key                                | Type   | Default                                                                                                                                                                                                                                   | Description                                                                                                          |
| ---------------------------------- | ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| diagnosticMode.args                | list   | `["infinity"]`                                                                                                                                                                                                                            | Arguments for diagnostic mode command                                                                                |
| diagnosticMode.command             | list   | `["sleep"]`                                                                                                                                                                                                                               | Command to run in diagnostic mode                                                                                    |
| diagnosticMode.enabled             | bool   | `false`                                                                                                                                                                                                                                   | Enable diagnostic mode (sleep infinity instead of running application)                                               |
| podDisruptionBudget.enabled        | bool   | `false`                                                                                                                                                                                                                                   | Enable Pod Disruption Budget                                                                                         |
| podDisruptionBudget.maxUnavailable | string | `""`                                                                                                                                                                                                                                      | Maximum unavailable pods (alternative to minAvailable)                                                               |
| podDisruptionBudget.minAvailable   | int    | `1`                                                                                                                                                                                                                                       | Minimum available pods                                                                                               |
| postgresql                         | object | `{"architecture":"standalone","auth":{"database":"shlink","existingSecret":"","password":"changeme","username":"shlink"},"enabled":true,"image":{"tag":"latest"},"primary":{"persistence":{"enabled":true,"size":"8Gi"},"resources":{}}}` | PostgreSQL subchart configuration See https://github.com/bitnami/charts/tree/main/bitnami/postgresql for all options |
| postgresql.architecture            | string | `"standalone"`                                                                                                                                                                                                                            | PostgreSQL architecture (standalone or replication)                                                                  |
| postgresql.auth                    | object | `{"database":"shlink","existingSecret":"","password":"changeme","username":"shlink"}`                                                                                                                                                     | PostgreSQL authentication configuration                                                                              |
| postgresql.auth.database           | string | `"shlink"`                                                                                                                                                                                                                                | PostgreSQL database name                                                                                             |
| postgresql.auth.existingSecret     | string | `""`                                                                                                                                                                                                                                      | Existing secret with PostgreSQL credentials                                                                          |
| postgresql.auth.password           | string | `"changeme"`                                                                                                                                                                                                                              | PostgreSQL password                                                                                                  |
| postgresql.auth.username           | string | `"shlink"`                                                                                                                                                                                                                                | PostgreSQL username                                                                                                  |
| postgresql.enabled                 | bool   | `true`                                                                                                                                                                                                                                    | Enable PostgreSQL subchart                                                                                           |
| postgresql.image                   | object | `{"tag":"latest"}`                                                                                                                                                                                                                        | PostgreSQL image configuration Override to use available image tag                                                   |
| postgresql.primary                 | object | `{"persistence":{"enabled":true,"size":"8Gi"},"resources":{}}`                                                                                                                                                                            | PostgreSQL primary configuration                                                                                     |
| postgresql.primary.persistence     | object | `{"enabled":true,"size":"8Gi"}`                                                                                                                                                                                                           | Persistence configuration for primary                                                                                |
| postgresql.primary.resources       | object | `{}`                                                                                                                                                                                                                                      | Resource limits for primary                                                                                          |

---

Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
