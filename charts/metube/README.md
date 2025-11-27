# MeTube Helm Chart

A Helm chart for deploying MeTube - a self-hosted YouTube/video downloader with a web interface powered by yt-dlp.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.2.0+
- PV provisioner support in the underlying infrastructure (for persistence)

## Architecture

This chart follows the common chart library pattern used across this repository. It leverages the shared `common` chart for:

- Standardized labels and naming
- Image handling and pull secrets
- Resource presets
- Security contexts
- Capability detection (API versions)

## Installing the Chart

```bash
helm install metube ./charts/metube
```

## Uninstalling the Chart

```bash
helm delete metube
```

## Configuration

The following table lists the configurable parameters of the MeTube chart and their default values.

### Global Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `global.imageRegistry` | Global Docker image registry | `""` |
| `global.imagePullSecrets` | Global Docker registry secret names | `[]` |

### Image Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `image.registry` | MeTube image registry | `ghcr.io` |
| `image.repository` | MeTube image repository | `alexta69/metube` |
| `image.tag` | MeTube image tag | `latest` |
| `image.pullPolicy` | Image pull policy | `IfNotPresent` |
| `image.pullSecrets` | Specify docker-registry secret names | `[]` |

### MeTube Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `config.downloadMode` | Download mode (audio/video) | `video` |
| `config.maxConcurrentDownloads` | Maximum concurrent downloads | `5` |
| `config.outputTemplate` | yt-dlp output template | `%(title)s.%(ext)s` |
| `config.ytdlOptions` | Custom yt-dlp options (JSON) | `{}` |
| `config.urlPrefix` | URL prefix for reverse proxy | `""` |
| `config.deleteFileOnTrashed` | Delete file when trashed | `false` |

### Storage Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `persistence.enabled` | Enable persistence | `true` |
| `persistence.existingClaim` | Use existing PVC | `""` |
| `persistence.storageClass` | Storage class | `""` |
| `persistence.accessModes` | Access modes | `["ReadWriteOnce"]` |
| `persistence.size` | Storage size | `10Gi` |
| `storage.downloadDir` | Download directory path | `/downloads` |
| `storage.uid` | User ID | `1000` |
| `storage.gid` | Group ID | `1000` |

### Service Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `service.type` | Service type | `ClusterIP` |
| `service.ports.http` | HTTP port | `8081` |
| `service.nodePorts.http` | Node port (if applicable) | `""` |
| `service.clusterIP` | Specific cluster IP | `""` |
| `service.loadBalancerIP` | LoadBalancer IP | `""` |

### Ingress Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `ingress.enabled` | Enable ingress | `false` |
| `ingress.ingressClassName` | Ingress class name | `""` |
| `ingress.hostname` | Default hostname | `metube.local` |
| `ingress.path` | Default path | `/` |
| `ingress.pathType` | Path type | `ImplementationSpecific` |
| `ingress.tls` | Enable TLS | `false` |
| `ingress.selfSigned` | Create self-signed certificate | `false` |

### Security Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `podSecurityContext.enabled` | Enable pod security context | `true` |
| `podSecurityContext.fsGroup` | Group ID for volumes | `1000` |
| `containerSecurityContext.enabled` | Enable container security context | `true` |
| `containerSecurityContext.runAsUser` | User ID | `1000` |
| `containerSecurityContext.runAsNonRoot` | Run as non-root | `true` |

### Resource Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `resourcesPreset` | Resource preset | `small` |
| `resources.limits` | Resource limits | `{}` |
| `resources.requests` | Resource requests | `{}` |

## Examples

### Basic Installation

```bash
helm install metube ./charts/metube
```

### With Custom Storage Size

```bash
helm install metube ./charts/metube \
  --set persistence.size=50Gi
```

### With Ingress

```bash
helm install metube ./charts/metube \
  --set ingress.enabled=true \
  --set ingress.hostname=metube.example.com \
  --set ingress.tls=true
```

### Audio-Only Downloads

```bash
helm install metube ./charts/metube \
  --set config.downloadMode=audio \
  --set config.outputTemplate="%(artist)s - %(title)s.%(ext)s"
```

### With Cookies for Authentication

```yaml
# values-cookies.yaml
cookies:
  enabled: true
  content: |
    # Netscape HTTP Cookie File
    .youtube.com    TRUE    /   FALSE   0   CONSENT YES+
```

```bash
helm install metube ./charts/metube -f values-cookies.yaml
```

## Upgrade

```bash
helm upgrade metube ./charts/metube
```

## Troubleshooting

### Check Pod Status

```bash
kubectl get pods -l app.kubernetes.io/name=metube
kubectl logs -l app.kubernetes.io/name=metube
```

### Access Logs

```bash
kubectl logs deployment/metube -f
```

### Check PVC

```bash
kubectl get pvc
kubectl describe pvc metube
```

## Links

- [MeTube GitHub](https://github.com/alexta69/metube)
- [yt-dlp Documentation](https://github.com/yt-dlp/yt-dlp)
- [Chart Repository](https://github.com/codefuturist/helm-charts)
