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

Helm chart for deploying [Homarr](https://homarr.dev) - A simple, yet powerful dashboard for your server. Perfect for homelabs and self-hosted environments.

**Version:** 1.0.0  
**App Version:** latest

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

Visit the individual chart directories for more information:

- [Application Chart Documentation](charts/application/README.md)
- [Homarr Chart Documentation](charts/homarr/README.md)

## Development

### Prerequisites for Development

- [Helm](https://helm.sh/docs/intro/install/) v3.8+
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

```bash
# Generate README files for all charts
make build-docs

# Or manually with helm-docs
helm-docs charts/<chart-name>
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

```
helm-charts/
├── .github/
│   ├── workflows/       # CI/CD workflows
│   └── ct-lint.yaml     # Chart testing linting configuration
├── charts/              # All Helm charts
│   ├── application/     # Generic application chart
│   └── homarr/         # Homarr dashboard chart
├── docs/               # Documentation (CHANGELOG, CONTRIBUTING, SECURITY)
├── ct.yaml             # Chart testing configuration
├── artifacthub-repo.yaml  # Artifact Hub metadata
├── LICENSE            # MIT License
└── README.md          # This file
```

## Support

- **Issues**: [GitHub Issues](https://github.com/codefuturist/helm-charts/issues)
- **Discussions**: [GitHub Discussions](https://github.com/codefuturist/helm-charts/discussions)
- **Email**: 58808821+codefuturist@users.noreply.github.com

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Inspired by and built upon best practices from the Kubernetes and Helm communities
- Special thanks to all contributors

---

**Maintained by:** [@codefuturist](https://github.com/codefuturist)  
**Repository:** [github.com/codefuturist/helm-charts](https://github.com/codefuturist/helm-charts)
