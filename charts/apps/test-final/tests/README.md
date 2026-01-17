# Chart Template Unit Tests

This directory contains unit tests for the Helm chart template using [helm-unittest](https://github.com/helm-unittest/helm-unittest).

## Test Files

| File                      | Templates Tested               | Description                                       |
| ------------------------- | ------------------------------ | ------------------------------------------------- |
| `deployment_test.yaml`    | deployment.yaml                | Deployment resources, env vars, volumes, security |
| `statefulset_test.yaml`   | statefulset.yaml               | StatefulSet, VCTs, update strategy                |
| `service_test.yaml`       | service.yaml                   | Service types, ports, annotations                 |
| `ingress_test.yaml`       | ingress.yaml                   | Ingress config, TLS, annotations                  |
| `rbac_test.yaml`          | serviceaccount.yaml, rbac.yaml | RBAC resources, annotations                       |
| `pvc_pdb_test.yaml`       | pvc.yaml, pdb.yaml             | Persistence, disruption budgets                   |
| `networkpolicy_test.yaml` | networkpolicy.yaml             | Network policies                                  |

## Prerequisites

Install helm-unittest plugin:

```bash
helm plugin install https://github.com/helm-unittest/helm-unittest
```

## Running Tests

### Run All Tests

```bash
# From chart directory
helm unittest .

# With verbose output
helm unittest -v .
```

### Run Specific Test File

```bash
helm unittest -f tests/deployment_test.yaml .
```

### Update Snapshots

```bash
helm unittest -u .
```
