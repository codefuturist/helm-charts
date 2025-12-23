# Helm Charts

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Release Charts](https://github.com/codefuturist/helm-charts/actions/workflows/release.yaml/badge.svg)](https://github.com/codefuturist/helm-charts/actions/workflows/release.yaml)

A collection of Helm charts for Kubernetes deployments, maintained by [@codefuturist](https://github.com/codefuturist).

## Overview

This repository contains production-ready Helm charts for various applications and services. Each chart follows Kubernetes and Helm best practices, providing flexible configuration options and comprehensive documentation.

## Available Charts

### 🚀 [Application](charts/application/)

A generic, highly flexible Helm chart for deploying various types of applications on Kubernetes. Supports deployments, jobs, and cronjobs with extensive configuration options including:

- Multiple deployment strategies (Deployment, Job, CronJob)
- Comprehensive probe configurations (startup, readiness, liveness)
- Service mesh integration (Istio, Linkerd)
- Monitoring (ServiceMonitor, PrometheusRule, Grafana Dashboards)
- Security features (NetworkPolicy, PodDisruptionBudget, RBAC)
- Auto-scaling (HPA, VPA)
- Certificate management
- And much more...

**Version:** 5.1.4

### 📊 [Homarr](charts/homarr/)

Helm chart for deploying [Homarr](https://github.com/ajnart/homarr) - a modern, customizable dashboard that puts all of your apps and services at your fingertips. Perfect for homelabs and self-hosted environments.

**Version:** 5.2.11
**App Version:** 0.15.0

### 🌐 [NGINX](charts/nginx/)

Helm chart for deploying NGINX web server with customizable configuration options.

**Version:** 0.1.1
**App Version:** 1.27.0

## Quick Start

### Prerequisites

- Kubernetes cluster (1.19+)
- Helm 3.8+
- kubectl configured to communicate with your cluster

### Adding the Repository

```bash
helm repo add pandia https://charts.pandia.io
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

📚 **Full documentation with search**: [charts.pandia.io](https://charts.pandia.io)

Each chart has its own detailed README with:
- Complete parameter documentation
- Usage examples
- Configuration guides
- Troubleshooting tips

### Quick Links

| Chart | README | Search Values |
|-------|--------|---------------|
| Application | [README](charts/application/README.md) | [Search](https://charts.pandia.io/charts/application/) |
| Homarr | [README](charts/homarr/README.md) | [Search](https://charts.pandia.io/charts/homarr/) |
| NGINX | [README](charts/nginx/README.md) | [Search](https://charts.pandia.io/charts/nginx/) |

**Search all values across all charts**: [Values Search](https://charts.pandia.io/reference/search/)

## Development

### Prerequisites for Development

- [Helm](https://helm.sh/docs/intro/install/) v3.8+
- [uv](https://docs.astral.sh/uv/) (fast Python package manager for documentation)
- [helm-docs](https://github.com/norwoodj/helm-docs) (for documentation generation)
- [chart-testing](https://github.com/helm/chart-testing) (for linting and testing)
- [yamllint](https://github.com/adrienverge/yamllint)

### Local Testing

```bash
# Lint all charts
ct lint --config ct.yaml --all

# Lint a specific chart
helm lint charts/<chart-name>

# Template and validate
helm template test charts/<chart-name> --values charts/<chart-name>/values.yaml

# Dry run installation
helm install test-release charts/<chart-name> --dry-run --debug
```

### Building Documentation

**Quick Start (Recommended):**

```bash
# Start local documentation server with live reload
./scripts/docs-dev.sh serve

# Or use make
make docs-serve
```

This will:
- Create a virtual environment automatically
- Install all dependencies
- Generate documentation from chart values
- Start a local server at http://localhost:8000
- Auto-refresh when you make changes

**Other Commands:**

```bash
# Using the dev script
./scripts/docs-dev.sh help      # Show all commands
./scripts/docs-dev.sh build     # Build static site
./scripts/docs-dev.sh generate  # Regenerate from values only
./scripts/docs-dev.sh sync      # Sync charts with docs (add/remove)
./scripts/docs-dev.sh check     # Check if docs are in sync
./scripts/docs-dev.sh clean     # Clean generated files

# Using make
make docs-deps      # Install dependencies only
make docs-generate  # Generate MkDocs pages from charts  
make docs-build     # Build documentation site
make docs-sync      # Sync charts with docs
make docs-check     # Check if docs are in sync
make docs-open      # Open built docs in browser
make docs-clean     # Clean documentation artifacts
```

**Automatic Sync:**

Documentation is automatically synced when you commit via pre-commit hooks. If you add or remove a chart:

1. The hook detects changes to `charts/*/Chart.yaml` or `charts/*/values.yaml`
2. Generates/removes documentation pages automatically
3. Updates `mkdocs.yml` navigation
4. Updates the charts index page

To manually sync after adding/removing charts:

```bash
./scripts/docs-dev.sh sync
# or
make docs-sync
```

## Contributing

We welcome contributions! Please see our [Contributing Guide](docs/CONTRIBUTING.md) for details on:
- How to submit issues and pull requests
- Development setup and workflow
- Chart development guidelines
- Testing requirements

## Security

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

```
helm-charts/
├── .github/
│   ├── workflows/       # CI/CD workflows
│   └── ct-lint.yaml     # Chart testing linting configuration
├── charts/              # All Helm charts
│   ├── application/     # Generic application chart
│   ├── homarr/         # Homarr dashboard chart
│   └── nginx/          # NGINX chart
├── docs/               # Documentation
│   ├── CHANGELOG.md    # Version history
│   ├── CONTRIBUTING.md # Contribution guidelines
│   ├── SECURITY.md     # Security policy
│   └── ...             # Additional documentation
├── site/               # GitHub Pages content
│   ├── index.html      # Landing page
│   └── index.yaml      # Helm repository index
├── ct.yaml             # Chart testing configuration
├── LICENSE            # MIT License
└── README.md          # This file
```

## Support

- **Issues**: [GitHub Issues](https://github.com/codefuturist/helm-charts/issues)
- **Discussions**: [GitHub Discussions](https://github.com/codefuturist/helm-charts/discussions)
- **Email**: hello@allcloud.trade

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Inspired by and built upon best practices from the Kubernetes and Helm communities
- Special thanks to all contributors

---

**Maintained by:** [@codefuturist](https://github.com/codefuturist)
**Repository:** [github.com/codefuturist/helm-charts](https://github.com/codefuturist/helm-charts)
