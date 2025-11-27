# proxmox-backup-server FluxCD Application

FluxCD manifests for deploying proxmox-backup-server (version 1.0.0) using GitOps.

## Structure

```
proxmox-backup-server-app/
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
kubectl apply -k apps/proxmox-backup-server-app/overlays/k3s-prod
```

### GitOps with FluxCD

```yaml
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: proxmox-backup-server
  namespace: flux-system
spec:
  interval: 10m
  path: ./apps/proxmox-backup-server-app/overlays/k3s-prod
  prune: true
  sourceRef:
    kind: GitRepository
    name: helm-charts
  targetNamespace: proxmox-backup-server
```

## Monitoring

```bash
# Check status
kubectl get helmrelease -n proxmox-backup-server

# Check pods
kubectl get pods -n proxmox-backup-server

# View logs
kubectl logs -n proxmox-backup-server -l app.kubernetes.io/name=proxmox-backup-server -f
```

## Uninstall

```bash
kubectl delete -k apps/proxmox-backup-server-app/overlays/k3s-prod
```
