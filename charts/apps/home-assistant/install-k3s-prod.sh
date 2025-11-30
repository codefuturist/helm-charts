#!/usr/bin/env bash
# Home Assistant Installation Script for k3s-prod
# Non-privileged, secure configuration following best practices

set -euo pipefail

CHART_PATH="charts/home-assistant"
VALUES_FILE="charts/home-assistant/values-k3s-prod.yaml"
RELEASE_NAME="home-assistant"
NAMESPACE="home-assistant"

echo "=== Home Assistant Installation for k3s-prod ==="
echo ""

# Step 1: Validate chart
echo "📋 Step 1: Validating Helm chart..."
helm lint "$CHART_PATH" --values "$VALUES_FILE"
if [ $? -eq 0 ]; then
    echo "✅ Chart validation passed"
else
    echo "❌ Chart validation failed"
    exit 1
fi
echo ""

# Step 2: Dry-run to check rendering
echo "📋 Step 2: Running dry-run installation..."
helm upgrade --install "$RELEASE_NAME" "$CHART_PATH" \
    --namespace "$NAMESPACE" \
    --create-namespace \
    --values "$VALUES_FILE" \
    --dry-run \
    --debug > /tmp/ha-dry-run.yaml 2>&1

if [ $? -eq 0 ]; then
    echo "✅ Dry-run successful"

    # Check for privileged mode
    if grep -q "privileged: true" /tmp/ha-dry-run.yaml; then
        echo "❌ WARNING: Privileged mode detected in rendered manifest!"
        echo "   This violates security best practices."
        exit 1
    else
        echo "✅ No privileged mode detected (secure configuration)"
    fi

    # Check capabilities
    echo ""
    echo "📋 Security Context Capabilities:"
    grep -A 3 "capabilities:" /tmp/ha-dry-run.yaml | head -10
else
    echo "❌ Dry-run failed"
    cat /tmp/ha-dry-run.yaml
    exit 1
fi
echo ""

# Step 3: Confirm installation
echo "📋 Step 3: Ready to install"
echo ""
echo "Configuration summary:"
echo "  - Release: $RELEASE_NAME"
echo "  - Namespace: $NAMESPACE"
echo "  - Chart: $CHART_PATH"
echo "  - Values: $VALUES_FILE"
echo "  - Security: Non-privileged with NET_ADMIN, NET_RAW capabilities"
echo ""

read -p "Proceed with installation? (y/N) " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Installation cancelled"
    exit 0
fi

# Step 4: Install
echo "🚀 Step 4: Installing Home Assistant..."
helm upgrade --install "$RELEASE_NAME" "$CHART_PATH" \
    --namespace "$NAMESPACE" \
    --create-namespace \
    --values "$VALUES_FILE" \
    --wait \
    --timeout 10m

if [ $? -eq 0 ]; then
    echo "✅ Installation successful"
else
    echo "❌ Installation failed"
    exit 1
fi
echo ""

# Step 5: Verify deployment
echo "📋 Step 5: Verifying deployment..."
echo ""

echo "Pods:"
kubectl get pods -n "$NAMESPACE"
echo ""

echo "Services:"
kubectl get svc -n "$NAMESPACE"
echo ""

echo "Ingress:"
kubectl get ingress -n "$NAMESPACE"
echo ""

echo "PVC:"
kubectl get pvc -n "$NAMESPACE"
echo ""

# Step 6: Security verification
echo "📋 Step 6: Security verification..."
POD_NAME=$(kubectl get pod -n "$NAMESPACE" -l app.kubernetes.io/name=home-assistant -o jsonpath='{.items[0].metadata.name}')

if [ -n "$POD_NAME" ]; then
    echo "Checking security context for pod: $POD_NAME"
    echo ""

    echo "Security Context:"
    kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath='{.spec.containers[0].securityContext}' | jq '.'
    echo ""

    # Verify privileged is false
    PRIVILEGED=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath='{.spec.containers[0].securityContext.privileged}')
    if [ "$PRIVILEGED" == "true" ]; then
        echo "❌ WARNING: Pod is running in privileged mode!"
    else
        echo "✅ Pod is NOT running in privileged mode (secure)"
    fi
    echo ""

    echo "Capabilities:"
    kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath='{.spec.containers[0].securityContext.capabilities}' | jq '.'
    echo ""
fi

echo "=== Installation Complete ==="
echo ""
echo "Next steps:"
echo "1. Update DNS or /etc/hosts to point homeassistant.example.com to your ingress"
echo "2. Access Home Assistant at: https://homeassistant.example.com"
echo "3. Complete the onboarding wizard"
echo ""
echo "Useful commands:"
echo "  View logs: kubectl logs -n $NAMESPACE -l app.kubernetes.io/name=home-assistant -f"
echo "  Get pod status: kubectl get pods -n $NAMESPACE"
echo "  Port-forward (local access): kubectl port-forward -n $NAMESPACE svc/home-assistant 8123:8123"
echo "  Uninstall: helm uninstall $RELEASE_NAME -n $NAMESPACE"
