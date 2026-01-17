# pgAdmin Quick Start Guide

This guide will help you get started with pgAdmin quickly.

## Prerequisites

- Kubernetes cluster (1.21+)
- Helm 3.x
- kubectl configured

## Installation Methods

### 1. Minimal Installation (Development)

Quick setup with default settings using ephemeral storage:

```bash
helm install my-pgadmin codefuturist/pgadmin \
  --set pgadmin.email=admin@example.com \
  --set pgadmin.password=SuperSecurePassword123
```

Access pgAdmin:

```bash
kubectl port-forward svc/my-pgadmin 8080:80
# Open http://localhost:8080 in your browser
```

### 2. Production Installation with Persistence

Install with persistent storage to retain configurations:

```bash
helm install my-pgadmin codefuturist/pgadmin \
  --set pgadmin.email=admin@example.com \
  --set pgadmin.password=SuperSecurePassword123 \
  --set persistence.enabled=true \
  --set persistence.size=2Gi
```

### 3. Installation with Ingress

Expose pgAdmin via ingress controller:

```bash
helm install my-pgadmin codefuturist/pgadmin \
  --set pgadmin.email=admin@example.com \
  --set pgadmin.password=SuperSecurePassword123 \
  --set ingress.enabled=true \
  --set ingress.className=nginx \
  --set ingress.hosts[0].host=pgadmin.example.com \
  --set ingress.hosts[0].paths[0].path=/ \
  --set ingress.hosts[0].paths[0].pathType=Prefix
```

### 4. Installation with Pre-configured PostgreSQL Servers

Create a values file with server definitions:

```yaml
# my-values.yaml
pgadmin:
  email: admin@example.com
  password: SuperSecurePassword123

  serverDefinitions:
    servers:
      1:
        Name: "Production PostgreSQL"
        Group: "Production"
        Host: "postgresql.default.svc.cluster.local"
        Port: 5432
        MaintenanceDB: "postgres"
        Username: "postgres"
        SSLMode: "prefer"
      2:
        Name: "Development PostgreSQL"
        Group: "Development"
        Host: "postgresql-dev.default.svc.cluster.local"
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
helm install my-pgadmin codefuturist/pgadmin -f my-values.yaml
```

### 5. Secure Installation with Existing Secret

Create a secret for credentials:

```bash
kubectl create secret generic pgadmin-credentials \
  --from-literal=email=admin@example.com \
  --from-literal=password=SuperSecurePassword123
```

Install using the existing secret:

```bash
helm install my-pgadmin codefuturist/pgadmin \
  --set pgadmin.existingSecret=pgadmin-credentials \
  --set persistence.enabled=true
```

## Connecting to PostgreSQL

### In-Cluster PostgreSQL

If PostgreSQL is running in the same Kubernetes cluster:

1. Log in to pgAdmin
2. Right-click "Servers" → "Register" → "Server"
3. General tab: Enter a name
4. Connection tab:
   - Host: `postgresql.namespace.svc.cluster.local`
   - Port: `5432`
   - Username: Your PostgreSQL username
   - Password: Your PostgreSQL password

### External PostgreSQL

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

Host pgAdmin under a subdirectory (e.g., `/pgadmin4`):

```yaml
pgadmin:
  scriptName: "/pgadmin4"

ingress:
  enabled: true
  className: nginx
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
  hosts:
    - host: example.com
      paths:
        - path: /pgadmin4
          pathType: Prefix
```

### Disable Internal Postfix

When using external SMTP or in restricted environments:

```yaml
pgadmin:
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
pgadmin:
  replaceServersOnStartup: true
  existingServerDefinitionsConfigMap: dynamic-servers
```

This is useful when server definitions are managed dynamically via ConfigMaps.

### Tune Gunicorn Performance

Adjust WSGI server settings for your workload:

```yaml
pgadmin:
  gunicorn:
    threads: 50 # More threads for high concurrency
    accessLogfile: "-" # Log to stdout for observability
    limitRequestLine: 16380 # Allow larger HTTP headers
```

## Upgrading

### Upgrade to New Version

```bash
helm repo update
helm upgrade my-pgadmin codefuturist/pgadmin
```

### Upgrade with New Values

```bash
helm upgrade my-pgadmin codefuturist/pgadmin -f my-values.yaml
```

## Troubleshooting

### Check Pod Status

```bash
kubectl get pods -l app.kubernetes.io/name=pgadmin
kubectl describe pod <pod-name>
kubectl logs <pod-name>
```

### Test Connectivity

```bash
helm test my-pgadmin
```

### Access Issues

If you can't access pgAdmin:

1. Check service:

   ```bash
   kubectl get svc -l app.kubernetes.io/name=pgadmin
   ```

2. Port forward directly:

   ```bash
   kubectl port-forward pod/<pod-name> 8080:80
   ```

3. Check ingress (if enabled):
   ```bash
   kubectl get ingress
   kubectl describe ingress my-pgadmin
   ```

### Password Issues

Reset password by updating the secret:

```bash
kubectl create secret generic my-pgadmin \
  --from-literal=email=admin@example.com \
  --from-literal=password=NewPassword123 \
  --dry-run=client -o yaml | kubectl apply -f -

kubectl rollout restart deployment my-pgadmin
```

## Uninstalling

Remove the Helm release:

```bash
helm uninstall my-pgadmin
```

If persistence was enabled, manually delete the PVC:

```bash
kubectl delete pvc my-pgadmin
```

## Next Steps

- Review [README.md](../README.md) for all configuration options
- Check [examples/](../examples/) for advanced configurations
- Review security best practices for production deployments

## Getting Help

- GitHub Issues: https://github.com/codefuturist/helm-charts/issues
- pgAdmin Documentation: https://www.pgadmin.org/docs/
