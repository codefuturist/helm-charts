# MeTube Examples

This directory contains example configurations for common deployment scenarios.

## Available Examples

### 1. values-minimal.yaml

Minimal configuration for quick development/testing:

- No persistence (ephemeral storage)
- Minimal resources
- Best for: Quick testing, development

```bash
helm install metube codefuturist/metube -f values-minimal.yaml
```

### 2. values-with-persistence.yaml

Basic configuration with persistent storage:

- Enables persistent volume for downloads
- Retains downloaded videos across restarts
- Configurable storage size and class
- Best for: Development, staging, production

```bash
helm install metube codefuturist/metube -f values-with-persistence.yaml
```

### 3. values-production.yaml

Production-ready configuration with all best practices:

- Persistent storage enabled
- Resource limits configured
- Ingress with TLS
- Network policies enabled
- Monitoring with ServiceMonitor
- Pod disruption budget
- Sequential download mode
- Best for: Production environments

```bash
helm install metube codefuturist/metube -f values-production.yaml
```

### 4. values-reverse-proxy.yaml

Configuration for reverse proxy environments:

- URL prefix configuration for subdirectory hosting
- Optimized ingress annotations
- Extended timeouts for long downloads
- Network policies configured
- Best for: Hosting under a subdirectory path

```bash
helm install metube codefuturist/metube -f values-reverse-proxy.yaml
```

## Combining Examples

You can combine multiple values files:

```bash
# Base config + custom overrides
helm install metube codefuturist/metube \
  -f values-production.yaml \
  -f my-custom-values.yaml
```

## Customizing Examples

All examples can be customized further using `--set`:

```bash
helm install metube codefuturist/metube \
  -f values-production.yaml \
  --set persistence.downloads.size=200Gi \
  --set resources.limits.memory=4Gi \
  --set metube.defaultFormat="bestvideo[height<=2160]+bestaudio/best"
```

## Common Customizations

### Change Download Directory Size

```bash
helm install metube codefuturist/metube \
  -f values-with-persistence.yaml \
  --set persistence.downloads.size=100Gi
```

### Configure yt-dlp Options

```bash
helm install metube codefuturist/metube \
  --set-file metube.ytdlOptions=my-ytdl-options.json
```

### Enable Cookie Authentication

```bash
# Create secret with cookies
kubectl create secret generic metube-cookies \
  --from-file=cookies.txt=./cookies.txt

# Install with cookie support
helm install metube codefuturist/metube \
  -f values-production.yaml \
  --set metube.existingCookieSecret=metube-cookies
```

## Security Notes

⚠️ **Important**:

- Ensure network policies allow egress for video downloads
- Monitor storage usage regularly to prevent disk full issues
- Use quality-controlled formats to manage storage consumption
- Review network policies for your specific security requirements

## Getting Help

- See [../docs/QUICKSTART.md](../docs/QUICKSTART.md) for detailed installation guide
- See [../README.md](../README.md) for all configuration options
- Report issues: <https://github.com/codefuturist/helm-charts/issues>
