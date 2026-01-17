# Testing Guide for MeTube Helm Chart

This guide covers all testing approaches for the MeTube Helm chart, from development to CI/CD integration.

## Table of Contents

- [Quick Start](#quick-start)
- [Manual Testing](#manual-testing)
- [Automated Testing](#automated-testing)
- [CI/CD Integration](#cicd-integration)
- [Troubleshooting](#troubleshooting)

## Quick Start

### Validate Chart Locally

```bash
# Quick validation (lint + template render all CI configs)
./scripts/validate.sh

# Comprehensive test suite
./scripts/test.sh
```

## Manual Testing

### 1. Lint the Chart

```bash
helm lint .
```

### 2. Template Rendering

```bash
# Render templates with default values
helm template test .

# Render with specific configuration
helm template test . -f ci/01-default-values.yaml

# Debug mode for detailed output
helm template test . --debug
```

### 3. Dry-Run Install

```bash
helm install test . \
  --namespace metube-test \
  --create-namespace \
  --dry-run --debug
```

### 4. Actual Installation

```bash
# Install with default values
helm install metube . \
  --namespace metube \
  --create-namespace

# Run Helm tests
helm test metube -n metube

# Clean up
helm uninstall metube -n metube
```

## Automated Testing

### Test Scripts

#### validate.sh - Quick Validation

Fast validation script that runs:

- Helm lint
- Template rendering for all CI configurations
- Resource count validation

```bash
./scripts/validate.sh
```

#### test.sh - Comprehensive Suite

Full test suite covering:

- Chart linting
- Default values rendering
- All CI configurations
- All example configurations
- Resource count validation
- Controller type validation
- Feature enablement tests (HPA, ServiceMonitor, PrometheusRule)

```bash
./scripts/test.sh
```

### CI Test Configurations

The `ci/` directory contains test configurations covering various scenarios:

```bash
# Test all CI configs
for config in ci/*.yaml; do
  helm template test . -f "$config" > /dev/null && echo "✓ $(basename $config)"
done
```

Common test configurations:

- Default deployment
- StatefulSet with persistence
- Security contexts and NetworkPolicy
- Monitoring stack
- Ingress with TLS
- High availability setup

### Example Configurations

Test all example configurations:

```bash
for example in examples/values-*.yaml; do
  helm template test . -f "$example" > /dev/null && echo "✓ $(basename $example)"
done
```

## Deployment Validation

### 1. Check Pod Status

```bash
kubectl get pods -l app.kubernetes.io/name=metube -n metube
kubectl describe pod <pod-name> -n metube
```

### 2. Check Logs

```bash
# View application logs
kubectl logs -l app.kubernetes.io/name=metube -n metube --tail=100 -f

# Check for errors
kubectl logs -l app.kubernetes.io/name=metube -n metube | grep -i error
```

### 3. Check Storage

```bash
# Check PVC status
kubectl get pvc -n metube
kubectl describe pvc metube-downloads -n metube

# Check storage usage
kubectl exec -n metube <pod-name> -- df -h /downloads
```

### 4. Test Connectivity

```bash
# Port forward to test access
kubectl port-forward -n metube svc/metube 8081:8081

# Test with curl
curl http://localhost:8081

# Run Helm tests
helm test metube -n metube
```

### 5. Test Download Functionality

```bash
# Access the web UI and test:
# 1. Paste a test video URL
# 2. Select format/quality
# 3. Start download
# 4. Monitor progress
# 5. Verify file appears in storage
```

## CI/CD Integration

### Chart Testing (ct)

The chart uses [chart-testing](https://github.com/helm/chart-testing) for CI/CD:

```bash
# Lint all charts
ct lint --charts charts/metube

# Install and test
ct install --charts charts/metube
```

### GitHub Actions Example

```yaml
name: Lint and Test Charts

on: pull_request

jobs:
  lint-test:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v3
        with:
          fetch-depth: 0

      - name: Set up Helm
        uses: azure/setup-helm@v3

      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: "3.x"

      - name: Set up chart-testing
        uses: helm/chart-testing-action@v2

      - name: Run chart-testing (lint)
        run: ct lint --charts charts/metube

      - name: Create kind cluster
        uses: helm/kind-action@v1

      - name: Run chart-testing (install)
        run: ct install --charts charts/metube
```

### Makefile Integration

Add to repository Makefile:

```makefile
.PHONY: test-metube
test-metube:
    cd charts/metube && ./scripts/test.sh

.PHONY: validate-metube
validate-metube:
    cd charts/metube && ./scripts/validate.sh

.PHONY: lint-metube
lint-metube:
    helm lint charts/metube
```

## Test Coverage

### What is Tested

✅ **Chart Structure**

- Valid Chart.yaml
- Required files present
- Proper template syntax

✅ **Controllers**

- Deployment (default)
- StatefulSet with volumeClaimTemplates

✅ **Security**

- Pod security contexts
- Container security contexts
- NetworkPolicy
- RBAC (ServiceAccount)

✅ **Storage**

- PersistentVolumeClaim for downloads
- Optional temp storage
- emptyDir fallback

✅ **Networking**

- Service (ClusterIP, LoadBalancer, NodePort)
- Ingress with TLS
- DNS configuration

✅ **Monitoring**

- ServiceMonitor
- PrometheusRule
- HorizontalPodAutoscaler

✅ **Configuration**

- MeTube environment variables
- yt-dlp options (YTDL_OPTIONS)
- Cookie authentication
- Existing secrets
- ConfigMaps

✅ **Extensibility**

- Extra containers
- Init containers
- Extra volumes
- Extra environment variables

✅ **MeTube Features**

- Download modes (sequential, concurrent, limited)
- Output templates
- URL prefix for reverse proxy
- Default format selection
- Custom yt-dlp options

✅ **Scheduling**

- Affinity rules
- Topology spread constraints
- Pod disruption budgets

### Test Output Example

```text
================================================
MeTube Helm Chart Test Suite
================================================

→ Test 1: Running helm lint...
✓ Helm lint passed
→ Test 2: Rendering templates with default values...
✓ Default values template rendering passed
→ Test 3: Testing CI configurations...
  Testing: 01-default-values
    ✓ 01-default-values passed
  Testing: 02-statefulset-controller
    ✓ 02-statefulset-controller passed
  ...
✓ All CI configurations passed
→ Test 4: Testing example configurations...
    ✓ values-minimal passed
    ✓ values-production passed
    ✓ values-with-persistence passed
    ✓ values-reverse-proxy passed
✓ All example configurations passed
→ Test 5: Validating resource counts...
✓ Resource count validation passed
→ Test 6: Testing StatefulSet controller...
✓ StatefulSet controller test passed
→ Test 7: Testing Deployment controller...
✓ Deployment controller test passed
→ Test 8: Testing HPA enablement...
✓ HPA enablement test passed
→ Test 9: Testing ServiceMonitor enablement...
✓ ServiceMonitor enablement test passed

================================================
All tests passed!
================================================
```

## Troubleshooting

### Common Issues

#### Issue: "validation failed" errors

```bash
# Check for YAML syntax errors
helm lint .

# Debug template rendering
helm template test . --debug
```

#### Issue: Templates don't render

```bash
# Check for missing required values
helm template test . -f ci/01-default-values.yaml --debug

# Validate specific template
helm template test . --show-only templates/deployment.yaml
```

#### Issue: CI tests fail

```bash
# Run individual CI test with debug output
helm template test . -f ci/01-default-values.yaml --debug

# Check for missing CRDs (ServiceMonitor, PrometheusRule)
kubectl api-resources | grep monitoring
```

#### Issue: Pod won't start

```bash
# Check pod events
kubectl describe pod -l app.kubernetes.io/name=metube -n metube

# Check logs
kubectl logs -l app.kubernetes.io/name=metube -n metube

# Check storage issues
kubectl get pvc -n metube
```

#### Issue: Downloads fail

```bash
# Check logs for yt-dlp errors
kubectl logs -l app.kubernetes.io/name=metube -n metube | grep -i error

# Check network policies allow egress
kubectl get networkpolicy -n metube

# Check storage space
kubectl exec -n metube <pod-name> -- df -h /downloads
```

### Debug Commands

```bash
# Show only specific template
helm template test . --show-only templates/deployment.yaml

# Get computed values
helm template test . --debug 2>&1 | grep "COMPUTED VALUES"

# Validate against specific Kubernetes version
helm template test . --kube-version 1.28.0

# Check resource generation
helm template test . | kubectl apply --dry-run=client -f -
```

## Best Practices

1. **Always lint before committing**

   ```bash
   ./scripts/validate.sh
   ```

2. **Test all CI configurations**

   ```bash
   ./scripts/test.sh
   ```

3. **Update tests when adding features**
   - Add new CI test config
   - Update test scripts
   - Document in README

4. **Test with actual Kubernetes cluster**

   ```bash
   kind create cluster
   helm install test . -f ci/01-default-values.yaml
   helm test test
   ```

5. **Keep CI configs minimal**
   - Only test specific feature
   - Use clear naming
   - Add descriptive comments

## References

- [Helm Testing Guide](https://helm.sh/docs/topics/chart_tests/)
- [Chart Testing Tool](https://github.com/helm/chart-testing)
- [Helm Best Practices](https://helm.sh/docs/chart_best_practices/)
- [MeTube GitHub](https://github.com/alexta69/metube)
- [yt-dlp Documentation](https://github.com/yt-dlp/yt-dlp)
