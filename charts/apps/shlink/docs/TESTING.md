# Testing Guide for Shlink Helm Chart

This guide covers all testing approaches for the Shlink Helm chart, from development to CI/CD integration.

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
./validate.sh

# Comprehensive test suite
./test.sh
```

## Manual Testing

### 1. Lint the Chart

```bash
helm lint . --set shlink.email=admin@example.com --set shlink.password=test123
```

### 2. Template Rendering

```bash
# Render templates with default values
helm template test . \
  --set shlink.email=admin@example.com \
  --set shlink.password=test123

# Render with specific configuration
helm template test . -f ci/01-default-values.yaml

# Debug mode for detailed output
helm template test . \
  --set shlink.email=admin@example.com \
  --set shlink.password=test123 \
  --debug
```

### 3. Dry-Run Install

```bash
helm install test . \
  --set shlink.email=admin@example.com \
  --set shlink.password=test123 \
  --namespace shlink-test \
  --create-namespace \
  --dry-run --debug
```

### 4. Actual Installation

```bash
# Install with default values
helm install my-shlink . \
  --set shlink.email=admin@example.com \
  --set shlink.password=SuperSecure123 \
  --namespace shlink \
  --create-namespace

# Run Helm tests
helm test my-shlink -n shlink

# Clean up
helm uninstall my-shlink -n shlink
```

## Automated Testing

### Test Scripts

#### validate.sh - Quick Validation

Fast validation script that runs:

- Helm lint
- Template rendering for all CI configurations
- Resource count validation

```bash
./validate.sh
```

#### test.sh - Comprehensive Suite

Full test suite covering:

- Chart linting
- Default values rendering
- All CI configurations (10 tests)
- All example configurations
- Resource count validation
- Controller type validation
- Feature enablement tests (HPA, ServiceMonitor, PrometheusRule)

```bash
./test.sh
```

### CI Test Configurations

The `ci/` directory contains 10 test configurations:

```bash
# Test all CI configs
for config in ci/*.yaml; do
  helm template test . -f "$config" > /dev/null && echo "✓ $(basename $config)"
done
```

| Config                           | Tests                            |
| -------------------------------- | -------------------------------- |
| `01-default-values.yaml`         | Basic deployment                 |
| `02-statefulset-controller.yaml` | StatefulSet with persistence     |
| `03-security-unprivileged.yaml`  | Security contexts, NetworkPolicy |
| `04-server-definitions.yaml`     | Pre-configured servers           |
| `05-monitoring-enabled.yaml`     | Monitoring stack                 |
| `06-extra-containers.yaml`       | Init containers, sidecars        |
| `07-shlink-features.yaml`        | SMTP, pgpass, config_local       |
| `08-ingress-enabled.yaml`        | Ingress with TLS                 |
| `09-advanced-scheduling.yaml`    | Topology spread, affinity        |
| `10-diagnostic-mode.yaml`        | Diagnostic mode                  |

### Example Configurations

Test all example configurations:

```bash
for example in examples/values-*.yaml; do
  helm template test . -f "$example" > /dev/null && echo "✓ $(basename $example)"
done
```

## CI/CD Integration

### Chart Testing (ct)

The chart uses [chart-testing](https://github.com/helm/chart-testing) for CI/CD:

```bash
# Lint all charts
ct lint --charts charts/shlink

# Install and test
ct install --charts charts/shlink
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
        run: ct lint --charts charts/shlink

      - name: Create kind cluster
        uses: helm/kind-action@v1

      - name: Run chart-testing (install)
        run: ct install --charts charts/shlink
```

### Makefile Integration

Add to repository Makefile:

```makefile
.PHONY: test-shlink
test-shlink:
    cd charts/shlink && ./test.sh

.PHONY: validate-shlink
validate-shlink:
    cd charts/shlink && ./validate.sh

.PHONY: lint-shlink
lint-shlink:
    helm lint charts/shlink \
        --set shlink.email=admin@example.com \
        --set shlink.password=test123
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
- RBAC

✅ **Storage**

- PersistentVolumeClaim
- VolumeClaimTemplates (StatefulSet)
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

- Server definitions
- Inline secrets
- Existing secrets
- ConfigMaps

✅ **Extensibility**

- Extra containers
- Init containers
- Extra volumes
- Extra environment variables

✅ **Shlink Features**

- SMTP configuration
- LDAP configuration
- pgpass file
- config_local.py

✅ **Scheduling**

- Affinity rules
- Topology spread constraints
- Pod disruption budgets

### Test Output Example

```
================================================
Shlink Helm Chart Test Suite
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
✓ All 10/10 CI configurations passed
→ Test 4: Testing example configurations...
    ✓ values-minimal passed
    ✓ values-production passed
    ✓ values-with-persistence passed
    ✓ values-multiple-servers passed
✓ All 4/4 example configurations passed
→ Test 5: Validating resource counts...
✓ Resource count validation passed (7 resources)
→ Test 6: Testing StatefulSet controller...
✓ StatefulSet controller test passed
→ Test 7: Testing Deployment controller...
✓ Deployment controller test passed
→ Test 8: Testing HPA enablement...
✓ HPA enablement test passed
→ Test 9: Testing ServiceMonitor enablement...
✓ ServiceMonitor enablement test passed
→ Test 10: Testing PrometheusRule enablement...
✓ PrometheusRule enablement test passed

================================================
All tests passed!
================================================
```

## Troubleshooting

### Common Issues

#### Issue: "validation failed" errors

```bash
# Check for YAML syntax errors
helm lint . --set shlink.email=admin@example.com --set shlink.password=test123

# Debug template rendering
helm template test . \
  --set shlink.email=admin@example.com \
  --set shlink.password=test123 \
  --debug
```

#### Issue: Templates don't render

```bash
# Check for missing required values
helm template test . -f ci/01-default-values.yaml --debug

# Validate specific template
helm template test . \
  --set shlink.email=admin@example.com \
  --set shlink.password=test123 \
  --show-only templates/deployment.yaml
```

#### Issue: CI tests fail

```bash
# Run individual CI test with debug output
helm template test . -f ci/05-monitoring-enabled.yaml --debug

# Check for missing CRDs (ServiceMonitor, PrometheusRule)
kubectl api-resources | grep monitoring
```

### Debug Commands

```bash
# Show only specific template
helm template test . \
  --set shlink.email=admin@example.com \
  --set shlink.password=test123 \
  --show-only templates/deployment.yaml

# Get computed values
helm template test . \
  --set shlink.email=admin@example.com \
  --set shlink.password=test123 \
  --debug 2>&1 | grep "COMPUTED VALUES"

# Validate against specific Kubernetes version
helm template test . \
  --set shlink.email=admin@example.com \
  --set shlink.password=test123 \
  --kube-version 1.28.0
```

## Best Practices

1. **Always lint before committing**

   ```bash
   ./validate.sh
   ```

2. **Test all CI configurations**

   ```bash
   ./test.sh
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
