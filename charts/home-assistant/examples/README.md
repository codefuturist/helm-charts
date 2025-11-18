# Home Assistant Helm Chart - Example Configurations

This directory contains example value files for different Home Assistant deployment scenarios.

## Available Examples

### 1. values-minimal.yaml

**Use Case**: Quick start, testing, development, small home labs

**Features**:
- ✅ SQLite database (no external dependencies)
- ✅ Basic persistence (5Gi)
- ✅ ClusterIP service (port-forward access)
- ✅ Minimal resource requirements
- ❌ No ingress
- ❌ No add-ons (code-server, MQTT)
- ❌ No device access

**Deploy**:
```bash
helm install home-assistant codefuturist/home-assistant \
  -f examples/values-minimal.yaml

kubectl port-forward svc/home-assistant 8123:8123
```

**Best For**:
- First-time users
- Testing and development
- Homes with < 25 devices
- Non-production environments

---

### 2. values-unprivileged.yaml (⭐ RECOMMENDED)

**Use Case**: Secure production deployment without privileged mode

**Features**:
- ✅ **Specific capabilities** (NET_ADMIN, NET_RAW, SYS_ADMIN) - no privileged mode
- ✅ **Bridge networking** - better security isolation
- ✅ Environment variable support
- ✅ System volume (localtime)
- ✅ Device access support (USB/Serial)
- ✅ SQLite database
- ✅ LoadBalancer service
- ✅ **Much safer than privileged mode**

**Deploy**:
```bash
helm install home-assistant codefuturist/home-assistant \
  -f examples/values-unprivileged.yaml \
  --namespace home-automation \
  --create-namespace

# With custom timezone
helm install home-assistant codefuturist/home-assistant \
  -f examples/values-unprivileged.yaml \
  --set homeassistant.env.TZ="America/New_York"
```

**Best For**:
- **Production environments** (recommended over privileged)
- Security-conscious deployments
- Compliance requirements
- Multi-tenant clusters
- Standard Home Assistant setups
- Most integrations (network discovery, ping, etc.)

**✅ Security Advantages**:
- Principle of least privilege
- Compatible with pod security policies
- Reduced attack surface
- Easier security auditing
- Better cluster isolation

---

### 3. values-docker-compose.yaml

**Use Case**: Migration from Docker Compose, privileged mode setup

**Features**:
- ✅ Privileged mode (matches Docker `privileged: true`)
- ✅ Host networking (matches `network_mode: host`)
- ✅ System volumes (`/etc/localtime`, `/run/dbus`)
- ✅ Stable image tag
- ✅ Full device access (Bluetooth, USB, etc.)
- ✅ SQLite database
- ✅ LoadBalancer service

**Deploy**:
```bash
helm install home-assistant codefuturist/home-assistant \
  -f examples/values-docker-compose.yaml \
  --namespace home-automation \
  --create-namespace
```

**Best For**:
- Migrating from Docker Compose
- Bluetooth integrations (requires privileged)
- Full D-Bus system integrations
- Legacy hardware requirements
- Users familiar with Docker setup

**⚠️ Security Note**: Privileged mode grants extensive permissions. Consider `values-unprivileged.yaml` first.

---

### 4. values-production.yaml

**Use Case**: Production deployments with PostgreSQL, medium to large homes

**Features**:
- ✅ PostgreSQL database (bundled subchart)
- ✅ Multiple persistent volumes (config, media, backup)
- ✅ LoadBalancer service
- ✅ Ingress with TLS
- ✅ Code-server for config editing
- ✅ MQTT broker
- ✅ Monitoring (ServiceMonitor)
- ✅ Production-grade resources
- ✅ PodDisruptionBudget
- ❌ No device access (can be added)

**Deploy**:
```bash
# Create database secret
kubectl create secret generic ha-db-secret \
  --from-literal=password="$(openssl rand -base64 32)"

# Install
helm install home-assistant codefuturist/home-assistant \
  -f examples/values-production.yaml \
  --namespace home-automation \
  --create-namespace
```

**Best For**:
- Production environments
- Homes with 50-200 devices
- Long-term history retention
- External access requirements
- Teams managing HA

---

### 3. values-advanced.yaml

**Use Case**: Power users, complex smart homes, device integrations

**Features**:
- ✅ PostgreSQL database (external, HA setup)
- ✅ Host network mode (device discovery)
- ✅ USB/Serial device mounting (Zigbee, Z-Wave)
- ✅ Multiple ingress domains
- ✅ Code-server with auth
- ✅ MQTT with advanced config
- ✅ High resource allocation
- ✅ Extended probes for large configs
- ✅ Node affinity and tolerations
- ✅ Init containers
- ✅ Extra capabilities for device access

**Deploy**:
```bash
# 1. Create secrets
kubectl create secret generic ha-db-credentials \
  --from-literal=password="$(openssl rand -base64 32)"

kubectl create secret generic home-assistant-env-secrets \
  --from-literal=SECRET_KEY="$(openssl rand -hex 32)"

# 2. Label node with USB devices
kubectl label node your-node-name \
  kubernetes.io/hostname=node-with-iot-devices

# 3. Install
helm install home-assistant codefuturist/home-assistant \
  -f examples/values-advanced.yaml \
  --namespace home-automation \
  --create-namespace
```

**Best For**:
- Advanced users
- Large homes (200+ devices)
- Zigbee/Z-Wave controllers
- Multiple protocols (MQTT, Zigbee, Z-Wave, Thread)
- Custom integrations
- Maximum performance

---

## Comparison Matrix

| Feature | Minimal | **Unprivileged** ⭐ | Docker Compose | Production | Advanced |
|---------|---------|-------------------|----------------|------------|----------|
| **Database** | SQLite | SQLite | SQLite | PostgreSQL (bundled) | PostgreSQL (external) |
| **Persistence** | 5Gi | 20Gi | 20Gi | 20Gi + media + backup | 50Gi + 500Gi media |
| **Service Type** | ClusterIP | LoadBalancer | LoadBalancer | LoadBalancer | LoadBalancer |
| **Ingress** | ❌ | ❌ | ❌ | ✅ TLS | ✅ Multi-domain TLS |
| **Code Server** | ❌ | ❌ | ❌ | ✅ | ✅ with auth |
| **MQTT** | ❌ | ❌ | ❌ | ✅ | ✅ advanced |
| **Device Access** | ❌ | ✅ USB/Serial | ✅ Full (privileged) | ❌ | ✅ USB/Serial |
| **Host Network** | ❌ | ❌ | ✅ | ❌ | ✅ |
| **Privileged Mode** | ❌ | ❌ (**secure**) | ✅ (⚠️ insecure) | ❌ | ❌ (capabilities) |
| **Capabilities** | None | NET_ADMIN, NET_RAW, SYS_ADMIN | All (privileged) | None | Custom |
| **System Volumes** | ❌ | ✅ localtime | ✅ (localtime, dbus) | ❌ | Optional |
| **Monitoring** | ❌ | ❌ | ❌ | ✅ | ✅ |
| **CPU Request** | 250m | 500m | 500m | 1000m | 2000m |
| **Memory Request** | 512Mi | 1Gi | 512Mi | 2Gi | 4Gi |
| **Storage Class** | default | default | default | fast-ssd | fast-nvme |
| **Security Level** | Basic | **High** ⭐ | Low ⚠️ | Basic | Medium |
| **Best For** | Testing | **Production** | Docker Migration | Enterprise | Advanced |

**Legend**:
- ⭐ = Recommended configuration
- ⚠️ = Security consideration needed

**Which configuration should I use?**

1. **Start here** → `values-unprivileged.yaml` - Secure, production-ready, works for 95% of use cases
2. **Need Bluetooth/D-Bus** → `values-docker-compose.yaml` - Full device access but less secure
3. **First time user** → `values-minimal.yaml` - Simplest setup for learning
4. **Enterprise** → `values-production.yaml` - PostgreSQL, monitoring, add-ons
5. **Power user** → `values-advanced.yaml` - Everything enabled, maximum control

---

## Customization Guide

### Adding Device Access to Production

Add to `values-production.yaml`:

```yaml
hostNetwork:
  enabled: true

devices:
  enabled: true
  list:
    - hostPath: /dev/ttyUSB0
      containerPath: /dev/ttyUSB0

nodeSelector:
  kubernetes.io/hostname: node-with-devices
```

### Using External PostgreSQL

Replace PostgreSQL configuration:

```yaml
postgresql:
  enabled: false

database:
  type: postgresql
  postgresql:
    host: external-postgres.example.com
    port: 5432
    database: homeassistant
    username: homeassistant
    existingSecret: external-db-secret
```

### Enabling Authentication for Code Server

```yaml
codeserver:
  enabled: true
  env:
    PASSWORD: "your-secure-password"
  # Or use a secret:
  envFrom:
    - secretRef:
        name: code-server-secret
```

### Adding NodePort Service

```yaml
service:
  type: NodePort
  port: 8123
  nodePort: 30123
```

### Customizing Storage Sizes

```yaml
persistence:
  size: 50Gi
  media:
    enabled: true
    size: 1Ti
  backup:
    enabled: true
    size: 100Gi
```

---

## Migration Between Examples

### Minimal → Production

1. **Backup SQLite database**:
```bash
kubectl exec deployment/home-assistant -- \
  cp /config/home-assistant_v2.db /backup/sqlite-backup.db
```

2. **Upgrade with production values**:
```bash
helm upgrade home-assistant codefuturist/home-assistant \
  -f examples/values-production.yaml
```

3. **Home Assistant will migrate to PostgreSQL automatically**

### Production → Advanced

1. **Add device access**:
```bash
# Label your node
kubectl label node node-name kubernetes.io/hostname=node-with-iot-devices

# Upgrade with advanced values
helm upgrade home-assistant codefuturist/home-assistant \
  -f examples/values-advanced.yaml
```

2. **Verify device access**:
```bash
kubectl exec deployment/home-assistant -- ls -la /dev/tty*
```

---

## Testing Configuration

### Dry Run

Test your configuration without deploying:

```bash
helm install home-assistant codefuturist/home-assistant \
  -f examples/values-production.yaml \
  --dry-run --debug
```

### Template Validation

Check generated Kubernetes manifests:

```bash
helm template home-assistant codefuturist/home-assistant \
  -f examples/values-production.yaml > manifests.yaml

kubectl apply --dry-run=client -f manifests.yaml
```

### Diff Before Upgrade

See what will change:

```bash
helm diff upgrade home-assistant codefuturist/home-assistant \
  -f examples/values-production.yaml
```

---

## Common Customizations

### Change Timezone

```yaml
homeassistant:
  env:
    TZ: "Europe/London"
```

### Increase Recorder Retention

```yaml
homeassistant:
  configuration:
    recorder:
      purge_keep_days: 180  # 6 months
```

### Add Trusted Proxies

```yaml
homeassistant:
  configuration:
    http:
      trusted_proxies:
        - 10.0.0.0/8
        - 192.168.0.0/16
```

### Enable Debug Logging

```yaml
homeassistant:
  configuration:
    logger:
      default: debug
```

---

## Support

For questions or issues with these examples:

1. Check the [main README](../README.md)
2. Review [QUICKSTART guide](../docs/QUICKSTART.md)
3. Read [ARCHITECTURE documentation](../docs/ARCHITECTURE.md)
4. Open an [issue](https://github.com/codefuturist/helm-charts/issues)

---

## Contributing

Have a useful configuration? Submit a PR with:
- New example file
- Description in this README
- Use case documentation
- Testing instructions
