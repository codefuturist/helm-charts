# netboot.xyz Helm Chart

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/codefuturist)](https://artifacthub.io/packages/search?repo=codefuturist)

[netboot.xyz](https://netboot.xyz) is a network boot environment that allows PXE booting various operating system installers or utilities from a central location, making it easy to boot and install operating systems over the network.

## TL;DR

```bash
helm repo add codefuturist https://codefuturist.github.io/helm-charts
helm install netbootxyz codefuturist/netbootxyz
```

## Introduction

This chart bootstraps a [netboot.xyz](https://github.com/netbootxyz/netboot.xyz) deployment on a Kubernetes cluster using the Helm package manager.

## Prerequisites

- Kubernetes 1.27+
- Helm 3.10+
- PV provisioner support in the underlying infrastructure
- An external DHCP server that can be configured to point PXE clients to the TFTP server

## Installing the Chart

To install the chart with the release name `netbootxyz`:

```bash
helm install netbootxyz codefuturist/netbootxyz
```

The command deploys netboot.xyz on the Kubernetes cluster with default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `netbootxyz` deployment:

```bash
helm uninstall netbootxyz
```

## Architecture

netboot.xyz exposes three main services:

| Service | Port | Protocol | Description |
|---------|------|----------|-------------|
| Web App | 3000 | TCP | Web-based configuration interface |
| Assets | 80 | TCP | NGINX server for hosting boot assets |
| TFTP | 69 | UDP | TFTP server for PXE boot files |

### Network Considerations

⚠️ **TFTP on UDP port 69** requires special handling in Kubernetes:

- **NodePort** (default): Exposes TFTP on a high port (30000-32767)
- **LoadBalancer**: Requires a load balancer that supports UDP
- **hostPort**: Exposes port 69 directly on the node (recommended for bare-metal)

## DHCP Server Configuration

netboot.xyz **requires an external DHCP server** configured to direct PXE clients to the TFTP server. Below are configuration examples for common DHCP servers.

### dnsmasq

```conf
# Enable TFTP
enable-tftp
tftp-root=/var/lib/tftpboot

# Point PXE clients to netboot.xyz
dhcp-boot=netboot.xyz.kpxe,<NETBOOTXYZ_SERVER_IP>

# For UEFI systems
dhcp-match=set:efi-x86_64,option:client-arch,7
dhcp-boot=tag:efi-x86_64,netboot.xyz.efi,<NETBOOTXYZ_SERVER_IP>
```

### ISC DHCP Server

```conf
# Global settings
next-server <NETBOOTXYZ_SERVER_IP>;
filename "netboot.xyz.kpxe";

# UEFI support
class "pxeclient-uefi-x64" {
  match if substring (option vendor-class-identifier, 0, 9) = "PXEClient"
           and option client-system = 00:07;
  filename "netboot.xyz.efi";
}

class "pxeclient-uefi-x64-http" {
  match if substring (option vendor-class-identifier, 0, 9) = "PXEClient"
           and option client-system = 00:10;
  filename "netboot.xyz.efi";
}
```

### pfSense / OPNsense

1. Navigate to **Services → DHCP Server → [Your Interface]**
2. Scroll to **Network Booting**
3. Configure:
   - **Enable**: ✓
   - **Next Server**: `<NETBOOTXYZ_SERVER_IP>`
   - **Default BIOS file name**: `netboot.xyz.kpxe`
   - **UEFI 64-bit file name**: `netboot.xyz.efi`

### MikroTik RouterOS

```routeros
/ip dhcp-server network
set [find] next-server=<NETBOOTXYZ_SERVER_IP> boot-file-name=netboot.xyz.kpxe
```

### Windows DHCP Server

1. Open **DHCP Manager**
2. Right-click your scope → **Configure Options**
3. Configure:
   - **066 Boot Server Host Name**: `<NETBOOTXYZ_SERVER_IP>`
   - **067 Bootfile Name**: `netboot.xyz.kpxe`

## Parameters

### Global parameters

| Name                      | Description                                     | Default |
|---------------------------|-------------------------------------------------|---------|
| `global.imageRegistry`    | Global Docker image registry                    | `""`    |
| `global.imagePullSecrets` | Global Docker registry secret names             | `[]`    |
| `global.storageClass`     | Global StorageClass for PVCs                    | `""`    |

### Common parameters

| Name                     | Description                                      | Default |
|--------------------------|--------------------------------------------------|---------|
| `nameOverride`           | Override the chart name                          | `""`    |
| `fullnameOverride`       | Override the full resource names                 | `""`    |
| `namespaceOverride`      | Override the namespace                           | `""`    |
| `commonLabels`           | Labels to add to all deployed objects            | `{}`    |
| `commonAnnotations`      | Annotations to add to all deployed objects       | `{}`    |
| `extraDeploy`            | Extra objects to deploy (evaluated as template)  | `[]`    |

### Image parameters

| Name               | Description                              | Default                     |
|--------------------|------------------------------------------|-----------------------------|
| `image.registry`   | Image registry                           | `ghcr.io`                   |
| `image.repository` | Image repository                         | `netbootxyz/netbootxyz`     |
| `image.tag`        | Image tag (defaults to appVersion)       | `""`                        |
| `image.pullPolicy` | Image pull policy                        | `IfNotPresent`              |
| `image.pullSecrets`| Image pull secrets                       | `[]`                        |

### Configuration parameters

| Name                  | Description                                    | Default |
|-----------------------|------------------------------------------------|---------|
| `config.menuVersion`  | Specific netboot.xyz menu version              | `""`    |
| `config.webAppPort`   | Web configuration interface port               | `3000`  |
| `config.nginxPort`    | NGINX asset server port                        | `80`    |
| `config.tftpdOpts`    | Additional TFTP daemon options                 | `""`    |
| `config.puid`         | User ID for file permissions                   | `1000`  |
| `config.pgid`         | Group ID for file permissions                  | `1000`  |

### Deployment parameters

| Name                         | Description                              | Default     |
|------------------------------|------------------------------------------|-------------|
| `replicaCount`               | Number of replicas (should be 1 for TFTP)| `1`         |
| `revisionHistoryLimit`       | Number of old history to retain          | `10`        |
| `updateStrategy.type`        | Deployment strategy type                 | `Recreate`  |
| `hostNetwork`                | Use host network (for bare-metal TFTP)   | `false`     |
| `hostAliases`                | Pod host aliases                         | `[]`        |
| `dnsPolicy`                  | DNS policy for the pod                   | `""`        |
| `dnsConfig`                  | Custom DNS configuration                 | `{}`        |
| `command`                    | Override container command               | `[]`        |
| `args`                       | Override container args                  | `[]`        |
| `diagnosticMode.enabled`     | Enable diagnostic mode (sleep infinity)  | `false`     |
| `podLabels`                  | Extra labels for pods                    | `{}`        |
| `podAnnotations`             | Extra annotations for pods               | `{}`        |
| `affinity`                   | Affinity for pod assignment              | `{}`        |
| `nodeSelector`               | Node labels for pod assignment           | `{}`        |
| `tolerations`                | Tolerations for pod assignment           | `[]`        |
| `priorityClassName`          | Priority class name                      | `""`        |

### Security Context parameters

| Name                                          | Description                           | Default          |
|-----------------------------------------------|---------------------------------------|------------------|
| `podSecurityContext.enabled`                  | Enable pod security context           | `true`           |
| `podSecurityContext.fsGroup`                  | Group ID for the pod                  | `1000`           |
| `containerSecurityContext.enabled`            | Enable container security context     | `true`           |
| `containerSecurityContext.allowPrivilegeEscalation` | Allow privilege escalation      | `false`          |
| `containerSecurityContext.capabilities.add`   | Capabilities to add                   | `[NET_BIND_SERVICE]` |

### Resource parameters

| Name              | Description                                    | Default   |
|-------------------|------------------------------------------------|-----------|
| `resourcesPreset` | Resource preset (nano, micro, small, etc.)     | `small`   |
| `resources`       | Custom resource requests/limits                | `{}`      |

### HTTP Service parameters

| Name                      | Description                              | Default      |
|---------------------------|------------------------------------------|--------------|
| `service.type`            | HTTP service type                        | `ClusterIP`  |
| `service.ports.webapp`    | Webapp service port                      | `3000`       |
| `service.ports.assets`    | Assets service port                      | `80`         |
| `service.nodePorts.webapp`| NodePort for webapp (if applicable)      | `""`         |
| `service.nodePorts.assets`| NodePort for assets (if applicable)      | `""`         |

### TFTP Service parameters

| Name                              | Description                              | Default   |
|-----------------------------------|------------------------------------------|-----------|
| `tftp.service.enabled`            | Enable TFTP service                      | `true`    |
| `tftp.service.type`               | TFTP service type                        | `NodePort`|
| `tftp.service.port`               | TFTP service port                        | `69`      |
| `tftp.service.nodePort`           | TFTP NodePort (auto-assigned if empty)   | `""`      |
| `tftp.service.externalTrafficPolicy` | External traffic policy               | `Local`   |
| `tftp.hostPort.enabled`           | Enable hostPort for TFTP                 | `false`   |
| `tftp.hostPort.port`              | Host port for TFTP                       | `69`      |

### Ingress parameters

| Name                      | Description                              | Default         |
|---------------------------|------------------------------------------|-----------------|
| `ingress.enabled`         | Enable ingress for webapp                | `false`         |
| `ingress.ingressClassName`| Ingress class name                       | `""`            |
| `ingress.hostname`        | Default hostname                         | `netboot.local` |
| `ingress.path`            | Default path                             | `/`             |
| `ingress.pathType`        | Ingress path type                        | `Prefix`        |
| `ingress.tls`             | Enable TLS                               | `false`         |
| `ingress.annotations`     | Additional annotations                   | `{}`            |

### Persistence parameters

| Name                               | Description                            | Default          |
|------------------------------------|----------------------------------------|------------------|
| `persistence.config.enabled`       | Enable config persistence              | `true`           |
| `persistence.config.size`          | Config PVC size                        | `1Gi`            |
| `persistence.config.storageClass`  | Config storage class                   | `""`             |
| `persistence.config.existingClaim` | Use existing PVC for config            | `""`             |
| `persistence.assets.enabled`       | Enable assets persistence              | `false`          |
| `persistence.assets.size`          | Assets PVC size                        | `50Gi`           |
| `persistence.assets.storageClass`  | Assets storage class                   | `""`             |
| `persistence.assets.existingClaim` | Use existing PVC for assets            | `""`             |

### ServiceAccount parameters

| Name                         | Description                              | Default |
|------------------------------|------------------------------------------|---------|
| `serviceAccount.create`      | Create ServiceAccount                    | `true`  |
| `serviceAccount.name`        | ServiceAccount name                      | `""`    |
| `serviceAccount.annotations` | ServiceAccount annotations               | `{}`    |

### NetworkPolicy parameters

| Name                              | Description                              | Default |
|-----------------------------------|------------------------------------------|---------|
| `networkPolicy.enabled`           | Enable NetworkPolicy                     | `false` |
| `networkPolicy.allowExternal`     | Allow external connections               | `true`  |
| `networkPolicy.allowExternalEgress` | Allow all external egress              | `true`  |
| `networkPolicy.extraIngress`      | Additional ingress rules                 | `[]`    |
| `networkPolicy.extraEgress`       | Additional egress rules                  | `[]`    |

### PodDisruptionBudget parameters

| Name                | Description                              | Default |
|---------------------|------------------------------------------|---------|
| `pdb.create`        | Create PodDisruptionBudget               | `false` |
| `pdb.minAvailable`  | Minimum available pods                   | `""`    |
| `pdb.maxUnavailable`| Maximum unavailable pods                 | `1`     |

## Configuration Examples

### Basic Installation

```yaml
# values.yaml
persistence:
  config:
    enabled: true
    size: 1Gi

tftp:
  service:
    type: NodePort
```

### With Ingress and TLS

```yaml
# values.yaml
ingress:
  enabled: true
  ingressClassName: nginx
  hostname: netboot.example.com
  tls: true
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt-prod

persistence:
  config:
    enabled: true
```

### Bare-Metal with hostPort

```yaml
# values.yaml
# Use hostPort for direct port 69 access
tftp:
  hostPort:
    enabled: true
    port: 69

# Ensure pod runs on a specific node
nodeSelector:
  kubernetes.io/hostname: pxe-server-node

persistence:
  config:
    enabled: true
```

### With Asset Mirroring

```yaml
# values.yaml
persistence:
  config:
    enabled: true
  assets:
    enabled: true
    size: 100Gi
    storageClass: fast-storage
```

### MetalLB LoadBalancer

```yaml
# values.yaml
service:
  type: LoadBalancer
  loadBalancerIP: 192.168.1.100
  annotations:
    metallb.universe.tf/loadBalancerIPs: 192.168.1.100

tftp:
  service:
    type: LoadBalancer
    loadBalancerIP: 192.168.1.100
    annotations:
      metallb.universe.tf/loadBalancerIPs: 192.168.1.100
```

## Troubleshooting

### TFTP Connection Issues

1. Verify the TFTP service is running:
   ```bash
   kubectl get svc -l app.kubernetes.io/name=netbootxyz
   ```

2. Check if the pod can bind to the TFTP port:
   ```bash
   kubectl logs -l app.kubernetes.io/name=netbootxyz
   ```

3. Test TFTP connectivity from a client:
   ```bash
   tftp <server-ip> -c get netboot.xyz.kpxe
   ```

### PXE Client Not Booting

1. Verify DHCP options are correctly configured
2. Check that the TFTP server IP is reachable from the client network
3. Ensure firewall rules allow UDP port 69
4. For UEFI systems, verify the correct boot file is configured

### Web Interface Not Accessible

1. Check pod status:
   ```bash
   kubectl get pods -l app.kubernetes.io/name=netbootxyz
   ```

2. Port-forward to test locally:
   ```bash
   kubectl port-forward svc/netbootxyz 3000:3000
   ```

## License

This chart is licensed under the MIT License.

## Links

- [netboot.xyz Documentation](https://netboot.xyz/docs/)
- [netboot.xyz GitHub](https://github.com/netbootxyz/netboot.xyz)
- [Docker Image](https://github.com/netbootxyz/docker-netbootxyz)
