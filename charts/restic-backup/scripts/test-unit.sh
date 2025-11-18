#!/usr/bin/env bash
# Unit tests for restic-backup Helm chart
# Run with: ./scripts/test-unit.sh

set -e

CHART_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$CHART_DIR"

echo "=== Restic Backup Chart Unit Tests ==="
echo ""

# Test counter
TESTS_PASSED=0
TESTS_FAILED=0

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Helper functions
pass() {
    echo -e "${GREEN}✓${NC} $1"
    ((TESTS_PASSED++))
}

fail() {
    echo -e "${RED}✗${NC} $1"
    ((TESTS_FAILED++))
}

warn() {
    echo -e "${YELLOW}⚠${NC} $1"
}

# Test 1: Helm lint
echo "Test 1: Running Helm lint..."
if helm lint . > /dev/null 2>&1; then
    pass "Helm lint passed"
else
    fail "Helm lint failed"
fi

# Test 2: Chart.yaml validation
echo "Test 2: Validating Chart.yaml..."
if [ -f "Chart.yaml" ]; then
    if python3 -c "import yaml; yaml.safe_load(open('Chart.yaml'))" 2>/dev/null; then
        pass "Chart.yaml is valid YAML"
    else
        fail "Chart.yaml has invalid YAML syntax"
    fi

    # Check required fields
    if grep -q "^version:" Chart.yaml && grep -q "^name:" Chart.yaml && grep -q "^description:" Chart.yaml; then
        pass "Chart.yaml has required fields"
    else
        fail "Chart.yaml missing required fields"
    fi
else
    fail "Chart.yaml not found"
fi

# Test 3: values.yaml validation
echo "Test 3: Validating values.yaml..."
if [ -f "values.yaml" ]; then
    if python3 -c "import yaml; yaml.safe_load(open('values.yaml'))" 2>/dev/null; then
        pass "values.yaml is valid YAML"
    else
        fail "values.yaml has invalid YAML syntax"
    fi
else
    fail "values.yaml not found"
fi

# Test 4: Template rendering with minimal config
echo "Test 4: Testing template rendering with minimal config..."
if helm template test . -f examples/values-minimal.yaml > /dev/null 2>&1; then
    pass "Templates render with minimal configuration"
else
    fail "Templates fail to render with minimal configuration"
fi

# Test 5: Template rendering with all features enabled
echo "Test 5: Testing template rendering with all features..."
if helm template test . -f test-values.yaml > /dev/null 2>&1; then
    pass "Templates render with all features enabled"
else
    fail "Templates fail to render with all features"
fi

# Test 6: Check for required templates
echo "Test 6: Checking for required templates..."
REQUIRED_TEMPLATES=(
    "templates/cronjob-backup.yaml"
    "templates/secret.yaml"
    "templates/serviceaccount.yaml"
    "templates/role.yaml"
    "templates/rolebinding.yaml"
)

for template in "${REQUIRED_TEMPLATES[@]}"; do
    if [ -f "$template" ]; then
        pass "Template exists: $template"
    else
        fail "Template missing: $template"
    fi
done

# Test 7: Check new feature templates
echo "Test 7: Checking new feature templates..."
NEW_TEMPLATES=(
    "templates/configmap-scripts.yaml"
    "templates/deployment-metrics.yaml"
    "templates/service.yaml"
)

for template in "${NEW_TEMPLATES[@]}"; do
    if [ -f "$template" ]; then
        pass "New template exists: $template"
    else
        fail "New template missing: $template"
    fi
done

# Test 8: Validate metrics configuration
echo "Test 8: Testing metrics configuration..."
OUTPUT=$(helm template test . -f test-values.yaml --set metrics.enabled=true 2>&1)
if echo "$OUTPUT" | grep -q "kind: Deployment" && echo "$OUTPUT" | grep -q "kind: Service"; then
    pass "Metrics deployment and service are generated"
else
    fail "Metrics resources not generated correctly"
fi

# Test 9: Validate ServiceMonitor
echo "Test 9: Testing ServiceMonitor configuration..."
OUTPUT=$(helm template test . -f test-values.yaml --set metrics.enabled=true --set serviceMonitor.enabled=true 2>&1)
if echo "$OUTPUT" | grep -q "kind: ServiceMonitor"; then
    pass "ServiceMonitor is generated when enabled"
else
    fail "ServiceMonitor not generated"
fi

# Test 10: Validate ConfigMap scripts
echo "Test 10: Testing ConfigMap scripts..."
OUTPUT=$(helm template test . -f test-values.yaml --set scripts.useConfigMap=true 2>&1)
if echo "$OUTPUT" | grep -q "kind: ConfigMap" && echo "$OUTPUT" | grep -q "backup.sh"; then
    pass "ConfigMap with scripts is generated"
else
    fail "ConfigMap scripts not generated correctly"
fi

# Test 11: Check for hooks support
echo "Test 11: Testing pre/post backup hooks..."
OUTPUT=$(helm template test . -f examples/values-production.yaml 2>&1)
if echo "$OUTPUT" | grep -q "initContainers:" || echo "$OUTPUT" | grep -q "preBackup"; then
    pass "Pre-backup hooks are supported"
else
    warn "Pre-backup hooks configuration not found"
fi

# Test 12: Validate activeDeadlineSeconds
echo "Test 12: Testing job timeout configuration..."
OUTPUT=$(helm template test . -f test-values.yaml 2>&1)
if echo "$OUTPUT" | grep -q "activeDeadlineSeconds: 3600"; then
    pass "Job timeout (activeDeadlineSeconds) is configured"
else
    warn "Job timeout configuration not found"
fi

# Test 13: Check example files
echo "Test 13: Validating example files..."
EXAMPLE_FILES=(
    "examples/values-minimal.yaml"
    "examples/values-production.yaml"
)

for example in "${EXAMPLE_FILES[@]}"; do
    if [ -f "$example" ]; then
        if python3 -c "import yaml; yaml.safe_load(open('$example'))" 2>/dev/null; then
            pass "Example file valid: $example"
        else
            fail "Example file has invalid YAML: $example"
        fi
    else
        fail "Example file missing: $example"
    fi
done

# Test 14: Test files exist
echo "Test 14: Checking test files..."
TEST_FILES=(
    "templates/tests/test-connection.yaml"
    "templates/tests/test-metrics.yaml"
    "templates/tests/test-backup-job.yaml"
    "templates/tests/test-rbac.yaml"
    "templates/tests/test-secrets.yaml"
)

for test_file in "${TEST_FILES[@]}"; do
    if [ -f "$test_file" ]; then
        pass "Test file exists: $test_file"
    else
        fail "Test file missing: $test_file"
    fi
done

# Test 15: Validate RBAC resources
echo "Test 15: Testing RBAC resources..."
OUTPUT=$(helm template test . -f test-values.yaml --set rbac.create=true 2>&1)
if echo "$OUTPUT" | grep -q "kind: Role" && echo "$OUTPUT" | grep -q "kind: RoleBinding"; then
    pass "RBAC resources are generated"
else
    fail "RBAC resources not generated"
fi

# Test 16: Check metrics exporter permissions
echo "Test 16: Testing metrics exporter RBAC permissions..."
OUTPUT=$(helm template test . -f test-values.yaml --set metrics.enabled=true --set rbac.create=true 2>&1)
if echo "$OUTPUT" | grep -q "apiGroups.*batch" && echo "$OUTPUT" | grep -q "resources.*jobs"; then
    pass "Metrics exporter has job permissions"
else
    warn "Metrics exporter job permissions not found"
fi

# Summary
echo ""
echo "=== Test Summary ==="
echo -e "${GREEN}Passed: $TESTS_PASSED${NC}"
if [ $TESTS_FAILED -gt 0 ]; then
    echo -e "${RED}Failed: $TESTS_FAILED${NC}"
    exit 1
else
    echo -e "${GREEN}All tests passed!${NC}"
    exit 0
fi
