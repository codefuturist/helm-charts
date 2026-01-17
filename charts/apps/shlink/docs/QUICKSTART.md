# Shlink Quick Start Guide

This guide will help you get Shlink up and running quickly in your Kubernetes cluster.

## Prerequisites

- Kubernetes cluster (1.21+)
- Helm 3.8+
- kubectl configured to access your cluster
- (Optional) Ingress controller installed (nginx, traefik, etc.)
- (Optional) cert-manager for TLS certificates

## What is Shlink?

Shlink is a self-hosted URL shortener that allows you to:

- Create custom short URLs with your own domain
- Track visits with detailed analytics (referrers, browsers, OS, location)
- Manage multiple domains
- Use REST API or web interface
- Integrate with your applications

## Installation Methods

### Method 1: Minimal Setup (Quick Test)

Perfect for testing or development environments. Uses embedded PostgreSQL and no persistence.

```bash
# Install with minimal configuration
helm install shlink codefuturist/shlink \
  --set shlink.defaultDomain="short.example.com" \
  --set postgresql.auth.password="test123"

# Wait for pods to be ready
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=shlink --timeout=300s

# Port-forward to access (backend API)
kubectl port-forward svc/shlink 8080:8080

# Visit http://localhost:8080
```

Generate an API key:

```bash
kubectl exec -it deployment/shlink -- shlink api-key:generate
```

### Method 2: With Web Client

Includes the beautiful React-based admin interface.

```bash
# Install with web client enabled
helm install shlink codefuturist/shlink \
  --set shlink.defaultDomain="short.example.com" \
  --set postgresql.auth.password="change-me" \
  --set webClient.enabled=true

# Port-forward to access web client
kubectl port-forward svc/shlink-webclient 8080:80

# Visit http://localhost:8080
# You'll need to configure the server connection in the UI:
#   - Name: My Shlink Server
#   - URL: http://localhost:8080 (or your backend URL)
#   - API Key: (the one generated above)
```

### Method 3: Production with Ingress

Full production setup with persistent storage and ingress access.

Create a values file (`shlink-production.yaml`):

```yaml
shlink:
  defaultDomain: "go.yourcompany.com"
  defaultSchema: "https"
  initialApiKey: "your-secure-api-key-here"
  geoLiteLicenseKey: "YOUR_GEOLITE_LICENSE_KEY" # Get from MaxMind

webClient:
  enabled: true
  replicaCount: 2
  servers:
    - name: "Production"
      url: "https://go.yourcompany.com"
      apiKey: "your-secure-api-key-here"

controller:
  replicaCount: 2

ingress:
  backend:
    enabled: true
    className: "nginx"
    annotations:
      cert-manager.io/cluster-issuer: "letsencrypt-prod"
    hosts:
      - host: go.yourcompany.com
        paths:
          - path: /
            pathType: Prefix
    tls:
      - secretName: shlink-api-tls
        hosts:
          - go.yourcompany.com

  webClient:
    enabled: true
    className: "nginx"
    annotations:
      cert-manager.io/cluster-issuer: "letsencrypt-prod"
    hosts:
      - host: shlink.yourcompany.com
        paths:
          - path: /
            pathType: Prefix
    tls:
      - secretName: shlink-webclient-tls
        hosts:
          - shlink.yourcompany.com

persistence:
  enabled: true
  storageClass: "default"
  size: 10Gi

postgresql:
  enabled: true
  auth:
    password: "SECURE-DATABASE-PASSWORD"
  primary:
    persistence:
      enabled: true
      size: 50Gi

resources:
  limits:
    cpu: 1000m
    memory: 1Gi
  requests:
    cpu: 250m
    memory: 512Mi

autoscaling:
  enabled: true
  minReplicas: 2
  maxReplicas: 10
  targetCPUUtilizationPercentage: 70

podDisruptionBudget:
  enabled: true
  minAvailable: 1
```

Install:

```bash
helm install shlink codefuturist/shlink -f shlink-production.yaml
```

### Method 4: External Database

Use an existing PostgreSQL or MySQL database instead of the embedded one.

```yaml
shlink:
  defaultDomain: "short.example.com"

database:
  type: "postgresql" # or "mysql"
  host: "postgres.example.com"
  port: 5432
  name: "shlink"
  user: "shlink"
  password: "secure-password"
  # Or use existing secret:
  # existingSecret: "shlink-db-secret"
  # existingSecretPasswordKey: "password"

postgresql:
  enabled: false # Disable embedded database
```

```bash
helm install shlink codefuturist/shlink -f external-db-values.yaml
```

## Common Operations

### Create Short URLs via CLI

```bash
# Create a short URL
kubectl exec -it deployment/shlink -- shlink short-url:generate \
  https://example.com/very-long-url \
  --domain=short.example.com \
  --custom-slug=myurl

# Result: https://short.example.com/myurl
```

### Create Short URLs via API

```bash
# Set your API key
API_KEY="your-api-key-here"
SHLINK_URL="https://go.yourcompany.com"

# Create a short URL
curl -X POST "$SHLINK_URL/rest/v3/short-urls" \
  -H "X-Api-Key: $API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "longUrl": "https://example.com/very-long-url",
    "customSlug": "myurl",
    "domain": "short.example.com"
  }'
```

### List Short URLs

```bash
# Via CLI
kubectl exec -it deployment/shlink -- shlink short-url:list

# Via API
curl "$SHLINK_URL/rest/v3/short-urls" \
  -H "X-Api-Key: $API_KEY"
```

### View Visit Statistics

```bash
# Via CLI - all visits
kubectl exec -it deployment/shlink -- shlink visit:stats

# Via CLI - specific short URL
kubectl exec -it deployment/shlink -- shlink visit:stats abc123

# Via API
curl "$SHLINK_URL/rest/v3/visits?shortCode=abc123" \
  -H "X-Api-Key: $API_KEY"
```

### Generate API Keys

```bash
# Create a new API key
kubectl exec -it deployment/shlink -- shlink api-key:generate

# Create API key with description
kubectl exec -it deployment/shlink -- shlink api-key:generate \
  --description="Production API Key"

# List all API keys
kubectl exec -it deployment/shlink -- shlink api-key:list
```

### Update GeoLite2 Database

For geolocation features, update the GeoLite2 database:

```bash
kubectl exec -it deployment/shlink -- shlink visit:update-db
```

## Configuration Examples

### Multiple Short Domains

```yaml
shlink:
  defaultDomain: "go.company.com"
  defaultSchema: "https"

ingress:
  backend:
    enabled: true
    hosts:
      - host: go.company.com
        paths:
          - path: /
            pathType: Prefix
      - host: s.company.com
        paths:
          - path: /
            pathType: Prefix
      - host: link.company.com
        paths:
          - path: /
            pathType: Prefix
    tls:
      - secretName: short-urls-tls
        hosts:
          - go.company.com
          - s.company.com
          - link.company.com
```

### Redis Caching

```yaml
shlink:
  defaultDomain: "short.example.com"
  redis:
    enabled: true
    servers: "redis-master:6379"
```

### Privacy-Focused Configuration

```yaml
shlink:
  defaultDomain: "short.example.com"
  anonymizeRemoteAddr: true
  redirectsLogging: false
  orphanVisitsLogging: false
```

## Verification Steps

### 1. Check Pod Status

```bash
kubectl get pods -l app.kubernetes.io/name=shlink
```

Expected output:

```
NAME                      READY   STATUS    RESTARTS   AGE
shlink-7d5f4c8b9c-abcd1   1/1     Running   0          2m
```

### 2. Check Services

```bash
kubectl get svc -l app.kubernetes.io/name=shlink
```

### 3. Check Ingress

```bash
kubectl get ingress
```

### 4. Test Backend Health

```bash
kubectl exec -it deployment/shlink -- curl http://localhost:8080/rest/health
```

Expected: `{"status":"pass"}`

### 5. Test Database Connection

```bash
kubectl exec -it deployment/shlink -- shlink db:create
```

## Troubleshooting

### Problem: Backend Pod Not Starting

**Check logs:**

```bash
kubectl logs deployment/shlink
```

**Common causes:**

- Database connection failure
- Missing required environment variables
- Insufficient resources

**Solution:**

```bash
# Verify database is running
kubectl get pods -l app.kubernetes.io/name=postgresql

# Check database credentials
kubectl get secret shlink -o yaml

# Increase resources if needed
helm upgrade shlink codefuturist/shlink \
  --set resources.requests.memory=512Mi \
  --set resources.requests.cpu=250m
```

### Problem: Cannot Access via Ingress

**Check ingress controller:**

```bash
kubectl get pods -n ingress-nginx
```

**Check ingress resource:**

```bash
kubectl describe ingress shlink-backend
```

**Common causes:**

- Ingress controller not installed
- DNS not pointing to cluster
- TLS certificate issues

**Solution:**

```bash
# Test with port-forward first
kubectl port-forward svc/shlink 8080:8080

# Check ingress controller logs
kubectl logs -n ingress-nginx deployment/ingress-nginx-controller
```

### Problem: Web Client Cannot Connect

**Symptom:** Web client shows "Server not reachable"

**Solution:**

1. Verify backend API is accessible at the configured URL
2. Check server configuration in web client:

```yaml
webClient:
  servers:
    - name: "Production"
      url: "https://go.yourcompany.com" # Must be the actual backend URL
      apiKey: "your-api-key"
```

3. For local testing, use port-forward for both:

```bash
# Terminal 1: Backend
kubectl port-forward svc/shlink 8080:8080

# Terminal 2: Web Client
kubectl port-forward svc/shlink-webclient 3000:80

# In web client (http://localhost:3000):
# Server URL: http://localhost:8080
```

### Problem: Database Connection Errors

**Check database status:**

```bash
kubectl get pods -l app.kubernetes.io/name=postgresql

kubectl logs -l app.kubernetes.io/name=postgresql
```

**Verify credentials:**

```bash
# Get the database password
kubectl get secret shlink-postgresql -o jsonpath='{.data.postgres-password}' | base64 -d

# Test connection from Shlink pod
kubectl exec -it deployment/shlink -- \
  psql -h shlink-postgresql -U shlink -d shlink
```

### Problem: GeoLite2 Not Working

**Symptom:** Location data not showing in analytics

**Solution:**

1. Get a free license key from [MaxMind](https://www.maxmind.com/en/geolite2/signup)
2. Configure in values:

```yaml
shlink:
  geoLiteLicenseKey: "YOUR_LICENSE_KEY"
```

3. Update the database:

```bash
kubectl exec -it deployment/shlink -- shlink visit:update-db
```

## Upgrading

### Upgrade to Latest Version

```bash
helm repo update
helm upgrade shlink codefuturist/shlink
```

### Upgrade with New Values

```bash
helm upgrade shlink codefuturist/shlink -f shlink-production.yaml
```

### Check What Will Change

```bash
helm diff upgrade shlink codefuturist/shlink -f shlink-production.yaml
```

## Backup and Restore

### Backup Database

```bash
# Create a backup
kubectl exec -it deployment/shlink-postgresql-0 -- \
  pg_dump -U shlink shlink > shlink-backup.sql

# Or use persistent volume snapshots if your storage class supports it
kubectl get volumesnapshot
```

### Restore Database

```bash
# Restore from backup
kubectl exec -i deployment/shlink-postgresql-0 -- \
  psql -U shlink shlink < shlink-backup.sql
```

## Next Steps

1. **Configure DNS** - Point your short domain to the ingress load balancer
2. **Set up monitoring** - Enable Prometheus ServiceMonitor
3. **Configure backups** - Set up regular database backups
4. **Review security** - Enable network policies, use strong passwords
5. **Customize** - Adjust resources, scaling, and features to your needs

## Useful Resources

- **Shlink Documentation**: https://shlink.io/documentation/
- **REST API Reference**: https://shlink.io/documentation/api-docs/
- **Web Client Guide**: https://shlink.io/documentation/shlink-web-client/
- **Helm Chart Repository**: https://github.com/codefuturist/helm-charts
- **Example Values**: See `examples/` directory in the chart

## Support

If you encounter issues:

1. Check this troubleshooting section
2. Review [GitHub Issues](https://github.com/codefuturist/helm-charts/issues)
3. Consult [Shlink Documentation](https://shlink.io/documentation/)
4. Open a new issue with:
   - Helm chart version
   - Kubernetes version
   - Error logs
   - Your values.yaml (redact sensitive data)
