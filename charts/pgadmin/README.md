# pgAdmin Helm Chart

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square)
![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)
![AppVersion: 9.10.0](https://img.shields.io/badge/AppVersion-9.10.0-informational?style=flat-square)

## Introduction

This chart bootstraps a [pgAdmin 4](https://www.pgadmin.org/) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

pgAdmin is the most popular and feature-rich Open Source administration and development platform for PostgreSQL, the most advanced Open Source database in the world.

## Features

- **Easy Installation**: Get started with minimal configuration
- **Security First**: Hardened security contexts, network policies, and RBAC
- **Production Ready**: Persistent storage, resource limits, health probes
- **Flexible Configuration**: Support for both inline and existing secrets
- **Pre-configured Servers**: Define PostgreSQL connections via values
- **Ingress Support**: Expose via any ingress controller with TLS
- **Monitoring Ready**: ServiceMonitor and PrometheusRule for Prometheus Operator
- **High Availability**: Pod disruption budgets, HPA, and anti-affinity
- **Advanced Features**: SMTP, LDAP, pgpass, config_local.py support
- **Flexible Deployment**: Deployment or StatefulSet controller options
- **Extensibility**: Extra containers, init containers, volumes, and environment variables
- **Comprehensive Examples**: Ready-to-use configurations for common scenarios

## Quick Start

To deploy pgAdmin using this Helm chart, follow these steps:

```console
$ helm repo add codefuturist https://codefuturist.github.io/helm-charts
$ helm repo update
$ helm install my-pgadmin codefuturist/pgadmin \
  --set pgadmin.email=admin@example.com \
  --set pgadmin.password=SuperSecurePassword123
```

This will deploy pgAdmin with the default configuration. See the [Configuration](#configuration) section for details on customizing the deployment.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-pgadmin` deployment:

```console
$ helm delete my-pgadmin
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

If persistence was enabled, you may need to manually delete the PVC:

```console
$ kubectl delete pvc my-pgadmin
```

## Prerequisites

- Kubernetes 1.21+
- Helm 3.x
- PersistentVolume support (optional, for data persistence)

## Configuration

The following table lists the configurable parameters of the pgAdmin chart and their default values.

| Parameter | Description | Default |
| --------- | ----------- | ------- |
| `pgadmin.email` | Default login email address | `admin@example.com` |
| `pgadmin.password` | Default login password | `""` (required) |
| `pgadmin.existingSecret` | Name of existing secret with credentials | `""` |
| `pgadmin.existingSecretEmailKey` | Key in existing secret for email | `email` |
| `pgadmin.existingSecretPasswordKey` | Key in existing secret for password | `password` |
| `pgadmin.config` | pgAdmin configuration environment variables | See values.yaml |
| `pgadmin.disablePostfix` | Disable internal Postfix server | `false` |
| `pgadmin.replaceServersOnStartup` | Replace server definitions on every startup | `false` |
| `pgadmin.scriptName` | Script name for reverse proxy subdirectory hosting | `""` |
| `pgadmin.serverDefinitions` | Pre-configured PostgreSQL server definitions | `{}` |
| `pgadmin.existingServerDefinitionsConfigMap` | ConfigMap with server definitions JSON | `""` |
| `pgadmin.pgpassFile` | pgpass file content for automatic authentication | `""` |
| `pgadmin.existingPgpassSecret` | Secret containing pgpass file | `""` |
| `pgadmin.configLocalPy` | Custom config_local.py content | `""` |
| `pgadmin.existingConfigLocalPyConfigMap` | ConfigMap with config_local.py | `""` |
| `pgadmin.smtp.enabled` | Enable SMTP configuration | `false` |
| `pgadmin.smtp.server` | SMTP server address | `""` |
| `pgadmin.smtp.port` | SMTP server port | `587` |
| `pgadmin.smtp.useTLS` | Use TLS for SMTP | `true` |
| `pgadmin.smtp.useSSL` | Use SSL for SMTP | `false` |
| `pgadmin.smtp.username` | SMTP username | `""` |
| `pgadmin.smtp.password` | SMTP password | `""` |
| `pgadmin.smtp.fromAddress` | SMTP from address | `""` |
| `pgadmin.smtp.existingSecret` | Existing secret with SMTP credentials | `""` |
| `pgadmin.ldap.enabled` | Enable LDAP configuration | `false` |
| `pgadmin.ldap.server` | LDAP server URI | `""` |
| `pgadmin.ldap.bindDN` | LDAP bind DN | `""` |
| `pgadmin.ldap.bindPassword` | LDAP bind password | `""` |
| `pgadmin.ldap.existingSecret` | Existing secret with LDAP credentials | `""` |
| `pgadmin.gunicorn.threads` | Number of threads per Gunicorn worker | `25` |
| `pgadmin.gunicorn.accessLogfile` | Access log file path | `"-"` |
| `pgadmin.gunicorn.limitRequestLine` | Maximum HTTP request line size | `8190` |
| `controller.type` | Controller type: `deployment` or `statefulset` | `deployment` |
| `controller.replicas` | Number of replicas | `1` |
| `controller.updateStrategy` | Update strategy for the controller | `{}` |
| `image.repository` | pgAdmin image repository | `dpage/pgadmin4` |
| `image.tag` | pgAdmin image tag | `""` (chart appVersion) |
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

This chart supports two types of controllers for deploying pgAdmin:

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

## Pre-configured PostgreSQL Servers

Define PostgreSQL server connections that appear automatically in pgAdmin:

```yaml
pgadmin:
  serverDefinitions:
    servers:
      1:
        Name: "Production PostgreSQL"
        Group: "Production"
        Host: "postgresql.default.svc.cluster.local"
        Port: 5432
        MaintenanceDB: "postgres"
        Username: "postgres"
        SSLMode: "prefer"
      2:
        Name: "Development PostgreSQL"
        Group: "Development"
        Host: "postgresql-dev.default.svc.cluster.local"
        Port: 5432
        MaintenanceDB: "postgres"
        Username: "postgres"
        SSLMode: "disable"
```

## Using Existing Secrets

For production deployments, use Kubernetes secrets instead of inline credentials:

```bash
# Create secret for pgAdmin credentials
kubectl create secret generic pgadmin-creds \
  --from-literal=email=admin@example.com \
  --from-literal=password=SecurePassword123

# Install using secret
helm install my-pgadmin codefuturist/pgadmin \
  --set pgadmin.existingSecret=pgadmin-creds
```

## Examples

Pre-configured example files are available in the [examples/](examples/) directory:

- **values-minimal.yaml**: Quick development setup
- **values-with-persistence.yaml**: Basic setup with persistent storage
- **values-production.yaml**: Full production configuration with security
- **values-multiple-servers.yaml**: Multiple PostgreSQL connections
- **values-reverse-proxy.yaml**: Reverse proxy configuration with subdirectory hosting

Deploy using an example configuration:

```bash
helm install my-pgadmin codefuturist/pgadmin -f examples/values-production.yaml
```

## Advanced Configuration

### SMTP Configuration

Configure SMTP for email alerts and password recovery:

```yaml
pgadmin:
  smtp:
    enabled: true
    server: smtp.gmail.com
    port: 587
    useTLS: true
    fromAddress: pgadmin@example.com
    existingSecret: pgadmin-smtp-credentials
```

The secret should contain `username` and `password` keys.

### LDAP Authentication

Enable LDAP authentication for enterprise environments:

```yaml
pgadmin:
  ldap:
    enabled: true
    server: "ldap://ldap.example.com"
    bindDN: "cn=admin,dc=example,dc=com"
    existingSecret: pgadmin-ldap-credentials
```

### pgpass File Support

Automatically authenticate to PostgreSQL servers without storing passwords in pgAdmin:

```yaml
pgadmin:
  pgpassFile: "postgresql.example.com:5432:*:myuser:mypassword"
  # Or use existing secret
  existingPgpassSecret: pgadmin-pgpass
```

The pgpass format is: `hostname:port:database:username:password`

### Container Configuration

#### Reverse Proxy Support

Host pgAdmin under a subdirectory (e.g., `/pgadmin4`):

```yaml
pgadmin:
  scriptName: "/pgadmin4"  # Sets SCRIPT_NAME environment variable
```

Configure your reverse proxy to set the `X-Script-Name` header:

```nginx
# Nginx
location /pgadmin4 {
    proxy_pass http://pgadmin-service;
    proxy_set_header X-Script-Name /pgadmin4;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
}
```

#### Gunicorn Configuration

Tune the WSGI server performance:

```yaml
pgadmin:
  gunicorn:
    threads: 25              # Threads per worker (default: 25)
    accessLogfile: "-"       # Access log to stdout
    limitRequestLine: 8190   # Max HTTP request line size
```

#### Postfix Control

Disable internal Postfix (useful when using external SMTP or in restricted environments):

```yaml
pgadmin:
  disablePostfix: true  # Sets PGADMIN_DISABLE_POSTFIX=1
```

#### Server Definition Reloading

Replace server definitions on every startup (not just first launch):

```yaml
pgadmin:
  replaceServersOnStartup: true  # Sets PGADMIN_REPLACE_SERVERS_ON_STARTUP=True
```

This is useful for dynamic server definitions managed via ConfigMaps.

#### Additional Configuration Variables

Pass any pgAdmin configuration variable as environment variables:

```yaml
pgadmin:
  config:
    PGADMIN_CONFIG_ENHANCED_COOKIE_PROTECTION: "True"
    PGADMIN_CONFIG_SESSION_COOKIE_NAME: "pgadmin4_session"
    PGADMIN_CONFIG_CONSOLE_LOG_LEVEL: "10"
    PGADMIN_CONFIG_SESSION_EXPIRATION_TIME: "604800"  # 7 days in seconds
```

See [pgAdmin Container Deployment](https://www.pgadmin.org/docs/pgadmin4/latest/container_deployment.html) for all available configuration options.

### Init Containers

Use init containers to perform tasks before starting pgAdmin, such as waiting for a database or initializing configuration:

```yaml
initContainers:
  - name: wait-for-db
    image: busybox:latest
    command: ['sh', '-c', 'until nslookup postgresql; do echo waiting for postgresql; sleep 2; done;']
```

### Additional Volumes and Mounts

Add custom volumes and mounts for extensions, plugins, or custom configurations:

```yaml
extraVolumes:
  - name: custom-plugins
    configMap:
      name: pgadmin-plugins
  - name: custom-certs
    secret:
      secretName: pgadmin-certificates

extraVolumeMounts:
  - name: custom-plugins
    mountPath: /var/lib/pgadmin/plugins
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
      - name: pgadmin-data
        mountPath: /var/lib/pgadmin
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
        port: 5432  # PostgreSQL only
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

The chart supports standard Kubernetes ingress configuration for exposing pgAdmin externally:

```yaml
ingress:
  enabled: true
  className: nginx
  annotations:
    cert-manager.io/cluster-issuer: "letsencrypt-prod"
  hosts:
    - host: pgadmin.example.com
      paths:
        - path: /
          pathType: Prefix
  tls:
    - secretName: pgadmin-tls
      hosts:
        - pgadmin.example.com
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

Note: pgAdmin uses SQLite for session storage by default, which doesn't support multiple replicas well. For HA deployments, consider:

1. Using a single replica with PVC
2. Implementing external session storage (requires custom configuration)

## Upgrading

### To New Chart Version

```bash
helm repo update
helm upgrade my-pgadmin codefuturist/pgadmin
```

### With New Configuration

```bash
helm upgrade my-pgadmin codefuturist/pgadmin -f my-values.yaml
```

## Uninstalling

```bash
helm uninstall my-pgadmin

# If persistence was enabled, manually delete PVC
kubectl delete pvc my-pgadmin
```

## Troubleshooting

### Connection Test

Run Helm test to verify deployment:

```bash
helm test my-pgadmin
```

### Check Logs

```bash
kubectl logs -l app.kubernetes.io/name=pgadmin
```

### Access via Port Forward

```bash
kubectl port-forward svc/my-pgadmin 8080:80
# Open http://localhost:8080
```

### Common Issues

**Issue**: Can't log in  
**Solution**: Verify password is set correctly, check pod logs for authentication errors

**Issue**: PostgreSQL connection fails  
**Solution**: Verify network policies allow egress to PostgreSQL port, check host/port configuration

**Issue**: Data lost after restart  
**Solution**: Enable persistence with `persistence.enabled=true`

## Documentation

- [Quick Start Guide](docs/QUICKSTART.md) - Detailed installation scenarios
- [Examples](examples/) - Ready-to-use configuration files
- [pgAdmin Official Documentation](https://www.pgadmin.org/docs/)

## Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](../../docs/CONTRIBUTING.md) for details.

## Support

- **Issues**: [GitHub Issues](https://github.com/codefuturist/helm-charts/issues)
- **Discussions**: [GitHub Discussions](https://github.com/codefuturist/helm-charts/discussions)

## License

This Helm chart is licensed under the Apache License 2.0. See [LICENSE](../../LICENSE) for details.

pgAdmin 4 is licensed under [The PostgreSQL License](https://www.pgadmin.org/licence/).

## Maintainers

| Name | Email |
| ---- | ------ |
| codefuturist | <58808821+codefuturist@users.noreply.github.com> |

## Source Code

- **Chart Repository**: <https://github.com/codefuturist/helm-charts>
- **pgAdmin Repository**: <https://github.com/pgadmin-org/pgadmin4>

---

*Made with care for the PostgreSQL community*
