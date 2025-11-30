# Helm Charts

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Release Charts](https://github.com/codefuturist/helm-charts/actions/workflows/release.yaml/badge.svg)](https://github.com/codefuturist/helm-charts/actions/workflows/release.yaml)

A collection of Helm charts for Kubernetes deployments, maintained by [@codefuturist](https://github.com/codefuturist).

## Overview

This repository contains production-ready Helm charts for various applications and services. Each chart follows Kubernetes and Helm best practices, providing flexible configuration options and comprehensive documentation.

## Available Charts

### Application Charts (`charts/apps/`)

| Chart | Description | Version |
|-------|-------------|---------|
| [bitwarden-eso-provider](charts/apps/bitwarden-eso-provider/) | Bitwarden webhook provider for External Secrets Operator | 1.0.2 |
| [compass-web](charts/apps/compass-web/) | MongoDB Compass Web - database management tool | 1.0.1 |
| [homarr](charts/apps/homarr/) | Simple, powerful dashboard for your server | 1.0.2 |
| [home-assistant](charts/apps/home-assistant/) | Open source home automation platform | 1.0.1 |
| [mailrise](charts/apps/mailrise/) | SMTP gateway for Apprise notifications | 1.0.1 |
| [mealie](charts/apps/mealie/) | Self-hosted recipe manager and meal planner | 0.1.1 |
| [metube](charts/apps/metube/) | YouTube downloader with web interface (yt-dlp) | 1.0.0 |
| [netbootxyz](charts/apps/netbootxyz/) | Network boot environment for PXE booting | 0.1.0 |
| [paperless-ngx](charts/apps/paperless-ngx/) | Document management system with OCR | 0.1.0 |
| [pgadmin](charts/apps/pgadmin/) | PostgreSQL management and administration tool | 1.0.2 |
| [pihole](charts/apps/pihole/pihole/) | Pi-hole DNS ad blocker | 0.2.0 |
| [proxmox-backup-server](charts/apps/proxmox-backup-server/) | Enterprise backup solution for VMs | 1.0.1 |
| [redisinsight](charts/apps/redisinsight/) | Redis database management tool | 1.0.1 |
| [restic-backup](charts/apps/restic-backup/) | Automated Kubernetes volume backups using restic | 1.2.1 |
| [semaphore](charts/apps/semaphore/) | Modern UI for Ansible, Terraform, and more | 1.3.1 |
| [shlink](charts/apps/shlink/) | Self-hosted URL shortener with analytics | 1.0.1 |
| [uptime-kuma](charts/apps/uptime-kuma/) | Self-hosted monitoring tool | 1.0.1 |

### Libraries (`charts/libs/`)

| Chart | Description |
|-------|-------------|
| [common](charts/libs/common/) | Shared library chart with common templates and helpers |

### Vendored Charts (`charts/vendors/`)

| Chart | Description |
|-------|-------------|
| [nginx](charts/vendors/nginx/) | Vendored NGINX chart |

## Quick Start

### Prerequisites

- Kubernetes cluster (1.19+)
- Helm 3.8+
- kubectl configured to communicate with your cluster

### Adding the Repository

```bash
helm repo add pandia https://charts.pandia.io/
helm repo update
```

### Installing a Chart

```bash
# Install with default values
helm install my-release pandia/<chart-name>

# Install with custom values
helm install my-release pandia/<chart-name> -f values.yaml

# Install in a specific namespace
helm install my-release pandia/<chart-name> --namespace my-namespace --create-namespace
```

### Upgrading a Release

```bash
helm upgrade my-release pandia/<chart-name>
```

### Uninstalling a Release

```bash
helm uninstall my-release
```

## Chart Documentation

Each chart has its own detailed README with:

- Complete parameter documentation
- Usage examples
- Configuration guides
- Troubleshooting tips

Visit the individual chart directories for more information.

## Development

### Prerequisites for Development

- [Helm](https://helm.sh/docs/intro/install/) v3.8+
- [helm-docs](https://github.com/norwoodj/helm-docs) (for documentation generation)
- [chart-testing](https://github.com/helm/chart-testing) (for linting and testing)
- [yamllint](https://github.com/adrienvergo/yamllint)
- [kind](https://kind.sigs.k8s.io/) (for local integration testing)

### Local Testing

```bash
# Lint all charts
make lint

# Lint a specific chart
make lint-chart CHART=apps/home-assistant

# Run unit tests
make test

# Run full CI locally (requires kind)
make ci-local

# Template and validate
make template CHART=apps/home-assistant
```

### Building Documentation

```bash
# Generate README files for all charts
make docs

# Generate docs for a specific chart
make docs-chart CHART=apps/home-assistant
```

## Contributing

We welcome contributions! Please see our [Contributing Guidelines](docs/CONTRIBUTING.md) for details on:

- How to submit issues and pull requests
- Code standards and testing requirements
- Development workflow
- Release process

For security concerns, please review our [Security Policy](docs/SECURITY.md) and report vulnerabilities responsibly.

## Chart Releases

Charts are automatically released via GitHub Actions when changes are merged to the main branch. The release process:

1. Detects changed charts
2. Lints and tests the charts
3. Packages the charts
4. Creates GitHub releases
5. Updates the Helm repository index
6. Publishes to GitHub Pages

Release artifacts and changelogs are available in the [Releases](https://github.com/codefuturist/helm-charts/releases) section.

## Repository Structure

```text
helm-charts/
├── .github/
│   ├── workflows/           # CI/CD workflows (release, lint-test)
│   └── dependabot.yml       # Dependency update configuration
├── charts/
│   ├── apps/                # Application charts (home-assistant, pgadmin, etc.)
│   ├── libs/                # Shared library charts (common)
│   └── vendors/             # Vendored third-party charts (nginx)
├── docs/                    # Documentation (CONTRIBUTING, SECURITY)
├── templates/               # Chart templates and documentation
├── tools/
│   └── compose-converter/   # Docker Compose to Helm converter utility
├── ct.yaml                  # Chart testing configuration
├── artifacthub-repo.yaml    # Artifact Hub metadata
├── Makefile                 # Development commands
└── README.md                # This file
```

## Support

- **Issues**: [GitHub Issues](https://github.com/codefuturist/helm-charts/issues)
- **Discussions**: [GitHub Discussions](https://github.com/codefuturist/helm-charts/discussions)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Inspired by and built upon best practices from the Kubernetes and Helm communities
- Special thanks to all contributors

---

**Maintained by:** [@codefuturist](https://github.com/codefuturist)  
**Repository:** [github.com/codefuturist/helm-charts](https://github.com/codefuturist/helm-charts)
