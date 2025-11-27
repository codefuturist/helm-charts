# redisinsight FluxCD Application

FluxCD manifests for deploying redisinsight (version 1.0.0) using GitOps.

## Structure

```
redisinsight-app/
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
kubectl apply -k apps/redisinsight-app/overlays/k3s-prod
```

### GitOps with FluxCD

```yaml
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: redisinsight
  namespace: flux-system
spec:
  interval: 10m
  path: ./apps/redisinsight-app/overlays/k3s-prod
  prune: true
  sourceRef:
    kind: GitRepository
    name: helm-charts
  targetNamespace: redisinsight
```

## Monitoring

```bash
# Check status
kubectl get helmrelease -n redisinsight

# Check pods
kubectl get pods -n redisinsight

# View logs
kubectl logs -n redisinsight -l app.kubernetes.io/name=redisinsight -f
```

## Uninstall

```bash
kubectl delete -k apps/redisinsight-app/overlays/k3s-prod
```
