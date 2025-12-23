#!/usr/bin/env python3
"""
Sync Helm charts with MkDocs documentation.

This script:
1. Scans the charts directory for available charts
2. Generates/updates documentation for each chart
3. Removes documentation for deleted charts
4. Updates mkdocs.yml navigation automatically

Can be run as a pre-commit hook or standalone.
"""

import os
import re
import sys
import yaml
from pathlib import Path
from typing import Dict, List, Set, Optional, Tuple
from datetime import datetime

# Add parent directory to path to import generate-docs module
SCRIPT_DIR = Path(__file__).parent
sys.path.insert(0, str(SCRIPT_DIR))

from importlib import import_module


class ChartDocsSync:
    """Synchronize Helm charts with MkDocs documentation."""
    
    def __init__(self, repo_root: Path):
        self.repo_root = repo_root
        self.charts_dir = repo_root / 'charts'
        self.docs_dir = repo_root / 'docs'
        self.charts_docs_dir = self.docs_dir / 'charts'
        self.mkdocs_config = repo_root / 'mkdocs.yml'
        
    def get_available_charts(self) -> Dict[str, Path]:
        """Get all available charts in the charts directory."""
        charts = {}
        
        if not self.charts_dir.exists():
            return charts
            
        for item in self.charts_dir.iterdir():
            if item.is_dir():
                chart_yaml = item / 'Chart.yaml'
                if chart_yaml.exists():
                    # Read chart name from Chart.yaml
                    with open(chart_yaml, 'r') as f:
                        try:
                            chart_meta = yaml.safe_load(f)
                            chart_name = chart_meta.get('name', item.name)
                            charts[chart_name] = item
                        except yaml.YAMLError:
                            print(f"⚠️  Warning: Could not parse {chart_yaml}")
                            continue
        
        return charts
    
    def get_documented_charts(self) -> Set[str]:
        """Get charts that currently have documentation."""
        documented = set()
        
        if not self.charts_docs_dir.exists():
            return documented
            
        for md_file in self.charts_docs_dir.glob('*.md'):
            if md_file.name != 'index.md':
                chart_name = md_file.stem
                documented.add(chart_name)
        
        return documented
    
    def remove_chart_docs(self, chart_name: str) -> bool:
        """Remove documentation for a deleted chart."""
        doc_file = self.charts_docs_dir / f'{chart_name}.md'
        
        if doc_file.exists():
            doc_file.unlink()
            print(f"🗑️  Removed documentation for deleted chart: {chart_name}")
            return True
        
        return False
    
    def update_mkdocs_nav(self, charts: Dict[str, Path]) -> bool:
        """Update mkdocs.yml navigation with current charts."""
        if not self.mkdocs_config.exists():
            print("⚠️  Warning: mkdocs.yml not found, skipping nav update")
            return False
        
        with open(self.mkdocs_config, 'r') as f:
            config = yaml.safe_load(f)
        
        if 'nav' not in config:
            print("⚠️  Warning: No 'nav' section in mkdocs.yml")
            return False
        
        # Find the Charts section in nav
        nav = config['nav']
        charts_section_idx = None
        
        for idx, section in enumerate(nav):
            if isinstance(section, dict) and 'Charts' in section:
                charts_section_idx = idx
                break
        
        if charts_section_idx is None:
            print("⚠️  Warning: No 'Charts' section found in nav")
            return False
        
        # Build new charts navigation
        # Sort charts alphabetically, but keep index.md first
        sorted_charts = sorted(charts.keys(), key=str.lower)
        
        new_charts_nav = [
            'charts/index.md',  # Keep index first
        ]
        
        for chart_name in sorted_charts:
            # Capitalize first letter for display
            display_name = chart_name.replace('-', ' ').title()
            new_charts_nav.append({display_name: f'charts/{chart_name}.md'})
        
        # Update the config
        old_charts_nav = config['nav'][charts_section_idx]['Charts']
        config['nav'][charts_section_idx]['Charts'] = new_charts_nav
        
        # Check if navigation changed
        if old_charts_nav == new_charts_nav:
            return False
        
        # Write updated config
        with open(self.mkdocs_config, 'w') as f:
            yaml.dump(config, f, default_flow_style=False, sort_keys=False, allow_unicode=True)
        
        print(f"📝 Updated mkdocs.yml navigation with {len(sorted_charts)} charts")
        return True
    
    def update_charts_index(self, charts: Dict[str, Path]) -> bool:
        """Update the charts index page with current charts."""
        index_file = self.charts_docs_dir / 'index.md'
        
        if not index_file.exists():
            return False
        
        # Read chart metadata
        chart_info = []
        for chart_name, chart_path in sorted(charts.items(), key=lambda x: x[0].lower()):
            chart_yaml = chart_path / 'Chart.yaml'
            with open(chart_yaml, 'r') as f:
                meta = yaml.safe_load(f)
            
            chart_info.append({
                'name': chart_name,
                'version': meta.get('version', '0.0.0'),
                'description': meta.get('description', ''),
                'type': meta.get('type', 'application'),
            })
        
        # Generate new table content
        table_lines = ['| Chart | Version | Description |',
                      '|-------|---------|-------------|']
        
        for info in chart_info:
            table_lines.append(
                f"| [{info['name']}]({info['name']}.md) | {info['version']} | {info['description']} |"
            )
        
        new_table = '\n'.join(table_lines)
        
        # Read current index
        with open(index_file, 'r') as f:
            content = f.read()
        
        # Replace the table (between "## Available Charts" and next ##)
        pattern = r'(## Available Charts\s*\n\n)(\|.*\n)+(\n)'
        replacement = f'\\1{new_table}\n\\3'
        
        new_content = re.sub(pattern, replacement, content)
        
        if new_content != content:
            with open(index_file, 'w') as f:
                f.write(new_content)
            print("📝 Updated charts/index.md")
            return True
        
        return False
    
    def sync(self, generate_docs: bool = True) -> Tuple[int, int, int]:
        """
        Synchronize charts with documentation.
        
        Returns:
            Tuple of (added, removed, updated) counts
        """
        added = 0
        removed = 0
        updated = 0
        
        # Get current state
        available_charts = self.get_available_charts()
        documented_charts = self.get_documented_charts()
        
        available_names = set(available_charts.keys())
        
        # Find charts to add and remove
        charts_to_add = available_names - documented_charts
        charts_to_remove = documented_charts - available_names
        
        # Remove documentation for deleted charts
        for chart_name in charts_to_remove:
            if self.remove_chart_docs(chart_name):
                removed += 1
        
        # Generate documentation for new/existing charts
        if generate_docs and available_charts:
            # Import and run the generate-docs script
            try:
                # Ensure docs directories exist
                self.charts_docs_dir.mkdir(parents=True, exist_ok=True)
                (self.docs_dir / 'reference').mkdir(parents=True, exist_ok=True)
                
                # Import the generate_docs module
                generate_docs_module = import_module('generate-docs')
                
                # Run documentation generation
                all_entries = []
                for chart_name, chart_path in available_charts.items():
                    entries = generate_docs_module.generate_chart_doc(
                        chart_path, 
                        self.charts_docs_dir
                    )
                    if entries:
                        all_entries.extend(entries)
                        if chart_name in charts_to_add:
                            added += 1
                            print(f"✨ Added documentation for new chart: {chart_name}")
                        else:
                            updated += 1
                
                # Generate search and index pages
                if all_entries:
                    generate_docs_module.generate_search_page(all_entries, self.docs_dir)
                    generate_docs_module.generate_values_index(all_entries, self.docs_dir)
                    
            except ImportError as e:
                print(f"⚠️  Warning: Could not import generate-docs module: {e}")
                print("   Run 'python3 scripts/generate-docs.py' manually")
        
        # Update mkdocs.yml navigation
        if self.update_mkdocs_nav(available_charts):
            updated += 1
        
        # Update charts index
        if self.update_charts_index(available_charts):
            updated += 1
        
        return added, removed, updated


def main():
    """Main entry point."""
    import argparse
    
    parser = argparse.ArgumentParser(
        description='Sync Helm charts with MkDocs documentation'
    )
    parser.add_argument(
        '--no-generate',
        action='store_true',
        help='Skip documentation generation (only sync navigation)'
    )
    parser.add_argument(
        '--check',
        action='store_true',
        help='Check if sync is needed without making changes'
    )
    parser.add_argument(
        '--repo-root',
        type=Path,
        default=None,
        help='Repository root directory (default: auto-detect)'
    )
    
    args = parser.parse_args()
    
    # Determine repo root
    if args.repo_root:
        repo_root = args.repo_root
    else:
        repo_root = SCRIPT_DIR.parent
    
    # Validate repo structure
    if not (repo_root / 'charts').exists():
        print(f"❌ Error: charts directory not found in {repo_root}")
        sys.exit(1)
    
    syncer = ChartDocsSync(repo_root)
    
    if args.check:
        # Check mode - just report what would change
        available = syncer.get_available_charts()
        documented = syncer.get_documented_charts()
        
        to_add = set(available.keys()) - documented
        to_remove = documented - set(available.keys())
        
        if to_add or to_remove:
            print("📋 Sync needed:")
            if to_add:
                print(f"   Charts to add: {', '.join(sorted(to_add))}")
            if to_remove:
                print(f"   Charts to remove: {', '.join(sorted(to_remove))}")
            sys.exit(1)
        else:
            print("✅ Charts and documentation are in sync")
            sys.exit(0)
    
    # Perform sync
    print("🔄 Syncing charts with documentation...")
    added, removed, updated = syncer.sync(generate_docs=not args.no_generate)
    
    # Summary
    print("\n" + "=" * 50)
    print(f"📊 Sync complete:")
    print(f"   ✨ Added:   {added}")
    print(f"   🗑️  Removed: {removed}")
    print(f"   📝 Updated: {updated}")
    
    # Exit with error if changes were made (useful for pre-commit)
    if added > 0 or removed > 0:
        print("\n⚠️  Documentation was updated. Please review and commit the changes.")
        sys.exit(1)
    
    sys.exit(0)


if __name__ == '__main__':
    main()
