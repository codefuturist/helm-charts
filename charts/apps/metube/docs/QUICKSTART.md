# MeTube Quick Start Guide

This guide will help you get started with MeTube quickly.

## Prerequisites

- Kubernetes cluster (1.21+)
- Helm 3.x
- kubectl configured
- Storage provisioner for persistent volumes (recommended)

## Installation Methods

### 1. Minimal Installation (Development)

Quick setup with default settings using ephemeral storage:

```bash
helm install metube codefuturist/metube
```

Access MeTube:

```bash
kubectl port-forward svc/metube 8081:8081
# Open http://localhost:8081 in your browser
```

### 2. Production Installation with Persistence

Install with persistent storage to retain downloaded videos:

```bash
helm install metube codefuturist/metube \
  --set persistence.downloads.enabled=true \
  --set persistence.downloads.size=50Gi
```

### 3. Installation with Ingress

Expose MeTube via ingress controller:

```bash
helm install metube codefuturist/metube \
  --set persistence.downloads.enabled=true \
  --set persistence.downloads.size=50Gi \
  --set ingress.enabled=true \
  --set ingress.className=nginx \
  --set ingress.hosts[0].host=metube.example.com \
  --set ingress.hosts[0].paths[0].path=/ \
  --set ingress.hosts[0].paths[0].pathType=Prefix
```

### 4. Installation with Custom Download Configuration

Create a values file with custom yt-dlp options:

```yaml
# my-values.yaml
metube:
  # Download behavior
  downloadMode: sequential

  # Output template
  outputTemplate: "%(title)s.%(ext)s"

  # Default format selection
  defaultFormat: "bestvideo+bestaudio/best"

  # yt-dlp options
  ytdlOptions: |
    {
      "writesubtitles": true,
      "writeautomaticsub": true,
      "subtitleslangs": ["en"],
      "postprocessors": [{
        "key": "FFmpegEmbedSubtitle"
      }]
    }

persistence:
  downloads:
    enabled: true
    size: 100Gi
```

Install with the values file:

```bash
helm install metube codefuturist/metube -f my-values.yaml
```

### 5. Installation with Cookie Authentication

For downloading restricted content that requires authentication:

```bash
# Create a secret with cookies.txt file
kubectl create secret generic metube-cookies \
  --from-file=cookies.txt=./cookies.txt

# Install with cookie support
helm install metube codefuturist/metube \
  --set metube.cookiesFromBrowser="" \
  --set metube.existingCookieSecret=metube-cookies \
  --set persistence.downloads.enabled=true \
  --set persistence.downloads.size=50Gi
```

## First Video Download

Once MeTube is running:

1. **Access the web interface** (via port-forward or ingress)
2. **Paste a video URL** into the input field (e.g., a YouTube URL)
3. **Select download options**:
   - Quality/format (auto-selected based on `defaultFormat`)
   - Audio-only option if desired
4. **Click "Download"** button
5. **Monitor progress** in the download queue
6. **Access files** in the downloads directory

Example URLs to test:

- Any YouTube video URL
- Vimeo, Dailymotion, and 1000+ other supported sites

## Storage Considerations

### Default Storage

The chart provisions 10Gi of storage by default for downloads:

```yaml
persistence:
  downloads:
    enabled: true
    size: 10Gi
```

### Sizing Recommendations

Plan storage based on your usage:

- **Light use** (occasional downloads): 10-25Gi
- **Medium use** (regular downloads): 50-100Gi
- **Heavy use** (frequent, high-quality downloads): 200Gi+

### Storage Classes

Use fast storage for better download performance:

```yaml
persistence:
  downloads:
    storageClassName: "fast-ssd"
    size: 100Gi
```

### Temp Storage

Configure temp directory for download processing:

```yaml
persistence:
  temp:
    enabled: true
    size: 20Gi
```

## Common Configuration Scenarios

### High-Quality Video Downloads

```yaml
metube:
  defaultFormat: "bestvideo[height<=2160]+bestaudio/best"
  outputTemplate: "%(title)s [%(id)s].%(ext)s"
  ytdlOptions: |
    {
      "merge_output_format": "mkv",
      "postprocessors": [{
        "key": "FFmpegVideoConvertor",
        "preferedformat": "mp4"
      }]
    }

persistence:
  downloads:
    size: 200Gi
```

### Audio-Only Downloads

```yaml
metube:
  defaultFormat: "bestaudio/best"
  outputTemplate: "%(title)s - %(artist)s.%(ext)s"
  ytdlOptions: |
    {
      "postprocessors": [{
        "key": "FFmpegExtractAudio",
        "preferredcodec": "mp3",
        "preferredquality": "320"
      }]
    }
```

### Reverse Proxy Configuration

Run MeTube under a subdirectory path:

```yaml
metube:
  urlPrefix: "/metube"

ingress:
  enabled: true
  className: nginx
  hosts:
    - host: media.example.com
      paths:
        - path: /metube
          pathType: Prefix
```

### Enable Monitoring

With Prometheus Operator:

```yaml
monitoring:
  serviceMonitor:
    enabled: true
    interval: 30s
  prometheusRule:
    enabled: true
```

### High Availability Setup

```yaml
controller:
  replicas: 2

pdb:
  enabled: true
  minAvailable: 1

hpa:
  enabled: true
  minReplicas: 2
  maxReplicas: 5
  targetCPU: 80

persistence:
  downloads:
    accessMode: ReadWriteMany # Requires NFS or similar
    size: 100Gi
```

## Upgrading

### Upgrade to New Version

```bash
helm repo update
helm upgrade metube codefuturist/metube
```

### Upgrade with New Values

```bash
helm upgrade metube codefuturist/metube -f my-values.yaml
```

## Troubleshooting

### Check Pod Status

```bash
kubectl get pods -l app.kubernetes.io/name=metube
kubectl describe pod <pod-name>
kubectl logs <pod-name>
```

### Test Connectivity

```bash
helm test metube
```

### Access Issues

If you can't access MeTube:

1. Check service:

   ```bash
   kubectl get svc -l app.kubernetes.io/name=metube
   ```

2. Port forward directly:

   ```bash
   kubectl port-forward pod/<pod-name> 8081:8081
   ```

3. Check ingress (if enabled):
   ```bash
   kubectl get ingress
   kubectl describe ingress metube
   ```

### Download Issues

Check logs for errors:

```bash
kubectl logs -l app.kubernetes.io/name=metube --tail=100 -f
```

Common issues:

- **Storage full**: Check PVC usage
- **Network restrictions**: Verify network policies allow egress
- **Format errors**: Adjust `defaultFormat` or `ytdlOptions`

### Storage Issues

Check PVC status:

```bash
kubectl get pvc
kubectl describe pvc metube-downloads
```

Monitor storage usage:

```bash
kubectl exec -it <pod-name> -- df -h /downloads
```

## Uninstalling

Remove the Helm release:

```bash
helm uninstall metube
```

If persistence was enabled, manually delete the PVC:

```bash
kubectl delete pvc metube-downloads
```

## Next Steps

- Review [README.md](../README.md) for all configuration options
- Check [examples/](../examples/) for advanced configurations
- Explore [TESTING.md](TESTING.md) for validation and troubleshooting
- Review security best practices for production deployments

## Getting Help

- [GitHub Issues](https://github.com/codefuturist/helm-charts/issues)
- [MeTube Documentation](https://github.com/alexta69/metube)
- [yt-dlp Documentation](https://github.com/yt-dlp/yt-dlp)
