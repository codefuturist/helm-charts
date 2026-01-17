---
tags:
  - application
  - shlink
---

# shlink

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square)
![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)
![AppVersion: 4.2.4](https://img.shields.io/badge/AppVersion-4.2.4-informational?style=flat-square)

A production-ready Helm chart for Shlink - Self-hosted URL shortener with analytics and web UI

## Quick Links

- [Installation](#installing-the-chart)
- [Values Reference](#values)
- [Search All Values](../reference/search.md)

## Installing the Chart

```bash
helm repo add pandia https://charts.pandia.io
helm repo update
helm install my-shlink pandia/shlink
```

## Values

!!! tip "Search Values"
Press ++ctrl+k++ or ++cmd+k++ to search, or use the [interactive values search](../reference/search.md).

<div class="filter-buttons">
  <button class="filter-btn" data-section="diagnostic-mode-configuration">Diagnostic Mode Configuration</button>
  <button class="filter-btn" data-section="pod-disruption-budget-configuration">Pod Disruption Budget Configuration</button>
  <button class="filter-btn" data-section="postgresql-configuration">PostgreSQL Configuration</button>
  <button class="filter-btn" data-section="">Show All</button>
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
<tr class="values-section-header"><td colspan="4"><strong>Diagnostic Mode Configuration</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="diagnostic-mode-configuration">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable diagnostic mode (sleep infinity instead of running application)</td>
</tr>
<tr id="value-command" class="value-anchor" data-section="diagnostic-mode-configuration">
<td><code class="value-key">command</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Command to run in diagnostic mode</td>
</tr>
<tr id="value-args" class="value-anchor" data-section="diagnostic-mode-configuration">
<td><code class="value-key">args</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Arguments for diagnostic mode command</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Pod Disruption Budget Configuration</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="pod-disruption-budget-configuration">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable Pod Disruption Budget</td>
</tr>
<tr id="value-minAvailable" class="value-anchor" data-section="pod-disruption-budget-configuration">
<td><code class="value-key">minAvailable</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Minimum available pods</td>
</tr>
<tr id="value-maxUnavailable" class="value-anchor" data-section="pod-disruption-budget-configuration">
<td><code class="value-key">maxUnavailable</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Maximum unavailable pods (alternative to minAvailable)</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>PostgreSQL Configuration</strong></td></tr>
<tr id="value-postgresql" class="value-anchor" data-section="postgresql-configuration">
<td><code class="value-key">postgresql</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>PostgreSQL subchart configuration</td>
</tr>
<tr id="value-enabled" class="value-anchor" data-section="postgresql-configuration">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Enable PostgreSQL subchart</td>
</tr>
<tr id="value-image" class="value-anchor" data-section="postgresql-configuration">
<td><code class="value-key">image</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>PostgreSQL image configuration</td>
</tr>
<tr id="value-auth" class="value-anchor" data-section="postgresql-configuration">
<td><code class="value-key">auth</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>PostgreSQL authentication configuration</td>
</tr>
<tr id="value-username" class="value-anchor" data-section="postgresql-configuration">
<td><code class="value-key">username</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>shlink</code></td>
<td>PostgreSQL username</td>
</tr>
<tr id="value-password" class="value-anchor" data-section="postgresql-configuration">
<td><code class="value-key">password</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>changeme</code></td>
<td>PostgreSQL password</td>
</tr>
<tr id="value-database" class="value-anchor" data-section="postgresql-configuration">
<td><code class="value-key">database</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>shlink</code></td>
<td>PostgreSQL database name</td>
</tr>
<tr id="value-existingSecret" class="value-anchor" data-section="postgresql-configuration">
<td><code class="value-key">existingSecret</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Existing secret with PostgreSQL credentials</td>
</tr>
<tr id="value-architecture" class="value-anchor" data-section="postgresql-configuration">
<td><code class="value-key">architecture</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>standalone</code></td>
<td>PostgreSQL architecture (standalone or replication)</td>
</tr>
<tr id="value-primary" class="value-anchor" data-section="postgresql-configuration">
<td><code class="value-key">primary</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>PostgreSQL primary configuration</td>
</tr>
<tr id="value-persistence" class="value-anchor" data-section="postgresql-configuration">
<td><code class="value-key">persistence</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Persistence configuration for primary</td>
</tr>
<tr id="value-resources" class="value-anchor" data-section="postgresql-configuration">
<td><code class="value-key">resources</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Resource limits for primary</td>
</tr>
</tbody>
</table>

---

_Autogenerated from chart metadata using [helm-docs](https://github.com/norwoodj/helm-docs)_
