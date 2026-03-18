# Helm Chart Copier Template

A [Copier](https://copier.readthedocs.io/) template for scaffolding production-ready
Helm charts that follow this repository's conventions.

## Prerequisites

- **copier** >= 9.0.0

```bash
# Install with uv (recommended)
uv tool install copier

# Or with pipx
pipx install copier
```

## Creating a New Chart

```bash
# Interactive — prompts for all options
./tools/new-chart.sh charts/apps/my-app

# Or with just
just new-chart charts/apps/my-app

# Or directly with copier
copier copy --trust templates/chart-copier charts/apps/my-app
```

Copier will ask a series of questions and generate a complete, lint-passing chart.

---

## Update Workflow

This is where Copier shines over static templates.

When the template evolves (bug fixes, new best practices, new optional features),
existing charts can **pull in those improvements** while keeping their customizations.

### Step 1 — Check what changed

Read [`TEMPLATE_CHANGELOG.md`](./TEMPLATE_CHANGELOG.md) to understand what's new
and whether any migration steps are needed.

### Pre-requisite — clean git state

`copier update` requires a clean git working tree (no modified or staged tracked files).
Commit or stash any pending changes before running an update:

```bash
# Option A — commit first (recommended)
git add . && git commit -m "chore: work in progress"

# Option B — stash, update, pop
git stash
./tools/update-charts.sh --defaults charts/apps/my-app
git stash pop
```

### Step 2 — Preview the update (optional but recommended)

```bash
# Dry-run: shows what would change without touching any files
./tools/update-charts.sh --pretend charts/apps/my-app
```

### Step 3 — Run the update

```bash
# Update a single chart (uses saved answers, no prompts)
./tools/update-charts.sh --defaults charts/apps/my-app

# Update all managed charts at once
./tools/update-charts.sh --defaults
just update-all-charts

# Update interactively (lets you re-answer questions)
./tools/update-charts.sh charts/apps/my-app
just update-chart charts/apps/my-app
```

### Step 4 — Resolve conflicts

Copier uses **git-style conflict markers** for files that were customized and have
template-side changes. Look for lines like:

```
<<<<<<< before updating
  ... your customization ...
=======
  ... template's new version ...
>>>>>>> after updating
```

Resolve each conflict manually, then remove the markers. After resolving:

```bash
helm lint charts/apps/my-app
helm template test charts/apps/my-app
```

### Discovering managed charts

```bash
# List all charts generated from this template
./tools/update-charts.sh --list
just list-managed-charts
```

A chart is "managed" when it has a `.copier-answers.yml` file in its root.
This file stores your answers and enables future updates.

---

## What Gets Generated

Depending on your answers, the template generates:

| Resource | File | Default |
|----------|------|---------|
| **Deployment** | `templates/deployment.yaml` | ✅ Always |
| **Service** | `templates/service.yaml` | ✅ Always |
| **ServiceAccount** | `templates/serviceaccount.yaml` | ✅ On |
| **Ingress** | `templates/ingress.yaml` | ✅ On |
| **HPA** | `templates/hpa.yaml` | ❌ Off |
| **PDB** | `templates/pdb.yaml` | ❌ Off |
| **ConfigMap** | `templates/configmap.yaml` | ❌ Off |
| **Secret** | `templates/secret.yaml` | ❌ Off |
| **NetworkPolicy** | `templates/networkpolicy.yaml` | ❌ Off |
| **PVC** | `templates/pvc.yaml` | ❌ Off |

Plus: `_helpers.tpl`, `NOTES.txt`, CI test values, helm-unittest tests, and `.copier-answers.yml`.

---

## Interactive Questions

| Question | Default | Notes |
|----------|---------|-------|
| `chart_name` | (dir name) | Lowercase alphanumeric + hyphens |
| `chart_description` | `A Helm chart for <name>` | |
| `chart_version` | `0.1.0` | SemVer |
| `app_version` | `1.0.0` | |
| `image_repository` | `nginx` | |
| `image_tag` | `""` | Empty = use appVersion |
| `container_port` | `80` | |
| `container_port_name` | `http` | Named port |
| `maintainer_name` | `codefuturist` | |
| `maintainer_email` | `hello@allcloud.trade` | |
| `use_service_account` | `true` | |
| `use_ingress` | `true` | |
| `use_hpa` | `false` | |
| `use_pdb` | `false` | |
| `use_configmap` | `false` | |
| `use_secret` | `false` | |
| `use_networkpolicy` | `false` | |
| `use_pvc` | `false` | |
| `replica_count` | `1` | |
| `service_type` | `ClusterIP` | ClusterIP / NodePort / LoadBalancer |
| `service_port` | `80` | |

---

## Conventions

Generated charts follow the repository's established patterns:

- **Labels**: Standard `app.kubernetes.io/*` Kubernetes recommended labels
- **Helpers**: `name`, `fullname`, `chart`, `labels`, `selectorLabels`, `serviceAccountName`
- **Values docs**: `helm-docs` annotation style (`# -- description` / `# @section`)
- **CI testing**: `ci/` directory with test value files for chart-testing
- **Unit tests**: `tests/` directory with helm-unittest YAML files
- **Discoverability**: `Chart.yaml` annotation `copier-managed: "true"`

---

## Technical Notes

### Jinja2 ↔ Helm delimiter conflict

Helm uses `{{ }}` (Go templates). Copier uses `{{ }}` (Jinja2). This template
uses custom delimiters to avoid conflicts, configured in `copier.yml` via `_envops`:

| Purpose | Delimiter |
|---------|-----------|
| Copier variable | `[[ variable ]]` |
| Copier block | `[% if condition %]...[% endif %]` |
| Helm template | `{{ .Values.x }}` (passes through unchanged) |

### Portability

The `update-charts.sh` script and all `just` targets always pass
`--src-path templates/chart-copier` to `copier update`. This overrides the
absolute path stored in `.copier-answers.yml`, making updates portable across
different machines and checkout locations.
