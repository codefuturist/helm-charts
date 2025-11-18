# Semaphore Examples

This directory contains example configurations for common deployment scenarios.

## Available Examples

### 1. values-minimal.yaml

Minimal configuration for quick development/testing:

- SQLite database (no external dependencies)
- Basic deployment controller
- Minimal resources
- ClusterIP service
- Basic persistence
- Best for: Quick testing, development, single-user

```bash
helm install my-semaphore codefuturist/semaphore -f values-minimal.yaml
```

### 2. values-with-persistence.yaml

Configuration demonstrating persistent storage setup:

- Three separate volumes (data, config, tmp)
- StatefulSet with volumeClaimTemplates
- PostgreSQL database
- Configurable storage classes and sizes
- Backup annotations
- Best for: Long-term deployments, data retention

```bash
helm install my-semaphore codefuturist/semaphore -f values-with-persistence.yaml
```

### 3. values-production.yaml

Production-ready configuration with all best practices:

- PostgreSQL database (required for multi-user)
- Uses Kubernetes secrets for credentials
- LDAP authentication
- Email notifications
- Two-factor authentication (TOTP)
- StatefulSet controller with multiple replicas
- Ingress with TLS
- Network policies enabled
- Monitoring with ServiceMonitor and PrometheusRule
- Pod disruption budget
- Pod anti-affinity for HA
- Runner support
- Best for: Production environments

Prerequisites:

```bash
# Create credentials secret
kubectl create secret generic semaphore-credentials \
  --from-literal=database-password=YourDBPassword123 \
  --from-literal=admin-password=YourAdminPassword123 \
  --from-literal=cookie-hash=$(openssl rand -hex 32) \
  --from-literal=cookie-encryption=$(openssl rand -hex 32) \
  --from-literal=access-key-encryption=$(openssl rand -hex 32)
```

Install:

```bash
helm install my-semaphore codefuturist/semaphore -f values-production.yaml
```

### 4. values-multiple-servers.yaml

High availability configuration with multiple Semaphore instances:

- PostgreSQL HA cluster required
- StatefulSet with 3 replicas
- Pod anti-affinity across nodes and zones
- Session affinity for consistent user experience
- Parallel pod management
- Topology spread constraints
- Pod disruption budget
- Best for: High availability, distributed task execution

Prerequisites:

```bash
# Ensure PostgreSQL HA cluster is available
# Example: using Bitnami PostgreSQL HA
helm install postgresql-ha bitnami/postgresql-ha

# Create database and user
kubectl exec -it postgresql-ha-postgresql-0 -- psql -U postgres
CREATE DATABASE semaphore;
CREATE USER semaphore WITH PASSWORD 'password';
GRANT ALL PRIVILEGES ON DATABASE semaphore TO semaphore;
```

Install:

```bash
helm install my-semaphore codefuturist/semaphore -f values-multiple-servers.yaml
```

### 5. values-reverse-proxy.yaml

Configuration for running behind a reverse proxy or on a subpath:

- Configured for subpath deployment (e.g., `/semaphore`)
- URL rewriting rules
- WebSocket support
- Security headers
- Extended timeouts for long-running tasks
- Best for: Enterprise environments with existing infrastructure

```bash
helm install my-semaphore codefuturist/semaphore -f values-reverse-proxy.yaml
```

## Quick Start

1. **Development/Testing:**

   ```bash
   helm install dev-semaphore codefuturist/semaphore -f values-minimal.yaml
   ```

2. **Production (Simple):**

   ```bash
   # Create secret first
   kubectl create secret generic semaphore-credentials \
     --from-literal=admin-password=$(openssl rand -base64 32)

   # Install with persistence
   helm install prod-semaphore codefuturist/semaphore \
     -f values-with-persistence.yaml \
     --set semaphore.existingSecret=semaphore-credentials
   ```

3. **Production (Full HA):**

   ```bash
   # Follow prerequisites in values-production.yaml
   helm install prod-semaphore codefuturist/semaphore -f values-production.yaml
   ```

## Customization

You can combine examples or override specific values:

```bash
# Start with production config and customize
helm install my-semaphore codefuturist/semaphore \
  -f values-production.yaml \
  --set controller.replicas=2 \
  --set resources.limits.memory=8Gi \
  --set ingress.hosts[0].host=semaphore.mycompany.com
```

## Database Options

### SQLite (Default)

- Best for: Single instance, development, testing
- Pros: No external dependencies, simple setup
- Cons: Not suitable for HA, limited concurrent users

```yaml
semaphore:
  database:
    dialect: sqlite
```

### PostgreSQL (Recommended for Production)

- Best for: Production, HA, multiple users
- Pros: Full ACID compliance, excellent concurrency, HA support
- Cons: Requires external database

```yaml
semaphore:
  database:
    dialect: postgres
    host: postgresql.database.svc.cluster.local
    port: 5432
    user: semaphore
    password: changeme
    name: semaphore
    sslMode: require
```

### MySQL

- Best for: Existing MySQL infrastructure
- Pros: Wide adoption, good performance
- Cons: Some edge case limitations

```yaml
semaphore:
  database:
    dialect: mysql
    host: mysql.database.svc.cluster.local
    port: 3306
    user: semaphore
    password: changeme
    name: semaphore
    sslMode: "true"
```

## Authentication Options

### Built-in (Default)

Simple username/password authentication:

```yaml
semaphore:
  admin:
    username: admin
    password: changeme
    email: admin@example.com
```

### LDAP

Enterprise authentication with Active Directory or OpenLDAP:

```yaml
semaphore:
  ldap:
    enabled: true
    server: ldap.example.com:636
    bindDn: cn=semaphore,ou=services,dc=example,dc=com
    searchDn: ou=users,dc=example,dc=com
    searchFilter: (&(objectClass=user)(uid=%s))
    needTls: true
```

### Two-Factor Authentication

Add TOTP 2FA for enhanced security:

```yaml
semaphore:
  totp:
    enabled: true
    allowRecovery: true
```

## Troubleshooting

### View logs

```bash
kubectl logs -n semaphore -l app.kubernetes.io/name=semaphore -f
```

### Test connectivity

```bash
kubectl run -it --rm test --image=busybox --restart=Never -- \
  wget -O- http://my-semaphore:3000
```

### Debug pod issues

```bash
kubectl describe pod -n semaphore -l app.kubernetes.io/name=semaphore
kubectl get events -n semaphore --sort-by='.lastTimestamp'
```

## Additional Resources

- [Semaphore Documentation](https://docs.semaphoreui.com)
- [Chart Values](../values.yaml)
- [Chart README](../README.md)
- [CI Test Configurations](../ci/)
