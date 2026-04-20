"""Application configuration via environment variables."""

import os
from dataclasses import dataclass, field


@dataclass
class Settings:
    """Provider settings loaded from environment variables."""

    # Proton Pass authentication
    username: str = field(
        default_factory=lambda: os.environ.get("PROTONPASS_USERNAME", "")
    )
    password: str = field(
        default_factory=lambda: os.environ.get("PROTONPASS_PASSWORD", "")
    )

    # Key provider for pass-cli session encryption (keyring, fs, env)
    key_provider: str = field(
        default_factory=lambda: os.environ.get("PROTON_PASS_KEY_PROVIDER", "fs")
    )
    encryption_key: str = field(
        default_factory=lambda: os.environ.get("PROTON_PASS_ENCRYPTION_KEY", "")
    )

    # API authentication (bearer token for ESO webhook requests)
    api_token: str = field(default_factory=lambda: os.environ.get("API_TOKEN", ""))

    # Vault access control
    allowed_vaults: list[str] = field(
        default_factory=lambda: _parse_list("PROTONPASS_ALLOWED_VAULTS")
    )
    denied_vaults: list[str] = field(
        default_factory=lambda: _parse_list("PROTONPASS_DENIED_VAULTS")
    )
    default_vault: str = field(
        default_factory=lambda: os.environ.get("PROTONPASS_DEFAULT_VAULT", "")
    )

    # Cache configuration
    cache_enabled: bool = field(
        default_factory=lambda: os.environ.get("CACHE_ENABLED", "true").lower()
        == "true"
    )
    cache_ttl: int = field(
        default_factory=lambda: int(os.environ.get("CACHE_TTL", "300"))
    )
    cache_max_entries: int = field(
        default_factory=lambda: int(os.environ.get("CACHE_MAX_ENTRIES", "1000"))
    )

    # Server configuration
    host: str = field(default_factory=lambda: os.environ.get("HOST", "0.0.0.0"))
    port: int = field(default_factory=lambda: int(os.environ.get("PORT", "8080")))
    log_level: str = field(default_factory=lambda: os.environ.get("LOG_LEVEL", "info"))
    debug: bool = field(
        default_factory=lambda: os.environ.get("DEBUG", "false").lower() == "true"
    )

    # Feature flags
    admin_enabled: bool = field(
        default_factory=lambda: os.environ.get("ADMIN_ENABLED", "false").lower()
        == "true"
    )
    metrics_enabled: bool = field(
        default_factory=lambda: os.environ.get("METRICS_ENABLED", "false").lower()
        == "true"
    )

    # pass-cli binary path
    pass_cli_path: str = field(
        default_factory=lambda: os.environ.get("PASS_CLI_PATH", "pass-cli")
    )


def _parse_list(env_var: str) -> list[str]:
    """Parse comma-separated environment variable into a list."""
    value = os.environ.get(env_var, "")
    if not value:
        return []
    return [v.strip() for v in value.split(",") if v.strip()]
