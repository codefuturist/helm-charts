FROM python:3.12-slim AS base

LABEL org.opencontainers.image.source="https://github.com/codefuturist/helm-charts"
LABEL org.opencontainers.image.description="Proton Pass ESO Provider — External Secrets Operator webhook for Proton Pass"

RUN apt-get update && apt-get install -y --no-install-recommends \
        curl \
        jq \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install Proton Pass CLI
RUN curl -fsSL https://proton.me/download/pass-cli/install.sh | bash

# Create non-root user
RUN groupadd -r provider && useradd -r -g provider -d /app -s /sbin/nologin provider

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Session & key storage directory
RUN mkdir -p /app/.session && chown -R provider:provider /app

USER provider

ENV PROTON_PASS_KEY_PROVIDER=fs \
    PROTON_PASS_SESSION_DIR=/app/.session \
    PORT=8080 \
    HOST=0.0.0.0

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=5s --start-period=15s --retries=3 \
    CMD curl -f http://localhost:8080/healthz || exit 1

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080", "--workers", "1"]
