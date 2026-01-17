# Mealie Helm Chart Examples

This directory contains example configurations for different Mealie deployment scenarios.

## Available Examples

### 📁 `values-minimal.yaml` - SQLite Mode (Single User/Small)

**Use case:** Personal use, testing, development, or small deployments

**Features:**

- SQLite database (no PostgreSQL required)
- Single replica
- Minimal resource requirements
- No external dependencies

**Deploy:**

```bash
helm install mealie ./mealie -f examples/values-minimal.yaml
```

---

### 📁 `values-production.yaml` - PostgreSQL Mode (Multi-User/Production)

**Use case:** Production deployments, multiple users, high availability

**Features:**

- PostgreSQL database (included)
- Multiple replicas with anti-affinity
- Resource limits and requests
- Email/SMTP configuration
- Ingress with TLS
- Production-ready settings

**Prerequisites:**

```bash
# Create SMTP secret
kubectl create secret generic mealie-smtp-secret \
  --from-literal=password='your-smtp-password'
```

**Deploy:**

```bash
helm install mealie ./mealie -f examples/values-production.yaml
```

---

### 📁 `values-oidc.yaml` - OpenID Connect Authentication

**Use case:** SSO integration with Keycloak, Authentik, Auth0, Okta, etc.

**Features:**

- OIDC authentication
- Automatic user provisioning
- Group-based access control
- Auto-redirect to IdP
- Password login disabled

**Prerequisites:**

1. Configure your Identity Provider:
   - Create OAuth2/OIDC client
   - Set redirect URI: `https://mealie.example.com/login`
   - Enable scopes: `openid`, `profile`, `email`, (optional: `groups`)

2. Create OIDC secret:

```bash
kubectl create secret generic mealie-oidc-secret \
  --from-literal=client-secret='your-oidc-client-secret'
```

**Deploy:**

```bash
helm install mealie ./mealie -f examples/values-oidc.yaml
```

**IdP Examples:**

- **Keycloak:** Use realm's OpenID Configuration URL
- **Authentik:** `https://authentik.example.com/application/o/mealie/.well-known/openid-configuration`
- **Auth0:** `https://your-tenant.auth0.com/.well-known/openid-configuration`

---

### 📁 `values-ldap.yaml` - LDAP Authentication

**Use case:** Integration with Active Directory, OpenLDAP, FreeIPA, etc.

**Features:**

- LDAP authentication
- Attribute mapping (uid, name, email)
- Group-based filtering
- Admin group support
- Secure LDAPS or STARTTLS

**Prerequisites:**

1. Create service account in LDAP for Mealie (read-only)

2. Create LDAP secret:

```bash
kubectl create secret generic mealie-ldap-secret \
  --from-literal=bind-password='your-bind-password'
```

3. Test LDAP connectivity:

```bash
ldapsearch -x -H ldaps://ldap.example.com:636 \
  -D "cn=mealie-readonly,ou=service-accounts,dc=example,dc=com" \
  -W -b "ou=users,dc=example,dc=com" "(uid=testuser)"
```

**Deploy:**

```bash
helm install mealie ./mealie -f examples/values-ldap.yaml
```

---

### 📁 `values-logging.yaml` - Custom Logging Configuration

**Use case:** Advanced logging with rotation, separate error logs, or JSON formatting

**Features:**

- Custom Python logging configuration
- Log rotation (10MB files, 5 backups)
- Separate error log file
- Configurable log levels per module
- Detailed formatting options

**Deploy:**

```bash
helm install mealie ./mealie -f examples/values-logging.yaml
```

**Access Logs:**

```bash
# View logs via Kubernetes (stdout)
kubectl logs -l app.kubernetes.io/name=mealie,app.kubernetes.io/component=mealie

# View log files in pod
kubectl exec -it deployment/mealie-release-mealie -- tail -f /app/data/mealie.log
kubectl exec -it deployment/mealie-release-mealie -- tail -f /app/data/mealie-error.log

# Copy log files locally
kubectl cp mealie-release-mealie-pod:/app/data/mealie.log ./mealie.log
```

---

## Configuration Quick Reference

### Common Environment Variables

| Variable       | Purpose                 | Example                      |
| -------------- | ----------------------- | ---------------------------- |
| `BASE_URL`     | External URL for Mealie | `https://mealie.example.com` |
| `TZ`           | Timezone for scheduling | `America/New_York`           |
| `ALLOW_SIGNUP` | Allow self-registration | `true` or `false`            |
| `LOG_LEVEL`    | Logging verbosity       | `info`, `debug`, `warning`   |

### Database Options

| Mode                  | Configuration             | Use Case                 |
| --------------------- | ------------------------- | ------------------------ |
| SQLite                | `postgres.enabled: false` | Single user, testing     |
| PostgreSQL (Internal) | `postgres.enabled: true`  | Multi-user, production   |
| PostgreSQL (External) | `database.urlOverride`    | Managed database service |

### Authentication Options

| Method           | Configuration             | Example File          |
| ---------------- | ------------------------- | --------------------- |
| Local (Password) | Default                   | `values-minimal.yaml` |
| OIDC/OAuth2      | `OIDC_AUTH_ENABLED: true` | `values-oidc.yaml`    |
| LDAP             | `LDAP_AUTH_ENABLED: true` | `values-ldap.yaml`    |

### Logging Options

| Feature                 | Configuration                  | Example File          |
| ----------------------- | ------------------------------ | --------------------- |
| Default (stdout + file) | No special config              | All examples          |
| Custom rotation/format  | `mealie.logging.enabled: true` | `values-logging.yaml` |
| JSON logs               | Custom formatter in config     | `values-logging.yaml` |

---

## Using Kubernetes Secrets

For sensitive values, use Kubernetes secrets instead of plain text:

### Create Secret

```bash
kubectl create secret generic mealie-secrets \
  --from-literal=smtp-password='password123' \
  --from-literal=db-password='dbpass456' \
  --from-literal=oidc-secret='oidcsecret789'
```

### Reference in Values

```yaml
mealie:
  env:
    SMTP_PASSWORD:
      valueFrom:
        secretKeyRef:
          name: mealie-secrets
          key: smtp-password

    OIDC_CLIENT_SECRET:
      valueFrom:
        secretKeyRef:
          name: mealie-secrets
          key: oidc-secret
```

---

## Combining Examples

You can combine multiple example files:

```bash
# Use production base with OIDC authentication
helm install mealie ./mealie \
  -f examples/values-production.yaml \
  -f examples/values-oidc.yaml
```

---

## All Available Environment Variables

For a complete list of all supported environment variables, see:

- [Mealie Official Documentation](https://docs.mealie.io/documentation/getting-started/installation/backend-config/)
- Chart `values.yaml` - includes all variables with descriptions

---

## Troubleshooting

### Check Logs

```bash
kubectl logs -l app.kubernetes.io/name=mealie,app.kubernetes.io/component=mealie
```

### Check Database Connection

```bash
kubectl exec -it deployment/mealie-release-postgres -- psql -U mealie -d mealie -c "SELECT 1"
```

### Verify OIDC Configuration

```bash
curl https://auth.example.com/.well-known/openid-configuration
```

### Test LDAP Connectivity

```bash
kubectl run ldap-test --rm -it --image=ubuntu --restart=Never -- bash
apt update && apt install -y ldap-utils
ldapsearch -x -H ldaps://ldap.example.com:636 -D "cn=bind-user,dc=example,dc=com" -W
```

---

## Getting Help

- **Documentation:** https://docs.mealie.io/
- **GitHub Issues:** https://github.com/mealie-recipes/mealie/issues
- **Chart Issues:** Open an issue in the helm-charts repository
