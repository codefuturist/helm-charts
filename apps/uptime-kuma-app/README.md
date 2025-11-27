# uptime-kuma FluxCD Application

FluxCD manifests for deploying uptime-kuma (version 1.0.0) using GitOps.

## Structure

```
uptime-kuma-app/
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
kubectl apply -k apps/uptime-kuma-app/overlays/k3s-prod
```

### GitOps with FluxCD

```yaml
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: uptime-kuma
  namespace: flux-system
spec:
  interval: 10m
  path: ./apps/uptime-kuma-app/overlays/k3s-prod
  prune: true
  sourceRef:
    kind: GitRepository
    name: helm-charts
  targetNamespace: uptime-kuma
```

## Monitoring

```bash
# Check status
kubectl get helmrelease -n uptime-kuma

# Check pods
kubectl get pods -n uptime-kuma

# View logs
kubectl logs -n uptime-kuma -l app.kubernetes.io/name=uptime-kuma -f
```

## Uninstall

```bash
kubectl delete -k apps/uptime-kuma-app/overlays/k3s-prod
```
