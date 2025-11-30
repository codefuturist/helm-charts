#!/usr/bin/env bash
# Comprehensive script to update all pgadmin references to shlink in template files

set -euo pipefail

CHART_DIR="/Users/colin/Developer/Projects/personal/helm-charts/charts/shlink"

echo "🚀 Starting Shlink chart adaptation..."
echo ""

# Function to replace all pgadmin references with shlink
replace_in_file() {
    local file="$1"
    if [[ -f "$file" ]]; then
        echo "  📝 Updating $(basename "$file")..."
        sed -i.bak 's/pgadmin/shlink/g' "$file"
        sed -i.bak 's/pgAdmin/Shlink/g' "$file"
        sed -i.bak 's/PGADMIN/SHLINK/g' "$file"
        sed -i.bak 's/database-admin/url-shortener/g' "$file"
        rm -f "${file}.bak"
    fi
}

# Update _helpers.tpl
echo "1️⃣  Updating template helpers..."
replace_in_file "$CHART_DIR/templates/_helpers.tpl"

# Update all template files
echo "2️⃣  Updating template files..."
for file in "$CHART_DIR/templates"/*.yaml; do
    replace_in_file "$file"
done

# Update NOTES.txt
replace_in_file "$CHART_DIR/templates/NOTES.txt"

# Update test files
echo "3️⃣  Updating test files..."
for file in "$CHART_DIR/templates/tests"/*.yaml; do
    replace_in_file "$file"
done

# Update CI files
echo "4️⃣  Updating CI configuration files..."
for file in "$CHART_DIR/ci"/*.yaml; do
    replace_in_file "$file"
done

# Update unit test files
echo "5️⃣  Updating unit test files..."
for file in "$CHART_DIR/tests"/*.yaml; do
    replace_in_file "$file"
done

# Update documentation
echo "6️⃣  Updating documentation..."
replace_in_file "$CHART_DIR/README.md"
replace_in_file "$CHART_DIR/CHANGELOG.md"
replace_in_file "$CHART_DIR/docs/QUICKSTART.md"
replace_in_file "$CHART_DIR/docs/TESTING.md"

# Update example files
echo "7️⃣  Updating example files..."
for file in "$CHART_DIR/examples"/*.yaml; do
    replace_in_file "$file"
done

# Update scripts
echo "8️⃣  Updating scripts..."
replace_in_file "$CHART_DIR/scripts/test.sh"
replace_in_file "$CHART_DIR/scripts/validate.sh"

echo ""
echo "✅ Basic text replacement complete!"
echo "⚠️  Manual updates still needed for:"
echo "   - Template logic (deployment.yaml, statefulset.yaml)"
echo "   - Service definitions"
echo "   - Secret/ConfigMap structures"
echo "   - NOTES.txt instructions"
echo "   - Documentation content"
