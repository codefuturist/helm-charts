# pgAdmin Chart CI Tests

This directory contains CI test configurations for the pgAdmin Helm chart. These tests are automatically run by Chart Testing (ct) to validate the chart before release.

## Test Configurations

| File | Purpose | Key Features Tested |
|------|---------|-------------------|
| `01-default-values.yaml` | Default configuration | Basic deployment with minimal settings |
| `02-statefulset-controller.yaml` | StatefulSet controller | StatefulSet with volumeClaimTemplates |
| `03-security-unprivileged.yaml` | Security hardening | Security contexts, NetworkPolicy, RBAC |
| `04-server-definitions.yaml` | Server management | Pre-configured servers, existing secrets |
| `05-monitoring-enabled.yaml` | Monitoring stack | ServiceMonitor, PrometheusRule, HPA |
| `06-extra-containers.yaml` | Extensibility | Init containers, sidecars, custom volumes |
| `07-pgadmin-features.yaml` | pgAdmin-specific | SMTP, pgpass, config_local.py |
| `08-ingress-enabled.yaml` | Ingress | Ingress with TLS and annotations |
| `09-advanced-scheduling.yaml` | Pod scheduling | Topology spread, affinity, DNS config |
| `10-diagnostic-mode.yaml` | Troubleshooting | Diagnostic mode configuration |

## Running Tests Locally

### Prerequisites

- Helm 3.x installed
- Chart Testing (ct) tool installed (optional)

### Run All Tests

```bash
# From the chart directory
./test.sh
```

### Run Specific Test

```bash
# Test a specific CI configuration
helm template test . -f ci/01-default-values.yaml --debug

# Validate syntax only
helm lint . -f ci/01-default-values.yaml
```

### Run Chart Testing

```bash
# From repository root
ct lint --charts charts/pgadmin
ct install --charts charts/pgadmin
```

## Test Coverage

The CI tests cover:

✅ **Controllers**: Deployment and StatefulSet  
✅ **Security**: Pod security contexts, NetworkPolicy, RBAC  
✅ **Storage**: Persistent volumes, emptyDir  
✅ **Networking**: Services, Ingress, DNS  
✅ **Monitoring**: ServiceMonitor, PrometheusRule, HPA  
✅ **Configuration**: Server definitions, secrets, ConfigMaps  
✅ **Extensibility**: Init containers, sidecars, extra volumes  
✅ **pgAdmin Features**: SMTP, LDAP, pgpass, config_local.py  
✅ **Scheduling**: Affinity, topology spread, DNS config  

## Adding New Tests

When adding new features to the chart:

1. Create a new test file: `ci/XX-feature-name.yaml`
2. Include minimal configuration to test the feature
3. Add comments describing what is being tested
4. Run `./test.sh` to validate
5. Update this README with the new test

## CI Pipeline Integration

These tests are automatically run in CI/CD pipelines using:

```yaml
- name: Run chart-testing (lint)
  run: ct lint --charts charts/pgadmin

- name: Run chart-testing (install)
  run: ct install --charts charts/pgadmin
```

The pipeline will test each file in this directory against a real Kubernetes cluster.

## Test Results

Expected output from successful test run:

```
================================================
pgAdmin Helm Chart Test Suite
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
  [... all CI tests ...]
✓ All 10/10 CI configurations passed
→ Test 4: Testing example configurations...
  [... example tests ...]
✓ All tests passed
```
