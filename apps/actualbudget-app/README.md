# actualbudget FluxCD Application

FluxCD manifests for deploying actualbudget (version 1.0.0) using GitOps.

## Structure

```
actualbudget-app/
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
kubectl apply -k apps/actualbudget-app/overlays/k3s-prod
```

### GitOps with FluxCD

```yaml
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: actualbudget
  namespace: flux-system
spec:
  interval: 10m
  path: ./apps/actualbudget-app/overlays/k3s-prod
  prune: true
  sourceRef:
    kind: GitRepository
    name: helm-charts
  targetNamespace: actualbudget
```

## Monitoring

```bash
# Check status
kubectl get helmrelease -n actualbudget

# Check pods
kubectl get pods -n actualbudget

# View logs
kubectl logs -n actualbudget -l app.kubernetes.io/name=actualbudget -f
```

## Uninstall

```bash
kubectl delete -k apps/actualbudget-app/overlays/k3s-prod
```
