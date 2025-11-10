SHELL := /bin/bash
CHARTS_DIR := charts
CHART_TESTING_IMAGE := quay.io/helmpack/chart-testing
CHART_TESTING_TAG := v3.10.0

.PHONY: help
help: ## Display this help message
	@echo "Available targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-20s %s\n", $$1, $$2}'

.PHONY: install-hooks
install-hooks: ## Install pre-commit hooks
	command -v pre-commit 2>&1 >/dev/null || pip install pre-commit
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
	find $(CHARTS_DIR) -name "Chart.lock" -delete
	find $(CHARTS_DIR) -type d -name "charts" -mindepth 2 -maxdepth 2 -exec rm -rf {} + 2>/dev/null || true
	@echo "Cleaned up generated files"

.PHONY: validate
validate: lint build-docs ## Validate all charts (lint + docs)
	@echo "All charts validated successfully!"

.PHONY: list-charts
list-charts: ## List all charts in the repository
	@for chart in $(CHARTS_DIR)/*; do \
		if [ -f "$$chart/Chart.yaml" ]; then \
			name=$$(grep "^name:" "$$chart/Chart.yaml" | awk '{print $$2}'); \
			version=$$(grep "^version:" "$$chart/Chart.yaml" | awk '{print $$2}'); \
			echo "$$name ($$version)"; \
		fi \
	done

