# MongoDB Compass Web Helm Chart

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square)
![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)
![AppVersion: 0.3.1](https://img.shields.io/badge/AppVersion-0.3.1-informational?style=flat-square)

## Introduction

This chart bootstraps a [MongoDB Compass Web](https://github.com/haohanyang/compass-web) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

MongoDB Compass Web is a web-based port of MongoDB Compass, providing an easy way to view and interact with your MongoDB databases from a browser, while keeping most of the MongoDB Compass features.

## Features

- **Easy Installation**: Get started with minimal configuration
- **Security First**: Hardened security contexts, network policies, and RBAC
- **Production Ready**: Persistent storage, resource limits, health probes
- **Flexible Configuration**: Support for both inline and existing secrets
- **Basic Authentication**: Optional HTTP basic auth protection
- **GenAI Integration**: Support for OpenAI-powered query generation
- **Ingress Support**: Expose via any ingress controller with TLS
- **Monitoring Ready**: ServiceMonitor and PrometheusRule for Prometheus Operator
- **High Availability**: Pod disruption budgets, HPA, and anti-affinity
- **Flexible Deployment**: Deployment or StatefulSet controller options
- **Extensibility**: Extra containers, init containers, volumes, and environment variables

## Quick Start

To deploy MongoDB Compass Web using this Helm chart, follow these steps:

```console
$ helm repo add codefuturist https://codefuturist.github.io/helm-charts
$ helm repo update
$ helm install my-compass-web codefuturist/compass-web \
  --set compassWeb.mongoUri="mongodb://mongodb:27017"
```

This will deploy Compass Web with the default configuration. See the [Configuration](#configuration) section for details on customizing the deployment.

> **Tip**: List all releases using `helm list`

## Prerequisites

- Kubernetes 1.19+
- Helm 3.2.0+
- A MongoDB instance (local or remote)

## Installing the Chart

To install the chart with the release name `my-compass-web`:

```console
$ helm install my-compass-web codefuturist/compass-web \
  --set compassWeb.mongoUri="mongodb://mongodb:27017"
```

The command deploys Compass Web on the Kubernetes cluster with the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-compass-web` deployment:

```console
$ helm delete my-compass-web
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

### MongoDB Connection

The most important configuration is the MongoDB connection string:

```yaml
compassWeb:
  mongoUri: "mongodb://username:password@mongodb:27017/database?authSource=admin"
```

You can also use multiple connection strings:

```yaml
compassWeb:
  mongoUri: "mongodb://localhost:27017 mongodb+srv://user:pass@cluster.mongodb.net/"
```

### Using Existing Secrets

Instead of providing the MongoDB URI in values, you can use an existing secret:

```yaml
compassWeb:
  existingSecret: "my-mongo-secret"
  existingSecretKey: "mongoUri"
```

### Basic Authentication

Enable HTTP basic authentication to protect access:

```yaml
compassWeb:
  basicAuth:
    enabled: true
    username: "admin"
    password: "SuperSecurePassword123"
```

### GenAI Features

Enable OpenAI-powered query generation:

```yaml
compassWeb:
  genAI:
    enabled: true
    apiKey: "sk-..."
    model: "gpt-4o-mini"
    enableSampleDocuments: false
```

### Ingress

Expose Compass Web via Ingress:

```yaml
ingress:
  enabled: true
  className: "nginx"
  annotations:
    cert-manager.io/cluster-issuer: "letsencrypt-prod"
  hosts:
    - host: compass.example.com
      paths:
        - path: /
          pathType: Prefix
  tls:
    - secretName: compass-tls
      hosts:
        - compass.example.com
```

### Persistence

Enable persistent storage for user preferences (optional):

```yaml
persistence:
  enabled: true
  size: 1Gi
  storageClassName: "fast-ssd"
```

### Resources

Configure resource limits and requests:

```yaml
resources:
  limits:
    cpu: 1000m
    memory: 512Mi
  requests:
    cpu: 100m
    memory: 256Mi
```

## Parameters

### Global Parameters

| Name | Description | Value |
| --- | --- | --- |
| `namespaceOverride` | Override the namespace for all resources | `""` |
| `nameOverride` | Override the name of the chart | `""` |
| `fullnameOverride` | Override the full name of the chart | `""` |
| `additionalLabels` | Additional labels to add to all resources | `{}` |
| `additionalAnnotations` | Additional annotations to add to all resources | `{}` |

### Image Configuration

| Name | Description | Value |
| --- | --- | --- |
| `image.repository` | MongoDB Compass Web Docker image repository | `haohanyang/compass-web` |
| `image.tag` | MongoDB Compass Web Docker image tag | `0.3.1` |
| `image.pullPolicy` | Image pull policy | `IfNotPresent` |
| `image.digest` | Image digest (overrides tag if set) | `""` |
| `imagePullSecrets` | Image pull secrets for private registries | `[]` |

### Compass Web Configuration

| Name | Description | Value |
| --- | --- | --- |
| `compassWeb.mongoUri` | MongoDB connection string(s) (required) | `""` |
| `compassWeb.existingSecret` | Name of an existing secret containing MongoDB connection string | `""` |
| `compassWeb.existingSecretKey` | Key in existingSecret that contains the MongoDB URI | `mongoUri` |
| `compassWeb.appName` | Application name displayed in the UI | `Compass Web` |
| `compassWeb.orgId` | Organization ID associated with the connection | `default-org-id` |
| `compassWeb.projectId` | Project ID associated with the connection | `default-project-id` |
| `compassWeb.clusterId` | Cluster ID associated with the connection | `default-cluster-id` |

### Basic Authentication

| Name | Description | Value |
| --- | --- | --- |
| `compassWeb.basicAuth.enabled` | Enable basic authentication | `false` |
| `compassWeb.basicAuth.username` | Username for basic auth | `""` |
| `compassWeb.basicAuth.password` | Password for basic auth | `""` |
| `compassWeb.basicAuth.existingSecret` | Name of existing secret containing basic auth credentials | `""` |

### GenAI Features

| Name | Description | Value |
| --- | --- | --- |
| `compassWeb.genAI.enabled` | Enable GenAI features | `false` |
| `compassWeb.genAI.apiKey` | OpenAI API key | `""` |
| `compassWeb.genAI.existingSecret` | Name of existing secret containing OpenAI API key | `""` |
| `compassWeb.genAI.model` | OpenAI model to use | `gpt-4o-mini` |
| `compassWeb.genAI.enableSampleDocuments` | Enable uploading sample documents to GenAI service | `false` |

### Service Configuration

| Name | Description | Value |
| --- | --- | --- |
| `service.type` | Service type | `ClusterIP` |
| `service.port` | Service port | `8080` |
| `service.targetPort` | Service target port (container port) | `8080` |

### Persistence Configuration

| Name | Description | Value |
| --- | --- | --- |
| `persistence.enabled` | Enable persistent storage | `false` |
| `persistence.size` | Size of the persistent volume | `1Gi` |
| `persistence.storageClassName` | Storage class name | `""` |
| `persistence.accessMode` | Access mode for the persistent volume | `ReadWriteOnce` |

### Security Context

| Name | Description | Value |
| --- | --- | --- |
| `podSecurityContext.runAsNonRoot` | Run as non-root user | `true` |
| `podSecurityContext.runAsUser` | User ID to run as | `1000` |
| `podSecurityContext.fsGroup` | Group ID for filesystem access | `1000` |
| `securityContext.allowPrivilegeEscalation` | Allow privilege escalation | `false` |
| `securityContext.readOnlyRootFilesystem` | Read-only root filesystem | `false` |

### Resources

| Name | Description | Value |
| --- | --- | --- |
| `resources.limits.cpu` | CPU limit | `1000m` |
| `resources.limits.memory` | Memory limit | `512Mi` |
| `resources.requests.cpu` | CPU request | `100m` |
| `resources.requests.memory` | Memory request | `256Mi` |

## Examples

Check the `examples/` directory for more configuration examples:

- `values-minimal.yaml` - Minimal configuration
- `values-production.yaml` - Production-ready setup
- `values-with-persistence.yaml` - Configuration with persistent storage
- `values-reverse-proxy.yaml` - Reverse proxy configuration

## Supported Cloud Providers

MongoDB Compass Web supports:
- MongoDB Atlas
- Amazon DocumentDB
- Azure Cosmos DB
- Self-hosted MongoDB

## Unsupported Features

Not all MongoDB Compass Desktop features are available in Compass Web:
- Mongo Shell (limited support)
- Some proxy configurations

## Troubleshooting

### Connection Issues

If you're having trouble connecting to MongoDB:

1. Verify your MongoDB URI format
2. Check network policies allow egress to MongoDB port (27017)
3. Ensure MongoDB authentication credentials are correct
4. For MongoDB Atlas, make sure TLS is enabled in the connection string

### Container Logs

View Compass Web logs:

```console
$ kubectl logs -l app.kubernetes.io/name=compass-web
```

### Health Checks

Check the health of the application:

```console
$ kubectl get pods -l app.kubernetes.io/name=compass-web
$ kubectl describe pod <pod-name>
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This Helm chart is open source and available under the MIT License.

## Credits

- [MongoDB Compass Web](https://github.com/haohanyang/compass-web) by Haohan Yang
- [MongoDB Compass](https://github.com/mongodb-js/compass) by MongoDB

## Support

For issues and questions:
- Chart issues: [GitHub Issues](https://github.com/codefuturist/helm-charts/issues)
- Compass Web issues: [Compass Web GitHub](https://github.com/haohanyang/compass-web/issues)
