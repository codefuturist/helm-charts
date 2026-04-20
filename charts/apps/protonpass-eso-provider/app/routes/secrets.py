"""Secret retrieval endpoint — ESO webhook provider interface."""

import logging

from fastapi import APIRouter, Depends, Header, HTTPException, Request

from models import SecretRequest, SecretResponse, ErrorResponse
from services.protonpass import ProtonPassError

logger = logging.getLogger("protonpass-eso-provider.routes.secrets")

router = APIRouter()


async def verify_token(request: Request, authorization: str = Header(...)) -> None:
    """Verify the bearer token from ESO webhook requests."""
    expected = request.app.state.settings.api_token
    if not expected:
        return  # No token configured, skip auth

    if not authorization.startswith("Bearer "):
        raise HTTPException(status_code=401, detail="Invalid authorization header")

    token = authorization[7:]
    if token != expected:
        raise HTTPException(status_code=401, detail="Invalid API token")


@router.post(
    "/secret",
    response_model=SecretResponse,
    responses={
        401: {"model": ErrorResponse, "description": "Unauthorized"},
        404: {"model": ErrorResponse, "description": "Secret not found"},
        500: {"model": ErrorResponse, "description": "Internal server error"},
    },
)
async def get_secret(
    body: SecretRequest,
    request: Request,
    _auth: None = Depends(verify_token),
):
    """Retrieve a secret from Proton Pass.

    This is the main webhook endpoint called by External Secrets Operator.
    ESO sends the itemId and field, and we return the resolved secret value.
    """
    protonpass = request.app.state.protonpass

    if not protonpass.authenticated:
        raise HTTPException(
            status_code=503,
            detail="Proton Pass session not authenticated",
        )

    try:
        value = await protonpass.get_secret(
            item_id=body.itemId,
            field=body.field,
            vault=body.vault,
        )
        return SecretResponse(value=value)
    except ProtonPassError as e:
        error_str = str(e)
        if "not found" in error_str.lower():
            raise HTTPException(status_code=404, detail=error_str)
        raise HTTPException(status_code=500, detail=error_str)
