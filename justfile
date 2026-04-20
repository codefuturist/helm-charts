# Helm Charts Justfile
# Migrated from Makefile to modular just-modules system

# ═══════════════════════════════════════════════════════════════════════════════
# Configuration

# ═══════════════════════════════════════════════════════════════════════════════
# Imports
# ═══════════════════════════════════════════════════════════════════════════════

# Core (required)
import '.just-modules/core/mod.just'

# Automation & Project Management
import '.just-modules/traits/automation-helpers.just'
import '.just-modules/traits/env.just'

# Features
mod versioning '.just-modules/traits/versioning.just'
mod gitflow '.just-modules/traits/gitflow.just'
mod hooks '.just-modules/traits/hooks.just'
mod docs '.just-modules/traits/docs.just'
mod cog '.just-modules/traits/cocogitto.just'

# Code Quality & Refactoring
import '.just-modules/traits/ast-grep.just'
import '.just-modules/traits/megalinter.just'
import '.just-modules/traits/backup.just'

# Security & Encryption
import '.just-modules/traits/encryption.just'

# Secret Providers
import '.just-modules/traits/protonpass.just'

# AI Features
import '.just-modules/traits/ai.just'

# ─────────────────────────────────────────────────────────────────────────────
# Configuration
# ─────────────────────────────────────────────────────────────────────────────

project_name := 'Helm Charts'

# Import language modules
mod python '.just-modules/languages/python/mod.just'

# Import features
mod security '.just-modules/traits/security.just'

# Helm settings
helm_repo_url := env_var_or_default('HELM_REPO_URL', 'https://charts.example.com')
charts_dir := 'charts'
docs_port := env_var_or_default('DOCS_PORT', '8000')

# ═══════════════════════════════════════════════════════════════════════════════
# Default
# ═══════════════════════════════════════════════════════════════════════════════

default:
    @just --list --list-heading $'⎈ Helm Charts - Available commands:\n'

# ═══════════════════════════════════════════════════════════════════════════════
# Setup
# ═══════════════════════════════════════════════════════════════════════════════

# Complete project setup
[group('setup')]
setup:
    @just _header "Project Setup"
    @just python::deps
    @just helm-plugin-install
    @just _success "Setup complete!"

# Install Helm plugins
[group('setup')]
helm-plugin-install:
    @just _info "Installing Helm plugins..."
    @helm plugin install https://github.com/norwoodj/helm-docs || echo "helm-docs already installed"
    @just _success "Plugins installed"

# ═══════════════════════════════════════════════════════════════════════════════
# Chart Management
# ═══════════════════════════════════════════════════════════════════════════════

# Create a new chart from the Copier template
[group('charts')]
new-chart dest:
    @just _info "Creating new chart at {{dest}}..."
    @copier copy --trust templates/chart-copier {{dest}}
    @just _success "Chart created at {{dest}}"

# Update an existing chart from the Copier template
[group('charts')]
update-chart dest:
    @just _info "Updating chart at {{dest}} from template..."
    @./tools/update-charts.sh {{dest}}
    @just _success "Chart updated"

# List all Copier-managed charts
[group('charts')]
list-managed-charts:
    @./tools/update-charts.sh --list

# Update all Copier-managed charts (uses saved answers, no prompts)
[group('charts')]
update-all-charts:
    @just _info "Updating all managed charts..."
    @./tools/update-charts.sh --defaults

# List all charts with name and version
[group('charts')]
list:
    @just _header "Available Charts"
    @for chart in charts/*/; do \
        if [ -f "$$chart/Chart.yaml" ]; then \
            name=$$(grep "^name:" "$$chart/Chart.yaml" | awk '{print $$2}'); \
            version=$$(grep "^version:" "$$chart/Chart.yaml" | awk '{print $$2}'); \
            echo "  $$name ($$version)"; \
        fi; \
    done

# Bump chart version (usage: just bump-chart <chart> <version>)
[group('charts')]
bump-chart chart version:
    @just _info "Bumping {{chart}} to version {{version}}..."
    @sed -i '' 's/^version: [0-9]*\.[0-9]*\.[0-9]*/version: {{version}}/' charts/{{chart}}/Chart.yaml
    @just _success "Bumped {{chart}} to version {{version}}"

# Lint all charts using chart-testing
[group('charts')]
ct-lint:
    @just _header "Linting All Charts (chart-testing)"
    @ct lint --config ct.yaml --all

# Validate all charts (lint + build-docs)
[group('charts')]
validate: ct-lint build-docs
    @just _success "All charts validated"

# Package chart
[group('charts')]
package chart:
    @just _header "Packaging Chart: {{chart}}"
    @helm package charts/{{chart}} -d dist/
    @just _success "Chart packaged"

# Package all charts
[group('charts')]
package-all:
    @just _header "Packaging All Charts"
    @for chart in charts/*/; do \
        just package $$(basename $$chart); \
    done
    @just _success "All charts packaged"

# Lint chart
[group('charts')]
lint chart:
    @just _info "Linting chart: {{chart}}"
    @helm lint charts/{{chart}}
    @just _success "Chart valid"

# Lint all charts
[group('charts')]
lint-all:
    @just _header "Linting All Charts"
    @for chart in charts/*/; do \
        just lint $$(basename $$chart); \
    done
    @just _success "All charts valid"

# Template chart
[group('charts')]
template chart:
    @just _info "Templating chart: {{chart}}"
    @helm template {{chart}} charts/{{chart}}

# Install chart
[group('charts')]
install chart release:
    @just _info "Installing chart: {{chart}} as {{release}}"
    @helm install {{release}} charts/{{chart}}
    @just _success "Chart installed"

# Upgrade chart
[group('charts')]
upgrade chart release:
    @just _info "Upgrading chart: {{chart}} ({{release}})"
    @helm upgrade {{release}} charts/{{chart}}
    @just _success "Chart upgraded"

# Uninstall chart
[group('charts')]
uninstall release:
    @just _warning "Uninstalling release: {{release}}"
    @helm uninstall {{release}}

# ═══════════════════════════════════════════════════════════════════════════════
# Documentation
# ═══════════════════════════════════════════════════════════════════════════════

# Generate documentation for chart
[group('docs')]
docs-chart chart:
    @just _info "Generating docs for: {{chart}}"
    @helm-docs charts/{{chart}}
    @just _success "Docs generated"

# Generate documentation for all charts
[group('docs')]
build-docs:
    @just _header "Generating Documentation"
    @helm-docs charts/
    @just _success "Docs generated"

# Install documentation dependencies
[group('docs')]
docs-deps:
    @just _info "Installing documentation dependencies..."
    @uv sync --quiet
    @just _success "Dependencies installed"

# Generate MkDocs pages from chart values
[group('docs')]
docs-generate:
    @just _info "Generating documentation from charts..."
    @uv run python scripts/generate-docs.py

# Sync chart documentation (add new, remove deleted)
[group('docs')]
docs-sync:
    @just _info "Syncing chart documentation..."
    @uv run python scripts/sync-chart-docs.py

# Check if chart documentation is in sync
[group('docs')]
docs-check:
    @uv run python scripts/sync-chart-docs.py --check

# Build MkDocs site
[group('docs')]
docs-build: docs-deps docs-generate
    @just _info "Building MkDocs site..."
    @uv run mkdocs build -d site-docs
    @just _success "Documentation built in site-docs/"

# Full documentation build (alias for docs-build)
[group('docs')]
docs-all: docs-build
    @just _info "Documentation ready at site-docs/index.html"

# Serve MkDocs site
[group('docs')]
docs-serve: docs-deps docs-generate
    @just _info "Starting MkDocs server on port {{docs_port}}..."
    @uv run mkdocs serve -a localhost:{{docs_port}}

# Open documentation in browser (macOS)
[group('docs')]
[script]
docs-open:
    if [ -f "site-docs/index.html" ]; then
        open site-docs/index.html
    else
        echo "⚠️  Documentation not built yet. Run 'just docs-build' first."
        exit 1
    fi

# Clean documentation build artifacts
[group('docs')]
docs-clean:
    @just _info "Cleaning documentation artifacts..."
    @rm -rf site-docs
    @rm -rf docs/charts/*.md
    @rm -rf docs/reference/search.md docs/reference/values-index.md
    @rm -f docs/assets/javascripts/values-index.json
    @just _success "Documentation artifacts cleaned"

# Deploy docs
[group('docs')]
docs-deploy:
    @just _info "Deploying docs..."
    @uv run mkdocs gh-deploy
    @just _success "Docs deployed"

# ═══════════════════════════════════════════════════════════════════════════════
# Dependencies
# ═══════════════════════════════════════════════════════════════════════════════

# Update chart dependencies
[group('deps')]
helm-deps-update chart:
    @just _info "Updating dependencies for: {{chart}}"
    @helm dependency update charts/{{chart}}
    @just _success "Dependencies updated"

# Update all chart dependencies
[group('deps')]
helm-deps-update-all:
    @just _header "Updating All Dependencies"
    @for chart in charts/*/; do \
        just helm-deps-update $$(basename $$chart); \
    done
    @just _success "All dependencies updated"

# Build chart dependencies
[group('deps')]
deps-build chart:
    @just _info "Building dependencies for: {{chart}}"
    @helm dependency build charts/{{chart}}
    @just _success "Dependencies built"

# ═══════════════════════════════════════════════════════════════════════════════
# Repository Management
# ═══════════════════════════════════════════════════════════════════════════════

# Generate Helm repository index
[group('repo')]
repo-index:
    @just _header "Generating Repository Index"
    @helm repo index dist/ --url {{helm_repo_url}}
    @just _success "Index generated"

# Package and index all charts
[group('repo')]
repo-update: package-all repo-index
    @just _success "Repository updated"

# ═══════════════════════════════════════════════════════════════════════════════
# Testing
# ═══════════════════════════════════════════════════════════════════════════════

# Test chart (helm lint + template + unittest if tests/ dir exists)
[group('test')]
[script]
test chart:
    just _header "Testing Chart: {{chart}}"
    helm lint charts/{{chart}}
    helm template test-{{chart}} charts/{{chart}} > /dev/null
    if [ -d "charts/{{chart}}/tests" ]; then
        echo "Running unit tests..."
        helm unittest charts/{{chart}}
    fi
    just _success "Chart tests passed"

# Test all charts
[group('test')]
[script]
test-all:
    just _header "Testing All Charts"
    for chart in charts/*/; do
        just test "$(basename "$chart")"
    done
    just _success "All tests passed"

# Run helm unittest only (requires helm unittest plugin)
[group('test')]
[script]
unittest chart:
    just _info "Running unit tests for: {{chart}}"
    helm unittest charts/{{chart}}

# Run helm unittest on all charts that have tests
[group('test')]
[script]
unittest-all:
    just _header "Running All Unit Tests"
    for chart in charts/*/; do
        if [ -d "$chart/tests" ]; then
            echo "Testing $chart..."
            helm unittest "$chart"
        fi
    done
    just _success "All unit tests passed"

# Run Python tests
[group('test')]
test-python:
    @just python::test

# ═══════════════════════════════════════════════════════════════════════════════
# Health Checks
# ═══════════════════════════════════════════════════════════════════════════════

# Run health check script
[group('health')]
health:
    @just _header "Health Check"
    @bash scripts/health-check.sh
    @just _success "Health check complete"

# Run health check with verbose output
[group('health')]
health-verbose:
    @just _header "Health Check (verbose)"
    @bash scripts/health-check.sh --verbose

# Run health check with JSON output
[group('health')]
health-json:
    @bash scripts/health-check.sh --json

# ═══════════════════════════════════════════════════════════════════════════════
# Chart Consistency
# ═══════════════════════════════════════════════════════════════════════════════

# Sync boilerplate files (.helmignore, Chart.yaml annotations) across all charts
[group('consistency')]
chart-sync:
    @just _header "Syncing Chart Boilerplate"
    @uv run python scripts/hooks/sync-boilerplate.py
    @just _success "Boilerplate synced"

# Sync boilerplate (dry-run — show what would change)
[group('consistency')]
chart-sync-check:
    @just _header "Checking Chart Boilerplate (dry-run)"
    @uv run python scripts/hooks/sync-boilerplate.py --dry-run

# Run drift detection on all charts
[group('consistency')]
chart-drift-check:
    @just _header "Chart Drift Check"
    @uv run python scripts/chart-drift-check.py

# Run drift detection (strict — fail on warnings too)
[group('consistency')]
chart-drift-check-strict:
    @just _header "Chart Drift Check (strict)"
    @uv run python scripts/chart-drift-check.py --strict

# Run drift detection with JSON output
[group('consistency')]
chart-drift-check-json:
    @uv run python scripts/chart-drift-check.py --json

# Recopy all Copier-managed charts from template
[group('consistency')]
chart-recopy-all:
    @just _header "Recopy Copier-Managed Charts"
    @./scripts/hooks/copier-recopy.sh
    @just _success "Charts recopied"

# ═══════════════════════════════════════════════════════════════════════════════
# Pre-commit Hooks (extended)
# ═══════════════════════════════════════════════════════════════════════════════
# The hooks module (.just-modules/traits/hooks.just) provides basic hook
# management. These recipes extend it with pre-commit-specific features.

# Run a specific pre-commit hook on staged files (usage: just hooks-run-hook <hook-id>)
[group('hooks')]
hooks-run-hook hook:
    @just _info "Running hook '{{hook}}' on staged files..."
    @pre-commit run {{hook}}

# Run a specific pre-commit hook on ALL files (usage: just hooks-run-hook-all <hook-id>)
[group('hooks')]
hooks-run-hook-all hook:
    @just _info "Running hook '{{hook}}' on all files..."
    @pre-commit run {{hook}} --all-files

# Update pre-commit hook versions
[group('hooks')]
hooks-autoupdate:
    @just _info "Updating pre-commit hooks..."
    @pre-commit autoupdate

# Clean pre-commit cache
[group('hooks')]
hooks-clean:
    @just _info "Cleaning pre-commit cache..."
    @pre-commit clean 2>/dev/null || true
    @pre-commit gc 2>/dev/null || true
    @just _success "Cache cleaned. Run 'just hooks install' to reinstall."

# ═══════════════════════════════════════════════════════════════════════════════
# Maintenance
# ═══════════════════════════════════════════════════════════════════════════════

# Clean artifacts
[group('maintenance')]
[script]
clean:
    just _info "Cleaning..."
    rm -rf dist/ .cr-release-packages .cr-index site-docs
    find charts -name "Chart.lock" -delete 2>/dev/null || true
    find charts -type d -name "charts" -mindepth 2 -maxdepth 2 -exec rm -rf {} + 2>/dev/null || true
    just python::clean
    just _success "Cleaned"

# Show project info
info:
    @just _header "{{project_name}}"
    @just _kv "Version" "{{_git_tag}}"
    @just _kv "Branch" "{{_git_branch}}"
    @just _kv "Charts" "$(ls -1 charts/ | wc -l | tr -d ' ')"
    @just _kv "Repository" "{{helm_repo_url}}"

# ═══════════════════════════════════════════════════════════════════════════════
# Local Kubernetes Development (k3d)
# ═══════════════════════════════════════════════════════════════════════════════

k3d_cluster_name := "helm-dev"
k3d_context := "k3d-helm-dev"

# Create local k3d cluster for chart development
[group('local')]
local-up:
    @just _header "Creating Local K8s Cluster"
    @k3d cluster create {{k3d_cluster_name}} --port "80:80@loadbalancer" --port "443:443@loadbalancer"
    @just _success "Cluster ready at context {{k3d_context}}"

# Delete local k3d cluster
[group('local')]
local-down:
    @just _header "Deleting Local K8s Cluster"
    @k3d cluster delete {{k3d_cluster_name}}
    @just _success "Cluster deleted"

# Lint and install-test changed charts against local cluster
[group('local')]
local-ct-test:
    @just _header "Chart Testing on Local Cluster"
    @kubectl config use-context {{k3d_context}}
    @ct install --config ct.yaml --target-branch main --excluded-charts common
    @just _success "Chart testing complete"

# ══════════════════════════════════════════════════════════════════════════════
# Just-Modules Management
# ══════════════════════════════════════════════════════════════════════════════

# Browse and interactively add just-modules to this project
[group('modules')]
modules-browse:
    @just _header "Available just-modules"
    @echo ""
    @echo "{{ BOLD }}{{ CYAN }}Language Modules:{{ NORMAL }}"
    @ls -1 .just-modules/languages/ 2>/dev/null | sed 's/^/  • /' || echo "  (none found)"
    @echo ""
    @echo "{{ BOLD }}{{ CYAN }}Traits/Features:{{ NORMAL }}"
    @ls -1 .just-modules/traits/*.just 2>/dev/null | xargs -n1 basename | sed 's/.just$//' | sed 's/^/  • /' || echo "  (none found)"
    @echo ""
    @echo "{{ BOLD }}{{ YELLOW }}To add a module, edit your justfile and add:{{ NORMAL }}"
    @echo "  {{ GREEN }}mod <name> '.just-modules/languages/<name>/mod.just'{{ NORMAL }}  # For languages"
    @echo "  {{ GREEN }}import '.just-modules/traits/<name>.just'{{ NORMAL }}              # For traits"
    @echo ""
    @echo "{{ BOLD }}Example - Add Go support:{{ NORMAL }}"
    @echo "  Add this line to your imports section:"
    @echo "  {{ CYAN }}mod go '.just-modules/languages/go/mod.just'{{ NORMAL }}"

# Show currently imported modules
[group('modules')]
modules-list:
    @just _header "Currently Imported Modules"
    @echo ""
    @echo "{{ BOLD }}Language Modules:{{ NORMAL }}"
    @grep "^mod .* '.just-modules/languages/" justfile | sed "s/^mod /  • /" | sed "s/ '.*//" || echo "  (none)"
    @echo ""
    @echo "{{ BOLD }}Trait Imports:{{ NORMAL }}"
    @grep "^import '.just-modules/traits/" justfile | sed "s/^import '.just-modules\/traits\//  • /" | sed "s/.just'.*//" || echo "  (none)"
    @echo ""
    @echo "{{ BOLD }}Trait Modules:{{ NORMAL }}"
    @grep "^mod .* '.just-modules/traits/" justfile | sed "s/^mod /  • /" | sed "s/ '.*//" || echo "  (none)"

# Update just-modules submodule to latest version
[group('modules')]
modules-update:
    @just _header "Updating just-modules"
    @just _info "Pulling latest from remote..."
    @cd .just-modules && git pull origin main
    @just _success "just-modules updated to latest version"

# Show just-modules submodule status
[group('modules')]
modules-status:
    @just _header "just-modules Submodule Status"
    @cd .just-modules && git log -1 --format="  {{ BOLD }}Commit:{{ NORMAL }} %h - %s" && git log -1 --format="  {{ BOLD }}Date:{{ NORMAL }}   %cr"
    @cd .just-modules && echo "  {{ BOLD }}Branch:{{ NORMAL }} $(git branch --show-current || echo 'detached')"
    @echo ""
    @cd .just-modules && git fetch origin --quiet && \
        LOCAL=$(git rev-parse HEAD) && \
        REMOTE=$(git rev-parse origin/main 2>/dev/null || echo "$LOCAL") && \
        if [ "$LOCAL" = "$REMOTE" ]; then \
            echo "  {{ GREEN }}✓ Up to date{{ NORMAL }}"; \
        else \
            echo "  {{ YELLOW }}⚠ Updates available{{ NORMAL }} (run: just modules-update)"; \
        fi
