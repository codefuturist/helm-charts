FROM python:3.11-slim

LABEL org.opencontainers.image.title="Bitwarden ESO Provider"
LABEL org.opencontainers.image.description="Webhook provider for External Secrets Operator using Bitwarden CLI"
LABEL org.opencontainers.image.source="https://github.com/codefuturist/helm-charts"
LABEL org.opencontainers.image.licenses="Apache-2.0"

# Install UV
COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

# Install Bitwarden CLI
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    wget \
    unzip \
    ca-certificates && \
    wget -q https://github.com/bitwarden/clients/releases/download/cli-v2024.10.0/bw-linux-2024.10.0.zip && \
    unzip bw-linux-2024.10.0.zip && \
    chmod +x bw && \
    mv bw /usr/local/bin/ && \
    rm bw-linux-2024.10.0.zip && \
    apt-get remove -y wget unzip && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# Create non-root user
RUN useradd -m -u 1000 -s /bin/bash appuser

# Set working directory
WORKDIR /app

# Set UV environment variables for non-interactive install
ENV UV_SYSTEM_PYTHON=1

# Copy project files
COPY pyproject.toml .
COPY app/requirements.txt .

# Install Python dependencies using UV
RUN uv pip install --system --no-cache -r requirements.txt

# Copy application
COPY app/app.py .

# Create cache directory with proper permissions
RUN mkdir -p /app/.cache && chown -R appuser:appuser /app

# Switch to non-root user
USER appuser

# Expose port
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8080/healthz')" || exit 1

# Run the application
CMD ["python", "app.py"]
