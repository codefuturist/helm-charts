---
tags:
  - application
  - bitwarden-eso-provider
---

# bitwarden-eso-provider

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square)
![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)
![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

A Bitwarden webhook provider for External Secrets Operator that works with personal/organizational vaults using the Bitwarden CLI

## Quick Links

- [Installation](#installing-the-chart)
- [Values Reference](#values)
- [Search All Values](../reference/search.md)

## Installing the Chart

```bash
helm repo add pandia https://charts.pandia.io
helm repo update
helm install my-bitwarden-eso-provider pandia/bitwarden-eso-provider
```

## Values

!!! tip "Search Values"
    Press ++ctrl+k++ or ++cmd+k++ to search, or use the [interactive values search](../reference/search.md).

<div class="filter-buttons">
  <button class="filter-btn" data-section="general">General</button>
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
<tr class="values-section-header"><td colspan="4"><strong>General</strong></td></tr>
<tr id="value-createClusterSecretStore" class="value-anchor" data-section="general">
<td><code class="value-key">createClusterSecretStore</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Create ClusterSecretStore resource</td>
</tr>
<tr id="value-namespaced" class="value-anchor" data-section="general">
<td><code class="value-key">namespaced</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Create namespaced SecretStore (if false, creates ClusterSecretStore)</td>
</tr>
<tr id="value-name" class="value-anchor" data-section="general">
<td><code class="value-key">name</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"bitwarden"</code></td>
<td>SecretStore/ClusterSecretStore name</td>
</tr>
<tr id="value-annotations" class="value-anchor" data-section="general">
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional annotations</td>
</tr>
<tr id="value-labels" class="value-anchor" data-section="general">
<td><code class="value-key">labels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional labels</td>
</tr>
<tr id="value-enabled" class="value-anchor" data-section="general">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable network policy</td>
</tr>
<tr id="value-ingress" class="value-anchor" data-section="general">
<td><code class="value-key">ingress</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Ingress rules</td>
</tr>
<tr id="value-egress" class="value-anchor" data-section="general">
<td><code class="value-key">egress</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Egress rules (allow Bitwarden API)</td>
</tr>
<tr id="value-enabled" class="value-anchor" data-section="general">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable Prometheus metrics endpoint</td>
</tr>
<tr id="value-enabled" class="value-anchor" data-section="general">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Create ServiceMonitor resource (requires Prometheus Operator)</td>
</tr>
<tr id="value-annotations" class="value-anchor" data-section="general">
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>ServiceMonitor annotations</td>
</tr>
<tr id="value-labels" class="value-anchor" data-section="general">
<td><code class="value-key">labels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional ServiceMonitor labels</td>
</tr>
<tr id="value-interval" class="value-anchor" data-section="general">
<td><code class="value-key">interval</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>30s</code></td>
<td>Scrape interval</td>
</tr>
<tr id="value-scrapeTimeout" class="value-anchor" data-section="general">
<td><code class="value-key">scrapeTimeout</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>null</code></td>
<td>Scrape timeout</td>
</tr>
<tr id="value-relabelings" class="value-anchor" data-section="general">
<td><code class="value-key">relabelings</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Relabelings for ServiceMonitor</td>
</tr>
<tr id="value-metricRelabelings" class="value-anchor" data-section="general">
<td><code class="value-key">metricRelabelings</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Metric relabelings for ServiceMonitor</td>
</tr>
</tbody>
</table>

---

*Autogenerated from chart metadata using [helm-docs](https://github.com/norwoodj/helm-docs)*
