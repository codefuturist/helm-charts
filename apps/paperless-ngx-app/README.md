# paperless-ngx FluxCD Application

FluxCD manifests for deploying paperless-ngx (version 0.1.0) using GitOps.

## Structure

```
paperless-ngx-app/
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
kubectl apply -k apps/paperless-ngx-app/overlays/k3s-prod
```

### GitOps with FluxCD

```yaml
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: paperless-ngx
  namespace: flux-system
spec:
  interval: 10m
  path: ./apps/paperless-ngx-app/overlays/k3s-prod
  prune: true
  sourceRef:
    kind: GitRepository
    name: helm-charts
  targetNamespace: paperless-ngx
```

## Monitoring

```bash
# Check status
kubectl get helmrelease -n paperless-ngx

# Check pods
kubectl get pods -n paperless-ngx

# View logs
kubectl logs -n paperless-ngx -l app.kubernetes.io/name=paperless-ngx -f
```

## Uninstall

```bash
kubectl delete -k apps/paperless-ngx-app/overlays/k3s-prod
```
