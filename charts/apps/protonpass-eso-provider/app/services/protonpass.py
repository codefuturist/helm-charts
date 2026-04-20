"""Proton Pass CLI wrapper service.

Handles authentication, secret retrieval, and session management
by invoking pass-cli as a subprocess.
"""

import asyncio
import json
import logging

from config import Settings
from services.cache import SecretCache

logger = logging.getLogger("protonpass-eso-provider.protonpass")


class ProtonPassError(Exception):
    """Raised when pass-cli returns an error."""

    pass


class ProtonPassService:
    """Wraps pass-cli for secret retrieval and vault management."""

    def __init__(self, settings: Settings, cache: SecretCache):
        self.settings = settings
        self.cache = cache
        self._authenticated = False

    @property
    def authenticated(self) -> bool:
        return self._authenticated

    async def _run_cli(self, *args: str, sensitive: bool = False) -> str:
        """Execute a pass-cli command and return stdout."""
        cmd = [self.settings.pass_cli_path, *args]
        log_cmd = (
            cmd
            if not sensitive
            else [cmd[0], *["***" if i > 0 else a for i, a in enumerate(args)]]
        )
        logger.debug(f"Running: {' '.join(log_cmd)}")

        env = self._build_env()
        proc = await asyncio.create_subprocess_exec(
            *cmd,
            stdout=asyncio.subprocess.PIPE,
            stderr=asyncio.subprocess.PIPE,
            env=env,
        )
        stdout, stderr = await proc.communicate()

        if proc.returncode != 0:
            error_msg = stderr.decode().strip()
            logger.error(f"pass-cli error (exit {proc.returncode}): {error_msg}")
            raise ProtonPassError(error_msg)

        return stdout.decode().strip()

    def _build_env(self) -> dict[str, str]:
        """Build environment variables for pass-cli subprocess."""
        import os

        env = os.environ.copy()
        env["PROTON_PASS_KEY_PROVIDER"] = self.settings.key_provider

        if self.settings.key_provider == "env" and self.settings.encryption_key:
            env["PROTON_PASS_ENCRYPTION_KEY"] = self.settings.encryption_key

        # Suppress interactive prompts
        env["PASS_LOG_LEVEL"] = "warn"

        return env

    async def login(self) -> None:
        """Authenticate with Proton Pass."""
        if not self.settings.username or not self.settings.password:
            raise ProtonPassError(
                "PROTONPASS_USERNAME and PROTONPASS_PASSWORD are required"
            )

        try:
            await self._run_cli(
                "login",
                "--username",
                self.settings.username,
                "--password",
                self.settings.password,
                sensitive=True,
            )
            self._authenticated = True
            logger.info("Successfully authenticated with Proton Pass")
        except ProtonPassError as e:
            self._authenticated = False
            raise ProtonPassError(f"Authentication failed: {e}")

    async def logout(self) -> None:
        """Clear pass-cli session."""
        try:
            await self._run_cli("logout")
            self._authenticated = False
        except ProtonPassError:
            logger.warning(
                "Logout encountered an error (session may already be cleared)"
            )

    async def check_session(self) -> bool:
        """Verify the current session is valid."""
        try:
            await self._run_cli("vault", "list")
            self._authenticated = True
            return True
        except ProtonPassError:
            self._authenticated = False
            return False

    async def get_secret(
        self, item_id: str, field: str = "password", vault: str = ""
    ) -> str:
        """Retrieve a secret value from Proton Pass.

        Args:
            item_id: Item ID or title
            field: Field name (password, username, email, url, note, or custom)
            vault: Optional vault name/ID (uses default if empty)
        """
        vault = vault or self.settings.default_vault
        cache_key = f"{vault}:{item_id}:{field}"

        cached = self.cache.get(cache_key)
        if cached is not None:
            logger.debug(f"Cache hit: {vault}/{item_id}/{field}")
            return cached

        self._check_vault_access(vault)

        # Build the pass:// URI for the secret reference
        ref = self._build_reference(vault, item_id, field)

        try:
            # Use pass-cli to resolve the secret reference via inject from stdin
            result = await self._resolve_reference(ref)
            self.cache.set(cache_key, result)
            logger.info(f"Retrieved secret: {vault}/{item_id}/{field}")
            return result
        except ProtonPassError as e:
            logger.error(f"Failed to retrieve secret {vault}/{item_id}/{field}: {e}")
            raise

    async def _resolve_reference(self, ref: str) -> str:
        """Resolve a pass:// secret reference to its value."""
        # Use inject command with stdin to resolve the reference
        template = f"{{{{ {ref} }}}}"

        cmd = [self.settings.pass_cli_path, "inject"]
        env = self._build_env()

        proc = await asyncio.create_subprocess_exec(
            *cmd,
            stdin=asyncio.subprocess.PIPE,
            stdout=asyncio.subprocess.PIPE,
            stderr=asyncio.subprocess.PIPE,
            env=env,
        )
        stdout, stderr = await proc.communicate(input=template.encode())

        if proc.returncode != 0:
            error_msg = stderr.decode().strip()
            raise ProtonPassError(error_msg)

        return stdout.decode().strip()

    def _build_reference(self, vault: str, item: str, field: str) -> str:
        """Build a pass:// URI from components."""
        parts = ["pass:/"]
        if vault:
            parts.append(vault)
        parts.append(item)
        parts.append(field)
        return "/".join(parts)

    def _check_vault_access(self, vault: str) -> None:
        """Enforce vault access control."""
        if not vault:
            return

        if self.settings.denied_vaults and vault in self.settings.denied_vaults:
            raise ProtonPassError(f"Access denied: vault '{vault}' is in the deny list")

        if self.settings.allowed_vaults and vault not in self.settings.allowed_vaults:
            raise ProtonPassError(
                f"Access denied: vault '{vault}' is not in the allow list"
            )

    async def list_vaults(self) -> list[dict]:
        """List accessible vaults (metadata only)."""
        output = await self._run_cli("vault", "list", "--output", "json")
        try:
            vaults = json.loads(output)
        except json.JSONDecodeError:
            # Fallback: parse text output
            return [
                {"id": "", "name": line.strip()}
                for line in output.splitlines()
                if line.strip()
            ]

        # Apply access control filtering
        filtered = []
        for v in vaults:
            name = v.get("name", "")
            if self.settings.denied_vaults and name in self.settings.denied_vaults:
                continue
            if (
                self.settings.allowed_vaults
                and name not in self.settings.allowed_vaults
            ):
                continue
            filtered.append(v)

        return filtered

    async def list_items(self, vault: str) -> list[dict]:
        """List items in a vault (metadata only, no secret values)."""
        self._check_vault_access(vault)

        args = ["item", "list", "--vault", vault, "--output", "json"]
        output = await self._run_cli(*args)

        try:
            return json.loads(output)
        except json.JSONDecodeError:
            return [
                {"id": "", "title": line.strip()}
                for line in output.splitlines()
                if line.strip()
            ]
