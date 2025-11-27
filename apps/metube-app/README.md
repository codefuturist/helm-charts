# metube FluxCD Application

FluxCD manifests for deploying metube (version 1.0.0) using GitOps.

## Structure

```
metube-app/
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
kubectl apply -k apps/metube-app/overlays/k3s-prod
```

### GitOps with FluxCD

```yaml
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: metube
  namespace: flux-system
spec:
  interval: 10m
  path: ./apps/metube-app/overlays/k3s-prod
  prune: true
  sourceRef:
    kind: GitRepository
    name: helm-charts
  targetNamespace: metube
```

## Monitoring

```bash
# Check status
kubectl get helmrelease -n metube

# Check pods
kubectl get pods -n metube

# View logs
kubectl logs -n metube -l app.kubernetes.io/name=metube -f
```

## Uninstall

```bash
kubectl delete -k apps/metube-app/overlays/k3s-prod
```
