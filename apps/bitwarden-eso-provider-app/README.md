# bitwarden-eso-provider FluxCD Application

FluxCD manifests for deploying bitwarden-eso-provider (version 1.0.0) using GitOps.

## Structure

```
bitwarden-eso-provider-app/
├── base/
│   ├── namespace.yaml
│   ├── helmrepository.yaml
│   ├── helmrelease.yaml
│   └── kustomization.yaml
└── overlays/
    └── k3s-prod/
        ├── helmrelease-patch.yaml
        └── kustomization.yaml
```

## Deployment

### Apply directly

```bash
kubectl apply -k apps/bitwarden-eso-provider-app/overlays/k3s-prod
```

### GitOps with FluxCD

```yaml
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: bitwarden-eso-provider
  namespace: flux-system
spec:
  interval: 10m
  path: ./apps/bitwarden-eso-provider-app/overlays/k3s-prod
  prune: true
  sourceRef:
    kind: GitRepository
    name: helm-charts
  targetNamespace: bitwarden-eso-provider
```

## Monitoring

```bash
# Check status
kubectl get helmrelease -n bitwarden-eso-provider

# Check pods
kubectl get pods -n bitwarden-eso-provider

# View logs
kubectl logs -n bitwarden-eso-provider -l app.kubernetes.io/name=bitwarden-eso-provider -f
```

## Uninstall

```bash
kubectl delete -k apps/bitwarden-eso-provider-app/overlays/k3s-prod
```
