#!/usr/bin/env bash
# OpenEBS Storage Class Verification for Home Assistant

set -euo pipefail

echo "=== OpenEBS Storage Class Verification ==="
echo ""

echo "📋 Checking available storage classes..."
echo ""

# Get all storage classes
kubectl get storageclass -o custom-columns=NAME:.metadata.name,PROVISIONER:.provisioner,RECLAIM:.reclaimPolicy --no-headers 2>&1 | while read -r line; do
    if echo "$line" | grep -q "openebs"; then
        echo "✅ Found OpenEBS storage class: $line"
    else
        echo "   $line"
    fi
done

echo ""
echo "📋 OpenEBS Storage Classes Details:"
echo ""

# Show OpenEBS-specific storage classes with more details
kubectl get sc -o json | jq -r '.items[] | select(.provisioner | contains("openebs")) |
  "Name: \(.metadata.name)\nProvisioner: \(.provisioner)\nReclaim Policy: \(.reclaimPolicy)\nVolume Binding Mode: \(.volumeBindingMode)\n---"' 2>/dev/null || {
    echo "Checking for OpenEBS storage classes..."
    kubectl get sc 2>&1 | grep -i openebs || echo "❌ No OpenEBS storage classes found"
}

echo ""
echo "📋 Common OpenEBS Storage Class Options:"
echo ""
echo "1. openebs-hostpath         - Local hostpath (single node)"
echo "2. openebs-device          - Local device (block device)"
echo "3. openebs-jiva-default    - Jiva volume (replicated)"
echo "4. openebs-cstor-default   - cStor volume (replicated, recommended)"
echo "5. openebs-lvmpv           - LVM volume (local)"
echo ""

echo "📋 Current configuration in values-k3s-prod.yaml:"
echo ""
grep -A 2 "storageClassName:" /Users/colin/Developer/Projects/personal/helm-charts/charts/home-assistant/values-k3s-prod.yaml || echo "Configuration file not found"

echo ""
echo "📋 Recommendations:"
echo ""
echo "For Home Assistant with single-node cluster:"
echo "  - Use: openebs-hostpath (simplest, local storage)"
echo ""
echo "For multi-node cluster with replication:"
echo "  - Use: openebs-cstor-default or openebs-jiva-default"
echo ""
echo "For performance with local storage:"
echo "  - Use: openebs-lvmpv or openebs-device"
echo ""

echo "To update the storage class in values-k3s-prod.yaml:"
echo '  sed -i "" "s/storageClassName: openebs/storageClassName: openebs-hostpath/" charts/home-assistant/values-k3s-prod.yaml'
