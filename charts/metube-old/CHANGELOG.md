# Changelog

All notable changes to the MeTube Helm chart will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-11-21

### Added
- Initial release of MeTube Helm chart
- Support for Deployment and StatefulSet controller types (Deployment is default)
- Comprehensive download directory management with 10Gi default persistent storage
- Full yt-dlp configuration support via `YTDL_OPTIONS` environment variable
- Cookie authentication support for downloading restricted content
- Configurable download modes: sequential, concurrent, and limited (with concurrency control)
- Custom download directory organization with regex-based exclusion
- Output template customization for filenames, chapters, and playlists
- Reverse proxy support with `URL_PREFIX` configuration
- HTTPS/TLS support with certificate mounting
- Pod security contexts with non-root user (UID/GID 1000)
- Comprehensive health probes (liveness, readiness, startup)
- Network policies for secure ingress and egress control
- ServiceMonitor and PrometheusRule for Prometheus Operator integration
- RBAC with ServiceAccount for secure pod execution
- Horizontal Pod Autoscaler (HPA) support
- PodDisruptionBudget (PDB) for high availability
- Diagnostic mode for troubleshooting
- robots.txt configuration support
- Extensive configuration examples in `examples/` directory
- Comprehensive CI test matrix with 11 test scenarios
- Helm unittest test suite with >90% coverage

### Configuration Highlights
- Default storage: 10Gi persistent volume (recommended 50-100Gi for production)
- Port: 8081 (MeTube standard port)
- Image: ghcr.io/alexta69/metube:latest
- Security: Runs as non-root user with dropped capabilities
- Resources: 100m CPU / 256Mi memory requests, 2000m CPU / 1Gi memory limits
- Controller: Deployment with Recreate strategy (default)

### Documentation
- Comprehensive README with all configuration options
- Quick start guide (docs/QUICKSTART.md)
- Testing guide (docs/TESTING.md)
- Multiple example configurations:
  - Minimal deployment
  - Production setup with ingress
  - Reverse proxy configuration
  - Persistence-enabled setup
  - Multi-replica configuration

---

## Release Notes

This chart provides a production-ready deployment of MeTube, a web-based GUI for yt-dlp (youtube-dl fork).
MeTube supports downloading videos from YouTube and 1000+ other websites with playlist support,
custom directory organization, and flexible output formatting.

Key features:
- 🎬 Support for 1000+ video sites via yt-dlp
- 📁 Organized downloads with custom directories
- 🎨 Modern web interface with light/dark themes
- 🔐 Cookie support for authenticated downloads
- 📊 Playlist and channel download support
- ⚡ Configurable concurrent downloads
- 🐳 Kubernetes-native with modern API versions
- 🔒 Security-hardened with least-privilege principles

For more information, visit:
- Chart repository: https://github.com/codefuturist/helm-charts
- MeTube project: https://github.com/alexta69/metube
- yt-dlp documentation: https://github.com/yt-dlp/yt-dlp
