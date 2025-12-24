SHELL := /bin/bash
CHARTS_DIR := charts
CHART_TESTING_IMAGE := quay.io/helmpack/chart-testing
CHART_TESTING_TAG := v3.10.0

# Use uv for Python package management (faster, more reliable)
UV := uv

.PHONY: help
help: ## Display this help message
	@echo "Available targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-20s %s\n", $$1, $$2}'

.PHONY: install-hooks
install-hooks: ## Install pre-commit hooks
	@command -v $(UV) >/dev/null 2>&1 || (echo "❌ uv not found. Install it from https://docs.astral.sh/uv/"; exit 1)
	$(UV) tool install pre-commit --quiet 2>/dev/null || true
	pre-commit install

.PHONY: lint
lint: ## Lint all charts using chart-testing
	ct lint --config ct.yaml --all

.PHONY: lint-chart
lint-chart: ## Lint a specific chart (usage: make lint-chart CHART=application)
	@test -n "$(CHART)" || (echo "CHART is not set. Usage: make lint-chart CHART=application"; exit 1)
	helm lint $(CHARTS_DIR)/$(CHART)

.PHONY: template
template: ## Template a specific chart (usage: make template CHART=application)
	@test -n "$(CHART)" || (echo "CHART is not set. Usage: make template CHART=application"; exit 1)
	helm template test $(CHARTS_DIR)/$(CHART) --values $(CHARTS_DIR)/$(CHART)/values.yaml

.PHONY: build-docs
build-docs: install-hooks ## Generate documentation for all charts using helm-docs
	@command -v helm-docs 2>&1 >/dev/null || (echo "helm-docs not found. Install it from https://github.com/norwoodj/helm-docs"; exit 1)
	@for chart in $(CHARTS_DIR)/*; do \
		if [ -f "$$chart/Chart.yaml" ]; then \
			echo "Generating docs for $$chart..."; \
			helm-docs "$$chart"; \
		fi \
	done

.PHONY: package
package: ## Package all charts
	@mkdir -p .cr-release-packages
	@for chart in $(CHARTS_DIR)/*; do \
		if [ -f "$$chart/Chart.yaml" ]; then \
			echo "Packaging $$chart..."; \
			helm package "$$chart" -d .cr-release-packages; \
		fi \
	done

.PHONY: package-chart
package-chart: ## Package a specific chart (usage: make package-chart CHART=application)
	@test -n "$(CHART)" || (echo "CHART is not set. Usage: make package-chart CHART=application"; exit 1)
	@mkdir -p .cr-release-packages
	helm package $(CHARTS_DIR)/$(CHART) -d .cr-release-packages

.PHONY: update-deps
update-deps: ## Update dependencies for all charts
	@for chart in $(CHARTS_DIR)/*; do \
		if [ -f "$$chart/Chart.yaml" ]; then \
			echo "Updating dependencies for $$chart..."; \
			helm dependency update "$$chart" || true; \
		fi \
	done

.PHONY: update-deps-chart
update-deps-chart: ## Update dependencies for a specific chart (usage: make update-deps-chart CHART=application)
	@test -n "$(CHART)" || (echo "CHART is not set. Usage: make update-deps-chart CHART=application"; exit 1)
	helm dependency update $(CHARTS_DIR)/$(CHART)

.PHONY: bump-chart
bump-chart: ## Bump chart version (usage: make bump-chart CHART=application VERSION=1.2.3)
	@test -n "$(VERSION)" || (echo "VERSION is not set. Usage: make bump-chart CHART=application VERSION=1.2.3"; exit 1)
	@test -n "$(CHART)" || (echo "CHART is not set. Usage: make bump-chart CHART=application VERSION=1.2.3"; exit 1)
	sed -i '' 's/^version: [0-9]\{1,\}\.[0-9]\{1,\}\.[0-9]\{1,\}/version: $(VERSION)/' $(CHARTS_DIR)/$(CHART)/Chart.yaml
	@echo "Bumped $(CHART) to version $(VERSION)"

.PHONY: test
test: ## Run helm unit tests (requires helm unittest plugin)
	@command -v helm unittest 2>&1 >/dev/null || (echo "helm unittest plugin not found. Install it with: helm plugin install https://github.com/helm-unittest/helm-unittest"; exit 1)
	@for chart in $(CHARTS_DIR)/*; do \
		if [ -d "$$chart/tests" ]; then \
			echo "Testing $$chart..."; \
			helm unittest "$$chart"; \
		fi \
	done

.PHONY: test-chart
test-chart: ## Test a specific chart (usage: make test-chart CHART=application)
	@test -n "$(CHART)" || (echo "CHART is not set. Usage: make test-chart CHART=application"; exit 1)
	@command -v helm unittest 2>&1 >/dev/null || (echo "helm unittest plugin not found. Install it with: helm plugin install https://github.com/helm-unittest/helm-unittest"; exit 1)
	helm unittest $(CHARTS_DIR)/$(CHART)

.PHONY: clean
clean: ## Clean up generated files
	rm -rf .cr-release-packages
	rm -rf .cr-index
	rm -rf site-docs
	find $(CHARTS_DIR) -name "Chart.lock" -delete
	find $(CHARTS_DIR) -type d -name "charts" -mindepth 2 -maxdepth 2 -exec rm -rf {} + 2>/dev/null || true
	@echo "Cleaned up generated files"

# Documentation targets using uv
DOCS_PORT ?= 8000

.PHONY: docs-deps
docs-deps: ## Install documentation dependencies
	@command -v $(UV) >/dev/null 2>&1 || (echo "❌ uv not found. Install it from https://docs.astral.sh/uv/"; exit 1)
	@echo "📥 Installing documentation dependencies..."
	@$(UV) sync --quiet
	@echo "✅ Dependencies installed"

.PHONY: docs-generate
docs-generate: ## Generate MkDocs pages from chart values
	@echo "🔄 Generating documentation from charts..."
	@$(UV) run python scripts/generate-docs.py

.PHONY: docs-serve
docs-serve: docs-deps docs-generate ## Serve documentation locally with live reload
	@echo ""
	@echo "🚀 Starting documentation server..."
	@echo "   📖 Local:   http://localhost:$(DOCS_PORT)"
	@echo "   🔄 Live reload enabled - changes will auto-refresh"
	@echo "   ⌨️  Press Ctrl+C to stop"
	@echo ""
	@$(UV) run mkdocs serve -a localhost:$(DOCS_PORT)

.PHONY: docs-build
docs-build: docs-deps docs-generate ## Build documentation site
	@echo "🏗️  Building documentation site..."
	@$(UV) run mkdocs build -d site-docs
	@echo "✅ Documentation built in site-docs/"

.PHONY: docs
docs: docs-build ## Full documentation build (alias for docs-build)
	@echo "📚 Documentation ready at site-docs/index.html"

.PHONY: docs-open
docs-open: ## Open documentation in browser (macOS)
	@if [ -f "site-docs/index.html" ]; then \
		open site-docs/index.html; \
	else \
		echo "⚠️  Documentation not built yet. Run 'make docs-build' first."; \
	fi

.PHONY: docs-clean
docs-clean: ## Clean documentation build artifacts
	@echo "🧹 Cleaning documentation artifacts..."
	@rm -rf site-docs
	@rm -rf docs/charts/*.md
	@rm -rf docs/reference/search.md docs/reference/values-index.md
	@rm -f docs/assets/javascripts/values-index.json
	@echo "✅ Documentation artifacts cleaned"

.PHONY: docs-sync
docs-sync: docs-deps ## Sync chart documentation (add new, remove deleted)
	@echo "🔄 Syncing chart documentation..."
	@$(UV) run python scripts/sync-chart-docs.py

.PHONY: docs-check
docs-check: docs-deps ## Check if chart documentation is in sync
	@$(UV) run python scripts/sync-chart-docs.py --check

.PHONY: validate
validate: lint build-docs ## Validate all charts (lint + docs)
	@echo "All charts validated successfully!"

.PHONY: health-check
health-check: ## Run repository health check
	@./scripts/health-check.sh

.PHONY: health-check-verbose
health-check-verbose: ## Run repository health check with verbose output
	@./scripts/health-check.sh --verbose

.PHONY: health-check-json
health-check-json: ## Run repository health check with JSON output
	@./scripts/health-check.sh --json

.PHONY: list-charts
list-charts: ## List all charts in the repository
	@for chart in $(CHARTS_DIR)/*; do \
		if [ -f "$$chart/Chart.yaml" ]; then \
			name=$$(grep "^name:" "$$chart/Chart.yaml" | awk '{print $$2}'); \
			version=$$(grep "^version:" "$$chart/Chart.yaml" | awk '{print $$2}'); \
			echo "$$name ($$version)"; \
		fi \
	done

