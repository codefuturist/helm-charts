# Home Assistant Architecture Guide

This document provides an in-depth look at the Home Assistant Helm chart architecture, design decisions, and best practices.

## Table of Contents

1. [Overview](#overview)
2. [Component Architecture](#component-architecture)
3. [Storage Architecture](#storage-architecture)
4. [Networking](#networking)
5. [Security Model](#security-model)
6. [High Availability](#high-availability)
7. [Database Options](#database-options)
8. [Device Integration](#device-integration)
9. [Migration Scenarios](#migration-scenarios)
10. [Performance Tuning](#performance-tuning)

## Overview

This Helm chart deploys Home Assistant on Kubernetes with enterprise-grade features while maintaining simplicity for home lab users.

### Design Principles

1. **User-Friendly First**: Sensible defaults for quick setup
2. **Production-Ready**: Optional HA, monitoring, and security features
3. **Flexible Storage**: Multiple volume options for different needs
4. **Device Access**: Native support for USB/serial devices
5. **Extensible**: Sidecar containers for additional services

## Component Architecture

### Core Components

```
┌─────────────────────────────────────────────────────────────────┐
│                         Kubernetes Cluster                       │
│                                                                  │
│  ┌────────────────────────────────────────────────────────┐    │
│  │                     Namespace                           │    │
│  │                                                         │    │
│  │  ┌──────────────────────────────────────────────┐     │    │
│  │  │            Deployment                        │     │    │
│  │  │  ┌────────────────────────────────────┐     │     │    │
│  │  │  │  Home Assistant Container          │     │     │    │
│  │  │  │  - Main application                │     │     │    │
│  │  │  │  - Port 8123                       │     │     │    │
│  │  │  │  - Runs as root (device access)    │     │     │    │
│  │  │  └────────────────────────────────────┘     │     │    │
│  │  │  ┌────────────────────────────────────┐     │     │    │
│  │  │  │  Code Server Sidecar (Optional)    │     │     │    │
│  │  │  │  - VSCode web interface            │     │     │    │
│  │  │  │  - Port 8080                       │     │     │    │
│  │  │  │  - Shared config volume            │     │     │    │
│  │  │  └────────────────────────────────────┘     │     │    │
│  │  │  ┌────────────────────────────────────┐     │     │    │
│  │  │  │  Mosquitto MQTT Sidecar (Optional) │     │     │    │
│  │  │  │  - MQTT broker                     │     │     │    │
│  │  │  │  - Port 1883                       │     │     │    │
│  │  │  │  - Local message bus               │     │     │    │
│  │  │  └────────────────────────────────────┘     │     │    │
│  │  └──────────────────────────────────────────────┘     │    │
│  │                                                         │    │
│  │  ┌──────────────────────────────────────────────┐     │    │
│  │  │            Service (ClusterIP)               │     │    │
│  │  │  - Port 8123 → Home Assistant                │     │    │
│  │  │  - Port 8080 → Code Server                   │     │    │
│  │  │  - Port 1883 → MQTT                          │     │    │
│  │  └──────────────────────────────────────────────┘     │    │
│  │                                                         │    │
│  │  ┌──────────────────────────────────────────────┐     │    │
│  │  │            Ingress (Optional)                │     │    │
│  │  │  - TLS termination                           │     │    │
│  │  │  - WebSocket support                         │     │    │
│  │  │  - Path-based routing                        │     │    │
│  │  └──────────────────────────────────────────────┘     │    │
│  │                                                         │    │
│  │  ┌──────────────────────────────────────────────┐     │    │
│  │  │        PersistentVolumeClaims                │     │    │
│  │  │  - config (5Gi)    - Required                │     │    │
│  │  │  - media (10Gi)    - Optional                │     │    │
│  │  │  - backup (5Gi)    - Optional                │     │    │
│  │  │  - mqtt (1Gi)      - Optional                │     │    │
│  │  └──────────────────────────────────────────────┘     │    │
│  │                                                         │    │
│  │  ┌──────────────────────────────────────────────┐     │    │
│  │  │        PostgreSQL (Optional)                 │     │    │
│  │  │  - Subchart or external                      │     │    │
│  │  │  - For production deployments                │     │    │
│  │  └──────────────────────────────────────────────┘     │    │
│  │                                                         │    │
│  └────────────────────────────────────────────────────────┘    │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### Pod Components

#### Main Container: Home Assistant

**Purpose**: Core home automation platform

**Key Features**:

- Runs as root (UID 0) for device access
- Seccomp profile for security
- Liveness/readiness/startup probes
- Configurable resource limits
- Environment variable configuration

**Volume Mounts**:

- `/config` - Main configuration directory
- `/media` - Media files (optional)
- `/backup` - Backup storage (optional)
- Device paths (e.g., `/dev/ttyUSB0`) for hardware

#### Sidecar: Code Server

**Purpose**: Web-based code editor for configuration management

**Why Include**:

- Edit YAML files without SSH/shell access
- Syntax highlighting and validation
- Git integration for version control
- Easy for non-technical users

**Access**:

- Via separate ingress (recommended)
- Via port-forward for testing
- Password-protected by default

#### Sidecar: Mosquitto MQTT

**Purpose**: Local MQTT broker for IoT devices

**Why Include**:

- Many devices require MQTT
- Reduces external dependencies
- Low resource overhead
- Automatic configuration with HA

## Storage Architecture

### Volume Strategy

```
PersistentVolume Layout:

/config (5Gi - Required)
├── configuration.yaml          # Main config
├── automations.yaml           # Automation definitions
├── scripts.yaml               # Script definitions
├── scenes.yaml                # Scene definitions
├── secrets.yaml               # Secret values
├── known_devices.yaml         # Device tracker
├── home-assistant_v2.db       # SQLite database (if used)
├── home-assistant.log         # Current log
├── .storage/                  # Internal state
└── custom_components/         # Custom integrations

/media (10Gi - Optional)
├── recordings/                # Security camera recordings
├── snapshots/                 # Camera snapshots
├── music/                     # Music files
└── videos/                    # Video files

/backup (5Gi - Optional)
├── daily/                     # Daily backups
├── weekly/                    # Weekly backups
└── manual/                    # Manual backups

/mosquitto/data (1Gi - Optional)
└── mosquitto.db               # MQTT persistence
```

### Storage Classes

**Recommendations**:

- **Config**: Fast SSD (frequent reads/writes)
- **Media**: Large HDD (infrequent access, large files)
- **Backup**: Any storage (retention focused)

**Example Configuration**:

```yaml
persistence:
  storageClassName: "fast-ssd"
  size: 5Gi

  media:
    enabled: true
    storageClassName: "slow-hdd"
    size: 100Gi

  backup:
    enabled: true
    storageClassName: "backup-storage"
    size: 20Gi
```

### Backup Strategy

#### Automated Backups

Create a CronJob for automated backups:

```yaml
apiVersion: batch/v1
kind: CronJob
metadata:
  name: home-assistant-backup
spec:
  schedule: "0 2 * * *" # 2 AM daily
  jobTemplate:
    spec:
      template:
        spec:
          containers:
            - name: backup
              image: alpine:3.18
              command:
                - /bin/sh
                - -c
                - |
                  BACKUP_FILE="/backup/ha-$(date +%Y%m%d-%H%M%S).tar.gz"
                  tar czf "$BACKUP_FILE" -C / config

                  # Keep only last 7 daily backups
                  ls -t /backup/ha-*.tar.gz | tail -n +8 | xargs -r rm
          volumeMounts:
            - name: config
              mountPath: /config
              readOnly: true
            - name: backup
              mountPath: /backup
          volumes:
            - name: config
              persistentVolumeClaim:
                claimName: home-assistant-config
            - name: backup
              persistentVolumeClaim:
                claimName: home-assistant-backup
          restartPolicy: OnFailure
```

## Networking

### Network Modes

#### Standard Mode (Default)

```yaml
hostNetwork:
  enabled: false
```

**Pros**:

- Better security isolation
- Standard Kubernetes networking
- Compatible with network policies

**Cons**:

- No multicast/broadcast (mDNS, SSDP)
- Device discovery limited
- Some integrations won't work

#### Host Network Mode

```yaml
hostNetwork:
  enabled: true
```

**Pros**:

- Full network access
- mDNS/SSDP discovery works
- All integrations functional

**Cons**:

- Less secure
- Requires nodeSelector
- Port conflicts possible

### Service Types

#### ClusterIP (Default)

**Use Case**: Access via Ingress or port-forward

```yaml
service:
  type: ClusterIP
  port: 8123
```

#### LoadBalancer

**Use Case**: Direct external access

```yaml
service:
  type: LoadBalancer
  port: 8123
  loadBalancerIP: 192.168.1.100 # Optional static IP
```

#### NodePort

**Use Case**: Access via node IP:port

```yaml
service:
  type: NodePort
  port: 8123
  nodePort: 30123
```

### Ingress Configuration

#### Basic Ingress

```yaml
ingress:
  enabled: true
  className: nginx
  hosts:
    - host: home.example.com
      paths:
        - path: /
          pathType: Prefix
```

#### Production Ingress with TLS

```yaml
ingress:
  enabled: true
  className: nginx
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt-prod
    nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
    nginx.ingress.kubernetes.io/websocket-services: home-assistant
    nginx.ingress.kubernetes.io/proxy-body-size: "10m"
    nginx.ingress.kubernetes.io/proxy-read-timeout: "3600"
    nginx.ingress.kubernetes.io/proxy-send-timeout: "3600"
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

## Security Model

### Pod Security Context

```yaml
podSecurityContext:
  runAsNonRoot: false # Home Assistant needs root for device access
  runAsUser: 0
  runAsGroup: 0
  fsGroup: 0
  seccompProfile:
    type: RuntimeDefault
```

### Container Security Context

```yaml
securityContext:
  allowPrivilegeEscalation: false
  capabilities:
    drop:
      - ALL
    # Add only if needed:
    # add:
    #   - NET_RAW    # For network scanning
    #   - NET_ADMIN  # For network management
  readOnlyRootFilesystem: false # HA writes to filesystem
  privileged: false
```

### RBAC

The chart creates minimal RBAC:

```yaml
rules:
  - apiGroups: [""]
    resources: ["configmaps", "secrets"]
    verbs: ["get", "list", "watch"]
```

### Network Policies

Example network policy:

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: home-assistant
spec:
  podSelector:
    matchLabels:
      app.kubernetes.io/name: home-assistant
  policyTypes:
    - Ingress
    - Egress
  ingress:
    - from:
        - podSelector:
            matchLabels:
              app: nginx-ingress
      ports:
        - protocol: TCP
          port: 8123
  egress:
    - to:
        - podSelector: {} # Allow all in namespace
    - to:
        - namespaceSelector: {}
      ports:
        - protocol: TCP
          port: 443 # HTTPS
        - protocol: TCP
          port: 5432 # PostgreSQL
    - to: []
      ports:
        - protocol: UDP
          port: 53 # DNS
```

## High Availability

### Limitations

Home Assistant is **not designed for active-active clustering**. The chart defaults to:

```yaml
replicaCount: 1
strategy:
  type: Recreate
```

### Why Single Replica?

1. **SQLite limitations**: File-based, single writer
2. **State management**: In-memory caches
3. **Device connections**: Serial/USB devices
4. **File locks**: Configuration file locking

### HA Options

#### Option 1: Fast Recovery (Recommended)

```yaml
replicaCount: 1
strategy:
  type: Recreate

# Fast startup
startupProbe:
  enabled: true
  failureThreshold: 30
  periodSeconds: 10

# Ensure volume is always available
persistence:
  enabled: true
  retain: true
```

#### Option 2: PostgreSQL Backend

```yaml
replicaCount: 1 # Still single replica
database:
  type: postgresql
  postgresql:
    host: postgresql-ha.database
    # PostgreSQL can be HA
```

#### Option 3: Backup/Restore Strategy

Focus on:

- Automated backups
- Quick restore procedures
- Infrastructure as Code
- External database HA

### Pod Disruption Budget

```yaml
podDisruptionBudget:
  enabled: true
  minAvailable: 1 # Prevents voluntary disruption
```

## Database Options

### SQLite (Default)

**Pros**:

- Zero configuration
- Fast for single instance
- Built-in, no external dependencies

**Cons**:

- File-based, single writer
- Limited scale
- No clustering
- Backup requires downtime or file copy

**Use Case**: Home labs, development, small deployments

**Configuration**:

```yaml
database:
  type: sqlite
```

Database location: `/config/home-assistant_v2.db`

### PostgreSQL

**Pros**:

- Better performance at scale
- MVCC (multi-version concurrency control)
- Better for recorder (history)
- Can be separately HA
- Better backup options

**Cons**:

- Additional complexity
- Requires external database
- Higher resource usage

**Use Case**: Production, large deployments, long history retention

**Configuration**:

```yaml
# Using bundled PostgreSQL subchart
postgresql:
  enabled: true
  auth:
    database: homeassistant
    username: homeassistant
    existingSecret: ha-db-secret
  primary:
    persistence:
      enabled: true
      size: 20Gi

database:
  type: postgresql
  postgresql:
    host: home-assistant-postgresql
    port: 5432
    database: homeassistant
    username: homeassistant
    existingSecret: ha-db-secret
    passwordKey: password
```

**External PostgreSQL**:

```yaml
database:
  type: postgresql
  postgresql:
    host: postgresql.database.svc.cluster.local
    port: 5432
    database: homeassistant
    username: homeassistant
    existingSecret: ha-db-external
    sslMode: require
```

### Migration: SQLite → PostgreSQL

1. **Backup SQLite database**:

```bash
kubectl exec deployment/home-assistant -- \
  cp /config/home-assistant_v2.db /backup/ha_v2_backup.db
```

2. **Export data** (use Home Assistant tools or manual SQL)

3. **Deploy PostgreSQL**:

```bash
helm upgrade home-assistant codefuturist/home-assistant \
  --set postgresql.enabled=true \
  --set database.type=postgresql
```

4. **Import data** (if needed)

5. **Verify and delete SQLite**

**Note**: Home Assistant >= 2023.1 handles most migration automatically on first start with new database.

## Device Integration

### USB/Serial Devices

For Zigbee, Z-Wave, or other USB controllers:

```yaml
# Enable host network for discovery
hostNetwork:
  enabled: true

# Mount USB devices
devices:
  enabled: true
  list:
    - hostPath: /dev/ttyUSB0
      containerPath: /dev/ttyUSB0
    - hostPath: /dev/ttyACM0
      containerPath: /dev/ttyACM0

# Pin to node with devices
nodeSelector:
  kubernetes.io/hostname: node-with-devices

# Add capabilities if needed
securityContext:
  capabilities:
    add:
      - SYS_RAWIO # For device access
```

### Device Permissions

Some devices require specific permissions:

```bash
# On the Kubernetes node:
sudo chmod 666 /dev/ttyUSB0
sudo usermod -aG dialout root

# Or use udev rules:
echo 'KERNEL=="ttyUSB0", MODE="0666"' | sudo tee /etc/udev/rules.d/99-usb-serial.rules
sudo udevadm control --reload-rules
```

### Network Device Discovery

For devices using mDNS, SSDP, or broadcast:

```yaml
hostNetwork:
  enabled: true
dnsPolicy: ClusterFirstWithHostNet
```

This enables:

- **mDNS**: HomeKit, Chromecast discovery
- **SSDP**: UPnP device discovery
- **Broadcast**: Wake-on-LAN, some IoT devices

## Migration Scenarios

### From Docker to Kubernetes

1. **Backup Docker volumes**:

```bash
docker cp homeassistant:/config ./ha-config-backup
```

2. **Create PVC and copy data**:

```bash
# Install chart
helm install home-assistant codefuturist/home-assistant

# Wait for pod
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=home-assistant

# Copy config
kubectl cp ./ha-config-backup home-assistant-pod:/config

# Restart
kubectl rollout restart deployment/home-assistant
```

### From VM to Kubernetes

1. **Backup VM configuration**:

```bash
scp -r root@homeassistant-vm:/config ./ha-config-backup
```

2. **Install chart with persistent storage**:

```bash
helm install home-assistant codefuturist/home-assistant \
  --set persistence.enabled=true \
  --set persistence.size=10Gi
```

3. **Restore configuration**:

```bash
kubectl cp ./ha-config-backup home-assistant-pod:/config
kubectl rollout restart deployment/home-assistant
```

4. **Migrate database** (if using PostgreSQL)

### From Home Assistant OS

1. **Create backup in HA OS**
2. **Extract backup** (it's a tar.gz)
3. **Follow VM to Kubernetes steps**

## Performance Tuning

### Resource Allocation

**Small Home** (< 50 devices):

```yaml
resources:
  limits:
    cpu: 1000m
    memory: 1Gi
  requests:
    cpu: 250m
    memory: 512Mi
```

**Medium Home** (50-200 devices):

```yaml
resources:
  limits:
    cpu: 2000m
    memory: 2Gi
  requests:
    cpu: 500m
    memory: 1Gi
```

**Large Home** (200+ devices):

```yaml
resources:
  limits:
    cpu: 4000m
    memory: 4Gi
  requests:
    cpu: 1000m
    memory: 2Gi
```

### Database Tuning

#### SQLite

```yaml
homeassistant:
  configuration:
    recorder:
      auto_purge: true
      purge_keep_days: 7 # Reduce for better performance
      commit_interval: 1 # Seconds between commits
```

#### PostgreSQL

```yaml
homeassistant:
  configuration:
    recorder:
      db_url: "postgresql://user:pass@host/db"
      auto_purge: true
      purge_keep_days: 30
      commit_interval: 1

      # Exclude high-frequency sensors
      exclude:
        domains:
          - automation
          - updater
        entity_globs:
          - sensor.weather_*
```

### Storage Performance

Use fast storage for config:

```yaml
persistence:
  storageClassName: "fast-ssd" # NVMe or SSD
```

Separate media to slower storage:

```yaml
persistence:
  media:
    enabled: true
    storageClassName: "standard" # HDD okay
```

### Probe Tuning

For slow storage or large configs:

```yaml
startupProbe:
  enabled: true
  initialDelaySeconds: 10
  periodSeconds: 10
  failureThreshold: 60 # 10 minutes max startup

readinessProbe:
  enabled: true
  periodSeconds: 10
  timeoutSeconds: 5
  failureThreshold: 3

livenessProbe:
  enabled: true
  periodSeconds: 10
  timeoutSeconds: 5
  failureThreshold: 6
```

## Best Practices Summary

1. **Start Simple**: Use defaults, add complexity as needed
2. **Use PostgreSQL for Production**: Better performance and reliability
3. **Enable Persistence**: Always use persistent volumes
4. **Regular Backups**: Automate backups, test restores
5. **Monitor Resources**: Watch CPU/memory usage
6. **Secure Access**: Use Ingress with TLS
7. **Device Isolation**: Use nodeSelector for USB devices
8. **Version Control**: Track configuration changes
9. **Test Upgrades**: Test Home Assistant upgrades before production
10. **Document**: Keep notes on your specific setup

## Conclusion

This architecture provides a solid foundation for running Home Assistant on Kubernetes, from simple home lab setups to production deployments. The chart's flexibility allows you to start simple and grow as needs evolve.

For more information:

- [Quick Start Guide](./QUICKSTART.md)
- [Main README](../README.md)
- [Home Assistant Docs](https://www.home-assistant.io/docs/)
