"""Admin endpoints for vault browsing and cache management.

These are optional endpoints gated behind ADMIN_ENABLED=true.
They expose vault/item metadata (never secret values) for debugging.
"""

import logging

from fastapi import APIRouter, Depends, Request, HTTPException

from models import VaultInfo, ItemInfo, ErrorResponse
from routes.secrets import verify_token
from services.protonpass import ProtonPassError

logger = logging.getLogger("protonpass-eso-provider.routes.admin")

router = APIRouter()


@router.get(
    "/vaults",
    response_model=list[VaultInfo],
    responses={500: {"model": ErrorResponse}},
)
async def list_vaults(
    request: Request,
    _auth: None = Depends(verify_token),
):
    """List accessible Proton Pass vaults (metadata only)."""
    protonpass = request.app.state.protonpass

    try:
        vaults = await protonpass.list_vaults()
        return [
            VaultInfo(
                id=v.get("id", v.get("share_id", "")),
                name=v.get("name", ""),
                item_count=v.get("item_count", 0),
            )
            for v in vaults
        ]
    except ProtonPassError as e:
        raise HTTPException(status_code=500, detail=str(e))


@router.get(
    "/items/{vault}",
    response_model=list[ItemInfo],
    responses={500: {"model": ErrorResponse}},
)
async def list_items(
    vault: str,
    request: Request,
    _auth: None = Depends(verify_token),
):
    """List items in a vault (metadata only, no secret values)."""
    protonpass = request.app.state.protonpass

    try:
        items = await protonpass.list_items(vault)
        return [
            ItemInfo(
                id=item.get("id", item.get("item_id", "")),
                title=item.get("title", item.get("name", "")),
                vault=vault,
                type=item.get("type", "login"),
                fields=item.get("fields", []),
            )
            for item in items
        ]
    except ProtonPassError as e:
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/cache/stats")
async def cache_stats(
    request: Request,
    _auth: None = Depends(verify_token),
):
    """Return cache statistics."""
    return request.app.state.cache.stats


@router.post("/cache/clear")
async def cache_clear(
    request: Request,
    _auth: None = Depends(verify_token),
):
    """Clear the secret cache."""
    request.app.state.cache.clear()
    return {"status": "cleared"}
