# Changelog

All notable changes to the Shlink Helm chart will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.1] - 2025-11-21

### Added
- Traefik-focused example values showing ingress annotations, TLS, and secret references for docker-compose migrations
- Documentation updates covering docker-compose env mappings and web client exposure requirements

### Fixed
- Default secret key names now match the generated Secret data, so automatic API/GeoLite keys are injected without manual overrides

### Removed
- `values.yaml.backup`, eliminating duplicate defaults that could confuse consumers


## [1.0.0] - 2024-11-21

### Added

#### Core Features
- Initial release of Shlink Helm chart
- Support for Shlink 4.2.4 (stable backend API)
- Shlink Web Client 4.2.1 (React-based admin interface)
- Separate deployment architecture for backend and web client
- PostgreSQL 16.2.0 via Bitnami subchart integration

#### Deployment & Scaling
- Support for both Deployment (default) and StatefulSet controllers
- Horizontal Pod Autoscaling (HPA) with CPU and memory targets
- Pod Disruption Budget (PDB) for high availability
- Configurable replica counts for backend and web client
- Pod anti-affinity and topology spread constraints
- Init containers and sidecar support

#### Database & Persistence
- Integrated Bitnami PostgreSQL subchart
- External database support (PostgreSQL/MySQL)
- Persistent volume claims for Shlink data storage
- GeoLite2 database storage for geolocation features
- Database connection configuration via environment variables
- Support for existing secrets for database credentials

#### Networking & Ingress
- Dual ingress support (separate for API and web client)
- Service configuration for backend (port 8080) and web client (port 80)
- Support for multiple ingress classes (nginx, traefik, etc.)
- TLS/SSL certificate management integration
- Path-based and host-based routing options
- CORS, rate limiting, and security header configurations

#### Security
- API key authentication support
- Kubernetes secrets for sensitive data (API keys, database passwords, GeoLite license)
- Pod security contexts with runAsNonRoot
- Container security contexts with dropped capabilities
- Network policies for ingress/egress control
- RBAC support with ServiceAccount, Role, and RoleBinding
- Configurable security settings (IP anonymization, logging)

#### Monitoring & Observability
- Prometheus ServiceMonitor integration
- PrometheusRule with alerting rules
- Custom metrics support
- Health probes (liveness, readiness, startup)
- Health check endpoint: `/rest/health`

#### Configuration & Customization
- Comprehensive values.yaml with 700+ lines of configuration options
- Environment variable injection for Shlink configuration
- Web client server pre-configuration
- Redis support for caching
- Custom environment variables support
- Custom volume mounts
- ConfigMap for web client `servers.json`
- Support for existing secrets

#### Examples & Documentation
- Four comprehensive example value files:
  - `values-minimal.yaml` - Basic configuration
  - `values-production.yaml` - Production HA setup
  - `values-with-persistence.yaml` - Storage focus
  - `values-reverse-proxy.yaml` - Advanced ingress
- Complete README.md with configuration reference
- QUICKSTART.md guide for common scenarios
- Detailed NOTES.txt post-install instructions
- ASCII art branding in NOTES.txt

#### Testing & CI
- CI test configurations for multiple scenarios
- Unit test templates
- Helm chart validation

### Technical Details

#### Shlink Backend Configuration
- `DB_DRIVER`, `DB_HOST`, `DB_PORT`, `DB_NAME`, `DB_USER`, `DB_PASSWORD` environment variables
- `DEFAULT_DOMAIN` and `DEFAULT_SCHEME` for URL generation
- `INITIAL_API_KEY` for automatic API key creation
- `GEOLITE_LICENSE_KEY` for MaxMind GeoLite2 integration
- Redis configuration via `REDIS_SERVERS`
- Security settings: `ANONYMIZE_REMOTE_ADDR`, `REDIRECTS_LOGGING`, `ORPHAN_VISITS_LOGGING`

#### Web Client Features
- Pre-configured server connections via `webClient.servers` array
- Nginx-based static file serving
- Separate scaling from backend
- ConfigMap-based `servers.json` injection
- Independent ingress configuration

#### Kubernetes Resources
- Deployment for stateless backend API
- Deployment for web client UI
- Service for backend (ClusterIP/NodePort/LoadBalancer)
- Service for web client (ClusterIP/NodePort/LoadBalancer)
- Ingress for backend with optional TLS
- Ingress for web client with optional TLS
- Secret for API keys and database credentials
- ConfigMap for web client configuration
- PersistentVolumeClaim for data storage (optional)
- ServiceMonitor for Prometheus (optional)
- PrometheusRule for alerts (optional)
- NetworkPolicy for security (optional)
- HorizontalPodAutoscaler (optional)
- PodDisruptionBudget (optional)

### Changed
- N/A (initial release)

### Deprecated
- N/A (initial release)

### Removed
- N/A (initial release)

### Fixed
- N/A (initial release)

### Security
- Default configuration uses secure contexts (runAsNonRoot, dropped capabilities)
- Secrets properly isolated for database credentials and API keys
- Network policies available for traffic restriction
- TLS ingress support for encrypted connections

## Future Releases

### Planned for 1.1.0
- StatefulSet template updates
- Additional CI test scenarios
- Enhanced monitoring dashboards
- Backup/restore documentation

### Planned for 1.2.0
- Support for Shlink 5.x (when released)
- Additional database backends (SQLite for development)
- Enhanced Redis configuration options
- Multi-region deployment support

---

## Release Notes Template

For future releases, use this template:

```markdown
## [X.Y.Z] - YYYY-MM-DD

### Added
- New feature descriptions

### Changed
- Modified behavior or updated dependencies

### Deprecated
- Features that will be removed in future versions

### Removed
- Features removed in this version

### Fixed
- Bug fixes

### Security
- Security improvements or vulnerability patches
```

[1.0.0]: https://github.com/codefuturist/helm-charts/releases/tag/shlink-1.0.0
