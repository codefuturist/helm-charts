# RedisInsight Helm Chart

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square)
![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)
![AppVersion: 9.10.0](https://img.shields.io/badge/AppVersion-9.10.0-informational?style=flat-square)

## Introduction

This chart bootstraps a [RedisInsight 4](https://www.redisinsight.org/) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

RedisInsight is the most popular and feature-rich Open Source administration and development platform for Redis, the most advanced Open Source database in the world.

## Features

- **Easy Installation**: Get started with minimal configuration
- **Security First**: Hardened security contexts, network policies, and RBAC
- **Production Ready**: Persistent storage, resource limits, health probes
- **Flexible Configuration**: Support for both inline and existing secrets
- **Pre-configured Servers**: Define Redis connections via values
- **Ingress Support**: Expose via any ingress controller with TLS
- **Monitoring Ready**: ServiceMonitor and PrometheusRule for Prometheus Operator
- **High Availability**: Pod disruption budgets, HPA, and anti-affinity
- **Advanced Features**: SMTP, LDAP, pgpass, config_local.py support
- **Flexible Deployment**: Deployment or StatefulSet controller options
- **Extensibility**: Extra containers, init containers, volumes, and environment variables
- **Comprehensive Examples**: Ready-to-use configurations for common scenarios

## Quick Start

To deploy RedisInsight using this Helm chart, follow these steps:

```console
$ helm repo add codefuturist https://codefuturist.github.io/helm-charts
$ helm repo update
$ helm install my-redisinsight codefuturist/redisinsight \
  --set redisinsight.email=admin@example.com \
  --set redisinsight.password=SuperSecurePassword123
```

This will deploy RedisInsight with the default configuration. See the [Configuration](#configuration) section for details on customizing the deployment.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-redisinsight` deployment:

```console
$ helm delete my-redisinsight
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

If persistence was enabled, you may need to manually delete the PVC:

```console
$ kubectl delete pvc my-redisinsight
```

## Prerequisites

- Kubernetes 1.21+
- Helm 3.x
- PersistentVolume support (optional, for data persistence)

## Configuration

The following table lists the configurable parameters of the RedisInsight chart and their default values.

| Parameter | Description | Default |
| --------- | ----------- | ------- |
| `redisinsight.email` | Default login email address | `admin@example.com` |
| `redisinsight.password` | Default login password | `""` (required) |
| `redisinsight.existingSecret` | Name of existing secret with credentials | `""` |
| `redisinsight.existingSecretEmailKey` | Key in existing secret for email | `email` |
| `redisinsight.existingSecretPasswordKey` | Key in existing secret for password | `password` |
| `redisinsight.config` | RedisInsight configuration environment variables | See values.yaml |
| `redisinsight.disablePostfix` | Disable internal Postfix server | `false` |
| `redisinsight.replaceServersOnStartup` | Replace server definitions on every startup | `false` |
| `redisinsight.scriptName` | Script name for reverse proxy subdirectory hosting | `""` |
| `redisinsight.serverDefinitions` | Pre-configured Redis server definitions | `{}` |
| `redisinsight.existingServerDefinitionsConfigMap` | ConfigMap with server definitions JSON | `""` |
| `redisinsight.pgpassFile` | pgpass file content for automatic authentication | `""` |
| `redisinsight.existingPgpassSecret` | Secret containing pgpass file | `""` |
| `redisinsight.configLocalPy` | Custom config_local.py content | `""` |
| `redisinsight.existingConfigLocalPyConfigMap` | ConfigMap with config_local.py | `""` |
| `redisinsight.smtp.enabled` | Enable SMTP configuration | `false` |
| `redisinsight.smtp.server` | SMTP server address | `""` |
| `redisinsight.smtp.port` | SMTP server port | `587` |
| `redisinsight.smtp.useTLS` | Use TLS for SMTP | `true` |
| `redisinsight.smtp.useSSL` | Use SSL for SMTP | `false` |
| `redisinsight.smtp.username` | SMTP username | `""` |
| `redisinsight.smtp.password` | SMTP password | `""` |
| `redisinsight.smtp.fromAddress` | SMTP from address | `""` |
| `redisinsight.smtp.existingSecret` | Existing secret with SMTP credentials | `""` |
| `redisinsight.ldap.enabled` | Enable LDAP configuration | `false` |
| `redisinsight.ldap.server` | LDAP server URI | `""` |
| `redisinsight.ldap.bindDN` | LDAP bind DN | `""` |
| `redisinsight.ldap.bindPassword` | LDAP bind password | `""` |
| `redisinsight.ldap.existingSecret` | Existing secret with LDAP credentials | `""` |
| `redisinsight.gunicorn.threads` | Number of threads per Gunicorn worker | `25` |
| `redisinsight.gunicorn.accessLogfile` | Access log file path | `"-"` |
| `redisinsight.gunicorn.limitRequestLine` | Maximum HTTP request line size | `8190` |
| `controller.type` | Controller type: `deployment` or `statefulset` | `deployment` |
| `controller.replicas` | Number of replicas | `1` |
| `controller.updateStrategy` | Update strategy for the controller | `{}` |
| `image.repository` | RedisInsight image repository | `dpage/redisinsight4` |
| `image.tag` | RedisInsight image tag | `""` (chart appVersion) |
| `image.pullPolicy` | Image pull policy | `IfNotPresent` |
| `imagePullSecrets` | Image pull secrets | `[]` |
| `service.type` | Service type | `ClusterIP` |
| `service.port` | Service port | `80` |
| `service.nodePort` | NodePort (if service.type is NodePort) | `""` |
| `service.annotations` | Service annotations | `{}` |
| `ingress.enabled` | Enable ingress | `false` |
| `ingress.className` | Ingress class name | `""` |
| `ingress.annotations` | Ingress annotations | `{}` |
| `ingress.hosts` | Ingress hosts configuration | `[]` |
| `ingress.tls` | Ingress TLS configuration | `[]` |
| `persistence.enabled` | Enable persistent storage | `false` |
| `persistence.storageClassName` | Storage class name | `""` |
| `persistence.accessMode` | Access mode | `ReadWriteOnce` |
| `persistence.size` | Storage size | `1Gi` |
| `persistence.existingClaim` | Use existing PVC (Deployment only) | `""` |
| `persistence.annotations` | PVC annotations | `{}` |
| `resources.limits.cpu` | CPU limit | `1000m` |
| `resources.limits.memory` | Memory limit | `512Mi` |
| `resources.requests.cpu` | CPU request | `100m` |
| `resources.requests.memory` | Memory request | `256Mi` |
| `podSecurityContext` | Pod security context | See values.yaml |
| `securityContext` | Container security context | See values.yaml |
| `networkPolicy.enabled` | Enable network policy | `false` |
| `networkPolicy.ingress` | Ingress rules | `[]` |
| `networkPolicy.egress` | Egress rules | `[]` |
| `serviceAccount.create` | Create service account | `true` |
| `serviceAccount.annotations` | Service account annotations | `{}` |
| `serviceAccount.name` | Service account name | `""` |
| `rbac.create` | Create RBAC resources | `true` |
| `rbac.rules` | Additional RBAC rules | `[]` |
| `pdb.enabled` | Enable pod disruption budget | `false` |
| `pdb.minAvailable` | Minimum available pods | `1` |
| `hpa.enabled` | Enable horizontal pod autoscaler | `false` |
| `hpa.minReplicas` | Minimum replicas | `1` |
| `hpa.maxReplicas` | Maximum replicas | `10` |
| `hpa.targetCPU` | Target CPU utilization percentage | `80` |
| `hpa.targetMemory` | Target memory utilization percentage | `80` |
| `monitoring.serviceMonitor.enabled` | Enable Prometheus ServiceMonitor | `false` |
| `monitoring.prometheusRule.enabled` | Enable Prometheus rules | `false` |
| `livenessProbe.enabled` | Enable liveness probe | `true` |
| `readinessProbe.enabled` | Enable readiness probe | `true` |
| `startupProbe.enabled` | Enable startup probe | `true` |
| `nodeSelector` | Node selector | `{}` |
| `tolerations` | Tolerations | `[]` |
| `affinity` | Affinity rules | `{}` |
| `extraEnv` | Additional environment variables | `[]` |
| `extraVolumes` | Additional volumes | `[]` |
| `extraVolumeMounts` | Additional volume mounts | `[]` |
| `initContainers` | Init containers | `[]` |
| `extraContainers` | Additional sidecar containers | `[]` |

For complete configuration options with detailed comments, see [values.yaml](values.yaml).

## Controller Type

This chart supports two types of controllers for deploying RedisInsight:

1. `Deployment` (default): Standard Kubernetes deployment, suitable for most use cases.

2. `StatefulSet`: Provides stable network identities and ordered deployment/scaling. Recommended when using StatefulSet-specific features.

To specify the controller type:

```yaml
controller:
  type: deployment  # or statefulset
```

## Persistence

By default, this chart uses an `emptyDir` volume, which means data is lost when the pod is removed. To enable persistent storage:

```yaml
persistence:
  enabled: true
  size: 5Gi
  storageClassName: ""  # Use default storage class
```

### Using an Existing PVC

When using a Deployment, you can specify an existing PVC:

```yaml
controller:
  type: deployment
persistence:
  enabled: true
  existingClaim: "my-existing-pvc"
```

## Pre-configured Redis Servers

Define Redis server connections that appear automatically in RedisInsight:

```yaml
redisinsight:
  serverDefinitions:
    servers:
      1:
        Name: "Production Redis"
        Group: "Production"
        Host: "redis.default.svc.cluster.local"
        Port: 5432
        MaintenanceDB: "postgres"
        Username: "postgres"
        SSLMode: "prefer"
      2:
        Name: "Development Redis"
        Group: "Development"
        Host: "redis-dev.default.svc.cluster.local"
        Port: 5432
        MaintenanceDB: "postgres"
        Username: "postgres"
        SSLMode: "disable"
```

## Using Existing Secrets

For production deployments, use Kubernetes secrets instead of inline credentials:

```bash
# Create secret for RedisInsight credentials
kubectl create secret generic redisinsight-creds \
  --from-literal=email=admin@example.com \
  --from-literal=password=SecurePassword123

# Install using secret
helm install my-redisinsight codefuturist/redisinsight \
  --set redisinsight.existingSecret=redisinsight-creds
```

## Examples

Pre-configured example files are available in the [examples/](examples/) directory:

- **values-minimal.yaml**: Quick development setup
- **values-with-persistence.yaml**: Basic setup with persistent storage
- **values-production.yaml**: Full production configuration with security
- **values-multiple-servers.yaml**: Multiple Redis connections
- **values-reverse-proxy.yaml**: Reverse proxy configuration with subdirectory hosting

Deploy using an example configuration:

```bash
helm install my-redisinsight codefuturist/redisinsight -f examples/values-production.yaml
```

## Advanced Configuration

### SMTP Configuration

Configure SMTP for email alerts and password recovery:

```yaml
redisinsight:
  smtp:
    enabled: true
    server: smtp.gmail.com
    port: 587
    useTLS: true
    fromAddress: redisinsight@example.com
    existingSecret: redisinsight-smtp-credentials
```

The secret should contain `username` and `password` keys.

### LDAP Authentication

Enable LDAP authentication for enterprise environments:

```yaml
redisinsight:
  ldap:
    enabled: true
    server: "ldap://ldap.example.com"
    bindDN: "cn=admin,dc=example,dc=com"
    existingSecret: redisinsight-ldap-credentials
```

### pgpass File Support

Automatically authenticate to Redis servers without storing passwords in RedisInsight:

```yaml
redisinsight:
  pgpassFile: "redis.example.com:5432:*:myuser:mypassword"
  # Or use existing secret
  existingPgpassSecret: redisinsight-pgpass
```

The pgpass format is: `hostname:port:database:username:password`

### Container Configuration

#### Reverse Proxy Support

Host RedisInsight under a subdirectory (e.g., `/redisinsight4`):

```yaml
redisinsight:
  scriptName: "/redisinsight4"  # Sets SCRIPT_NAME environment variable
```

Configure your reverse proxy to set the `X-Script-Name` header:

```nginx
# Nginx
location /redisinsight4 {
    proxy_pass http://redisinsight-service;
    proxy_set_header X-Script-Name /redisinsight4;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
}
```

#### Gunicorn Configuration

Tune the WSGI server performance:

```yaml
redisinsight:
  gunicorn:
    threads: 25              # Threads per worker (default: 25)
    accessLogfile: "-"       # Access log to stdout
    limitRequestLine: 8190   # Max HTTP request line size
```

#### Postfix Control

Disable internal Postfix (useful when using external SMTP or in restricted environments):

```yaml
redisinsight:
  disablePostfix: true  # Sets REDISINSIGHT_DISABLE_POSTFIX=1
```

#### Server Definition Reloading

Replace server definitions on every startup (not just first launch):

```yaml
redisinsight:
  replaceServersOnStartup: true  # Sets REDISINSIGHT_REPLACE_SERVERS_ON_STARTUP=True
```

This is useful for dynamic server definitions managed via ConfigMaps.

#### Additional Configuration Variables

Pass any RedisInsight configuration variable as environment variables:

```yaml
redisinsight:
  config:
    REDISINSIGHT_CONFIG_ENHANCED_COOKIE_PROTECTION: "True"
    REDISINSIGHT_CONFIG_SESSION_COOKIE_NAME: "redisinsight4_session"
    REDISINSIGHT_CONFIG_CONSOLE_LOG_LEVEL: "10"
    REDISINSIGHT_CONFIG_SESSION_EXPIRATION_TIME: "604800"  # 7 days in seconds
```

See [RedisInsight Container Deployment](https://www.redisinsight.org/docs/redisinsight4/latest/container_deployment.html) for all available configuration options.

### Init Containers

Use init containers to perform tasks before starting RedisInsight, such as waiting for a database or initializing configuration:

```yaml
initContainers:
  - name: wait-for-db
    image: busybox:latest
    command: ['sh', '-c', 'until nslookup redis; do echo waiting for redis; sleep 2; done;']
```

### Additional Volumes and Mounts

Add custom volumes and mounts for extensions, plugins, or custom configurations:

```yaml
extraVolumes:
  - name: custom-plugins
    configMap:
      name: redisinsight-plugins
  - name: custom-certs
    secret:
      secretName: redisinsight-certificates

extraVolumeMounts:
  - name: custom-plugins
    mountPath: /var/lib/redisinsight/plugins
  - name: custom-certs
    mountPath: /certs
    readOnly: true
```

### Sidecar Containers

Add sidecar containers for logging, monitoring, or other auxiliary services:

```yaml
extraContainers:
  - name: log-shipper
    image: fluent/fluent-bit:latest
    volumeMounts:
      - name: redisinsight-data
        mountPath: /var/lib/redisinsight
        readOnly: true
```

### Horizontal Pod Autoscaling

Enable HPA for automatic scaling based on resource usage:

```yaml
hpa:
  enabled: true
  minReplicas: 2
  maxReplicas: 10
  targetCPU: 80
  targetMemory: 80
```

## Security

### Pod Security Context

The chart implements security best practices:

- Runs as non-root user (UID 5050)
- Drops all capabilities
- Uses RuntimeDefault seccomp profile
- Read-only root filesystem where possible

### Network Policies

When enabled, network policies restrict traffic:

```yaml
networkPolicy:
  enabled: true
  egress:
    - to:
      - namespaceSelector: {}
      ports:
      - protocol: TCP
        port: 5432  # Redis only
```

### RBAC

Service accounts and RBAC rules can be customized:

```yaml
serviceAccount:
  create: true
  annotations: {}

rbac:
  create: true
  rules: []
```

## Ingress

The chart supports standard Kubernetes ingress configuration for exposing RedisInsight externally:

```yaml
ingress:
  enabled: true
  className: nginx
  annotations:
    cert-manager.io/cluster-issuer: "letsencrypt-prod"
  hosts:
    - host: redisinsight.example.com
      paths:
        - path: /
          pathType: Prefix
  tls:
    - secretName: redisinsight-tls
      hosts:
        - redisinsight.example.com
```

Alternatively, set `service.type` to `NodePort` or `LoadBalancer` when ingress is not available.

## Monitoring with Prometheus

Enable monitoring with Prometheus Operator:

```yaml
monitoring:
  serviceMonitor:
    enabled: true
    interval: 30s
    labels:
      prometheus: kube-prometheus
```

## High Availability

### Pod Disruption Budget

```yaml
pdb:
  enabled: true
  minAvailable: 1
```

### Multiple Replicas

Note: RedisInsight uses SQLite for session storage by default, which doesn't support multiple replicas well. For HA deployments, consider:

1. Using a single replica with PVC
2. Implementing external session storage (requires custom configuration)

## Upgrading

### To New Chart Version

```bash
helm repo update
helm upgrade my-redisinsight codefuturist/redisinsight
```

### With New Configuration

```bash
helm upgrade my-redisinsight codefuturist/redisinsight -f my-values.yaml
```

## Uninstalling

```bash
helm uninstall my-redisinsight

# If persistence was enabled, manually delete PVC
kubectl delete pvc my-redisinsight
```

## Troubleshooting

### Connection Test

Run Helm test to verify deployment:

```bash
helm test my-redisinsight
```

### Check Logs

```bash
kubectl logs -l app.kubernetes.io/name=redisinsight
```

### Access via Port Forward

```bash
kubectl port-forward svc/my-redisinsight 8080:80
# Open http://localhost:8080
```

### Common Issues

**Issue**: Can't log in  
**Solution**: Verify password is set correctly, check pod logs for authentication errors

**Issue**: Redis connection fails  
**Solution**: Verify network policies allow egress to Redis port, check host/port configuration

**Issue**: Data lost after restart  
**Solution**: Enable persistence with `persistence.enabled=true`

## Documentation

- [Quick Start Guide](docs/QUICKSTART.md) - Detailed installation scenarios
- [Examples](examples/) - Ready-to-use configuration files
- [RedisInsight Official Documentation](https://www.redisinsight.org/docs/)

## Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](../../docs/CONTRIBUTING.md) for details.

## Support

- **Issues**: [GitHub Issues](https://github.com/codefuturist/helm-charts/issues)
- **Discussions**: [GitHub Discussions](https://github.com/codefuturist/helm-charts/discussions)

## License

This Helm chart is licensed under the Apache License 2.0. See [LICENSE](../../LICENSE) for details.

RedisInsight 4 is licensed under [The Redis License](https://www.redisinsight.org/licence/).

## Maintainers

| Name | Email |
| ---- | ------ |
| codefuturist | <58808821+codefuturist@users.noreply.github.com> |

## Source Code

- **Chart Repository**: <https://github.com/codefuturist/helm-charts>
- **RedisInsight Repository**: <https://github.com/redisinsight-org/redisinsight4>

---

*Made with care for the Redis community*
