# Test Suite Summary and Fixes

## Test Results Analysis (v1.7.0)

### Overall Status
- **Total Tests**: 92
- **Passed**: 25 (27%)
- **Failed**: 67 (73%)
- **Errors**: 15

### Passing Test Suites
✅ secret_test.yaml
✅ service_test.yaml  
✅ common_test.yaml (partial)

### Failing Test Suites

#### 1. Template Rendering Issues
**Problem**: Tests don't include required templates or set required values

**Files Affected**:
- All statefulset-based tests
- Tests checking retention policies
- Tests checking replication
- Tests checking pre-init scripts

**Root Causes**:
a) `statefulset.enabled: true` not set (required for statefulset.yaml to render)
b) `configmap.yaml` not included in templates list (statefulset.yaml includes it for checksums)
c) `replication-scripts.yaml` requires `replication.enabled: true`

#### 2. Assertion Method Issues
**Problem**: Using `isNull` and `isNotNull` which aren't valid helm-unittest assertions

**Valid Alternatives**:
- `isNull` → use `notExists` or check with `matchRegex: "^$"`
- `isNotNull` → use conditional checks or value assertions

#### 3. Test Value Mismatches
**Problem**: Tests expect different values than defaults

**Examples**:
- PVC test expects 8Gi, default is 2Gi
- Tests expect specific document counts that don't match

## Fixes Needed

### Phase 1: Template Inclusion (HIGH PRIORITY)
1. Add `configmap.yaml` to all statefulset test templates
2. Add `replication-scripts.yaml` to replication tests
3. Set `statefulset.enabled: true` in all statefulset tests

### Phase 2: Fix Assertions (HIGH PRIORITY)
1. Replace `isNull` with `notExists`
2. Replace `isNotNull` with value checks
3. Fix expected values to match defaults

### Phase 3: Integration Tests (MEDIUM PRIORITY)
1. Fix replication_integration_test.yaml
2. Fix backup_integration_test.yaml
3. Fix e2e_test.yaml

### Phase 4: Expand Coverage (LOW PRIORITY)
1. Add more edge cases
2. Add negative test cases
3. Add performance test scenarios

## Quick Wins to Fix Now

### Fix retention_test.yaml
```yaml
suite: test pvc retention policy
templates:
  - statefulset.yaml
  - configmap.yaml  # ADD THIS
tests:
  - it: should set retention policy when enabled
    template: statefulset.yaml
    set:
      statefulset.enabled: true  # ADD THIS
      persistence.enabled: true
      persistence.retentionPolicy.enabled: true
      # ... rest of test
```

### Fix preinit_test.yaml
```yaml
suite: test pre-initialization scripts
templates:
  - statefulset.yaml
  - configmap.yaml
tests:
  - it: should create pre-init scripts configmap
    template: configmap.yaml
    set:
      statefulset.enabled: true  # ADD THIS
      postgresql.preInitScripts:
        setup.sh: "#!/bin/bash"
    # ... rest of test
```

### Fix replication_integration_test.yaml
```yaml
suite: test replication with new features
templates:
  - statefulset.yaml
  - replication-scripts.yaml
  - configmap.yaml  # ADD THIS
tests:
  - it: should load passwords from files in replication setup script
    template: replication-scripts.yaml
    set:
      statefulset.enabled: true  # ADD THIS
      replication.enabled: true
      postgresql.auth.usePasswordFiles: true
    # ... rest of test
```

## Implementation Strategy

1. **Batch Fix Common Issues** (30 min)
   - Add statefulset.enabled: true to all relevant tests
   - Add configmap.yaml to template lists
   - Add replication-scripts.yaml where needed

2. **Fix Assertion Methods** (15 min)
   - Replace isNull/isNotNull
   - Update expected values

3. **Run and Validate** (15 min)
   - Run full test suite
   - Fix remaining failures
   - Document any known limitations

4. **Document** (10 min)
   - Update TESTING.md
   - Add test coverage report
   - Add troubleshooting guide

## Expected Outcome

After fixes:
- **Target Pass Rate**: 95%+
- **Known Limitations**: Document any tests that can't pass due to helm-unittest limitations
- **CI Ready**: Tests should be stable enough for CI/CD integration
