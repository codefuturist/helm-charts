# pgAdmin Examples

This directory contains example configurations for common deployment scenarios.

## Available Examples

### 1. values-minimal.yaml
Minimal configuration for quick development/testing:
- Inline credentials (not recommended for production)
- No persistence (data lost on restart)
- Minimal resources
- Best for: Quick testing, development

```bash
helm install my-pgadmin codefuturist/pgadmin -f values-minimal.yaml
```

### 2. values-with-persistence.yaml
Basic configuration with persistent storage:
- Enables persistent volume for data retention
- Retains user preferences, saved queries, and sessions
- Configurable storage size and class
- Best for: Development, staging environments

```bash
helm install my-pgadmin codefuturist/pgadmin -f values-with-persistence.yaml
```

### 3. values-production.yaml
Production-ready configuration with all best practices:
- Uses Kubernetes secrets for credentials
- Persistent storage enabled
- Resource limits configured
- Ingress with TLS
- Network policies enabled
- Monitoring with ServiceMonitor
- Pod disruption budget
- Pod anti-affinity
- Best for: Production environments

Prerequisites:
```bash
# Create secret first
kubectl create secret generic pgadmin-credentials \
  --from-literal=email=admin@example.com \
  --from-literal=password=YourSecurePassword123
```

Install:
```bash
helm install my-pgadmin codefuturist/pgadmin -f values-production.yaml
```

### 4. values-multiple-servers.yaml
Configuration with pre-configured PostgreSQL servers:
- Multiple database connections defined
- Organized by environment groups
- Different SSL modes per environment
- Best for: Managing multiple databases

```bash
helm install my-pgadmin codefuturist/pgadmin -f values-multiple-servers.yaml
```

## Combining Examples

You can combine multiple values files:

```bash
# Base config + custom overrides
helm install my-pgadmin codefuturist/pgadmin \
  -f values-production.yaml \
  -f my-custom-values.yaml
```

## Customizing Examples

All examples can be customized further using `--set`:

```bash
helm install my-pgadmin codefuturist/pgadmin \
  -f values-production.yaml \
  --set persistence.size=10Gi \
  --set resources.limits.memory=2Gi
```

## Security Notes

⚠️ **Important**:
- Never commit sensitive passwords to version control
- Always use Kubernetes secrets for production credentials
- Change default passwords in all examples
- Review network policies for your specific security requirements

## Getting Help

- See [../docs/QUICKSTART.md](../docs/QUICKSTART.md) for detailed installation guide
- See [../README.md](../README.md) for all configuration options
- Report issues: https://github.com/codefuturist/helm-charts/issues
