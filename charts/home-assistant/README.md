# Home Assistant Helm Chart

A comprehensive, production-ready Helm chart for deploying [Home Assistant](https://www.home-assistant.io/) on Kubernetes.

Home Assistant is an open-source home automation platform that focuses on privacy and local control. It integrates with hundreds of devices and services, allowing you to control your entire smart home from a single, unified interface.

## Features

✅ **Secure by Default**: Unprivileged mode with specific capabilities (NET_ADMIN, NET_RAW, SYS_ADMIN)  
✅ **Built-in Database**: SQLite included (no external database needed), PostgreSQL optional for HA  
✅ **Persistent Storage**: Separate volumes for config, media, and backups  
✅ **Device Access**: USB/Serial device mounting for Zigbee, Z-Wave controllers  
✅ **Host Network**: Optional host network mode for device discovery  
✅ **Add-ons Support**: Built-in code-server and MQTT broker sidecars  
✅ **Security Hardened**: Non-root containers, seccomp profiles, RBAC  
✅ **Monitoring**: Prometheus ServiceMonitor support  
✅ **High Availability**: StatefulSet support with optional PostgreSQL for multi-replica  
✅ **Production Ready**: Resource limits, probes, PodDisruptionBudget  

## Quick Start

### Minimal Installation

```bash
helm repo add codefuturist https://codefuturist.github.io/helm-charts
helm install home-assistant codefuturist/home-assistant
```

### With Ingress

```bash
helm install home-assistant codefuturist/home-assistant \
  --set ingress.enabled=true \
  --set ingress.hosts[0].host=home.example.com \
  --set ingress.hosts[0].paths[0].path=/ \
  --set ingress.hosts[0].paths[0].pathType=Prefix
```

## Prerequisites

- Kubernetes 1.19+
- Helm 3.0+
- PersistentVolume provisioner (if persistence is enabled)
- (Optional) Cert-manager for TLS certificates
- (Optional) Prometheus Operator for monitoring

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                         Ingress                             │
│                  (Optional TLS/HTTPS)                       │
└────────────────────────┬────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────┐
│                       Service                               │
│              (ClusterIP/LoadBalancer)                       │
└────────────────────────┬────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────┐
│                      Deployment                             │
│  ┌─────────────────────────────────────────────────────┐   │
│  │  Home Assistant Container                           │   │
│  │  - Port 8123                                        │   │
│  │  - SQLite or PostgreSQL                             │   │
│  │  - Config Volume (/config)                          │   │
│  │  - Media Volume (/media) [optional]                 │   │
│  │  - Backup Volume (/backup) [optional]               │   │
│  │  - USB Devices [optional]                           │   │
│  └─────────────────────────────────────────────────────┘   │
│  ┌─────────────────────────────────────────────────────┐   │
│  │  Code Server (Optional Sidecar)                     │   │
│  │  - Port 8080                                        │   │
│  │  - VSCode in browser for config editing             │   │
│  └─────────────────────────────────────────────────────┘   │
│  ┌─────────────────────────────────────────────────────┐   │
│  │  Mosquitto MQTT (Optional Sidecar)                  │   │
│  │  - Port 1883                                        │   │
│  │  - Local MQTT broker                                │   │
│  └─────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────┐
│              PersistentVolumeClaims                         │
│  - config-pvc (5Gi)                                         │
│  - media-pvc (10Gi) [optional]                              │
│  - backup-pvc (5Gi) [optional]                              │
│  - mqtt-pvc (1Gi) [optional]                                │
└─────────────────────────────────────────────────────────────┘
```

## Configuration

See [values.yaml](./values.yaml) for all configuration options.

### Key Configuration Sections

#### Image Configuration

```yaml
image:
  repository: ghcr.io/home-assistant/home-assistant
  tag: "2024.11.1"
  pullPolicy: IfNotPresent
```

#### Persistence

```yaml
persistence:
  enabled: true
  storageClassName: ""
  size: 5Gi

  # Additional volumes
  media:
    enabled: true
    size: 10Gi

  backup:
    enabled: true
    size: 5Gi
```

#### Database Configuration

**SQLite (Default - Recommended)**:

Home Assistant includes SQLite built-in. No external database is needed for most deployments:

```yaml
database:
  type: sqlite  # Default, no configuration needed
```

**PostgreSQL (Advanced - Only for High Availability)**:

Only needed if you're running multiple Home Assistant replicas (StatefulSet with replicas > 1):

```yaml
database:
  type: postgresql
  postgresql:
    host: postgresql.database.svc.cluster.local
    port: 5432
    database: homeassistant
    username: homeassistant
    existingSecret: home-assistant-db-secret
```

> ⚠️ **Note**: PostgreSQL is only beneficial for multi-replica deployments. For single-instance deployments (the vast majority of use cases), SQLite is recommended and performs excellently.

#### Device Access

For Zigbee/Z-Wave USB controllers:

```yaml
hostNetwork:
  enabled: true  # For mDNS/device discovery

devices:
  enabled: true
  list:
    - hostPath: /dev/ttyUSB0
      containerPath: /dev/ttyUSB0
    - hostPath: /dev/ttyACM0
      containerPath: /dev/ttyACM0

# Pin to specific node with USB devices
nodeSelector:
  kubernetes.io/hostname: node-with-zigbee
```

#### Code Server (VSCode in Browser)

```yaml
codeserver:
  enabled: true
  port: 8080
  env:
    PASSWORD: "your-secure-password"

  ingress:
    enabled: true
    hosts:
      - host: code.home.example.com
        paths:
          - path: /
            pathType: Prefix
```

#### MQTT Broker

```yaml
mqtt:
  enabled: true
  port: 1883
  persistence:
    enabled: true
    size: 1Gi
```

#### Ingress with TLS

```yaml
ingress:
  enabled: true
  className: nginx
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt-prod
    nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
    nginx.ingress.kubernetes.io/websocket-services: home-assistant
  hosts:
    - host: home.example.com
      paths:
        - path: /
          pathType: Prefix
  tls:
    - secretName: home-assistant-tls
      hosts:
        - home.example.com
```

#### Resource Limits

```yaml
resources:
  limits:
    cpu: 2000m
    memory: 2Gi
  requests:
    cpu: 500m
    memory: 512Mi
```

### Security Configuration

**Default: Unprivileged Mode (Recommended)**

The chart runs in secure unprivileged mode by default with specific Linux capabilities:

```yaml
securityContext:
  privileged: false  # Default - secure mode
  capabilities:
    drop:
      - ALL
    add:
      - NET_ADMIN    # Network discovery (SSDP, mDNS)
      - NET_RAW      # Ping integration
      - SYS_ADMIN    # Hardware access
```

**When to use privileged mode:**

Only enable if you need Bluetooth or full D-Bus system access:

```yaml
securityContext:
  privileged: true
  capabilities:
    add: []  # Clear capabilities when using privileged mode

hostNetwork:
  enabled: true  # Often needed with privileged mode
```

**Security best practices:**
- ✅ Use default unprivileged mode for 95% of deployments
- ✅ Add only specific capabilities you need
- ✅ Enable Pod Security Standards enforcement
- ⚠️ Only use privileged mode if absolutely required
- ⚠️ Test with unprivileged mode first before escalating

See [examples/values-unprivileged.yaml](./examples/values-unprivileged.yaml) for secure configuration template.

## Common Use Cases

### 1. Home Lab Setup (Basic)

```bash
helm install home-assistant codefuturist/home-assistant \
  --set persistence.size=10Gi \
  --set service.type=LoadBalancer
```

### 2. Production with PostgreSQL

```bash
# Create database secret
kubectl create secret generic ha-db-secret \
  --from-literal=password="$(openssl rand -base64 32)"

# Install with PostgreSQL
helm install home-assistant codefuturist/home-assistant \
  -f examples/values-production.yaml
```

### 3. Zigbee/Z-Wave Controller

```bash
helm install home-assistant codefuturist/home-assistant \
  --set hostNetwork.enabled=true \
  --set devices.enabled=true \
  --set devices.list[0].hostPath=/dev/ttyUSB0 \
  --set devices.list[0].containerPath=/dev/ttyUSB0 \
  --set nodeSelector."kubernetes\.io/hostname"=node-with-zigbee
```

### 4. Full Stack with MQTT and Code Server

```bash
helm install home-assistant codefuturist/home-assistant \
  --set codeserver.enabled=true \
  --set mqtt.enabled=true \
  --set mqtt.persistence.enabled=true
```

## Upgrading

### Upgrade Home Assistant Version

```bash
helm upgrade home-assistant codefuturist/home-assistant \
  --set image.tag=2024.11.2 \
  --reuse-values
```

### Migrate from SQLite to PostgreSQL

1. Backup your Home Assistant configuration
2. Export your SQLite database
3. Enable PostgreSQL and import data
4. Update chart configuration

See [docs/ARCHITECTURE.md](./docs/ARCHITECTURE.md) for detailed migration guide.

## Backup and Restore

### Manual Backup

```bash
# Backup configuration
kubectl exec -it deployment/home-assistant -- tar czf /backup/config-backup.tar.gz /config

# Copy to local
kubectl cp home-assistant-pod:/backup/config-backup.tar.gz ./config-backup.tar.gz
```

### Restore from Backup

```bash
# Copy backup to pod
kubectl cp ./config-backup.tar.gz home-assistant-pod:/config/

# Extract
kubectl exec -it deployment/home-assistant -- tar xzf /config/config-backup.tar.gz -C /
```

## Monitoring

Enable Prometheus monitoring:

```yaml
serviceMonitor:
  enabled: true
  interval: 30s
  path: /api/prometheus
```

## Troubleshooting

### Check Pod Status

```bash
kubectl get pods -l app.kubernetes.io/name=home-assistant
kubectl logs -l app.kubernetes.io/name=home-assistant -f
```

### Check Persistent Volumes

```bash
kubectl get pvc
kubectl describe pvc home-assistant-config
```

### Access Shell

```bash
kubectl exec -it deployment/home-assistant -- /bin/bash
```

### Check Configuration

```bash
kubectl exec -it deployment/home-assistant -- ha core check
```

### Common Issues

**Issue**: Home Assistant won't start  
**Solution**: Check logs for configuration errors:
```bash
kubectl logs -l app.kubernetes.io/name=home-assistant --tail=100
```

**Issue**: Devices not discovered  
**Solution**: Enable host network mode:
```yaml
hostNetwork:
  enabled: true
```

**Issue**: Database connection errors  
**Solution**: Verify database credentials and connectivity:
```bash
kubectl get secret home-assistant-db-secret -o yaml
```

## Security Considerations

- Use strong passwords for all services
- Enable TLS/HTTPS for external access
- Store secrets in Kubernetes Secrets
- Use network policies to restrict traffic
- Keep Home Assistant updated regularly
- Enable authentication in Home Assistant config
- Consider using External Secrets Operator for secret management

## Examples

See the [examples/](./examples/) directory for:

- `values-minimal.yaml` - Minimal setup
- `values-production.yaml` - Production-ready configuration
- `values-advanced.yaml` - Advanced features enabled

## Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](../../docs/CONTRIBUTING.md) for details.

## License

This chart is licensed under the MIT License. See [LICENSE](../../LICENSE) for details.

## Support

- **Chart Issues**: [GitHub Issues](https://github.com/codefuturist/helm-charts/issues)
- **Home Assistant**: [Home Assistant Community](https://community.home-assistant.io/)
- **Documentation**: [Home Assistant Docs](https://www.home-assistant.io/docs/)

## Acknowledgments

- Home Assistant Team for the amazing platform
- Kubernetes community for excellent tooling
- Chart inspiration from the community charts
