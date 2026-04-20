# Proton Pass ESO Provider

A webhook provider for [External Secrets Operator](https://external-secrets.io/) that fetches secrets from [Proton Pass](https://proton.me/pass) vaults using the official [pass-cli](https://protonpass.github.io/pass-cli/).

## Overview

This chart deploys a lightweight FastAPI microservice that bridges Proton Pass with Kubernetes External Secrets Operator. It allows you to store secrets in Proton Pass and have them automatically synced to Kubernetes Secrets.

```
External Secrets Operator → Webhook → protonpass-eso-provider → pass-cli → Proton Pass API
```

## Quick Start

### 1. Create a Proton Pass credentials secret

```bash
# Create and encrypt with SOPS
cat > protonpass-credentials.yaml <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: protonpass-credentials
  namespace: protonpass-eso-provider
type: Opaque
stringData:
  username: "your-email@example.com"
  password: "your-proton-password"
EOF

sops --encrypt --in-place protonpass-credentials.yaml
```

### 2. Install the chart

```bash
helm install protonpass-eso-provider charts/apps/protonpass-eso-provider \
  --namespace protonpass-eso-provider \
  --create-namespace \
  --set protonpass.auth.existingSecret.name=protonpass-credentials \
  --set protonpass.vaults.shared="Company Secrets"
```

### 3. Use it in your applications

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
  data:
    - secretKey: DB_PASSWORD
      remoteRef:
        key: "my-database" # Proton Pass item title or ID
        property: "password" # Field name
    - secretKey: API_KEY
      remoteRef:
        key: "api-keys"
        property: "api_key" # Custom field name
```

## Parameters

### Proton Pass Authentication

| Parameter                                    | Description                                    | Default      |
| -------------------------------------------- | ---------------------------------------------- | ------------ |
| `protonpass.auth.existingSecret.name`        | Existing K8s secret with credentials           | `""`         |
| `protonpass.auth.existingSecret.usernameKey` | Key for username                               | `"username"` |
| `protonpass.auth.existingSecret.passwordKey` | Key for password                               | `"password"` |
| `protonpass.auth.credentials.username`       | Username (not for production)                  | `""`         |
| `protonpass.auth.credentials.password`       | Password (not for production)                  | `""`         |
| `protonpass.keyProvider`                     | pass-cli key provider (`fs`, `env`, `keyring`) | `"fs"`       |

### Vault Access Control

| Parameter                   | Description                       | Default |
| --------------------------- | --------------------------------- | ------- |
| `protonpass.vaults.shared`  | Default/shared company vault name | `""`    |
| `protonpass.vaults.allowed` | Allowed vault names (empty = all) | `[]`    |
| `protonpass.vaults.denied`  | Denied vault names                | `[]`    |

### Cache Configuration

| Parameter                     | Description              | Default |
| ----------------------------- | ------------------------ | ------- |
| `protonpass.cache.enabled`    | Enable in-memory caching | `true`  |
| `protonpass.cache.ttlSeconds` | Cache TTL                | `300`   |
| `protonpass.cache.maxEntries` | Max cached secrets       | `1000`  |

### External Secrets Operator

| Parameter                                   | Description                 | Default        |
| ------------------------------------------- | --------------------------- | -------------- |
| `externalSecretsOperator.createSecretStore` | Create SecretStore resource | `true`         |
| `externalSecretsOperator.namespaced`        | Use namespaced SecretStore  | `false`        |
| `externalSecretsOperator.secretStore.name`  | Store name                  | `"protonpass"` |
| `externalSecretsOperator.timeout`           | Webhook timeout             | `"10s"`        |

### API Authentication

| Parameter                 | Description                         | Default |
| ------------------------- | ----------------------------------- | ------- |
| `api.existingSecret.name` | Existing secret for webhook token   | `""`    |
| `api.token`               | Token value (empty = auto-generate) | `""`    |

## Architecture

The provider runs as a single-container deployment:

1. On startup, it authenticates with Proton Pass using `pass-cli login`
2. ESO sends webhook requests with `itemId` and `field`
3. The provider resolves the secret reference via `pass-cli inject`
4. Results are cached in-memory (configurable TTL) to reduce API calls
5. Health probes verify the pass-cli session is valid

## Security

- Credentials stored in Kubernetes Secrets (encrypt with SOPS)
- Network policies restrict access to ESO namespace only
- API token authenticates webhook requests
- Session data stored in ephemeral emptyDir volume
- Container runs as non-root with dropped capabilities
- Secret values are never logged
