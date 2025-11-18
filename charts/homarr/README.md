# Homarr Helm Chart

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square)
![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)
![AppVersion: latest](https://img.shields.io/badge/AppVersion-latest-informational?style=flat-square)

## Introduction

This chart bootstraps a [Homarr](https://homarr.dev) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

Homarr is a sleek, modern dashboard that brings all of your services together in one place. It integrates with the services you use to display useful information or control them.

## Features

- **Quick Setup**: Get started in minutes
- **Service Integration**: Connect to your favorite services
- **Customizable Layout**: Arrange widgets and tiles to your liking
- **Search Functionality**: Quickly find what you need
- **Mobile Responsive**: Works seamlessly on mobile devices
- **Dark Mode**: Built-in dark theme support
- **Authentication**: Secure access with user management
- **Docker Widgets**: Monitor Docker containers
- **System Monitoring**: Keep track of system resources

## Quick Start

To deploy Homarr using this Helm chart, follow these steps:

```console
$ helm repo add codefuturist https://codefuturist.github.io/helm-charts
$ helm repo update
$ helm install homarr codefuturist/homarr
```

This will deploy Homarr with the default configuration. See the [Configuration](#configuration) section for details on customizing the deployment.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `homarr` deployment:

```console
$ helm delete homarr
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.2.0+
- PersistentVolume support (optional, for data persistence)

## Configuration

The following table lists the configurable parameters of the Homarr chart and their default values.

See [values.yaml](values.yaml) for the full list of parameters.

### Basic Configuration Example

```yaml
deployment:
  image:
    repository: ghcr.io/homarr-labs/homarr
    tag: "latest"
  env:
    SECRET_ENCRYPTION_KEY:
      value: "YOUR_64_CHAR_HEX_STRING_HERE"
    LOG_LEVEL:
      value: "info"
    DB_DRIVER:
      value: "better-sqlite3"
    DB_DIALECT:
      value: "sqlite"
    DB_URL:
      value: "/appdata/db/db.sqlite"

persistence:
  enabled: true
  storageSize: 2Gi

ingress:
  enabled: true
  ingressClassName: nginx
  hosts:
    - host: homarr.example.com
      paths:
        - path: /
          pathType: Prefix
  tls:
    - secretName: homarr-tls
      hosts:
        - homarr.example.com
```

### Advanced Configuration Example

```yaml
deployment:
  image:
    repository: ghcr.io/homarr-labs/homarr
    tag: "latest"
  replicas: 2
  env:
    # Security (REQUIRED)
    SECRET_ENCRYPTION_KEY:
      valueFrom:
        secretKeyRef:
          name: homarr-secret
          key: encryption-key
    # General
    LOG_LEVEL:
      value: "info"
    PUID:
      value: "1000"
    PGID:
      value: "1000"
    # Docker Integration
    DOCKER_HOSTNAMES:
      value: "localhost"
    DOCKER_PORTS:
      value: "2375"
    # Database (MySQL example)
    DB_DRIVER:
      value: "mysql2"
    DB_DIALECT:
      value: "mysql"
    DB_HOST:
      value: "mysql.database.svc.cluster.local"
    DB_PORT:
      value: "3306"
    DB_NAME:
      value: "homarr"
    DB_USER:
      valueFrom:
        secretKeyRef:
          name: homarr-db-secret
          key: username
    DB_PASSWORD:
      valueFrom:
        secretKeyRef:
          name: homarr-db-secret
          key: password
    # External Redis
    REDIS_IS_EXTERNAL:
      value: "true"
    REDIS_HOST:
      value: "redis.cache.svc.cluster.local"
    REDIS_PORT:
      value: "6379"
    REDIS_PASSWORD:
      valueFrom:
        secretKeyRef:
          name: homarr-redis-secret
          key: password
  # Docker socket integration
  volumes:
    docker-socket:
      hostPath:
        path: /var/run/docker.sock
        type: Socket
  volumeMounts:
    docker-socket:
      mountPath: /var/run/docker.sock
      readOnly: true
  resources:
    limits:
      memory: 1Gi
      cpu: 1000m
    requests:
      memory: 512Mi
      cpu: 200m

persistence:
  enabled: true
  storageSize: 5Gi
  storageClass: fast-ssd

ingress:
  enabled: true
  ingressClassName: nginx
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt-prod
  hosts:
    - host: homarr.example.com
      paths:
        - path: /
          pathType: Prefix
  tls:
    - secretName: homarr-tls
      hosts:
        - homarr.example.com

autoscaling:
  enabled: true
  minReplicas: 2
  maxReplicas: 5
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 70

networkPolicy:
  enabled: true
  ingress:
    - from:
        - namespaceSelector:
            matchLabels:
              name: ingress-nginx
```

## Parameters

### Global Parameters

| Name | Description | Value |
| ---- | ----------- | ----- |
| `namespaceOverride` | Override the namespace for all resources | `""` |
| `applicationName` | Application name | `""` (defaults to chart name) |
| `additionalLabels` | Additional labels for all resources | `{}` |

### Deployment Parameters

| Name | Description | Value |
| ---- | ----------- | ----- |
| `deployment.enabled` | Enable Deployment | `true` |
| `deployment.replicas` | Number of replicas | `1` |
| `deployment.image.repository` | Image repository | `ghcr.io/homarr-labs/homarr` |
| `deployment.image.tag` | Image tag | `latest` |
| `deployment.image.pullPolicy` | Image pull policy | `IfNotPresent` |
| `deployment.resources.limits.memory` | Memory limit | `512Mi` |
| `deployment.resources.limits.cpu` | CPU limit | `500m` |
| `deployment.resources.requests.memory` | Memory request | `256Mi` |
| `deployment.resources.requests.cpu` | CPU request | `100m` |
| `deployment.readinessProbe.enabled` | Enable readiness probe | `true` |
| `deployment.livenessProbe.enabled` | Enable liveness probe | `true` |

### Persistence Parameters

| Name | Description | Value |
| ---- | ----------- | ----- |
| `persistence.enabled` | Enable persistence | `true` |
| `persistence.mountPVC` | Mount PVC to deployment | `true` |
| `persistence.mountPath` | Mount path for volume | `/appdata` |
| `persistence.storageSize` | Size of persistent volume | `1Gi` |
| `persistence.storageClass` | Storage class for volume | `nil` |
| `persistence.accessMode` | Access mode for volume | `ReadWriteOnce` |

### Service Parameters

| Name | Description | Value |
| ---- | ----------- | ----- |
| `service.enabled` | Enable Service | `true` |
| `service.type` | Service type | `ClusterIP` |
| `service.ports[0].port` | Service port | `7575` |
| `service.ports[0].name` | Port name | `http` |

### Ingress Parameters

| Name | Description | Value |
| ---- | ----------- | ----- |
| `ingress.enabled` | Enable Ingress | `false` |
| `ingress.ingressClassName` | Ingress class name | `""` |
| `ingress.hosts[0].host` | Hostname | `homarr.local` |
| `ingress.hosts[0].paths[0].path` | Path | `/` |
| `ingress.hosts[0].paths[0].pathType` | Path type | `Prefix` |
| `ingress.tls` | TLS configuration | `[]` |

### Autoscaling Parameters

| Name | Description | Value |
| ---- | ----------- | ----- |
| `autoscaling.enabled` | Enable HPA | `false` |
| `autoscaling.minReplicas` | Minimum replicas | `1` |
| `autoscaling.maxReplicas` | Maximum replicas | `10` |

### RBAC Parameters

| Name | Description | Value |
| ---- | ----------- | ----- |
| `rbac.enabled` | Enable RBAC | `true` |
| `rbac.serviceAccount.enabled` | Create ServiceAccount | `true` |
| `rbac.serviceAccount.name` | ServiceAccount name | `""` (auto-generated) |

## Persistence

Homarr requires persistent storage for its configuration and data. By default, the chart creates a PersistentVolumeClaim with 1Gi of storage.

The data is mounted at `/appdata` in the container, which stores:
* Database files (SQLite by default)
* Configuration files
* Icons and assets
* User data

### Using Existing PersistentVolumeClaim

If you want to use an existing PVC:

```yaml
persistence:
  enabled: true
  name: my-existing-pvc
```

## Environment Variables

Homarr can be configured using environment variables. See the [official documentation](https://homarr.dev/docs/getting-started/installation) for more details.

### Security (Required)

* `SECRET_ENCRYPTION_KEY`: 64-character hex string used to encrypt secrets in database (required)
  * Generate with: `openssl rand -hex 32`
  * **Must be set before first startup**

### General Configuration

* `PUID`: User ID to run the container as (default: 0)
* `PGID`: Group ID to run the container as (default: 0)
* `LOG_LEVEL`: Log level (debug/info/warn/error, default: info)
* `NO_EXTERNAL_CONNECTION`: Disable requests requiring internet (true/false, default: false)
* `ENABLE_DNS_CACHING`: Enable DNS caching (true/false, default: false)

### Docker Integration

* `DOCKER_HOSTNAMES`: Comma-separated list of Docker hostnames
* `DOCKER_PORTS`: Comma-separated list of Docker ports

To enable Docker integration, mount the Docker socket:

```yaml
deployment:
  volumes:
    docker-socket:
      hostPath:
        path: /var/run/docker.sock
        type: Socket
  volumeMounts:
    docker-socket:
      mountPath: /var/run/docker.sock
      readOnly: true
```

### Database Configuration

* `DB_DRIVER`: Database driver (better-sqlite3/mysql2/node-postgres, default: better-sqlite3)
* `DB_DIALECT`: Database dialect (sqlite/mysql/postgresql, default: sqlite)
* `DB_URL`: Database connection URL
* `DB_HOST`: Database host
* `DB_PORT`: Database port
* `DB_NAME`: Database name
* `DB_USER`: Database username
* `DB_PASSWORD`: Database password

### Redis Configuration

* `REDIS_IS_EXTERNAL`: Use external Redis (true/false, default: false)
* `REDIS_HOST`: Redis hostname
* `REDIS_PORT`: Redis port (default: 6379)
* `REDIS_USERNAME`: Redis username
* `REDIS_PASSWORD`: Redis password
* `REDIS_DATABASE_INDEX`: Redis database index
* `REDIS_TLS_CA`: CA certificate for Redis TLS connections

Example:

```yaml
deployment:
  env:
    SECRET_ENCRYPTION_KEY:
      valueFrom:
        secretKeyRef:
          name: homarr-secret
          key: encryption-key
    LOG_LEVEL:
      value: "info"
    DB_DRIVER:
      value: "mysql2"
    DB_DIALECT:
      value: "mysql"
    DB_HOST:
      value: "mysql-host"
    DB_NAME:
      value: "homarr"
    DB_USER:
      valueFrom:
        secretKeyRef:
          name: homarr-db-secret
          key: username
    DB_PASSWORD:
      valueFrom:
        secretKeyRef:
          name: homarr-db-secret
          key: password
```

## Upgrading

### To 1.0.0

Initial release of the Homarr Helm chart.

## Troubleshooting

### Pod fails to start

Check the logs:

```bash
kubectl logs -l app.kubernetes.io/name=homarr
```

### Persistence issues

Verify the PVC is bound:

```bash
kubectl get pvc
```

### Ingress not working

Verify the ingress controller is installed and the ingress resource is created:

```bash
kubectl get ingress
kubectl describe ingress homarr
```

## Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](../../docs/CONTRIBUTING.md) for details.

## Support

- **Issues**: [GitHub Issues](https://github.com/codefuturist/helm-charts/issues)
- **Discussions**: [GitHub Discussions](https://github.com/codefuturist/helm-charts/discussions)
- **Homarr Documentation**: [homarr.dev](https://homarr.dev)

## License

This Helm chart is licensed under the Apache License 2.0. See [LICENSE](../../LICENSE) for details.

## Maintainers

| Name | Email |
| ---- | ------ |
| codefuturist | <58808821+codefuturist@users.noreply.github.com> |

## Source Code

- **Chart Repository**: <https://github.com/codefuturist/helm-charts>
- **Homarr Repository**: <https://github.com/homarr-labs/homarr>
