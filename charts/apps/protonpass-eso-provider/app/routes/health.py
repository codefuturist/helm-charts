"""Health check endpoints for liveness and readiness probes."""

import logging

from fastapi import APIRouter, Request

from models import HealthResponse

logger = logging.getLogger("protonpass-eso-provider.routes.health")

router = APIRouter()


@router.get("/healthz", response_model=HealthResponse)
async def liveness(request: Request):
    """Liveness probe — always returns 200 if the process is running."""
    protonpass = request.app.state.protonpass
    return HealthResponse(
        status="ok",
        authenticated=protonpass.authenticated,
    )


@router.get("/readyz", response_model=HealthResponse)
async def readiness(request: Request):
    """Readiness probe — checks pass-cli session is valid."""
    protonpass = request.app.state.protonpass

    if not protonpass.authenticated:
        # Try to re-check session
        is_valid = await protonpass.check_session()
        if not is_valid:
            return HealthResponse(
                status="not_ready",
                authenticated=False,
            )

    return HealthResponse(
        status="ok",
        authenticated=True,
    )
