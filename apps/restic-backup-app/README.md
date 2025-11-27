# restic-backup FluxCD Application

FluxCD manifests for deploying restic-backup (version 1.2.0) using GitOps.

## Structure

```
restic-backup-app/
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
kubectl apply -k apps/restic-backup-app/overlays/k3s-prod
```

### GitOps with FluxCD

```yaml
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: restic-backup
  namespace: flux-system
spec:
  interval: 10m
  path: ./apps/restic-backup-app/overlays/k3s-prod
  prune: true
  sourceRef:
    kind: GitRepository
    name: helm-charts
  targetNamespace: restic-backup
```

## Monitoring

```bash
# Check status
kubectl get helmrelease -n restic-backup

# Check pods
kubectl get pods -n restic-backup

# View logs
kubectl logs -n restic-backup -l app.kubernetes.io/name=restic-backup -f
```

## Uninstall

```bash
kubectl delete -k apps/restic-backup-app/overlays/k3s-prod
```
