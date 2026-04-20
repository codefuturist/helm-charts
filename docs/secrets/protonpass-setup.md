# Proton Pass Secret Provider — Getting Started

This guide covers setting up Proton Pass as your company's secret provider, both for **Kubernetes** (via External Secrets Operator) and **local development** (via CLI tooling).

## Prerequisites

| Tool             | Purpose                    | Install                                                                                                       |
| ---------------- | -------------------------- | ------------------------------------------------------------------------------------------------------------- |
| `pass-cli`       | Proton Pass CLI            | `brew install protonpass/tap/pass-cli` or `curl -fsSL https://proton.me/download/pass-cli/install.sh \| bash` |
| `fzf` (optional) | Interactive vault browsing | `brew install fzf`                                                                                            |
| `yq` (optional)  | YAML profile parsing       | `brew install yq`                                                                                             |

## Quick Setup

```bash
# One-command setup (installs pass-cli, configures completions)
just protonpass-setup

# Authenticate
just protonpass-login

# Verify
just protonpass-status
```

## Vault Organization

We recommend organizing your Proton Pass vaults by environment/team:

| Vault             | Purpose                       | Access           |
| ----------------- | ----------------------------- | ---------------- |
| `Company Secrets` | Shared infrastructure secrets | All team members |
| `Production`      | Production credentials        | Ops team only    |
| `Staging`         | Staging environment           | Dev + Ops        |
| `Development`     | Shared dev secrets            | All developers   |
| Personal vaults   | Developer-specific tokens     | Individual       |

## Local Development Workflow

### 1. Create a Profile

Profiles map vault items to environment variables:

```bash
just protonpass-profile-create myapp-dev
```

This creates `~/.config/protonpass-provider/profiles/myapp-dev.yaml`:

```yaml
name: "myapp-dev"
description: "MyApp development secrets"
vault: "Development"
mappings:
  DATABASE_URL: "pass://Development/MyApp DB/connection_string"
  API_KEY: "pass://Development/API Keys/myapp"
  REDIS_PASSWORD: "pass://Development/Redis/password"
personal:
  GITHUB_TOKEN: "pass://Personal/GitHub/token"
```

### 2. Generate .env

```bash
# Generate .env.local from profile
just protonpass-env myapp-dev

# Or specify output file
just protonpass-env myapp-dev .env
```

### 3. Run with Secrets

```bash
# Inject secrets and run a command
just protonpass-run myapp-dev npm start

# Or use template injection
just protonpass-inject config.yaml.template config.yaml
```

### 4. Detect Drift

```bash
# Check if .env matches current vault state
just protonpass-env-diff myapp-dev
```

## Kubernetes Deployment

See the [Proton Pass ESO Provider chart](../../charts/apps/protonpass-eso-provider/README.md) for deploying the webhook provider to Kubernetes.

Quick version:

```bash
helm install protonpass-eso-provider charts/apps/protonpass-eso-provider \
  --namespace protonpass-eso-provider \
  --create-namespace \
  --set protonpass.auth.existingSecret.name=protonpass-credentials \
  --set protonpass.vaults.shared="Company Secrets"
```

Then in your application charts:

```yaml
externalSecret:
  enabled: true
  secretStore:
    name: protonpass
    kind: ClusterSecretStore
  files:
    main:
      data:
        DB_PASSWORD:
          remoteRef:
            key: "MyApp Database"
            property: "password"
```

## All Just Commands

| Command                                            | Description                       |
| -------------------------------------------------- | --------------------------------- |
| `just protonpass-setup`                            | Install and configure everything  |
| `just protonpass-login`                            | Authenticate with Proton Pass     |
| `just protonpass-logout`                           | Clear session                     |
| `just protonpass-status`                           | Show status                       |
| `just protonpass-get "pass://..."`                 | Get a single secret               |
| `just protonpass-vaults`                           | List vaults                       |
| `just protonpass-list [vault]`                     | List items (interactive with fzf) |
| `just protonpass-search <query>`                   | Search across vaults              |
| `just protonpass-env <profile>`                    | Generate .env from profile        |
| `just protonpass-env-diff <profile>`               | Detect drift                      |
| `just protonpass-inject <template>`                | Inject secrets into template      |
| `just protonpass-run <profile> <cmd>`              | Run with secrets                  |
| `just protonpass-profile-list`                     | List profiles                     |
| `just protonpass-profile-create <n>`               | Create profile                    |
| `just protonpass-profile-edit <n>`                 | Edit profile                      |
| `just protonpass-k8s-secret <ns> <name> <profile>` | Generate K8s Secret YAML          |
| `just protonpass-k8s-eso <profile>`                | Generate ExternalSecret YAML      |
| `just protonpass-audit`                            | Audit report                      |
