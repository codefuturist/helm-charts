# Semaphore Quick Start Guide

This guide will help you get Semaphore running on Kubernetes in minutes with secure defaults.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Basic Installation](#basic-installation)
3. [First Login](#first-login)
4. [Security Notes](#security-notes)
5. [Common Configurations](#common-configurations)
6. [Creating Your First Project](#creating-your-first-project)
7. [Next Steps](#next-steps)

## Prerequisites

Before you begin, ensure you have:

- ✅ Kubernetes cluster (1.21+)
- ✅ kubectl configured and connected
- ✅ Helm 3.8+ installed
- ✅ Storage class available (check with `kubectl get storageclass`)
- ✅ PostgreSQL database (recommended) or use SQLite for development

## Basic Installation

### 1. Add the Helm Repository

```bash
helm repo add pandia https://charts.pandia.io
helm repo update
```

### 2. Install Semaphore

**Option A: With PostgreSQL (Recommended for Production)**

```bash
# Prerequisites: Have PostgreSQL running
# Create database and user first

helm install semaphore codefuturist/semaphore \
  --set semaphore.database.dialect=postgres \
  --set semaphore.database.host=postgresql.default.svc.cluster.local \
  --set semaphore.database.password=YourDBPassword123 \
  --set semaphore.admin.password=YourSecurePassword123

# Check installation
kubectl get pods -l app.kubernetes.io/name=semaphore
```

**Option B: Development Setup (SQLite)**

```bash
# Install with SQLite for testing/development
helm install semaphore codefuturist/semaphore \
  --set semaphore.database.dialect=sqlite \
  --set semaphore.admin.password=YourSecurePassword123
  --set semaphore.admin.email=admin@example.com
```

**Option C: With Ingress**

```bash
helm install semaphore codefuturist/semaphore \
  --set semaphore.admin.password=YourSecurePassword123 \
  --set ingress.enabled=true \
  --set ingress.className=nginx \
  --set ingress.hosts[0].host=semaphore.local \
  --set ingress.hosts[0].paths[0].path=/ \
  --set ingress.hosts[0].paths[0].pathType=Prefix
```

**Option D: Production Setup with PostgreSQL**

```bash
# Create database secret
kubectl create secret generic semaphore-secrets \
  --from-literal=database-password=SecureDBPassword \
  --from-literal=admin-password=SecureAdminPassword \
  --from-literal=cookie-hash=$(openssl rand -hex 32) \
  --from-literal=cookie-encryption=$(openssl rand -hex 16) \
  --from-literal=access-key-encryption=$(openssl rand -hex 16)

# Install with PostgreSQL
helm install semaphore codefuturist/semaphore \
  --set semaphore.existingSecret=semaphore-secrets \
  --set semaphore.database.dialect=postgres \
  --set semaphore.database.host=postgresql.default.svc.cluster.local \
  --set semaphore.database.user=semaphore \
  --set semaphore.database.name=semaphore \
  --set semaphore.admin.email=admin@example.com \
  --set controller.type=statefulset
```

**Option E: With Distributed Runners**

```bash
# Deploy Semaphore with 3 runner pods for distributed task execution
helm install semaphore codefuturist/semaphore \
  --set semaphore.admin.password=YourSecurePassword123 \
  --set semaphore.runner.enabled=true \
  --set semaphore.runner.registrationToken=$(openssl rand -hex 32) \
  --set runnerDeployment.enabled=true \
  --set runnerDeployment.replicas=3 \
  --set runnerDeployment.server.webRoot=http://semaphore:3000 \
  --set runnerDeployment.server.registrationToken=$(openssl rand -hex 32)

# Note: Both registration tokens must match!
# In production, use a values file instead
```

### 3. Wait for Deployment

```bash
# Watch pod status
kubectl get pods -w

# Check logs
kubectl logs -l app.kubernetes.io/name=semaphore -f
```

The first startup may take 1-2 minutes as Semaphore initializes the database.

## First Login

### Access Semaphore

**If using ClusterIP (default):**

```bash
kubectl port-forward svc/semaphore 3000:3000
```

Then visit: http://localhost:3000

**If using LoadBalancer:**

```bash
kubectl get svc semaphore
# Note the EXTERNAL-IP
```

Visit: http://EXTERNAL-IP:3000

**If using Ingress:**

Visit your configured domain (e.g., http://semaphore.local)

### Initial Login

1. Open Semaphore in your browser
2. Login with default credentials:
   - **Username**: `admin`
   - **Password**: `changeme` (or the password you set)
3. You'll be prompted to change your password on first login (recommended)

## Security Notes

### Change Default Password

⚠️ **IMPORTANT**: If you used the default password, change it immediately:

1. Log in to Semaphore
2. Click on your profile (top right)
3. Go to Settings → Account
4. Update your password

### Generate Strong Encryption Keys

For production deployments, generate strong encryption keys:

```bash
# Generate keys
COOKIE_HASH=$(openssl rand -hex 32)
COOKIE_ENCRYPTION=$(openssl rand -hex 16)
ACCESS_KEY_ENCRYPTION=$(openssl rand -hex 16)

# Create secret
kubectl create secret generic semaphore-secrets \
  --from-literal=admin-password=YourSecurePassword \
  --from-literal=cookie-hash=$COOKIE_HASH \
  --from-literal=cookie-encryption=$COOKIE_ENCRYPTION \
  --from-literal=access-key-encryption=$ACCESS_KEY_ENCRYPTION

# Upgrade with secret
helm upgrade semaphore codefuturist/semaphore \
  --set semaphore.existingSecret=semaphore-secrets
```

## Common Configurations

### 1. Enable Email Notifications

```bash
helm upgrade semaphore codefuturist/semaphore \
  --set semaphore.email.enabled=true \
  --set semaphore.email.host=smtp.gmail.com \
  --set semaphore.email.port=587 \
  --set semaphore.email.username=your-email@gmail.com \
  --set semaphore.email.password=your-app-password \
  --set semaphore.email.sender=semaphore@example.com \
  --set semaphore.email.secure=true
```

### 2. Configure Telegram Notifications

First, create a Telegram bot and get the bot token and chat ID.

```bash
helm upgrade semaphore codefuturist/semaphore \
  --set semaphore.messengers.telegram.enabled=true \
  --set semaphore.messengers.telegram.token=bot123456:ABC-DEF1234ghIkl \
  --set semaphore.messengers.telegram.chat=-1001234567890
```

### 3. Enable LDAP Authentication

Create a values file `ldap-values.yaml`:

```yaml
semaphore:
  ldap:
    enabled: true
    bindDn: "cn=admin,dc=example,dc=com"
    bindPassword: "ldap-password"
    server: "ldap://ldap.example.com:389"
    searchDn: "ou=users,dc=example,dc=com"
    searchFilter: "(&(objectClass=user)(sAMAccountName=%s))"
    mappingDn: dn
    mappingMail: mail
    mappingUid: uid
    mappingCn: cn
```

Apply:

```bash
helm upgrade semaphore codefuturist/semaphore -f ldap-values.yaml
```

### 4. Increase Storage for Git Repositories

```bash
helm upgrade semaphore codefuturist/semaphore \
  --set persistence.tmp.size=50Gi
```

### 5. Enable Runner Support

For distributed task execution:

```bash
# Generate runner token
RUNNER_TOKEN=$(openssl rand -hex 32)

helm upgrade semaphore codefuturist/semaphore \
  --set semaphore.runner.enabled=true \
  --set semaphore.runner.registrationToken=$RUNNER_TOKEN
```

Save the `RUNNER_TOKEN` - you'll need it to register runners.

## Creating Your First Project

### 1. Create a New Project

1. After logging in, click **"New Project"**
2. Enter project details:
   - **Name**: My First Project
   - **Alert**: (optional) Enable alerts

### 2. Add a Key Store

For SSH/Git access:

1. Go to **Key Store** → **New Key**
2. Choose type:
   - **SSH**: For Git repositories
   - **Login Password**: For server access
   - **None**: For no authentication
3. For SSH:
   - Name: `github-deploy-key`
   - Paste your private SSH key
   - Or generate a new one

### 3. Add a Repository

1. Go to **Repositories** → **New Repository**
2. Enter repository details:
   - **Name**: ansible-playbooks
   - **URL**: `git@github.com:username/ansible-playbooks.git`
   - **Branch**: main
   - **Key**: Select your SSH key
3. Click **Create**

### 4. Create an Inventory

1. Go to **Inventory** → **New Inventory**
2. Choose type:
   - **Static**: Manual host list
   - **File**: Ansible inventory file
3. For static inventory:
   - **Name**: production
   - **Type**: Static
   - **Inventory**:

     ```ini
     [webservers]
     web1.example.com
     web2.example.com

     [databases]
     db1.example.com
     ```

### 5. Create a Template

1. Go to **Task Templates** → **New Template**
2. Enter template details:
   - **Name**: Deploy Web App
   - **Playbook**: `deploy.yml`
   - **Inventory**: production
   - **Repository**: ansible-playbooks
   - **Environment**: (optional) Add env vars
3. Click **Create**

### 6. Run Your First Task

1. Go to the template you created
2. Click **Run**
3. Monitor the task output in real-time
4. View task history and logs

## Next Steps

### Explore Advanced Features

- **Task Scheduling**: Set up cron-like scheduled tasks
- **Terraform Integration**: Manage infrastructure as code
- **OpenTofu**: Use OpenTofu for infrastructure management
- **Bash Scripts**: Run custom bash scripts
- **Pulumi**: Infrastructure as code with general-purpose languages

### Set Up Monitoring

Enable Prometheus monitoring:

```bash
helm upgrade semaphore codefuturist/semaphore \
  --set monitoring.serviceMonitor.enabled=true \
  --set monitoring.prometheusRule.enabled=true
```

### Configure High Availability

For production with multiple replicas:

```yaml
controller:
  type: statefulset
  replicas: 2

semaphore:
  database:
    dialect: postgres
    host: postgresql.default.svc.cluster.local
    # ... other postgres settings

pdb:
  enabled: true
  minAvailable: 1

hpa:
  enabled: true
  minReplicas: 2
  maxReplicas: 5
```

### Backup and Recovery

Set up Velero annotations for backup:

```yaml
persistence:
  data:
    annotations:
      backup.velero.io/backup-volumes: data
  config:
    annotations:
      backup.velero.io/backup-volumes: config
```

### Enable TLS/HTTPS

With cert-manager:

```yaml
ingress:
  enabled: true
  className: nginx
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt-prod
  hosts:
    - host: semaphore.example.com
      paths:
        - path: /
          pathType: Prefix
  tls:
    - secretName: semaphore-tls
      hosts:
        - semaphore.example.com
```

## Troubleshooting

### Pod Not Starting

```bash
# Check pod status
kubectl describe pod -l app.kubernetes.io/name=semaphore

# Check logs
kubectl logs -l app.kubernetes.io/name=semaphore
```

### Can't Connect to Database

```bash
# Test database connectivity from pod
kubectl exec -it deployment/semaphore -- /bin/sh
# Try connecting to database manually
```

### Volume Permission Issues

If you see permission denied errors:

```bash
# Check volume permissions
kubectl exec -it deployment/semaphore -- ls -la /var/lib/semaphore
```

The chart runs as user `1001` by default. Ensure your storage class supports fsGroup.

### Reset Admin Password

If you forget the admin password:

```bash
# For SQLite (default)
kubectl exec -it deployment/semaphore -- /bin/sh
# Use semaphore CLI to reset password (if available)

# Or update the secret
kubectl delete secret semaphore-secrets
kubectl create secret generic semaphore-secrets \
  --from-literal=admin-password=NewPassword123

# Restart pod
kubectl rollout restart deployment/semaphore
```

## Common Issues

### Issue: "Cookie hash is required"

**Solution**: Set security encryption keys:

```bash
kubectl create secret generic semaphore-secrets \
  --from-literal=cookie-hash=$(openssl rand -hex 32)

helm upgrade semaphore codefuturist/semaphore \
  --set semaphore.existingSecret=semaphore-secrets
```

### Issue: Git operations failing

**Solution**: Ensure proper SSH key configuration and network access:

```bash
# Check network policy allows egress to Git servers
# Check SSH key is correctly added to Key Store
```

### Issue: High memory usage

**Solution**: Increase resources or reduce parallel tasks:

```bash
helm upgrade semaphore codefuturist/semaphore \
  --set resources.limits.memory=4Gi \
  --set semaphore.maxParallelTasks=5
```

## Getting Help

- **Documentation**: https://docs.semaphoreui.com
- **GitHub Issues**: https://github.com/codefuturist/helm-charts/issues
- **Semaphore Issues**: https://github.com/semaphoreui/semaphore/issues
- **Community**: Semaphore UI community discussions

## Next Reading

- [Full README](../README.md) - Complete documentation
- [Testing Guide](./TESTING.md) - Testing procedures
- [Examples](../examples/) - Configuration examples
