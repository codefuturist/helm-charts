# Bitwarden ESO Provider Helm Chart

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square)
![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

## Introduction

This chart bootstraps a Bitwarden webhook provider for [External Secrets Operator](https://external-secrets.io/) on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

The Bitwarden ESO Provider enables integration with personal and organizational Bitwarden vaults using the **Bitwarden CLI**. This is a **free alternative** to Bitwarden Secrets Manager.

## Features

### Why CLI-based?

- **Full Vault Access**: Works with personal and organizational vaults
- **No Subscription Required**: Works with free Bitwarden accounts
- **Industry Standard**: Same approach used by Raycast and other popular tools
- **Battle-tested**: Bitwarden CLI is mature and widely used
- **Lightweight**: 295MB image size

### Key Features

- **Free Solution**: Works with personal/organizational Bitwarden vaults (no paid Secrets Manager needed)
- **Kubernetes-native**: Integrates seamlessly with External Secrets Operator
- **Secure**: API key or password authentication, encrypted sessions
- **Performant**: Built-in caching with configurable TTL, efficient session management
- **Production-ready**: Health checks, metrics, logging, and auto-retry
- **Self-hosted Compatible**: Works with self-hosted Bitwarden/Vaultwarden instances

## Architecture

```text
┌─────────────────┐
│  Your App Pod   │
│   ┌─────────┐   │
│   │  App    │   │◄──── Reads from
│   └─────────┘   │
└────────┬────────┘
         │ mounts
         ▼
┌─────────────────┐
│ Kubernetes      │
│ Secret          │◄──── Synced by
└────────┬────────┘
         │
         ▼
┌──────────────────────┐
│ ExternalSecret (CRD) │
└──────────┬───────────┘
           │ webhook call
           ▼
┌──────────────────────┐
│ Bitwarden ESO        │
│ Provider (this)      │◄──── Uses
└──────────┬───────────┘
           │ bw CLI
           ▼
┌──────────────────────┐
│ Bitwarden Vault      │
│ (cloud/self-hosted)  │
└──────────────────────┘
```

## Prerequisites

1. **Kubernetes cluster** (1.19+)
2. **External Secrets Operator** installed ([installation guide](https://external-secrets.io/latest/introduction/getting-started/))
3. **Bitwarden account** (free or paid)
4. **API credentials** from Bitwarden

### Get Bitwarden API Credentials

#### Method 1: API Key (Recommended)

1. Log in to your Bitwarden web vault
2. Go to **Settings** → **Security** → **Keys**
3. Under "API Key", view your `client_id` and `client_secret`
4. Save these securely

#### Method 2: Master Password (Less Secure)

Use your Bitwarden email and master password. **Not recommended for production.**

## Installation

### Quick Start

```bash
# Add the helm repository
helm repo add codefuturist https://codefuturist.github.io/helm-charts
helm repo update

# Create namespace
kubectl create namespace bitwarden-eso-provider

# Create secret with Bitwarden credentials (API Key method)
kubectl create secret generic bitwarden-credentials \
  --namespace bitwarden-eso-provider \
  --from-literal=clientId='your-client-id' \
  --from-literal=clientSecret='your-client-secret'

# Install the chart
helm install bitwarden-eso-provider codefuturist/bitwarden-eso-provider \
  --namespace bitwarden-eso-provider \
  --set bitwarden.auth.useApiKey=true \
  --set bitwarden.auth.existingSecret.name=bitwarden-credentials \
  --set externalSecretsOperator.createClusterSecretStore=true
```

### Configuration

See [values.yaml](values.yaml) for all configuration options.

#### Essential Configuration

```yaml
# values.yaml
bitwarden:
  # Bitwarden server (use your self-hosted URL if applicable)
  server: "https://vault.bitwarden.com"

  # Authentication
  auth:
    useApiKey: true  # or usePassword: true
    existingSecret:
      name: "bitwarden-credentials"
      clientIdKey: "clientId"
      clientSecretKey: "clientSecret"

# External Secrets Operator integration
externalSecretsOperator:
  createClusterSecretStore: true
  secretStore:
    name: "bitwarden"
```

#### Self-Hosted Bitwarden/Vaultwarden

```yaml
bitwarden:
  server: "https://vault.example.com"
```

## Usage

### 1. Create an ExternalSecret

```yaml
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: my-app-secrets
spec:
  refreshInterval: 5m
  secretStoreRef:
    name: bitwarden
    kind: ClusterSecretStore
  target:
    name: my-app-secrets
    creationPolicy: Owner
  data:
    # Fetch password field
    - secretKey: db-password
      remoteRef:
        key: "database-credentials"  # Bitwarden item name or UUID
        property: "password"

    # Fetch username field
    - secretKey: db-username
      remoteRef:
        key: "database-credentials"
        property: "username"

    # Fetch custom field
    - secretKey: api-token
      remoteRef:
        key: "api-credentials"
        property: "field:API_TOKEN"
```

### 2. Use the Secret in Your Pod

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-app
spec:
  containers:
  - name: app
    image: myapp:latest
    envFrom:
    - secretRef:
        name: my-app-secrets
```

## Supported Field Types

| Property Value | Description | Example |
|----------------|-------------|---------|
| `password` | Login password | `property: "password"` |
| `username` | Login username | `property: "username"` |
| `totp` | TOTP secret | `property: "totp"` |
| `uri` | First URI | `property: "uri"` |
| `notes` | Secure notes | `property: "notes"` |
| `field:<name>` | Custom field | `property: "field:API_KEY"` |

## Integration with Your Helm Charts

Use this with your existing charts (like `homarr`):

```yaml
# charts/homarr/values.yaml
externalSecret:
  enabled: true
  secretStore:
    name: bitwarden
    kind: ClusterSecretStore
  refreshInterval: "5m"
  files:
    main:
      data:
        SECRET_ENCRYPTION_KEY:
          remoteRef:
            key: "homarr-config"
            property: "field:encryption_key"
        DB_PASSWORD:
          remoteRef:
            key: "homarr-database"
            property: "password"
```

## Security Best Practices

### 1. Use API Keys

Prefer API key authentication over master password.

### 2. Rotate Credentials

```bash
# Update credentials
kubectl create secret generic bitwarden-credentials \
  --namespace bitwarden-eso-provider \
  --from-literal=clientId='new-client-id' \
  --from-literal=clientSecret='new-client-secret' \
  --dry-run=client -o yaml | kubectl apply -f -

# Restart provider
kubectl rollout restart deployment/bitwarden-eso-provider -n bitwarden-eso-provider
```

### 3. Enable Network Policies

```yaml
networkPolicy:
  enabled: true
```

### 4. Use RBAC

Restrict which namespaces can access the ClusterSecretStore:

```yaml
externalSecretsOperator:
  namespaced: true  # Create per-namespace SecretStores instead
```

## Monitoring

### Prometheus Metrics

```yaml
metrics:
  enabled: true
  serviceMonitor:
    enabled: true
```

Metrics exposed at `/metrics`:
- Request counts
- Latency
- Cache hit rate
- Session health

### Health Checks

- **Liveness**: `GET /healthz`
- **Readiness**: `GET /readyz`

## Troubleshooting

### Check Provider Logs

```bash
kubectl logs -n bitwarden-eso-provider -l app.kubernetes.io/name=bitwarden-eso-provider
```

### Check ExternalSecret Status

```bash
kubectl describe externalsecret my-app-secrets
```

### Test Webhook Manually

```bash
# Port-forward to provider
kubectl port-forward -n bitwarden-eso-provider svc/bitwarden-eso-provider 8080:8080

# Get API token
API_TOKEN=$(kubectl get secret -n bitwarden-eso-provider bitwarden-eso-provider-api-token -o jsonpath='{.data.token}' | base64 -d)

# Test request
curl -X POST http://localhost:8080/api/v1/secret \
  -H "Authorization: Bearer $API_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"itemId": "your-item-name", "field": "password"}'
```

### Common Issues

#### "Session expired" errors

Increase session TTL:

```yaml
bitwarden:
  sessionTTL: 7200  # 2 hours
```

#### "Field not found" errors

Check the field name in Bitwarden vault. Use `field:FieldName` for custom fields.

#### Rate limiting

Adjust sync interval:

```yaml
bitwarden:
  syncInterval: 600  # 10 minutes
```

## Performance Tuning

### Caching

```yaml
cache:
  enabled: true
  ttl: 60  # seconds
  maxSize: 1000  # items
```

### Scaling

```yaml
replicaCount: 3

affinity:
  podAntiAffinity:
    preferredDuringSchedulingIgnoredDuringExecution:
    - weight: 100
      podAffinityTerm:
        labelSelector:
          matchExpressions:
          - key: app.kubernetes.io/name
            operator: In
            values:
            - bitwarden-eso-provider
        topologyKey: kubernetes.io/hostname
```

## Development

### Build Docker Image

```bash
cd charts/bitwarden-eso-provider
docker build -t ghcr.io/codefuturist/bitwarden-eso-provider:latest .
```

### Run Locally

```bash
export BW_CLIENTID="your-client-id"
export BW_CLIENTSECRET="your-client-secret"
export API_TOKEN="test-token"
export BW_AUTH_METHOD="apikey"

cd app
pip install -r requirements.txt
python app.py
```

## Contributing

Contributions welcome! Please see [CONTRIBUTING.md](../../docs/CONTRIBUTING.md).

## Support

For bug reports, feature requests, and general questions:

- **GitHub Issues**: [Report a bug or request a feature](https://github.com/codefuturist/helm-charts/issues)
- **GitHub Discussions**: [Ask questions and discuss ideas](https://github.com/codefuturist/helm-charts/discussions)

## License

This Helm chart is licensed under the [Apache License 2.0](../../LICENSE).

## Maintainers

| Name | Email | GitHub |
|------|-------|--------|
| codefuturist | - | [@codefuturist](https://github.com/codefuturist) |

## Source Code

- **Chart Repository**: <https://github.com/codefuturist/helm-charts/tree/main/charts/bitwarden-eso-provider>
- **Application Repository**: <https://github.com/codefuturist/helm-charts/tree/main/apps/bitwarden-eso-provider-app>

## Acknowledgments

- [External Secrets Operator](https://external-secrets.io/)
- [Bitwarden](https://bitwarden.com/)
- [Bitwarden CLI](https://bitwarden.com/help/cli/)
