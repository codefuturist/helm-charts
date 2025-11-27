# pihole FluxCD Application

FluxCD manifests for deploying pihole (version 1.0.0) using GitOps.

## Structure

```
pihole-app/
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
kubectl apply -k apps/pihole-app/overlays/k3s-prod
```

### GitOps with FluxCD

```yaml
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: pihole
  namespace: flux-system
spec:
  interval: 10m
  path: ./apps/pihole-app/overlays/k3s-prod
  prune: true
  sourceRef:
    kind: GitRepository
    name: helm-charts
  targetNamespace: pihole
```

## Monitoring

```bash
# Check status
kubectl get helmrelease -n pihole

# Check pods
kubectl get pods -n pihole

# View logs
kubectl logs -n pihole -l app.kubernetes.io/name=pihole -f
```

## Uninstall

```bash
kubectl delete -k apps/pihole-app/overlays/k3s-prod
```
