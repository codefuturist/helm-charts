# postgresql FluxCD Application

FluxCD manifests for deploying postgresql (version 1.7.0) using GitOps.

## Structure

```
postgresql-app/
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
kubectl apply -k apps/postgresql-app/overlays/k3s-prod
```

### GitOps with FluxCD

```yaml
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: postgresql
  namespace: flux-system
spec:
  interval: 10m
  path: ./apps/postgresql-app/overlays/k3s-prod
  prune: true
  sourceRef:
    kind: GitRepository
    name: helm-charts
  targetNamespace: postgresql
```

## Monitoring

```bash
# Check status
kubectl get helmrelease -n postgresql

# Check pods
kubectl get pods -n postgresql

# View logs
kubectl logs -n postgresql -l app.kubernetes.io/name=postgresql -f
```

## Uninstall

```bash
kubectl delete -k apps/postgresql-app/overlays/k3s-prod
```
