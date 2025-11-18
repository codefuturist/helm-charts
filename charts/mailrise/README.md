# Mailrise - SMTP Gateway for Apprise Notifications

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square)
![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)
![AppVersion: 1.4.0](https://img.shields.io/badge/AppVersion-1.4.0-informational?style=flat-square)

An SMTP gateway that converts emails into Apprise notifications, enabling access to 60+ notification services from any email-capable device or software.

## Description

Mailrise is an SMTP server that converts the emails it receives into [Apprise](https://github.com/caronc/apprise) notifications. This enables Linux servers, IoT devices, surveillance systems, and legacy software to send notifications to modern services like Discord, Telegram, Pushover, Matrix, and many more—all through simple email.

**Key Features:**
- 📧 Accept emails via SMTP
- 🔔 Send notifications to 60+ services via Apprise
- 🔐 Optional TLS encryption and SMTP authentication
- 🏠 Perfect for homelabs and self-hosted environments
- 🚀 Lightweight and runs as non-root (UID 999)
- 🎯 Route emails to different notification configs by address

## Prerequisites

- Kubernetes 1.21+
- Helm 3.0+

## Installation

### Add Helm Repository

```bash
helm repo add codefuturist https://codefuturist.github.io/helm-charts
helm repo update
```

### Install Chart

```bash
# Basic installation with example configuration
helm install mailrise codefuturist/mailrise

# With custom values
helm install mailrise codefuturist/mailrise -f values.yaml

# In a specific namespace
helm install mailrise codefuturist/mailrise -n notifications --create-namespace
```

### Uninstall Chart

```bash
helm delete mailrise
```

## Quick Start

### 1. Basic Configuration

Create a `values.yaml` with your Apprise notification URLs:

```yaml
mailrise:
  config:
    configs:
      # Send to: alerts@mailrise.xyz
      alerts:
        urls:
          - "discord://WEBHOOK_ID/WEBHOOK_TOKEN"
          - "tgram://BOT_TOKEN/CHAT_ID"
```

### 2. Install and Expose Service

```bash
helm install mailrise ./charts/mailrise -f values.yaml

# Port-forward for testing
kubectl port-forward svc/mailrise 8025:8025

# Configure your email client to use localhost:8025
```

### 3. Send Test Email

```bash
# Using swaks
swaks --to alerts@mailrise.xyz \
  --from test@example.com \
  --server localhost:8025 \
  --body "Test notification from Mailrise"
```

## Configuration

### Mailrise Configuration Structure

The `mailrise.config` section mirrors the [Mailrise YAML configuration format](https://github.com/YoRyan/mailrise#configuration):

```yaml
mailrise:
  config:
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
      mode: "starttls"  # or "onconnect"

  tls:
    enabled: true
    existingSecret: "mailrise-tls"
    certKey: "tls.crt"
    keyKey: "tls.key"
```

### SMTP Authentication

Enable SMTP authentication:

```yaml
mailrise:
  config:
    smtp:
      auth:
        basic:
          username: password
          user2: password2

  # Or use existing secret
  auth:
    enabled: true
    existingSecret: "mailrise-auth"
```

### Service Types

#### ClusterIP (default)

For internal cluster access only:

```yaml
service:
  type: ClusterIP
  port: 8025
```

#### LoadBalancer

For external access with cloud load balancer:

```yaml
service:
  type: LoadBalancer
  port: 8025
  loadBalancerIP: "203.0.113.42"  # optional
```

#### NodePort

For external access via node IP:

```yaml
service:
  type: NodePort
  port: 8025
  nodePort: 30025
```

## Examples

### Home Assistant Notifications

```yaml
mailrise:
  config:
    configs:
      homeassistant:
        urls:
          - "hasio://192.168.1.100/YOUR_LONG_LIVED_ACCESS_TOKEN"
```

Send email to: `homeassistant@mailrise.xyz`

### Multiple Services

```yaml
mailrise:
  config:
    configs:
      critical:
        urls:
          - "tgram://BOT_TOKEN/CHAT_ID"
          - "discord://WEBHOOK_ID/WEBHOOK_TOKEN"
          - "pover://USER_KEY@TOKEN"
        mailrise:
          title_template: "🚨 $subject"
```

Send email to: `critical@mailrise.xyz`

### Custom Domain

```yaml
mailrise:
  config:
    configs:
      "alerts@mydomain.com":
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

### Template Strings

Customize notification format with template strings:

```yaml
mailrise:
  config:
    configs:
      custom:
        urls:
          - "service://credentials"
        mailrise:
          title_template: "$subject ($from)"
          body_template: "From: $from\nTo: $to\n\n$body"
          body_format: "text"  # text, html, or markdown
```

Available variables: `$subject`, `$from`, `$body`, `$to`, `$config`, `$type`

### Environment Variables in URLs

Use environment variables for secrets:

```yaml
mailrise:
  config:
    configs:
      secure:
        urls:
          - !env_var MY_SECRET_DISCORD_URL

extraEnv:
  - name: MY_SECRET_DISCORD_URL
    valueFrom:
      secretKeyRef:
        name: apprise-secrets
        key: discord-url
```

### High Availability

```yaml
controller:
  replicas: 3

pdb:
  enabled: true
  minAvailable: 2

affinity:
  podAntiAffinity:
    preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 100
        podAffinityTerm:
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
