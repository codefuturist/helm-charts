#!/bin/bash
# Quick start script for the compose converter

set -e

echo "🚀 Docker Compose to Helm Chart Converter - Quick Start"
echo ""

# Check if Python 3 is installed
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 is required but not installed."
    exit 1
fi

echo "✓ Python 3 found: $(python3 --version)"

# Check if uv is installed
if ! command -v uv &> /dev/null; then
    echo "📦 uv not found. Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    export PATH="$HOME/.cargo/bin:$PATH"

    if ! command -v uv &> /dev/null; then
        echo "❌ Failed to install uv. Please install manually:"
        echo "   curl -LsSf https://astral.sh/uv/install.sh | sh"
        exit 1
    fi
fi

echo "✓ uv found: $(uv --version)"

# Sync dependencies with uv
echo ""
echo "📦 Installing dependencies with uv..."
uv sync || {
    echo "⚠️  Failed to sync dependencies. Trying pip fallback..."
    uv pip install -r requirements.txt || {
        echo "⚠️  Failed to install some dependencies, but continuing..."
    }
}

# Make the script executable
chmod +x compose2helm.py

echo ""
echo "✅ Setup complete!"
echo ""
echo "Usage examples:"
echo ""
echo "  # Run with uv"
echo "  uv run compose2helm.py -c examples/simple-app.yml -o ../../charts -n simple-app"
echo ""
echo "  # Or activate the virtual environment"
echo "  source .venv/bin/activate"
echo "  python compose2helm.py -c examples/wordpress.yml -o ../../charts -n wordpress"
echo ""
echo "  # Convert a full-stack app"
echo "  uv run compose2helm.py -c examples/fullstack-app.yml -o ../../charts -n fullstack-app"
echo ""
echo "  # Run tests"
echo "  uv run pytest test_compose2helm.py -v"
echo ""
echo "For more information, see README.md"
