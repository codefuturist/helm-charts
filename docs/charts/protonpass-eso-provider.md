---
tags:
  - application
  - protonpass-eso-provider
---

# protonpass-eso-provider

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square)
![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)
![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

A Proton Pass webhook provider for External Secrets Operator that fetches secrets from Proton Pass vaults using pass-cli

## Quick Links

- [Installation](#installing-the-chart)
- [Values Reference](#values)
- [Search All Values](../reference/search.md)

## Installing the Chart

```bash
helm repo add pandia https://charts.pandia.io
helm repo update
helm install my-protonpass-eso-provider pandia/protonpass-eso-provider
```

## Values

!!! tip "Search Values"
    Press ++ctrl+k++ or ++cmd+k++ to search, or use the [interactive values search](../reference/search.md).

<div class="filter-buttons">
  <button class="filter-btn" data-section="api-authentication">API Authentication</button>
  <button class="filter-btn" data-section="admin-api">Admin API</button>
  <button class="filter-btn" data-section="external-secrets-operator">External Secrets Operator</button>
  <button class="filter-btn" data-section="global">Global</button>
  <button class="filter-btn" data-section="image">Image</button>
  <button class="filter-btn" data-section="monitoring">Monitoring</button>
  <button class="filter-btn" data-section="network-policy">Network Policy</button>
  <button class="filter-btn" data-section="pod-disruption-budget">Pod Disruption Budget</button>
  <button class="filter-btn" data-section="proton-pass-authentication">Proton Pass Authentication</button>
  <button class="filter-btn" data-section="scheduling">Scheduling</button>
  <button class="filter-btn" data-section="secret-cache">Secret Cache</button>
  <button class="filter-btn" data-section="security-context">Security Context</button>
  <button class="filter-btn" data-section="service">Service</button>
  <button class="filter-btn" data-section="service-account">Service Account</button>
  <button class="filter-btn" data-section="vault-access-control">Vault Access Control</button>
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
<tr class="values-section-header"><td colspan="4"><strong>API Authentication</strong></td></tr>
<tr id="value-existingSecret" class="value-anchor" data-section="api-authentication">
<td><code class="value-key">existingSecret</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Use an existing secret for the ESO webhook bearer token</td>
</tr>
<tr id="value-name" class="value-anchor" data-section="api-authentication">
<td><code class="value-key">name</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Name of the existing secret (leave empty to auto-generate)</td>
</tr>
<tr id="value-key" class="value-anchor" data-section="api-authentication">
<td><code class="value-key">key</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"token"</code></td>
<td>Key in the secret containing the token</td>
</tr>
<tr id="value-token" class="value-anchor" data-section="api-authentication">
<td><code class="value-key">token</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Token value (leave empty to auto-generate a random 32-char token)</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Admin API</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="admin-api">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable admin endpoints (/api/v1/vaults, /api/v1/items, /api/v1/cache)</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>External Secrets Operator</strong></td></tr>
<tr id="value-createSecretStore" class="value-anchor" data-section="external-secrets-operator">
<td><code class="value-key">createSecretStore</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Create a SecretStore/ClusterSecretStore for ESO</td>
</tr>
<tr id="value-namespaced" class="value-anchor" data-section="external-secrets-operator">
<td><code class="value-key">namespaced</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Create a namespaced SecretStore instead of ClusterSecretStore</td>
</tr>
<tr id="value-timeout" class="value-anchor" data-section="external-secrets-operator">
<td><code class="value-key">timeout</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"10s"</code></td>
<td>Webhook timeout for ESO requests</td>
</tr>
<tr id="value-name" class="value-anchor" data-section="external-secrets-operator">
<td><code class="value-key">name</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"protonpass"</code></td>
<td>Name of the SecretStore/ClusterSecretStore</td>
</tr>
<tr id="value-annotations" class="value-anchor" data-section="external-secrets-operator">
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional annotations</td>
</tr>
<tr id="value-labels" class="value-anchor" data-section="external-secrets-operator">
<td><code class="value-key">labels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional labels</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Global</strong></td></tr>
<tr id="value-replicaCount" class="value-anchor" data-section="global">
<td><code class="value-key">replicaCount</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>See below</code></td>
<td>Proton Pass ESO Provider Number of replicas</td>
</tr>
<tr id="value-additionalLabels" class="value-anchor" data-section="global">
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional labels for all resources</td>
</tr>
<tr id="value-podAnnotations" class="value-anchor" data-section="global">
<td><code class="value-key">podAnnotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Pod annotations</td>
</tr>
<tr id="value-podLabels" class="value-anchor" data-section="global">
<td><code class="value-key">podLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Pod labels</td>
</tr>
<tr id="value-logLevel" class="value-anchor" data-section="global">
<td><code class="value-key">logLevel</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"info"</code></td>
<td>Log level (debug, info, warn, error)</td>
</tr>
<tr id="value-extraEnv" class="value-anchor" data-section="global">
<td><code class="value-key">extraEnv</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Extra environment variables</td>
</tr>
<tr id="value-extraVolumeMounts" class="value-anchor" data-section="global">
<td><code class="value-key">extraVolumeMounts</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Extra volume mounts</td>
</tr>
<tr id="value-extraVolumes" class="value-anchor" data-section="global">
<td><code class="value-key">extraVolumes</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Extra volumes</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Image</strong></td></tr>
<tr id="value-registry" class="value-anchor" data-section="image">
<td><code class="value-key">registry</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>ghcr.io</code></td>
<td>Image registry</td>
</tr>
<tr id="value-repository" class="value-anchor" data-section="image">
<td><code class="value-key">repository</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>codefuturist/protonpass-eso-provider</code></td>
<td>Image repository</td>
</tr>
<tr id="value-tag" class="value-anchor" data-section="image">
<td><code class="value-key">tag</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Image tag (defaults to chart appVersion)</td>
</tr>
<tr id="value-pullPolicy" class="value-anchor" data-section="image">
<td><code class="value-key">pullPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>IfNotPresent</code></td>
<td>Image pull policy</td>
</tr>
<tr id="value-imagePullSecrets" class="value-anchor" data-section="image">
<td><code class="value-key">imagePullSecrets</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Image pull secrets</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Monitoring</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="monitoring">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable Prometheus metrics endpoint</td>
</tr>
<tr id="value-enabled" class="value-anchor" data-section="monitoring">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Create a ServiceMonitor resource</td>
</tr>
<tr id="value-interval" class="value-anchor" data-section="monitoring">
<td><code class="value-key">interval</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"30s"</code></td>
<td>Scrape interval</td>
</tr>
<tr id="value-scrapeTimeout" class="value-anchor" data-section="monitoring">
<td><code class="value-key">scrapeTimeout</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Scrape timeout</td>
</tr>
<tr id="value-namespace" class="value-anchor" data-section="monitoring">
<td><code class="value-key">namespace</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>ServiceMonitor namespace (defaults to release namespace)</td>
</tr>
<tr id="value-labels" class="value-anchor" data-section="monitoring">
<td><code class="value-key">labels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional labels for ServiceMonitor</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Network Policy</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="network-policy">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable network policy</td>
</tr>
<tr id="value-ingress" class="value-anchor" data-section="network-policy">
<td><code class="value-key">ingress</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Ingress rules (who can reach the provider)</td>
</tr>
<tr id="value-egress" class="value-anchor" data-section="network-policy">
<td><code class="value-key">egress</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Egress rules (provider needs HTTPS to Proton API + DNS)</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Pod Disruption Budget</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="pod-disruption-budget">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable PDB</td>
</tr>
<tr id="value-minAvailable" class="value-anchor" data-section="pod-disruption-budget">
<td><code class="value-key">minAvailable</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Minimum available pods</td>
</tr>
<tr id="value-maxUnavailable" class="value-anchor" data-section="pod-disruption-budget">
<td><code class="value-key">maxUnavailable</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Maximum unavailable pods</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Proton Pass Authentication</strong></td></tr>
<tr id="value-existingSecret" class="value-anchor" data-section="proton-pass-authentication">
<td><code class="value-key">existingSecret</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Use an existing Kubernetes secret for Proton Pass credentials</td>
</tr>
<tr id="value-name" class="value-anchor" data-section="proton-pass-authentication">
<td><code class="value-key">name</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Name of the existing secret</td>
</tr>
<tr id="value-usernameKey" class="value-anchor" data-section="proton-pass-authentication">
<td><code class="value-key">usernameKey</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"username"</code></td>
<td>Key in the secret containing the username/email</td>
</tr>
<tr id="value-passwordKey" class="value-anchor" data-section="proton-pass-authentication">
<td><code class="value-key">passwordKey</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"password"</code></td>
<td>Key in the secret containing the password</td>
</tr>
<tr id="value-credentials" class="value-anchor" data-section="proton-pass-authentication">
<td><code class="value-key">credentials</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Credentials to create a new secret (NOT recommended for production)</td>
</tr>
<tr id="value-username" class="value-anchor" data-section="proton-pass-authentication">
<td><code class="value-key">username</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Proton account email address</td>
</tr>
<tr id="value-password" class="value-anchor" data-section="proton-pass-authentication">
<td><code class="value-key">password</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Proton account password</td>
</tr>
<tr id="value-keyProvider" class="value-anchor" data-section="proton-pass-authentication">
<td><code class="value-key">keyProvider</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"fs"</code></td>
<td>pass-cli key provider for session encryption</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Scheduling</strong></td></tr>
<tr id="value-nodeSelector" class="value-anchor" data-section="scheduling">
<td><code class="value-key">nodeSelector</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Node selector</td>
</tr>
<tr id="value-tolerations" class="value-anchor" data-section="scheduling">
<td><code class="value-key">tolerations</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Tolerations</td>
</tr>
<tr id="value-affinity" class="value-anchor" data-section="scheduling">
<td><code class="value-key">affinity</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Affinity</td>
</tr>
<tr id="value-global" class="value-anchor" data-section="scheduling">
<td><code class="value-key">global</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Global values (for common library)</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Secret Cache</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="secret-cache">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Enable in-memory secret caching</td>
</tr>
<tr id="value-ttlSeconds" class="value-anchor" data-section="secret-cache">
<td><code class="value-key">ttlSeconds</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>300</code></td>
<td>Cache time-to-live in seconds</td>
</tr>
<tr id="value-maxEntries" class="value-anchor" data-section="secret-cache">
<td><code class="value-key">maxEntries</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1000</code></td>
<td>Maximum cached entries</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Security Context</strong></td></tr>
<tr id="value-podSecurityContext" class="value-anchor" data-section="security-context">
<td><code class="value-key">podSecurityContext</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Pod security context</td>
</tr>
<tr id="value-securityContext" class="value-anchor" data-section="security-context">
<td><code class="value-key">securityContext</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Container security context</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Service</strong></td></tr>
<tr id="value-type" class="value-anchor" data-section="service">
<td><code class="value-key">type</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>ClusterIP</code></td>
<td>Service type</td>
</tr>
<tr id="value-port" class="value-anchor" data-section="service">
<td><code class="value-key">port</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>8080</code></td>
<td>Service port</td>
</tr>
<tr id="value-labels" class="value-anchor" data-section="service">
<td><code class="value-key">labels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional service labels</td>
</tr>
<tr id="value-annotations" class="value-anchor" data-section="service">
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional service annotations</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Service Account</strong></td></tr>
<tr id="value-create" class="value-anchor" data-section="service-account">
<td><code class="value-key">create</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Create a service account</td>
</tr>
<tr id="value-name" class="value-anchor" data-section="service-account">
<td><code class="value-key">name</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Service account name (defaults to fullname)</td>
</tr>
<tr id="value-annotations" class="value-anchor" data-section="service-account">
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Service account annotations</td>
</tr>
<tr id="value-automount" class="value-anchor" data-section="service-account">
<td><code class="value-key">automount</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Automount service account token</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Vault Access Control</strong></td></tr>
<tr id="value-shared" class="value-anchor" data-section="vault-access-control">
<td><code class="value-key">shared</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Default/shared company vault name or Share ID</td>
</tr>
<tr id="value-allowed" class="value-anchor" data-section="vault-access-control">
<td><code class="value-key">allowed</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Allowed vaults (empty = all accessible vaults)</td>
</tr>
<tr id="value-denied" class="value-anchor" data-section="vault-access-control">
<td><code class="value-key">denied</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Denied vaults (these vaults will never be accessed)</td>
</tr>
</tbody>
</table>

---

*Autogenerated from chart metadata using [helm-docs](https://github.com/norwoodj/helm-docs)*
