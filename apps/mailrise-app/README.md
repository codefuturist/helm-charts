# mailrise FluxCD Application

FluxCD manifests for deploying mailrise (version 1.0.0) using GitOps.

## Structure

```
mailrise-app/
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
kubectl apply -k apps/mailrise-app/overlays/k3s-prod
```

### GitOps with FluxCD

```yaml
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: mailrise
  namespace: flux-system
spec:
  interval: 10m
  path: ./apps/mailrise-app/overlays/k3s-prod
  prune: true
  sourceRef:
    kind: GitRepository
    name: helm-charts
  targetNamespace: mailrise
```

## Monitoring

```bash
# Check status
kubectl get helmrelease -n mailrise

# Check pods
kubectl get pods -n mailrise

# View logs
kubectl logs -n mailrise -l app.kubernetes.io/name=mailrise -f
```

## Uninstall

```bash
kubectl delete -k apps/mailrise-app/overlays/k3s-prod
```
