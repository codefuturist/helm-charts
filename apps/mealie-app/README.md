# mealie FluxCD Application

FluxCD manifests for deploying mealie (version 0.1.0) using GitOps.

## Structure

```
mealie-app/
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
kubectl apply -k apps/mealie-app/overlays/k3s-prod
```

### GitOps with FluxCD

```yaml
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: mealie
  namespace: flux-system
spec:
  interval: 10m
  path: ./apps/mealie-app/overlays/k3s-prod
  prune: true
  sourceRef:
    kind: GitRepository
    name: helm-charts
  targetNamespace: mealie
```

## Monitoring

```bash
# Check status
kubectl get helmrelease -n mealie

# Check pods
kubectl get pods -n mealie

# View logs
kubectl logs -n mealie -l app.kubernetes.io/name=mealie -f
```

## Uninstall

```bash
kubectl delete -k apps/mealie-app/overlays/k3s-prod
```
