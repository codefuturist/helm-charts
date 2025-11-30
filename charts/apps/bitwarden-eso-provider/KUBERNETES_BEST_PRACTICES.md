# Kubernetes Best Practices Guide

This chart follows Kubernetes and Helm best practices to ensure production-ready deployments.

## Security Best Practices

### Pod Security

✅ **Non-root user**: Container runs as UID 1000  
✅ **Read-only root filesystem**: Prevents container file modifications  
✅ **Drop all capabilities**: Minimal Linux capabilities  
✅ **No privilege escalation**: Security hardening enabled  
✅ **Seccomp profile**: Runtime security with RuntimeDefault

```yaml
podSecurityContext:
  runAsNonRoot: true
  runAsUser: 1000
  fsGroup: 1000
  seccompProfile:
    type: RuntimeDefault

securityContext:
  allowPrivilegeEscalation: false
  capabilities:
    drop:
    - ALL
  readOnlyRootFilesystem: true
```

### Secrets Management

✅ **External secrets only**: No hardcoded credentials  
✅ **Secret rotation**: Automatic with ESO sync  
✅ **Encrypted storage**: Kubernetes secrets at rest  
✅ **RBAC**: ServiceAccount with minimal permissions

```yaml
# Store credentials in Kubernetes secrets
kubectl create secret generic bitwarden-credentials \
  --from-literal=clientId="user.xxx" \
  --from-literal=clientSecret="xxx"

# Reference in values.yaml
bitwarden:
  auth:
    useApiKey: true
    existingSecret:
      name: bitwarden-credentials
```

### Network Security

✅ **Network policies**: Restrict ingress/egress  
✅ **ClusterIP service**: Internal-only access  
✅ **TLS enforcement**: HTTPS to Bitwarden API  
✅ **Token authentication**: Bearer token for webhook

```yaml
networkPolicy:
  enabled: true
  egress:
    - to:
      - namespaceSelector: {}
      ports:
      - protocol: TCP
        port: 443  # Only HTTPS to Bitwarden
```

## High Availability

### Replica Management

✅ **Multiple replicas**: Default 2 for redundancy  
✅ **Pod anti-affinity**: Spread across nodes  
✅ **PodDisruptionBudget**: Ensure availability during updates  
✅ **Topology spread**: Zone-aware distribution

```yaml
# Basic HA setup
replicaCount: 2

podDisruptionBudget:
  enabled: true
  minAvailable: 1

affinity:
  podAntiAffinity:
    preferredDuringSchedulingIgnoredDuringExecution:
    - weight: 100
      podAffinityTerm:
        topologyKey: kubernetes.io/hostname
```

### Advanced HA Configuration

```yaml
# Multi-zone distribution
topologySpreadConstraints:
  - maxSkew: 1
    topologyKey: topology.kubernetes.io/zone
    whenUnsatisfiable: DoNotSchedule
    labelSelector:
      matchLabels:
        app.kubernetes.io/name: bitwarden-eso-provider

# Priority scheduling
priorityClassName: high-priority
```

## Auto-Scaling

### Horizontal Pod Autoscaler

✅ **CPU-based scaling**: Automatic based on load  
✅ **Memory-based scaling**: Optional memory triggers  
✅ **Custom metrics**: Extensible for custom metrics  
✅ **Scaling behavior**: Controlled scale-up/down

```yaml
autoscaling:
  enabled: true
  minReplicas: 2
  maxReplicas: 10
  targetCPUUtilizationPercentage: 80
  targetMemoryUtilizationPercentage: 85

  # Fine-tune scaling behavior
  behavior:
    scaleDown:
      stabilizationWindowSeconds: 300  # Wait 5min before scale-down
      policies:
      - type: Percent
        value: 50  # Scale down 50% at a time
        periodSeconds: 60
    scaleUp:
      stabilizationWindowSeconds: 0  # Scale up immediately
      policies:
      - type: Percent
        value: 100  # Double pods
        periodSeconds: 30
      - type: Pods
        value: 2  # Or add 2 pods
        periodSeconds: 30
      selectPolicy: Max  # Use more aggressive policy
```

## Health Checks

### Probe Configuration

✅ **Startup probe**: Handle slow container starts  
✅ **Liveness probe**: Detect and restart unhealthy pods  
✅ **Readiness probe**: Remove unhealthy pods from service  
✅ **Session validation**: Checks Bitwarden connectivity

```yaml
# Startup probe - allows 150s for initial startup
startupProbe:
  httpGet:
    path: /healthz
    port: http
  initialDelaySeconds: 0
  periodSeconds: 5
  failureThreshold: 30  # 30 * 5s = 150s max

# Liveness probe - restart if unhealthy
livenessProbe:
  httpGet:
    path: /healthz
    port: http
  initialDelaySeconds: 10
  periodSeconds: 30
  timeoutSeconds: 5

# Readiness probe - remove from service if not ready
readinessProbe:
  httpGet:
    path: /readyz
    port: http
  initialDelaySeconds: 5
  periodSeconds: 10
  timeoutSeconds: 5
```

### Probe Endpoints

- `/healthz`: Basic health check (always returns 200)
- `/readyz`: Validates Bitwarden session is active
- `/metrics`: Prometheus metrics (when enabled)

## Resource Management

### Resource Requests & Limits

✅ **Guaranteed QoS**: Requests = Limits for critical workloads  
✅ **Right-sizing**: Based on actual usage patterns  
✅ **Burst capacity**: Limits allow temporary spikes  
✅ **OOM prevention**: Memory limits prevent node issues

```yaml
# Production recommendations
resources:
  requests:
    cpu: 100m
    memory: 128Mi
  limits:
    cpu: 200m
    memory: 256Mi

# For high-traffic deployments
resources:
  requests:
    cpu: 200m
    memory: 256Mi
  limits:
    cpu: 500m
    memory: 512Mi
```

### Resource Sizing Guide

| Traffic Level | CPU Request | CPU Limit | Memory Request | Memory Limit |
|---------------|-------------|-----------|----------------|--------------|
| Low (<10 req/s) | 50m | 100m | 64Mi | 128Mi |
| Medium (10-50 req/s) | 100m | 200m | 128Mi | 256Mi |
| High (50-200 req/s) | 200m | 500m | 256Mi | 512Mi |
| Very High (>200 req/s) | 500m | 1000m | 512Mi | 1Gi |

## Monitoring & Observability

### Prometheus Integration

✅ **ServiceMonitor**: Auto-discovery with Prometheus Operator  
✅ **Custom metrics**: Request counts, cache stats, session info  
✅ **Standard labels**: Kubernetes metadata included  
✅ **Alerting**: Configure PrometheusRule for alerts

```yaml
metrics:
  enabled: true
  serviceMonitor:
    enabled: true
    interval: 30s
    labels:
      release: prometheus  # Match your Prometheus
```

### Available Metrics

```prometheus
# Request metrics
bitwarden_eso_requests_total          # Total requests
bitwarden_eso_requests_success        # Successful requests
bitwarden_eso_requests_error          # Failed requests

# Cache metrics
bitwarden_eso_cache_hits              # Cache hit count
bitwarden_eso_cache_misses            # Cache miss count

# Session metrics
bitwarden_eso_session_renewals        # Session renewal count
bitwarden_eso_session_expires_at      # Session expiration timestamp
```

### Sample Prometheus Rules

```yaml
apiVersion: monitoring.coreos.com/v1
kind: PrometheusRule
metadata:
  name: bitwarden-eso-provider
spec:
  groups:
  - name: bitwarden_eso_provider
    interval: 30s
    rules:
    - alert: BitwardenESOHighErrorRate
      expr: |
        rate(bitwarden_eso_requests_error[5m])
        / rate(bitwarden_eso_requests_total[5m]) > 0.1
      for: 5m
      labels:
        severity: warning
      annotations:
        summary: High error rate in Bitwarden ESO Provider
        description: "{{ $value | humanizePercentage }} of requests are failing"

    - alert: BitwardenESOSessionExpiring
      expr: |
        bitwarden_eso_session_expires_at - time() < 300
      for: 1m
      labels:
        severity: info
      annotations:
        summary: Bitwarden session expiring soon
        description: "Session expires in less than 5 minutes"
```

## Deployment Strategies

### Rolling Updates

✅ **Zero-downtime**: Rolling update strategy  
✅ **Gradual rollout**: One pod at a time  
✅ **Health validation**: New pods must be ready  
✅ **Automatic rollback**: Failed updates revert

```yaml
# Default strategy (already in deployment)
strategy:
  type: RollingUpdate
  rollingUpdate:
    maxUnavailable: 0  # Always keep at least one pod
    maxSurge: 1        # Add one new pod during update
```

### Blue-Green Deployments

```bash
# Install new version in separate namespace
helm install bitwarden-eso-provider-v2 ./bitwarden-eso-provider \
  --namespace bitwarden-v2 \
  --create-namespace

# Test new version
kubectl port-forward -n bitwarden-v2 svc/bitwarden-eso-provider 8080:8080

# Switch SecretStore to new service
kubectl patch secretstore bitwarden \
  --type merge \
  -p '{"spec":{"provider":{"webhook":{"url":"http://bitwarden-eso-provider.bitwarden-v2:8080"}}}}'

# Delete old version after validation
helm uninstall bitwarden-eso-provider -n bitwarden
```

### Canary Deployments

```yaml
# Install canary with fewer replicas
helm install bitwarden-eso-provider-canary ./bitwarden-eso-provider \
  --set replicaCount=1 \
  --set service.labels.version=canary

# Use traffic splitting (requires service mesh like Istio)
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: bitwarden-eso-provider
spec:
  hosts:
  - bitwarden-eso-provider
  http:
  - match:
    - headers:
        canary:
          exact: "true"
    route:
    - destination:
        host: bitwarden-eso-provider-canary
  - route:
    - destination:
        host: bitwarden-eso-provider
      weight: 90
    - destination:
        host: bitwarden-eso-provider-canary
      weight: 10
```

## Production Checklist

### Pre-Deployment

- [ ] Create Kubernetes secrets for credentials
- [ ] Configure proper resource requests/limits
- [ ] Enable NetworkPolicy if supported
- [ ] Set up monitoring and alerting
- [ ] Configure backup for critical secrets
- [ ] Review security context settings
- [ ] Test failover scenarios

### Deployment

- [ ] Deploy with at least 2 replicas
- [ ] Enable PodDisruptionBudget
- [ ] Configure pod anti-affinity
- [ ] Set appropriate session TTL
- [ ] Enable caching for performance
- [ ] Configure proper logging level

### Post-Deployment

- [ ] Verify all pods are running
- [ ] Check health and readiness endpoints
- [ ] Validate Bitwarden connectivity
- [ ] Test ExternalSecret sync
- [ ] Monitor metrics in Prometheus
- [ ] Set up alerts for errors
- [ ] Document runbooks for incidents

### Ongoing Maintenance

- [ ] Monitor resource usage and adjust limits
- [ ] Review logs for errors
- [ ] Update Bitwarden CLI regularly
- [ ] Rotate API credentials periodically
- [ ] Test disaster recovery procedures
- [ ] Keep Helm chart up to date

## Troubleshooting

### Pod Not Starting

```bash
# Check pod status
kubectl get pods -l app.kubernetes.io/name=bitwarden-eso-provider

# View pod events
kubectl describe pod <pod-name>

# Check logs
kubectl logs <pod-name>

# Common issues:
# - Missing secrets: Create required secrets
# - Image pull errors: Check imagePullSecrets
# - Resource constraints: Increase limits
```

### Session Errors

```bash
# Check if credentials are valid
kubectl exec <pod-name> -- bw login --check

# View session expiration
kubectl exec <pod-name> -- curl http://localhost:8080/readyz

# Force session renewal
kubectl rollout restart deployment/bitwarden-eso-provider
```

### Performance Issues

```bash
# Check metrics
kubectl port-forward svc/bitwarden-eso-provider 8080:8080
curl http://localhost:8080/metrics

# Enable HPA for auto-scaling
helm upgrade bitwarden-eso-provider ./bitwarden-eso-provider \
  --set autoscaling.enabled=true

# Increase cache TTL
helm upgrade bitwarden-eso-provider ./bitwarden-eso-provider \
  --set cache.ttl=300
```

## References

- [Kubernetes Best Practices](https://kubernetes.io/docs/concepts/configuration/overview/)
- [Pod Security Standards](https://kubernetes.io/docs/concepts/security/pod-security-standards/)
- [External Secrets Operator](https://external-secrets.io/)
- [Prometheus Operator](https://prometheus-operator.dev/)
- [Bitwarden CLI](https://bitwarden.com/help/cli/)
