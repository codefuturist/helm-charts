# shlink FluxCD Application

FluxCD manifests for deploying shlink (version 1.0.1) using GitOps.

## Structure

```
shlink-app/
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
kubectl apply -k apps/shlink-app/overlays/k3s-prod
```

### GitOps with FluxCD

```yaml
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: shlink
  namespace: flux-system
spec:
  interval: 10m
  path: ./apps/shlink-app/overlays/k3s-prod
  prune: true
  sourceRef:
    kind: GitRepository
    name: helm-charts
  targetNamespace: shlink
```

## Monitoring

```bash
# Check status
kubectl get helmrelease -n shlink

# Check pods
kubectl get pods -n shlink

# View logs
kubectl logs -n shlink -l app.kubernetes.io/name=shlink -f
```

## Uninstall

```bash
kubectl delete -k apps/shlink-app/overlays/k3s-prod
```
