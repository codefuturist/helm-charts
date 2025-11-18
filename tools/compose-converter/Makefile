# Makefile for Docker Compose to Helm Converter

.PHONY: help install sync test unittest examples clean lint format validate

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Available targets:'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-20s %s\n", $$1, $$2}'

install: ## Install uv if not present
	@echo "Checking for uv..."
	@command -v uv >/dev/null 2>&1 || { \
		echo "Installing uv..."; \
		curl -LsSf https://astral.sh/uv/install.sh | sh; \
	}
	@echo "✓ uv is installed"

sync: install ## Sync dependencies with uv
	@echo "Syncing dependencies with uv..."
	uv sync
	chmod +x compose2helm.py
	@echo "✓ Dependencies synced"

unittest: ## Run unit tests with uv
	@echo "Running unit tests..."
	uv run python test_compose2helm.py -v
	@echo "✓ Unit tests complete"

test: unittest ## Run integration tests on example compose files
	@echo ""
	@echo "Testing simple app conversion..."
	uv run python compose2helm.py -c examples/simple-app.yml -o ../../test-output -n simple-app-test
	@echo ""
	@echo "Testing WordPress conversion..."
	uv run python compose2helm.py -c examples/wordpress.yml -o ../../test-output -n wordpress-test
	@echo ""
	@echo "Testing full-stack app conversion..."
	uv run python compose2helm.py -c examples/fullstack-app.yml -o ../../test-output -n fullstack-test
	@echo ""
	@echo "✓ All tests completed"

examples: ## Convert all example compose files
	@echo "Converting examples to charts..."
	@mkdir -p ../../charts/generated
	uv run python compose2helm.py -c examples/simple-app.yml -o ../../charts/generated -n simple-app
	uv run python compose2helm.py -c examples/wordpress.yml -o ../../charts/generated -n wordpress
	uv run python compose2helm.py -c examples/fullstack-app.yml -o ../../charts/generated -n fullstack-app
	@echo "✓ Examples converted to ../../charts/generated/"

lint: sync ## Lint the Python code with ruff
	@echo "Linting Python code..."
	uv run ruff check compose2helm.py test_compose2helm.py || true
	@echo "✓ Linting complete"

format: sync ## Format code with black and ruff
	@echo "Formatting Python code..."
	uv run black compose2helm.py test_compose2helm.py
	uv run ruff check --fix compose2helm.py test_compose2helm.py || true
	@echo "✓ Formatting complete"

clean: ## Clean up generated test files
	@echo "Cleaning up test output..."
	rm -rf ../../test-output
	rm -rf ../../charts/generated
	rm -rf .venv
	rm -rf __pycache__
	rm -rf .pytest_cache
	rm -rf .ruff_cache
	@echo "✓ Cleanup complete"

validate: ## Validate generated charts
	@echo "Validating generated charts..."
	@if [ -d "../../charts/generated" ]; then \
		for chart in ../../charts/generated/*/; do \
			echo "Validating $$chart..."; \
			helm lint "$$chart" || true; \
		done; \
	else \
		echo "No generated charts found. Run 'make examples' first."; \
	fi

quick-start: ## Quick start - install and run example
	@echo "Running quick start..."
	@bash setup.sh
	@echo ""
	@echo "Converting simple-app example..."
	python3 compose2helm.py -c examples/simple-app.yml -o ../../charts -n simple-app-example
	@echo ""
	@echo "✓ Quick start complete! Check ../../charts/simple-app-example/"
