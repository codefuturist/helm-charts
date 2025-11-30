# RedisInsight Quick Start Guide

This guide will help you get started with RedisInsight quickly.

## Prerequisites

- Kubernetes cluster (1.21+)
- Helm 3.x
- kubectl configured

## Installation Methods

### 1. Minimal Installation (Development)

Quick setup with default settings using ephemeral storage:

```bash
helm install my-redisinsight codefuturist/redisinsight \
  --set redisinsight.email=admin@example.com \
  --set redisinsight.password=SuperSecurePassword123
```

Access RedisInsight:

```bash
kubectl port-forward svc/my-redisinsight 8080:80
# Open http://localhost:8080 in your browser
```

### 2. Production Installation with Persistence

Install with persistent storage to retain configurations:

```bash
helm install my-redisinsight codefuturist/redisinsight \
  --set redisinsight.email=admin@example.com \
  --set redisinsight.password=SuperSecurePassword123 \
  --set persistence.enabled=true \
  --set persistence.size=2Gi
```

### 3. Installation with Ingress

Expose RedisInsight via ingress controller:

```bash
helm install my-redisinsight codefuturist/redisinsight \
  --set redisinsight.email=admin@example.com \
  --set redisinsight.password=SuperSecurePassword123 \
  --set ingress.enabled=true \
  --set ingress.className=nginx \
  --set ingress.hosts[0].host=redisinsight.example.com \
  --set ingress.hosts[0].paths[0].path=/ \
  --set ingress.hosts[0].paths[0].pathType=Prefix
```

### 4. Installation with Pre-configured Redis Servers

Create a values file with server definitions:

```yaml
# my-values.yaml
redisinsight:
  email: admin@example.com
  password: SuperSecurePassword123

  serverDefinitions:
    servers:
      1:
        Name: "Production Redis"
        Group: "Production"
        Host: "redis.default.svc.cluster.local"
        Port: 5432
        MaintenanceDB: "postgres"
        Username: "postgres"
        SSLMode: "prefer"
      2:
        Name: "Development Redis"
        Group: "Development"
        Host: "redis-dev.default.svc.cluster.local"
        Port: 5432
        MaintenanceDB: "postgres"
        Username: "postgres"
        SSLMode: "disable"

persistence:
  enabled: true
  size: 2Gi
```

Install with the values file:

```bash
helm install my-redisinsight codefuturist/redisinsight -f my-values.yaml
```

### 5. Secure Installation with Existing Secret

Create a secret for credentials:

```bash
kubectl create secret generic redisinsight-credentials \
  --from-literal=email=admin@example.com \
  --from-literal=password=SuperSecurePassword123
```

Install using the existing secret:

```bash
helm install my-redisinsight codefuturist/redisinsight \
  --set redisinsight.existingSecret=redisinsight-credentials \
  --set persistence.enabled=true
```

## Connecting to Redis

### In-Cluster Redis

If Redis is running in the same Kubernetes cluster:

1. Log in to RedisInsight
2. Right-click "Servers" → "Register" → "Server"
3. General tab: Enter a name
4. Connection tab:
   - Host: `redis.namespace.svc.cluster.local`
   - Port: `5432`
   - Username: Your Redis username
   - Password: Your Redis password

### External Redis

For external databases, ensure network policies allow egress:

```yaml
networkPolicy:
  enabled: true
  egress:
    - to:
      - ipBlock:
          cidr: 0.0.0.0/0
      ports:
      - protocol: TCP
        port: 5432
```

## Common Configuration

### Increase Resources

For production workloads:

```yaml
resources:
  limits:
    cpu: 2000m
    memory: 1Gi
  requests:
    cpu: 500m
    memory: 512Mi
```

### Enable Monitoring

With Prometheus Operator:

```yaml
monitoring:
  serviceMonitor:
    enabled: true
    interval: 30s
```

### Enable Network Policy

Restrict network access:

```yaml
networkPolicy:
  enabled: true
  ingress:
    - from:
      - namespaceSelector:
          matchLabels:
            name: ingress-nginx
      ports:
      - protocol: TCP
        port: 80
```

### Reverse Proxy with Subdirectory

Host RedisInsight under a subdirectory (e.g., `/redisinsight4`):

```yaml
redisinsight:
  scriptName: "/redisinsight4"

ingress:
  enabled: true
  className: nginx
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
  hosts:
    - host: example.com
      paths:
        - path: /redisinsight4
          pathType: Prefix
```

### Disable Internal Postfix

When using external SMTP or in restricted environments:

```yaml
redisinsight:
  disablePostfix: true
  smtp:
    enabled: true
    server: smtp.gmail.com
    port: 587
    useTLS: true
    fromAddress: alerts@example.com
    existingSecret: smtp-credentials
```

### Dynamic Server Definitions

Reload server definitions on every startup (not just first launch):

```yaml
redisinsight:
  replaceServersOnStartup: true
  existingServerDefinitionsConfigMap: dynamic-servers
```

This is useful when server definitions are managed dynamically via ConfigMaps.

### Tune Gunicorn Performance

Adjust WSGI server settings for your workload:

```yaml
redisinsight:
  gunicorn:
    threads: 50              # More threads for high concurrency
    accessLogfile: "-"       # Log to stdout for observability
    limitRequestLine: 16380  # Allow larger HTTP headers
```

## Upgrading

### Upgrade to New Version

```bash
helm repo update
helm upgrade my-redisinsight codefuturist/redisinsight
```

### Upgrade with New Values

```bash
helm upgrade my-redisinsight codefuturist/redisinsight -f my-values.yaml
```

## Troubleshooting

### Check Pod Status

```bash
kubectl get pods -l app.kubernetes.io/name=redisinsight
kubectl describe pod <pod-name>
kubectl logs <pod-name>
```

### Test Connectivity

```bash
helm test my-redisinsight
```

### Access Issues

If you can't access RedisInsight:

1. Check service:
   ```bash
   kubectl get svc -l app.kubernetes.io/name=redisinsight
   ```

2. Port forward directly:
   ```bash
   kubectl port-forward pod/<pod-name> 8080:80
   ```

3. Check ingress (if enabled):
   ```bash
   kubectl get ingress
   kubectl describe ingress my-redisinsight
   ```

### Password Issues

Reset password by updating the secret:

```bash
kubectl create secret generic my-redisinsight \
  --from-literal=email=admin@example.com \
  --from-literal=password=NewPassword123 \
  --dry-run=client -o yaml | kubectl apply -f -

kubectl rollout restart deployment my-redisinsight
```

## Uninstalling

Remove the Helm release:

```bash
helm uninstall my-redisinsight
```

If persistence was enabled, manually delete the PVC:

```bash
kubectl delete pvc my-redisinsight
```

## Next Steps

- Review [README.md](../README.md) for all configuration options
- Check [examples/](../examples/) for advanced configurations
- Review security best practices for production deployments

## Getting Help

- GitHub Issues: https://github.com/codefuturist/helm-charts/issues
- RedisInsight Documentation: https://www.redisinsight.org/docs/
