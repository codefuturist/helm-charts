#!/usr/bin/env python3
"""
Sync canonical boilerplate files across all Helm charts.

This script ensures consistency across ALL charts (not just Copier-managed ones)
by syncing specific "canonical" files from template sources.

Synced resources:
  - .helmignore     — from templates/chart-template/.helmignore
  - Chart.yaml      — ensures standard annotations and maintainer fields

Run as a pre-commit hook or standalone.
"""

import argparse
import sys
from pathlib import Path
from typing import List, Tuple

import yaml

SCRIPT_DIR = Path(__file__).parent
REPO_ROOT = SCRIPT_DIR.parent.parent

# Canonical source files
CANONICAL_HELMIGNORE = REPO_ROOT / "templates" / "chart-template" / ".helmignore"

# Standard annotations that should be present in every Chart.yaml
STANDARD_ANNOTATIONS = {
    # No forced annotations by default — add entries here to enforce them.
    # Example: "category": "application"
}

# Standard maintainer
STANDARD_MAINTAINER = {
    "name": "codefuturist",
    "email": "hello@allcloud.trade",
}

# Charts directories to scan (supports nested structures like charts/apps/)
CHART_ROOTS = [
    REPO_ROOT / "charts",
]

# Directories to exclude (vendored/example third-party charts)
EXCLUDE_PATTERNS = ["examples", "vendors"]


class BoilerplateSync:
    """Sync canonical boilerplate files to all Helm charts."""

    def __init__(self, repo_root: Path, dry_run: bool = False):
        self.repo_root = repo_root
        self.dry_run = dry_run
        self.synced: List[str] = []
        self.skipped: List[str] = []
        self.errors: List[str] = []

    def discover_charts(self) -> List[Path]:
        """Find all chart directories (those containing Chart.yaml)."""
        charts: List[Path] = []
        for root in CHART_ROOTS:
            if not root.exists():
                continue
            for chart_yaml in root.rglob("Chart.yaml"):
                # Skip nested dependency charts (charts/*/charts/*/Chart.yaml)
                rel = chart_yaml.relative_to(root)
                parts = rel.parts
                # A chart's own Chart.yaml is at depth 1 or 2 (e.g., nginx/Chart.yaml
                # or apps/my-app/Chart.yaml), but NOT deeper dependency dirs
                if "charts" in parts[:-1]:
                    continue
                # Skip excluded directories (vendored, examples)
                if any(excl in parts for excl in EXCLUDE_PATTERNS):
                    continue
                charts.append(chart_yaml.parent)
        return sorted(charts)

    def sync_helmignore(self, chart_dir: Path) -> bool:
        """Sync .helmignore from canonical source."""
        if not CANONICAL_HELMIGNORE.exists():
            return False

        target = chart_dir / ".helmignore"
        canonical = CANONICAL_HELMIGNORE.read_text()

        # If the chart has a .copier-answers.yml, include it in .helmignore
        has_copier = (chart_dir / ".copier-answers.yml").exists()
        if has_copier and ".copier-answers.yml" not in canonical:
            canonical = canonical.rstrip("\n") + "\n# Copier answers (not needed in packages)\n.copier-answers.yml\n"

        if target.exists() and target.read_text() == canonical:
            return False

        if not self.dry_run:
            target.write_text(canonical)

        rel = chart_dir.relative_to(self.repo_root)
        self.synced.append(f"{rel}/.helmignore")
        return True

    def sync_chart_yaml_annotations(self, chart_dir: Path) -> bool:
        """Ensure Chart.yaml has standard annotations and maintainer."""
        chart_yaml_path = chart_dir / "Chart.yaml"
        if not chart_yaml_path.exists():
            return False

        content = chart_yaml_path.read_text()
        try:
            data = yaml.safe_load(content)
        except yaml.YAMLError as e:
            rel = chart_dir.relative_to(self.repo_root)
            self.errors.append(f"{rel}/Chart.yaml: YAML parse error: {e}")
            return False

        if not isinstance(data, dict):
            return False

        changed = False

        # Ensure maintainers field exists with at least the standard maintainer
        maintainers = data.get("maintainers", [])
        if not maintainers:
            data["maintainers"] = [STANDARD_MAINTAINER]
            changed = True
        else:
            # Check if standard maintainer is present
            has_std = any(m.get("name") == STANDARD_MAINTAINER["name"] for m in maintainers if isinstance(m, dict))
            if not has_std:
                data["maintainers"].append(STANDARD_MAINTAINER)
                changed = True

        # Ensure standard annotations
        if STANDARD_ANNOTATIONS:
            annotations = data.get("annotations", {})
            if not isinstance(annotations, dict):
                annotations = {}
            for key, value in STANDARD_ANNOTATIONS.items():
                if annotations.get(key) != value:
                    annotations[key] = value
                    changed = True
            if annotations:
                data["annotations"] = annotations

        if changed and not self.dry_run:
            # Preserve original formatting as much as possible by doing
            # targeted replacements instead of full YAML rewrite
            self._write_chart_yaml(chart_yaml_path, data)

        if changed:
            rel = chart_dir.relative_to(self.repo_root)
            self.synced.append(f"{rel}/Chart.yaml")

        return changed

    def _write_chart_yaml(self, path: Path, data: dict) -> None:
        """Write Chart.yaml preserving reasonable formatting."""
        # Use yaml.dump with settings that produce clean Helm-compatible YAML
        output = yaml.dump(
            data,
            default_flow_style=False,
            sort_keys=False,
            allow_unicode=True,
            width=120,
        )
        path.write_text(output)

    def sync_all(self) -> Tuple[int, int, int]:
        """
        Sync boilerplate across all charts.

        Returns:
            Tuple of (synced, skipped, errors) counts
        """
        charts = self.discover_charts()

        if not charts:
            print("⚠️  No charts found.")
            return 0, 0, 0

        for chart_dir in charts:
            # Sync .helmignore
            self.sync_helmignore(chart_dir)

            # Sync Chart.yaml annotations/maintainers
            self.sync_chart_yaml_annotations(chart_dir)

        return len(self.synced), len(self.skipped), len(self.errors)


def main() -> None:
    parser = argparse.ArgumentParser(description="Sync canonical boilerplate files across all Helm charts.")
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Show what would change without modifying files.",
    )
    parser.add_argument(
        "--repo-root",
        type=Path,
        default=None,
        help="Repository root directory (default: auto-detect).",
    )
    args = parser.parse_args()

    repo_root = args.repo_root or REPO_ROOT

    syncer = BoilerplateSync(repo_root, dry_run=args.dry_run)

    prefix = "(dry-run) " if args.dry_run else ""
    print(f"🔄 {prefix}Syncing boilerplate across charts...")

    synced, skipped, errors = syncer.sync_all()

    # Report
    if syncer.synced:
        print(f"\n📝 {prefix}Synced {synced} file(s):")
        for f in syncer.synced:
            print(f"   ✅ {f}")

    if syncer.errors:
        print(f"\n❌ {errors} error(s):")
        for e in syncer.errors:
            print(f"   ⚠️  {e}")

    if not syncer.synced and not syncer.errors:
        print("✅ All charts are already in sync.")
        sys.exit(0)

    if syncer.synced and not args.dry_run:
        print("\n⚠️  Files were updated. Please review and stage the changes.")
        sys.exit(1)

    if syncer.errors:
        sys.exit(1)

    sys.exit(0)


if __name__ == "__main__":
    main()
