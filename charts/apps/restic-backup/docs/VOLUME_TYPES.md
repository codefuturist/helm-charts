# Volume Types and Configuration

The Restic Backup Helm chart supports multiple volume types to accommodate different backup scenarios. This guide explains each type and when to use it.

## Supported Volume Types

### 1. PersistentVolumeClaim (PVC) - Default

The most common volume type for backing up Kubernetes persistent storage.

**Configuration:**

```yaml
volumes:
  - name: app-data
    type: pvc # Optional, PVC is default
    claimName: myapp-data-pvc
    mountPath: /data/app
    subPath: "" # Optional: backup specific subdirectory
    readOnly: false # Optional: mount read-only for safety
```

**When to use:**

- Backing up application data stored in PVCs
- Standard Kubernetes storage backup scenarios
- When you have existing PersistentVolumeClaims

**Example:**

```yaml
volumes:
  - name: postgres-data
    claimName: postgres-pvc
    mountPath: /pgdata
    readOnly: true # Read-only for database safety
```

---

### 2. HostPath - Direct Host Directory Access

Access and backup directories directly from the Kubernetes node filesystem.

**Configuration:**

```yaml
volumes:
  - name: host-data
    type: hostPath
    hostPath:
      path: /mnt/data # Path on the host
      type: Directory # Optional: Directory, DirectoryOrCreate, File, etc.
    mountPath: /backup/host-data
    readOnly: true # Recommended for safety
```

**HostPath types:**

- `Directory` - Must exist on host
- `DirectoryOrCreate` - Create if doesn't exist
- `File` - Must be a file
- `FileOrCreate` - Create file if doesn't exist
- `Socket` - UNIX socket
- `CharDevice` - Character device
- `BlockDevice` - Block device

**When to use:**

- Backing up Docker volumes (`/var/lib/docker/volumes`)
- Accessing host-mounted storage
- Backing up node-specific data
- Legacy applications with host path storage

**Important considerations:**

- Requires appropriate pod security context (may need root)
- Pod must be scheduled on the correct node
- Use node selectors or node affinity
- Set `readOnly: true` when possible

**Complete example:**

```yaml
restic:
  repository: "s3:s3.amazonaws.com/my-backups/host-data"
  password: "secure-password"

volumes:
  - name: docker-volumes
    type: hostPath
    hostPath:
      path: /var/lib/docker/volumes
      type: Directory
    mountPath: /backup/docker
    readOnly: true

cronjob:
  # Ensure backup runs on specific node
  nodeSelector:
    kubernetes.io/hostname: backup-node

# May need elevated permissions
podSecurityContext:
  runAsUser: 0
  runAsGroup: 0
  fsGroup: 0
  runAsNonRoot: false
```

---

### 3. EmptyDir - Temporary Workspace

Ephemeral storage for backup operations, useful as temporary workspace.

**Configuration:**

```yaml
volumes:
  - name: temp-workspace
    type: emptyDir
    emptyDir:
      sizeLimit: 2Gi # Optional: limit storage size
      medium: "" # Optional: "" (disk) or "Memory" (tmpfs)
    mountPath: /tmp/backup-work
```

**When to use:**

- Temporary decompression space
- Intermediate backup processing
- Scratch space for backup scripts
- Testing and development

**Example with memory-backed storage:**

```yaml
volumes:
  - name: fast-temp
    type: emptyDir
    emptyDir:
      medium: "Memory" # Use RAM
      sizeLimit: 1Gi
    mountPath: /tmp/fast-space
```

---

### 4. ConfigMap - Configuration Files

Mount ConfigMaps as volumes for backup configuration or scripts.

**Configuration:**

```yaml
volumes:
  - name: backup-config
    type: configMap
    configMap:
      name: backup-settings
      defaultMode: 0644 # Optional: file permissions
      items: # Optional: select specific keys
        - key: config.json
          path: config.json
    mountPath: /config
```

**When to use:**

- Backing up configuration alongside data
- Providing configuration to pre/post backup hooks
- Include application settings in backups

**Example:**

```yaml
volumes:
  - name: app-config
    type: configMap
    configMap:
      name: myapp-config
    mountPath: /backup/config
```

---

### 5. Secret - Sensitive Data

Mount Kubernetes Secrets for backup (use carefully).

**Configuration:**

```yaml
volumes:
  - name: backup-credentials
    type: secret
    secret:
      secretName: app-secrets
      defaultMode: 0400 # Optional: file permissions
      items: # Optional: select specific keys
        - key: database.key
          path: db.key
    mountPath: /secrets
```

**When to use:**

- Including encrypted credentials in backups
- Providing secrets to backup hooks
- Backing up certificate stores

**Security warning:**

- Secrets will be written to backup repository
- Ensure backup repository is properly encrypted and secured
- Consider using External Secrets Operator instead

---

### 6. Custom - Advanced Volume Types

Support for any Kubernetes volume type using custom specification.

**Configuration:**

```yaml
volumes:
  - name: custom-volume
    type: custom
    volumeSpec:
      nfs:
        server: nfs-server.example.com
        path: /exports/backup
    mountPath: /backup/nfs
```

**Supported via volumeSpec:**

- NFS
- CephFS
- GlusterFS
- iSCSI
- FC (Fibre Channel)
- AzureFile
- AzureDisk
- GCEPersistentDisk
- AWSElasticBlockStore
- Any other Kubernetes volume type

**NFS example:**

```yaml
volumes:
  - name: nfs-backup
    type: custom
    volumeSpec:
      nfs:
        server: 10.0.0.10
        path: /exports/backups
        readOnly: false
    mountPath: /backup/nfs
```

**CephFS example:**

```yaml
volumes:
  - name: ceph-data
    type: custom
    volumeSpec:
      cephfs:
        monitors:
          - 10.0.0.11:6789
          - 10.0.0.12:6789
        path: /volumes
        user: admin
        secretRef:
          name: ceph-secret
    mountPath: /backup/ceph
```

---

## Using Local Storage for Backups

Store restic repository on a dedicated local PV instead of cloud storage.

**Step 1: Create dedicated PVC for backup repository**

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: restic-backup-repo-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 100Gi
  storageClassName: fast-ssd
```

**Step 2: Configure backup to use local repository**

```yaml
restic:
  repository: "/backup-repo" # Local path
  password: "secure-password"

volumes:
  - name: app-data
    claimName: myapp-pvc
    mountPath: /data

# Mount the backup repository PVC
extraVolumes:
  - name: backup-repository
    persistentVolumeClaim:
      claimName: restic-backup-repo-pvc

extraVolumeMounts:
  - name: backup-repository
    mountPath: /backup-repo
```

**Step 3 (Optional): Create PV with hostPath**

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: restic-backup-repo-pv
spec:
  capacity:
    storage: 100Gi
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: local-storage
  hostPath:
    path: /mnt/backup-storage
    type: DirectoryOrCreate
  nodeAffinity:
    required:
      nodeSelectorTerms:
        - matchExpressions:
            - key: kubernetes.io/hostname
              operator: In
              values:
                - backup-node
```

See `examples/dedicated-pv-backup-values.yaml` for complete configuration.

---

## Restore with Different Volume Types

The restore job also supports multiple volume types:

**Restore to PVC:**

```yaml
restore:
  enabled: true
  snapshotId: "latest"
  targetVolume: "restore-pvc" # Simple syntax
```

**Restore to HostPath:**

```yaml
restore:
  enabled: true
  snapshotId: "latest"
  targetVolumeConfig:
    type: hostPath
    hostPath:
      path: /mnt/restore
      type: DirectoryOrCreate
```

**Restore to Custom Volume:**

```yaml
restore:
  enabled: true
  targetVolumeConfig:
    type: custom
    volumeSpec:
      nfs:
        server: nfs-restore.example.com
        path: /restore
```

---

## Common Patterns

### Pattern 1: Mixed Volume Types

```yaml
volumes:
  # Application PVC
  - name: app-data
    claimName: myapp-pvc
    mountPath: /data/app

  # Host directory
  - name: host-logs
    type: hostPath
    hostPath:
      path: /var/log/myapp
      type: Directory
    mountPath: /data/logs
    readOnly: true

  # Temporary workspace
  - name: temp
    type: emptyDir
    emptyDir:
      sizeLimit: 1Gi
    mountPath: /tmp/work
```

### Pattern 2: Backup to Local Storage

```yaml
restic:
  repository: "/backup-repo"
  password: "secure-password"

volumes:
  - name: source-data
    claimName: source-pvc
    mountPath: /data

extraVolumes:
  - name: backup-storage
    hostPath:
      path: /mnt/backups
      type: DirectoryOrCreate

extraVolumeMounts:
  - name: backup-storage
    mountPath: /backup-repo

cronjob:
  nodeSelector:
    kubernetes.io/hostname: storage-node
```

### Pattern 3: Multi-Node Backup

Use node affinity to backup different nodes:

```yaml
# Deploy multiple releases, one per node
restic:
  repository: "s3:s3.amazonaws.com/backups/node-01"
  password: "secure-password"

volumes:
  - name: node-data
    type: hostPath
    hostPath:
      path: /mnt/node-data
      type: Directory
    mountPath: /data

cronjob:
  nodeSelector:
    kubernetes.io/hostname: node-01
```

---

## Troubleshooting

### Volume Mount Issues

**Permission denied:**

```yaml
# May need elevated permissions for hostPath
podSecurityContext:
  runAsUser: 0
  runAsNonRoot: false
```

**Volume not found:**

- Check PVC exists: `kubectl get pvc`
- Verify HostPath exists on node
- Check node selector matches

**Read-only filesystem:**

```yaml
volumes:
  - name: data
    claimName: my-pvc
    mountPath: /data
    readOnly: false # Ensure not read-only if writing
```

### Examples Directory

Complete working examples available in `examples/`:

- `hostpath-backup-values.yaml` - HostPath configuration
- `dedicated-pv-backup-values.yaml` - Local PV storage
- `test-values.yaml` - PVC-based backup

---

## Best Practices

1. **Use read-only mounts when possible** - Prevents accidental data modification
2. **Set appropriate security contexts** - Especially for hostPath volumes
3. **Use node selectors for hostPath** - Ensure pods run on correct nodes
4. **Limit emptyDir size** - Prevent disk space exhaustion
5. **Secure backup repositories** - Whether cloud or local storage
6. **Test restore procedures** - Verify backups are restorable
7. **Monitor disk space** - Especially for local backup storage
8. **Use dedicated backup PVs** - Separate from application storage
