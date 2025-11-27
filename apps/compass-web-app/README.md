# compass-web FluxCD Application

FluxCD manifests for deploying compass-web (version 1.0.0) using GitOps.

## Structure

```
compass-web-app/
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
kubectl apply -k apps/compass-web-app/overlays/k3s-prod
```

### GitOps with FluxCD

```yaml
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: compass-web
  namespace: flux-system
spec:
  interval: 10m
  path: ./apps/compass-web-app/overlays/k3s-prod
  prune: true
  sourceRef:
    kind: GitRepository
    name: helm-charts
  targetNamespace: compass-web
```

## Monitoring

```bash
# Check status
kubectl get helmrelease -n compass-web

# Check pods
kubectl get pods -n compass-web

# View logs
kubectl logs -n compass-web -l app.kubernetes.io/name=compass-web -f
```

## Uninstall

```bash
kubectl delete -k apps/compass-web-app/overlays/k3s-prod
```
