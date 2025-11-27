# semaphore FluxCD Application

FluxCD manifests for deploying semaphore (version 1.3.0) using GitOps.

## Structure

```
semaphore-app/
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
kubectl apply -k apps/semaphore-app/overlays/k3s-prod
```

### GitOps with FluxCD

```yaml
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: semaphore
  namespace: flux-system
spec:
  interval: 10m
  path: ./apps/semaphore-app/overlays/k3s-prod
  prune: true
  sourceRef:
    kind: GitRepository
    name: helm-charts
  targetNamespace: semaphore
```

## Monitoring

```bash
# Check status
kubectl get helmrelease -n semaphore

# Check pods
kubectl get pods -n semaphore

# View logs
kubectl logs -n semaphore -l app.kubernetes.io/name=semaphore -f
```

## Uninstall

```bash
kubectl delete -k apps/semaphore-app/overlays/k3s-prod
```
