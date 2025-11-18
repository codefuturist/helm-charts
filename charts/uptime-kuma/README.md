# Uptime Kuma - Self-hosted Monitoring Tool

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square)
![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)
![AppVersion: 2.0.0](https://img.shields.io/badge/AppVersion-2.0.0-informational?style=flat-square)

A fancy self-hosted monitoring tool for monitoring your services and servers with beautiful status pages.

## Description

Uptime Kuma is a self-hosted monitoring tool that allows you to monitor uptime for HTTP(s), TCP, HTTP(s) Keyword, Ping, DNS Record, Push, and Steam Game servers. It provides a clean and modern UI with notification support for 90+ services.

**Key Features:**
- 🖥️ Beautiful and reactive UI/UX
- 📺 Monitor uptime for HTTP(s) / TCP / HTTP(s) Keyword / HTTP(s) Json Query / Ping / DNS Record / Push / Steam Game Server / Docker Containers
- 🔔 90+ notification services (Discord, Slack, Telegram, Email, etc.)
- 🗂️ Multi-language support
- 📈 Uptime statistics
- 📊 Status pages with custom domain support
- 🔐 Two-factor authentication (2FA)
- 🎨 Custom branding
- 🏷️ Tagging and grouping

## Prerequisites

- Kubernetes 1.21+
- Helm 3.0+
- Persistent storage (recommended for production)

## Installation

### Add Helm Repository

```bash
helm repo add codefuturist https://codefuturist.github.io/helm-charts
helm repo update
```

### Install Chart

```bash
# Basic installation
helm install uptime-kuma codefuturist/uptime-kuma

# With custom values
helm install uptime-kuma codefuturist/uptime-kuma -f values.yaml

# In a specific namespace
helm install uptime-kuma codefuturist/uptime-kuma -n monitoring --create-namespace
```

### Uninstall Chart

```bash
helm delete uptime-kuma -n monitoring
    # Define notification targets
    configs:
      # Email: basic@mailrise.xyz
      basic:
        urls:
          - "service://credentials"

      # Email: important.failure@mailrise.xyz  
      # (.failure changes notification type)
      important:
        urls:
          - "service://credentials"
        mailrise:
          title_template: "ALERT: $subject"
          body_template: "$body"

    # Network settings
    listen:
      host: "0.0.0.0"
      port: 8025

    # TLS settings
    tls:
      mode: "off"  # off, onconnect, starttls, starttlsrequire
```

### Using Existing ConfigMap

Instead of inline configuration, use an existing ConfigMap:

```yaml
mailrise:
  existingConfigMap: "my-mailrise-config"
  existingConfigMapKey: "mailrise.conf"
```

### TLS Configuration

Enable TLS with certificates:

```yaml
mailrise:
  config:
    tls:
```

## Quick Start

### 1. Basic Installation

```bash
# Install with default values
helm install uptime-kuma codefuturist/uptime-kuma -n monitoring --create-namespace

# Port-forward to access the UI
kubectl port-forward -n monitoring svc/uptime-kuma 3001:3001
```

### 2. Access the Web Interface

Open your browser and navigate to:
```
http://localhost:3001
```

Create your admin account on first login.

### 3. Configure Monitors

Once logged in, you can:
1. Click "Add New Monitor"
2. Choose monitor type (HTTP(s), TCP, Ping, etc.)
3. Configure monitor settings
4. Set up notifications
5. Create status pages

## Configuration

### Basic Configuration

```yaml
# Minimal configuration with persistence
persistence:
  enabled: true
  size: 4Gi

resources:
  limits:
    cpu: 1000m
    memory: 512Mi
  requests:
    cpu: 250m
    memory: 256Mi
```

### Ingress Configuration

```yaml
ingress:
  enabled: true
  className: "nginx"
  annotations:
    cert-manager.io/cluster-issuer: "letsencrypt-prod"
    nginx.ingress.kubernetes.io/proxy-body-size: "50m"
    nginx.ingress.kubernetes.io/websocket-services: "uptime-kuma"
  hosts:
    - host: uptime.example.com
      paths:
        - path: /
          pathType: Prefix
  tls:
    - secretName: uptime-kuma-tls
      hosts:
        - uptime.example.com
```

### Docker Socket Access

Enable Docker socket for container monitoring:

```yaml
uptimeKuma:
  dockerSocket:
    enabled: true
    hostPath: /var/run/docker.sock
```

**Note:** Docker socket access requires appropriate security considerations and RBAC permissions.

### StatefulSet Deployment

For production with persistent identity:

```yaml
controller:
  type: statefulset
  replicas: 1
  podManagementPolicy: OrderedReady

persistence:
  volumeClaimTemplate:
    enabled: true
    storageClassName: "fast-ssd"
    size: 10Gi
```

## Service Types

### ClusterIP (default)

For internal cluster access:

```yaml
service:
  type: ClusterIP
  port: 3001
```

### LoadBalancer

For external access with cloud load balancer:

```yaml
service:
  type: LoadBalancer
  port: 3001
```

### NodePort

For external access via node IP:

```yaml
service:
  type: NodePort
  port: 3001
  nodePort: 30301
```

## Examples

### Minimal Deployment

```yaml
controller:
  type: deployment
  replicas: 1

persistence:
  enabled: true
  size: 4Gi
```

### Production Deployment

```yaml
controller:
  type: statefulset
  replicas: 1

persistence:
  volumeClaimTemplate:
    enabled: true
    storageClassName: "fast-ssd"
    size: 10Gi

ingress:
  enabled: true
  className: "nginx"
  hosts:
    - host: uptime.example.com
      paths:
        - path: /
          pathType: Prefix

resources:
  limits:
    cpu: 2000m
    memory: 1Gi
  requests:
    cpu: 500m
    memory: 512Mi

monitoring:
  serviceMonitor:
    enabled: true
        urls:
          - "discord://WEBHOOK_ID/WEBHOOK_TOKEN"
```

Send email to: `alerts@mydomain.com`

### Wildcard Routing

```yaml
mailrise:
  config:
    configs:
      # Catches all emails to @mydomain.com
      "*@mydomain.com":
        urls:
          - "discord://WEBHOOK_ID/WEBHOOK_TOKEN"

      # Catch-all for any address
      "*@*":
        urls:
          - "tgram://BOT_TOKEN/CHAT_ID"
```

### With Production Security

```yaml
# Enable TLS
mailrise:
  config:
    tls:
      mode: "starttls"
  tls:
    enabled: true
    existingSecret: "mailrise-tls-cert"

# Enable authentication
mailrise:
  config:
    smtp:
      auth:
        basic:
          mailuser: "SecurePassword123"

# Network policy
networkPolicy:
  enabled: true
  ingress:
    - from:
        - podSelector:
            matchLabels:
              app: my-app
      ports:
        - protocol: TCP
          port: 8025

# Resource limits
resources:
  limits:
    cpu: 500m
    memory: 256Mi
  requests:
    cpu: 100m
    memory: 128Mi
```

## Advanced Configuration

### Template Strings```

### With Docker Socket Access

```yaml
uptimeKuma:
  dockerSocket:
    enabled: true
    hostPath: /var/run/docker.sock

persistence:
  enabled: true
  size: 4Gi

resources:
  limits:
    cpu: 1000m
    memory: 512Mi
  requests:
    cpu: 250m
    memory: 256Mi
```

## High Availability

**Note:** Uptime Kuma uses SQLite by default, which doesn't support multiple replicas. For HA:

1. Configure an external MySQL/MariaDB database
2. Use StatefulSet with single replica
3. Use proper backup strategies

```yaml
controller:
  type: statefulset
  replicas: 1

pdb:
  enabled: true
  minAvailable: 1
```

## Monitoring

### Prometheus ServiceMonitor

```yaml
monitoring:
  serviceMonitor:
    enabled: true
    interval: 60s
    labels:
      prometheus: kube-prometheus

  prometheusRule:
    enabled: true
    labels:
      prometheus: kube-prometheus
    rules:
      - alert: UptimeKumaDown
        expr: up{job="uptime-kuma"} == 0
        for: 5m
        labels:
          severity: critical
```

## Security

### Pod Security Standards

The chart follows Kubernetes Pod Security Standards:

- Runs as non-root user (UID 1000)
- Uses read-only root filesystem where possible
- Drops all capabilities
- Restricts privilege escalation
- Uses seccomp profile

### Network Policies

```yaml
networkPolicy:
  enabled: true
  policyTypes:
    - Ingress
    - Egress
  ingress:
    - from:
        - namespaceSelector:
            matchLabels:
              name: ingress-nginx
      ports:
        - protocol: TCP
          port: 3001
  egress:
    - {}  # Allow all egress for monitoring external services
```

## Backup and Restore

### Backup Data

```bash
# Get pod name
POD=$(kubectl get pod -n monitoring -l app.kubernetes.io/name=uptime-kuma -o jsonpath='{.items[0].metadata.name}')

# Copy data directory
kubectl cp -n monitoring $POD:/app/data ./uptime-kuma-backup
```

### Restore Data

```bash
# Copy backup to pod
kubectl cp -n monitoring ./uptime-kuma-backup $POD:/app/data
```

## Troubleshooting

### Check Pod Status

```bash
kubectl get pods -n monitoring -l app.kubernetes.io/name=uptime-kuma
```

### View Logs

```bash
kubectl logs -n monitoring -l app.kubernetes.io/name=uptime-kuma -f
```

### Common Issues

**Pod stuck in Pending:**
- Check PVC status: `kubectl get pvc -n monitoring`
- Verify storage class exists: `kubectl get storageclass`

**Container crashes:**
- Check logs for errors
- Verify resource limits
- Ensure persistence is properly configured

**Cannot access UI:**
- Verify ingress configuration
- Check service status
- Verify network policies if enabled

## Parameters

### Global Parameters

| Name | Description | Default |
|------|-------------|---------|
| `namespaceOverride` | Override namespace | `""` |
| `nameOverride` | Override chart name | `""` |
| `fullnameOverride` | Override full name | `""` |

### Image Parameters

| Name | Description | Default |
|------|-------------|---------|
| `image.repository` | Image repository | `louislam/uptime-kuma` |
| `image.tag` | Image tag | `"2"` |
| `image.pullPolicy` | Image pull policy | `IfNotPresent` |

### Uptime Kuma Configuration

| Name | Description | Default |
|------|-------------|---------|
| `uptimeKuma.basePath` | Base path for reverse proxy | `""` |
| `uptimeKuma.dockerSocket.enabled` | Enable Docker socket access | `false` |
| `uptimeKuma.dockerSocket.hostPath` | Docker socket path | `/var/run/docker.sock` |

### Controller Parameters

| Name | Description | Default |
|------|-------------|---------|
| `controller.type` | Controller type (deployment/statefulset) | `deployment` |
| `controller.replicas` | Number of replicas | `1` |

### Service Parameters

| Name | Description | Default |
|------|-------------|---------|
| `service.type` | Service type | `ClusterIP` |
| `service.port` | Service port | `3001` |

### Ingress Parameters

| Name | Description | Default |
|------|-------------|---------|
| `ingress.enabled` | Enable ingress | `false` |
| `ingress.className` | Ingress class name | `""` |

### Persistence Parameters

| Name | Description | Default |
|------|-------------|---------|
| `persistence.enabled` | Enable persistence | `true` |
| `persistence.size` | PVC size | `4Gi` |
| `persistence.storageClassName` | Storage class | `""` |

For complete parameter documentation, see `values.yaml`.

## Resources

- **Uptime Kuma Project**: <https://github.com/louislam/uptime-kuma>
- **Demo**: <https://demo.uptime.kuma.pet>
- **Documentation**: <https://github.com/louislam/uptime-kuma/wiki>
- **Chart Repository**: <https://github.com/codefuturist/helm-charts>

## License

This Helm chart is licensed under the Apache License 2.0.

## Contributing

Contributions are welcome! Please open an issue or pull request on GitHub.

## Support

For issues related to:
- **Chart**: Open an issue in the [helm-charts repository](https://github.com/codefuturist/helm-charts/issues)
- **Uptime Kuma**: Open an issue in the [Uptime Kuma repository](https://github.com/louislam/uptime-kuma/issues)
          labelSelector:
            matchLabels:
              app.kubernetes.io/name: mailrise
          topologyKey: kubernetes.io/hostname
```

## Troubleshooting

### Connection Issues

Check if the service is running:

```bash
kubectl get pods -l app.kubernetes.io/name=mailrise
kubectl logs -l app.kubernetes.io/name=mailrise -f
```

Test SMTP connectivity:

```bash
kubectl port-forward svc/mailrise 8025:8025
telnet localhost 8025
```

### Email Not Producing Notifications

1. Check Mailrise logs for errors:
   ```bash
   kubectl logs -l app.kubernetes.io/name=mailrise --tail=100
   ```

2. Verify email address format matches config:
   ```bash
   # If config has "alerts@mailrise.xyz", send to that exact address
   ```

3. Test Apprise URLs directly:
   ```bash
   apprise -b "Test" "discord://WEBHOOK_ID/WEBHOOK_TOKEN"
   ```

### TLS Certificate Issues

Verify certificate is mounted:

```bash
kubectl exec -it <pod-name> -- ls -la /etc/mailrise/tls/
```

Check certificate validity:

```bash
openssl s_client -connect mailrise.example.com:8025 -starttls smtp
```

## Notes

- Mailrise runs as non-root user (UID 999, GID 999) for enhanced security
- Default SMTP port is 8025 (non-privileged)
- Supports notification types: info, success, warning, failure (append `.type` to address)
- Attachments are supported if the notification service supports them
- Wildcard patterns use Python's `fnmatch` library
- Configuration is hot-reloaded when ConfigMap changes (with proper deployment strategy)

## Links

- **Mailrise Project**: https://github.com/YoRyan/mailrise
- **Apprise Documentation**: https://github.com/caronc/apprise
- **Docker Hub**: https://hub.docker.com/r/yoryan/mailrise
- **Chart Repository**: https://github.com/codefuturist/helm-charts

## License

Apache 2.0

## Maintainers

| Name | Email |
| ---- | ----- |
| codefuturist | <58808821+codefuturist@users.noreply.github.com> |
