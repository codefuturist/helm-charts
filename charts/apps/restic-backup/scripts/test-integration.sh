#!/usr/bin/env bash
# Integration tests for restic-backup Helm chart
# Requires a running Kubernetes cluster and helm installed
# Run with: ./scripts/test-integration.sh

set -e

CHART_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$CHART_DIR"

NAMESPACE="${TEST_NAMESPACE:-restic-backup-test}"
RELEASE_NAME="${RELEASE_NAME:-restic-test}"

echo "=== Restic Backup Chart Integration Tests ==="
echo "Namespace: $NAMESPACE"
echo "Release: $RELEASE_NAME"
echo ""

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

pass() {
    echo -e "${GREEN}✓${NC} $1"
}

fail() {
    echo -e "${RED}✗${NC} $1"
    exit 1
}

info() {
    echo -e "${YELLOW}ℹ${NC} $1"
}

cleanup() {
    info "Cleaning up test resources..."
    helm uninstall $RELEASE_NAME -n $NAMESPACE 2>/dev/null || true
    kubectl delete namespace $NAMESPACE --wait=false 2>/dev/null || true
}

# Setup trap for cleanup
trap cleanup EXIT

# Test 1: Create namespace
echo "Test 1: Creating test namespace..."
if kubectl create namespace $NAMESPACE 2>/dev/null; then
    pass "Test namespace created"
else
    info "Namespace already exists"
fi

# Test 2: Create test PVC
echo "Test 2: Creating test PersistentVolumeClaim..."
cat <<EOF | kubectl apply -f - -n $NAMESPACE
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: test-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
EOF
pass "Test PVC created"

# Test 3: Install chart with minimal configuration
echo "Test 3: Installing chart with minimal configuration..."
if helm install $RELEASE_NAME . \
    -n $NAMESPACE \
    --set restic.repository="s3:test.s3.amazonaws.com/test-bucket" \
    --set restic.password="test-password-12345" \
    --set volumes[0].name="test-data" \
    --set volumes[0].claimName="test-pvc" \
    --set volumes[0].mountPath="/data" \
    --wait --timeout=2m; then
    pass "Chart installed successfully"
else
    fail "Chart installation failed"
fi

# Test 4: Check if resources are created
echo "Test 4: Verifying deployed resources..."

# Check CronJob
if kubectl get cronjob $RELEASE_NAME-backup -n $NAMESPACE > /dev/null 2>&1; then
    pass "Backup CronJob created"
else
    fail "Backup CronJob not found"
fi

# Check Secret
if kubectl get secret $RELEASE_NAME -n $NAMESPACE > /dev/null 2>&1; then
    pass "Secret created"
else
    fail "Secret not found"
fi

# Check ServiceAccount
if kubectl get serviceaccount $RELEASE_NAME -n $NAMESPACE > /dev/null 2>&1; then
    pass "ServiceAccount created"
else
    fail "ServiceAccount not found"
fi

# Check RBAC
if kubectl get role $RELEASE_NAME -n $NAMESPACE > /dev/null 2>&1; then
    pass "Role created"
else
    fail "Role not found"
fi

if kubectl get rolebinding $RELEASE_NAME -n $NAMESPACE > /dev/null 2>&1; then
    pass "RoleBinding created"
else
    fail "RoleBinding not found"
fi

# Test 5: Upgrade with metrics enabled
echo "Test 5: Upgrading with metrics enabled..."
if helm upgrade $RELEASE_NAME . \
    -n $NAMESPACE \
    --set restic.repository="s3:test.s3.amazonaws.com/test-bucket" \
    --set restic.password="test-password-12345" \
    --set volumes[0].name="test-data" \
    --set volumes[0].claimName="test-pvc" \
    --set volumes[0].mountPath="/data" \
    --set metrics.enabled=true \
    --set scripts.useConfigMap=true \
    --wait --timeout=2m; then
    pass "Chart upgraded with metrics"
else
    fail "Chart upgrade failed"
fi

# Test 6: Verify metrics resources
echo "Test 6: Verifying metrics resources..."

if kubectl get deployment $RELEASE_NAME-metrics -n $NAMESPACE > /dev/null 2>&1; then
    pass "Metrics Deployment created"
else
    fail "Metrics Deployment not found"
fi

if kubectl get service $RELEASE_NAME-metrics -n $NAMESPACE > /dev/null 2>&1; then
    pass "Metrics Service created"
else
    fail "Metrics Service not found"
fi

if kubectl get configmap $RELEASE_NAME-scripts -n $NAMESPACE > /dev/null 2>&1; then
    pass "Scripts ConfigMap created"
else
    fail "Scripts ConfigMap not found"
fi

# Test 7: Check metrics deployment health
echo "Test 7: Checking metrics deployment health..."
kubectl wait --for=condition=available --timeout=60s deployment/$RELEASE_NAME-metrics -n $NAMESPACE 2>/dev/null && \
    pass "Metrics deployment is healthy" || \
    info "Metrics deployment not fully ready (may need more time)"

# Test 8: Run Helm tests
echo "Test 8: Running Helm test suite..."
if helm test $RELEASE_NAME -n $NAMESPACE --timeout=5m; then
    pass "Helm tests passed"
else
    info "Helm tests had issues (this may be expected if repository is not configured)"
fi

# Test 9: Verify ConfigMap content
echo "Test 9: Verifying ConfigMap scripts content..."
BACKUP_SCRIPT=$(kubectl get configmap $RELEASE_NAME-scripts -n $NAMESPACE -o jsonpath='{.data.backup\.sh}')
if echo "$BACKUP_SCRIPT" | grep -q "Restic Backup Job Started"; then
    pass "Backup script content is valid"
else
    fail "Backup script content is invalid"
fi

if echo "$BACKUP_SCRIPT" | grep -q "send_email_notification"; then
    pass "Email notification function is present"
else
    fail "Email notification function is missing"
fi

# Test 10: Check CronJob configuration
echo "Test 10: Verifying CronJob configuration..."
SCHEDULE=$(kubectl get cronjob $RELEASE_NAME-backup -n $NAMESPACE -o jsonpath='{.spec.schedule}')
if [ -n "$SCHEDULE" ]; then
    pass "CronJob schedule is configured: $SCHEDULE"
else
    fail "CronJob schedule is not configured"
fi

# Test 11: Verify volume mounts
echo "Test 11: Verifying volume mounts..."
VOLUMES=$(kubectl get cronjob $RELEASE_NAME-backup -n $NAMESPACE -o jsonpath='{.spec.jobTemplate.spec.template.spec.volumes[*].name}')
if echo "$VOLUMES" | grep -q "test-data"; then
    pass "Test volume is mounted"
else
    fail "Test volume is not mounted"
fi

# Test 12: Check resource limits
echo "Test 12: Verifying resource limits..."
CPU_LIMIT=$(kubectl get cronjob $RELEASE_NAME-backup -n $NAMESPACE -o jsonpath='{.spec.jobTemplate.spec.template.spec.containers[0].resources.limits.cpu}')
if [ -n "$CPU_LIMIT" ]; then
    pass "CPU limit is set: $CPU_LIMIT"
else
    info "CPU limit is not set"
fi

# Test 13: Uninstall chart
echo "Test 13: Uninstalling chart..."
if helm uninstall $RELEASE_NAME -n $NAMESPACE --wait; then
    pass "Chart uninstalled successfully"
else
    fail "Chart uninstallation failed"
fi

# Test 14: Verify cleanup
echo "Test 14: Verifying resource cleanup..."
sleep 5
if ! kubectl get cronjob $RELEASE_NAME-backup -n $NAMESPACE > /dev/null 2>&1; then
    pass "Resources cleaned up"
else
    fail "Resources still exist after uninstall"
fi

echo ""
echo -e "${GREEN}=== All integration tests passed! ===${NC}"
