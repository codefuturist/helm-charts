---
tags:
  - application
  - nginx
---

# nginx

![Version: 0.1.2](https://img.shields.io/badge/Version-0.1.2-informational?style=flat-square)
![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)
![AppVersion: 1.27.0](https://img.shields.io/badge/AppVersion-1.27.0-informational?style=flat-square)

Helm chart for deploying NGINX web server with customizable configuration

## Quick Links

- [Installation](#installing-the-chart)
- [Values Reference](#values)
- [Search All Values](../reference/search.md)

## Installing the Chart

```bash
helm repo add pandia https://charts.pandia.io
helm repo update
helm install my-nginx pandia/nginx
```

## Values

!!! tip "Search Values"
    Press ++ctrl+k++ or ++cmd+k++ to search, or use the [interactive values search](../reference/search.md).

<div class="filter-buttons">
  <button class="filter-btn" data-section="autoscaling-parameters">Autoscaling Parameters</button>
  <button class="filter-btn" data-section="deployment-parameters">Deployment Parameters</button>
  <button class="filter-btn" data-section="general-parameters">General Parameters</button>
  <button class="filter-btn" data-section="image-parameters">Image Parameters</button>
  <button class="filter-btn" data-section="ingress-parameters">Ingress Parameters</button>
  <button class="filter-btn" data-section="pod-parameters">Pod Parameters</button>
  <button class="filter-btn" data-section="probe-parameters">Probe Parameters</button>
  <button class="filter-btn" data-section="resource-parameters">Resource Parameters</button>
  <button class="filter-btn" data-section="scheduling-parameters">Scheduling Parameters</button>
  <button class="filter-btn" data-section="service-parameters">Service Parameters</button>
  <button class="filter-btn" data-section="serviceaccount-parameters">ServiceAccount Parameters</button>
  <button class="filter-btn" data-section="volume-parameters">Volume Parameters</button>
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
<tr class="values-section-header"><td colspan="4"><strong>Autoscaling Parameters</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="autoscaling-parameters">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable horizontal pod autoscaling.</td>
</tr>
<tr id="value-minReplicas" class="value-anchor" data-section="autoscaling-parameters">
<td><code class="value-key">minReplicas</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Minimum number of replicas.</td>
</tr>
<tr id="value-maxReplicas" class="value-anchor" data-section="autoscaling-parameters">
<td><code class="value-key">maxReplicas</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>100</code></td>
<td>Maximum number of replicas.</td>
</tr>
<tr id="value-targetCPUUtilizationPercentage" class="value-anchor" data-section="autoscaling-parameters">
<td><code class="value-key">targetCPUUtilizationPercentage</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>80</code></td>
<td>Target CPU utilization percentage.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Deployment Parameters</strong></td></tr>
<tr id="value-replicaCount" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">replicaCount</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>3</code></td>
<td>Number of replicas for the deployment.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>General Parameters</strong></td></tr>
<tr id="value-nameOverride" class="value-anchor" data-section="general-parameters">
<td><code class="value-key">nameOverride</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Override the chart name.</td>
</tr>
<tr id="value-fullnameOverride" class="value-anchor" data-section="general-parameters">
<td><code class="value-key">fullnameOverride</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Override the full name.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Image Parameters</strong></td></tr>
<tr id="value-repository" class="value-anchor" data-section="image-parameters">
<td><code class="value-key">repository</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>nginx</code></td>
<td>Container image repository.</td>
</tr>
<tr id="value-pullPolicy" class="value-anchor" data-section="image-parameters">
<td><code class="value-key">pullPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>IfNotPresent</code></td>
<td>Image pull policy.</td>
</tr>
<tr id="value-tag" class="value-anchor" data-section="image-parameters">
<td><code class="value-key">tag</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Overrides the image tag whose default is the chart appVersion.</td>
</tr>
<tr id="value-imagePullSecrets" class="value-anchor" data-section="image-parameters">
<td><code class="value-key">imagePullSecrets</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Secrets for pulling images from a private repository.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Ingress Parameters</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="ingress-parameters">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable ingress.</td>
</tr>
<tr id="value-className" class="value-anchor" data-section="ingress-parameters">
<td><code class="value-key">className</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Ingress class name.</td>
</tr>
<tr id="value-annotations" class="value-anchor" data-section="ingress-parameters">
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Ingress annotations.</td>
</tr>
<tr id="value-hosts" class="value-anchor" data-section="ingress-parameters">
<td><code class="value-key">hosts</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Ingress hosts configuration.</td>
</tr>
<tr id="value-tls" class="value-anchor" data-section="ingress-parameters">
<td><code class="value-key">tls</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Ingress TLS configuration.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Pod Parameters</strong></td></tr>
<tr id="value-podAnnotations" class="value-anchor" data-section="pod-parameters">
<td><code class="value-key">podAnnotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Annotations for pods.</td>
</tr>
<tr id="value-podLabels" class="value-anchor" data-section="pod-parameters">
<td><code class="value-key">podLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Labels for pods.</td>
</tr>
<tr id="value-podSecurityContext" class="value-anchor" data-section="pod-parameters">
<td><code class="value-key">podSecurityContext</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Pod security context.</td>
</tr>
<tr id="value-securityContext" class="value-anchor" data-section="pod-parameters">
<td><code class="value-key">securityContext</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Container security context.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Probe Parameters</strong></td></tr>
<tr id="value-livenessProbe" class="value-anchor" data-section="probe-parameters">
<td><code class="value-key">livenessProbe</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Liveness probe configuration.</td>
</tr>
<tr id="value-readinessProbe" class="value-anchor" data-section="probe-parameters">
<td><code class="value-key">readinessProbe</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Readiness probe configuration.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Resource Parameters</strong></td></tr>
<tr id="value-resources" class="value-anchor" data-section="resource-parameters">
<td><code class="value-key">resources</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Resource limits and requests.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Scheduling Parameters</strong></td></tr>
<tr id="value-nodeSelector" class="value-anchor" data-section="scheduling-parameters">
<td><code class="value-key">nodeSelector</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Node selector for pod scheduling.</td>
</tr>
<tr id="value-tolerations" class="value-anchor" data-section="scheduling-parameters">
<td><code class="value-key">tolerations</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Tolerations for pod scheduling.</td>
</tr>
<tr id="value-affinity" class="value-anchor" data-section="scheduling-parameters">
<td><code class="value-key">affinity</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Affinity rules for pod scheduling.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Service Parameters</strong></td></tr>
<tr id="value-type" class="value-anchor" data-section="service-parameters">
<td><code class="value-key">type</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>ClusterIP</code></td>
<td>Service type (ClusterIP, NodePort, LoadBalancer).</td>
</tr>
<tr id="value-port" class="value-anchor" data-section="service-parameters">
<td><code class="value-key">port</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>80</code></td>
<td>Service port.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>ServiceAccount Parameters</strong></td></tr>
<tr id="value-create" class="value-anchor" data-section="serviceaccount-parameters">
<td><code class="value-key">create</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Specifies whether a service account should be created.</td>
</tr>
<tr id="value-automount" class="value-anchor" data-section="serviceaccount-parameters">
<td><code class="value-key">automount</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Automatically mount a ServiceAccount's API credentials.</td>
</tr>
<tr id="value-annotations" class="value-anchor" data-section="serviceaccount-parameters">
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Annotations to add to the service account.</td>
</tr>
<tr id="value-name" class="value-anchor" data-section="serviceaccount-parameters">
<td><code class="value-key">name</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>The name of the service account to use. If not set and create is true, a name is generated.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Volume Parameters</strong></td></tr>
<tr id="value-volumes" class="value-anchor" data-section="volume-parameters">
<td><code class="value-key">volumes</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Additional volumes for the deployment.</td>
</tr>
<tr id="value-volumeMounts" class="value-anchor" data-section="volume-parameters">
<td><code class="value-key">volumeMounts</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Additional volume mounts for the deployment.</td>
</tr>
</tbody>
</table>

---

*Autogenerated from chart metadata using [helm-docs](https://github.com/norwoodj/helm-docs)*
