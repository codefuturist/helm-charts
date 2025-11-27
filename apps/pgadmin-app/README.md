# pgAdmin FluxCD Application

This directory contains FluxCD manifests for deploying pgAdmin 4 using GitOps.

## Structure

```
pgadmin-app/
├── base/
│   ├── namespace.yaml           # pgadmin namespace
│   ├── helmrepository.yaml      # Helm repository source
│   ├── helmrelease.yaml         # Base HelmRelease configuration
│   └── kustomization.yaml       # Base kustomization
└── overlays/
    └── k3s-prod/
        ├── helmrelease-patch.yaml   # Production-specific overrides
        └── kustomization.yaml       # Overlay kustomization
```

## Prerequisites

1. FluxCD installed in the cluster
2. Flux HelmController and SourceController running

## Deployment

### Option 1: Apply directly with kubectl

```bash
# Deploy to production
kubectl apply -k apps/pgadmin-app/overlays/k3s-prod
```

### Option 2: Let FluxCD manage it (GitOps)

Create a Flux Kustomization that points to this directory:

```yaml
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: pgadmin
  namespace: flux-system
spec:
  interval: 10m
  path: ./apps/pgadmin-app/overlays/k3s-prod
  prune: true
  sourceRef:
    kind: GitRepository
    name: helm-charts
  targetNamespace: pgadmin
```

## Configuration

### Base Configuration

The base configuration (`base/helmrelease.yaml`) includes:
- Image: `dpage/pgadmin4:9.10.0`
- Persistence: 5Gi
- Resources: 500m CPU / 512Mi RAM (requests), 2000m CPU / 1Gi RAM (limits)
- Service: ClusterIP (default)

### Production Overlay (k3s-prod)

The production overlay adds:
- NodePort service on port 30080
- Uses existing secret for credentials (create manually)

## Secrets

Create the pgadmin credentials secret before deploying:

```bash
kubectl create secret generic pgadmin-credentials \
  --namespace pgadmin \
  --from-literal=email=admin@example.com \
  --from-literal=password=YourSecurePassword
```

Or use SOPS/Sealed Secrets for encrypted secrets in Git.

## Access

After deployment, access pgAdmin at:
- **NodePort**: `http://<node-ip>:30080`
- **Port Forward**: `kubectl port-forward -n pgadmin svc/pgadmin 8080:80`

## Monitoring

Check deployment status:

```bash
# Check HelmRelease status
kubectl get helmrelease -n pgadmin

# Check pods
kubectl get pods -n pgadmin

# View logs
kubectl logs -n pgadmin -l app.kubernetes.io/name=pgadmin -f
```

## Customization

To customize for your environment:

1. Create a new overlay directory under `overlays/`
2. Add environment-specific patches
3. Update the kustomization to reference the base

Example for a new environment:

```bash
mkdir -p overlays/my-env
cat > overlays/my-env/kustomization.yaml <<EOF
---
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

namespace: pgadmin

resources:
  - ../../base

patches:
  - path: helmrelease-patch.yaml
EOF
```

## Uninstall

```bash
kubectl delete -k apps/pgadmin-app/overlays/k3s-prod
```

Or let FluxCD handle it by removing the Kustomization resource.
