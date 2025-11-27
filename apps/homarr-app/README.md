# homarr FluxCD Application

FluxCD manifests for deploying homarr (version 1.0.0) using GitOps.

## Structure

```
homarr-app/
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
kubectl apply -k apps/homarr-app/overlays/k3s-prod
```

### GitOps with FluxCD

```yaml
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: homarr
  namespace: flux-system
spec:
  interval: 10m
  path: ./apps/homarr-app/overlays/k3s-prod
  prune: true
  sourceRef:
    kind: GitRepository
    name: helm-charts
  targetNamespace: homarr
```

## Monitoring

```bash
# Check status
kubectl get helmrelease -n homarr

# Check pods
kubectl get pods -n homarr

# View logs
kubectl logs -n homarr -l app.kubernetes.io/name=homarr -f
```

## Uninstall

```bash
kubectl delete -k apps/homarr-app/overlays/k3s-prod
```
