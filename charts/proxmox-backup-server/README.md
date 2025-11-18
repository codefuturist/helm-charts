# Proxmox Backup Server Helm Chart

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square)
![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)
![AppVersion: 4.0.12](https://img.shields.io/badge/AppVersion-4.0.12-informational?style=flat-square)

## Introduction

This chart bootstraps a [Proxmox Backup Server](https://pbs.proxmox.com/) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

Proxmox Backup Server is an enterprise backup solution for backing up and restoring VMs, containers, and physical hosts. This containerized version is based on the [ayufan/pve-backup-server-dockerfiles](https://github.com/ayufan/pve-backup-server-dockerfiles) project.

## Features

- **Easy Installation**: Get started with minimal configuration
- **Security First**: Configurable security contexts, network policies, and RBAC
- **Production Ready**: Persistent storage for config, logs, and state
- **Flexible Storage**: Support for multiple backup data volumes
- **SMART Support**: Optional device access for SMART monitoring
- **Timezone Configuration**: Set server timezone for accurate logging
- **Ingress Support**: Expose via any ingress controller with TLS
- **Monitoring Ready**: ServiceMonitor and PrometheusRule for Prometheus Operator
- **High Availability**: Pod disruption budgets and anti-affinity
- **Flexible Deployment**: Deployment or StatefulSet controller options
- **Extensibility**: Extra containers, init containers, volumes, and environment variables

## Quick Start

To deploy Proxmox Backup Server using this Helm chart:

```console
$ helm repo add codefuturist https://codefuturist.github.io/helm-charts
$ helm repo update
$ helm install my-pbs codefuturist/proxmox-backup-server \
  --set pbs.password=ChangeMe123
```

After installation, access the web interface at `https://<service-ip>:8007/` and login with:
- Username: `admin@pbs`
- Password: `pbspbs` (or your custom password)

**IMPORTANT**: Change the default password after first login!

## Prerequisites

- Kubernetes 1.21+
- Helm 3.0+
- PV provisioner support in the underlying infrastructure (if persistence is enabled)

## Installing the Chart

Add the repository:

```console
$ helm repo add codefuturist https://codefuturist.github.io/helm-charts
$ helm repo update
```

Install the chart:

```console
$ helm install my-pbs codefuturist/proxmox-backup-server
```

## Uninstalling the Chart

To uninstall/delete the `my-pbs` deployment:

```console
$ helm delete my-pbs
```

## Configuration

The following table lists the configurable parameters of the Proxmox Backup Server chart and their default values.

### Global Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `namespaceOverride` | Override the namespace | `.Release.Namespace` |
| `nameOverride` | Override the name | `""` |
| `fullnameOverride` | Override the full name | `""` |

### Image Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `image.repository` | PBS image repository | `ayufan/proxmox-backup-server` |
| `image.tag` | PBS image tag (`latest` for stable, `beta` for pre-release) | `latest` |
| `image.pullPolicy` | Image pull policy | `IfNotPresent` |

**Note**: Use `image.tag: beta` for the latest pre-release version. See [available tags](https://hub.docker.com/r/ayufan/proxmox-backup-server/tags).

### PBS Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `pbs.username` | PBS admin username | `admin@pbs` |
| `pbs.password` | PBS admin password | `pbspbs` |
| `pbs.timezone` | Timezone | `UTC` |
| `pbs.smartAccess.enabled` | Enable SMART device access | `false` |
| `pbs.smartAccess.devices` | Device paths to expose | `[]` |

### Persistence

| Parameter | Description | Default |
|-----------|-------------|---------|
| `persistence.enabled` | Enable persistence | `true` |
| `persistence.etc.enabled` | Persist /etc/proxmox-backup | `true` |
| `persistence.etc.size` | Size for etc volume | `1Gi` |
| `persistence.logs.enabled` | Persist /var/log/proxmox-backup | `true` |
| `persistence.logs.size` | Size for logs volume | `5Gi` |
| `persistence.lib.enabled` | Persist /var/lib/proxmox-backup | `true` |
| `persistence.lib.size` | Size for lib volume | `10Gi` |

See [values.yaml](./values.yaml) for the complete list of parameters.

## Examples

### Basic Installation

```yaml
pbs:
  password: MySecurePassword123
  timezone: "America/New_York"

persistence:
  enabled: true
```

### With SMART Monitoring

```yaml
pbs:
  password: MySecurePassword123
  smartAccess:
    enabled: true
    devices:
      - /dev/sda
      - /dev/sdb
```

### With Additional Backup Volumes

```yaml
pbs:
  password: MySecurePassword123
  backupVolumes:
    - name: backups-primary
      mountPath: /backups
      size: 500Gi
```

## Notes

- Default credentials are `admin@pbs` / `pbspbs` - **change after first login**
- The container requires `/run` mounted as tmpfs for authentication (automatically configured)
- Some features are not available in containerized version:
  - **ZFS**: Not installed in container
  - **Shell Access**: Not available due to PVE authentication and ephemeral container architecture
  - **PAM Authentication**: Containers are ephemeral, `/etc/` configs not persisted by default
- For production use, enable persistent storage for etc, logs, and lib directories
- Uses self-signed certificates by default - accept certificate warning in browser

### Getting SSL Certificate Fingerprint

If you need to integrate with Proxmox VE, you may need the PBS certificate fingerprint:

```bash
# For Kubernetes deployment
kubectl exec -n <namespace> <pod-name> -- proxmox-backup-manager cert info | grep Fingerprint

# Example output:
# Fingerprint (sha256): xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx
```

Follow the [Proxmox VE Integration tutorial](https://pbs.proxmox.com/docs/pve-integration.html) for complete setup.

## Troubleshooting

### Authentication Failures

If you experience authentication failures with `admin@pbs`:

1. **Verify `/run` is mounted as tmpfs** - This is required for PBS 2.1.x and later (automatically configured in this chart)
   ```bash
   kubectl exec -n <namespace> <pod-name> -- mount | grep /run
   # Should show: tmpfs on /run type tmpfs
   ```

2. **Check pod logs for errors**
   ```bash
   kubectl logs -n <namespace> <pod-name> -f
   ```

3. **Verify persistent volumes are mounted**
   ```bash
   kubectl get pvc -n <namespace>
   # All PVCs should be "Bound"
   ```

### Service Not Accessible

If you cannot access the web interface:

1. **Check pod status**
   ```bash
   kubectl get pods -n <namespace> -l app.kubernetes.io/name=proxmox-backup-server
   ```

2. **Check service**
   ```bash
   kubectl get svc -n <namespace>
   ```

3. **Port-forward for testing**
   ```bash
   kubectl port-forward -n <namespace> svc/<release-name>-proxmox-backup-server 8007:8007
   # Then visit https://localhost:8007/
   ```

### SMART Device Access Not Working

If SMART monitoring doesn't show device information:

1. Ensure `pbs.smartAccess.enabled: true`
2. Verify devices are listed in `pbs.smartAccess.devices`
3. Check pod has SYS_RAWIO capability:
   ```bash
   kubectl get pod <pod-name> -n <namespace> -o jsonpath='{.spec.containers[0].securityContext.capabilities}'
   ```

## License

Apache 2.0

## Links

- [Proxmox Backup Server Official Docs](https://pbs.proxmox.com/docs/)
- [Container Project](https://github.com/ayufan/pve-backup-server-dockerfiles)
- [Docker Hub](https://hub.docker.com/r/ayufan/proxmox-backup-server)
