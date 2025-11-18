# Mealie Helm Chart

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square)
![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

## Introduction

This chart bootstraps a [Mealie](https://mealie.io/) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

Mealie is a self-hosted recipe manager and meal planner with a REST API and a reactive frontend application built in Vue.

## Features

- **Recipe Management**: Store and organize your recipes
- **Meal Planning**: Plan your meals for the week
- **Shopping Lists**: Generate shopping lists from recipes
- **REST API**: Full-featured API for integrations
- **Multi-user Support**: Family-friendly with user management
- **Recipe Import**: Import from various sources
- **Mobile Responsive**: Works great on mobile devices

## Quick Start

To deploy Mealie using this Helm chart, follow these steps:

```console
$ helm repo add codefuturist https://codefuturist.github.io/helm-charts
$ helm repo update
$ helm install mealie codefuturist/mealie
```

This will deploy Mealie with the default configuration. See the [Configuration](#configuration) section for details on customizing the deployment.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `mealie` deployment:

```console
$ helm delete mealie
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.0+
- PersistentVolume support (optional, for data persistence)

## Configuration

The following table lists the configurable parameters and their default values.

| Parameter | Description | Default |
|-----------|-------------|---------|
| `namespaceOverride` | Override namespace | `""` |
| `deployment.enabled` | Enable deployment | `true` |
| `deployment.replicas` | Number of replicas | `1` |
| `service.type` | Service type | `ClusterIP` |
| `ingress.enabled` | Enable ingress | `false` |

## Examples

### Minimal Configuration

```yaml
deployment:
  enabled: true
  replicas: 1
```

### Production Configuration

```yaml
deployment:
  enabled: true
  replicas: 3
  resources:
    requests:
      memory: "256Mi"
      cpu: "100m"
    limits:
      memory: "512Mi"
      cpu: "500m"

ingress:
  enabled: true
  hosts:
    - host: example.com
      paths:
        - path: /
          pathType: Prefix
```

## Upgrading

To upgrade to a new version:

```bash
helm repo update
helm upgrade mealie codefuturist/mealie
```

## Documentation

- [Mealie Official Documentation](https://mealie.io/)
- [Examples](examples/) - Ready-to-use configuration files

## Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](../../docs/CONTRIBUTING.md) for details.

## Support

- **Issues**: [GitHub Issues](https://github.com/codefuturist/helm-charts/issues)
- **Discussions**: [GitHub Discussions](https://github.com/codefuturist/helm-charts/discussions)

## License

This Helm chart is licensed under the Apache License 2.0. See [LICENSE](../../LICENSE) for details.

## Maintainers

| Name | Email |
| ---- | ------ |
| codefuturist | <58808821+codefuturist@users.noreply.github.com> |

## Source Code

- **Chart Repository**: <https://github.com/codefuturist/helm-charts>
- **Mealie Repository**: <https://github.com/mealie-recipes/mealie>
