# Proton Pass — Kubernetes Integration

This guide covers deploying and using the Proton Pass ESO Provider in Kubernetes.

## Architecture

```
ExternalSecret CR  →  ESO Controller  →  ClusterSecretStore (webhook)
                                              │
                                              ▼
                                    protonpass-eso-provider (FastAPI)
                                              │
                                              ▼
                                        Proton Pass API
```

## Prerequisites

1. **External Secrets Operator** installed in cluster
2. **Proton Pass account** with a service/shared vault
3. **Kubernetes secret** with Proton Pass credentials

## Installation

### 1. Create Credentials Secret

```bash
# Using SOPS (recommended)
cat > protonpass-credentials.yaml <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: protonpass-credentials
  namespace: protonpass-eso-provider
type: Opaque
stringData:
  username: "your-proton-email@proton.me"
  password: "your-proton-password"
EOF

sops --encrypt --in-place protonpass-credentials.yaml
```

Or generate from your local Proton Pass session:

```bash
just protonpass-k8s-secret protonpass-eso-provider protonpass-credentials
```

### 2. Install the Chart

```bash
helm install protonpass-eso-provider charts/apps/protonpass-eso-provider \
  --namespace protonpass-eso-provider \
  --create-namespace \
  -f charts/apps/protonpass-eso-provider/examples/values-production.yaml
```

### 3. Verify

```bash
# Check pod is running
kubectl get pods -n protonpass-eso-provider

# Check ClusterSecretStore is ready
kubectl get clustersecretstore protonpass

# Check health
kubectl port-forward -n protonpass-eso-provider svc/protonpass-eso-provider 8080:8080
curl http://localhost:8080/healthz
```

## Using ExternalSecrets

### Basic ExternalSecret

```yaml
apiVersion: external-secrets.io/v1
kind: ExternalSecret
metadata:
  name: my-app-secrets
spec:
  refreshInterval: "5m"
  secretStoreRef:
    name: protonpass
    kind: ClusterSecretStore
  target:
    name: my-app-secrets
  data:
    - secretKey: DATABASE_PASSWORD
      remoteRef:
        key: "MyApp Database" # Proton Pass item title
        property: "password" # Field name
```

### Multiple Secrets from One Item

```yaml
data:
  - secretKey: DB_HOST
    remoteRef:
      key: "MyApp Database"
      property: "url"
  - secretKey: DB_USER
    remoteRef:
      key: "MyApp Database"
      property: "username"
  - secretKey: DB_PASS
    remoteRef:
      key: "MyApp Database"
      property: "password"
```

### Specifying a Vault

If you have multiple vaults, specify which one to use:

```yaml
data:
  - secretKey: API_KEY
    remoteRef:
      key: "API Keys"
      property: "myapp_key"
      # The vault is specified at the provider level via values.yaml
```

## Generating ExternalSecrets from Profiles

If you're using the profile system locally, generate ExternalSecret manifests:

```bash
just protonpass-k8s-eso myapp-dev
```

This reads your profile mappings and outputs a valid ExternalSecret YAML.

## Monitoring

When metrics are enabled:

```yaml
metrics:
  enabled: true
  serviceMonitor:
    enabled: true
```

Available Prometheus metrics:

- `protonpass_secret_requests_total` — total requests
- `protonpass_cache_hits_total` — cache hit rate
- `protonpass_session_refresh_total` — auth refreshes

## Troubleshooting

| Symptom                             | Likely Cause            | Fix                                  |
| ----------------------------------- | ----------------------- | ------------------------------------ |
| SecretStore shows `InvalidProvider` | Provider pod not ready  | Check pod logs                       |
| `401 Unauthorized`                  | Wrong API token         | Verify `api.token` matches           |
| `Secret not found`                  | Wrong item name         | Use exact Proton Pass item title     |
| `Vault access denied`               | Vault not in allow-list | Add to `protonpass.vaults.allowed`   |
| Stale secrets                       | Cache TTL too long      | Reduce `protonpass.cache.ttlSeconds` |
