"""
Proton Pass ESO Provider — FastAPI webhook service for External Secrets Operator.

Bridges Proton Pass CLI (pass-cli) with Kubernetes External Secrets Operator
via the webhook provider interface.
"""

import logging

from fastapi import FastAPI
from contextlib import asynccontextmanager

from config import Settings
from routes.secrets import router as secrets_router
from routes.health import router as health_router
from routes.admin import router as admin_router
from services.protonpass import ProtonPassService
from services.cache import SecretCache

logger = logging.getLogger("protonpass-eso-provider")


@asynccontextmanager
async def lifespan(app: FastAPI):
    """Initialize pass-cli session on startup, cleanup on shutdown."""
    settings = app.state.settings
    protonpass = app.state.protonpass

    logger.info("Starting Proton Pass ESO Provider")
    logger.info(f"Key provider: {settings.key_provider}")
    logger.info(f"Cache enabled: {settings.cache_enabled}, TTL: {settings.cache_ttl}s")

    await protonpass.login()
    logger.info("Proton Pass session established")

    yield

    logger.info("Shutting down Proton Pass ESO Provider")
    await protonpass.logout()


def create_app() -> FastAPI:
    """Create and configure the FastAPI application."""
    settings = Settings()

    logging.basicConfig(
        level=getattr(logging, settings.log_level.upper(), logging.INFO),
        format="%(asctime)s %(levelname)s [%(name)s] %(message)s",
    )

    app = FastAPI(
        title="Proton Pass ESO Provider",
        description="External Secrets Operator webhook provider for Proton Pass",
        version="1.0.0",
        docs_url="/docs" if settings.debug else None,
        redoc_url=None,
        lifespan=lifespan,
    )

    cache = SecretCache(
        enabled=settings.cache_enabled,
        ttl=settings.cache_ttl,
        max_entries=settings.cache_max_entries,
    )
    protonpass = ProtonPassService(settings=settings, cache=cache)

    app.state.settings = settings
    app.state.protonpass = protonpass
    app.state.cache = cache

    app.include_router(health_router, tags=["health"])
    app.include_router(secrets_router, prefix="/api/v1", tags=["secrets"])

    if settings.admin_enabled:
        app.include_router(admin_router, prefix="/api/v1", tags=["admin"])

    return app


app = create_app()
