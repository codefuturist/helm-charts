# Bitwarden ESO Provider Application

Python webhook service that integrates Bitwarden with External Secrets Operator using the Bitwarden CLI.

## Features

- ✅ **Personal vault access** - Works with your personal Bitwarden vault
- ✅ **Multiple auth methods** - Supports both password and API key authentication
- ✅ **No subscription required** - Uses personal vault, not Secrets Manager
- ✅ **Session management** - Automatic session renewal and vault syncing
- ✅ **Caching** - LRU cache with configurable TTL for better performance
- ✅ **Built with UV** - Fast dependency management and builds
- ✅ **Bitwarden CLI** - Uses official CLI (v2024.10.0)
- 📦 **Container size** - ~284MB (includes CLI)

## Authentication Methods

### Password Authentication (Recommended for Development)
```bash
export BW_AUTH_METHOD="password"
export BW_EMAIL="your-email@example.com"
export BW_PASSWORD="your-master-password"
```

### API Key Authentication (Recommended for Production)
```bash
export BW_AUTH_METHOD="apikey"
export BW_CLIENTID="user.xxxxx"
export BW_CLIENTSECRET="xxxxx"
```

Get your API keys from: https://vault.bitwarden.com/settings/security/security-keys

## Project Structure

```
bitwarden-eso-provider-app/
├── app/
│   ├── app.py              # SDK-based implementation
│   └── requirements.txt    # Dependencies
├── pyproject.toml          # UV project configuration
├── Dockerfile              # Container build
├── _archive/               # Archived CLI version
└── README.md
```

## Build with UV

```bash
docker build -t ghcr.io/codefuturist/bitwarden-eso-provider:latest .
```

## Development with UV

### Install dependencies
```bash
# Install UV if not already installed
curl -LsSf https://astral.sh/uv/install.sh | sh

# Install all dependencies
uv sync

# Install with SDK extras
uv sync --extra sdk

# Install dev dependencies
uv sync --extra dev
```

### Run locally
```bash
# Set environment variables
export BW_CLIENT_ID=your_client_id
export BW_CLIENT_SECRET=your_client_secret
export AUTH_TOKEN=your_auth_token

# Run SDK version
uv run python app/app-sdk.py

# Run CLI version (requires bw CLI installed)
uv run python app/app.py
```

## Container Images

Published to GitHub Container Registry:
- `ghcr.io/codefuturist/bitwarden-eso-provider:latest`
- `ghcr.io/codefuturist/bitwarden-eso-provider:v1.0.0`

**Archived**: CLI version (using Bitwarden CLI binary) is in `_archive/` directory.

## Configuration

Environment variables:
- `BW_CLIENT_ID` - Bitwarden API client ID
- `BW_CLIENT_SECRET` - Bitwarden API client secret
- `BW_EMAIL` - Bitwarden email (password auth)
- `BW_PASSWORD` - Bitwarden master password (password auth)
- `BW_SERVER_URL` - Bitwarden server URL (default: https://vault.bitwarden.com)
- `AUTH_TOKEN` - Webhook authentication token
- `CACHE_ENABLED` - Enable caching (default: true)
- `CACHE_TTL` - Cache TTL in seconds (default: 60)
- `PORT` - Server port (default: 8080)
- `DEBUG` - Enable debug mode (default: false)

## Helm Chart

The Helm chart is in a separate directory: `../bitwarden-eso-provider/`

See the chart's README for installation instructions.
