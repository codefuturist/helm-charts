# Dynamic User Management Example

This example demonstrates how to add PostgreSQL users and databases without restarting the PostgreSQL pod.

## Overview

The chart includes a CronJob-based user synchronization feature that:
- Periodically checks for new user/database definitions
- Executes SQL scripts to create missing resources
- Does NOT require pod restart
- Uses idempotent SQL (safe to run multiple times)

## Setup

### 1. Create a ConfigMap with SQL Scripts

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: postgres-user-sync-scripts
  namespace: postgres-test
data:
  # Users are created first
  01-sync-users.sql: |
    -- Create user if not exists
    DO $$
    BEGIN
      IF NOT EXISTS (SELECT FROM pg_catalog.pg_user WHERE usename = 'newuser') THEN
        CREATE USER newuser NOSUPERUSER NOCREATEDB NOCREATEROLE NOREPLICATION;
        -- Set password from secret
        ALTER USER newuser WITH PASSWORD 'changeme';
      END IF;
    END
    $$;

    DO $$
    BEGIN
      IF NOT EXISTS (SELECT FROM pg_catalog.pg_user WHERE usename = 'app_reader') THEN
        CREATE USER app_reader NOSUPERUSER NOCREATEDB NOCREATEROLE NOREPLICATION;
        ALTER USER app_reader WITH PASSWORD 'reader123';
      END IF;
    END
    $$;

  # Databases are created after users
  02-sync-databases.sql: |
    -- Create databases if not exist
    SELECT 'CREATE DATABASE newdb OWNER newuser'
    WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'newdb');
    \gexec

    SELECT 'CREATE DATABASE reports OWNER postgres'
    WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'reports');
    \gexec

  # Grants are applied last
  03-sync-grants.sql: |
    -- Grant privileges (these are idempotent)
    GRANT ALL ON DATABASE newdb TO newuser;
    GRANT SELECT ON DATABASE reports TO app_reader;

    -- Connect to specific database to grant table permissions
    \c newdb
    GRANT ALL ON SCHEMA public TO newuser;
    GRANT ALL ON ALL TABLES IN SCHEMA public TO newuser;
    GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO newuser;

    \c reports
    GRANT USAGE ON SCHEMA public TO app_reader;
    GRANT SELECT ON ALL TABLES IN SCHEMA public TO app_reader;
```

Apply it:
```bash
kubectl apply -f user-sync-configmap.yaml
```

### 2. Enable Dynamic Sync in Helm Values

```yaml
userManagement:
  dynamicSync:
    enabled: true
    schedule: "*/15 * * * *"  # Run every 15 minutes
    configMapName: "postgres-user-sync-scripts"
```

### 3. Install/Upgrade the Chart

```bash
helm upgrade postgres . \
  --set userManagement.dynamicSync.enabled=true \
  --set userManagement.dynamicSync.configMapName=postgres-user-sync-scripts
```

## Manual Trigger

You can manually trigger the sync job without waiting for the cron schedule:

```bash
# Create a one-time job from the CronJob
kubectl create job --from=cronjob/postgres-user-sync manual-sync-1 -n postgres-test

# Watch the job
kubectl get jobs -n postgres-test -w

# Check logs
kubectl logs job/manual-sync-1 -n postgres-test
```

## Using Kubernetes Secrets for Passwords

For production, don't hardcode passwords in ConfigMaps. Instead:

### 1. Create Secrets First

```bash
kubectl create secret generic newuser-secret \
  -n postgres-test \
  --from-literal=password='secure-password-here'

kubectl create secret generic app-reader-secret \
  -n postgres-test \
  --from-literal=password='reader-secure-pass'
```

### 2. Mount Secrets in CronJob

Update the CronJob template to mount secrets and read passwords:

```yaml
userManagement:
  dynamicSync:
    enabled: true
    configMapName: "postgres-user-sync-scripts"
    secrets:
      - name: newuser-secret
      - name: app-reader-secret
```

### 3. Update SQL Script to Read from Environment

```sql
-- Read password from file mounted from secret
DO $$
DECLARE
  user_password text;
BEGIN
  IF NOT EXISTS (SELECT FROM pg_catalog.pg_user WHERE usename = 'newuser') THEN
    -- Read password from mounted secret
    user_password := pg_read_file('/secrets/newuser-secret/password');
    EXECUTE format('CREATE USER newuser WITH PASSWORD %L', user_password);
  END IF;
END
$$;
```

## Using Annotations for Kubernetes-Native Updates

Instead of ConfigMaps, you can use annotations on a ConfigMap to trigger updates:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: postgres-users
  namespace: postgres-test
  annotations:
    postgresql.example.com/sync-version: "2"  # Increment to trigger sync
data:
  users.yaml: |
    - username: newuser
      databases: [newdb]
      privileges: ALL
    - username: app_reader
      databases: [reports]
      privileges: SELECT
```

The CronJob can watch for changes in the annotation version.

## Best Practices

1. **Idempotent Scripts**: Always use `IF NOT EXISTS` checks
2. **Password Management**: Use Kubernetes Secrets, not ConfigMaps
3. **Testing**: Test SQL scripts manually before adding to ConfigMap
4. **Monitoring**: Check CronJob logs regularly
5. **Backup**: Take backups before bulk user changes
6. **RBAC**: Grant minimal permissions to sync job ServiceAccount

## Verification

```bash
# Check if new users exist
kubectl exec -n postgres-test deploy/postgres -c postgresql -- \
  psql -U postgres -c '\du'

# Check if new databases exist
kubectl exec -n postgres-test deploy/postgres -c postgresql -- \
  psql -U postgres -c '\l'

# Test connecting as new user
kubectl exec -n postgres-test deploy/postgres -c postgresql -- \
  bash -c 'PGPASSWORD=changeme psql -U newuser -d newdb -c "SELECT current_user;"'
```

## Troubleshooting

```bash
# View CronJob status
kubectl get cronjob -n postgres-test

# View recent job runs
kubectl get jobs -n postgres-test

# Check job logs
kubectl logs -n postgres-test -l job-name=<job-name>

# Manually test SQL script
kubectl exec -n postgres-test deploy/postgres -c postgresql -- \
  psql -U postgres -f /path/to/script.sql
```

## Limitations

- CronJob runs on schedule (minimum 1 minute intervals)
- For immediate updates, trigger manually with `kubectl create job`
- Complex permission changes may require multiple sync cycles
- Password changes require users to reconnect
