# Architecture: Proton Pass ESO Provider

## System Design

```
┌──────────────────────────────────────────────────────────────┐
│                     Kubernetes Cluster                        │
│                                                              │
│  ┌─────────────┐   POST /api/v1/secret    ┌──────────────┐  │
│  │  External    │ ──────────────────────▶  │  Provider    │  │
│  │  Secrets     │   { itemId, field }      │  (FastAPI)   │  │
│  │  Operator    │ ◀──────────────────────  │              │  │
│  │              │   { value: "..." }       │  pass-cli    │──┼──▶ Proton Pass API
│  └──────┬───────┘                          └──────────────┘  │
│         │                                         │          │
│         ▼                                    ┌────┴────┐     │
│  ┌─────────────┐                             │  Cache  │     │
│  │  K8s Secret │                             │ (in-mem)│     │
│  │  (synced)   │                             └─────────┘     │
│  └─────────────┘                                             │
└──────────────────────────────────────────────────────────────┘
```

## Components

### 1. FastAPI Application (`app/main.py`)

The core service exposes:

| Endpoint                | Method | Purpose                                   |
| ----------------------- | ------ | ----------------------------------------- |
| `/api/v1/secret`        | POST   | ESO webhook — resolves secrets            |
| `/healthz`              | GET    | Liveness probe                            |
| `/readyz`               | GET    | Readiness probe (checks pass-cli session) |
| `/api/v1/vaults`        | GET    | Admin: list vaults (optional)             |
| `/api/v1/items/{vault}` | GET    | Admin: list items (optional)              |
| `/api/v1/cache/stats`   | GET    | Admin: cache metrics (optional)           |

### 2. Proton Pass Service (`app/services/protonpass.py`)

Wraps `pass-cli` as async subprocesses:

- **Authentication**: `pass-cli login --username ... --password ...`
- **Secret resolution**: Pipes templates through `pass-cli inject` to resolve `pass://` URIs
- **Vault access control**: Enforces allow/deny lists before any CLI call
- **Session management**: Checks session validity via readiness probe

### 3. Secret Cache (`app/services/cache.py`)

Thread-safe, in-memory LRU cache with TTL:

- Reduces redundant pass-cli invocations
- Configurable TTL (default: 5 minutes) and max entries (default: 1000)
- Cache stats exposed via admin endpoint
- Clear cache on demand via admin endpoint

### 4. Helm Chart

Follows the exact pattern of `bitwarden-eso-provider`:

- **ClusterSecretStore**: Webhook provider pointing to the service
- **Deployment**: Single container with pass-cli, session volume, health probes
- **Secrets**: Credentials + API token (supports existing secrets)
- **NetworkPolicy**: Restricts ingress to ESO namespace
- **ServiceMonitor**: Optional Prometheus integration

## Authentication Flow

```
Pod Start
  │
  ├─ Set PROTON_PASS_KEY_PROVIDER=fs
  ├─ Set PROTON_PASS_SESSION_DIR=/app/.session
  │
  ├─ pass-cli login --username $USERNAME --password $PASSWORD
  │   ├─ Generates 256-bit encryption key → /app/.session/local.key
  │   ├─ Authenticates with Proton API
  │   └─ Stores encrypted session data
  │
  ├─ readinessProbe: GET /readyz
  │   └─ Calls: pass-cli vault list (validates session)
  │
  └─ Ready to serve ESO webhook requests
```

## Secret Resolution Flow

```
ESO ExternalSecret
  │
  ├─ POST /api/v1/secret
  │   Body: { "itemId": "My Database", "field": "password" }
  │   Header: Authorization: Bearer <api-token>
  │
  ├─ Verify bearer token
  ├─ Check cache → hit? return cached value
  │
  ├─ Check vault access (allow/deny lists)
  ├─ Build reference: pass://Company Secrets/My Database/password
  │
  ├─ echo "{{ pass://Company Secrets/My Database/password }}" | pass-cli inject
  │   └─ Returns: actual_secret_value
  │
  ├─ Store in cache (key: "Company Secrets:My Database:password")
  │
  └─ Response: { "value": "actual_secret_value" }
```

## Security Model

| Layer              | Mechanism                                                |
| ------------------ | -------------------------------------------------------- |
| Transport          | ClusterIP service (no external exposure)                 |
| Authentication     | Bearer token on webhook requests                         |
| Authorization      | Vault allow/deny lists                                   |
| Encryption at rest | Proton Pass E2E encryption + pass-cli session encryption |
| Container security | Non-root, dropped capabilities, read-only hints          |
| Network            | NetworkPolicy restricts ingress to ESO namespace         |
| Secrets management | K8s Secrets (SOPS-encrypted in Git)                      |
| Session data       | emptyDir volume (ephemeral, pod-scoped)                  |
