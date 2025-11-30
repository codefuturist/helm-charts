# User and Database Management Feature

## Overview

The PostgreSQL Helm chart now supports automated creation of additional databases and users during initialization. This feature provides two approaches:

1. **Configuration-based**: Define users and databases directly in `values.yaml`
2. **Kubernetes-native**: Read definitions from external ConfigMaps and Secrets

## Features

- ✅ Create multiple databases with encoding, locale, and template options
- ✅ Create users with granular privileges and attributes
- ✅ **Automatic database ownership** - databases are automatically owned by the first user with ALL privileges
- ✅ Secure password management via Kubernetes Secrets
- ✅ GitOps-friendly external resource integration
- ✅ Idempotent SQL generation (safe for upgrades)
- ✅ Multi-tenant support
- ✅ Automatic privilege granting on databases
- ✅ Support for superuser, createdb, createrole, replication attributes

## Configuration Examples

### Method 1: Direct Configuration

```yaml
postgresql:
  additionalDatabases:
    - name: myapp_db
      # owner is automatically set to myapp_user (first user with ALL privileges)
      encoding: UTF8
      lc_collate: en_US.UTF-8
      lc_ctype: en_US.UTF-8
      template: template0
    - name: analytics_db
      owner: postgres  # Explicitly set owner (optional)
    - name: staging_db
      # owner is automatically set to myapp_user

  additionalUsers:
    - username: myapp_user
      existingSecret: myapp-user-secret  # Recommended
      databases:
        - myapp_db
        - staging_db
      privileges: ALL  # Gets ownership of myapp_db and staging_db
      superuser: false
      createdb: false

    - username: readonly_user
      existingSecret: readonly-secret
      databases:
        - myapp_db
        - analytics_db
      privileges: SELECT
```

### Method 2: External Kubernetes Resources

**Step 1:** Create ConfigMaps and Secrets

```bash
# Databases ConfigMap
kubectl create configmap postgresql-databases --from-file=databases.yaml

# Users ConfigMap
kubectl create configmap postgresql-users --from-file=users.yaml

# Passwords Secret
kubectl create secret generic postgresql-user-passwords \
  --from-literal=myapp-password=strong_pass_123 \
  --from-literal=readonly-password=readonly_pass_456
```

**Step 2:** Configure chart

```yaml
postgresql:
  externalResources:
    enabled: true

    databasesConfigMap:
      name: postgresql-databases
      key: databases.yaml

    usersConfigMap:
      name: postgresql-users
      key: users.yaml

    usersSecret:
      name: postgresql-user-passwords
      passwordKeys:
        myapp_user: myapp-password
        readonly_user: readonly-password
```

## Database Options

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `name` | string | Yes | Database name |
| `owner` | string | No | Database owner user. **If not specified, automatically set to the first user with ALL privileges on this database** |
| `encoding` | string | No | Character encoding (e.g., UTF8) |
| `lc_collate` | string | No | Locale collation (e.g., en_US.UTF-8) |
| `lc_ctype` | string | No | Locale character type (e.g., en_US.UTF-8) |
| `template` | string | No | Template database (e.g., template0) |

### Automatic Database Ownership

By default, databases are automatically owned by the first user that has `ALL` privileges on them. This follows the best practice of giving application users ownership of their dedicated databases.

**Example:**
```yaml
additionalDatabases:
  - name: myapp_db        # Automatically owned by myapp_user
  - name: shared_db       # Automatically owned by app_admin
  - name: system_db       # Explicitly owned by postgres
    owner: postgres

additionalUsers:
  - username: myapp_user
    databases: [myapp_db]
    privileges: ALL       # Gets ownership of myapp_db

  - username: app_admin
    databases: [shared_db]
    privileges: ALL       # Gets ownership of shared_db

  - username: readonly
    databases: [myapp_db, shared_db]
    privileges: SELECT    # Does NOT get ownership (read-only)
```

To explicitly set ownership (override automatic behavior), simply specify the `owner` field.

## User Options

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `username` | string | Yes | Username |
| `password` | string | No | Plain password (not recommended) |
| `existingSecret` | string | No | Kubernetes Secret name (recommended) |
| `existingSecretKey` | string | No | Key in secret (default: "password") |
| `databases` | array | No | List of databases to grant access to |
| `privileges` | string | No | Privileges to grant (default: ALL) |
| `superuser` | boolean | No | PostgreSQL superuser (default: false) |
| `createdb` | boolean | No | Can create databases (default: false) |
| `createrole` | boolean | No | Can create roles (default: false) |
| `replication` | boolean | No | Can perform replication (default: false) |

## Privilege Types

Supported privilege values:
- `ALL` - Full access to the database
- `SELECT` - Read-only access
- `INSERT` - Insert permission
- `UPDATE` - Update permission
- `DELETE` - Delete permission
- `TRUNCATE` - Truncate permission
- `REFERENCES` - References permission
- `TRIGGER` - Trigger permission
- `CREATE` - Create permission
- `CONNECT` - Connection permission
- `TEMPORARY` - Temporary objects permission
- `EXECUTE` - Execute permission

Multiple privileges: `privileges: "SELECT, INSERT, UPDATE"`

## Generated SQL

The chart automatically generates idempotent SQL scripts:

### Database Creation (`01-databases.sql`)

```sql
-- Create database: myapp_db
SELECT 'CREATE DATABASE myapp_db OWNER myapp_user ENCODING 'UTF8' LC_COLLATE 'en_US.UTF-8' LC_CTYPE 'en_US.UTF-8' TEMPLATE template0'
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'myapp_db');
\gexec
```

### User Creation (`02-users.sql`)

```sql
-- Create user: myapp_user
DO $$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_catalog.pg_user WHERE usename = 'myapp_user') THEN
    CREATE USER myapp_user NOSUPERUSER NOCREATEDB NOCREATEROLE NOREPLICATION;
  END IF;
END
$$;

-- Update password from secret
ALTER USER myapp_user WITH PASSWORD 'xxx';

-- Grant privileges
GRANT ALL ON DATABASE myapp_db TO myapp_user;
```

## Security Best Practices

1. **Never commit passwords** to version control
2. **Always use existingSecret** for production environments
3. **Grant minimal privileges** required for each user
4. **Use separate users** for different applications/services
5. **Enable audit logging** with pgaudit extension
6. **Use scram-sha-256** authentication (default)
7. **Review generated SQL** before deploying to production

## Use Cases

### Multi-Tenant Application

See `examples/values-multitenant.yaml` for a complete example with:
- Multiple tenant databases
- Separate users per tenant
- Shared database for common data
- Read-only analytics user
- Proper privilege separation

### Microservices Architecture

```yaml
postgresql:
  additionalDatabases:
    - name: users_service_db
      owner: users_svc
    - name: orders_service_db
      owner: orders_svc
    - name: inventory_service_db
      owner: inventory_svc

  additionalUsers:
    - username: users_svc
      existingSecret: users-svc-db-secret
      databases: [users_service_db]
      privileges: ALL

    - username: orders_svc
      existingSecret: orders-svc-db-secret
      databases: [orders_service_db]
      privileges: ALL

    - username: inventory_svc
      existingSecret: inventory-svc-db-secret
      databases: [inventory_service_db]
      privileges: ALL
```

### Development vs Production

**Development** (use plain passwords for convenience):
```yaml
postgresql:
  additionalUsers:
    - username: dev_user
      password: dev_password  # OK for dev
      databases: [dev_db]
      privileges: ALL
```

**Production** (use secrets):
```yaml
postgresql:
  additionalUsers:
    - username: prod_user
      existingSecret: prod-user-secret  # Required
      databases: [prod_db]
      privileges: ALL
```

## GitOps Workflow

1. Store database/user definitions in Git
2. Create ConfigMaps/Secrets via CI/CD
3. Reference in Helm values
4. Chart reads from Kubernetes resources at install time
5. Changes tracked in version control
6. Separate credentials from configuration

## Troubleshooting

### Databases not created

Check init scripts ConfigMap:
```bash
kubectl get configmap <release>-postgresql-init-scripts -o yaml
```

View logs during initialization:
```bash
kubectl logs <pod-name> -c postgresql
```

### Users not created

Verify secrets exist:
```bash
kubectl get secret <secret-name>
```

Check SQL generation:
```bash
helm template . -f values.yaml --show-only templates/configmap.yaml | grep -A 50 "02-users.sql"
```

### Passwords not working

Ensure password is read from correct secret key:
```yaml
additionalUsers:
  - username: myuser
    existingSecret: my-secret
    existingSecretKey: password  # Must match secret key
```

### External resources not found

Verify namespace:
```yaml
externalResources:
  usersConfigMap:
    name: postgresql-users
    namespace: default  # Must match where ConfigMap exists
```

Check if lookup is enabled (requires Helm --lookup flag).

## Testing

Test the configuration locally:
```bash
# Generate templates
helm template my-release . -f values.yaml

# Check specific ConfigMap
helm template my-release . -f values.yaml --show-only templates/configmap.yaml

# Validate SQL
helm template my-release . -f values.yaml --show-only templates/configmap.yaml | grep -A 100 "01-databases.sql"
```

## Files Modified

- `values.yaml` - Added `additionalDatabases`, `additionalUsers`, `externalResources` parameters
- `templates/_helpers.tpl` - Added `postgresql.databaseSQL` and `postgresql.userSQL` helper functions
- `templates/configmap.yaml` - Updated to generate database/user init scripts
- `templates/NOTES.txt` - Added warnings and info about created resources
- `values.schema.json` - Added JSON schema validation for new parameters
- `Chart.yaml` - Version bumped to 1.3.0, changelog updated
- `README.md` - Comprehensive documentation added

## Examples

- `examples/values-multitenant.yaml` - Multi-tenant setup
- `examples/values-external-resources.yaml` - External ConfigMap/Secret usage
- `examples/external-databases-configmap.yaml` - Database definitions
- `examples/external-users-configmap.yaml` - User definitions
- `examples/external-users-secret.yaml` - User passwords
