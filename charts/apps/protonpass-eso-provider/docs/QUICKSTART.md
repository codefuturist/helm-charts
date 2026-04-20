# Quick Start: Proton Pass ESO Provider

Get secrets from Proton Pass into your Kubernetes cluster in 5 minutes.

## Prerequisites

- Kubernetes cluster with [External Secrets Operator](https://external-secrets.io/) installed
- A Proton Pass account with vaults containing your secrets
- Helm 3.x

## Step 1: Prepare Credentials

Create a Kubernetes Secret with your Proton Pass credentials:

```yaml
# protonpass-credentials.yaml
apiVersion: v1
kind: Secret
metadata:
  name: protonpass-credentials
  namespace: protonpass-eso-provider
type: Opaque
stringData:
  username: "your-email@proton.me"
  password: "your-proton-password"
```

> **Production tip**: Encrypt this file with SOPS before committing:
>
> ```bash
> just sops-encrypt protonpass-credentials.yaml
> ```

## Step 2: Install the Chart

```bash
# Minimal installation
helm install protonpass-eso-provider charts/apps/protonpass-eso-provider \
  --namespace protonpass-eso-provider \
  --create-namespace \
  -f values-minimal.yaml

# Or with inline values
helm install protonpass-eso-provider charts/apps/protonpass-eso-provider \
  --namespace protonpass-eso-provider \
  --create-namespace \
  --set protonpass.auth.existingSecret.name=protonpass-credentials \
  --set protonpass.vaults.shared="Company Secrets"
```

## Step 3: Verify

```bash
# Check the pod is running
kubectl get pods -n protonpass-eso-provider

# Check the ClusterSecretStore is created
kubectl get clustersecretstore protonpass

# Check logs
kubectl logs -n protonpass-eso-provider -l app.kubernetes.io/name=protonpass-eso-provider
```

## Step 4: Create an ExternalSecret

```yaml
apiVersion: external-secrets.io/v1
kind: ExternalSecret
metadata:
  name: my-app-secrets
  namespace: my-app
spec:
  refreshInterval: "5m"
  secretStoreRef:
    name: protonpass
    kind: ClusterSecretStore
  data:
    - secretKey: DATABASE_PASSWORD
      remoteRef:
        key: "My Database" # Item title in Proton Pass
        property: "password" # Field name
    - secretKey: API_KEY
      remoteRef:
        key: "API Keys"
        property: "api_key" # Custom field name
```

## Step 5: Use the Secret in Your App

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
spec:
  template:
    spec:
      containers:
        - name: app
          envFrom:
            - secretRef:
                name: my-app-secrets
```

## What's Next?

- Set up [network policies](../values.yaml) to restrict access
- Enable [monitoring](../values.yaml) with Prometheus ServiceMonitor
- Configure [vault access control](../values.yaml) with allow/deny lists
- Use [profiles](../../../../docs/secrets/protonpass-profiles.md) for local development
