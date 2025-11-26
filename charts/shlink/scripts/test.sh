#!/usr/bin/env bash
# Shlink Helm Chart Test Script
# Tests chart rendering and validation across multiple configurations

set -e

CHART_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CHART_NAME="shlink"
TEST_NAMESPACE="shlink-test"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "================================================"
echo "Shlink Helm Chart Test Suite"
echo "================================================"
echo ""

# Function to print test results
print_result() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✓${NC} $2"
    else
        echo -e "${RED}✗${NC} $2"
        exit 1
    fi
}

# Function to print info
print_info() {
    echo -e "${YELLOW}→${NC} $1"
}

# Test 1: Chart linting
print_info "Test 1: Running helm lint..."
if helm lint "$CHART_DIR" > /dev/null 2>&1; then
    print_result 0 "Helm lint passed"
else
    helm lint "$CHART_DIR"
    print_result 1 "Helm lint failed"
fi

# Test 2: Template rendering with default values
print_info "Test 2: Rendering templates with default values..."
if helm template test "$CHART_DIR" \
    --set shlink.email=admin@example.com \
    --set shlink.password=test123 \
    --namespace "$TEST_NAMESPACE" > /dev/null 2>&1; then
    print_result 0 "Default values template rendering passed"
else
    print_result 1 "Default values template rendering failed"
fi

# Test 3: CI test configurations
CI_DIR="$CHART_DIR/ci"
if [ -d "$CI_DIR" ]; then
    print_info "Test 3: Testing CI configurations..."
    CI_TESTS=0
    CI_PASSED=0

    for test_file in "$CI_DIR"/*.yaml; do
        test_name=$(basename "$test_file" .yaml)
        CI_TESTS=$((CI_TESTS + 1))

        print_info "  Testing: $test_name"

        if helm template test "$CHART_DIR" \
            -f "$test_file" \
            --namespace "$TEST_NAMESPACE" > /dev/null 2>&1; then
            CI_PASSED=$((CI_PASSED + 1))
            echo -e "    ${GREEN}✓${NC} $test_name passed"
        else
            echo -e "    ${RED}✗${NC} $test_name failed"
            helm template test "$CHART_DIR" -f "$test_file" --namespace "$TEST_NAMESPACE"
            exit 1
        fi
    done

    print_result 0 "All $CI_PASSED/$CI_TESTS CI configurations passed"
else
    print_info "Test 3: No CI configurations found (skipping)"
fi

# Test 4: Example configurations
EXAMPLES_DIR="$CHART_DIR/examples"
if [ -d "$EXAMPLES_DIR" ]; then
    print_info "Test 4: Testing example configurations..."
    EXAMPLE_TESTS=0
    EXAMPLE_PASSED=0

    for example_file in "$EXAMPLES_DIR"/values-*.yaml; do
        if [ -f "$example_file" ]; then
            example_name=$(basename "$example_file" .yaml)
            EXAMPLE_TESTS=$((EXAMPLE_TESTS + 1))

            print_info "  Testing: $example_name"

            if helm template test "$CHART_DIR" \
                -f "$example_file" \
                --namespace "$TEST_NAMESPACE" > /dev/null 2>&1; then
                EXAMPLE_PASSED=$((EXAMPLE_PASSED + 1))
                echo -e "    ${GREEN}✓${NC} $example_name passed"
            else
                echo -e "    ${RED}✗${NC} $example_name failed"
                helm template test "$CHART_DIR" -f "$example_file" --namespace "$TEST_NAMESPACE"
                exit 1
            fi
        fi
    done

    if [ $EXAMPLE_TESTS -gt 0 ]; then
        print_result 0 "All $EXAMPLE_PASSED/$EXAMPLE_TESTS example configurations passed"
    else
        print_info "Test 4: No example files found (skipping)"
    fi
else
    print_info "Test 4: No examples directory found (skipping)"
fi

# Test 5: Resource count validation
print_info "Test 5: Validating resource counts..."
RESOURCE_COUNT=$(helm template test "$CHART_DIR" \
    --set shlink.email=admin@example.com \
    --set shlink.password=test123 \
    --namespace "$TEST_NAMESPACE" | grep -c "^kind:")

if [ "$RESOURCE_COUNT" -ge 5 ]; then
    print_result 0 "Resource count validation passed ($RESOURCE_COUNT resources)"
else
    print_result 1 "Resource count validation failed (expected >= 5, got $RESOURCE_COUNT)"
fi

# Test 6: StatefulSet controller
print_info "Test 6: Testing StatefulSet controller..."
STATEFULSET_COUNT=$(helm template test "$CHART_DIR" \
    --set shlink.email=admin@example.com \
    --set shlink.password=test123 \
    --set controller.type=statefulset \
    --namespace "$TEST_NAMESPACE" | grep -c "kind: StatefulSet")

if [ "$STATEFULSET_COUNT" -eq 1 ]; then
    print_result 0 "StatefulSet controller test passed"
else
    print_result 1 "StatefulSet controller test failed"
fi

# Test 7: Deployment controller (default)
print_info "Test 7: Testing Deployment controller..."
DEPLOYMENT_COUNT=$(helm template test "$CHART_DIR" \
    --set shlink.email=admin@example.com \
    --set shlink.password=test123 \
    --set controller.type=deployment \
    --namespace "$TEST_NAMESPACE" | grep -c "kind: Deployment")

if [ "$DEPLOYMENT_COUNT" -eq 1 ]; then
    print_result 0 "Deployment controller test passed"
else
    print_result 1 "Deployment controller test failed"
fi

# Test 8: HPA enablement
print_info "Test 8: Testing HPA enablement..."
HPA_COUNT=$(helm template test "$CHART_DIR" \
    --set shlink.email=admin@example.com \
    --set shlink.password=test123 \
    --set hpa.enabled=true \
    --namespace "$TEST_NAMESPACE" | grep -c "kind: HorizontalPodAutoscaler")

if [ "$HPA_COUNT" -eq 1 ]; then
    print_result 0 "HPA enablement test passed"
else
    print_result 1 "HPA enablement test failed"
fi

# Test 9: ServiceMonitor enablement
print_info "Test 9: Testing ServiceMonitor enablement..."
SM_COUNT=$(helm template test "$CHART_DIR" \
    --set shlink.email=admin@example.com \
    --set shlink.password=test123 \
    --set monitoring.serviceMonitor.enabled=true \
    --namespace "$TEST_NAMESPACE" | grep -c "kind: ServiceMonitor")

if [ "$SM_COUNT" -eq 1 ]; then
    print_result 0 "ServiceMonitor enablement test passed"
else
    print_result 1 "ServiceMonitor enablement test failed"
fi

# Test 10: PrometheusRule enablement
print_info "Test 10: Testing PrometheusRule enablement..."
PR_COUNT=$(helm template test "$CHART_DIR" \
    --set shlink.email=admin@example.com \
    --set shlink.password=test123 \
    --set monitoring.prometheusRule.enabled=true \
    --set-json 'monitoring.prometheusRule.rules=[{"alert":"Test","expr":"up==0"}]' \
    --namespace "$TEST_NAMESPACE" | grep -c "kind: PrometheusRule")

if [ "$PR_COUNT" -eq 1 ]; then
    print_result 0 "PrometheusRule enablement test passed"
else
    print_result 1 "PrometheusRule enablement test failed"
fi

echo ""
echo "================================================"
echo -e "${GREEN}All tests passed!${NC}"
echo "================================================"
