# Repository Restructure - Migration Guide

## Overview

This document describes the comprehensive restructuring of the helm-charts repository to align with Helm and Kubernetes best practices and conventions.

**Date:** November 10, 2025  
**Branch:** develop

---

## Summary of Changes

### ✅ Completed Tasks

1. **Repository Structure Standardization**
2. **Configuration Files Added**
3. **Gitignore Updates**
4. **Chart Metadata Fixes**
5. **Documentation Improvements**
6. **Workflow Consolidation**
7. **Repository Cleanup**
8. **Makefile Modernization**

---

## Detailed Changes

### 1. Repository Structure

**Before:**
```
helm-charts/
├── application/         # Chart at root
├── homarr/             # Duplicate chart at root
├── nginx/              # Chart at root
├── charts/
│   └── homarr/        # Duplicate with different version
├── *.tgz              # Packaged charts scattered
└── multiple index.yaml files
```

**After:**
```
helm-charts/
├── charts/            # All charts consolidated here
│   ├── application/
│   ├── homarr/
│   └── nginx/
├── docs/              # GitHub Pages content
├── .github/
│   ├── workflows/     # Streamlined workflows
│   └── ct-lint.yaml   # Linting config
├── ct.yaml            # Chart testing config
├── artifacthub-repo.yaml
├── CONTRIBUTING.md
├── SECURITY.md
└── README.md          # Repository overview
```

### 2. Files Added

#### Configuration Files
- **`ct.yaml`** - Chart Testing configuration for CI/CD
- **`.github/ct-lint.yaml`** - YAML linting rules
- **`artifacthub-repo.yaml`** - Artifact Hub repository metadata

#### Documentation
- **`CONTRIBUTING.md`** - Comprehensive contribution guidelines
- **`SECURITY.md`** - Security policy and vulnerability reporting
- **`README.md`** (new) - Repository overview (old one backed up to `charts/application/README.md.backup`)

#### Workflows
- **`.github/workflows/lint-test.yaml`** - Automated linting and testing for PRs
- **`.github/workflows/release-charts.yaml`** - Automated chart releases via chart-releaser

### 3. Files Removed/Archived

- ✅ **Removed duplicate `homarr/` directory** (kept newer version in `charts/`)
- ✅ **Removed `sops/` directory** (secrets should not be in repo)
- ✅ **Removed `Tiltfile-delete`**
- ✅ **Removed all `.tgz` files from root**
- ✅ **Removed extra `index.yaml` from charts/**
- ✅ **Archived `publish.sh`** → `_archive_publish.sh`
- ✅ **Archived 21 redundant workflows** → `.github/workflows/_archive/`

### 4. Chart Metadata Updates

#### Application Chart (`charts/application/Chart.yaml`)
```yaml
name: application  # Fixed from "homarr"
description: A generic, flexible Helm chart for deploying applications...
version: 5.1.4
home: https://github.com/codefuturist/helm-charts
sources:
  - https://github.com/codefuturist/helm-charts/tree/main/charts/application
```

#### Homarr Chart (`charts/homarr/Chart.yaml`)
```yaml
name: homarr
description: Helm chart for deploying Homarr - a modern dashboard...
version: 5.2.11
appVersion: "0.15.0"
home: https://github.com/codefuturist/helm-charts
sources:
  - https://github.com/codefuturist/helm-charts/tree/main/charts/homarr
  - https://github.com/ajnart/homarr
```

#### NGINX Chart (`charts/nginx/Chart.yaml`)
```yaml
name: nginx
description: Helm chart for deploying NGINX web server...
version: 0.1.1
appVersion: "1.27.0"
home: https://github.com/codefuturist/helm-charts
```

### 5. Updated .gitignore

Added entries to ignore:
```gitignore
# Helm
*.tgz
charts/**/charts/
Chart.lock

# Temporary files
*.swp
*.bak
*~
```

### 6. Enhanced Makefile

New targets added:
- `help` - Display available targets
- `lint` - Lint all charts
- `lint-chart` - Lint specific chart
- `template` - Template specific chart
- `package` - Package all charts
- `package-chart` - Package specific chart
- `update-deps` - Update dependencies for all charts
- `update-deps-chart` - Update deps for specific chart
- `test` - Run helm unit tests
- `test-chart` - Test specific chart
- `clean` - Clean up generated files
- `validate` - Validate all charts
- `list-charts` - List all charts

Usage examples:
```bash
make help
make lint
make lint-chart CHART=application
make bump-chart CHART=application VERSION=5.1.5
make template CHART=homarr
```

### 7. GitHub Workflows

#### Lint and Test (`lint-test.yaml`)
- Triggers on PR and push to develop/main
- Uses `chart-testing` to lint changed charts
- Creates kind cluster for integration tests
- Installs and tests charts

#### Release Charts (`release-charts.yaml`)
- Triggers on push to main when charts change
- Uses `chart-releaser-action` for automated releases
- Packages charts
- Creates GitHub releases
- Updates GitHub Pages index
- Publishes to Helm repository

---

## Migration Impact

### Breaking Changes
❌ **None** - This is a structural reorganization that doesn't affect chart functionality

### Path Changes
Charts are now located at:
- `charts/application/` (was `application/`)
- `charts/homarr/` (consolidated from two locations)
- `charts/nginx/` (was `nginx/`)

### Workflow Changes
- Manual publishing via `publish.sh` → Automated via GitHub Actions
- 21 workflow files → 2 streamlined workflows

---

## Next Steps

### For Repository Maintainers

1. **Review Changes**
   ```bash
   git status
   git diff
   ```

2. **Test Locally**
   ```bash
   make lint
   make validate
   ```

3. **Update Branch Protection Rules**
   - Require `lint-test.yaml` to pass before merge
   - Configure branch protection for `main`

4. **Configure Secrets** (if needed)
   - GitHub Actions should have `GITHUB_TOKEN` (automatic)
   - No additional secrets required for basic operation

5. **Merge to Main**
   ```bash
   git add .
   git commit -m "Restructure repository according to best practices"
   git push origin develop
   # Create PR to main
   ```

6. **First Release**
   - Once merged to main, workflows will automatically:
     - Package charts
     - Create releases
     - Update GitHub Pages

### For Chart Users

#### Updating Repository URL
```bash
# Remove old repo (if different URL)
helm repo remove codefuturist

# Add repository
helm repo add codefuturist https://codefuturist.github.io/helm-charts
helm repo update
```

#### Installing Charts
```bash
# Same commands as before
helm install my-app codefuturist/application
helm install my-homarr codefuturist/homarr
```

---

## Best Practices Implemented

### ✅ Repository Structure
- [x] All charts in `charts/` directory
- [x] Single source of truth for each chart
- [x] Clean separation of concerns

### ✅ Documentation
- [x] Repository-level README
- [x] Contributing guidelines
- [x] Security policy
- [x] Per-chart documentation structure

### ✅ Automation
- [x] Automated testing on PRs
- [x] Automated releases
- [x] Version validation
- [x] Linting enforcement

### ✅ Metadata
- [x] Accurate Chart.yaml for all charts
- [x] Semantic versioning
- [x] Proper keywords and descriptions
- [x] Maintainer information
- [x] Artifact Hub integration

### ✅ Development Workflow
- [x] Pre-commit hooks support
- [x] Chart testing integration
- [x] Comprehensive Makefile
- [x] Local testing capabilities

---

## References

- [Helm Chart Best Practices](https://helm.sh/docs/chart_best_practices/)
- [Chart Testing Tool](https://github.com/helm/chart-testing)
- [Chart Releaser Action](https://github.com/helm/chart-releaser-action)
- [Artifact Hub](https://artifacthub.io/)

---

## Rollback Plan

If issues arise, the previous state can be restored:

1. **Workflows**: Available in `.github/workflows/_archive/`
2. **Scripts**: `_archive_publish.sh` contains old publish script
3. **README**: Old application README at `charts/application/README.md.backup`
4. **Git**: Use `git revert` or checkout previous commit

---

## Support

For questions or issues:
- Open an issue: https://github.com/codefuturist/helm-charts/issues
- Email: hello@allcloud.trade

---

**Note:** This restructure positions the repository for scalability, easier maintenance, and better community engagement following industry-standard practices.
