# nginx FluxCD Application

FluxCD manifests for deploying nginx (version 22.1.0) using GitOps.

## Structure

```
nginx-app/
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
kubectl apply -k apps/nginx-app/overlays/k3s-prod
```

### GitOps with FluxCD

```yaml
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: nginx
  namespace: flux-system
spec:
  interval: 10m
  path: ./apps/nginx-app/overlays/k3s-prod
  prune: true
  sourceRef:
    kind: GitRepository
    name: helm-charts
  targetNamespace: nginx
```

## Monitoring

```bash
# Check status
kubectl get helmrelease -n nginx

# Check pods
kubectl get pods -n nginx

# View logs
kubectl logs -n nginx -l app.kubernetes.io/name=nginx -f
```

## Uninstall

```bash
kubectl delete -k apps/nginx-app/overlays/k3s-prod
```
