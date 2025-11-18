# Testing Guide for PostgreSQL Helm Chart

## Overview

This Helm chart uses [helm-unittest](https://github.com/helm-unittest/helm-unittest) for testing template rendering and configuration validation.

## Prerequisites

Install the helm-unittest plugin:

```bash
helm plugin install https://github.com/helm-unittest/helm-unittest.git
```

## Running Tests

### Run All Tests

```bash
cd charts/postgresql
helm unittest .
```

### Run Specific Test Suite

```bash
helm unittest -f 'tests/auth_test.yaml' .
```

### Run Tests with Verbose Output

```bash
helm unittest --color --with-subchart charts=false .
```

## Test Organization

### Test Suites

| Test Suite | Purpose | Status |
|------------|---------|--------|
| `auth_test.yaml` | Password file authentication | ✅ Ready |
| `backup_test.yaml` | Backup configuration | ✅ Passing |
| `common_test.yaml` | Common template helpers | ✅ Passing |
| `configmap_test.yaml` | ConfigMap generation | ✅ Passing |
| `deployment_test.yaml` | Deployment mode | ✅ Passing |
| `diagnostic_test.yaml` | Diagnostic mode | ✅ Ready |
| `monitoring_test.yaml` | Prometheus monitoring | ✅ Passing |
| `preinit_test.yaml` | Pre-initialization scripts | ✅ Ready |
| `pvc_test.yaml` | PersistentVolumeClaim | ✅ Passing |
| `retention_test.yaml` | PVC retention policies | ✅ Ready |
| `secret_test.yaml` | Secret generation | ✅ Passing |
| `service_test.yaml` | Service configuration | ✅ Passing |
| `statefulset_test.yaml` | StatefulSet mode | ✅ Passing |
| `user_database_test.yaml` | User/DB management | ✅ Passing |
| `replication_integration_test.yaml` | Replication with features | 🔄 Integration |
| `backup_integration_test.yaml` | Backup with features | 🔄 Integration |
| `e2e_test.yaml` | End-to-end scenarios | 🔄 Integration |

### Test Coverage

#### Features Tested

- ✅ Password file authentication (auth_test.yaml)
- ✅ Diagnostic mode (diagnostic_test.yaml)
- ✅ Pre-initialization scripts (preinit_test.yaml)
- ✅ PVC retention policies (retention_test.yaml)
- ✅ Replication setup
- ✅ Backup configuration
- ✅ Monitoring integration
- ✅ Network policies
- ✅ RBAC configuration

#### Integration Scenarios Tested

- Password files + Replication
- Diagnostic mode + All features
- Pre-init scripts + Replication
- Backup + PVC retention
- Complete HA configurations
- Production-ready secure setups
- Development/debugging scenarios
- Migration scenarios with pre-init

## Writing Tests

### Basic Test Structure

```yaml
suite: test suite name
templates:
  - template.yaml
  - other-template.yaml  # Include all templates that are referenced
tests:
  - it: test description
    template: template.yaml
    set:
      key: value
      statefulset.enabled: true  # Required for statefulset.yaml
    asserts:
      - equal:
          path: spec.field
          value: expected-value
```

### Common Patterns

#### Testing Template Rendering

```yaml
- it: should render when enabled
  template: statefulset.yaml
  set:
    statefulset.enabled: true
  asserts:
    - hasDocuments:
        count: 1
```

#### Testing Conditional Logic

```yaml
- it: should not render when disabled
  template: backup.yaml
  set:
    backup.enabled: false
  asserts:
    - hasDocuments:
        count: 0
```

#### Testing Values

```yaml
- it: should use custom value
  template: statefulset.yaml
  set:
    statefulset.enabled: true
    image.tag: "16.5"
  asserts:
    - equal:
        path: spec.template.spec.containers[0].image
        value: "postgres:16.5"
```

#### Testing Arrays/Lists

```yaml
- it: should contain volume mount
  template: statefulset.yaml
  set:
    statefulset.enabled: true
    postgresql.auth.usePasswordFiles: true
  asserts:
    - contains:
        path: spec.template.spec.containers[0].volumeMounts
        content:
          name: postgresql-password
          mountPath: /opt/bitnami/postgresql/secrets
```

#### Testing Pattern Matching

```yaml
- it: should include script content
  template: replication-scripts.yaml
  set:
    replication.enabled: true
  asserts:
    - matchRegex:
        path: data["setup-replication.sh"]
        pattern: 'pg_basebackup'
```

### Important Requirements

#### 1. Template Inclusion

Always include templates that are referenced by the main template:

```yaml
templates:
  - statefulset.yaml
  - configmap.yaml  # statefulset.yaml includes this for checksum
```

#### 2. Enable Conditions

Set required values to render templates:

```yaml
set:
  statefulset.enabled: true  # Required for statefulset.yaml
  replication.enabled: true  # Required for replication-scripts.yaml
  backup.enabled: true       # Required for backup.yaml
```

#### 3. Valid Assertions

Use helm-unittest valid assertions:

| Valid | Invalid | Alternative |
|-------|---------|-------------|
| `notExists` | `isNull` | Check path doesn't exist |
| Value check | `isNotNull` | Check actual value |
| `matchRegex` | - | Pattern matching |

## Troubleshooting

### Common Issues

#### "no manifest found"

**Cause**: Template not rendering due to missing condition or disabled feature

**Fix**: Set required values to enable template rendering

```yaml
set:
  statefulset.enabled: true
  persistence.enabled: true
```

#### "document index out of range"

**Cause**: Expecting multiple documents but only one rendered

**Fix**: Check hasDocuments count or enable features that create additional documents

```yaml
- it: check document count first
  template: configmap.yaml
  set:
    postgresql.preInitScripts:
      script.sh: "#!/bin/bash"
  asserts:
    - hasDocuments:
        count: 2  # Main + pre-init scripts
```

#### "template not associated"

**Cause**: Referenced template not included in templates list

**Fix**: Add all referenced templates

```yaml
templates:
  - statefulset.yaml
  - configmap.yaml  # Add this if statefulset includes it
```

### Debug Test Failures

#### 1. Check Rendered Output

```bash
helm template test-release . --set statefulset.enabled=true
```

#### 2. Check Specific Values

```bash
helm template test-release . --set statefulset.enabled=true | grep -A 10 "kind: StatefulSet"
```

#### 3. Validate Template Syntax

```bash
helm lint .
```

## CI/CD Integration

### GitHub Actions Example

```yaml
name: Test Helm Chart

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Install Helm
        uses: azure/setup-helm@v3

      - name: Install helm-unittest
        run: helm plugin install https://github.com/helm-unittest/helm-unittest.git

      - name: Run tests
        run: |
          cd charts/postgresql
          helm unittest --color .
```

## Test Development Workflow

1. **Write Test**: Create test case in appropriate test file
2. **Run Test**: `helm unittest -f 'tests/mytest_test.yaml' .`
3. **Fix Issues**: Adjust assertions or values as needed
4. **Verify**: Run full suite `helm unittest .`
5. **Commit**: Add test to version control

## Best Practices

### DO

- ✅ Test both enabled and disabled states
- ✅ Test edge cases and validation
- ✅ Include all referenced templates
- ✅ Use descriptive test names
- ✅ Group related tests in same suite
- ✅ Test integration scenarios

### DON'T

- ❌ Use invalid assertions (isNull, isNotNull)
- ❌ Forget to enable required features
- ❌ Test implementation details
- ❌ Create overly complex test cases
- ❌ Skip integration tests
- ❌ Ignore test failures

## Test Maintenance

### When to Update Tests

- After adding new features
- When changing default values
- When modifying template logic
- After bug fixes
- When deprecating features

### Test Review Checklist

- [ ] All tests pass
- [ ] New features have tests
- [ ] Integration tests cover feature combinations
- [ ] Test names are descriptive
- [ ] No redundant tests
- [ ] Documentation updated

## Getting Help

- **helm-unittest docs**: https://github.com/helm-unittest/helm-unittest
- **Helm docs**: https://helm.sh/docs/
- **Chart issues**: https://github.com/your-repo/helm-charts/issues

## Future Improvements

- [ ] Performance testing
- [ ] Load testing scenarios
- [ ] Chaos engineering tests
- [ ] Security scanning integration
- [ ] Automated coverage reporting
- [ ] E2E tests with real clusters
