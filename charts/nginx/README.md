# nginx

Helm chart for deploying NGINX web server with customizable configuration

## Prerequisites

- Kubernetes 1.26+
- Helm 3.8+

## Installing the Chart

```bash
helm install nginx ./charts/nginx
```

## Uninstalling the Chart

```bash
helm uninstall nginx
```

## Parameters

See [values.yaml](values.yaml) for the full list of configurable parameters.

### General Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `nameOverride` | Override the chart name | `""` |
| `fullnameOverride` | Override the full name | `""` |
| `replicaCount` | Number of replicas | `3` |

### Image Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `image.repository` | Container image repository | `nginx` |
| `image.pullPolicy` | Image pull policy | `IfNotPresent` |
| `image.tag` | Image tag (defaults to appVersion) | `""` |

### Service Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `service.type` | Service type | `ClusterIP` |
| `service.port` | Service port | `80` |

---

> This chart was generated with [Copier](https://copier.readthedocs.io/).
> Run `copier update` to pull in template improvements.
