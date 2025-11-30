# Home Assistant Helm Chart - Test Suite

This directory contains comprehensive tests for the Home Assistant Helm chart following Kubernetes and Helm best practices.

## Test Overview

The test suite includes 9 automated test pods that validate different aspects of the deployment:

| Test | Purpose | When It Runs | Weight |
|------|---------|--------------|--------|
| `test-connection` | Basic service connectivity | Always | 0 (first) |
| `test-api` | Home Assistant API endpoint | Always | 1 |
| `test-persistence` | Volume mounts and write permissions | When persistence enabled | 2 |
| `test-database` | PostgreSQL connectivity | When PostgreSQL enabled | 3 |
| `test-ingress` | Ingress configuration | When ingress enabled | 4 |
| `test-rbac` | Service account and RBAC | Always | 5 |
| `test-codeserver` | Code-server sidecar | When code-server enabled | 6 |
| `test-mqtt` | MQTT broker | When MQTT enabled | 7 |
| `test-security` | Security context validation | Always | 8 |

## Running Tests

### Run All Tests

```bash
# After installing the chart
helm test home-assistant

# With detailed output
helm test home-assistant --logs
```

### Run Tests During Installation

```bash
# Install and test in one command
helm install home-assistant codefuturist/home-assistant --wait
helm test home-assistant
```

### Clean Up Test Pods

Test pods are automatically deleted after successful runs due to the `hook-delete-policy: before-hook-creation,hook-succeeded` annotation.

To manually clean up:

```bash
kubectl delete pod -l app.kubernetes.io/component=test -n <namespace>
```

## Test Details

### 1. Connection Test (`test-connection.yaml`)

**Purpose**: Validates basic service connectivity

**What it tests**:
- Service is reachable
- Port is correctly configured
- Basic network connectivity

**Expected outcome**: Successfully downloads index from service

**Runs when**: Always (baseline test)

### 2. API Test (`test-api.yaml`)

**Purpose**: Validates Home Assistant API endpoint

**What it tests**:
- Home Assistant web interface is responding
- HTTP status codes (200 or 401 expected)
- Service health after startup

**Expected outcome**: Receives 200 or 401 response from API

**Runs when**: Always (critical functionality test)

### 3. Persistence Test (`test-persistence.yaml`)

**Purpose**: Validates volume mounts and permissions

**What it tests**:
- Config volume is mounted
- Config volume is writable
- Media volume is mounted (if enabled)
- Backup volume is mounted (if enabled)

**Expected outcome**: All volumes accessible and writable

**Runs when**: `persistence.enabled=true`

**StatefulSet vs Deployment**: Automatically detects controller type and uses appropriate volume names

### 4. Database Test (`test-database.yaml`)

**Purpose**: Validates PostgreSQL connectivity

**What it tests**:
- Database connection succeeds
- Credentials are correct
- Database is accessible
- Can execute queries

**Expected outcome**: Successfully connects and queries database

**Runs when**: `database.type=postgresql`

**Requirements**: Database must be running and accessible

### 5. Ingress Test (`test-ingress.yaml`)

**Purpose**: Validates Ingress configuration

**What it tests**:
- Hosts are resolvable
- Ingress is configured
- HTTP endpoint responds

**Expected outcome**: Ingress configuration is valid (warnings okay if DNS not configured)

**Runs when**: `ingress.enabled=true`

**Note**: May show warnings in test environments without external DNS

### 6. RBAC Test (`test-rbac.yaml`)

**Purpose**: Validates service account and RBAC configuration

**What it tests**:
- Service account token is mounted
- RBAC permissions (if enabled)
- Service account name is correct

**Expected outcome**: Service account properly configured

**Runs when**: Always (security validation)

### 7. Code-Server Test (`test-codeserver.yaml`)

**Purpose**: Validates code-server sidecar

**What it tests**:
- Code-server is responding
- Port 8080 is accessible
- Health endpoint works

**Expected outcome**: Code-server responds to health checks

**Runs when**: `codeserver.enabled=true`

**Note**: May need longer startup time

### 8. MQTT Test (`test-mqtt.yaml`)

**Purpose**: Validates MQTT broker sidecar

**What it tests**:
- MQTT broker accepts connections
- Port 1883 is accessible
- Can publish test messages

**Expected outcome**: MQTT broker accepts test publish

**Runs when**: `mqtt.enabled=true`

**Note**: May need longer startup time

### 9. Security Test (`test-security.yaml`)

**Purpose**: Validates security configuration

**What it tests**:
- Controller (Deployment/StatefulSet) exists
- Privileged mode status
- Capabilities configuration
- runAsNonRoot setting
- Seccomp profile

**Expected outcome**: Security context matches configuration

**Runs when**: Always (security audit)

## Test Hook Weights

Tests run in sequence based on hook weights:

```
0: test-connection (basic connectivity)
1: test-api (service health)
2: test-persistence (if enabled)
3: test-database (if PostgreSQL)
4: test-ingress (if enabled)
5: test-rbac (always)
6: test-codeserver (if enabled)
7: test-mqtt (if enabled)
8: test-security (always)
```

Lower weights run first. This ensures dependencies are tested before dependent features.

## Security Context

All test pods use secure, non-privileged containers:

```yaml
securityContext:
  allowPrivilegeEscalation: false
  runAsNonRoot: true
  runAsUser: 65534  # nobody user
  capabilities:
    drop:
      - ALL
  seccompProfile:
    type: RuntimeDefault
```

## Troubleshooting

### Test Pod Failed

```bash
# View test pod logs
kubectl logs home-assistant-test-<name> -n <namespace>

# Describe test pod
kubectl describe pod home-assistant-test-<name> -n <namespace>

# Check events
kubectl get events -n <namespace> --sort-by='.lastTimestamp'
```

### Common Issues

**Test timeout**: Increase startup time or check if service is actually ready

```bash
kubectl get pods -n <namespace>
kubectl logs <pod-name> -n <namespace>
```

**Permission denied**: Check PVC permissions or security context

```bash
kubectl describe pvc <pvc-name> -n <namespace>
```

**Connection refused**: Service may not be ready yet

```bash
kubectl get svc -n <namespace>
kubectl get endpoints -n <namespace>
```

**Database connection failed**: Check database pod and credentials

```bash
kubectl logs <db-pod> -n <namespace>
kubectl get secret <secret-name> -n <namespace> -o yaml
```

## CI/CD Integration

### GitHub Actions Example

```yaml
- name: Install chart
  run: helm install test ./charts/home-assistant -f ci/values.yaml

- name: Run tests
  run: |
    helm test test --timeout 5m
    if [ $? -ne 0 ]; then
      kubectl logs -l app.kubernetes.io/component=test
      exit 1
    fi
```

### GitLab CI Example

```yaml
test-chart:
  script:
    - helm install test ./charts/home-assistant -f ci/values.yaml
    - helm test test --logs
```

## Best Practices

1. **Always run tests** after installation
2. **Use hook weights** to control test execution order
3. **Delete test pods** after successful runs (automatic with hook-delete-policy)
4. **Review test logs** when tests fail
5. **Add custom tests** for integration-specific requirements

## Adding Custom Tests

Create a new test pod in `templates/tests/`:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: {{ include "home-assistant.fullname" . }}-test-custom
  annotations:
    "helm.sh/hook": test
    "helm.sh/hook-delete-policy": before-hook-creation,hook-succeeded
    "helm.sh/hook-weight": "10"  # Run after other tests
spec:
  restartPolicy: Never
  containers:
    - name: test
      image: your-test-image
      command: ['your-test-command']
      securityContext:
        # Use secure defaults
        allowPrivilegeEscalation: false
        runAsNonRoot: true
        capabilities:
          drop: [ALL]
```

## Test Coverage

Current test coverage:

- ✅ Basic connectivity
- ✅ Service health
- ✅ API endpoints
- ✅ Persistence volumes
- ✅ Database connectivity
- ✅ Ingress configuration
- ✅ RBAC configuration
- ✅ Add-ons (code-server, MQTT)
- ✅ Security context
- ✅ Controller validation

## References

- [Helm Chart Tests Documentation](https://helm.sh/docs/topics/chart_tests/)
- [Kubernetes Testing Best Practices](https://kubernetes.io/docs/tasks/debug/)
- [Chart Testing Guidelines](https://github.com/helm/chart-testing)
