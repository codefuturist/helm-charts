# Proton Pass Secret Profiles

Profiles are the core of the developer experience — they map Proton Pass vault items to environment variables, enabling one-command secret injection.

## Profile Location

Profiles are stored in `~/.config/protonpass-provider/profiles/` as YAML files.

## Profile Format

```yaml
# ~/.config/protonpass-provider/profiles/myapp-dev.yaml
name: "myapp-dev"
description: "MyApp development environment secrets"
vault: "Development"

# Shared vault mappings: ENV_VAR → pass:// URI
mappings:
  DATABASE_URL: "pass://Development/MyApp Database/connection_string"
  DATABASE_PASSWORD: "pass://Development/MyApp Database/password"
  REDIS_URL: "pass://Development/Redis/url"
  API_KEY: "pass://Development/API Keys/myapp_key"
  SMTP_PASSWORD: "pass://Development/Email Service/password"

# Personal vault overrides (developer-specific)
personal:
  GITHUB_TOKEN: "pass://Personal/GitHub/token"
  NPM_TOKEN: "pass://Personal/NPM/token"
```

## Secret Reference Syntax

References follow the Proton Pass CLI URI format:

```
pass://<vault>/<item>/<field>
```

| Component | Description                 | Examples                          |
| --------- | --------------------------- | --------------------------------- |
| `vault`   | Vault name or Share ID      | `Development`, `Company Secrets`  |
| `item`    | Item title or Item ID       | `MyApp Database`, `API Keys`      |
| `field`   | Field name (case-sensitive) | `password`, `username`, `api_key` |

### Common Field Names

| Field      | Description                   |
| ---------- | ----------------------------- |
| `password` | Login item password           |
| `username` | Login item username           |
| `email`    | Login item email              |
| `url`      | Login item URL                |
| `note`     | Secure note content           |
| `totp`     | TOTP secret                   |
| `<custom>` | Any custom field you've added |

## Commands

### Create a Profile

```bash
just protonpass-profile-create myapp-dev
```

This launches an interactive wizard that:

1. Asks for a description
2. Shows available vaults
3. Lets you map ENV_VAR → vault item/field pairs

### List Profiles

```bash
just protonpass-profile-list
```

### Edit a Profile

```bash
just protonpass-profile-edit myapp-dev
```

Opens the profile in your `$EDITOR`.

### Generate .env from Profile

```bash
# Default output: .env.local
just protonpass-env myapp-dev

# Custom output file
just protonpass-env myapp-dev .env.development
```

### Check for Drift

```bash
just protonpass-env-diff myapp-dev
```

Compares your current `.env.local` against the live vault state and shows any differences.

### Run with Secrets

```bash
just protonpass-run myapp-dev npm start
```

Generates a temporary .env, uses `pass-cli run` to inject secrets as env vars, and executes the command. Secret masking is enabled by default.

## Tips

### Sharing Profiles via Git

You can version-control profile templates (without secret values) in your project:

```yaml
# .protonpass-profile.yaml (commit this)
name: "myapp"
vault: "Company Secrets"
mappings:
  DATABASE_URL: "pass://Company Secrets/MyApp DB/connection_string"
  API_KEY: "pass://Company Secrets/API Keys/myapp"
```

Then each developer copies it to their local profiles:

```bash
cp .protonpass-profile.yaml ~/.config/protonpass-provider/profiles/myapp.yaml
```

### Multiple Environments

Create separate profiles for each environment:

```
profiles/
├── myapp-dev.yaml       # Development vault
├── myapp-staging.yaml   # Staging vault
└── myapp-prod.yaml      # Production vault (restricted)
```

### Personal Overrides

The `personal:` section in profiles allows each developer to inject their own tokens without modifying the shared profile:

```yaml
personal:
  GITHUB_TOKEN: "pass://Personal/GitHub/token"
  SSH_KEY: "pass://Personal/SSH Keys/deploy"
```
