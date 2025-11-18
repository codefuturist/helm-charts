# Quick Reference: Production Deployment

## Minimal Production Install

```bash
# 1. Create secrets
kubectl create secret generic bitwarden-credentials \
  --from-literal=clientId="user.xxx" \
  --from-literal=clientSecret="xxx"

kubectl create secret generic bitwarden-api-token \
  --from-literal=token="$(openssl rand -base64 32)"

# 2. Install chart
helm install bitwarden-eso-provider ./bitwarden-eso-provider \
  --set bitwarden.auth.existingSecret.name=bitwarden-credentials \
  --set api.existingSecret.name=bitwarden-api-token

# 3. Create SecretStore
kubectl apply -f - <<EOF
apiVersion: external-secrets.io/v1beta1
kind: ClusterSecretStore
metadata:
  name: bitwarden
spec:
  provider:
    webhook:
      url: "http://bitwarden-eso-provider.default:8080/api/v1/secret"
      result:
        jsonPath: "$.value"
      headers:
        Content-Type: application/json
        Authorization:
          secretRef:
            name: bitwarden-api-token
            namespace: default
            key: token
      body: |
        {
          "itemId": "{{ .remoteRef.key }}",
          "field": "{{ .remoteRef.property | default \"password\" }}"
        }
EOF
```

## High Availability Setup

```yaml
# values-ha.yaml
replicaCount: 3

podDisruptionBudget:
  enabled: true
  minAvailable: 2

topologySpreadConstraints:
  - maxSkew: 1
    topologyKey: topology.kubernetes.io/zone
    whenUnsatisfiable: DoNotSchedule
    labelSelector:
      matchLabels:
        app.kubernetes.io/name: bitwarden-eso-provider

autoscaling:
  enabled: true
  minReplicas: 3
  maxReplicas: 10
  targetCPUUtilizationPercentage: 70

resources:
  requests:
    cpu: 200m
    memory: 256Mi
  limits:
    cpu: 500m
    memory: 512Mi
```

```bash
helm install bitwarden-eso-provider ./bitwarden-eso-provider -f values-ha.yaml
```

## Security Hardened Setup

```yaml
# values-secure.yaml
networkPolicy:
  enabled: true
  egress:
    # Only allow HTTPS to Bitwarden
    - to:
      - namespaceSelector: {}
      ports:
      - protocol: TCP
        port: 443
    # Allow DNS
    - to:
      - namespaceSelector: {}
      ports:
      - protocol: TCP
        port: 53
      - protocol: UDP
        port: 53

priorityClassName: system-cluster-critical

podSecurityContext:
  runAsNonRoot: true
  runAsUser: 65534  # nobody
  fsGroup: 65534
  seccompProfile:
    type: RuntimeDefault

securityContext:
  allowPrivilegeEscalation: false
  readOnlyRootFilesystem: true
  capabilities:
    drop:
    - ALL
```

```bash
helm install bitwarden-eso-provider ./bitwarden-eso-provider -f values-secure.yaml
```

## Monitoring Setup

```yaml
# values-monitoring.yaml
metrics:
  enabled: true
  serviceMonitor:
    enabled: true
    interval: 30s
    labels:
      release: prometheus

logging:
  level: "info"
  format: "json"
```

```bash
helm install bitwarden-eso-provider ./bitwarden-eso-provider -f values-monitoring.yaml
```

## Common Operations

### Check Status

```bash
# Pod status
kubectl get pods -l app.kubernetes.io/name=bitwarden-eso-provider

# Logs
kubectl logs -l app.kubernetes.io/name=bitwarden-eso-provider -f

# Health check
kubectl port-forward svc/bitwarden-eso-provider 8080:8080
curl http://localhost:8080/healthz
curl http://localhost:8080/readyz

# Metrics
curl http://localhost:8080/metrics
```

### Update Deployment

```bash
# Update image
helm upgrade bitwarden-eso-provider ./bitwarden-eso-provider \
  --set image.tag=1.1.0

# Change replica count
helm upgrade bitwarden-eso-provider ./bitwarden-eso-provider \
  --set replicaCount=5

# Enable autoscaling
helm upgrade bitwarden-eso-provider ./bitwarden-eso-provider \
  --set autoscaling.enabled=true
```

### Rotate Credentials

```bash
# Update Bitwarden credentials
kubectl create secret generic bitwarden-credentials \
  --from-literal=clientId="user.new-id" \
  --from-literal=clientSecret="new-secret" \
  --dry-run=client -o yaml | kubectl apply -f -

# Restart pods to pick up new credentials
kubectl rollout restart deployment/bitwarden-eso-provider

# Update API token
kubectl create secret generic bitwarden-api-token \
  --from-literal=token="$(openssl rand -base64 32)" \
  --dry-run=client -o yaml | kubectl apply -f -

# Update SecretStore with new token
kubectl patch clustersecretstore bitwarden \
  --type merge \
  -p '{"spec":{"provider":{"webhook":{"headers":{"Authorization":{"secretRef":{"name":"bitwarden-api-token"}}}}}}}'
```

### Troubleshooting

```bash
# Get recent events
kubectl get events --sort-by=.lastTimestamp | grep bitwarden

# Check pod resource usage
kubectl top pods -l app.kubernetes.io/name=bitwarden-eso-provider

# Describe deployment
kubectl describe deployment bitwarden-eso-provider

# Shell into pod
kubectl exec -it deployment/bitwarden-eso-provider -- /bin/sh

# Test Bitwarden CLI
kubectl exec deployment/bitwarden-eso-provider -- bw --version
kubectl exec deployment/bitwarden-eso-provider -- bw status
```

### Testing ExternalSecret

```bash
# Create test ExternalSecret
kubectl apply -f - <<EOF
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: test-secret
spec:
  refreshInterval: 1h
  secretStoreRef:
    kind: ClusterSecretStore
    name: bitwarden
  target:
    name: test-secret
    creationPolicy: Owner
  data:
  - secretKey: password
    remoteRef:
      key: "item-id-or-name"
      property: password
EOF

# Check status
kubectl get externalsecret test-secret
kubectl describe externalsecret test-secret

# Verify secret was created
kubectl get secret test-secret
kubectl get secret test-secret -o jsonpath='{.data.password}' | base64 -d
```

## Performance Tuning

### High Traffic Configuration

```yaml
# For >1000 requests/minute
cache:
  enabled: true
  ttl: 300  # 5 minutes
  maxSize: 5000

bitwarden:
  sessionTTL: 7200  # 2 hours
  syncInterval: 600  # 10 minutes

resources:
  requests:
    cpu: 500m
    memory: 512Mi
  limits:
    cpu: 1000m
    memory: 1Gi

autoscaling:
  enabled: true
  minReplicas: 5
  maxReplicas: 20
  targetCPUUtilizationPercentage: 60
```

### Low Latency Configuration

```yaml
# For latency-sensitive workloads
cache:
  enabled: true
  ttl: 120  # 2 minutes
  maxSize: 10000

resources:
  requests:
    cpu: 500m
    memory: 512Mi
  limits:
    cpu: 1000m
    memory: 1Gi

# Pin to high-performance nodes
nodeSelector:
  node.kubernetes.io/instance-type: "high-cpu"

priorityClassName: high-priority
```

## Backup & Disaster Recovery

### Backup Secrets

```bash
# Export all secrets
kubectl get secret bitwarden-credentials -o yaml > bitwarden-credentials.yaml
kubectl get secret bitwarden-api-token -o yaml > bitwarden-api-token.yaml

# Backup SecretStore config
kubectl get clustersecretstore bitwarden -o yaml > clustersecretstore.yaml

# Store in secure location (encrypted!)
```

### Restore

```bash
# Restore secrets
kubectl apply -f bitwarden-credentials.yaml
kubectl apply -f bitwarden-api-token.yaml

# Restore SecretStore
kubectl apply -f clustersecretstore.yaml

# Reinstall chart
helm install bitwarden-eso-provider ./bitwarden-eso-provider \
  --set bitwarden.auth.existingSecret.name=bitwarden-credentials \
  --set api.existingSecret.name=bitwarden-api-token
```

## Values.yaml Examples

### Minimal

```yaml
bitwarden:
  auth:
    useApiKey: true
    existingSecret:
      name: bitwarden-credentials

api:
  existingSecret:
    name: bitwarden-api-token
```

### Production

```yaml
image:
  tag: "1.0.0"

replicaCount: 3

bitwarden:
  server: "https://vault.bitwarden.com"
  sessionTTL: 3600
  syncInterval: 300
  auth:
    useApiKey: true
    existingSecret:
      name: bitwarden-credentials

api:
  port: 8080
  existingSecret:
    name: bitwarden-api-token

cache:
  enabled: true
  ttl: 60
  maxSize: 1000

logging:
  level: "info"
  format: "json"

resources:
  requests:
    cpu: 100m
    memory: 128Mi
  limits:
    cpu: 200m
    memory: 256Mi

podDisruptionBudget:
  enabled: true
  minAvailable: 1

metrics:
  enabled: true
  serviceMonitor:
    enabled: true
```

### Self-Hosted Bitwarden

```yaml
bitwarden:
  server: "https://vault.example.com"
  auth:
    useApiKey: true
    existingSecret:
      name: bitwarden-credentials

api:
  existingSecret:
    name: bitwarden-api-token

# May need custom CA certificate
# Add to deployment via extraVolumes/extraVolumeMounts
```
