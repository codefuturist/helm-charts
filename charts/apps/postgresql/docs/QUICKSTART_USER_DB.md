# Quick Start: User and Database Management

## Simple Example (values.yaml)

```yaml
postgresql:
  database: "postgres"
  username: "postgres"

  # Create additional databases
  additionalDatabases:
    - name: myapp_db
      # owner automatically set to myapp_user (first user with ALL privileges)
      encoding: UTF8
    - name: shared_db
      # owner automatically set to myapp_user

  # Create additional users  
  additionalUsers:
    - username: myapp_user
      existingSecret: myapp-user-secret  # Create this secret first!
      databases:
        - myapp_db
        - shared_db
      privileges: ALL  # Gets ownership of myapp_db and shared_db
```

**Note:** Database ownership is automatically assigned to the first user with `ALL` privileges. You can override this by explicitly setting the `owner` field.

## Before Installing

Create the password secret:

```bash
kubectl create secret generic myapp-user-secret \
  --from-literal=password=YOUR_SECURE_PASSWORD
```

## Install

```bash
helm install my-postgresql . -f values.yaml
```

## Verify

```bash
# Check if init scripts were created
kubectl get configmap my-postgresql-init-scripts -o yaml

# Connect to PostgreSQL
export POSTGRES_PASSWORD=$(kubectl get secret my-postgresql -o jsonpath="{.data.postgresql-password}" | base64 -d)
kubectl run psql-client --rm -it --image=postgres:16.4-alpine --env="PGPASSWORD=$POSTGRES_PASSWORD" -- psql -h my-postgresql -U postgres

# Inside psql:
\l              # List databases (should see myapp_db)
\du             # List users (should see myapp_user)
\c myapp_db     # Connect to myapp_db
\dt             # List tables
```

## Common Patterns

### Read-Only User

```yaml
additionalUsers:
  - username: readonly_user
    existingSecret: readonly-secret
    databases:
      - myapp_db
    privileges: SELECT
```

### Multi-Database User

```yaml
additionalUsers:
  - username: admin_user
    existingSecret: admin-secret
    databases:
      - db1
      - db2
      - db3
    privileges: ALL
    createdb: true  # Can create more databases
```

### User with Multiple Privileges

```yaml
additionalUsers:
  - username: api_user
    existingSecret: api-secret
    databases:
      - myapp_db
    privileges: "SELECT, INSERT, UPDATE"  # No DELETE
```

## See More

- Full documentation: `USER_DATABASE_MANAGEMENT.md`
- Multi-tenant example: `examples/values-multitenant.yaml`
- External resources: `examples/values-external-resources.yaml`
