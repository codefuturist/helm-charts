#!/bin/bash
# Validation script for generated Helm charts

set -e

CHART_DIR="$1"

if [ -z "$CHART_DIR" ]; then
    echo "Usage: ./validate-chart.sh <chart-directory>"
    exit 1
fi

if [ ! -d "$CHART_DIR" ]; then
    echo "Error: Directory $CHART_DIR does not exist"
    exit 1
fi

echo "🔍 Validating Helm chart: $CHART_DIR"
echo ""

# Check if helm is installed
if ! command -v helm &> /dev/null; then
    echo "❌ Helm is not installed. Please install Helm first."
    exit 1
fi

# Lint the chart
echo "1. Running helm lint..."
if helm lint "$CHART_DIR"; then
    echo "✓ Lint passed"
else
    echo "✗ Lint failed"
    exit 1
fi

echo ""

# Dry run template
echo "2. Testing template rendering..."
if helm template test-release "$CHART_DIR" > /dev/null; then
    echo "✓ Template rendering passed"
else
    echo "✗ Template rendering failed"
    exit 1
fi

echo ""

# Check for required files
echo "3. Checking required files..."
REQUIRED_FILES=(
    "Chart.yaml"
    "values.yaml"
    "templates/_helpers.tpl"
    "templates/deployment.yaml"
    "templates/service.yaml"
)

for file in "${REQUIRED_FILES[@]}"; do
    if [ -f "$CHART_DIR/$file" ]; then
        echo "  ✓ $file exists"
    else
        echo "  ✗ $file is missing"
        exit 1
    fi
done

echo ""

# Check Chart.yaml structure
echo "4. Validating Chart.yaml..."
if grep -q "apiVersion:" "$CHART_DIR/Chart.yaml" && \
   grep -q "name:" "$CHART_DIR/Chart.yaml" && \
   grep -q "version:" "$CHART_DIR/Chart.yaml"; then
    echo "✓ Chart.yaml is valid"
else
    echo "✗ Chart.yaml is missing required fields"
    exit 1
fi

echo ""

# Dry run install
echo "5. Testing dry-run installation..."
if helm install test-release "$CHART_DIR" --dry-run --debug > /dev/null 2>&1; then
    echo "✓ Dry-run installation passed"
else
    echo "✗ Dry-run installation failed"
    exit 1
fi

echo ""
echo "✅ All validation checks passed!"
echo ""
echo "Next steps:"
echo "  1. Review the generated values.yaml"
echo "  2. Customize templates as needed"
echo "  3. Test in a real cluster: helm install my-release $CHART_DIR"
