# FluxCD Applications

This directory contains FluxCD manifests for all Helm charts in GitOps format.

## Available Applications

| Application | Chart Version | Description |
|------------|---------------|-------------|
| actualbudget | 1.0.0 | Personal finance and budgeting tool |
| bitwarden-eso-provider | 1.0.0 | External Secrets Operator provider for Bitwarden |
| compass-web | 1.0.0 | Web-based compass application |
| homarr | 1.0.0 | Customizable homepage/dashboard |
| home-assistant | 1.0.0 | Home automation platform |
| mailrise | 1.0.0 | SMTP gateway for Apprise notifications |
| mealie | 0.1.0 | Recipe manager and meal planner |
| metube | 1.0.0 | Web GUI for youtube-dl |
| nginx | 22.1.0 | High-performance web server |
| paperless-ngx | 0.1.0 | Document management system |
| pgadmin | 1.0.1 | PostgreSQL administration tool |
| pihole | 1.0.0 | Network-wide ad blocking |
| postgresql | 1.7.0 | PostgreSQL database |
| proxmox-backup-server | 1.0.0 | Backup solution for Proxmox |
| redisinsight | 1.0.0 | Redis GUI and management tool |
| restic-backup | 1.2.0 | Backup solution using Restic |
| semaphore | 1.3.0 | Ansible UI and automation |
| shlink | 1.0.1 | URL shortener |
| uptime-kuma | 1.0.0 | Uptime monitoring tool |

## Directory Structure

Each application follows this structure:

```
<app-name>-app/
├── base/
│   ├── namespace.yaml           # Application namespace
│   ├── helmrepository.yaml      # Helm repository source
│   ├── helmrelease.yaml         # Base HelmRelease configuration
│   └── kustomization.yaml       # Base kustomization
├── overlays/
│   └── k3s-prod/
│       ├── helmrelease-patch.yaml   # Environment-specific overrides
│       └── kustomization.yaml       # Overlay kustomization
└── README.md                    # Application-specific documentation
```

## Prerequisites

1. FluxCD installed in the cluster
2. Flux HelmController and SourceController running
3. kubectl with kustomize support

Check FluxCD status:
```bash
flux check
kubectl get pods -n flux-system
```

## Deployment Methods

### Option 1: Direct kubectl apply

Deploy a specific application:
```bash
kubectl apply -k apps/<app-name>-app/overlays/k3s-prod
```

Deploy all applications:
```bash
for app in apps/*-app/overlays/k3s-prod; do
  kubectl apply -k "$app"
done
```

### Option 2: GitOps with FluxCD (Recommended)

Create a Flux Kustomization for each application:

```yaml
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: <app-name>
  namespace: flux-system
spec:
  interval: 10m
  path: ./apps/<app-name>-app/overlays/k3s-prod
  prune: true
  sourceRef:
    kind: GitRepository
    name: helm-charts
  targetNamespace: <app-name>
  healthChecks:
    - apiVersion: helm.toolkit.fluxcd.io/v2beta1
      kind: HelmRelease
      name: <app-name>
      namespace: <app-name>
```

Or create a single Kustomization to deploy all apps:

```yaml
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: all-apps
  namespace: flux-system
spec:
  interval: 10m
  path: ./apps
  prune: true
  sourceRef:
    kind: GitRepository
    name: helm-charts
```

### Option 3: Using Flux CLI

```bash
# Create a GitRepository source
flux create source git helm-charts \
  --url=https://github.com/codefuturist/helm-charts \
  --branch=main \
  --interval=1m

# Create a Kustomization for an app
flux create kustomization postgresql \
  --source=GitRepository/helm-charts \
  --path="./apps/postgresql-app/overlays/k3s-prod" \
  --prune=true \
  --interval=10m
```

## Monitoring

### Check all HelmReleases
```bash
kubectl get helmrelease -A
```

### Check specific application
```bash
# Status
kubectl get helmrelease -n <app-name>

# Detailed info
kubectl describe helmrelease -n <app-name> <app-name>

# Pods
kubectl get pods -n <app-name>

# Logs
kubectl logs -n <app-name> -l app.kubernetes.io/name=<app-name> -f
```

### Using Flux CLI
```bash
# Watch all Kustomizations
flux get kustomizations --watch

# Check HelmRelease status
flux get helmreleases -A

# Force reconciliation
flux reconcile kustomization <app-name> --with-source
```

## Customization

### Creating a New Environment Overlay

To create a new environment (e.g., staging):

```bash
mkdir -p apps/<app-name>-app/overlays/staging

cat > apps/<app-name>-app/overlays/staging/kustomization.yaml <<EOF
---
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

namespace: <app-name>

resources:
  - ../../base

patches:
  - path: helmrelease-patch.yaml
    target:
      kind: HelmRelease
      name: <app-name>
EOF

cat > apps/<app-name>-app/overlays/staging/helmrelease-patch.yaml <<EOF
---
apiVersion: helm.toolkit.fluxcd.io/v2beta1
kind: HelmRelease
metadata:
  name: <app-name>
  namespace: <app-name>
spec:
  values:
    # Staging-specific values here
    replicaCount: 1
EOF
```

### Modifying Values

Edit the `helmrelease-patch.yaml` in your overlay to customize values for your environment.

## Secrets Management

For production deployments, use one of these methods for sensitive data:

### 1. Kubernetes Secrets (Manual)
```bash
kubectl create secret generic app-credentials \
  --namespace <app-name> \
  --from-literal=password=YourSecurePassword
```

### 2. Sealed Secrets
```bash
kubeseal --format yaml < secret.yaml > sealed-secret.yaml
```

### 3. SOPS (Recommended for GitOps)
```bash
sops -e secret.yaml > secret.enc.yaml
```

### 4. External Secrets Operator
```yaml
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: app-credentials
spec:
  refreshInterval: 1h
  secretStoreRef:
    name: vault-backend
    kind: SecretStore
  target:
    name: app-credentials
  data:
    - secretKey: password
      remoteRef:
        key: app/password
```

## Troubleshooting

### HelmRelease not ready

```bash
# Check HelmRelease events
kubectl describe helmrelease -n <app-name> <app-name>

# Check Helm controller logs
kubectl logs -n flux-system -l app=helm-controller -f

# Force reconciliation
flux reconcile helmrelease -n <app-name> <app-name>
```

### Source not found

```bash
# Check HelmRepository status
kubectl get helmrepository -n <app-name>

# Force reconciliation
flux reconcile source helm -n <app-name> codefuturist
```

### Chart version not found

Update the version in `base/helmrelease.yaml`:
```yaml
spec:
  chart:
    spec:
      version: "x.y.z"  # Update this
```

## Uninstalling

### Remove specific application
```bash
kubectl delete -k apps/<app-name>-app/overlays/k3s-prod
```

### Remove all applications
```bash
for app in apps/*-app/overlays/k3s-prod; do
  kubectl delete -k "$app"
done
```

### With FluxCD (GitOps)
```bash
flux delete kustomization <app-name>
```

## Best Practices

1. **Use overlays** for environment-specific configurations
2. **Store secrets securely** using SOPS, Sealed Secrets, or External Secrets Operator
3. **Pin chart versions** in HelmRelease manifests for predictable deployments
4. **Enable health checks** in Flux Kustomizations
5. **Use GitOps** for production environments - commit changes to Git, let Flux deploy
6. **Monitor HelmReleases** regularly using Flux CLI or Kubernetes dashboard
7. **Test changes** in staging overlay before promoting to production

## Additional Resources

- [FluxCD Documentation](https://fluxcd.io/docs/)
- [Helm Charts Repository](https://github.com/codefuturist/helm-charts)
- [Kustomize Documentation](https://kubectl.docs.kubernetes.io/references/kustomize/)
