# Example: Using Bitwarden secrets in your Helm chart

## Step 1: Install Bitwarden ESO Provider

```bash
helm install bitwarden-eso-provider codefuturist/bitwarden-eso-provider \
  --namespace bitwarden-eso-provider \
  --create-namespace \
  -f values-production.yaml
```

## Step 2: Create Bitwarden Items

In your Bitwarden vault, create items with the secrets you need:

### Example: Database Credentials
- **Name**: `myapp-database`
- **Username**: `dbuser`
- **Password**: `super-secret-password`
- **Custom Fields**:
  - `DB_HOST`: `postgresql.default.svc.cluster.local`
  - `DB_PORT`: `5432`
  - `DB_NAME`: `myapp`

### Example: API Keys
- **Name**: `myapp-api-keys`
- **Custom Fields**:
  - `STRIPE_API_KEY`: `sk_live_...`
  - `SENDGRID_API_KEY`: `SG....`
  - `JWT_SECRET`: `...`

## Step 3: Create ExternalSecret

```yaml
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: myapp-secrets
  namespace: default
spec:
  refreshInterval: 5m

  secretStoreRef:
    name: bitwarden
    kind: ClusterSecretStore

  target:
    name: myapp-secrets
    creationPolicy: Owner
    template:
      type: Opaque
      metadata:
        labels:
          app: myapp

  data:
    # Database credentials
    - secretKey: DB_USERNAME
      remoteRef:
        key: "myapp-database"
        property: "username"

    - secretKey: DB_PASSWORD
      remoteRef:
        key: "myapp-database"
        property: "password"

    - secretKey: DB_HOST
      remoteRef:
        key: "myapp-database"
        property: "field:DB_HOST"

    - secretKey: DB_PORT
      remoteRef:
        key: "myapp-database"
        property: "field:DB_PORT"

    - secretKey: DB_NAME
      remoteRef:
        key: "myapp-database"
        property: "field:DB_NAME"

    # API Keys
    - secretKey: STRIPE_API_KEY
      remoteRef:
        key: "myapp-api-keys"
        property: "field:STRIPE_API_KEY"

    - secretKey: SENDGRID_API_KEY
      remoteRef:
        key: "myapp-api-keys"
        property: "field:SENDGRID_API_KEY"

    - secretKey: JWT_SECRET
      remoteRef:
        key: "myapp-api-keys"
        property: "field:JWT_SECRET"
```

## Step 4: Use in Your Application

### Option A: Environment Variables

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp
spec:
  template:
    spec:
      containers:
      - name: app
        image: myapp:latest
        envFrom:
        - secretRef:
            name: myapp-secrets
```

### Option B: Volume Mounts

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp
spec:
  template:
    spec:
      containers:
      - name: app
        image: myapp:latest
        volumeMounts:
        - name: secrets
          mountPath: /secrets
          readOnly: true
      volumes:
      - name: secrets
        secret:
          secretName: myapp-secrets
```

### Option C: With Your Helm Charts (homarr example)

```yaml
# homarr values.yaml
externalSecret:
  enabled: true
  secretStore:
    name: bitwarden
    kind: ClusterSecretStore
  refreshInterval: "5m"

  files:
    main:
      type: Opaque
      data:
        SECRET_ENCRYPTION_KEY:
          remoteRef:
            key: "homarr-config"
            property: "field:encryption_key"

        DB_PASSWORD:
          remoteRef:
            key: "homarr-database"
            property: "password"

        DB_USER:
          remoteRef:
            key: "homarr-database"
            property: "username"

deployment:
  env:
    SECRET_ENCRYPTION_KEY:
      valueFrom:
        secretKeyRef:
          name: homarr-main
          key: SECRET_ENCRYPTION_KEY

    DB_PASSWORD:
      valueFrom:
        secretKeyRef:
          name: homarr-main
          key: DB_PASSWORD

    DB_USER:
      valueFrom:
        secretKeyRef:
          name: homarr-main
          key: DB_USER
```

## Step 5: Verify

```bash
# Check ExternalSecret status
kubectl describe externalsecret myapp-secrets

# Verify secret was created
kubectl get secret myapp-secrets -o yaml

# Check logs
kubectl logs -n bitwarden-eso-provider -l app.kubernetes.io/name=bitwarden-eso-provider
```

## Advanced Usage

### Using Item UUIDs

For better security, use item UUIDs instead of names:

1. Get item UUID:
```bash
bw list items --search "myapp-database" | jq '.[0].id'
```

2. Use in ExternalSecret:
```yaml
data:
  - secretKey: DB_PASSWORD
    remoteRef:
      key: "a1b2c3d4-e5f6-1234-5678-9abcdefghijk"
      property: "password"
```

### Multiple Vaults/Organizations

Deploy separate instances per organization:

```bash
helm install bw-org1 codefuturist/bitwarden-eso-provider \
  --namespace bw-org1 \
  --set externalSecretsOperator.secretStore.name=bitwarden-org1 \
  --set bitwarden.auth.existingSecret.name=org1-credentials

helm install bw-org2 codefuturist/bitwarden-eso-provider \
  --namespace bw-org2 \
  --set externalSecretsOperator.secretStore.name=bitwarden-org2 \
  --set bitwarden.auth.existingSecret.name=org2-credentials
```

### Secret Rotation

When you update a secret in Bitwarden, it will automatically sync based on `refreshInterval`:

```yaml
spec:
  refreshInterval: 1m  # Check every minute
```

To force immediate sync:

```bash
kubectl annotate externalsecret myapp-secrets \
  force-sync="$(date +%s)" \
  --overwrite
```
