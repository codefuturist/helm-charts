#!/usr/bin/env bash
# Quick validation script for Semaphore chart

set -e

CHART_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Testing Semaphore Helm Chart..."
echo ""

# Test 1: Lint
echo "1. Running helm lint..."
helm lint "$CHART_DIR" \
  --quiet && echo "✓ Lint passed" || { echo "✗ Lint failed"; exit 1; }

# Test 2: Template with default values
echo "2. Testing default values..."
helm template test "$CHART_DIR" > /dev/null 2>&1 && \
  echo "  ✓ Default values passed" || \
  { echo "  ✗ Default values failed"; exit 1; }

# Test 3: Template with CI configs
echo "3. Testing CI configurations..."
for config in "$CHART_DIR"/ci/*.yaml; do
  [ -f "$config" ] || continue
  name=$(basename "$config")
  echo "  - Testing $name..."
  helm template test "$CHART_DIR" -f "$config" > /dev/null 2>&1 && \
    echo "    ✓ $name passed" || \
    { echo "    ✗ $name failed"; exit 1; }
done

# Test 4: Template with example configs
echo "4. Testing example configurations..."
for config in "$CHART_DIR"/examples/values-*.yaml; do
  [ -f "$config" ] || continue
  name=$(basename "$config")
  echo "  - Testing $name..."
  helm template test "$CHART_DIR" -f "$config" > /dev/null 2>&1 && \
    echo "    ✓ $name passed" || \
    { echo "    ✗ $name failed"; exit 1; }
done

# Test 5: Count resources
echo "5. Validating resource generation..."
RESOURCES=$(helm template test "$CHART_DIR" | grep "^kind:" | wc -l | tr -d ' ')
echo "  Generated $RESOURCES resources ✓"

# Test 6: Validate StatefulSet mode
echo "6. Testing StatefulSet mode..."
helm template test "$CHART_DIR" \
  --set controller.type=statefulset \
  --set persistence.volumeClaimTemplates.enabled=true \
  > /dev/null 2>&1 && \
  echo "  ✓ StatefulSet mode passed" || \
  { echo "  ✗ StatefulSet mode failed"; exit 1; }

# Test 7: Validate Ingress
echo "7. Testing Ingress..."
helm template test "$CHART_DIR" \
  --set ingress.enabled=true \
  --set ingress.hosts[0].host=semaphore.example.com \
  > /dev/null 2>&1 && \
  echo "  ✓ Ingress passed" || \
  { echo "  ✗ Ingress failed"; exit 1; }

echo ""
echo "All validation tests passed! ✓"
