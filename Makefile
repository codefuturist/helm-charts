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

.PHONY: bump-patch
bump-patch: ## Bump patch version (usage: make bump-patch CHART=application)
	@test -n "$(CHART)" || (echo "CHART is not set. Usage: make bump-patch CHART=application"; exit 1)
	@CURRENT=$$(grep "^version:" $(CHARTS_DIR)/$(CHART)/Chart.yaml | awk '{print $$2}'); \
	MAJOR=$$(echo $$CURRENT | cut -d. -f1); \
	MINOR=$$(echo $$CURRENT | cut -d. -f2); \
	PATCH=$$(echo $$CURRENT | cut -d. -f3); \
	NEW_PATCH=$$(($$PATCH + 1)); \
	NEW_VERSION="$$MAJOR.$$MINOR.$$NEW_PATCH"; \
	sed -i '' "s/^version: .*/version: $$NEW_VERSION/" $(CHARTS_DIR)/$(CHART)/Chart.yaml; \
	echo "Bumped $(CHART) from $$CURRENT to $$NEW_VERSION"

.PHONY: bump-minor
bump-minor: ## Bump minor version (usage: make bump-minor CHART=application)
	@test -n "$(CHART)" || (echo "CHART is not set. Usage: make bump-minor CHART=application"; exit 1)
	@CURRENT=$$(grep "^version:" $(CHARTS_DIR)/$(CHART)/Chart.yaml | awk '{print $$2}'); \
	MAJOR=$$(echo $$CURRENT | cut -d. -f1); \
	MINOR=$$(echo $$CURRENT | cut -d. -f2); \
	NEW_MINOR=$$(($$MINOR + 1)); \
	NEW_VERSION="$$MAJOR.$$NEW_MINOR.0"; \
	sed -i '' "s/^version: .*/version: $$NEW_VERSION/" $(CHARTS_DIR)/$(CHART)/Chart.yaml; \
	echo "Bumped $(CHART) from $$CURRENT to $$NEW_VERSION"

.PHONY: bump-major
bump-major: ## Bump major version (usage: make bump-major CHART=application)
	@test -n "$(CHART)" || (echo "CHART is not set. Usage: make bump-major CHART=application"; exit 1)
	@CURRENT=$$(grep "^version:" $(CHARTS_DIR)/$(CHART)/Chart.yaml | awk '{print $$2}'); \
	MAJOR=$$(echo $$CURRENT | cut -d. -f1); \
	NEW_MAJOR=$$(($$MAJOR + 1)); \
	NEW_VERSION="$$NEW_MAJOR.0.0"; \
	sed -i '' "s/^version: .*/version: $$NEW_VERSION/" $(CHARTS_DIR)/$(CHART)/Chart.yaml; \
	echo "Bumped $(CHART) from $$CURRENT to $$NEW_VERSION"

.PHONY: release-patch
release-patch: ## Bump patch, generate docs, commit and tag (usage: make release-patch CHART=application)
	@test -n "$(CHART)" || (echo "CHART is not set. Usage: make release-patch CHART=application"; exit 1)
	@$(MAKE) bump-patch CHART=$(CHART)
	@$(MAKE) docs-chart CHART=$(CHART)
	@NEW_VERSION=$$(grep "^version:" $(CHARTS_DIR)/$(CHART)/Chart.yaml | awk '{print $$2}'); \
	git add $(CHARTS_DIR)/$(CHART)/Chart.yaml $(CHARTS_DIR)/$(CHART)/README.md; \
	git commit -m "chore($(CHART)): release version $$NEW_VERSION"; \
	git tag "$(CHART)-$$NEW_VERSION"; \
	echo "✓ Released $(CHART) version $$NEW_VERSION"; \
	echo "Run 'git push origin main --tags' to publish"

.PHONY: release-minor
release-minor: ## Bump minor, generate docs, commit and tag (usage: make release-minor CHART=application)
	@test -n "$(CHART)" || (echo "CHART is not set. Usage: make release-minor CHART=application"; exit 1)
	@$(MAKE) bump-minor CHART=$(CHART)
	@$(MAKE) docs-chart CHART=$(CHART)
	@NEW_VERSION=$$(grep "^version:" $(CHARTS_DIR)/$(CHART)/Chart.yaml | awk '{print $$2}'); \
	git add $(CHARTS_DIR)/$(CHART)/Chart.yaml $(CHARTS_DIR)/$(CHART)/README.md; \
	git commit -m "chore($(CHART)): release version $$NEW_VERSION"; \
	git tag "$(CHART)-$$NEW_VERSION"; \
	echo "✓ Released $(CHART) version $$NEW_VERSION"; \
	echo "Run 'git push origin main --tags' to publish"

.PHONY: release-major
release-major: ## Bump major, generate docs, commit and tag (usage: make release-major CHART=application)
	@test -n "$(CHART)" || (echo "CHART is not set. Usage: make release-major CHART=application"; exit 1)
	@$(MAKE) bump-major CHART=$(CHART)
	@$(MAKE) docs-chart CHART=$(CHART)
	@NEW_VERSION=$$(grep "^version:" $(CHARTS_DIR)/$(CHART)/Chart.yaml | awk '{print $$2}'); \
	git add $(CHARTS_DIR)/$(CHART)/Chart.yaml $(CHARTS_DIR)/$(CHART)/README.md; \
	git commit -m "chore($(CHART)): release version $$NEW_VERSION"; \
	git tag "$(CHART)-$$NEW_VERSION"; \
	echo "✓ Released $(CHART) version $$NEW_VERSION"; \
	echo "Run 'git push origin main --tags' to publish"

.PHONY: publish-release
publish-release: ## Push commits and tags to trigger release workflow
	git push origin main --tags
	@echo "✓ Pushed to main with tags. Check GitHub Actions for release progress."

.PHONY: current-version
current-version: ## Show current version of a chart (usage: make current-version CHART=application)
	@test -n "$(CHART)" || (echo "CHART is not set. Usage: make current-version CHART=application"; exit 1)
	@grep "^version:" $(CHARTS_DIR)/$(CHART)/Chart.yaml | awk '{print $$2}'

# ============================================================================
# Git Flow Release Helpers
# ============================================================================

.PHONY: flow-start
flow-start: ## Start a new release branch (usage: make flow-start CHART=nginx TYPE=patch)
	@test -n "$(CHART)" || (echo "CHART is not set. Usage: make flow-start CHART=nginx TYPE=patch"; exit 1)
	@test -n "$(TYPE)" || TYPE=patch; \
	CURRENT=$$(grep "^version:" $(CHARTS_DIR)/$(CHART)/Chart.yaml | awk '{print $$2}'); \
	case "$(TYPE)" in \
		patch) \
			MAJOR=$$(echo $$CURRENT | cut -d. -f1); \
			MINOR=$$(echo $$CURRENT | cut -d. -f2); \
			PATCH=$$(echo $$CURRENT | cut -d. -f3); \
			NEW_PATCH=$$(($$PATCH + 1)); \
			NEW_VERSION="$$MAJOR.$$MINOR.$$NEW_PATCH" ;; \
		minor) \
			MAJOR=$$(echo $$CURRENT | cut -d. -f1); \
			MINOR=$$(echo $$CURRENT | cut -d. -f2); \
			NEW_MINOR=$$(($$MINOR + 1)); \
			NEW_VERSION="$$MAJOR.$$NEW_MINOR.0" ;; \
		major) \
			MAJOR=$$(echo $$CURRENT | cut -d. -f1); \
			NEW_MAJOR=$$(($$MAJOR + 1)); \
			NEW_VERSION="$$NEW_MAJOR.0.0" ;; \
		*) \
			echo "Invalid TYPE. Use: patch, minor, or major"; \
			exit 1 ;; \
	esac; \
	echo "📦 Starting release branch: release/$(CHART)-$$NEW_VERSION"; \
	git checkout -b "release/$(CHART)-$$NEW_VERSION" main; \
	sed -i '' "s/^version: .*/version: $$NEW_VERSION/" $(CHARTS_DIR)/$(CHART)/Chart.yaml; \
	echo "✓ Created release branch and bumped version from $$CURRENT to $$NEW_VERSION"; \
	echo ""; \
	echo "Next steps:"; \
	echo "  1. Make any final changes"; \
	echo "  2. Run: make flow-finish CHART=$(CHART)"

.PHONY: flow-finish
flow-finish: ## Finish release branch and create tag (usage: make flow-finish CHART=nginx)
	@test -n "$(CHART)" || (echo "CHART is not set. Usage: make flow-finish CHART=nginx"; exit 1)
	@BRANCH=$$(git branch --show-current); \
	if [[ ! "$$BRANCH" =~ ^release/$(CHART)- ]]; then \
		echo "Error: Not on a release branch for $(CHART)"; \
		echo "Current branch: $$BRANCH"; \
		exit 1; \
	fi; \
	VERSION=$$(grep "^version:" $(CHARTS_DIR)/$(CHART)/Chart.yaml | awk '{print $$2}'); \
	echo "🔨 Finishing release: $(CHART)-$$VERSION"; \
	$(MAKE) docs-chart CHART=$(CHART); \
	git add $(CHARTS_DIR)/$(CHART)/Chart.yaml $(CHARTS_DIR)/$(CHART)/README.md; \
	git commit -m "chore($(CHART)): release version $$VERSION"; \
	echo ""; \
	echo "✓ Committed changes"; \
	echo "📝 Merging to main..."; \
	git checkout main; \
	git merge --no-ff "$$BRANCH" -m "Merge branch '$$BRANCH'"; \
	git tag "$(CHART)-$$VERSION" -m "Release $(CHART) version $$VERSION"; \
	git branch -d "$$BRANCH"; \
	echo ""; \
	echo "✅ Release completed successfully!"; \
	echo ""; \
	echo "📋 Summary:"; \
	echo "  Chart: $(CHART)"; \
	echo "  Version: $$VERSION"; \
	echo "  Tag: $(CHART)-$$VERSION"; \
	echo ""; \
	echo "Next step:"; \
	echo "  Run: make flow-publish"

.PHONY: flow-publish
flow-publish: ## Push release to remote and trigger CI/CD
	@echo "🚀 Publishing release to remote..."
	git push origin main --tags
	@echo ""; \
	echo "✅ Release published!"; \
	echo ""; \
	echo "🔍 Monitor the release:"; \
	echo "  https://github.com/codefuturist/helm-charts/actions"

.PHONY: flow-abort
flow-abort: ## Abort current release branch (usage: make flow-abort CHART=nginx)
	@test -n "$(CHART)" || (echo "CHART is not set. Usage: make flow-abort CHART=nginx"; exit 1)
	@BRANCH=$$(git branch --show-current); \
	if [[ ! "$$BRANCH" =~ ^release/$(CHART)- ]]; then \
		echo "Error: Not on a release branch for $(CHART)"; \
		echo "Current branch: $$BRANCH"; \
		exit 1; \
	fi; \
	echo "⚠️  Aborting release branch: $$BRANCH"; \
	read -p "Are you sure? This will delete the branch and lose changes. [y/N] " -n 1 -r; \
	echo; \
	if [[ $$REPLY =~ ^[Yy]$$ ]]; then \
		git checkout main; \
		git branch -D "$$BRANCH"; \
		echo "✓ Release branch deleted"; \
	else \
		echo "Cancelled"; \
	fi

.PHONY: flow-status
flow-status: ## Show current git flow status
	@echo "📊 Git Flow Status"; \
	echo ""; \
	BRANCH=$$(git branch --show-current); \
	echo "Current branch: $$BRANCH"; \
	echo ""; \
	if [[ "$$BRANCH" =~ ^release/ ]]; then \
		echo "🔄 Active release detected!"; \
		CHART=$$(echo $$BRANCH | sed 's/release\/\([^-]*\)-.*/\1/'); \
		VERSION=$$(echo $$BRANCH | sed 's/release\/[^-]*-//'); \
		echo "  Chart: $$CHART"; \
		echo "  Target version: $$VERSION"; \
		if [ -f "$(CHARTS_DIR)/$$CHART/Chart.yaml" ]; then \
			CURRENT=$$(grep "^version:" $(CHARTS_DIR)/$$CHART/Chart.yaml | awk '{print $$2}'); \
			echo "  Chart.yaml version: $$CURRENT"; \
		fi; \
		echo ""; \
		echo "Next steps:"; \
		echo "  - Finish: make flow-finish CHART=$$CHART"; \
		echo "  - Abort:  make flow-abort CHART=$$CHART"; \
	else \
		echo "ℹ️  No active release branch"; \
		echo ""; \
		echo "Start a new release:"; \
		echo "  make flow-start CHART=<name> TYPE=<patch|minor|major>"; \
	fi; \
	echo ""; \
	echo "Available charts:"; \
	$(MAKE) --no-print-directory list-charts

.PHONY: flow-help
flow-help: ## Show git flow usage guide
	@echo "📚 Git Flow Release Guide"; \
	echo ""; \
	echo "Complete release workflow:"; \
	echo ""; \
	echo "1️⃣  Start a release:"; \
	echo "   make flow-start CHART=nginx TYPE=patch"; \
	echo "   (TYPE can be: patch, minor, or major)"; \
	echo ""; \
	echo "2️⃣  Make changes (optional):"; \
	echo "   - Edit chart files"; \
	echo "   - Test changes: make lint-chart CHART=nginx"; \
	echo "   - Add commits as needed"; \
	echo ""; \
	echo "3️⃣  Finish the release:"; \
	echo "   make flow-finish CHART=nginx"; \
	echo "   (Auto-generates docs, commits, merges, and tags)"; \
	echo ""; \
	echo "4️⃣  Publish the release:"; \
	echo "   make flow-publish"; \
	echo "   (Pushes to GitHub and triggers CI/CD)"; \
	echo ""; \
	echo "Other commands:"; \
	echo "  make flow-status          - Check current release status"; \
	echo "  make flow-abort CHART=x   - Cancel and delete release branch"; \
	echo "  make current-version CHART=x - Show current chart version"; \
	echo "  make list-charts          - List all available charts"; \
	echo ""; \
	echo "Quick release (all-in-one):"; \
	echo "  make release-patch CHART=nginx && make publish-release"



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

.PHONY: docs
docs: ## Generate documentation for all charts using helm-docs
	@command -v helm-docs 2>&1 >/dev/null || (echo "helm-docs not found. Install it with: brew install norwoodj/tap/helm-docs"; exit 1)
	helm-docs --chart-search-root=$(CHARTS_DIR)
	@echo "Documentation generated successfully!"

.PHONY: docs-chart
docs-chart: ## Generate documentation for a specific chart (usage: make docs-chart CHART=nginx)
	@command -v helm-docs 2>&1 >/dev/null || (echo "helm-docs not found. Install it with: brew install norwoodj/tap/helm-docs"; exit 1)
	@if [ -z "$(CHART)" ]; then \
		echo "Error: CHART variable is required. Usage: make docs-chart CHART=nginx"; \
		exit 1; \
	fi
	helm-docs --chart-search-root=$(CHARTS_DIR)/$(CHART)
	@echo "Documentation generated for $(CHART)!"

# ============================================================================
# Local CI Integration Testing
# ============================================================================

KIND_CLUSTER_NAME := helm-charts-test
KIND_IMAGE := kindest/node:v1.29.0

.PHONY: ci-local
ci-local: ci-check-deps ci-cluster-create ci-install ci-cluster-delete ## Run full CI pipeline locally (lint + kind + ct install)
	@echo "✅ Local CI completed successfully!"

.PHONY: ci-check-deps
ci-check-deps: ## Check that CI dependencies are installed
	@echo "🔍 Checking CI dependencies..."
	@command -v kind >/dev/null 2>&1 || (echo "❌ kind not found. Install: brew install kind"; exit 1)
	@command -v ct >/dev/null 2>&1 || (echo "❌ chart-testing not found. Install: brew install chart-testing"; exit 1)
	@command -v helm >/dev/null 2>&1 || (echo "❌ helm not found. Install: brew install helm"; exit 1)
	@command -v kubectl >/dev/null 2>&1 || (echo "❌ kubectl not found. Install: brew install kubectl"; exit 1)
	@echo "✓ All dependencies available"

.PHONY: ci-cluster-create
ci-cluster-create: ## Create a kind cluster for testing
	@echo "🔧 Creating kind cluster: $(KIND_CLUSTER_NAME)..."
	@if kind get clusters 2>/dev/null | grep -q "^$(KIND_CLUSTER_NAME)$$"; then \
		echo "ℹ️  Cluster already exists, reusing..."; \
	else \
		kind create cluster --name $(KIND_CLUSTER_NAME) --image $(KIND_IMAGE) --wait 60s; \
	fi
	@kubectl cluster-info --context kind-$(KIND_CLUSTER_NAME)
	@echo "✓ Cluster ready"

.PHONY: ci-install
ci-install: ## Run ct install against the kind cluster
	@echo "📦 Adding Helm repositories..."
	@helm repo add bitnami https://charts.bitnami.com/bitnami 2>/dev/null || true
	@helm repo update
	@echo "🔨 Running ct lint..."
	@ct lint --config ct.yaml --all
	@echo "🚀 Running ct install..."
	@ct install --config ct.yaml --all

.PHONY: ci-cluster-delete
ci-cluster-delete: ## Delete the kind test cluster
	@echo "🧹 Deleting kind cluster: $(KIND_CLUSTER_NAME)..."
	@kind delete cluster --name $(KIND_CLUSTER_NAME) 2>/dev/null || true
	@echo "✓ Cluster deleted"

.PHONY: ci-cluster-keep
ci-cluster-keep: ci-check-deps ci-cluster-create ci-install ## Run CI but keep the cluster for debugging
	@echo "✅ CI completed. Cluster $(KIND_CLUSTER_NAME) kept for debugging."
	@echo "   Delete with: make ci-cluster-delete"
