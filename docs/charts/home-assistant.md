---
tags:
  - application
  - home-assistant
---

# home-assistant

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square)
![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)
![AppVersion: 2024.11.1](https://img.shields.io/badge/AppVersion-2024.11.1-informational?style=flat-square)

A comprehensive Helm chart for Home Assistant - Open source home automation that puts local control and privacy first

## Quick Links

- [Installation](#installing-the-chart)
- [Values Reference](#values)
- [Search All Values](../reference/search.md)

## Installing the Chart

```bash
helm repo add pandia https://charts.pandia.io
helm repo update
helm install my-home-assistant pandia/home-assistant
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
<tr id="value-create" class="value-anchor" data-section="general">
<td><code class="value-key">create</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Create service account</td>
</tr>
<tr id="value-annotations" class="value-anchor" data-section="general">
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Annotations for service account</td>
</tr>
<tr id="value-name" class="value-anchor" data-section="general">
<td><code class="value-key">name</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Service account name</td>
</tr>
<tr id="value-create" class="value-anchor" data-section="general">
<td><code class="value-key">create</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Create RBAC resources</td>
</tr>
<tr id="value-enabled" class="value-anchor" data-section="general">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable PodDisruptionBudget</td>
</tr>
<tr id="value-tolerations" class="value-anchor" data-section="general">
<td><code class="value-key">tolerations</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Tolerations</td>
</tr>
<tr id="value-affinity" class="value-anchor" data-section="general">
<td><code class="value-key">affinity</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Affinity rules</td>
</tr>
<tr id="value-extraVolumes" class="value-anchor" data-section="general">
<td><code class="value-key">extraVolumes</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>[]</code></td>
<td>Extra volumes</td>
</tr>
<tr id="value-extraVolumeMounts" class="value-anchor" data-section="general">
<td><code class="value-key">extraVolumeMounts</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>[]</code></td>
<td>Extra volume mounts</td>
</tr>
<tr id="value-initContainers" class="value-anchor" data-section="general">
<td><code class="value-key">initContainers</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Init containers</td>
</tr>
<tr id="value-extraContainers" class="value-anchor" data-section="general">
<td><code class="value-key">extraContainers</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Sidecar containers</td>
</tr>
<tr id="value-enabled" class="value-anchor" data-section="general">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable automated configuration setup</td>
</tr>
<tr id="value-forceInit" class="value-anchor" data-section="general">
<td><code class="value-key">forceInit</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Force initialization on every start</td>
</tr>
<tr id="value-trusted_proxies" class="value-anchor" data-section="general">
<td><code class="value-key">trusted_proxies</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Trusted proxy CIDR ranges for reverse proxy setups</td>
</tr>
<tr id="value-templateConfig" class="value-anchor" data-section="general">
<td><code class="value-key">templateConfig</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>|-</code></td>
<td>Template for configuration.yaml file</td>
</tr>
<tr id="value-initScript" class="value-anchor" data-section="general">
<td><code class="value-key">initScript</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>|-</code></td>
<td>Init script for configuration management</td>
</tr>
<tr id="value-initContainer" class="value-anchor" data-section="general">
<td><code class="value-key">initContainer</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Init container configuration</td>
</tr>
<tr id="value-name" class="value-anchor" data-section="general">
<td><code class="value-key">name</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>setup-config</code></td>
<td>Init container name</td>
</tr>
<tr id="value-image" class="value-anchor" data-section="general">
<td><code class="value-key">image</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>mikefarah/yq:4</code></td>
<td>Init container image (needs yq tool)</td>
</tr>
<tr id="value-securityContext" class="value-anchor" data-section="general">
<td><code class="value-key">securityContext</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Init container security context</td>
</tr>
<tr id="value-volumeMounts" class="value-anchor" data-section="general">
<td><code class="value-key">volumeMounts</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Additional volume mounts for init container</td>
</tr>
</tbody>
</table>

---

_Autogenerated from chart metadata using [helm-docs](https://github.com/norwoodj/helm-docs)_
