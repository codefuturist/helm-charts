# Chart Copier Template — Changelog

This file documents changes to the Copier template. When the template evolves,
chart owners can run `copier update` (or `./tools/update-charts.sh`) to pull
in improvements. Copier will show conflict markers for files you've customized.

## How to Use This Changelog

Before running `copier update`, check the latest version here to understand:
- What files changed
- Whether changes are breaking (require manual intervention) or automatic
- Any migration steps required

---

## v1.0.0 — Initial Release

**Released:** 2026-03-18

### What's Included

First release of the chart-copier Copier template for generating simple Helm
chart deployments following this repository's conventions.

#### Generated Resources
- **Always**: `Deployment`, `Service`, `_helpers.tpl`, `NOTES.txt`
- **Optional** (toggled by answers): `ServiceAccount`, `Ingress`, `HPA`, `PDB`,
  `ConfigMap`, `Secret`, `NetworkPolicy`, `PVC`

#### Conventions Encoded
- Standard `app.kubernetes.io/*` Kubernetes recommended labels
- `helm-docs` annotation style (`# -- description` / `# @section`) for all values
- CI test value files (`ci/01-default-values.yaml`, `ci/02-all-features-values.yaml`)
- `helm-unittest` test files for Deployment, Service, and Ingress
- `Chart.yaml` annotation `copier-managed: "true"` for discovery

#### Available Questions
| Question | Default |
|---|---|
| `chart_name` | (from directory name) |
| `chart_description` | `A Helm chart for deploying <name>` |
| `chart_version` | `0.1.0` |
| `app_version` | `1.0.0` |
| `image_repository` | `nginx` |
| `image_tag` | `""` (uses appVersion) |
| `container_port` | `80` |
| `container_port_name` | `http` |
| `maintainer_name` | `codefuturist` |
| `maintainer_email` | `hello@allcloud.trade` |
| `use_service_account` | `true` |
| `use_ingress` | `true` |
| `use_hpa` | `false` |
| `use_pdb` | `false` |
| `use_configmap` | `false` |
| `use_secret` | `false` |
| `use_networkpolicy` | `false` |
| `use_pvc` | `false` |
| `replica_count` | `1` |
| `service_type` | `ClusterIP` |
| `service_port` | `80` |

### Migration Notes
None — this is the initial release.

---

## Template Maintainer Notes

When making changes to the template:

1. **Bump the version** — add a new section at the top of this file with the new version
2. **Classify changes**:
   - 🟢 **Automatic** — Copier merges cleanly, no user action needed
   - 🟡 **Manual merge** — May produce conflict markers in customized files
   - 🔴 **Breaking** — Requires manual migration steps
3. **Document migration steps** — If removing/renaming questions, document how existing charts should adapt
4. **Commit and tag** — Commit the template changes; chart owners can then `copier update`

### Change Classification Guide
- Adding new optional questions → 🟢 Automatic (new defaults are safe)
- Updating template boilerplate → 🟡 Manual merge for customized charts
- Renaming a question key → 🔴 Breaking (stored answers use old key name)
- Removing a feature toggle → 🔴 Breaking (may delete files unexpectedly)
