# Semaphore Helm Chart

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/codefuturist)](https://artifacthub.io/packages/helm/codefuturist/semaphore)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

A comprehensive, production-ready Helm chart for deploying [Semaphore UI](https://semaphoreui.com) on Kubernetes.

Semaphore is a modern UI for Ansible, Terraform, OpenTofu, Bash, and Pulumi. It provides a beautiful, responsive interface for managing infrastructure automation and orchestration tasks with support for task scheduling, role-based access control, and integration with various notification systems.

## Features

✅ **Multi-Tool Support**: Run Ansible, Terraform, OpenTofu, Bash, and Pulumi tasks  
✅ **Flexible Database Options**: PostgreSQL (default), SQLite, or MySQL  
✅ **Persistent Storage**: Separate volumes for data, config, and temporary files  
✅ **Runner Support**: Distributed task execution with runner registration  
✅ **Rich Integrations**: Email (SMTP), LDAP, Telegram, Slack, Rocket.Chat, Microsoft Teams, DingTalk, Gotify  
✅ **Security**: Encryption keys, 2FA support, RBAC, cookie encryption  
✅ **TLS/HTTPS**: Built-in TLS support with certificate management  
✅ **Task Scheduling**: Timezone-aware task scheduling with parallel execution control  
✅ **High Availability**: StatefulSet support with persistent identity  
✅ **Monitoring**: Prometheus ServiceMonitor and alerting rules  
✅ **Production Ready**: Resource limits, health probes, pod disruption budget  

## Quick Start

### Minimal Installation

```bash
helm repo add codefuturist https://codefuturist.github.io/helm-charts
helm install semaphore codefuturist/semaphore
```

Access Semaphore:
```bash
kubectl port-forward svc/semaphore 3000:3000
# Open http://localhost:3000
# Login: admin / changeme
```

### With Ingress

```bash
helm install semaphore codefuturist/semaphore \
  --set ingress.enabled=true \
  --set ingress.hosts[0].host=semaphore.example.com \
  --set ingress.hosts[0].paths[0].path=/ \
  --set ingress.hosts[0].paths[0].pathType=Prefix
```

## Prerequisites

- Kubernetes 1.21+
- Helm 3.8+
- PV provisioner support in the underlying infrastructure
- (Optional) cert-manager for TLS certificates
- (Optional) Prometheus Operator for monitoring
- (Optional) PostgreSQL or MySQL for external database

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
│                    (ClusterIP)                              │
└────────────────────────┬────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────┐
│               Deployment/StatefulSet                        │
│  ┌─────────────────────────────────────────────────────┐   │
│  │  Semaphore Container                                │   │
│  │  - Port 3000                                        │   │
│  │  - SQLite/PostgreSQL/MySQL                          │   │
│  │  - Data Volume (/var/lib/semaphore)                 │   │
│  │  - Config Volume (/etc/semaphore)                   │   │
│  │  - Temp Volume (/tmp/semaphore)                     │   │
│  │  - Git repositories, inventories, playbooks         │   │
│  └─────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────┐
│              PersistentVolumeClaims                         │
│  - data-pvc (5Gi) - Database and user data                 │
│  - config-pvc (100Mi) - Optional configuration files       │
│  - tmp-pvc (10Gi) - Git repos, cache, inventory            │
└─────────────────────────────────────────────────────────────┘
```

## Installation

### Add Helm Repository

```bash
helm repo add codefuturist https://codefuturist.github.io/helm-charts
helm repo update
```

### Install Chart

```bash
# Basic installation with SQLite
helm install semaphore codefuturist/semaphore

# With custom values
helm install semaphore codefuturist/semaphore -f values.yaml

# With inline values
helm install semaphore codefuturist/semaphore \
  --set semaphore.admin.password=SecurePassword123 \
  --set persistence.data.size=20Gi
```

## Configuration Examples

### SQLite

Simplest setup, suitable for small single-instance deployments:

```yaml
semaphore:
  database:
    dialect: sqlite

  admin:
    username: admin
    password: changeme
    email: admin@localhost

persistence:
  data:
    enabled: true
    size: 5Gi
  config:
    enabled: false
  tmp:
    enabled: true
    size: 10Gi
```

### PostgreSQL (Default)

Recommended for production deployments. This is the default configuration:

```yaml
semaphore:
  database:
    dialect: postgres  # Default
    host: postgresql
    port: 5432
    user: semaphore
    password: SecureDBPassword
    name: semaphore
    sslMode: require

  admin:
    username: admin
    password: SecureAdminPassword
    email: admin@example.com

controller:
  type: statefulset
  replicas: 2

persistence:
  volumeClaimTemplates:
    enabled: true
    data:
      size: 20Gi
    tmp:
      size: 50Gi
```

### MySQL

Alternative database option:

```yaml
semaphore:
  database:
    dialect: mysql
    host: mysql.default.svc.cluster.local
    port: 3306
    user: semaphore
    password: SecureDBPassword
    name: semaphore
    sslMode: "true"
```

### With Email Notifications

```yaml
semaphore:
  email:
    enabled: true
    sender: semaphore@example.com
    host: smtp.gmail.com
    port: 587
    username: semaphore@example.com
    password: app-specific-password
    secure: true
    tls: true
```

### With LDAP Authentication

```yaml
semaphore:
  ldap:
    enabled: true
    bindDn: "cn=admin,dc=example,dc=com"
    bindPassword: ldap-password
    server: ldap://ldap.example.com:389
    searchDn: "ou=users,dc=example,dc=com"
    searchFilter: "(&(objectClass=user)(sAMAccountName=%s))"
    mappingDn: dn
    mappingMail: mail
    mappingUid: uid
    mappingCn: cn
```

### With Telegram Integration

```yaml
semaphore:
  messengers:
    telegram:
      enabled: true
      chat: "-1001234567890"
      token: "bot123456:ABC-DEF1234ghIkl-zyx57W2v1u123ew11"
```

### With Distributed Runners

Deploy separate runner pods for distributed task execution:

```yaml
semaphore:
  # Enable runner registration on the server
  runner:
    enabled: true
    registrationToken: "your-secure-random-token-here"

# Deploy separate runner pods
runnerDeployment:
  enabled: true
  replicas: 3  # Number of runner pods

  image:
    repository: semaphoreui/runner
    tag: "v2.16.43"

  server:
    webRoot: "http://semaphore:3000"
    registrationToken: "your-secure-random-token-here"  # Must match server token

  resources:
    limits:
      cpu: 2000m
      memory: 2Gi
    requests:
      cpu: 500m
      memory: 512Mi

  persistence:
    data:
      enabled: true
      size: 5Gi
    tmp:
      enabled: true
      size: 10Gi
```

> **Note**: The runner deployment creates separate pods that connect to the Semaphore server to execute tasks in a distributed manner. This is useful for scaling task execution across multiple nodes.

### With Runner Support (Server Only)

Enable runner registration without deploying runner pods:

```yaml
semaphore:
  runner:
    enabled: true
    registrationToken: "your-secure-random-token-here"
```
resources:
  limits:
    cpu: 4000m
    memory: 4Gi
  requests:
    cpu: 1000m
    memory: 1Gi
```

### Using Existing Secrets

For production, store sensitive data in Kubernetes secrets:

```bash
# Create secret
kubectl create secret generic semaphore-secrets \
  --from-literal=database-password=DBPassword \
  --from-literal=admin-password=AdminPassword \
  --from-literal=cookie-hash=$(openssl rand -hex 32) \
  --from-literal=cookie-encryption=$(openssl rand -hex 16) \
  --from-literal=access-key-encryption=$(openssl rand -hex 16) \
  --from-literal=runner-token=RunnerToken
```

```yaml
semaphore:
  existingSecret: semaphore-secrets

  database:
    dialect: postgres
    host: postgresql.default.svc.cluster.local
    user: semaphore
    name: semaphore
    # password read from secret

  admin:
    username: admin
    # password read from secret
    email: admin@example.com
```

## Parameters

### Global Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `namespaceOverride` | Override namespace | `""` |
| `nameOverride` | Override chart name | `""` |
| `fullnameOverride` | Override full name | `""` |
| `additionalLabels` | Additional labels for all resources | `{}` |
| `additionalAnnotations` | Additional annotations for all resources | `{}` |

### Image Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `image.repository` | Semaphore image repository | `semaphoreui/semaphore` |
| `image.tag` | Image tag | `v2.10.32` |
| `image.pullPolicy` | Image pull policy | `IfNotPresent` |
| `image.digest` | Image digest (overrides tag) | `""` |
| `imagePullSecrets` | Image pull secrets | `[]` |

### Semaphore Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `semaphore.port` | HTTP port | `3000` |
| `semaphore.interface` | Network interface to bind | `""` |
| `semaphore.tmpPath` | Temporary files path | `""` |
| `semaphore.gitClient` | Git client type (`cmd_git` or `go_git`) | `cmd_git` |
| `semaphore.webRoot` | Public web address | `""` |
| `semaphore.scheduleTimezone` | Timezone for task scheduling | `""` |
| `semaphore.maxTaskDurationSec` | Maximum task duration in seconds | `""` |
| `semaphore.maxParallelTasks` | Maximum parallel tasks | `""` |
| `semaphore.maxTasksPerTemplate` | Recent tasks per template | `""` |
| `semaphore.passwordLoginDisabled` | Disable password login | `false` |
| `semaphore.nonAdminCanCreateProject` | Allow non-admins to create projects | `false` |

### Database Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `semaphore.database.dialect` | Database type (`sqlite`, `postgres`, `mysql`) | `sqlite` |
| `semaphore.database.host` | Database host | `localhost` |
| `semaphore.database.port` | Database port | `""` |
| `semaphore.database.user` | Database user | `root` |
| `semaphore.database.password` | Database password | `password` |
| `semaphore.database.name` | Database name | `semaphore` |
| `semaphore.database.sslMode` | SSL mode (postgres: `disable`, `require`, `verify-ca`, `verify-full`; mysql: `true`, `false`, `skip-verify`) | `prefer` |
| `semaphore.database.options` | Additional database options (JSON) | `{}` |

### Admin User Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `semaphore.admin.username` | Admin username | `admin` |
| `semaphore.admin.password` | Admin password | `changeme` |
| `semaphore.admin.name` | Admin display name | `Admin` |
| `semaphore.admin.email` | Admin email | `admin@localhost` |

### Runner Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `semaphore.runner.enabled` | Enable runner support | `false` |
| `semaphore.runner.registrationToken` | Runner registration token | `""` |

### Email Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `semaphore.email.enabled` | Enable email notifications | `false` |
| `semaphore.email.sender` | Sender email address | `""` |
| `semaphore.email.host` | SMTP server hostname | `""` |
| `semaphore.email.port` | SMTP server port | `""` |
| `semaphore.email.username` | SMTP username | `""` |
| `semaphore.email.password` | SMTP password | `""` |
| `semaphore.email.secure` | Enable StartTLS | `false` |
| `semaphore.email.tls` | Use SSL/TLS connection | `false` |

### LDAP Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `semaphore.ldap.enabled` | Enable LDAP authentication | `false` |
| `semaphore.ldap.bindDn` | LDAP bind DN | `""` |
| `semaphore.ldap.bindPassword` | LDAP bind password | `""` |
| `semaphore.ldap.server` | LDAP server URL | `""` |
| `semaphore.ldap.searchDn` | LDAP search DN | `""` |
| `semaphore.ldap.searchFilter` | LDAP search filter | `""` |
| `semaphore.ldap.needTls` | Require TLS | `false` |
| `semaphore.ldap.mappingDn` | DN attribute mapping | `""` |
| `semaphore.ldap.mappingMail` | Email attribute mapping | `""` |
| `semaphore.ldap.mappingUid` | UID attribute mapping | `""` |
| `semaphore.ldap.mappingCn` | CN attribute mapping | `""` |

### Security Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `semaphore.security.cookieHash` | Cookie signing key (required) | `""` |
| `semaphore.security.cookieEncryption` | Cookie encryption key | `""` |
| `semaphore.security.accessKeyEncryption` | Access key encryption key | `""` |
| `semaphore.totp.enabled` | Enable 2FA | `false` |
| `semaphore.totp.allowRecovery` | Allow TOTP recovery | `false` |

### TLS Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `semaphore.tls.enabled` | Enable TLS | `false` |
| `semaphore.tls.certFile` | TLS certificate file path | `""` |
| `semaphore.tls.keyFile` | TLS key file path | `""` |
| `semaphore.tls.httpRedirectPort` | HTTP to HTTPS redirect port | `""` |

### Messenger Integrations

| Parameter | Description | Default |
|-----------|-------------|---------|
| `semaphore.messengers.telegram.enabled` | Enable Telegram | `false` |
| `semaphore.messengers.telegram.chat` | Telegram chat ID | `""` |
| `semaphore.messengers.telegram.token` | Telegram bot token | `""` |
| `semaphore.messengers.slack.enabled` | Enable Slack | `false` |
| `semaphore.messengers.slack.url` | Slack webhook URL | `""` |
| `semaphore.messengers.rocketchat.enabled` | Enable Rocket.Chat | `false` |
| `semaphore.messengers.rocketchat.url` | Rocket.Chat webhook URL | `""` |
| `semaphore.messengers.microsoftTeams.enabled` | Enable Microsoft Teams | `false` |
| `semaphore.messengers.microsoftTeams.url` | Teams webhook URL | `""` |
| `semaphore.messengers.dingtalk.enabled` | Enable DingTalk | `false` |
| `semaphore.messengers.dingtalk.url` | DingTalk webhook URL | `""` |
| `semaphore.messengers.gotify.enabled` | Enable Gotify | `false` |
| `semaphore.messengers.gotify.url` | Gotify server URL | `""` |
| `semaphore.messengers.gotify.token` | Gotify token | `""` |

### Ansible Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `semaphore.ansible.hostKeyChecking` | SSH host key checking | `false` |

### Existing Secret

| Parameter | Description | Default |
|-----------|-------------|---------|
| `semaphore.existingSecret` | Use existing secret for credentials | `""` |

### Controller Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `controller.type` | Controller type (`deployment` or `statefulset`) | `deployment` |
| `controller.replicas` | Number of replicas (deployment only) | `1` |
| `controller.strategy.type` | Update strategy type | `RollingUpdate` |
| `controller.podManagementPolicy` | Pod management policy (statefulset) | `OrderedReady` |
| `controller.terminationGracePeriodSeconds` | Termination grace period | `30` |

### Service Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `service.type` | Service type | `ClusterIP` |
| `service.port` | Service port | `3000` |
| `service.targetPort` | Container target port | `3000` |
| `service.nodePort` | NodePort (if type is NodePort) | `""` |
| `service.annotations` | Service annotations | `{}` |
| `service.labels` | Service labels | `{}` |

### Ingress Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `ingress.enabled` | Enable ingress | `false` |
| `ingress.className` | Ingress class name | `""` |
| `ingress.annotations` | Ingress annotations | `{}` |
| `ingress.hosts` | Ingress hosts configuration | See values.yaml |
| `ingress.tls` | Ingress TLS configuration | `[]` |

### Persistence Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `persistence.data.enabled` | Enable data volume | `true` |
| `persistence.data.storageClassName` | Storage class name | `""` |
| `persistence.data.accessMode` | Access mode | `ReadWriteOnce` |
| `persistence.data.size` | Volume size | `10Gi` |
| `persistence.data.existingClaim` | Use existing PVC | `""` |
| `persistence.config.enabled` | Enable config volume | `true` |
| `persistence.config.size` | Volume size | `1Gi` |
| `persistence.tmp.enabled` | Enable temporary volume | `true` |
| `persistence.tmp.size` | Volume size | `20Gi` |

### Security Contexts

| Parameter | Description | Default |
|-----------|-------------|---------|
| `podSecurityContext.runAsNonRoot` | Run as non-root user | `true` |
| `podSecurityContext.runAsUser` | User ID | `1001` |
| `podSecurityContext.runAsGroup` | Group ID | `1001` |
| `podSecurityContext.fsGroup` | FS group | `1001` |
| `securityContext.allowPrivilegeEscalation` | Allow privilege escalation | `false` |
| `securityContext.readOnlyRootFilesystem` | Read-only root filesystem | `false` |

### Resources

| Parameter | Description | Default |
|-----------|-------------|---------|
| `resources.limits.cpu` | CPU limit | `2000m` |
| `resources.limits.memory` | Memory limit | `2Gi` |
| `resources.requests.cpu` | CPU request | `500m` |
| `resources.requests.memory` | Memory request | `512Mi` |

### Health Probes

| Parameter | Description | Default |
|-----------|-------------|---------|
| `livenessProbe.enabled` | Enable liveness probe | `true` |
| `livenessProbe.initialDelaySeconds` | Initial delay | `60` |
| `readinessProbe.enabled` | Enable readiness probe | `true` |
| `readinessProbe.initialDelaySeconds` | Initial delay | `30` |
| `startupProbe.enabled` | Enable startup probe | `true` |
| `startupProbe.failureThreshold` | Failure threshold | `60` |

### Service Account & RBAC

| Parameter | Description | Default |
|-----------|-------------|---------|
| `serviceAccount.create` | Create service account | `true` |
| `serviceAccount.name` | Service account name | `""` |
| `rbac.create` | Create RBAC resources | `true` |

### Pod Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `podAnnotations` | Pod annotations | `{}` |
| `podLabels` | Pod labels | `{}` |
| `priorityClassName` | Priority class name | `""` |
| `nodeSelector` | Node selector | `{}` |
| `tolerations` | Tolerations | `[]` |
| `affinity` | Affinity rules | `{}` |

### High Availability

| Parameter | Description | Default |
|-----------|-------------|---------|
| `pdb.enabled` | Enable pod disruption budget | `false` |
| `pdb.minAvailable` | Minimum available pods | `1` |
| `hpa.enabled` | Enable horizontal pod autoscaler | `false` |
| `hpa.minReplicas` | Minimum replicas | `1` |
| `hpa.maxReplicas` | Maximum replicas | `10` |
| `hpa.targetCPUUtilizationPercentage` | Target CPU % | `80` |

### Monitoring

| Parameter | Description | Default |
|-----------|-------------|---------|
| `monitoring.serviceMonitor.enabled` | Enable ServiceMonitor | `false` |
| `monitoring.serviceMonitor.interval` | Scrape interval | `60s` |
| `monitoring.prometheusRule.enabled` | Enable PrometheusRule | `false` |

### Network Policy

| Parameter | Description | Default |
|-----------|-------------|---------|
| `networkPolicy.enabled` | Enable network policy | `false` |
| `networkPolicy.ingress` | Ingress rules | `[]` |
| `networkPolicy.egress` | Egress rules | See values.yaml |

## Upgrading

### From SQLite to PostgreSQL

1. Export your data from SQLite (backup recommended)
2. Set up PostgreSQL database
3. Update values to use PostgreSQL:

```yaml
semaphore:
  database:
    dialect: postgres
    host: postgresql.default.svc.cluster.local
    port: 5432
    user: semaphore
    password: SecurePassword
    name: semaphore
```

4. Upgrade the release:

```bash
helm upgrade semaphore codefuturist/semaphore -f values.yaml
```

### Version Upgrades

```bash
# Update repository
helm repo update

# Upgrade release
helm upgrade semaphore codefuturist/semaphore

# Or with custom values
helm upgrade semaphore codefuturist/semaphore -f values.yaml
```

## Uninstalling

```bash
# Uninstall release
helm uninstall semaphore

# Optional: Remove PVCs if no longer needed
kubectl delete pvc -l app.kubernetes.io/name=semaphore
```

## Common Scenarios

### Development Environment

Quick setup for testing:

```bash
helm install semaphore codefuturist/semaphore \
  --set semaphore.admin.password=dev123 \
  --set persistence.data.size=5Gi \
  --set persistence.tmp.size=10Gi
```

### Production Environment

Secure production setup:

```bash
# Create secrets first
kubectl create secret generic semaphore-secrets \
  --from-literal=database-password=SecureDBPass \
  --from-literal=admin-password=SecureAdminPass \
  --from-literal=cookie-hash=$(openssl rand -hex 32) \
  --from-literal=cookie-encryption=$(openssl rand -hex 16) \
  --from-literal=access-key-encryption=$(openssl rand -hex 16)

# Install with production values
helm install semaphore codefuturist/semaphore \
  -f examples/values-production.yaml
```

### With External Database

Using managed PostgreSQL:

```yaml
semaphore:
  database:
    dialect: postgres
    host: postgres.example.com
    port: 5432
    user: semaphore
    password: SecurePassword
    name: semaphore
    sslMode: require

controller:
  type: statefulset
  replicas: 2
```

### Behind Reverse Proxy

```yaml
semaphore:
  webRoot: "https://example.com/semaphore"

ingress:
  enabled: true
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
  hosts:
    - host: example.com
      paths:
        - path: /semaphore
          pathType: Prefix
```

## Troubleshooting

### Pods Not Starting

Check events and logs:
```bash
kubectl describe pod -l app.kubernetes.io/name=semaphore
kubectl logs -l app.kubernetes.io/name=semaphore
```

### Database Connection Issues

Verify database connectivity:
```bash
kubectl exec -it deployment/semaphore -- /bin/sh
# Test connection from within pod
```

### Permission Issues

Check security contexts and volume permissions:
```bash
kubectl describe pod -l app.kubernetes.io/name=semaphore
# Look for permission denied errors
```

### Runner Registration

Verify runner token and API URL:
```bash
# Check environment variables
kubectl exec -it deployment/semaphore -- env | grep SEMAPHORE
```

## Examples

See the [examples](./examples) directory for complete configuration examples:

- **values-minimal.yaml** - Minimal setup for quick testing
- **values-production.yaml** - Production-ready configuration
- **values-with-persistence.yaml** - Basic setup with persistent storage
- **values-multiple-servers.yaml** - Multi-database configuration
- **values-reverse-proxy.yaml** - Behind reverse proxy setup

## Documentation

- [Quick Start Guide](./docs/QUICKSTART.md) - Step-by-step installation guide
- [Testing Guide](./docs/TESTING.md) - Testing and validation procedures

## Support

- [Semaphore UI Documentation](https://docs.semaphoreui.com)
- [GitHub Issues](https://github.com/codefuturist/helm-charts/issues)
- [Semaphore UI GitHub](https://github.com/semaphoreui/semaphore)

## License

Apache 2.0 License. See [LICENSE](../../LICENSE) for details.
