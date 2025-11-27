# Home Assistant Installation on k3s-prod

Secure, non-privileged deployment of Home Assistant following Kubernetes best practices.

## Prerequisites

- Kubernetes cluster (k3s-prod) with kubectl access
- Helm 3.x installed
- Ingress controller (nginx) configured
- cert-manager for TLS certificates (optional)
- OpenEBS storage provisioner installed (e.g., openebs-hostpath, openebs-lvmpv)

## Security Configuration

This deployment uses **non-privileged** mode with specific Linux capabilities:

- ✅ `privileged: false` - Container does not run with all host privileges
- ✅ `runAsUser: 0` - Runs as root (required for Home Assistant device access)
- ✅ `allowPrivilegeEscalation: false` - Cannot gain more privileges
- ✅ `capabilities.drop: [ALL]` - Drops all default capabilities
- ✅ `capabilities.add: [NET_ADMIN, NET_RAW]` - Adds only required capabilities:
  - `NET_ADMIN`: For network discovery (SSDP, mDNS, device scanning)
  - `NET_RAW`: For ping integration and network scanning
- ✅ `seccompProfile: RuntimeDefault` - Applies seccomp security profile

### Why Not Privileged?

Privileged mode grants extensive permissions and is a security risk:
- Full access to host devices
- Can modify kernel parameters
- Bypasses many security restrictions

Most Home Assistant use cases work perfectly with specific capabilities instead.

## Installation Methods

### Method 1: Automated Script (Recommended)

```bash
cd /Users/colin/Developer/Projects/personal/helm-charts
./charts/home-assistant/install-k3s-prod.sh
```

The script will:
1. Validate the chart
2. Run dry-run and verify no privileged mode
3. Prompt for confirmation
4. Install Home Assistant
5. Verify security configuration

### Method 2: Manual Installation

1. **Edit the values file** (`charts/home-assistant/values-k3s-prod.yaml`):
   - Update `ingress.hosts[0].host` to your domain
   - Update `ingress.tls[0].hosts[0]` to your domain
   - Set `homeassistant.env.TZ` to your timezone
   - Verify `persistence.config.storageClassName` matches your OpenEBS storage class
     (Run `kubectl get sc | grep openebs` to see available options)

2. **Validate the chart**:
   ```bash
   helm lint charts/home-assistant --values charts/home-assistant/values-k3s-prod.yaml
   ```

3. **Test rendering** (verify security):
   ```bash
   helm template test-ha charts/home-assistant \
     -f charts/home-assistant/values-k3s-prod.yaml \
     | grep -A 10 "securityContext:"
   ```

4. **Install**:
   ```bash
   helm upgrade --install home-assistant charts/home-assistant \
     --namespace home-assistant \
     --create-namespace \
     --values charts/home-assistant/values-k3s-prod.yaml \
     --wait \
     --timeout 10m
   ```

5. **Verify**:
   ```bash
   kubectl get pods -n home-assistant
   kubectl get svc -n home-assistant
   kubectl get ingress -n home-assistant
   ```

6. **Check security context**:
   ```bash
   kubectl get pod -n home-assistant -l app.kubernetes.io/name=home-assistant \
     -o jsonpath='{.spec.containers[0].securityContext}' | jq '.'
   ```

   Should show:
   ```json
   {
     "allowPrivilegeEscalation": false,
     "capabilities": {
       "add": ["NET_ADMIN", "NET_RAW"],
       "drop": ["ALL"]
     },
     "privileged": false,
     "readOnlyRootFilesystem": false
   }
   ```

## Post-Installation

### Access Home Assistant

1. **Via Ingress** (if configured):
   ```bash
   https://homeassistant.example.com
   ```

2. **Via Port Forward** (local testing):
   ```bash
   kubectl port-forward -n home-assistant svc/home-assistant 8123:8123
   ```
   Then access: http://localhost:8123

### View Logs

```bash
kubectl logs -n home-assistant -l app.kubernetes.io/name=home-assistant -f
```

### Complete Onboarding

1. Open Home Assistant web interface
2. Create your account
3. Configure your home location
4. Add integrations (devices, services)

## Troubleshooting

### Pod CrashLoopBackOff

```bash
# Check logs
kubectl logs -n home-assistant -l app.kubernetes.io/name=home-assistant

# Check events
kubectl describe pod -n home-assistant -l app.kubernetes.io/name=home-assistant
```

### Permissions Issues

If you encounter device access issues:

1. First try adding `SYS_ADMIN` capability (still non-privileged):
   ```yaml
   securityContext:
     capabilities:
       add:
         - NET_ADMIN
         - NET_RAW
         - SYS_ADMIN  # Add this
   ```

2. If still not working, check if specific hardware requires host access (rare):
   ```yaml
   hostNetwork: true  # For devices requiring host network
   ```

3. **Last resort only**: If absolutely necessary for specific hardware:
   ```yaml
   securityContext:
     privileged: true
     capabilities:
       add: []  # Remove specific capabilities, privileged grants all
   ```

### Storage Issues

```bash
# Check PVC status
kubectl get pvc -n home-assistant

# If pending, check storage class
kubectl get sc

# Describe PVC for events
kubectl describe pvc -n home-assistant
```

## Updating Home Assistant

```bash
# Update to specific version
helm upgrade home-assistant charts/home-assistant \
  --namespace home-assistant \
  --values charts/home-assistant/values-k3s-prod.yaml \
  --set image.tag=2024.12.0 \
  --wait

# Or edit values-k3s-prod.yaml and upgrade
helm upgrade home-assistant charts/home-assistant \
  --namespace home-assistant \
  --values charts/home-assistant/values-k3s-prod.yaml
```

## Uninstallation

```bash
# Uninstall release
helm uninstall home-assistant -n home-assistant

# Delete namespace (WARNING: This deletes PVCs if not using retain policy)
kubectl delete namespace home-assistant
```

## Security Best Practices

✅ **Implemented**:
- Non-privileged containers
- Minimal capabilities (NET_ADMIN, NET_RAW only)
- Seccomp profile enabled
- Drop all default capabilities
- No privilege escalation
- Resource limits set
- Health probes configured

⚠️ **Consider Adding**:
- Network policies (restrict pod communication)
- Pod Security Standards (enforce via admission controller)
- Backup automation (for config persistence)
- Monitoring and alerting

## Additional Configuration

### Enable PostgreSQL Database

Edit `values-k3s-prod.yaml`:
```yaml
database:
  type: postgresql
  postgresql:
    host: postgresql.default.svc.cluster.local
    port: 5432
    database: homeassistant
    username: homeassistant
    existingSecret: homeassistant-db-secret
    passwordKey: password
```

### Enable Code Server (VSCode)

Edit `values-k3s-prod.yaml`:
```yaml
codeserver:
  enabled: true
  ingress:
    enabled: true
    hosts:
      - host: ha-code.example.com
```

### Add Media Storage

Edit `values-k3s-prod.yaml`:
```yaml
persistence:
  media:
    enabled: true
    storageClassName: longhorn
    size: 50Gi
```

## Resources

- [Home Assistant Documentation](https://www.home-assistant.io/docs/)
- [Kubernetes Security Best Practices](https://kubernetes.io/docs/concepts/security/pod-security-standards/)
- [Linux Capabilities](https://man7.org/linux/man-pages/man7/capabilities.7.html)
