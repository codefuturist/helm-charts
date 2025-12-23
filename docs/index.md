# Helm Charts Repository

Welcome to the Helm Charts documentation! This repository contains production-ready Helm charts for deploying applications on Kubernetes.

## :mag: Quick Search

Use the search bar above (or press ++s++ / ++f++) to search across all chart values, descriptions, and documentation.

## :rocket: Featured Charts

<div class="grid cards" markdown>

-   :material-application:{ .lg .middle } __Application Chart__

    ---

    Generic helm chart for deploying stateless applications, jobs, and cronjobs.

    [:octicons-arrow-right-24: View Chart](charts/application.md)

-   :material-home:{ .lg .middle } __Homarr__

    ---

    Dashboard for managing your self-hosted applications.

    [:octicons-arrow-right-24: View Chart](charts/homarr.md)

-   :material-web:{ .lg .middle } __NGINX__

    ---

    NGINX web server with customizable configuration.

    [:octicons-arrow-right-24: View Chart](charts/nginx.md)

</div>

## :zap: Quick Start

```bash
# Add the Helm repository
helm repo add pandia https://charts.pandia.io
helm repo update

# Install a chart
helm install my-app pandia/application
```

## :books: Documentation

| Section | Description |
|---------|-------------|
| [Getting Started](getting-started/installation.md) | Installation and basic usage |
| [Charts](charts/index.md) | All available charts with full documentation |
| [Values Search](reference/search.md) | Interactive search across all chart values |
| [Contributing](CONTRIBUTING.md) | How to contribute to this repository |

## :label: Browse by Tags

Explore charts organized by tags in the navigation.

## :computer: Local Development

To preview this documentation locally:

```bash
# Clone the repo and start the dev server
./scripts/docs-dev.sh serve
```

The documentation will be available at [http://localhost:8000](http://localhost:8000) with live reload enabled.
