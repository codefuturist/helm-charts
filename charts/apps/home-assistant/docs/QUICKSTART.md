# Home Assistant Quick Start Guide

This guide will help you get Home Assistant running on Kubernetes in minutes with secure defaults.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Basic Installation](#basic-installation)
3. [First Login](#first-login)
4. [Security Notes](#security-notes)
5. [Common Configurations](#common-configurations)
6. [Next Steps](#next-steps)

## Prerequisites

Before you begin, ensure you have:

- ✅ Kubernetes cluster (1.19+)
- ✅ kubectl configured and connected
- ✅ Helm 3.0+ installed
- ✅ Storage class available (check with `kubectl get storageclass`)

## Basic Installation

### 1. Add the Helm Repository

```bash
helm repo add pandia https://charts.pandia.io
helm repo update
```

### 2. Install Home Assistant

**Option A: Minimal Setup (Secure Default)**
```bash
# Install with secure unprivileged mode (recommended)
helm install home-assistant codefuturist/home-assistant

# Check installation
kubectl get pods -l app.kubernetes.io/name=home-assistant
```

> 🔒 **Security**: The default configuration runs in **unprivileged mode** with only necessary capabilities (NET_ADMIN, NET_RAW, SYS_ADMIN). This is secure and works for 95% of use cases.

**Option B: With LoadBalancer**
```bash
helm install home-assistant codefuturist/home-assistant \
  --set service.type=LoadBalancer
```

**Option C: With Ingress**
```bash
helm install home-assistant codefuturist/home-assistant \
  --set ingress.enabled=true \
  --set ingress.className=nginx \
  --set ingress.hosts[0].host=home.local \
  --set ingress.hosts[0].paths[0].path=/ \
  --set ingress.hosts[0].paths[0].pathType=Prefix
```

### 3. Wait for Deployment

```bash
# Watch pod status
kubectl get pods -w

# Check logs
kubectl logs -l app.kubernetes.io/name=home-assistant -f
```

The first startup may take 2-3 minutes as Home Assistant initializes.

## First Login

### Access Home Assistant

**If using ClusterIP (default):**
```bash
kubectl port-forward svc/home-assistant 8123:8123
```
Then visit: http://localhost:8123

**If using LoadBalancer:**
```bash
kubectl get svc home-assistant
# Note the EXTERNAL-IP
```
Visit: http://EXTERNAL-IP:8123

**If using Ingress:**
Visit your configured domain (e.g., http://home.local)

### Initial Setup

1. Open Home Assistant in your browser
2. Create your admin account
3. Set your location and timezone
4. Home Assistant will auto-discover devices on your network
5. Complete the onboarding wizard

## Security Notes

### Default Security Configuration

The chart uses **unprivileged mode by default** for better security:

```yaml
securityContext:
  privileged: false
  capabilities:
    add:
      - NET_ADMIN    # For network discovery (SSDP, mDNS)
      - NET_RAW      # For ping integration
      - SYS_ADMIN    # For hardware access
```

**What this means:**
- ✅ Most integrations work out of the box (network discovery, ping, sensors)
- ✅ Better security and cluster isolation
- ✅ Compatible with Pod Security Standards
- ⚠️ Bluetooth integrations require privileged mode (see below)

### When You Need Privileged Mode

**Only enable privileged mode if you need:**
- Bluetooth integrations
- Full D-Bus system access
- Certain legacy hardware

**To enable privileged mode:**
```yaml
# values-privileged.yaml
securityContext:
  privileged: true
  capabilities:
    add: []  # Clear capabilities when using privileged

hostNetwork:
  enabled: true
```

**Deploy:**
```bash
helm upgrade home-assistant codefuturist/home-assistant \
  -f values-privileged.yaml
```

> 📘 **Tip**: Try the default unprivileged mode first. Only escalate to privileged if you encounter issues with specific integrations.

## Common Configurations

### Configuration 1: Enable Persistent Storage

By default, persistence is enabled with 5Gi. To adjust:

```yaml
# values-persistent.yaml
persistence:
  enabled: true
  size: 10Gi
  storageClassName: "fast-ssd"  # Your storage class

  media:
    enabled: true
    size: 20Gi

  backup:
    enabled: true
    size: 10Gi
```

Apply:
```bash
helm upgrade home-assistant codefuturist/home-assistant \
  -f values-persistent.yaml
```

### Configuration 2: Add Code Server for Config Editing

```yaml
# values-codeserver.yaml
codeserver:
  enabled: true
  env:
    PASSWORD: "change-me-please"
  ingress:
    enabled: true
    className: nginx
    hosts:
      - host: code.home.local
        paths:
          - path: /
            pathType: Prefix
```

Apply and access:
```bash
helm upgrade home-assistant codefuturist/home-assistant \
  -f values-codeserver.yaml
```

Visit: http://code.home.local (or port-forward to 8080)

### Configuration 3: Enable MQTT Broker

```yaml
# values-mqtt.yaml
mqtt:
  enabled: true
  port: 1883
  persistence:
    enabled: true
    size: 1Gi
```

Apply:
```bash
helm upgrade home-assistant codefuturist/home-assistant \
  -f values-mqtt.yaml
```

Configure in Home Assistant:
- Go to Settings → Devices & Services
- Add Integration → MQTT
- Broker: localhost
- Port: 1883

### Configuration 4: USB Device Access (Zigbee/Z-Wave)

```yaml
# values-zigbee.yaml
hostNetwork:
  enabled: true  # Required for device discovery

devices:
  enabled: true
  list:
    - hostPath: /dev/ttyUSB0
      containerPath: /dev/ttyUSB0

# Ensure pod runs on the node with the USB device
nodeSelector:
  kubernetes.io/hostname: node-with-zigbee
```

Apply:
```bash
helm upgrade home-assistant codefuturist/home-assistant \
  -f values-zigbee.yaml
```

### Configuration 5: Production with PostgreSQL

```bash
# 1. Create database secret
kubectl create secret generic ha-db-secret \
  --from-literal=password="$(openssl rand -base64 32)"

# 2. Install with PostgreSQL
helm install home-assistant codefuturist/home-assistant \
  --set postgresql.enabled=true \
  --set postgresql.auth.existingSecret=ha-db-secret \
  --set database.type=postgresql \
  --set database.postgresql.host=home-assistant-postgresql \
  --set database.postgresql.existingSecret=ha-db-secret
```

## Verification Checklist

After installation, verify everything is working:

```bash
# ✅ Pod is running
kubectl get pods -l app.kubernetes.io/name=home-assistant
# Should show: STATUS=Running

# ✅ Service is available
kubectl get svc home-assistant
# Should show service endpoints

# ✅ PVC is bound
kubectl get pvc
# Should show: STATUS=Bound

# ✅ Logs show no errors
kubectl logs -l app.kubernetes.io/name=home-assistant --tail=50
# Should see "Home Assistant initialized"

# ✅ Web interface accessible
curl -I http://localhost:8123 (after port-forward)
# Should return HTTP 200
```

## Quick Commands Reference

```bash
# View logs
kubectl logs -l app.kubernetes.io/name=home-assistant -f

# Restart Home Assistant
kubectl rollout restart deployment/home-assistant

# Check configuration
kubectl exec -it deployment/home-assistant -- ha core check

# Access shell
kubectl exec -it deployment/home-assistant -- /bin/bash

# Port forward
kubectl port-forward svc/home-assistant 8123:8123

# Backup config
kubectl exec deployment/home-assistant -- tar czf /backup/config.tar.gz /config

# View all resources
kubectl get all -l app.kubernetes.io/name=home-assistant
```

## Next Steps

### 1. Configure Home Assistant

Edit configuration files:

**Option A: Use Code Server (if enabled)**
- Access code-server web UI
- Edit `/config/configuration.yaml`

**Option B: Use kubectl**
```bash
kubectl exec -it deployment/home-assistant -- vi /config/configuration.yaml
```

**Option C: Use ConfigMap**
```yaml
homeassistant:
  configuration:
    http:
      use_x_forwarded_for: true
      trusted_proxies:
        - 10.0.0.0/8
```

### 2. Add Integrations

In Home Assistant:
1. Go to **Settings** → **Devices & Services**
2. Click **Add Integration**
3. Search for your devices/services
4. Follow the setup wizard

Popular integrations:
- **MQTT** - For IoT devices
- **ESPHome** - For ESP32/ESP8266 devices
- **Zigbee (ZHA)** - For Zigbee devices
- **Z-Wave** - For Z-Wave devices
- **HomeKit** - For Apple HomeKit
- **Google Assistant** - For Google Home
- **Alexa** - For Amazon Alexa

### 3. Set Up Automations

1. Go to **Settings** → **Automations & Scenes**
2. Click **Create Automation**
3. Use the visual editor or YAML mode
4. Test and save

### 4. Configure Dashboards

1. Go to **Overview** (main page)
2. Click **Edit Dashboard**
3. Add cards for your devices
4. Organize by rooms or categories

### 5. Enable Advanced Features

```yaml
homeassistant:
  configuration:
    # Enable advanced mode
    default_config:

    # Custom Python scripts
    python_script:

    # Text-to-speech
    tts:
      - platform: google_translate

    # Recorder (with PostgreSQL)
    recorder:
      db_url: postgresql://user:pass@host/db
      purge_keep_days: 30
      auto_purge: true

    # Logger
    logger:
      default: info
      logs:
        homeassistant.components.mqtt: debug
```

### 6. Set Up Backups

**Automated Backups** (using CronJob):
```yaml
# Create a backup CronJob
apiVersion: batch/v1
kind: CronJob
metadata:
  name: home-assistant-backup
spec:
  schedule: "0 2 * * *"  # 2 AM daily
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: backup
            image: ghcr.io/home-assistant/home-assistant:2024.11.1
            command:
            - /bin/bash
            - -c
            - |
              tar czf /backup/ha-backup-$(date +%Y%m%d).tar.gz /config
          volumeMounts:
          - name: config
            mountPath: /config
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

### 7. Secure Your Installation

1. **Enable Authentication**:
   - Already enabled by default in Home Assistant 2023.1+

2. **Use HTTPS**:
```yaml
ingress:
  enabled: true
  className: nginx
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt-prod
  tls:
    - secretName: home-assistant-tls
      hosts:
        - home.example.com
```

3. **Configure Trusted Proxies**:
```yaml
homeassistant:
  configuration:
    http:
      use_x_forwarded_for: true
      trusted_proxies:
        - 10.0.0.0/8  # Your cluster network
```

4. **Use Secrets**:
```yaml
homeassistant:
  secrets:
    http_password: "your-secure-password"
    api_key: "your-api-key"
```

## Troubleshooting

### Pod won't start
```bash
# Check pod events
kubectl describe pod -l app.kubernetes.io/name=home-assistant

# Check logs
kubectl logs -l app.kubernetes.io/name=home-assistant --tail=100
```

### Can't access web interface
```bash
# Verify service
kubectl get svc home-assistant

# Test connectivity
kubectl run -it --rm debug --image=busybox --restart=Never -- wget -O- http://home-assistant:8123
```

### Configuration errors
```bash
# Check configuration
kubectl exec -it deployment/home-assistant -- ha core check

# View configuration
kubectl exec -it deployment/home-assistant -- cat /config/configuration.yaml
```

### Database issues
```bash
# Check database connection (PostgreSQL)
kubectl exec -it deployment/home-assistant -- psql -h $DB_HOST -U $DB_USER -d homeassistant

# Check SQLite database
kubectl exec -it deployment/home-assistant -- ls -lh /config/home-assistant_v2.db
```

## Getting Help

- 📖 [Full Documentation](./README.md)
- 🏗️ [Architecture Guide](./docs/ARCHITECTURE.md)
- 💬 [Home Assistant Community](https://community.home-assistant.io/)
- 🐛 [Report Issues](https://github.com/codefuturist/helm-charts/issues)

## What's Next?

You now have a working Home Assistant installation! Here are some ideas:

1. **Add devices**: Start adding your smart home devices
2. **Create automations**: Automate your home based on triggers
3. **Build dashboards**: Create beautiful dashboards for control
4. **Explore integrations**: Discover the 2000+ integrations
5. **Join community**: Learn from other users
6. **Contribute**: Share your configurations and automations

Happy Home Automating! 🏠✨
