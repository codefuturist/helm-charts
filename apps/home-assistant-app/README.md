# home-assistant FluxCD Application

FluxCD manifests for deploying home-assistant (version 1.0.0) using GitOps.

## Structure

```
home-assistant-app/
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
kubectl apply -k apps/home-assistant-app/overlays/k3s-prod
```

### GitOps with FluxCD

```yaml
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: home-assistant
  namespace: flux-system
spec:
  interval: 10m
  path: ./apps/home-assistant-app/overlays/k3s-prod
  prune: true
  sourceRef:
    kind: GitRepository
    name: helm-charts
  targetNamespace: home-assistant
```

## Monitoring

```bash
# Check status
kubectl get helmrelease -n home-assistant

# Check pods
kubectl get pods -n home-assistant

# View logs
kubectl logs -n home-assistant -l app.kubernetes.io/name=home-assistant -f
```

## Uninstall

```bash
kubectl delete -k apps/home-assistant-app/overlays/k3s-prod
```
