# pgAdmin Chart Unit Tests

This directory contains unit tests for the pgAdmin Helm chart using [helm-unittest](https://github.com/helm-unittest/helm-unittest).

## Overview

The test suite provides comprehensive coverage of all chart templates, ensuring correct YAML rendering, value handling, and conditional logic.

## Test Files

| File | Templates Tested | Test Count | Coverage |
|------|-----------------|------------|----------|
| `common_test.yaml` | deployment, service, secret, configmap | 5 tests | Labels, metadata, overrides |
| `deployment_test.yaml` | deployment | 11 tests | Resources, env vars, volumes, security |
| `statefulset_test.yaml` | statefulset | 5 tests | Controller type, VCTs, storage |
| `service_test.yaml` | service | 7 tests | Service types, ports, annotations |
| `secret_test.yaml` | secret | 4 tests | Inline/existing secrets, SMTP, pgpass |
| `configmap_test.yaml` | configmap | 3 tests | Server definitions, config_local |
| `ingress_test.yaml` | ingress | 5 tests | Ingress config, TLS, annotations |
| `monitoring_test.yaml` | servicemonitor, prometheusrule, hpa | 8 tests | Monitoring stack configuration |
| `networkpolicy_test.yaml` | networkpolicy | 5 tests | Network policies, ingress/egress |
| `rbac_test.yaml` | serviceaccount, rbac | 7 tests | RBAC resources, annotations |
| `pvc_test.yaml` | pvc, pdb | 7 tests | Persistence, disruption budgets |
| `diagnostic_test.yaml` | deployment | 4 tests | Diagnostic mode functionality |

**Total: 71 unit tests**

## Prerequisites

Install helm-unittest plugin:

```bash
helm plugin install https://github.com/helm-unittest/helm-unittest
```

## Running Tests

### Run All Tests

```bash
# From chart directory
helm unittest .

# From repository root
helm unittest charts/pgadmin
```

### Run Specific Test File

```bash
helm unittest -f tests/deployment_test.yaml .
```

### Run with Verbose Output

```bash
helm unittest -v .
```

### Run with Colored Output

```bash
helm unittest --color .
```

### Generate Test Report

```bash
helm unittest --output-type JUnit --output-file test-results.xml .
```

## Test Structure

Each test file follows this structure:

```yaml
suite: test description
templates:
  - template.yaml       # Templates to render
tests:
  - it: should do something
    set:                # Override values
      key: value
    asserts:            # Assertions
      - isKind:
          of: Deployment
      - equal:
          path: metadata.name
          value: expected-value
```

## Available Assertions

Common assertions used in tests:

- `isKind` - Check resource kind
- `equal` - Exact value match
- `notEqual` - Value mismatch
- `matchRegex` - Regex pattern match
- `contains` - List/array contains value
- `notContains` - List doesn't contain value
- `isNotEmpty` - Value is not empty
- `isEmpty` - Value is empty
- `hasDocuments` - Check document count
- `isNull` - Value is null
- `isNotNull` - Value is not null

See [helm-unittest documentation](https://github.com/helm-unittest/helm-unittest/blob/main/DOCUMENT.md) for all assertions.

## Test Coverage

### Templates Tested

✅ deployment.yaml (11 tests)  
✅ statefulset.yaml (5 tests)  
✅ service.yaml (7 tests)  
✅ secret.yaml (4 tests)  
✅ configmap.yaml (3 tests)  
✅ ingress.yaml (5 tests)  
✅ servicemonitor.yaml (3 tests)  
✅ prometheusrule.yaml (2 tests)  
✅ hpa.yaml (3 tests)  
✅ networkpolicy.yaml (5 tests)  
✅ serviceaccount.yaml (4 tests)  
✅ rbac.yaml (3 tests)  
✅ pvc.yaml (4 tests)  
✅ pdb.yaml (3 tests)  

### Features Tested

✅ **Controllers**: Deployment vs StatefulSet  
✅ **Resources**: CPU/memory limits and requests  
✅ **Storage**: PVC, VolumeClaimTemplates, emptyDir  
✅ **Security**: Security contexts, capabilities  
✅ **Secrets**: Inline, existing, SMTP, pgpass  
✅ **Configuration**: Server definitions, config_local  
✅ **Networking**: Service types, Ingress, NetworkPolicy  
✅ **Monitoring**: ServiceMonitor, PrometheusRule, HPA  
✅ **RBAC**: ServiceAccount, Role, RoleBinding  
✅ **Scheduling**: PodDisruptionBudget  
✅ **Extensibility**: Extra env, volumes, containers  
✅ **Operations**: Diagnostic mode, lifecycle hooks  

## Adding New Tests

When adding features to the chart:

1. **Create test file** (if new template):
   ```yaml
   suite: test new feature
   templates:
     - newfeature.yaml
   tests:
     - it: should create resource
       asserts:
         - isKind:
             of: NewKind
   ```

2. **Add tests for new values**:
   ```yaml
   - it: should configure new feature
     set:
       newFeature.enabled: true
       newFeature.value: "test"
     asserts:
       - equal:
           path: spec.newField
           value: "test"
   ```

3. **Test conditional logic**:
   ```yaml
   - it: should not create when disabled
     set:
       newFeature.enabled: false
     asserts:
       - hasDocuments:
           count: 0
   ```

4. **Run tests**:
   ```bash
   helm unittest .
   ```

## CI/CD Integration

### GitHub Actions Example

```yaml
- name: Run Helm Unit Tests
  run: |
    helm plugin install https://github.com/helm-unittest/helm-unittest
    helm unittest charts/pgadmin --color
```

### GitLab CI Example

```yaml
helm-unittest:
  stage: test
  script:
    - helm plugin install https://github.com/helm-unittest/helm-unittest
    - helm unittest charts/pgadmin --output-type JUnit --output-file test-results.xml
  artifacts:
    reports:
      junit: test-results.xml
```

## Expected Output

Successful test run:

```
### Chart [ pgadmin ] charts/pgadmin

 PASS  test pgadmin common labels and metadata  tests/common_test.yaml
 PASS  test pgadmin deployment  tests/deployment_test.yaml
 PASS  test pgadmin statefulset tests/statefulset_test.yaml
 PASS  test pgadmin service tests/service_test.yaml
 PASS  test pgadmin secrets tests/secret_test.yaml
 PASS  test pgadmin configmaps  tests/configmap_test.yaml
 PASS  test pgadmin ingress tests/ingress_test.yaml
 PASS  test pgadmin monitoring  tests/monitoring_test.yaml
 PASS  test pgadmin network policy  tests/networkpolicy_test.yaml
 PASS  test pgadmin RBAC    tests/rbac_test.yaml
 PASS  test pgadmin PVC and PDB tests/pvc_test.yaml
 PASS  test pgadmin diagnostic mode tests/diagnostic_test.yaml

Charts:      1 passed, 1 total
Test Suites: 12 passed, 12 total
Tests:       71 passed, 71 total
Snapshot:    0 passed, 0 total
Time:        2.5s
```

## Troubleshooting

### Plugin Not Installed

```bash
helm plugin install https://github.com/helm-unittest/helm-unittest
```

### Test Failures

```bash
# Run with verbose output
helm unittest -v .

# Run specific failing test
helm unittest -f tests/failing_test.yaml -v .

# Check template rendering
helm template test . --set pgadmin.email=admin@example.com --set pgadmin.password=test123 --show-only templates/deployment.yaml
```

### Debugging Tests

Add `--debug` flag:

```bash
helm unittest --debug .
```

## Best Practices

1. **Test positive and negative cases**
   - Test when feature is enabled
   - Test when feature is disabled

2. **Use meaningful test names**
   - Bad: "test 1"
   - Good: "should create PVC when persistence enabled"

3. **Test edge cases**
   - Empty values
   - Missing values
   - Invalid configurations

4. **Keep tests focused**
   - One assertion per test when possible
   - Group related assertions

5. **Use snapshots for complex outputs**
   ```yaml
   asserts:
     - matchSnapshot: {}
   ```

## References

- [helm-unittest GitHub](https://github.com/helm-unittest/helm-unittest)
- [helm-unittest Documentation](https://github.com/helm-unittest/helm-unittest/blob/main/DOCUMENT.md)
- [Helm Testing Guide](https://helm.sh/docs/topics/chart_tests/)
