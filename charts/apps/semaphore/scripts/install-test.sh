#!/bin/bash
# Installation script for Semaphore Helm chart to k3s-development-k3s-testbox

set -e

CHART_PATH="/Users/colin/Developer/Projects/personal/helm-charts/charts/semaphore"
VALUES_FILE="$CHART_PATH/test-install-values.yaml"
NAMESPACE="semaphore"
RELEASE_NAME="semaphore-test"
KUBE_CONTEXT="k3s-development-k3s-testbox"

echo "==================================================================="
echo "Semaphore Helm Chart Installation"
echo "==================================================================="
echo ""
echo "Chart Path: $CHART_PATH"
echo "Values File: $VALUES_FILE"
echo "Namespace: $NAMESPACE"
echo "Release Name: $RELEASE_NAME"
echo "Kube Context: $KUBE_CONTEXT"
echo ""

# Check if helm is installed
if ! command -v helm &> /dev/null; then
    echo "❌ Error: helm is not installed"
    exit 1
fi

# Check if kubectl is installed
if ! command -v kubectl &> /dev/null; then
    echo "❌ Error: kubectl is not installed"
    exit 1
fi

echo "✅ Helm and kubectl are available"
echo ""

# Switch kubectl context
echo "🔄 Switching to context: $KUBE_CONTEXT"
kubectl config use-context "$KUBE_CONTEXT" || { echo "❌ Failed to switch context"; exit 1; }
echo ""

# Verify cluster access
echo "🔍 Verifying cluster access..."
kubectl get nodes || { echo "❌ Cannot access cluster"; exit 1; }
echo ""

# Lint the chart
echo "🔍 Linting chart..."
helm lint "$CHART_PATH" || { echo "⚠️  Lint warnings (may be non-critical)"; }
echo ""

# Dry-run installation
echo "🧪 Performing dry-run..."
helm install "$RELEASE_NAME" "$CHART_PATH" \
  --namespace "$NAMESPACE" \
  --create-namespace \
  --values "$VALUES_FILE" \
  --kube-context "$KUBE_CONTEXT" \
  --dry-run --debug > /tmp/semaphore-dry-run.yaml 2>&1

if [ $? -eq 0 ]; then
    echo "✅ Dry-run successful"
    echo "   Output saved to: /tmp/semaphore-dry-run.yaml"
else
    echo "❌ Dry-run failed. Check /tmp/semaphore-dry-run.yaml for details"
    exit 1
fi
echo ""

# Actual installation
echo "🚀 Installing chart..."
helm install "$RELEASE_NAME" "$CHART_PATH" \
  --namespace "$NAMESPACE" \
  --create-namespace \
  --values "$VALUES_FILE" \
  --kube-context "$KUBE_CONTEXT" \
  --wait --timeout 5m

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Installation successful!"
    echo ""
    echo "==================================================================="
    echo "Post-Installation Information"
    echo "==================================================================="
    echo ""

    # Get pod status
    echo "📦 Pod Status:"
    kubectl get pods -n "$NAMESPACE" -l "app.kubernetes.io/instance=$RELEASE_NAME"
    echo ""

    # Get service status
    echo "🌐 Service Status:"
    kubectl get svc -n "$NAMESPACE" -l "app.kubernetes.io/instance=$RELEASE_NAME"
    echo ""

    # Get PVC status
    echo "💾 Persistent Volume Claims:"
    kubectl get pvc -n "$NAMESPACE"
    echo ""

    echo "==================================================================="
    echo "Access Instructions"
    echo "==================================================================="
    echo ""
    echo "Since service type is NodePort (30300), access via:"
    echo "  - http://<node-ip>:30300"
    echo ""
    echo "Or use port-forward:"
    echo "  kubectl port-forward -n $NAMESPACE svc/$RELEASE_NAME 3000:3000"
    echo "  Then visit: http://localhost:3000"
    echo ""
    echo "Default credentials:"
    echo "  Username: admin"
    echo "  Password: testpassword123"
    echo ""
    echo "View logs:"
    echo "  kubectl logs -n $NAMESPACE -l app.kubernetes.io/instance=$RELEASE_NAME -f"
    echo ""
    echo "Uninstall:"
    echo "  helm uninstall $RELEASE_NAME -n $NAMESPACE"
    echo ""
else
    echo "❌ Installation failed"
    echo ""
    echo "Debug with:"
    echo "  kubectl get events -n $NAMESPACE --sort-by='.lastTimestamp'"
    echo "  kubectl describe pod -n $NAMESPACE -l app.kubernetes.io/instance=$RELEASE_NAME"
    exit 1
fi

echo ""

# Dry-run installation
echo "🧪 Performing dry-run..."
helm install "$RELEASE_NAME" "$CHART_PATH" \
  --namespace "$NAMESPACE" \
  --create-namespace \
  --values "$VALUES_FILE" \
  --kube-context "$KUBE_CONTEXT" \
  --dry-run --debug > /tmp/uptime-kuma-dry-run.yaml 2>&1

if [ $? -eq 0 ]; then
    echo "✅ Dry-run successful"
    echo "   Output saved to: /tmp/uptime-kuma-dry-run.yaml"
else
    echo "❌ Dry-run failed. Check /tmp/uptime-kuma-dry-run.yaml for details"
    exit 1
fi
echo ""

# Actual installation
echo "🚀 Installing chart..."
helm install "$RELEASE_NAME" "$CHART_PATH" \
  --namespace "$NAMESPACE" \
  --create-namespace \
  --values "$VALUES_FILE" \
  --kube-context "$KUBE_CONTEXT" \
  --wait --timeout 5m

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Installation successful!"
    echo ""
    echo "==================================================================="
    echo "Post-Installation Information"
    echo "==================================================================="
    echo ""

    # Get pod status
    echo "📦 Pod Status:"
    kubectl get pods -n "$NAMESPACE" -l "app.kubernetes.io/instance=$RELEASE_NAME"
    echo ""

    # Get service status
    echo "🌐 Service Status:"
    kubectl get svc -n "$NAMESPACE" -l "app.kubernetes.io/instance=$RELEASE_NAME"
    echo ""

    # Get PVC status
    echo "💾 Persistent Volume Claims:"
    kubectl get pvc -n "$NAMESPACE"
    echo ""

    echo "==================================================================="
    echo "Access Instructions"
    echo "==================================================================="
    echo ""
    echo "Since service type is NodePort (30301), access via:"
    echo "  - http://<node-ip>:30301"
    echo ""
    echo "Or use port-forward:"
    echo "  kubectl port-forward -n $NAMESPACE svc/$RELEASE_NAME 3001:3001"
    echo "  Then visit: http://localhost:3001"
    echo ""
    echo "View logs:"
    echo "  kubectl logs -n $NAMESPACE -l app.kubernetes.io/instance=$RELEASE_NAME -f"
    echo ""
    echo "Uninstall:"
    echo "  helm uninstall $RELEASE_NAME -n $NAMESPACE"
    echo ""
else
    echo "❌ Installation failed"
    echo ""
    echo "Debug with:"
    echo "  kubectl get events -n $NAMESPACE --sort-by='.lastTimestamp'"
    echo "  kubectl describe pod -n $NAMESPACE -l app.kubernetes.io/instance=$RELEASE_NAME"
    exit 1
fi
