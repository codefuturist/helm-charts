# Charts Overview

This repository contains the following Helm charts:

## Available Charts

| Chart | Version | Description |
|-------|---------|-------------|
| [application](application.md) | 6.14.1 | Generic helm chart for deploying stateless applications |
| [homarr](homarr.md) | 5.2.12 | Dashboard for managing self-hosted applications |
| [nginx](nginx.md) | 0.1.2 | NGINX web server with customizable configuration |

## Chart Categories

### :material-application: Application Deployment

- **[Application](application.md)** - Deploy any stateless application with support for:
    - Deployments, Jobs, and CronJobs
    - ConfigMaps and Secrets
    - Ingress and Services
    - Autoscaling (HPA/VPA)
    - ServiceMonitors for Prometheus

### :material-home: Dashboard & Management

- **[Homarr](homarr.md)** - Self-hosted dashboard for your applications

### :material-web: Web Servers

- **[NGINX](nginx.md)** - Production-ready NGINX deployment

## Common Patterns

All charts in this repository follow these conventions:

### Naming Convention

Resources are named using the pattern: `{{ .Release.Name }}-{{ .Chart.Name }}`

### Labels

Standard Kubernetes labels are applied:

```yaml
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: Helm
```

### Security Defaults

All charts include secure defaults:

- `readOnlyRootFilesystem: true`
- `runAsNonRoot: true`
- Resource limits defined

## Finding Values

Use the [Values Search](../reference/search.md) to quickly find configuration options across all charts.
