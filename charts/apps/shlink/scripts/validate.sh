#!/usr/bin/env bash
# Quick validation script for Shlink chart

set -e

CHART_DIR="/Users/colin/Developer/Projects/personal/helm-charts/charts/shlink"

echo "Testing Shlink Helm Chart..."
echo ""

# Test 1: Lint
echo "1. Running helm lint..."
helm lint "$CHART_DIR" \
  --set shlink.email=admin@example.com \
  --set shlink.password=test123 \
  --quiet && echo "✓ Lint passed" || { echo "✗ Lint failed"; exit 1; }

# Test 2: Template with CI configs
echo "2. Testing CI configurations..."
for config in "$CHART_DIR"/ci/*.yaml; do
  name=$(basename "$config")
  echo "  - Testing $name..."
  helm template test "$CHART_DIR" -f "$config" > /dev/null 2>&1 && \
    echo "    ✓ $name passed" || \
    { echo "    ✗ $name failed"; exit 1; }
done

# Test 3: Count resources
echo "3. Validating resource generation..."
RESOURCES=$(helm template test "$CHART_DIR" \
  --set shlink.email=admin@example.com \
  --set shlink.password=test123 | grep "^kind:" | wc -l)
echo "  Generated $RESOURCES resources ✓"

echo ""
echo "All validation tests passed! ✓"
