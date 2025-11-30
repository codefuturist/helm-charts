# Shlink Helm Chart Unit Tests

This directory contains [helm-unittest](https://github.com/helm-unittest/helm-unittest) suites that cover the critical Shlink templates. The tests focus on ensuring that the rendered manifests respect the values provided by users, especially around credentials, services, persistence, and the optional web client.

## Covered Templates

| File | Templates | Highlights |
| ---- | --------- | ---------- |
| `deployment_test.yaml` | `templates/deployment.yaml` | DB secret wiring, env vars, persistence volumes |
| `secret_test.yaml` | `templates/secret.yaml` | Generated secrets vs. existing secrets |
| `configmap_test.yaml` | `templates/configmap.yaml` | Pre-configured `servers.json` behavior |
| `webclient_test.yaml` | `templates/deployment-webclient.yaml` | Default server env vars, extra env handling |
| `service_test.yaml` | `templates/service*.yaml` | Backend and web client services |

## Prerequisites

Install the helm-unittest plugin once per machine:

```bash
helm plugin install https://github.com/helm-unittest/helm-unittest
```

## Running the Tests

From the chart directory:

```bash
cd charts/shlink
helm unittest .
```

Run a single suite (for example, the web client tests):

```bash
helm unittest -f tests/webclient_test.yaml .
```

Pass `-v` or `--color` for verbose or colorized output.

## Adding Tests

When introducing a new template or feature, add or extend a suite that exercises both the enabled and disabled states. Prefer concise assertions that target the rendered YAML paths most likely to regress (credentials, selectors, ports, feature gates, etc.).
