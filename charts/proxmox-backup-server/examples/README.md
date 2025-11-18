# Proxmox Backup Server - Configuration Examples

This directory contains example configurations for various PBS deployment scenarios.

## Available Examples

### 1. Production Deployment (`production.yaml`)

A complete production-ready configuration with:
- Persistence enabled for all volumes
- Monitoring with Prometheus Operator
- Network policies for security
- Resource limits and health probes
- Ingress with TLS
- Backup data volume configuration

**Use this as a starting point for production deployments.**

```bash
helm install pbs codefuturist/proxmox-backup-server \
  -f examples/production.yaml \
  --set pbs.password=YourSecurePassword
```

### 2. Beta Version (`beta-version.yaml`)

Configuration for testing pre-release versions:
- Uses `image.tag: beta`
- Reduced resources for testing
- Basic persistence setup

**Only use in non-production environments.**

```bash
helm install pbs-beta codefuturist/proxmox-backup-server \
  -f examples/beta-version.yaml
```

### 3. Existing Volumes (`existing-volumes.yaml`)

Example of using pre-existing PVCs:
- Useful for migrations
- Preserves data across releases
- References existing storage

**Note**: The PVCs must already exist before installation.

```bash
# Create your PVCs first, then:
helm install pbs codefuturist/proxmox-backup-server \
  -f examples/existing-volumes.yaml
```

## Customizing Examples

All examples can be customized by overriding values:

```bash
# Override specific values
helm install pbs codefuturist/proxmox-backup-server \
  -f examples/production.yaml \
  --set pbs.timezone="America/Los_Angeles" \
  --set persistence.lib.size=100Gi

# Use multiple value files
helm install pbs codefuturist/proxmox-backup-server \
  -f examples/production.yaml \
  -f my-custom-values.yaml
```

## Testing Examples

Validate any example before installation:

```bash
# Render templates without installing
helm template pbs codefuturist/proxmox-backup-server \
  -f examples/production.yaml

# Or install in dry-run mode
helm install pbs codefuturist/proxmox-backup-server \
  -f examples/production.yaml \
  --dry-run --debug
```

## Important Notes

1. **Always change the default password** after installation
2. **Backup your PVCs** regularly - they contain all PBS data
3. **Monitor disk usage** - backup data can grow quickly
4. **Use appropriate storage classes** for your environment
5. **Test restores regularly** to ensure backups are working

## Getting Help

- Chart Documentation: [README.md](../README.md)
- PBS Official Docs: https://pbs.proxmox.com/docs/
- Container Project: https://github.com/ayufan/pve-backup-server-dockerfiles
- Issues: https://github.com/codefuturist/helm-charts/issues
