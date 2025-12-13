# Chart Template CI Tests

This directory contains CI test configurations for the chart template. These tests are automatically run by Chart Testing (ct) to validate the chart before release.

## Test Configurations

| File | Purpose | Key Features Tested |
|------|---------|-------------------|
| `01-default-values.yaml` | Default configuration | Basic deployment with minimal settings |
| `02-statefulset-controller.yaml` | StatefulSet controller | StatefulSet with volumeClaimTemplates |
| `03-security-hardening.yaml` | Security hardening | Security contexts, NetworkPolicy, RBAC |
| `04-monitoring-enabled.yaml` | Monitoring stack | ServiceMonitor, PrometheusRule, HPA, PDB |
| `05-extra-containers.yaml` | Extensibility | Init containers, sidecars, custom volumes |
| `06-ingress-enabled.yaml` | Ingress | Ingress with TLS and annotations |
| `07-advanced-scheduling.yaml` | Pod scheduling | Topology spread, affinity, DNS config |
| `08-diagnostic-mode.yaml` | Troubleshooting | Diagnostic mode configuration |

## Running Tests Locally

### Prerequisites

- Helm 3.x installed
- Chart Testing (ct) tool installed (optional)

### Run All Tests

```bash
# From the chart directory
for f in ci/*.yaml; do
  echo "Testing $f..."
  helm template test . -f "$f" --debug > /dev/null && echo "✓ $f passed" || echo "✗ $f failed"
done
```

### Run Specific Test

```bash
# Test a specific CI configuration
helm template test . -f ci/01-default-values.yaml --debug

# Validate syntax only
helm lint . -f ci/01-default-values.yaml
```

### Run Chart Testing

```bash
# From repository root
ct lint --charts charts/apps/your-chart
ct install --charts charts/apps/your-chart
```

