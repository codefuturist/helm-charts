# Charts Overview

This repository contains the following Helm charts:

## Available Charts

| Chart | Version | Description |
|-------|---------|-------------|
| [actualbudget](actualbudget.md) | 1.0.0 | A Helm chart for Actual Budget - A local-first personal finance app |
| [application](application.md) | 6.14.1 | Generic helm chart for all kind of applications |
| [bitwarden-eso-provider](bitwarden-eso-provider.md) | 1.0.0 | A Bitwarden webhook provider for External Secrets Operator that works with personal/organizational vaults using the Bitwarden CLI
 |
| [compass-web](compass-web.md) | 1.0.0 | A production-ready Helm chart for MongoDB Compass Web - MongoDB database management and administration tool |
| [homarr](homarr.md) | 5.2.12 | Generic helm chart for all kind of applications |
| [home-assistant](home-assistant.md) | 1.0.0 | A comprehensive Helm chart for Home Assistant - Open source home automation that puts local control and privacy first
 |
| [it-tools](it-tools.md) | 1.0.0 | A Helm chart for IT Tools - Useful tools for developers |
| [mailrise](mailrise.md) | 1.0.0 | An SMTP gateway for Apprise notifications - convert emails to 60+ notification services |
| [mealie](mealie.md) | 1.0.0 | A Helm chart for mealie |
| [metube](metube.md) | 1.0.0 | A Helm chart for MeTube - YouTube downloader with web interface powered by yt-dlp |
| [netbootxyz](netbootxyz.md) | 1.0.0 | netboot.xyz is a network boot environment that allows PXE booting various operating system installers or utilities from a central location.
 |
| [nginx](nginx.md) | 0.1.2 | Helm chart for deploying NGINX web server with customizable configuration |
| [paperless-ngx](paperless-ngx.md) | 1.0.0 | A Helm chart for Paperless-ngx - A community-supported supercharged version of paperless based on paperless-ng
 |
| [pgadmin](pgadmin.md) | 1.0.0 | A production-ready Helm chart for pgAdmin 4 - PostgreSQL management and administration tool |
| [protonpass-eso-provider](protonpass-eso-provider.md) | 1.0.0 | A Proton Pass webhook provider for External Secrets Operator that fetches secrets from Proton Pass vaults using pass-cli |
| [proxmox-backup-server](proxmox-backup-server.md) | 1.0.0 | A production-ready Helm chart for Proxmox Backup Server - Enterprise backup solution for virtual environments
 |
| [redisinsight](redisinsight.md) | 1.0.0 | A production-ready Helm chart for Redis Insight - Redis database management and administration tool |
| [restic-backup](restic-backup.md) | 1.0.0 | A user-friendly Helm chart for automated Kubernetes volume backups using restic with support for multiple storage backends and flexible scheduling
 |
| [semaphore](semaphore.md) | 1.0.0 | Modern UI for Ansible, Terraform, OpenTofu, Bash, and Pulumi - task automation and infrastructure orchestration |
| [shlink](shlink.md) | 1.0.0 | A production-ready Helm chart for Shlink - Self-hosted URL shortener with analytics and web UI |
| [test-final](test-final.md) | 1.0.0 | Test chart with auto-version |
| [uptime-kuma](uptime-kuma.md) | 1.0.0 | A self-hosted monitoring tool - monitor uptime for HTTP(s) / TCP / HTTP(s) Keyword / Ping / DNS Record / Push / Steam Game Server
 |

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
app.kubernetes.io/name: { { .Chart.Name } }
app.kubernetes.io/instance: { { .Release.Name } }
app.kubernetes.io/version: { { .Chart.AppVersion } }
app.kubernetes.io/managed-by: Helm
```

### Security Defaults

All charts include secure defaults:

- `readOnlyRootFilesystem: true`
- `runAsNonRoot: true`
- Resource limits defined

## Finding Values

Use the [Values Search](../reference/search.md) to quickly find configuration options across all charts.
