#!/usr/bin/env python3
"""
Chart drift detection — audit all Helm charts for consistency.

Checks:
  - Required files present (Chart.yaml, values.yaml, .helmignore, README.md)
  - .helmignore matches canonical source
  - Chart.yaml has standard maintainer and annotations
  - values.yaml has helm-docs comment annotations (@section, @default)
  - _helpers.tpl follows naming conventions

Output modes:
  - Human-readable (default)
  - JSON (--json)

Exit codes:
  0 = all charts consistent
  1 = drift detected
"""

import argparse
import json
import sys
from pathlib import Path
from typing import Any, Dict, List

import yaml

SCRIPT_DIR = Path(__file__).parent
REPO_ROOT = SCRIPT_DIR.parent

# Expected files in every chart
REQUIRED_FILES = ["Chart.yaml", "values.yaml", ".helmignore"]
RECOMMENDED_FILES = ["README.md", "templates/_helpers.tpl"]

# Canonical .helmignore
CANONICAL_HELMIGNORE = REPO_ROOT / "templates" / "chart-template" / ".helmignore"

# Standard maintainer
STANDARD_MAINTAINER_NAME = "codefuturist"

# Chart directories to scan
CHART_ROOTS = [REPO_ROOT / "charts"]

# Directories to exclude (vendored/example third-party charts)
EXCLUDE_PATTERNS = ["examples", "vendors"]


class DriftChecker:
    """Audit Helm charts for consistency and drift."""

    def __init__(self, repo_root: Path):
        self.repo_root = repo_root
        self.results: Dict[str, Dict[str, Any]] = {}

    def discover_charts(self) -> List[Path]:
        """Find all chart directories, excluding vendored/example dirs."""
        charts: List[Path] = []
        for root in CHART_ROOTS:
            if not root.exists():
                continue
            for chart_yaml in root.rglob("Chart.yaml"):
                rel = chart_yaml.relative_to(root)
                parts = rel.parts
                # Skip nested dependency charts
                if "charts" in parts[:-1]:
                    continue
                # Skip excluded directories (vendored, examples)
                if any(excl in parts for excl in EXCLUDE_PATTERNS):
                    continue
                charts.append(chart_yaml.parent)
        return sorted(charts)

    def check_required_files(self, chart_dir: Path) -> List[str]:
        """Check for required files."""
        issues: List[str] = []
        for f in REQUIRED_FILES:
            if not (chart_dir / f).exists():
                issues.append(f"Missing required file: {f}")
        for f in RECOMMENDED_FILES:
            if not (chart_dir / f).exists():
                issues.append(f"Missing recommended file: {f}")
        return issues

    def check_helmignore(self, chart_dir: Path) -> List[str]:
        """Check .helmignore against canonical source."""
        issues: List[str] = []
        target = chart_dir / ".helmignore"

        if not target.exists():
            return issues  # Already reported by required files check

        if not CANONICAL_HELMIGNORE.exists():
            return issues

        canonical = CANONICAL_HELMIGNORE.read_text()
        current = target.read_text()

        # Normalize for comparison (strip trailing whitespace, ignore copier line)
        def normalize(text: str) -> set:
            lines = set()
            for line in text.strip().splitlines():
                stripped = line.strip()
                if stripped and not stripped.startswith("#"):
                    lines.add(stripped)
            return lines

        canonical_entries = normalize(canonical)
        current_entries = normalize(current)

        missing = canonical_entries - current_entries
        if missing:
            issues.append(f".helmignore missing entries: {', '.join(sorted(missing))}")

        return issues

    def check_chart_yaml(self, chart_dir: Path) -> List[str]:
        """Check Chart.yaml for standard fields."""
        issues: List[str] = []
        chart_yaml = chart_dir / "Chart.yaml"

        if not chart_yaml.exists():
            return issues

        try:
            data = yaml.safe_load(chart_yaml.read_text())
        except yaml.YAMLError:
            issues.append("Chart.yaml: invalid YAML")
            return issues

        if not isinstance(data, dict):
            issues.append("Chart.yaml: not a valid mapping")
            return issues

        # Check required fields
        for field in ["apiVersion", "name", "version", "description", "type"]:
            if field not in data:
                issues.append(f"Chart.yaml: missing field '{field}'")

        # Check maintainers
        maintainers = data.get("maintainers", [])
        if not maintainers:
            issues.append("Chart.yaml: no maintainers defined")
        else:
            has_std = any(m.get("name") == STANDARD_MAINTAINER_NAME for m in maintainers if isinstance(m, dict))
            if not has_std:
                issues.append(f"Chart.yaml: standard maintainer '{STANDARD_MAINTAINER_NAME}' not listed")

        # Check keywords
        if not data.get("keywords"):
            issues.append("Chart.yaml: no keywords defined")

        return issues

    def check_values_yaml(self, chart_dir: Path) -> List[str]:
        """Check values.yaml for helm-docs annotations."""
        issues: List[str] = []
        values_file = chart_dir / "values.yaml"

        if not values_file.exists():
            return issues

        content = values_file.read_text()

        # Check for at least some helm-docs annotations
        has_section = "# @section" in content or "# -- " in content
        if not has_section and len(content.splitlines()) > 10:
            issues.append("values.yaml: no helm-docs annotations found (@section or # -- comments)")

        return issues

    def check_helpers_tpl(self, chart_dir: Path) -> List[str]:
        """Check _helpers.tpl for standard patterns."""
        issues: List[str] = []
        helpers = chart_dir / "templates" / "_helpers.tpl"

        if not helpers.exists():
            return issues

        content = helpers.read_text()
        chart_yaml = chart_dir / "Chart.yaml"

        if chart_yaml.exists():
            try:
                data = yaml.safe_load(chart_yaml.read_text())
                chart_name = data.get("name", "")
            except yaml.YAMLError:
                return issues
        else:
            return issues

        # Check for standard helper definitions
        expected_defines = [
            f'define "{chart_name}.name"',
            f'define "{chart_name}.fullname"',
            f'define "{chart_name}.labels"',
        ]

        for define in expected_defines:
            if define not in content:
                # Check for common alternatives (e.g., "application.name" for generic charts)
                issues.append(f"_helpers.tpl: missing standard define: {define}")

        return issues

    def check_chart(self, chart_dir: Path) -> Dict[str, Any]:
        """Run all checks on a single chart."""
        rel = str(chart_dir.relative_to(self.repo_root))
        result: Dict[str, Any] = {
            "path": rel,
            "errors": [],
            "warnings": [],
        }

        # Required files
        file_issues = self.check_required_files(chart_dir)
        for issue in file_issues:
            if "Missing required" in issue:
                result["errors"].append(issue)
            else:
                result["warnings"].append(issue)

        # .helmignore drift
        result["warnings"].extend(self.check_helmignore(chart_dir))

        # Chart.yaml standards
        chart_issues = self.check_chart_yaml(chart_dir)
        for issue in chart_issues:
            if "missing field" in issue or "invalid YAML" in issue:
                result["errors"].append(issue)
            else:
                result["warnings"].append(issue)

        # values.yaml annotations
        result["warnings"].extend(self.check_values_yaml(chart_dir))

        # _helpers.tpl patterns
        result["warnings"].extend(self.check_helpers_tpl(chart_dir))

        # Copier management status
        result["copier_managed"] = (chart_dir / ".copier-answers.yml").exists()

        return result

    def check_all(self) -> Dict[str, Any]:
        """Run drift checks on all charts."""
        charts = self.discover_charts()
        summary = {
            "total": len(charts),
            "clean": 0,
            "with_errors": 0,
            "with_warnings": 0,
            "copier_managed": 0,
            "charts": {},
        }

        for chart_dir in charts:
            result = self.check_chart(chart_dir)
            name = chart_dir.name
            summary["charts"][name] = result

            if result["copier_managed"]:
                summary["copier_managed"] += 1

            if result["errors"]:
                summary["with_errors"] += 1
            elif result["warnings"]:
                summary["with_warnings"] += 1
            else:
                summary["clean"] += 1

        return summary


def print_human(summary: Dict[str, Any]) -> None:
    """Print human-readable drift report."""
    print("⎈  Chart Drift Report")
    print(f"   {summary['total']} charts scanned")
    print()

    for name, result in sorted(summary["charts"].items()):
        errors = result["errors"]
        warnings = result["warnings"]
        managed = "📋" if result["copier_managed"] else "  "

        if not errors and not warnings:
            print(f"  {managed} ✅ {name}")
            continue

        status = "❌" if errors else "⚠️ "
        print(f"  {managed} {status} {name} ({result['path']})")

        for e in errors:
            print(f"        ❌ {e}")
        for w in warnings:
            print(f"        ⚠️  {w}")

    print()
    print(f"   ✅ Clean: {summary['clean']}")
    print(f"   ⚠️  Warnings: {summary['with_warnings']}")
    print(f"   ❌ Errors: {summary['with_errors']}")
    print(f"   📋 Copier-managed: {summary['copier_managed']}")


def main() -> None:
    parser = argparse.ArgumentParser(description="Audit Helm charts for consistency and drift.")
    parser.add_argument(
        "--json",
        action="store_true",
        dest="json_output",
        help="Output results as JSON.",
    )
    parser.add_argument(
        "--strict",
        action="store_true",
        help="Exit non-zero on warnings (not just errors).",
    )
    parser.add_argument(
        "--repo-root",
        type=Path,
        default=None,
        help="Repository root directory (default: auto-detect).",
    )
    args = parser.parse_args()

    repo_root = args.repo_root or REPO_ROOT
    checker = DriftChecker(repo_root)
    summary = checker.check_all()

    if args.json_output:
        print(json.dumps(summary, indent=2))
    else:
        print_human(summary)

    # Exit code
    has_errors = summary["with_errors"] > 0
    has_warnings = summary["with_warnings"] > 0

    if has_errors:
        sys.exit(1)
    elif has_warnings and args.strict:
        sys.exit(1)
    else:
        sys.exit(0)


if __name__ == "__main__":
    main()
