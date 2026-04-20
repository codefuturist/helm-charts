"""In-memory TTL cache for secret values."""

import logging
import time
from collections import OrderedDict
from threading import Lock
from typing import Optional

logger = logging.getLogger("protonpass-eso-provider.cache")


class SecretCache:
    """Thread-safe in-memory cache with TTL and max size eviction."""

    def __init__(self, enabled: bool = True, ttl: int = 300, max_entries: int = 1000):
        self.enabled = enabled
        self.ttl = ttl
        self.max_entries = max_entries
        self._cache: OrderedDict[str, tuple[str, float]] = OrderedDict()
        self._lock = Lock()
        self._hits = 0
        self._misses = 0

    def get(self, key: str) -> Optional[str]:
        """Retrieve a cached value if it exists and hasn't expired."""
        if not self.enabled:
            return None

        with self._lock:
            entry = self._cache.get(key)
            if entry is None:
                self._misses += 1
                return None

            value, timestamp = entry
            if time.monotonic() - timestamp > self.ttl:
                del self._cache[key]
                self._misses += 1
                logger.debug(f"Cache expired: {key}")
                return None

            # Move to end (most recently used)
            self._cache.move_to_end(key)
            self._hits += 1
            return value

    def set(self, key: str, value: str) -> None:
        """Store a value in the cache."""
        if not self.enabled:
            return

        with self._lock:
            self._cache[key] = (value, time.monotonic())
            self._cache.move_to_end(key)

            # Evict oldest entries if over max size
            while len(self._cache) > self.max_entries:
                evicted_key, _ = self._cache.popitem(last=False)
                logger.debug(f"Cache evicted: {evicted_key}")

    def invalidate(self, key: str) -> None:
        """Remove a specific entry from cache."""
        if not self.enabled:
            return

        with self._lock:
            self._cache.pop(key, None)

    def clear(self) -> None:
        """Clear all cached entries."""
        with self._lock:
            self._cache.clear()
            logger.info("Cache cleared")

    @property
    def stats(self) -> dict:
        """Return cache statistics."""
        with self._lock:
            return {
                "enabled": self.enabled,
                "entries": len(self._cache),
                "max_entries": self.max_entries,
                "ttl": self.ttl,
                "hits": self._hits,
                "misses": self._misses,
                "hit_rate": (
                    round(self._hits / (self._hits + self._misses), 3)
                    if (self._hits + self._misses) > 0
                    else 0
                ),
            }
