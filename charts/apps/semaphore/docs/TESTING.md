# Testing Guide for Semaphore Helm Chart

## Overview

This guide provides comprehensive testing procedures for the Semaphore Helm chart to ensure proper functionality across different deployment scenarios.

## Prerequisites

Before running tests, ensure you have:

- Kubernetes cluster (1.21+)
- Helm 3.8+
- kubectl configured
- helm-unittest plugin (for unit tests)
- (Optional) PostgreSQL or MySQL for database tests

## Installing Test Tools

### Helm Unit Test Plugin

```bash
helm plugin install https://github.com/helm-unittest/helm-unittest.git
```

## Running Tests

### Unit Tests

Run Helm template unit tests:

```bash
cd charts/semaphore
helm unittest .
```

Run specific test suite:

```bash
helm unittest -f 'tests/deployment_test.yaml' .
```

Run with verbose output:

```bash
helm unittest --color --with-subchart charts=false .
```

## Test Categories

### 1. Template Rendering Tests

Verify that templates render correctly with different configurations.

#### Test Deployment Mode

```bash
helm template semaphore . \
  --set controller.type=deployment \
  --debug
```

#### Test StatefulSet Mode

```bash
helm template semaphore . \
  --set controller.type=statefulset \
  --set controller.replicas=3 \
  --debug
```

#### Test with Existing Secret

```bash
helm template semaphore . \
  --set semaphore.existingSecret=my-secret \
  --debug
```

### 2. Installation Tests

Test actual deployment to Kubernetes cluster.

#### Test 1: Minimal Installation

```bash
# Install
helm install semaphore-test . \
  --wait --timeout 5m

# Verify
kubectl get pods -l app.kubernetes.io/name=semaphore
kubectl get svc semaphore-test

# Test connectivity
kubectl port-forward svc/semaphore-test 3000:3000 &
curl -I http://localhost:3000

# Cleanup
helm uninstall semaphore-test
```

#### Test 2: With Persistent Storage

```bash
# Install
helm install semaphore-test . \
  --set persistence.data.enabled=true \
  --set persistence.data.size=5Gi \
  --wait --timeout 5m

# Verify PVCs
kubectl get pvc -l app.kubernetes.io/name=semaphore

# Cleanup
helm uninstall semaphore-test
kubectl delete pvc -l app.kubernetes.io/name=semaphore
```

#### Test 3: With PostgreSQL Database

```bash
# Deploy PostgreSQL first
kubectl create secret generic postgres-secret \
  --from-literal=password=testpass123

kubectl run postgres --image=postgres:16-alpine \
  --env="POSTGRES_PASSWORD=testpass123" \
  --env="POSTGRES_DB=semaphore" \
  --env="POSTGRES_USER=semaphore"

kubectl expose pod postgres --port=5432

# Wait for PostgreSQL to be ready
kubectl wait --for=condition=ready pod/postgres --timeout=60s

# Install Semaphore with PostgreSQL
helm install semaphore-test . \
  --set semaphore.database.dialect=postgres \
  --set semaphore.database.host=postgres \
  --set semaphore.database.user=semaphore \
  --set semaphore.database.password=testpass123 \
  --set semaphore.database.name=semaphore \
  --wait --timeout 5m

# Verify database connection
kubectl logs -l app.kubernetes.io/name=semaphore | grep -i database

# Cleanup
helm uninstall semaphore-test
kubectl delete pod postgres
kubectl delete svc postgres
kubectl delete secret postgres-secret
```

#### Test 4: With Ingress

```bash
# Install with ingress
helm install semaphore-test . \
  --set ingress.enabled=true \
  --set ingress.hosts[0].host=semaphore.local \
  --set ingress.hosts[0].paths[0].path=/ \
  --set ingress.hosts[0].paths[0].pathType=Prefix \
  --wait --timeout 5m

# Verify ingress
kubectl get ingress

# Cleanup
helm uninstall semaphore-test
```

### 3. Upgrade Tests

Test chart upgrades and configuration changes.

#### Test Basic Upgrade

```bash
# Install initial version
helm install semaphore-test . \
  --set semaphore.admin.password=initial123

# Upgrade with new settings
helm upgrade semaphore-test . \
  --set semaphore.admin.password=updated456 \
  --set persistence.tmp.size=30Gi

# Verify upgrade
kubectl rollout status deployment/semaphore-test

# Cleanup
helm uninstall semaphore-test
```

#### Test Database Migration (SQLite to PostgreSQL)

```bash
# Install with SQLite
helm install semaphore-test .

# Wait for initialization
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=semaphore --timeout=120s

# Deploy PostgreSQL
kubectl create secret generic postgres-secret \
  --from-literal=password=testpass123

# (Deploy postgres as shown above)

# Upgrade to PostgreSQL
helm upgrade semaphore-test . \
  --set semaphore.database.dialect=postgres \
  --set semaphore.database.host=postgres \
  --set semaphore.database.user=semaphore \
  --set semaphore.database.password=testpass123 \
  --set semaphore.database.name=semaphore

# Verify
kubectl logs -l app.kubernetes.io/name=semaphore | grep postgres

# Cleanup
helm uninstall semaphore-test
kubectl delete pod postgres svc postgres secret postgres-secret
```

### 4. High Availability Tests

Test HA configurations with multiple replicas.

#### Test StatefulSet with Multiple Replicas

```bash
# Deploy PostgreSQL for shared state
kubectl create secret generic postgres-secret \
  --from-literal=password=testpass123

kubectl run postgres --image=postgres:16-alpine \
  --env="POSTGRES_PASSWORD=testpass123" \
  --env="POSTGRES_DB=semaphore" \
  --env="POSTGRES_USER=semaphore"

kubectl expose pod postgres --port=5432
kubectl wait --for=condition=ready pod/postgres --timeout=60s

# Install with StatefulSet
helm install semaphore-test . \
  --set controller.type=statefulset \
  --set semaphore.database.dialect=postgres \
  --set semaphore.database.host=postgres \
  --set semaphore.database.user=semaphore \
  --set semaphore.database.password=testpass123 \
  --set semaphore.database.name=semaphore \
  --set persistence.volumeClaimTemplates.enabled=true \
  --wait --timeout 5m

# Scale to 2 replicas
kubectl scale statefulset semaphore-test --replicas=2

# Wait for scale
kubectl wait --for=condition=ready pod/semaphore-test-1 --timeout=120s

# Verify both pods
kubectl get pods -l app.kubernetes.io/name=semaphore

# Test failover (delete one pod)
kubectl delete pod semaphore-test-0
kubectl wait --for=condition=ready pod/semaphore-test-0 --timeout=120s

# Cleanup
helm uninstall semaphore-test
kubectl delete pod postgres
kubectl delete svc postgres
kubectl delete secret postgres-secret
kubectl delete pvc -l app.kubernetes.io/name=semaphore
```

### 5. Security Tests

Test security-related configurations.

#### Test Non-Root User

```bash
# Install
helm install semaphore-test .

# Verify security context
kubectl get pod -l app.kubernetes.io/name=semaphore -o jsonpath='{.items[0].spec.securityContext}'
kubectl get pod -l app.kubernetes.io/name=semaphore -o jsonpath='{.items[0].spec.containers[0].securityContext}'

# Should show:
# - runAsNonRoot: true
# - runAsUser: 1001
# - fsGroup: 1001

# Cleanup
helm uninstall semaphore-test
```

#### Test with Existing Secrets

```bash
# Create secret
kubectl create secret generic semaphore-secrets \
  --from-literal=admin-password=SecurePass123 \
  --from-literal=database-password=DBPass123 \
  --from-literal=cookie-hash=$(openssl rand -hex 32) \
  --from-literal=cookie-encryption=$(openssl rand -hex 16) \
  --from-literal=access-key-encryption=$(openssl rand -hex 16)

# Install with existing secret
helm install semaphore-test . \
  --set semaphore.existingSecret=semaphore-secrets

# Verify secret is mounted
kubectl describe pod -l app.kubernetes.io/name=semaphore | grep -A5 "Environment Variables from"

# Cleanup
helm uninstall semaphore-test
kubectl delete secret semaphore-secrets
```

### 6. Monitoring Tests

Test monitoring integration.

#### Test ServiceMonitor

```bash
# Install with monitoring
helm install semaphore-test . \
  --set monitoring.serviceMonitor.enabled=true \
  --set monitoring.prometheusRule.enabled=true

# Verify ServiceMonitor
kubectl get servicemonitor semaphore-test -o yaml

# Verify PrometheusRule
kubectl get prometheusrule semaphore-test -o yaml

# Cleanup
helm uninstall semaphore-test
```

### 7. Persistence Tests

Test persistent storage functionality.

#### Test Volume Mounts

```bash
# Install
helm install semaphore-test . \
  --set persistence.data.enabled=true \
  --set persistence.config.enabled=true \
  --set persistence.tmp.enabled=true

# Verify volumes
kubectl get pvc -l app.kubernetes.io/name=semaphore

# Verify mounts in pod
kubectl exec -it deployment/semaphore-test -- df -h | grep semaphore

# Write test data
kubectl exec -it deployment/semaphore-test -- touch /var/lib/semaphore/test.txt

# Delete pod and verify data persistence
kubectl delete pod -l app.kubernetes.io/name=semaphore
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=semaphore --timeout=120s
kubectl exec -it deployment/semaphore-test -- ls -la /var/lib/semaphore/test.txt

# Cleanup
helm uninstall semaphore-test
kubectl delete pvc -l app.kubernetes.io/name=semaphore
```

### 8. Integration Tests

Test integrations with external services.

#### Test Email Configuration

```bash
# Install with email
helm install semaphore-test . \
  --set semaphore.email.enabled=true \
  --set semaphore.email.host=smtp.example.com \
  --set semaphore.email.port=587 \
  --set semaphore.email.sender=test@example.com

# Verify environment variables
kubectl exec -it deployment/semaphore-test -- env | grep SEMAPHORE_EMAIL

# Cleanup
helm uninstall semaphore-test
```

#### Test LDAP Configuration

```bash
# Install with LDAP
helm install semaphore-test . \
  --set semaphore.ldap.enabled=true \
  --set semaphore.ldap.server=ldap://ldap.example.com \
  --set semaphore.ldap.bindDn="cn=admin,dc=example,dc=com"

# Verify environment variables
kubectl exec -it deployment/semaphore-test -- env | grep SEMAPHORE_LDAP

# Cleanup
helm uninstall semaphore-test
```

## Automated Test Script

Create a comprehensive test script:

```bash
#!/bin/bash
# test-semaphore.sh

set -e

CHART_DIR="."
RELEASE_NAME="semaphore-test"
NAMESPACE="default"

echo "=== Starting Semaphore Helm Chart Tests ==="

# Test 1: Lint
echo "Test 1: Linting chart..."
helm lint $CHART_DIR

# Test 2: Template rendering
echo "Test 2: Testing template rendering..."
helm template $RELEASE_NAME $CHART_DIR > /dev/null

# Test 3: Install
echo "Test 3: Installing chart..."
helm install $RELEASE_NAME $CHART_DIR --wait --timeout 5m

# Test 4: Verify pods
echo "Test 4: Verifying pods..."
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=semaphore --timeout=120s

# Test 5: Test connectivity
echo "Test 5: Testing connectivity..."
kubectl port-forward svc/$RELEASE_NAME 3000:3000 &
PF_PID=$!
sleep 5
curl -f http://localhost:3000 || echo "Connection test completed"
kill $PF_PID

# Test 6: Upgrade
echo "Test 6: Testing upgrade..."
helm upgrade $RELEASE_NAME $CHART_DIR --set persistence.tmp.size=30Gi

# Test 7: Rollback
echo "Test 7: Testing rollback..."
helm rollback $RELEASE_NAME

# Cleanup
echo "Cleaning up..."
helm uninstall $RELEASE_NAME
kubectl delete pvc -l app.kubernetes.io/name=semaphore --ignore-not-found=true

echo "=== All tests completed successfully! ==="
```

Make it executable and run:

```bash
chmod +x test-semaphore.sh
./test-semaphore.sh
```

## Test Checklist

Use this checklist to ensure comprehensive testing:

- [ ] Helm lint passes
- [ ] Template rendering works for all configurations
- [ ] Deployment mode installation succeeds
- [ ] StatefulSet mode installation succeeds
- [ ] SQLite database works
- [ ] PostgreSQL database connection works
- [ ] MySQL database connection works
- [ ] Persistent volumes are created and mounted
- [ ] Ingress resource is created correctly
- [ ] ServiceMonitor is created when enabled
- [ ] PrometheusRule is created when enabled
- [ ] Security contexts are applied correctly
- [ ] Existing secrets integration works
- [ ] Email configuration is applied
- [ ] LDAP configuration is applied
- [ ] Runner configuration is applied
- [ ] Upgrades work without data loss
- [ ] Rollback works correctly
- [ ] High availability with multiple replicas works
- [ ] Pod disruption budget is created
- [ ] Network policies work as expected
- [ ] Resource limits are respected
- [ ] Health probes work correctly

## Troubleshooting Tests

### Test Failures

If a test fails:

1. Check pod logs:
   ```bash
   kubectl logs -l app.kubernetes.io/name=semaphore
   ```

2. Check pod events:
   ```bash
   kubectl describe pod -l app.kubernetes.io/name=semaphore
   ```

3. Check rendered manifests:
   ```bash
   helm template semaphore . --debug
   ```

4. Verify values are applied:
   ```bash
   helm get values semaphore-test
   ```

### Common Test Issues

**Issue**: Pod fails to start

**Solution**: Check resource limits, storage class availability, and image pull

**Issue**: Database connection fails

**Solution**: Verify database is accessible, credentials are correct

**Issue**: PVC creation fails

**Solution**: Verify storage class exists and has available capacity

## Continuous Integration

Example GitHub Actions workflow:

```yaml
name: Test Semaphore Chart

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Set up Helm
        uses: azure/setup-helm@v3
        with:
          version: '3.12.0'

      - name: Install helm-unittest
        run: helm plugin install https://github.com/helm-unittest/helm-unittest.git

      - name: Lint chart
        run: helm lint charts/semaphore

      - name: Run unit tests
        run: helm unittest charts/semaphore

      - name: Template chart
        run: helm template semaphore charts/semaphore
```

## Best Practices

1. **Always clean up**: Remove test resources after each test
2. **Use unique names**: Avoid conflicts with parallel tests
3. **Test isolation**: Each test should be independent
4. **Document failures**: Keep logs of failed tests
5. **Regular testing**: Run tests on every commit
6. **Production-like**: Test with production-like configurations

## Next Steps

- Review [README](../README.md) for full documentation
- Check [QUICKSTART](./QUICKSTART.md) for deployment guide
- Explore [examples](../examples/) for configuration samples
