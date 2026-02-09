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

# List all charts
[group('charts')]
list:
    @just _header "Available Charts"
    @ls -1 charts/

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

# Build MkDocs site
[group('docs')]
docs-build:
    @just _info "Building MkDocs site..."
    @uv run mkdocs build
    @just _success "Site built"

# Serve MkDocs site
[group('docs')]
docs-serve:
    @just _info "Starting MkDocs server..."
    @uv run mkdocs serve

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

# Test chart
[group('test')]
test chart:
    @just _header "Testing Chart: {{chart}}"
    @helm lint charts/{{chart}}
    @helm template test-{{chart}} charts/{{chart}} > /dev/null
    @just _success "Chart tests passed"

# Test all charts
[group('test')]
test-all:
    @just _header "Testing All Charts"
    @for chart in charts/*/; do \
        just test $$(basename $$chart); \
    done
    @just _success "All tests passed"

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

# ═══════════════════════════════════════════════════════════════════════════════
# Maintenance
# ═══════════════════════════════════════════════════════════════════════════════

# Clean artifacts
[group('maintenance')]
clean:
    @just _info "Cleaning..."
    @rm -rf dist/ charts/*/charts/ charts/*/Chart.lock
    @just python::clean
    @just _success "Cleaned"

# Show project info
info:
    @just _header "{{project_name}}"
    @just _kv "Version" "{{_git_tag}}"
    @just _kv "Branch" "{{_git_branch}}"
    @just _kv "Charts" "$(ls -1 charts/ | wc -l | tr -d ' ')"
    @just _kv "Repository" "{{helm_repo_url}}"

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
