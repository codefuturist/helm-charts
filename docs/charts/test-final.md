---
tags:
  - application
  - test-final
---

# test-final

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square)
![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)
![AppVersion: 1.27.3](https://img.shields.io/badge/AppVersion-1.27.3-informational?style=flat-square)

Test chart with auto-version

## Quick Links

- [Installation](#installing-the-chart)
- [Values Reference](#values)
- [Search All Values](../reference/search.md)

## Installing the Chart

```bash
helm repo add pandia https://charts.pandia.io
helm repo update
helm install my-test-final pandia/test-final
```

## Values

!!! tip "Search Values"
    Press ++ctrl+k++ or ++cmd+k++ to search, or use the [interactive values search](../reference/search.md).

<div class="filter-buttons">
  <button class="filter-btn" data-section="application-configuration">Application Configuration</button>
  <button class="filter-btn" data-section="controller-configuration">Controller Configuration</button>
  <button class="filter-btn" data-section="diagnostic-mode">Diagnostic Mode</button>
  <button class="filter-btn" data-section="global-parameters">Global Parameters</button>
  <button class="filter-btn" data-section="health-probes">Health Probes</button>
  <button class="filter-btn" data-section="high-availability">High Availability</button>
  <button class="filter-btn" data-section="image-configuration">Image Configuration</button>
  <button class="filter-btn" data-section="ingress-configuration">Ingress Configuration</button>
  <button class="filter-btn" data-section="monitoring">Monitoring</button>
  <button class="filter-btn" data-section="network-policy">Network Policy</button>
  <button class="filter-btn" data-section="persistence-configuration">Persistence Configuration</button>
  <button class="filter-btn" data-section="pod-configuration">Pod Configuration</button>
  <button class="filter-btn" data-section="rbac-configuration">RBAC Configuration</button>
  <button class="filter-btn" data-section="resources">Resources</button>
  <button class="filter-btn" data-section="security-context">Security Context</button>
  <button class="filter-btn" data-section="service-configuration">Service Configuration</button>
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
<tr class="values-section-header"><td colspan="4"><strong>Application Configuration</strong></td></tr>
<tr id="value-config" class="value-anchor" data-section="application-configuration">
<td><code class="value-key">config</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Application configuration as environment variables</td>
</tr>
<tr id="value-existingSecret" class="value-anchor" data-section="application-configuration">
<td><code class="value-key">existingSecret</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Name of an existing secret containing application credentials</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Controller Configuration</strong></td></tr>
<tr id="value-type" class="value-anchor" data-section="controller-configuration">
<td><code class="value-key">type</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>deployment</code></td>
<td>Controller type (deployment or statefulset)</td>
</tr>
<tr id="value-replicas" class="value-anchor" data-section="controller-configuration">
<td><code class="value-key">replicas</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Number of replicas</td>
</tr>
<tr id="value-strategy" class="value-anchor" data-section="controller-configuration">
<td><code class="value-key">strategy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Deployment update strategy</td>
</tr>
<tr id="value-updateStrategy" class="value-anchor" data-section="controller-configuration">
<td><code class="value-key">updateStrategy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>StatefulSet update strategy (only used if controller.type is statefulset)</td>
</tr>
<tr id="value-podManagementPolicy" class="value-anchor" data-section="controller-configuration">
<td><code class="value-key">podManagementPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>OrderedReady</code></td>
<td>Pod management policy (only used if controller.type is statefulset)</td>
</tr>
<tr id="value-command" class="value-anchor" data-section="controller-configuration">
<td><code class="value-key">command</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Command override for the main container</td>
</tr>
<tr id="value-args" class="value-anchor" data-section="controller-configuration">
<td><code class="value-key">args</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Args override for the main container</td>
</tr>
<tr id="value-workingDir" class="value-anchor" data-section="controller-configuration">
<td><code class="value-key">workingDir</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Working directory for the main container</td>
</tr>
<tr id="value-terminationGracePeriodSeconds" class="value-anchor" data-section="controller-configuration">
<td><code class="value-key">terminationGracePeriodSeconds</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>30</code></td>
<td>Termination grace period in seconds</td>
</tr>
<tr id="value-lifecycle" class="value-anchor" data-section="controller-configuration">
<td><code class="value-key">lifecycle</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Lifecycle hooks for the main container</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Diagnostic Mode</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="diagnostic-mode">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable diagnostic mode (disables probes, overrides command)</td>
</tr>
<tr id="value-command" class="value-anchor" data-section="diagnostic-mode">
<td><code class="value-key">command</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Command override for diagnostic mode</td>
</tr>
<tr id="value-args" class="value-anchor" data-section="diagnostic-mode">
<td><code class="value-key">args</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Args override for diagnostic mode</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Global Parameters</strong></td></tr>
<tr id="value-namespaceOverride" class="value-anchor" data-section="global-parameters">
<td><code class="value-key">namespaceOverride</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`.Release.Namespace`</code></td>
<td>Override the namespace for all resources</td>
</tr>
<tr id="value-nameOverride" class="value-anchor" data-section="global-parameters">
<td><code class="value-key">nameOverride</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Override the name of the chart</td>
</tr>
<tr id="value-fullnameOverride" class="value-anchor" data-section="global-parameters">
<td><code class="value-key">fullnameOverride</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Override the full name of the chart</td>
</tr>
<tr id="value-additionalLabels" class="value-anchor" data-section="global-parameters">
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional labels to add to all resources</td>
</tr>
<tr id="value-additionalAnnotations" class="value-anchor" data-section="global-parameters">
<td><code class="value-key">additionalAnnotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional annotations to add to all resources</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Health Probes</strong></td></tr>
<tr id="value-livenessProbe" class="value-anchor" data-section="health-probes">
<td><code class="value-key">livenessProbe</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Liveness probe configuration</td>
</tr>
<tr id="value-readinessProbe" class="value-anchor" data-section="health-probes">
<td><code class="value-key">readinessProbe</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Readiness probe configuration</td>
</tr>
<tr id="value-startupProbe" class="value-anchor" data-section="health-probes">
<td><code class="value-key">startupProbe</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Startup probe configuration</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>High Availability</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="high-availability">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable PodDisruptionBudget</td>
</tr>
<tr id="value-minAvailable" class="value-anchor" data-section="high-availability">
<td><code class="value-key">minAvailable</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Minimum number of pods that must be available</td>
</tr>
<tr id="value-maxUnavailable" class="value-anchor" data-section="high-availability">
<td><code class="value-key">maxUnavailable</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Maximum number of pods that can be unavailable</td>
</tr>
<tr id="value-hpa" class="value-anchor" data-section="high-availability">
<td><code class="value-key">hpa</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Horizontal Pod Autoscaler configuration</td>
</tr>
<tr id="value-enabled" class="value-anchor" data-section="high-availability">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable HorizontalPodAutoscaler</td>
</tr>
<tr id="value-minReplicas" class="value-anchor" data-section="high-availability">
<td><code class="value-key">minReplicas</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Minimum number of replicas</td>
</tr>
<tr id="value-maxReplicas" class="value-anchor" data-section="high-availability">
<td><code class="value-key">maxReplicas</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>3</code></td>
<td>Maximum number of replicas</td>
</tr>
<tr id="value-targetCPUUtilizationPercentage" class="value-anchor" data-section="high-availability">
<td><code class="value-key">targetCPUUtilizationPercentage</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>80</code></td>
<td>Target CPU utilization percentage</td>
</tr>
<tr id="value-targetMemoryUtilizationPercentage" class="value-anchor" data-section="high-availability">
<td><code class="value-key">targetMemoryUtilizationPercentage</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>80</code></td>
<td>Target memory utilization percentage</td>
</tr>
<tr id="value-customMetrics" class="value-anchor" data-section="high-availability">
<td><code class="value-key">customMetrics</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Custom metrics for autoscaling</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Image Configuration</strong></td></tr>
<tr id="value-repository" class="value-anchor" data-section="image-configuration">
<td><code class="value-key">repository</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>nginx:1.27.3</code></td>
<td>Docker image repository</td>
</tr>
<tr id="value-tag" class="value-anchor" data-section="image-configuration">
<td><code class="value-key">tag</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>Chart appVersion</code></td>
<td>Docker image tag</td>
</tr>
<tr id="value-pullPolicy" class="value-anchor" data-section="image-configuration">
<td><code class="value-key">pullPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>IfNotPresent</code></td>
<td>Image pull policy</td>
</tr>
<tr id="value-digest" class="value-anchor" data-section="image-configuration">
<td><code class="value-key">digest</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Image digest (overrides tag if set)</td>
</tr>
<tr id="value-imagePullSecrets" class="value-anchor" data-section="image-configuration">
<td><code class="value-key">imagePullSecrets</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Image pull secrets for private registries</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Ingress Configuration</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="ingress-configuration">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable ingress</td>
</tr>
<tr id="value-className" class="value-anchor" data-section="ingress-configuration">
<td><code class="value-key">className</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Ingress class name</td>
</tr>
<tr id="value-annotations" class="value-anchor" data-section="ingress-configuration">
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Ingress annotations</td>
</tr>
<tr id="value-hosts" class="value-anchor" data-section="ingress-configuration">
<td><code class="value-key">hosts</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Ingress hosts configuration</td>
</tr>
<tr id="value-tls" class="value-anchor" data-section="ingress-configuration">
<td><code class="value-key">tls</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Ingress TLS configuration</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Monitoring</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="monitoring">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable ServiceMonitor for Prometheus Operator</td>
</tr>
<tr id="value-namespace" class="value-anchor" data-section="monitoring">
<td><code class="value-key">namespace</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Namespace for the ServiceMonitor (defaults to the release namespace)</td>
</tr>
<tr id="value-interval" class="value-anchor" data-section="monitoring">
<td><code class="value-key">interval</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>30s</code></td>
<td>Interval at which metrics should be scraped</td>
</tr>
<tr id="value-scrapeTimeout" class="value-anchor" data-section="monitoring">
<td><code class="value-key">scrapeTimeout</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>10s</code></td>
<td>Timeout for scraping metrics</td>
</tr>
<tr id="value-labels" class="value-anchor" data-section="monitoring">
<td><code class="value-key">labels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional labels for the ServiceMonitor</td>
</tr>
<tr id="value-annotations" class="value-anchor" data-section="monitoring">
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional annotations for the ServiceMonitor</td>
</tr>
<tr id="value-metricRelabelings" class="value-anchor" data-section="monitoring">
<td><code class="value-key">metricRelabelings</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Metric relabelings</td>
</tr>
<tr id="value-relabelings" class="value-anchor" data-section="monitoring">
<td><code class="value-key">relabelings</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Relabelings</td>
</tr>
<tr id="value-enabled" class="value-anchor" data-section="monitoring">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable PrometheusRule for alerting</td>
</tr>
<tr id="value-namespace" class="value-anchor" data-section="monitoring">
<td><code class="value-key">namespace</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Namespace for the PrometheusRule (defaults to the release namespace)</td>
</tr>
<tr id="value-labels" class="value-anchor" data-section="monitoring">
<td><code class="value-key">labels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional labels for the PrometheusRule</td>
</tr>
<tr id="value-rules" class="value-anchor" data-section="monitoring">
<td><code class="value-key">rules</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Alert rules</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Network Policy</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="network-policy">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable network policy</td>
</tr>
<tr id="value-policyTypes" class="value-anchor" data-section="network-policy">
<td><code class="value-key">policyTypes</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Policy types</td>
</tr>
<tr id="value-ingress" class="value-anchor" data-section="network-policy">
<td><code class="value-key">ingress</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Ingress rules</td>
</tr>
<tr id="value-egress" class="value-anchor" data-section="network-policy">
<td><code class="value-key">egress</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Egress rules</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Persistence Configuration</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="persistence-configuration">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable persistent storage</td>
</tr>
<tr id="value-storageClassName" class="value-anchor" data-section="persistence-configuration">
<td><code class="value-key">storageClassName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>Default storage class</code></td>
<td>Storage class name</td>
</tr>
<tr id="value-accessMode" class="value-anchor" data-section="persistence-configuration">
<td><code class="value-key">accessMode</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>ReadWriteOnce</code></td>
<td>Access mode for the persistent volume</td>
</tr>
<tr id="value-size" class="value-anchor" data-section="persistence-configuration">
<td><code class="value-key">size</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>1Gi</code></td>
<td>Size of the persistent volume</td>
</tr>
<tr id="value-existingClaim" class="value-anchor" data-section="persistence-configuration">
<td><code class="value-key">existingClaim</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Name of an existing PVC to use</td>
</tr>
<tr id="value-annotations" class="value-anchor" data-section="persistence-configuration">
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Annotations for the PVC</td>
</tr>
<tr id="value-mountPath" class="value-anchor" data-section="persistence-configuration">
<td><code class="value-key">mountPath</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>/data</code></td>
<td>Mount path for the persistent volume</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Pod Configuration</strong></td></tr>
<tr id="value-podAnnotations" class="value-anchor" data-section="pod-configuration">
<td><code class="value-key">podAnnotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Pod annotations</td>
</tr>
<tr id="value-podLabels" class="value-anchor" data-section="pod-configuration">
<td><code class="value-key">podLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Pod labels</td>
</tr>
<tr id="value-nodeSelector" class="value-anchor" data-section="pod-configuration">
<td><code class="value-key">nodeSelector</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Node selector for pod assignment</td>
</tr>
<tr id="value-tolerations" class="value-anchor" data-section="pod-configuration">
<td><code class="value-key">tolerations</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Tolerations for pod assignment</td>
</tr>
<tr id="value-affinity" class="value-anchor" data-section="pod-configuration">
<td><code class="value-key">affinity</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Affinity for pod assignment</td>
</tr>
<tr id="value-priorityClassName" class="value-anchor" data-section="pod-configuration">
<td><code class="value-key">priorityClassName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Priority class name for the pod</td>
</tr>
<tr id="value-topologySpreadConstraints" class="value-anchor" data-section="pod-configuration">
<td><code class="value-key">topologySpreadConstraints</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Topology spread constraints for pod distribution</td>
</tr>
<tr id="value-dnsPolicy" class="value-anchor" data-section="pod-configuration">
<td><code class="value-key">dnsPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>ClusterFirst</code></td>
<td>DNS policy</td>
</tr>
<tr id="value-dnsConfig" class="value-anchor" data-section="pod-configuration">
<td><code class="value-key">dnsConfig</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>DNS config</td>
</tr>
<tr id="value-hostAliases" class="value-anchor" data-section="pod-configuration">
<td><code class="value-key">hostAliases</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Host aliases</td>
</tr>
<tr id="value-runtimeClassName" class="value-anchor" data-section="pod-configuration">
<td><code class="value-key">runtimeClassName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Runtime class name</td>
</tr>
<tr id="value-initContainers" class="value-anchor" data-section="pod-configuration">
<td><code class="value-key">initContainers</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Init containers to run before the main container</td>
</tr>
<tr id="value-extraContainers" class="value-anchor" data-section="pod-configuration">
<td><code class="value-key">extraContainers</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Extra sidecar containers</td>
</tr>
<tr id="value-extraEnv" class="value-anchor" data-section="pod-configuration">
<td><code class="value-key">extraEnv</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Extra environment variables</td>
</tr>
<tr id="value-extraEnvFrom" class="value-anchor" data-section="pod-configuration">
<td><code class="value-key">extraEnvFrom</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Extra environment variables from ConfigMaps or Secrets</td>
</tr>
<tr id="value-extraVolumes" class="value-anchor" data-section="pod-configuration">
<td><code class="value-key">extraVolumes</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Extra volumes</td>
</tr>
<tr id="value-extraVolumeMounts" class="value-anchor" data-section="pod-configuration">
<td><code class="value-key">extraVolumeMounts</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Extra volume mounts</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>RBAC Configuration</strong></td></tr>
<tr id="value-create" class="value-anchor" data-section="rbac-configuration">
<td><code class="value-key">create</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Create a service account</td>
</tr>
<tr id="value-name" class="value-anchor" data-section="rbac-configuration">
<td><code class="value-key">name</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Service account name (generated if not set and create is true)</td>
</tr>
<tr id="value-annotations" class="value-anchor" data-section="rbac-configuration">
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Service account annotations</td>
</tr>
<tr id="value-create" class="value-anchor" data-section="rbac-configuration">
<td><code class="value-key">create</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Create RBAC resources</td>
</tr>
<tr id="value-rules" class="value-anchor" data-section="rbac-configuration">
<td><code class="value-key">rules</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Additional RBAC rules</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Resources</strong></td></tr>
<tr id="value-resources" class="value-anchor" data-section="resources">
<td><code class="value-key">resources</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Resource limits and requests</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Security Context</strong></td></tr>
<tr id="value-podSecurityContext" class="value-anchor" data-section="security-context">
<td><code class="value-key">podSecurityContext</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Pod security context</td>
</tr>
<tr id="value-securityContext" class="value-anchor" data-section="security-context">
<td><code class="value-key">securityContext</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Container security context</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Service Configuration</strong></td></tr>
<tr id="value-type" class="value-anchor" data-section="service-configuration">
<td><code class="value-key">type</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>ClusterIP</code></td>
<td>Service type</td>
</tr>
<tr id="value-port" class="value-anchor" data-section="service-configuration">
<td><code class="value-key">port</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>80</code></td>
<td>Service port</td>
</tr>
<tr id="value-targetPort" class="value-anchor" data-section="service-configuration">
<td><code class="value-key">targetPort</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>8080</code></td>
<td>Service target port (container port)</td>
</tr>
<tr id="value-nodePort" class="value-anchor" data-section="service-configuration">
<td><code class="value-key">nodePort</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Node port (only used if type is NodePort)</td>
</tr>
<tr id="value-loadBalancerIP" class="value-anchor" data-section="service-configuration">
<td><code class="value-key">loadBalancerIP</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Load balancer IP (only used if type is LoadBalancer)</td>
</tr>
<tr id="value-loadBalancerSourceRanges" class="value-anchor" data-section="service-configuration">
<td><code class="value-key">loadBalancerSourceRanges</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Load balancer source ranges (only used if type is LoadBalancer)</td>
</tr>
<tr id="value-externalTrafficPolicy" class="value-anchor" data-section="service-configuration">
<td><code class="value-key">externalTrafficPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>External traffic policy (only used if type is LoadBalancer or NodePort)</td>
</tr>
<tr id="value-clusterIP" class="value-anchor" data-section="service-configuration">
<td><code class="value-key">clusterIP</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Cluster IP (set to None for headless service)</td>
</tr>
<tr id="value-sessionAffinity" class="value-anchor" data-section="service-configuration">
<td><code class="value-key">sessionAffinity</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>None</code></td>
<td>Session affinity</td>
</tr>
<tr id="value-sessionAffinityConfig" class="value-anchor" data-section="service-configuration">
<td><code class="value-key">sessionAffinityConfig</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Session affinity config</td>
</tr>
<tr id="value-annotations" class="value-anchor" data-section="service-configuration">
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Service annotations</td>
</tr>
<tr id="value-labels" class="value-anchor" data-section="service-configuration">
<td><code class="value-key">labels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Service labels</td>
</tr>
</tbody>
</table>

---

*Autogenerated from chart metadata using [helm-docs](https://github.com/norwoodj/helm-docs)*
