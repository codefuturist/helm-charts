# Shlink Helm Chart

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 4.2.4](https://img.shields.io/badge/AppVersion-4.2.4-informational?style=flat-square)

A production-ready Helm chart for deploying [Shlink](https://shlink.io) - a self-hosted URL shortener with analytics, written in PHP.

**Homepage:** <https://shlink.io>

## Features

- 🔗 **URL Shortening** - Create custom short URLs with tracking capabilities
- 📊 **Analytics** - Track visits, referrers, browsers, OS, and geographic location
- 🌐 **Multi-domain Support** - Configure multiple short domains
- 🎨 **Web Client** - Beautiful React-based admin interface (optional)
- 🗄️ **Database** - Integrated PostgreSQL subchart or external database support
- 🔐 **Security** - API key authentication, secure secrets management
- 📈 **Monitoring** - Prometheus ServiceMonitor and alerting rules
- ⚡ **High Availability** - Horizontal autoscaling, pod disruption budgets
- 💾 **Persistence** - Optional persistent storage for GeoLite2 databases
- 🔄 **Health Checks** - Kubernetes-native liveness, readiness, and startup probes

## Architecture

This chart deploys two separate components:

1. **Shlink Backend** - PHP-based REST API server (port 8080)
2. **Shlink Web Client** - React-based admin UI served by nginx (port 80)

Both components can be scaled independently and exposed via separate ingress routes.

## Quick Start

### Basic Installation

```bash
# Add the repository
helm repo add codefuturist https://codefuturist.github.io/helm-charts

# Install with minimal configuration
helm install shlink codefuturist/shlink \
  --set shlink.defaultDomain="short.example.com" \
  --set postgresql.auth.password="change-me"
```

### Access Your Shlink Instance

```bash
# Port-forward to the backend API
kubectl port-forward svc/shlink 8080:8080

# Port-forward to the web client (if enabled)
kubectl port-forward svc/shlink-webclient 8080:80
```

Visit <http://localhost:8080> for the API or web client.

> The chart deploys the React web client by default. Expose it via ingress/port-forwarding or disable it with `--set webClient.enabled=false` if you only need the REST API.

### Generate an API Key

```bash
# Connect to the Shlink pod
kubectl exec -it deployment/shlink -- shlink api-key:generate

# Or with initial API key in values:
helm install shlink codefuturist/shlink \
  --set shlink.initialApiKey="your-secure-api-key"
```

## Installation

### Prerequisites

- Kubernetes 1.21+
- Helm 3.8+
- PV provisioner support (if using persistence)

### Install from Repository

```bash
helm repo add codefuturist https://codefuturist.github.io/helm-charts
helm repo update
helm install shlink codefuturist/shlink
```

### Install from Source

```bash
git clone https://github.com/codefuturist/helm-charts.git
cd helm-charts/charts/shlink
helm install shlink .
```

## Configuration

### Basic Configuration

```yaml
# values.yaml
shlink:
  defaultDomain: "short.example.com"
  defaultSchema: "https"
  initialApiKey: "your-secure-api-key"

webClient:
  enabled: true
  servers:
    - name: "Production"
      url: "https://short.example.com"
      apiKey: "your-secure-api-key"
      forwardCredentials: false

ingress:
  backend:
    enabled: true
    hosts:
      - host: short.example.com
        paths:
          - path: /
            pathType: Prefix
  
  webClient:
    enabled: true
    hosts:
      - host: shlink.example.com
        paths:
          - path: /
            pathType: Prefix

postgresql:
  enabled: true
  auth:
    password: "secure-database-password"

### Pre-configuring the Default Web Client Server

You can mirror the docker image behavior by letting the chart write a `servers.json` entry from environment variables. This is convenient for trusted clusters where you want the UI ready-to-use without exporting/importing servers manually.

> ⚠️ The resulting `servers.json` lives in the web client's document root. Anyone with access to the UI can read your API key, so only use this mechanism for internal dashboards.

```yaml
webClient:
  defaultServer:
    enabled: true
    url: "https://short.example.com"
    name: "Production"
    apiKeySecretRef:
      name: shlink-webclient-secret
      key: apiKey
    forwardCredentials: false
```

### Using External Database

```yaml
shlink:
  defaultDomain: "short.example.com"

database:
  type: "postgresql"  # or "mysql"
  host: "postgres.example.com"
  port: 5432
  name: "shlink"
  user: "shlink"
  existingSecret: "shlink-db-secret"
  existingSecretPasswordKey: "password"

postgresql:
  enabled: false  # Disable the subchart
```

### Migrating from docker-compose

The chart can mirror the provided docker-compose stack (Traefik + external PostgreSQL) with the settings below.

| docker-compose setting | Helm values |
| --- | --- |
| `DB_DRIVER`, `DB_HOST`, `DB_PORT`, `DB_NAME`, `DB_USER`, `DB_PASSWORD` | `database.*` (or `database.existingSecret*` to read from a Secret) |
| `DEFAULT_DOMAIN` | `shlink.defaultDomain` |
| `IS_HTTPS_ENABLED` | `shlink.defaultSchema` (`https` when `true`) |
| `TZ` | `shlink.extraEnv[]` and `webClient.extraEnv[]` |
| `SHLINK_SERVER_URL` | `webClient.defaultServer.url` or `webClient.servers[].url` |
| `SHLINK_SERVER_API_KEY` | `webClient.defaultServer.apiKeySecretRef` (preferred) or `webClient.defaultServer.apiKey` |
| Traefik labels (routers, entrypoints, middlewares, TLS) | `ingress.backend` / `ingress.webClient` hosts, TLS secrets, and annotations |

See [`examples/values-traefik-compose.yaml`](./examples/values-traefik-compose.yaml) for a complete, secret-friendly translation of the compose file shared in the issue.

### High Availability Setup

```yaml
controller:
  replicaCount: 3

autoscaling:
  enabled: true
  minReplicas: 3
  maxReplicas: 10
  targetCPUUtilizationPercentage: 70

podDisruptionBudget:
  enabled: true
  minAvailable: 2

persistence:
  enabled: true
  size: 10Gi

postgresql:
  enabled: true
  auth:
    password: "secure-password"
  primary:
    persistence:
      enabled: true
      size: 50Gi
```

## Configuration Values

### Shlink Backend Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `shlink.defaultDomain` | Default domain for short URLs | `""` |
| `shlink.defaultSchema` | Default URL schema (http/https) | `"http"` |
| `shlink.initialApiKey` | Initial API key to create | `""` |
| `shlink.geoLiteLicenseKey` | MaxMind GeoLite2 license key for geolocation | `""` |
| `shlink.anonymizeRemoteAddr` | Anonymize visitor IP addresses | `false` |
| `shlink.redirectsLogging` | Enable redirects logging | `true` |
| `shlink.orphanVisitsLogging` | Enable orphan visits logging | `true` |
| `shlink.redis.enabled` | Enable Redis for caching | `false` |
| `shlink.redis.servers` | Redis server addresses | `""` |

> The autogenerated secret uses the keys `initial-api-key` and `geolite-license-key`. Override `shlink.existingSecretApiKeyKey` / `shlink.existingSecretGeoLiteKey` only when pointing at a differently structured Secret.

### Web Client Configuration

> ⚠️ **Warning**: Pre-configured servers embed API keys in files served straight from the browser. Only enable them in trusted environments and prefer referencing Kubernetes Secrets instead of inlining credentials.

| Parameter | Description | Default |
|-----------|-------------|---------|
| `webClient.enabled` | Enable Shlink Web Client deployment | `false` |
| `webClient.replicaCount` | Number of web client replicas | `1` |
| `webClient.image.repository` | Web client image repository | `shlinkio/shlink-web-client` |
| `webClient.image.tag` | Web client image tag | `4.2.1` |
| `webClient.servers` | Pre-configured server connections | `[]` |
| `webClient.servers[].forwardCredentials` | Forward cookies/client certs to the backend (requires restrictive CORS) | `false` |
| `webClient.defaultServer.enabled` | Build a default server via `SHLINK_SERVER_*` env vars | `false` |
| `webClient.defaultServer.name` | Display name for the generated server | `""` |
| `webClient.defaultServer.url` | Backend URL for the generated server | `""` |
| `webClient.defaultServer.apiKey` | Inline API key for the generated server (use only if plaintext is acceptable) | `""` |
| `webClient.defaultServer.apiKeySecretRef.name` | Secret that stores the default server API key | `""` |
| `webClient.defaultServer.apiKeySecretRef.key` | Key inside the secret that stores the API key | `""` |
| `webClient.defaultServer.forwardCredentials` | Forward credentials for the generated server | `false` |

### Database Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `database.type` | Database type (postgresql/mysql) | `"postgresql"` |
| `database.host` | External database host | `""` |
| `database.port` | External database port | `5432` |
| `database.name` | Database name | `"shlink"` |
| `database.user` | Database username | `"shlink"` |
| `database.password` | Database password | `""` |
| `database.existingSecret` | Existing secret with database credentials | `""` |

### Service Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `service.backend.type` | Backend service type | `ClusterIP` |
| `service.backend.port` | Backend service port | `8080` |
| `service.webClient.type` | Web client service type | `ClusterIP` |
| `service.webClient.port` | Web client service port | `80` |

### Ingress Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `ingress.backend.enabled` | Enable ingress for backend API | `false` |
| `ingress.backend.className` | Ingress class name | `""` |
| `ingress.backend.hosts` | Backend ingress hosts | `[]` |
| `ingress.backend.tls` | Backend TLS configuration | `[]` |
| `ingress.webClient.enabled` | Enable ingress for web client | `false` |
| `ingress.webClient.className` | Ingress class name | `""` |
| `ingress.webClient.hosts` | Web client ingress hosts | `[]` |
| `ingress.webClient.tls` | Web client TLS configuration | `[]` |

### Persistence Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `persistence.enabled` | Enable persistent storage | `false` |
| `persistence.storageClass` | Storage class name | `""` |
| `persistence.size` | Volume size | `2Gi` |
| `persistence.accessModes` | Access modes | `["ReadWriteOnce"]` |

### PostgreSQL Subchart

| Parameter | Description | Default |
|-----------|-------------|---------|
| `postgresql.enabled` | Enable PostgreSQL subchart | `true` |
| `postgresql.auth.username` | PostgreSQL username | `"shlink"` |
| `postgresql.auth.password` | PostgreSQL password | `""` |
| `postgresql.auth.database` | PostgreSQL database | `"shlink"` |

For all PostgreSQL options, see the [Bitnami PostgreSQL chart documentation](https://github.com/bitnami/charts/tree/main/bitnami/postgresql).

### Monitoring

| Parameter | Description | Default |
|-----------|-------------|---------|
| `monitoring.serviceMonitor.enabled` | Enable Prometheus ServiceMonitor | `false` |
| `monitoring.serviceMonitor.interval` | Scrape interval | `30s` |
| `monitoring.prometheusRule.enabled` | Enable Prometheus alerting rules | `false` |

### Autoscaling

| Parameter | Description | Default |
|-----------|-------------|---------|
| `autoscaling.enabled` | Enable horizontal pod autoscaling | `false` |
| `autoscaling.minReplicas` | Minimum replicas | `1` |
| `autoscaling.maxReplicas` | Maximum replicas | `10` |
| `autoscaling.targetCPUUtilizationPercentage` | Target CPU utilization | `80` |

## Examples

See the [examples directory](./examples) for complete configuration examples:

- **[values-minimal.yaml](./examples/values-minimal.yaml)** - Minimal working configuration
- **[values-production.yaml](./examples/values-production.yaml)** - Production-ready HA setup
- **[values-with-persistence.yaml](./examples/values-with-persistence.yaml)** - Focus on storage configuration
- **[values-reverse-proxy.yaml](./examples/values-reverse-proxy.yaml)** - Advanced ingress scenarios
- **[values-traefik-compose.yaml](./examples/values-traefik-compose.yaml)** - Translation of the sample docker-compose + Traefik deployment

## Common Tasks

### Create a Short URL via CLI

```bash
kubectl exec -it deployment/shlink -- shlink short-url:generate \
  https://example.com/very-long-url \
  --domain=short.example.com \
  --custom-slug=myurl
```

### List All Short URLs

```bash
kubectl exec -it deployment/shlink -- shlink short-url:list
```

### View Visit Statistics

```bash
kubectl exec -it deployment/shlink -- shlink visit:stats
```

### Update GeoLite2 Database

```bash
kubectl exec -it deployment/shlink -- shlink visit:update-db
```

## Troubleshooting

### Backend Pod Not Starting

Check the logs:

```bash
kubectl logs deployment/shlink
```

Common issues:

- Database connection failure - verify database credentials
- Missing required environment variables - check values.yaml

### Cannot Access via Ingress

Verify ingress is created:

```bash
kubectl get ingress
```

Check ingress controller logs:

```bash
kubectl logs -n ingress-nginx deployment/ingress-nginx-controller
```

### Web Client Cannot Connect to Backend

Ensure the server configuration matches your backend URL:

```yaml
webClient:
  servers:
    - name: "Production"
      url: "https://short.example.com"  # Must match backend ingress
      apiKey: "your-api-key"
      forwardCredentials: false
```

## Upgrading

### To 1.x from Initial Version

This is the initial release. No upgrade path exists yet.

```bash
helm upgrade shlink codefuturist/shlink
```

## Uninstalling

```bash
helm uninstall shlink
```

This will remove all Kubernetes resources except:

- PersistentVolumeClaims (if `persistence.enabled=true`)
- Secrets (if using `existingSecret`)

To remove PVCs:

```bash
kubectl delete pvc -l app.kubernetes.io/instance=shlink
```

## Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## Support

- **Documentation**: [Shlink Documentation](https://shlink.io/documentation/)
- **Issues**: [GitHub Issues](https://github.com/codefuturist/helm-charts/issues)
- **Chart Source**: [GitHub Repository](https://github.com/codefuturist/helm-charts/tree/main/charts/shlink)

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| codefuturist | <colin@codefuturist.com> | <https://github.com/codefuturist> |

## Source Code

- <https://github.com/shlinkio/shlink> (Backend)
- <https://github.com/shlinkio/shlink-web-client> (Web Client)
- <https://github.com/codefuturist/helm-charts/tree/main/charts/shlink> (Helm Chart)

## License

This Helm chart is licensed under the Apache License 2.0.

Shlink itself is licensed under the MIT License.
