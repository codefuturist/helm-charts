"""Pydantic models for API request/response schemas."""

from pydantic import BaseModel, Field


class SecretRequest(BaseModel):
    """ESO webhook request body."""

    itemId: str = Field(..., description="Proton Pass item ID or title")
    field: str = Field(
        default="password",
        description="Field name to retrieve (password, username, email, url, note, or custom)",
    )
    vault: str = Field(default="", description="Optional vault name/ID override")


class SecretResponse(BaseModel):
    """ESO webhook response body."""

    value: str = Field(..., description="The resolved secret value")


class ErrorResponse(BaseModel):
    """Error response body."""

    error: str
    detail: str = ""


class HealthResponse(BaseModel):
    """Health check response."""

    status: str
    authenticated: bool
    version: str = "1.0.0"


class VaultInfo(BaseModel):
    """Vault metadata (admin endpoint)."""

    id: str
    name: str
    item_count: int = 0


class ItemInfo(BaseModel):
    """Item metadata without secret values (admin endpoint)."""

    id: str
    title: str
    vault: str
    type: str = "login"
    fields: list[str] = []
