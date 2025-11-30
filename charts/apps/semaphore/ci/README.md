# Semaphore Chart CI Tests

This directory contains CI test configurations for the Semaphore Helm chart. These tests are automatically run by Chart Testing (ct) to validate the chart before release.

## Test Configurations

| File | Purpose | Key Features Tested |
|------|---------|-------------------|
| `01-default-values.yaml` | Default configuration | Basic deployment with SQLite, minimal settings |
| `02-with-tls.yaml` | TLS/HTTPS | TLS configuration, certificates, ingress with TLS |
| `03-with-auth.yaml` | Authentication & Security | LDAP, email, TOTP, existing secrets, NetworkPolicy |
| `04-statefulset.yaml` | StatefulSet controller | StatefulSet with volumeClaimTemplates, pod affinity |
| `05-monitoring-enabled.yaml` | Monitoring stack | ServiceMonitor, PrometheusRule, HPA, PDB |

## Running Tests Locally

### Prerequisites

- Helm 3.x installed
- Chart Testing (ct) tool installed (optional)

### Run All Tests

```bash
# From the chart directory
./scripts/test.sh
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
ct lint --charts charts/semaphore
ct install --charts charts/semaphore
```

## Test Coverage

### 01-default-values.yaml
- ✅ Basic Deployment controller
- ✅ SQLite database
- ✅ Minimal resource allocation
- ✅ ClusterIP service
- ✅ Basic persistence (data, config, tmp)

### 02-with-tls.yaml
- ✅ TLS/HTTPS configuration
- ✅ Certificate mounting
- ✅ Ingress with TLS
- ✅ cert-manager integration
- ✅ HTTPS redirects

### 03-with-auth.yaml
- ✅ PostgreSQL database
- ✅ Existing secrets
- ✅ LDAP authentication
- ✅ Email/SMTP configuration
- ✅ TOTP (2FA) enabled
- ✅ Runner support
- ✅ NetworkPolicy

### 04-statefulset.yaml
- ✅ StatefulSet controller
- ✅ VolumeClaimTemplates
- ✅ Multiple replicas
- ✅ Pod anti-affinity
- ✅ Session affinity
- ✅ PostgreSQL backend

### 05-monitoring-enabled.yaml
- ✅ ServiceMonitor (Prometheus)
- ✅ PrometheusRule (alerts)
- ✅ HorizontalPodAutoscaler
- ✅ PodDisruptionBudget
- ✅ Multiple replicas

## Adding New Tests

1. Create a new YAML file in this directory (e.g., `06-new-feature.yaml`)
2. Follow the naming convention: `NN-descriptive-name.yaml`
3. Include a comment header describing the test purpose
4. Add an entry to the table above
5. Run `./scripts/test.sh` to verify

## Troubleshooting

If a test fails:

```bash
# Run with debug output
helm template test . -f ci/XX-failing-test.yaml --debug

# Check for syntax errors
helm lint . -f ci/XX-failing-test.yaml

# Validate against Kubernetes schemas
helm template test . -f ci/XX-failing-test.yaml | kubectl apply --dry-run=client -f -
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
