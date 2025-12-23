#!/usr/bin/env python3
"""
Generate documentation files for MkDocs from helm chart values.
Creates searchable documentation with anchor links for each value.
"""

import os
import re
import json
import yaml
from pathlib import Path
from typing import Dict, List, Any, Optional
from dataclasses import dataclass, asdict
from datetime import datetime

@dataclass
class ValueEntry:
    """Represents a single value entry from values.yaml"""
    key: str
    type: str
    default: str
    description: str
    section: str
    line_number: int
    chart: str
    
    @property
    def anchor_id(self) -> str:
        """Generate a valid HTML anchor ID"""
        return f"value-{self.key.replace('.', '-').replace('[', '_').replace(']', '')}"


def parse_values_yaml(values_path: Path, chart_name: str) -> List[ValueEntry]:
    """Parse values.yaml and extract value entries with metadata"""
    entries = []
    
    if not values_path.exists():
        return entries
    
    with open(values_path, 'r') as f:
        content = f.read()
        lines = content.split('\n')
    
    # Regex patterns for helm-docs annotations
    comment_pattern = re.compile(r'^(\s*)#\s*--\s*(\([^)]+\))?\s*(.*)')
    section_pattern = re.compile(r'@section\s*--\s*(.+)')
    default_pattern = re.compile(r'@default\s*--\s*(.+)')
    
    current_description = []
    current_type = None
    current_section = "General"
    current_default = None
    
    for line_num, line in enumerate(lines, 1):
        # Check for section annotation
        section_match = section_pattern.search(line)
        if section_match:
            current_section = section_match.group(1).strip()
        
        # Check for default override
        default_match = default_pattern.search(line)
        if default_match:
            current_default = default_match.group(1).strip()
        
        # Check for comment with description
        comment_match = comment_pattern.match(line)
        if comment_match:
            type_hint = comment_match.group(2)
            description = comment_match.group(3).strip()
            
            if type_hint:
                current_type = type_hint.strip('()')
            
            if description:
                current_description.append(description)
            continue
        
        # Check for key: value line
        key_match = re.match(r'^(\s*)([a-zA-Z_][a-zA-Z0-9_-]*)\s*:\s*(.*)', line)
        if key_match and current_description:
            indent = len(key_match.group(1))
            key = key_match.group(2)
            value = key_match.group(3).strip()
            
            # Build full key path based on indentation
            # This is simplified - for complex nested structures, 
            # you'd need to track the indent stack
            
            # Determine type from value if not specified
            if not current_type:
                current_type = infer_type(value)
            
            # Determine default value
            if current_default:
                default = current_default
            else:
                default = value if value else '`nil`'
            
            entries.append(ValueEntry(
                key=key,
                type=current_type or 'string',
                default=default[:100] + '...' if len(str(default)) > 100 else str(default),
                description=' '.join(current_description),
                section=current_section,
                line_number=line_num,
                chart=chart_name
            ))
            
            # Reset for next entry
            current_description = []
            current_type = None
            current_default = None
    
    return entries


def infer_type(value: str) -> str:
    """Infer the type from a YAML value string"""
    if not value or value == '':
        return 'string'
    if value in ('true', 'false'):
        return 'bool'
    if value.startswith('{') or value.startswith('|'):
        return 'object'
    if value.startswith('['):
        return 'list'
    if value.replace('.', '').replace('-', '').isdigit():
        return 'int' if '.' not in value else 'float'
    return 'string'


def generate_chart_doc(chart_path: Path, output_dir: Path) -> Optional[List[ValueEntry]]:
    """Generate MkDocs documentation for a single chart"""
    chart_yaml = chart_path / 'Chart.yaml'
    values_yaml = chart_path / 'values.yaml'
    readme_path = chart_path / 'README.md'
    
    if not chart_yaml.exists():
        return None
    
    with open(chart_yaml, 'r') as f:
        chart_meta = yaml.safe_load(f)
    
    chart_name = chart_meta.get('name', chart_path.name)
    
    # Parse values
    entries = parse_values_yaml(values_yaml, chart_name)
    
    # Read existing README if available
    readme_content = ""
    if readme_path.exists():
        with open(readme_path, 'r') as f:
            readme_content = f.read()
    
    # Generate the MkDocs page
    output_file = output_dir / f"{chart_name}.md"
    
    doc_content = generate_mkdocs_page(chart_meta, entries, readme_content)
    
    with open(output_file, 'w') as f:
        f.write(doc_content)
    
    print(f"Generated: {output_file}")
    return entries


def generate_mkdocs_page(chart_meta: Dict, entries: List[ValueEntry], readme_content: str) -> str:
    """Generate a MkDocs-compatible markdown page"""
    name = chart_meta.get('name', 'Unknown')
    version = chart_meta.get('version', '0.0.0')
    description = chart_meta.get('description', '')
    app_version = chart_meta.get('appVersion', '')
    chart_type = chart_meta.get('type', 'application')
    
    # Group entries by section
    sections: Dict[str, List[ValueEntry]] = {}
    for entry in entries:
        if entry.section not in sections:
            sections[entry.section] = []
        sections[entry.section].append(entry)
    
    content = f"""---
tags:
  - {chart_type}
  - {name}
---

# {name}

![Version: {version}](https://img.shields.io/badge/Version-{version.replace('-', '--')}-informational?style=flat-square)
![Type: {chart_type}](https://img.shields.io/badge/Type-{chart_type}-informational?style=flat-square)
{"![AppVersion: " + app_version + "](https://img.shields.io/badge/AppVersion-" + app_version.replace('-', '--') + "-informational?style=flat-square)" if app_version else ""}

{description}

## Quick Links

- [Installation](#installing-the-chart)
- [Values Reference](#values)
- [Search All Values](../reference/search.md)

## Installing the Chart

```bash
helm repo add pandia https://charts.pandia.io
helm repo update
helm install my-{name} pandia/{name}
```

## Values

!!! tip "Search Values"
    Press ++ctrl+k++ or ++cmd+k++ to search, or use the [interactive values search](../reference/search.md).

<div class="filter-buttons">
"""
    
    # Add filter buttons for sections
    for section in sorted(sections.keys()):
        safe_section = section.replace(' ', '-').lower()
        content += f'  <button class="filter-btn" data-section="{safe_section}">{section}</button>\n'
    
    content += """  <button class="filter-btn" data-section="">Show All</button>
</div>

<input type="text" id="values-search" placeholder="🔍 Filter values... (Ctrl+K)" />
<div class="search-results-count"></div>

<table class="values-table">
<thead>
<tr>
<th>Key</th>
<th>Type</th>
<th>Default</th>
<th>Description</th>
</tr>
</thead>
<tbody>
"""
    
    # Add table rows grouped by section
    for section in sorted(sections.keys()):
        safe_section = section.replace(' ', '-').lower()
        content += f'<tr class="values-section-header"><td colspan="4"><strong>{section}</strong></td></tr>\n'
        
        for entry in sections[section]:
            anchor_id = entry.anchor_id
            escaped_key = entry.key.replace('<', '&lt;').replace('>', '&gt;')
            escaped_desc = entry.description.replace('<', '&lt;').replace('>', '&gt;')
            escaped_default = str(entry.default).replace('<', '&lt;').replace('>', '&gt;')
            
            type_class = entry.type.split('/')[0] if '/' in entry.type else entry.type
            
            content += f'''<tr id="{anchor_id}" class="value-anchor" data-section="{safe_section}">
<td><code class="value-key">{escaped_key}</code></td>
<td><span class="type-badge {type_class}">{entry.type}</span></td>
<td><code>{escaped_default}</code></td>
<td>{escaped_desc}</td>
</tr>
'''
    
    content += """</tbody>
</table>

---

*Autogenerated from chart metadata using [helm-docs](https://github.com/norwoodj/helm-docs)*
"""
    
    return content


def generate_search_page(all_entries: List[ValueEntry], output_dir: Path):
    """Generate the unified search page"""
    output_file = output_dir / 'reference' / 'search.md'
    output_file.parent.mkdir(parents=True, exist_ok=True)
    
    # Group by chart
    charts: Dict[str, List[ValueEntry]] = {}
    for entry in all_entries:
        if entry.chart not in charts:
            charts[entry.chart] = []
        charts[entry.chart].append(entry)
    
    content = """---
tags:
  - reference
  - search
---

# Values Search

Search across all chart values in this repository.

!!! tip "Keyboard Shortcuts"
    - ++ctrl+k++ or ++cmd+k++ - Focus search
    - ++escape++ - Clear search
    - Click 🔗 to copy direct link to a value

<input type="text" id="values-search" placeholder="🔍 Search all values... (e.g., 'replicas', 'image.tag', 'enabled')" autofocus />

<div class="filter-buttons">
"""
    
    for chart in sorted(charts.keys()):
        content += f'  <button class="filter-btn" data-section="{chart}">{chart}</button>\n'
    
    content += """  <button class="filter-btn active" data-section="">All Charts</button>
</div>

<div class="search-results-count"></div>

<table class="values-table">
<thead>
<tr>
<th>Chart</th>
<th>Key</th>
<th>Type</th>
<th>Default</th>
<th>Description</th>
</tr>
</thead>
<tbody>
"""
    
    for chart in sorted(charts.keys()):
        for entry in charts[chart]:
            anchor_id = f"{chart}-{entry.anchor_id}"
            escaped_key = entry.key.replace('<', '&lt;').replace('>', '&gt;')
            escaped_desc = entry.description.replace('<', '&lt;').replace('>', '&gt;')
            escaped_default = str(entry.default).replace('<', '&lt;').replace('>', '&gt;')
            
            type_class = entry.type.split('/')[0] if '/' in entry.type else entry.type
            
            content += f'''<tr id="{anchor_id}" class="value-anchor" data-section="{chart}">
<td><a href="../charts/{chart}.md#{entry.anchor_id}">{chart}</a></td>
<td><code class="value-key">{escaped_key}</code></td>
<td><span class="type-badge {type_class}">{entry.type}</span></td>
<td><code>{escaped_default}</code></td>
<td>{escaped_desc}</td>
</tr>
'''
    
    content += f"""</tbody>
</table>

---

*Last updated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}*
"""
    
    with open(output_file, 'w') as f:
        f.write(content)
    
    print(f"Generated: {output_file}")


def generate_values_index(all_entries: List[ValueEntry], output_dir: Path):
    """Generate a JSON index for client-side search"""
    output_file = output_dir / 'reference' / 'values-index.md'
    json_file = output_dir / 'assets' / 'javascripts' / 'values-index.json'
    
    output_file.parent.mkdir(parents=True, exist_ok=True)
    json_file.parent.mkdir(parents=True, exist_ok=True)
    
    # Generate JSON index
    index_data = [asdict(entry) for entry in all_entries]
    with open(json_file, 'w') as f:
        json.dump(index_data, f, indent=2)
    
    print(f"Generated: {json_file}")
    
    # Generate markdown index page
    content = """---
tags:
  - reference
  - index
---

# All Values Index

Complete alphabetical listing of all configuration values across all charts.

| Chart | Key | Type | Section |
|-------|-----|------|---------|
"""
    
    sorted_entries = sorted(all_entries, key=lambda e: (e.key.lower(), e.chart))
    
    for entry in sorted_entries:
        content += f"| [{entry.chart}](../charts/{entry.chart}.md#{entry.anchor_id}) | `{entry.key}` | {entry.type} | {entry.section} |\n"
    
    content += f"\n\n*Total: {len(all_entries)} values across {len(set(e.chart for e in all_entries))} charts*\n"
    
    with open(output_file, 'w') as f:
        f.write(content)
    
    print(f"Generated: {output_file}")


def update_mkdocs_nav(repo_root: Path, chart_names: List[str]):
    """Update mkdocs.yml navigation with discovered charts"""
    mkdocs_path = repo_root / 'mkdocs.yml'
    
    if not mkdocs_path.exists():
        print("Warning: mkdocs.yml not found, skipping nav update")
        return
    
    with open(mkdocs_path, 'r') as f:
        content = f.read()
    
    # Sort charts alphabetically
    sorted_charts = sorted(chart_names, key=lambda x: x.lower())
    
    # Build new charts nav entries
    charts_entries = ['      - charts/index.md']
    for chart in sorted_charts:
        display_name = chart.replace('-', ' ').title()
        charts_entries.append(f'      - {display_name}: charts/{chart}.md')
    
    new_charts_section = '\n'.join(charts_entries)
    
    # Use regex to find and replace the Charts section in nav
    # Pattern matches from "  - Charts:" until the next top-level nav item or end
    pattern = r'(  - Charts:\n)((?:      - .*\n)*)'
    replacement = f'\\1{new_charts_section}\n'
    
    new_content = re.sub(pattern, replacement, content)
    
    if new_content != content:
        with open(mkdocs_path, 'w') as f:
            f.write(new_content)
        print(f"Updated: {mkdocs_path} with {len(chart_names)} charts")
    else:
        print(f"No changes needed to {mkdocs_path}")


def cleanup_old_chart_docs(charts_docs_dir: Path, current_charts: List[str]):
    """Remove documentation for charts that no longer exist"""
    removed = []
    for doc_file in charts_docs_dir.glob('*.md'):
        if doc_file.name == 'index.md':
            continue
        chart_name = doc_file.stem
        if chart_name not in current_charts:
            doc_file.unlink()
            removed.append(chart_name)
            print(f"Removed: {doc_file}")
    
    if removed:
        print(f"🗑️  Cleaned up {len(removed)} old chart docs: {', '.join(removed)}")


def main():
    """Main entry point"""
    # Determine paths
    script_dir = Path(__file__).parent
    repo_root = script_dir.parent
    charts_dir = repo_root / 'charts'
    docs_dir = repo_root / 'docs'
    charts_docs_dir = docs_dir / 'charts'
    
    # Ensure output directories exist
    charts_docs_dir.mkdir(parents=True, exist_ok=True)
    (docs_dir / 'reference').mkdir(parents=True, exist_ok=True)
    
    all_entries: List[ValueEntry] = []
    generated_charts: List[str] = []
    seen_chart_names: set = set()
    
    # Collect chart paths from top-level and apps/ subdirectory
    chart_paths: List[Path] = []
    
    # Top-level charts first (e.g., charts/nginx, charts/application) - these take precedence
    for chart_path in sorted(charts_dir.iterdir()):
        if chart_path.is_dir() and (chart_path / 'Chart.yaml').exists():
            chart_paths.append(chart_path)
    
    # Charts in apps/ subdirectory
    apps_dir = charts_dir / 'apps'
    if apps_dir.exists():
        for chart_path in sorted(apps_dir.iterdir()):
            if chart_path.is_dir() and (chart_path / 'Chart.yaml').exists():
                chart_paths.append(chart_path)
    
    # Process each chart, skipping duplicates
    for chart_path in chart_paths:
        # Get chart name from Chart.yaml first to check for duplicates
        with open(chart_path / 'Chart.yaml', 'r') as f:
            chart_meta = yaml.safe_load(f)
        chart_name = chart_meta.get('name', chart_path.name)
        
        # Skip if we've already processed a chart with this name
        if chart_name in seen_chart_names:
            print(f"Skipping duplicate: {chart_path} (already processed {chart_name})")
            continue
        
        seen_chart_names.add(chart_name)
        
        entries = generate_chart_doc(chart_path, charts_docs_dir)
        # Always add to generated_charts if doc was created, even if no entries
        generated_charts.append(chart_name)
        if entries:
            all_entries.extend(entries)
    
    # Cleanup old chart docs that no longer exist
    cleanup_old_chart_docs(charts_docs_dir, generated_charts)
    
    # Update mkdocs.yml navigation
    update_mkdocs_nav(repo_root, generated_charts)
    
    # Generate unified search page
    if all_entries:
        generate_search_page(all_entries, docs_dir)
        generate_values_index(all_entries, docs_dir)
    
    print(f"\n✅ Generated documentation for {len(generated_charts)} charts")
    print(f"📊 Total values indexed: {len(all_entries)}")


if __name__ == '__main__':
    main()
