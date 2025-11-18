#!/usr/bin/env python3
"""
Bitwarden ESO Provider - Webhook service for External Secrets Operator
Provides integration between ESO and Bitwarden CLI for personal/organizational vaults
"""

import os
import sys
import json
import subprocess
import time
import logging
from threading import Lock
from functools import lru_cache
from typing import Optional, Dict, Any
from flask import Flask, request, jsonify
from werkzeug.exceptions import HTTPException

# Configuration
BW_SERVER = os.getenv("BW_SERVER", "https://vault.bitwarden.com")
BW_AUTH_METHOD = os.getenv("BW_AUTH_METHOD", "apikey")  # apikey or password
BW_SESSION_TTL = int(os.getenv("BW_SESSION_TTL", "3600"))
BW_SYNC_INTERVAL = int(os.getenv("BW_SYNC_INTERVAL", "300"))
API_PORT = int(os.getenv("API_PORT", "8080"))
API_TOKEN = os.getenv("API_TOKEN")
API_TOKEN_FILE = os.getenv("API_TOKEN_FILE")
CACHE_ENABLED = os.getenv("CACHE_ENABLED", "true").lower() == "true"
CACHE_TTL = int(os.getenv("CACHE_TTL", "60"))
CACHE_MAX_SIZE = int(os.getenv("CACHE_MAX_SIZE", "1000"))
LOG_LEVEL = os.getenv("LOG_LEVEL", "info").upper()
LOG_FORMAT = os.getenv("LOG_FORMAT", "json")
SKIP_BW_CHECK = os.getenv("SKIP_BW_CHECK", "false").lower() == "true"  # For testing

# Initialize Flask app
app = Flask(__name__)

# Configure logging
if LOG_FORMAT == "json":
    import json_logging
    json_logging.init_flask(enable_json=True)
    json_logging.init_request_instrument(app)

logging.basicConfig(
    level=getattr(logging, LOG_LEVEL),
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

# Session management
session_lock = Lock()
session_token: Optional[str] = None
session_expires: float = 0
last_sync: float = 0

# Metrics
metrics = {
    "requests_total": 0,
    "requests_success": 0,
    "requests_error": 0,
    "cache_hits": 0,
    "cache_misses": 0,
    "session_renewals": 0,
}
metrics_lock = Lock()


class BitwardenError(Exception):
    """Custom exception for Bitwarden operations"""
    pass


def run_bw_command(args: list, env: Optional[Dict[str, str]] = None) -> subprocess.CompletedProcess:
    """Execute a Bitwarden CLI command"""
    cmd = ["bw"] + args
    full_env = os.environ.copy()
    if env:
        full_env.update(env)

    logger.debug(f"Running command: {' '.join(args)}")

    result = subprocess.run(
        cmd,
        capture_output=True,
        text=True,
        env=full_env
    )

    if result.returncode != 0:
        logger.error(f"Command failed: {result.stderr}")
        raise BitwardenError(f"Bitwarden CLI error: {result.stderr}")

    return result


def ensure_bw_installed():
    """Verify Bitwarden CLI is installed"""
    try:
        result = subprocess.run(
            ["bw", "--version"],
            capture_output=True,
            text=True,
            timeout=5  # 5 second timeout to prevent hanging
        )
        if result.returncode == 0:
            logger.info(f"Bitwarden CLI version: {result.stdout.strip()}")
            return True
        else:
            logger.error(f"Bitwarden CLI check failed with code {result.returncode}: {result.stderr}")
            return False
    except FileNotFoundError:
        logger.error("Bitwarden CLI not found in PATH")
        return False
    except subprocess.TimeoutExpired:
        logger.error("Bitwarden CLI check timed out (may be Rosetta emulation issue on Apple Silicon)")
        return False
    except Exception as e:
        logger.error(f"Unexpected error checking Bitwarden CLI: {e}")
        return False


def configure_server():
    """Configure Bitwarden server URL"""
    if BW_SERVER != "https://vault.bitwarden.com":
        logger.info(f"Configuring Bitwarden server: {BW_SERVER}")
        run_bw_command(["config", "server", BW_SERVER])


def login_and_get_session() -> str:
    """Login to Bitwarden and get session token"""
    logger.info("Logging in to Bitwarden...")

    if BW_AUTH_METHOD == "apikey":
        client_id = os.getenv("BW_CLIENTID")
        client_secret = os.getenv("BW_CLIENTSECRET")

        if not client_id or not client_secret:
            raise BitwardenError("BW_CLIENTID and BW_CLIENTSECRET are required for API key auth")

        result = run_bw_command(
            ["login", "--apikey", "--raw"],
            env={
                "BW_CLIENTID": client_id,
                "BW_CLIENTSECRET": client_secret
            }
        )

    elif BW_AUTH_METHOD == "password":
        email = os.getenv("BW_EMAIL")
        password = os.getenv("BW_PASSWORD")

        if not email or not password:
            raise BitwardenError("BW_EMAIL and BW_PASSWORD are required for password auth")

        result = run_bw_command(
            ["login", email, password, "--raw"]
        )

    else:
        raise BitwardenError(f"Unknown auth method: {BW_AUTH_METHOD}")

    token = result.stdout.strip()
    logger.info("Successfully logged in to Bitwarden")
    return token


def sync_vault(session: str):
    """Sync Bitwarden vault"""
    logger.info("Syncing Bitwarden vault...")
    run_bw_command(["sync"], env={"BW_SESSION": session})
    logger.info("Vault synced successfully")


def ensure_session() -> str:
    """Ensure we have a valid Bitwarden session"""
    global session_token, session_expires, last_sync

    with session_lock:
        current_time = time.time()

        # Check if session is expired
        if current_time >= session_expires:
            logger.info("Session expired, logging in...")
            session_token = login_and_get_session()
            session_expires = current_time + BW_SESSION_TTL
            last_sync = current_time
            sync_vault(session_token)
            with metrics_lock:
                metrics["session_renewals"] += 1

        # Check if we need to sync
        elif current_time - last_sync >= BW_SYNC_INTERVAL:
            logger.info("Syncing vault (periodic)...")
            try:
                sync_vault(session_token)
                last_sync = current_time
            except BitwardenError as e:
                logger.warning(f"Sync failed, will retry: {e}")

        return session_token


def get_cache_bucket() -> int:
    """Get current cache bucket (for TTL-based cache invalidation)"""
    if not CACHE_ENABLED:
        # Always return 0 to effectively disable caching
        return 0
    return int(time.time() / CACHE_TTL)


@lru_cache(maxsize=CACHE_MAX_SIZE)
def get_secret_cached(item_id: str, field: str, cache_bucket: int) -> Optional[str]:
    """
    Get secret with caching
    cache_bucket is used to invalidate cache based on CACHE_TTL
    """
    session = ensure_session()

    logger.info(f"Fetching item: {item_id}, field: {field}")

    try:
        result = run_bw_command(
            ["get", "item", item_id],
            env={"BW_SESSION": session}
        )
    except BitwardenError:
        # Try by name if UUID fails
        logger.debug(f"Failed to fetch by ID, trying by name: {item_id}")
        result = run_bw_command(
            ["get", "item", item_id, "--search"],
            env={"BW_SESSION": session}
        )

    item = json.loads(result.stdout)
    logger.debug(f"Item fetched: {item.get('name', 'unknown')}")

    # Extract field value
    value = extract_field(item, field)

    if value is None:
        logger.warning(f"Field '{field}' not found in item '{item_id}'")

    return value


def extract_field(item: Dict[str, Any], field: str) -> Optional[str]:
    """Extract a specific field from a Bitwarden item"""

    # Handle standard fields
    if field == "password":
        return item.get("login", {}).get("password")

    elif field == "username":
        return item.get("login", {}).get("username")

    elif field == "totp":
        return item.get("login", {}).get("totp")

    elif field == "uri":
        uris = item.get("login", {}).get("uris", [])
        if uris:
            return uris[0].get("uri")

    elif field == "notes":
        return item.get("notes")

    # Handle custom fields
    elif field.startswith("field:"):
        field_name = field[6:]
        for f in item.get("fields", []):
            if f.get("name") == field_name:
                return f.get("value")

    # Handle attachments
    elif field.startswith("attachment:"):
        attachment_name = field[11:]
        for attachment in item.get("attachments", []):
            if attachment.get("fileName") == attachment_name:
                # TODO: Download attachment
                logger.warning("Attachment download not yet implemented")
                return None

    # Default: try to find in item root
    return item.get(field)


@app.route("/healthz", methods=["GET"])
def health():
    """Health check endpoint"""
    return jsonify({"status": "healthy", "timestamp": time.time()})


@app.route("/readyz", methods=["GET"])
def ready():
    """Readiness check endpoint"""
    try:
        ensure_session()
        return jsonify({
            "status": "ready",
            "timestamp": time.time(),
            "session_expires_in": max(0, int(session_expires - time.time()))
        })
    except Exception as e:
        logger.error(f"Readiness check failed: {e}")
        return jsonify({
            "status": "not ready",
            "error": str(e),
            "timestamp": time.time()
        }), 503


@app.route("/metrics", methods=["GET"])
def get_metrics():
    """Prometheus metrics endpoint"""
    with metrics_lock:
        lines = [
            "# HELP bitwarden_eso_requests_total Total number of webhook requests",
            "# TYPE bitwarden_eso_requests_total counter",
            f"bitwarden_eso_requests_total {metrics['requests_total']}",
            "",
            "# HELP bitwarden_eso_requests_success Total number of successful webhook requests",
            "# TYPE bitwarden_eso_requests_success counter",
            f"bitwarden_eso_requests_success {metrics['requests_success']}",
            "",
            "# HELP bitwarden_eso_requests_error Total number of failed webhook requests",
            "# TYPE bitwarden_eso_requests_error counter",
            f"bitwarden_eso_requests_error {metrics['requests_error']}",
            "",
            "# HELP bitwarden_eso_cache_hits Total number of cache hits",
            "# TYPE bitwarden_eso_cache_hits counter",
            f"bitwarden_eso_cache_hits {metrics['cache_hits']}",
            "",
            "# HELP bitwarden_eso_cache_misses Total number of cache misses",
            "# TYPE bitwarden_eso_cache_misses counter",
            f"bitwarden_eso_cache_misses {metrics['cache_misses']}",
            "",
            "# HELP bitwarden_eso_session_renewals Total number of session renewals",
            "# TYPE bitwarden_eso_session_renewals counter",
            f"bitwarden_eso_session_renewals {metrics['session_renewals']}",
            "",
            "# HELP bitwarden_eso_session_expires_at Timestamp when session expires",
            "# TYPE bitwarden_eso_session_expires_at gauge",
            f"bitwarden_eso_session_expires_at {session_expires}",
            "",
        ]
    return "\n".join(lines), 200, {"Content-Type": "text/plain; charset=utf-8"}


@app.route("/api/v1/secret", methods=["POST"])
def get_secret():
    """
    Webhook endpoint for External Secrets Operator

    Expected request body:
    {
        "itemId": "uuid-or-name",
        "field": "password|username|field:custom_field_name"
    }

    Response:
    {
        "value": "secret-value"
    }
    """
    # Increment request counter
    with metrics_lock:
        metrics["requests_total"] += 1

    # Validate authentication
    auth_header = request.headers.get("Authorization", "")
    if not auth_header.startswith("Bearer "):
        logger.warning("Missing or invalid Authorization header")
        with metrics_lock:
            metrics["requests_error"] += 1
        return jsonify({"error": "Unauthorized"}), 401

    provided_token = auth_header[7:]  # Remove "Bearer " prefix
    if provided_token != API_TOKEN:
        logger.warning("Invalid API token")
        with metrics_lock:
            metrics["requests_error"] += 1
        return jsonify({"error": "Unauthorized"}), 401

    # Parse request
    data = request.json
    if not data:
        with metrics_lock:
            metrics["requests_error"] += 1
        return jsonify({"error": "Request body is required"}), 400

    item_id = data.get("itemId")
    field = data.get("field", "password")

    if not item_id:
        with metrics_lock:
            metrics["requests_error"] += 1
        return jsonify({"error": "itemId is required"}), 400

    # Fetch secret
    try:
        cache_bucket = get_cache_bucket()
        value = get_secret_cached(item_id, field, cache_bucket)

        if value is None:
            with metrics_lock:
                metrics["requests_error"] += 1
            return jsonify({"error": f"Field '{field}' not found in item '{item_id}'"}), 404

        with metrics_lock:
            metrics["requests_success"] += 1
        return jsonify({"value": value})

    except BitwardenError as e:
        logger.error(f"Bitwarden error: {e}")
        with metrics_lock:
            metrics["requests_error"] += 1
        return jsonify({"error": str(e)}), 500

    except Exception as e:
        logger.error(f"Unexpected error: {e}", exc_info=True)
        with metrics_lock:
            metrics["requests_error"] += 1
        return jsonify({"error": "Internal server error"}), 500


@app.errorhandler(HTTPException)
def handle_http_exception(e):
    """Handle HTTP exceptions"""
    response = e.get_response()
    response.data = json.dumps({
        "error": e.name,
        "description": e.description,
    })
    response.content_type = "application/json"
    return response


@app.errorhandler(Exception)
def handle_exception(e):
    """Handle unexpected exceptions"""
    logger.error(f"Unhandled exception: {e}", exc_info=True)
    return jsonify({"error": "Internal server error"}), 500


def initialize():
    """Initialize the application"""
    logger.info("Initializing Bitwarden ESO Provider...")
    logger.info(f"Server: {BW_SERVER}")
    logger.info(f"Auth method: {BW_AUTH_METHOD}")
    logger.info(f"Cache enabled: {CACHE_ENABLED}")

    # Read API token from file if configured
    global API_TOKEN
    if API_TOKEN_FILE and os.path.exists(API_TOKEN_FILE):
        try:
            with open(API_TOKEN_FILE, 'r') as f:
                API_TOKEN = f.read().strip()
            logger.info(f"API token loaded from {API_TOKEN_FILE}")
        except Exception as e:
            logger.error(f"Failed to read API token from {API_TOKEN_FILE}: {e}")
            sys.exit(1)

    if not API_TOKEN:
        logger.error("API_TOKEN is not set!")
        sys.exit(1)

    if SKIP_BW_CHECK:
        logger.warning("Skipping Bitwarden CLI check (SKIP_BW_CHECK=true)")
    else:
        if not ensure_bw_installed():
            logger.error("Bitwarden CLI is not installed!")
            sys.exit(1)

        configure_server()

        # Pre-warm session
        try:
            ensure_session()
            logger.info("Initialization complete")
        except Exception as e:
            logger.error(f"Failed to initialize session: {e}")
            sys.exit(1)


if __name__ == "__main__":
    initialize()
    app.run(host="0.0.0.0", port=API_PORT, debug=False)
