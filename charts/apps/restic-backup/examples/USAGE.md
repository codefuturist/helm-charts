# Restic Backup Chart - Usage Examples

This document provides practical examples for common backup scenarios.

## Table of Contents

- [Basic Examples](#basic-examples)
- [Storage Backend Examples](#storage-backend-examples)
- [Advanced Scenarios](#advanced-scenarios)
- [Database Backups](#database-backups)
- [Restore Operations](#restore-operations)

## Basic Examples

### Example 1: Single Volume Backup

Back up a single application PVC to S3:

```yaml
restic:
  repository: "s3:s3.amazonaws.com/my-backups/myapp"
  password: "secure-password"
  backendEnv:
    AWS_ACCESS_KEY_ID: "AKIAIOSFODNN7EXAMPLE"
    AWS_SECRET_ACCESS_KEY: "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
    AWS_DEFAULT_REGION: "us-east-1"

volumes:
  - name: app-data
    claimName: myapp-pvc
    mountPath: /data
```

### Example 2: Using Existing Secret

```bash
# Create secret
kubectl create secret generic restic-creds -n backups \
  --from-literal=RESTIC_REPOSITORY="s3:s3.amazonaws.com/bucket/path" \
  --from-literal=RESTIC_PASSWORD="password" \
  --from-literal=AWS_ACCESS_KEY_ID="key" \
  --from-literal=AWS_SECRET_ACCESS_KEY="secret" \
  --from-literal=AWS_DEFAULT_REGION="us-east-1"
```

```yaml
restic:
  existingSecret: "restic-creds"

volumes:
  - name: app-data
    claimName: myapp-pvc
    mountPath: /data
```

### Example 3: Custom Schedule and Retention

```yaml
restic:
  repository: "s3:s3.amazonaws.com/backups/app"
  password: "password"

  backup:
    schedule: "0 3 * * *" # 3 AM daily
    retention:
      enabled: true
      keepLast: 10
      keepDaily: 30
      keepWeekly: 12
      keepMonthly: 24
      keepYearly: 7

volumes:
  - name: data
    claimName: app-pvc
    mountPath: /data
```

## Storage Backend Examples

### AWS S3 with IAM Role (IRSA)

```yaml
restic:
  repository: "s3:s3.amazonaws.com/my-bucket/backups"
  password: "encryption-password"

serviceAccount:
  create: true
  annotations:
    eks.amazonaws.com/role-arn: "arn:aws:iam::123456789012:role/restic-backup"

volumes:
  - name: data
    claimName: app-pvc
    mountPath: /data
```

### Azure Blob with Managed Identity

```yaml
restic:
  repository: "azure:my-container:/backups"
  password: "encryption-password"

serviceAccount:
  annotations:
    azure.workload.identity/client-id: "client-id"
    azure.workload.identity/tenant-id: "tenant-id"

volumes:
  - name: data
    claimName: app-pvc
    mountPath: /data
```

### MinIO (On-Premise S3)

```yaml
restic:
  repository: "s3:minio.example.com:9000/backups/kubernetes"
  password: "encryption-password"
  backendEnv:
    AWS_ACCESS_KEY_ID: "minioadmin"
    AWS_SECRET_ACCESS_KEY: "minioadmin"
    AWS_S3_ENDPOINT: "https://minio.example.com:9000"

volumes:
  - name: data
    claimName: app-pvc
    mountPath: /data
```

### SFTP Server

```yaml
restic:
  repository: "sftp:backupuser@backup-server.example.com:/backups/k8s"
  password: "encryption-password"

# Mount SSH key
extraVolumes:
  - name: ssh-key
    secret:
      secretName: backup-ssh-key
      defaultMode: 0600

extraVolumeMounts:
  - name: ssh-key
    mountPath: /root/.ssh/id_rsa
    subPath: id_rsa
    readOnly: true

volumes:
  - name: data
    claimName: app-pvc
    mountPath: /data
```

## Advanced Scenarios

### Multiple Applications in One Backup

```yaml
restic:
  repository: "s3:s3.amazonaws.com/backups/cluster"
  password: "password"

volumes:
  - name: webapp
    claimName: webapp-pvc
    mountPath: /volumes/webapp

  - name: api
    claimName: api-pvc
    mountPath: /volumes/api

  - name: worker
    claimName: worker-pvc
    mountPath: /volumes/worker

cronjob:
  resources:
    limits:
      cpu: 2000m
      memory: 1Gi
```

### Backup with Exclusions

```yaml
restic:
  repository: "s3:s3.amazonaws.com/backups/app"
  password: "password"

  backup:
    excludes:
      - "*.log"
      - "*.tmp"
      - "*.cache"
      - "/data/temp/*"
      - "/data/sessions/*"
      - ".git/*"
      - "node_modules/*"

volumes:
  - name: data
    claimName: app-pvc
    mountPath: /data
```

### Backup with Tags

```yaml
restic:
  repository: "s3:s3.amazonaws.com/backups/multi"
  password: "password"

  backup:
    tags:
      - environment:production
      - app:myapp
      - team:platform
      - backup-type:automated
      - cluster:prod-1

volumes:
  - name: data
    claimName: app-pvc
    mountPath: /data
```

### Network-Isolated Backup

```yaml
restic:
  repository: "s3:s3.amazonaws.com/backups/secure"
  password: "password"

networkPolicy:
  enabled: true
  egress:
    # Allow DNS
    - to:
        - namespaceSelector:
            matchLabels:
              name: kube-system
      ports:
        - protocol: UDP
          port: 53
    # Allow only S3
    - to:
        - ipBlock:
            cidr: 52.216.0.0/15 # S3 IP range
      ports:
        - protocol: TCP
          port: 443

volumes:
  - name: data
    claimName: app-pvc
    mountPath: /data
```

## Database Backups

### PostgreSQL Backup

```yaml
restic:
  repository: "s3:s3.amazonaws.com/backups/postgres"
  password: "password"

volumes:
  - name: pgdata
    claimName: postgres-data
    mountPath: /pgdata
  - name: backup-staging
    claimName: backup-staging-pvc
    mountPath: /backup

hooks:
  preBackup:
    - name: postgres-dump
      image: postgres:16-alpine
      command: ["/bin/sh", "-c"]
      args:
        - |
          pg_dump -h postgres-service -U postgres -d mydb \
            -f /backup/dump.sql
          pg_dumpall -h postgres-service -U postgres \
            -f /backup/dumpall.sql
      env:
        - name: PGPASSWORD
          valueFrom:
            secretKeyRef:
              name: postgres-secret
              key: password
      volumeMounts:
        - name: backup-staging
          mountPath: /backup

  postBackup:
    - name: cleanup-dumps
      image: busybox
      command: ["rm", "-f"]
      args:
        - /backup/dump.sql
        - /backup/dumpall.sql
      volumeMounts:
        - name: backup-staging
          mountPath: /backup
```

### MySQL Backup

```yaml
restic:
  repository: "s3:s3.amazonaws.com/backups/mysql"
  password: "password"

volumes:
  - name: mysql-data
    claimName: mysql-data
    mountPath: /var/lib/mysql
  - name: backup-staging
    claimName: backup-staging-pvc
    mountPath: /backup

hooks:
  preBackup:
    - name: mysql-dump
      image: mysql:8.0
      command: ["/bin/sh", "-c"]
      args:
        - |
          mysqldump -h mysql-service -u root -p${MYSQL_ROOT_PASSWORD} \
            --all-databases --single-transaction \
            > /backup/all-databases.sql
      env:
        - name: MYSQL_ROOT_PASSWORD
          valueFrom:
            secretKeyRef:
              name: mysql-secret
              key: root-password
      volumeMounts:
        - name: backup-staging
          mountPath: /backup
```

### MongoDB Backup

```yaml
restic:
  repository: "s3:s3.amazonaws.com/backups/mongodb"
  password: "password"

volumes:
  - name: mongo-data
    claimName: mongodb-data
    mountPath: /data/db
  - name: backup-staging
    claimName: backup-staging-pvc
    mountPath: /backup

hooks:
  preBackup:
    - name: mongodump
      image: mongo:7.0
      command: ["/bin/sh", "-c"]
      args:
        - |
          mongodump --host mongodb-service \
            --username admin \
            --password ${MONGO_PASSWORD} \
            --authenticationDatabase admin \
            --out /backup/mongodump
      env:
        - name: MONGO_PASSWORD
          valueFrom:
            secretKeyRef:
              name: mongodb-secret
              key: password
      volumeMounts:
        - name: backup-staging
          mountPath: /backup
```

## Restore Operations

### Restore Latest Snapshot

```yaml
restore:
  enabled: true
  snapshotId: "latest"
  targetVolume: "restore-pvc"
  targetPath: "/"
  verify: true
```

Deploy and check:

```bash
helm upgrade restic-backup . -f values.yaml
kubectl logs -n backups -l app.kubernetes.io/component=restore-job -f
```

### Restore Specific Snapshot

```bash
# List snapshots
kubectl run restic-list -n backups -it --rm \
  --image=restic/restic:0.17.3 \
  --env=RESTIC_REPOSITORY="s3:s3.amazonaws.com/bucket/path" \
  --env=RESTIC_PASSWORD="password" \
  -- restic snapshots

# Note the snapshot ID (e.g., abc123de)
```

```yaml
restore:
  enabled: true
  snapshotId: "abc123de"
  targetVolume: "restore-pvc"
  targetPath: "/"
  verify: true
```

### Restore to Different Namespace

```bash
# Install in restore namespace
helm install restic-restore codefuturist/restic-backup \
  --namespace restore \
  --create-namespace \
  --set restore.enabled=true \
  --set restore.snapshotId=latest \
  --set restore.targetVolume=restored-data-pvc \
  --set restic.existingSecret=restic-creds
```

### Partial Restore

Use restic directly for partial restores:

```bash
kubectl run restic-restore -n backups -it --rm \
  --image=restic/restic:0.17.3 \
  --env=RESTIC_REPOSITORY="s3:..." \
  --env=RESTIC_PASSWORD="..." \
  -- restic restore latest \
  --target /restore \
  --include /app/config \
  --include /app/data/important
```

## Monitoring and Notifications

### Slack Notifications

```yaml
notifications:
  enabled: true
  webhook:
    url: "https://hooks.slack.com/services/T00/B00/XXX"
```

### Prometheus Monitoring

```yaml
serviceMonitor:
  enabled: true
  additionalLabels:
    release: prometheus-stack
  interval: 30s


# Create PrometheusRule for alerts
---
apiVersion: monitoring.coreos.com/v1
kind: PrometheusRule
metadata:
  name: restic-backup-alerts
spec:
  groups:
    - name: restic-backup
      rules:
        - alert: ResticBackupFailed
          expr: kube_job_status_failed{job_name=~"restic-backup.*"} > 0
          for: 5m
          labels:
            severity: critical
          annotations:
            summary: "Restic backup job failed"
```

## Tips and Best Practices

1. **Test your backups**: Always verify restore procedures
2. **Use external secrets**: Don't store credentials in values files
3. **Enable notifications**: Get alerted on backup failures
4. **Monitor disk space**: Track repository growth
5. **Schedule wisely**: Run backups during low-traffic periods
6. **Use read-only mounts**: Safer for production volumes
7. **Tag your backups**: Makes finding snapshots easier
8. **Regular checks**: Schedule repository integrity checks
9. **Retention policy**: Balance storage cost vs recovery needs
10. **Document procedures**: Maintain restore runbooks
