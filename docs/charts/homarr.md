---
tags:
  - application
  - homarr
---

# homarr

![Version: 5.2.12](https://img.shields.io/badge/Version-5.2.12-informational?style=flat-square)
![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

Generic helm chart for all kind of applications

## Quick Links

- [Installation](#installing-the-chart)
- [Values Reference](#values)
- [Search All Values](../reference/search.md)

## Installing the Chart

```bash
helm repo add pandia https://charts.pandia.io
helm repo update
helm install my-homarr pandia/homarr
```

## Values

!!! tip "Search Values"
Press ++ctrl+k++ or ++cmd+k++ to search, or use the [interactive values search](../reference/search.md).

<div class="filter-buttons">
  <button class="filter-btn" data-section="alertmanagerconfig-parameters">AlertmanagerConfig Parameters</button>
  <button class="filter-btn" data-section="autoscaling---horizontal-pod-autoscaling-parameters">Autoscaling - Horizontal Pod Autoscaling Parameters</button>
  <button class="filter-btn" data-section="backup-parameters">Backup Parameters</button>
  <button class="filter-btn" data-section="configmap-parameters">ConfigMap Parameters</button>
  <button class="filter-btn" data-section="cronjob-parameters">CronJob Parameters</button>
  <button class="filter-btn" data-section="deployment-parameters">Deployment Parameters</button>
  <button class="filter-btn" data-section="endpointmonitor-parameters">EndpointMonitor Parameters</button>
  <button class="filter-btn" data-section="externalsecret-parameters">ExternalSecret Parameters</button>
  <button class="filter-btn" data-section="forecastleapp-parameters">ForecastleApp Parameters</button>
  <button class="filter-btn" data-section="grafanadashboard-parameters">GrafanaDashboard Parameters</button>
  <button class="filter-btn" data-section="ingress-parameters">Ingress Parameters</button>
  <button class="filter-btn" data-section="job-parameters">Job Parameters</button>
  <button class="filter-btn" data-section="networkpolicy-parameters">NetworkPolicy Parameters</button>
  <button class="filter-btn" data-section="parameters">Parameters</button>
  <button class="filter-btn" data-section="poddisruptionbudget-parameters">PodDisruptionBudget Parameters</button>
  <button class="filter-btn" data-section="prometheusrule-parameters">PrometheusRule Parameters</button>
  <button class="filter-btn" data-section="rbac-parameters">RBAC Parameters</button>
  <button class="filter-btn" data-section="route-parameters">Route Parameters</button>
  <button class="filter-btn" data-section="sealedsecret-parameters">SealedSecret Parameters</button>
  <button class="filter-btn" data-section="secret-parameters">Secret Parameters</button>
  <button class="filter-btn" data-section="secretproviderclass-parameters">SecretProviderClass Parameters</button>
  <button class="filter-btn" data-section="service-parameters">Service Parameters</button>
  <button class="filter-btn" data-section="servicemonitor-parameters">ServiceMonitor Parameters</button>
  <button class="filter-btn" data-section="vpa---vertical-pod-autoscaler-parameters">VPA - Vertical Pod Autoscaler Parameters</button>
  <button class="filter-btn" data-section="cert-manager-certificate-parameters">cert-manager Certificate Parameters</button>
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
<tr class="values-section-header"><td colspan="4"><strong>AlertmanagerConfig Parameters</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="alertmanagerconfig-parameters">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy an AlertmanagerConfig (Prometheus Operator) resource.</td>
</tr>
<tr id="value-selectionLabels" class="value-anchor" data-section="alertmanagerconfig-parameters">
<td><code class="value-key">selectionLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Labels to be picked up by Alertmanager to add it to base config.</td>
</tr>
<tr id="value-spec" class="value-anchor" data-section="alertmanagerconfig-parameters">
<td><code class="value-key">spec</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>AlertmanagerConfig spec.</td>
</tr>
<tr id="value-route" class="value-anchor" data-section="alertmanagerconfig-parameters">
<td><code class="value-key">route</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Route definition for alerts matching the resource’s namespace.</td>
</tr>
<tr id="value-receivers" class="value-anchor" data-section="alertmanagerconfig-parameters">
<td><code class="value-key">receivers</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>List of receivers.</td>
</tr>
<tr id="value-inhibitRules" class="value-anchor" data-section="alertmanagerconfig-parameters">
<td><code class="value-key">inhibitRules</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Inhibition rules that allows to mute alerts when other alerts are already firing.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Autoscaling - Horizontal Pod Autoscaling Parameters</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="autoscaling---horizontal-pod-autoscaling-parameters">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable Horizontal Pod Autoscaling.</td>
</tr>
<tr id="value-additionalLabels" class="value-anchor" data-section="autoscaling---horizontal-pod-autoscaling-parameters">
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for HPA.</td>
</tr>
<tr id="value-annotations" class="value-anchor" data-section="autoscaling---horizontal-pod-autoscaling-parameters">
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for HPA.</td>
</tr>
<tr id="value-minReplicas" class="value-anchor" data-section="autoscaling---horizontal-pod-autoscaling-parameters">
<td><code class="value-key">minReplicas</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Minimum number of replicas.</td>
</tr>
<tr id="value-maxReplicas" class="value-anchor" data-section="autoscaling---horizontal-pod-autoscaling-parameters">
<td><code class="value-key">maxReplicas</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>10</code></td>
<td>Maximum number of replicas.</td>
</tr>
<tr id="value-metrics" class="value-anchor" data-section="autoscaling---horizontal-pod-autoscaling-parameters">
<td><code class="value-key">metrics</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Metrics used for autoscaling.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Backup Parameters</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="backup-parameters">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy a [Velero/OADP Backup](https://velero.io/docs/main/api-types/backup/) resource.</td>
</tr>
<tr id="value-namespace" class="value-anchor" data-section="backup-parameters">
<td><code class="value-key">namespace</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`{{ .Release.Namespace }}`</code></td>
<td>Namespace for Backup.</td>
</tr>
<tr id="value-additionalLabels" class="value-anchor" data-section="backup-parameters">
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for Backup.</td>
</tr>
<tr id="value-annotations" class="value-anchor" data-section="backup-parameters">
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for Backup.</td>
</tr>
<tr id="value-defaultVolumesToRestic" class="value-anchor" data-section="backup-parameters">
<td><code class="value-key">defaultVolumesToRestic</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Whether to use Restic to take snapshots of all pod volumes by default.</td>
</tr>
<tr id="value-snapshotVolumes" class="value-anchor" data-section="backup-parameters">
<td><code class="value-key">snapshotVolumes</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Whether to take snapshots of persistent volumes as part of the backup.</td>
</tr>
<tr id="value-storageLocation" class="value-anchor" data-section="backup-parameters">
<td><code class="value-key">storageLocation</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Name of the backup storage location where the backup should be stored.</td>
</tr>
<tr id="value-ttl" class="value-anchor" data-section="backup-parameters">
<td><code class="value-key">ttl</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"1h0m0s"</code></td>
<td>How long the Backup should be retained for.</td>
</tr>
<tr id="value-includedResources" class="value-anchor" data-section="backup-parameters">
<td><code class="value-key">includedResources</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>List of resource types to include in the backup.</td>
</tr>
<tr id="value-excludedResources" class="value-anchor" data-section="backup-parameters">
<td><code class="value-key">excludedResources</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>List of resource types to exclude from the backup.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>ConfigMap Parameters</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="configmap-parameters">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy additional ConfigMaps.</td>
</tr>
<tr id="value-additionalLabels" class="value-anchor" data-section="configmap-parameters">
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for ConfigMaps.</td>
</tr>
<tr id="value-annotations" class="value-anchor" data-section="configmap-parameters">
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for ConfigMaps.</td>
</tr>
<tr id="value-files" class="value-anchor" data-section="configmap-parameters">
<td><code class="value-key">files</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>List of ConfigMap entries.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>CronJob Parameters</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="cronjob-parameters">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy CronJob resources.</td>
</tr>
<tr id="value-jobs" class="value-anchor" data-section="cronjob-parameters">
<td><code class="value-key">jobs</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Map of CronJob resources.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Deployment Parameters</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Enable Deployment.</td>
</tr>
<tr id="value-additionalLabels" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for Deployment.</td>
</tr>
<tr id="value-podLabels" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">podLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional pod labels which are used in Service's Label Selector.</td>
</tr>
<tr id="value-annotations" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for Deployment.</td>
</tr>
<tr id="value-additionalPodAnnotations" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">additionalPodAnnotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional pod annotations.</td>
</tr>
<tr id="value-type" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">type</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>RollingUpdate</code></td>
<td>Type of deployment strategy.</td>
</tr>
<tr id="value-maxUnavailable" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">maxUnavailable</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>25%</code></td>
<td>Max unavailable pods during update.</td>
</tr>
<tr id="value-maxSurge" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">maxSurge</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>25%</code></td>
<td>Max surge pods during update.</td>
</tr>
<tr id="value-reloadOnChange" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">reloadOnChange</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Reload deployment if attached Secret/ConfigMap changes.</td>
</tr>
<tr id="value-nodeSelector" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">nodeSelector</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Select the node where the pods should be scheduled.</td>
</tr>
<tr id="value-hostAliases" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">hostAliases</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Add host aliases to the pods.</td>
</tr>
<tr id="value-initContainers" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">initContainers</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Add init containers to the pods.</td>
</tr>
<tr id="value-fluentdConfigAnnotations" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">fluentdConfigAnnotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Configuration details for fluentdConfigurations.</td>
</tr>
<tr id="value-replicas" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">replicas</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>`nil`</code></td>
<td>Number of replicas.</td>
</tr>
<tr id="value-imagePullSecrets" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">imagePullSecrets</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>List of secrets to be used for pulling the images.</td>
</tr>
<tr id="value-envFrom" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">envFrom</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Mount environment variables from ConfigMap or Secret to the pod.</td>
</tr>
<tr id="value-env" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">env</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Environment variables to be added to the pod.</td>
</tr>
<tr id="value-volumes" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">volumes</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Volumes to be added to the pod.</td>
</tr>
<tr id="value-volumeMounts" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">volumeMounts</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Mount path for Volumes.</td>
</tr>
<tr id="value-priorityClassName" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">priorityClassName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Define the priority class for the pod.</td>
</tr>
<tr id="value-tolerations" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">tolerations</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Taint tolerations for the pods.</td>
</tr>
<tr id="value-affinity" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">affinity</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Affinity for the pods.</td>
</tr>
<tr id="value-topologySpreadConstraints" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">topologySpreadConstraints</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Topology spread constraints for the pods.</td>
</tr>
<tr id="value-revisionHistoryLimit" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">revisionHistoryLimit</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>2</code></td>
<td>Number of ReplicaSet revisions to retain.</td>
</tr>
<tr id="value-repository" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">repository</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"nginx"</code></td>
<td>Repository.</td>
</tr>
<tr id="value-tag" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">tag</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"latest"</code></td>
<td>Tag.</td>
</tr>
<tr id="value-digest" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">digest</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Image digest. If set to a non-empty value, digest takes precedence on the tag.</td>
</tr>
<tr id="value-pullPolicy" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">pullPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>IfNotPresent</code></td>
<td>Image pull policy.</td>
</tr>
<tr id="value-dnsConfig" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">dnsConfig</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>DNS config for the pods.</td>
</tr>
<tr id="value-startupProbe" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">startupProbe</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>See below</code></td>
<td>Startup probe.</td>
</tr>
<tr id="value-enabled" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable Startup probe.</td>
</tr>
<tr id="value-failureThreshold" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">failureThreshold</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>30</code></td>
<td>Number of retries before marking the pod as failed.</td>
</tr>
<tr id="value-periodSeconds" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">periodSeconds</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>10</code></td>
<td>Time between retries.</td>
</tr>
<tr id="value-successThreshold" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">successThreshold</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Number of successful probes before marking the pod as ready.</td>
</tr>
<tr id="value-timeoutSeconds" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">timeoutSeconds</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Time before the probe times out.</td>
</tr>
<tr id="value-httpGet" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">httpGet</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>HTTP Get probe.</td>
</tr>
<tr id="value-exec" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">exec</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Exec probe.</td>
</tr>
<tr id="value-tcpSocket" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">tcpSocket</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>TCP Socket probe.</td>
</tr>
<tr id="value-grpc" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">grpc</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>gRPC probe.</td>
</tr>
<tr id="value-readinessProbe" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">readinessProbe</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>See below</code></td>
<td>Readiness probe.</td>
</tr>
<tr id="value-enabled" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable Readiness probe.</td>
</tr>
<tr id="value-failureThreshold" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">failureThreshold</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>30</code></td>
<td>Number of retries before marking the pod as failed.</td>
</tr>
<tr id="value-periodSeconds" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">periodSeconds</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>10</code></td>
<td>Time between retries.</td>
</tr>
<tr id="value-successThreshold" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">successThreshold</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Number of successful probes before marking the pod as ready.</td>
</tr>
<tr id="value-timeoutSeconds" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">timeoutSeconds</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Time before the probe times out.</td>
</tr>
<tr id="value-httpGet" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">httpGet</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>HTTP Get probe.</td>
</tr>
<tr id="value-exec" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">exec</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Exec probe.</td>
</tr>
<tr id="value-tcpSocket" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">tcpSocket</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>TCP Socket probe.</td>
</tr>
<tr id="value-grpc" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">grpc</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>gRPC probe.</td>
</tr>
<tr id="value-livenessProbe" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">livenessProbe</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>See below</code></td>
<td>Liveness probe.</td>
</tr>
<tr id="value-enabled" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable Liveness probe.</td>
</tr>
<tr id="value-failureThreshold" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">failureThreshold</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>30</code></td>
<td>Number of retries before marking the pod as failed.</td>
</tr>
<tr id="value-periodSeconds" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">periodSeconds</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>10</code></td>
<td>Time between retries.</td>
</tr>
<tr id="value-successThreshold" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">successThreshold</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Number of successful probes before marking the pod as ready.</td>
</tr>
<tr id="value-timeoutSeconds" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">timeoutSeconds</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Time before the probe times out.</td>
</tr>
<tr id="value-httpGet" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">httpGet</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>HTTP Get probe.</td>
</tr>
<tr id="value-exec" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">exec</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Exec probe.</td>
</tr>
<tr id="value-tcpSocket" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">tcpSocket</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>TCP Socket probe.</td>
</tr>
<tr id="value-grpc" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">grpc</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>gRPC probe.</td>
</tr>
<tr id="value-resources" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">resources</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Resource limits and requests for the pod.</td>
</tr>
<tr id="value-containerSecurityContext" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">containerSecurityContext</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Security Context at Container Level.</td>
</tr>
<tr id="value-enabled" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable [OpenShift OAuth Proxy](https://github.com/openshift/oauth-proxy).</td>
</tr>
<tr id="value-port" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">port</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>8080</code></td>
<td>Port on which application is running inside container.</td>
</tr>
<tr id="value-secretName" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">secretName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"openshift-oauth-proxy-tls"</code></td>
<td>Secret name for the OAuth Proxy TLS certificate.</td>
</tr>
<tr id="value-image" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">image</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>openshift/oauth-proxy:latest</code></td>
<td>Image for the OAuth Proxy.</td>
</tr>
<tr id="value-disableTLSArg" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">disableTLSArg</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>If disabled `--http-address=:8081` will be used instead of `--https-address=:8443`.</td>
</tr>
<tr id="value-securityContext" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">securityContext</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Security Context for the pod.</td>
</tr>
<tr id="value-command" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">command</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Command for the app container.</td>
</tr>
<tr id="value-args" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">args</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Args for the app container.</td>
</tr>
<tr id="value-ports" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">ports</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>List of ports for the app container.</td>
</tr>
<tr id="value-hostNetwork" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">hostNetwork</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>`nil`</code></td>
<td>Host network connectivity.</td>
</tr>
<tr id="value-terminationGracePeriodSeconds" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">terminationGracePeriodSeconds</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>`nil`</code></td>
<td>Gracefull termination period.</td>
</tr>
<tr id="value-lifecycle" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">lifecycle</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Lifecycle configuration for the pod.</td>
</tr>
<tr id="value-additionalContainers" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">additionalContainers</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Additional containers besides init and app containers (without templating).</td>
</tr>
<tr id="value-enabled" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable persistence.</td>
</tr>
<tr id="value-mountPVC" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">mountPVC</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Whether to mount the created PVC to the deployment.</td>
</tr>
<tr id="value-mountPath" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">mountPath</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"/"</code></td>
<td>If `persistence.mountPVC` is enabled, where to mount the volume in the containers.</td>
</tr>
<tr id="value-name" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">name</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`{{ include "application.name" $ }}-data`</code></td>
<td>Name of the PVC.</td>
</tr>
<tr id="value-accessMode" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">accessMode</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>ReadWriteOnce</code></td>
<td>Access mode for volume.</td>
</tr>
<tr id="value-storageClass" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">storageClass</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>null</code></td>
<td>Storage class for volume.</td>
</tr>
<tr id="value-additionalLabels" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for persistent volume.</td>
</tr>
<tr id="value-annotations" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for persistent volume.</td>
</tr>
<tr id="value-storageSize" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">storageSize</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>8Gi</code></td>
<td>Size of the persistent volume.</td>
</tr>
<tr id="value-volumeMode" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">volumeMode</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>PVC Volume Mode.</td>
</tr>
<tr id="value-volumeName" class="value-anchor" data-section="deployment-parameters">
<td><code class="value-key">volumeName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Name of the volume.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>EndpointMonitor Parameters</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="endpointmonitor-parameters">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy an [IMC EndpointMonitor](https://github.com/stakater/IngressMonitorController) resource.</td>
</tr>
<tr id="value-additionalLabels" class="value-anchor" data-section="endpointmonitor-parameters">
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for EndpointMonitor.</td>
</tr>
<tr id="value-annotations" class="value-anchor" data-section="endpointmonitor-parameters">
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for EndpointMonitor.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>ExternalSecret Parameters</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="externalsecret-parameters">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy [ExternalSecret](https://external-secrets.io/latest/) resources.</td>
</tr>
<tr id="value-additionalLabels" class="value-anchor" data-section="externalsecret-parameters">
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for ExternalSecret.</td>
</tr>
<tr id="value-annotations" class="value-anchor" data-section="externalsecret-parameters">
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for ExternalSecret.</td>
</tr>
<tr id="value-secretStore" class="value-anchor" data-section="externalsecret-parameters">
<td><code class="value-key">secretStore</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Default values for the SecretStore.</td>
</tr>
<tr id="value-name" class="value-anchor" data-section="externalsecret-parameters">
<td><code class="value-key">name</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>tenant-vault-secret-store</code></td>
<td>Name of the SecretStore to use.</td>
</tr>
<tr id="value-kind" class="value-anchor" data-section="externalsecret-parameters">
<td><code class="value-key">kind</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>SecretStore</code></td>
<td>Kind of the SecretStore being refered to.</td>
</tr>
<tr id="value-refreshInterval" class="value-anchor" data-section="externalsecret-parameters">
<td><code class="value-key">refreshInterval</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"1m"</code></td>
<td>RefreshInterval is the amount of time before the values are read again from the SecretStore provider.</td>
</tr>
<tr id="value-files" class="value-anchor" data-section="externalsecret-parameters">
<td><code class="value-key">files</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>List of ExternalSecret entries.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>ForecastleApp Parameters</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="forecastleapp-parameters">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy a [ForecastleApp](https://github.com/stakater/Forecastle) resource.</td>
</tr>
<tr id="value-additionalLabels" class="value-anchor" data-section="forecastleapp-parameters">
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for ForecastleApp.</td>
</tr>
<tr id="value-icon" class="value-anchor" data-section="forecastleapp-parameters">
<td><code class="value-key">icon</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>https://raw.githubusercontent.com/stakater/ForecastleIcons/master/stakater-big.png</code></td>
<td>Icon URL.</td>
</tr>
<tr id="value-displayName" class="value-anchor" data-section="forecastleapp-parameters">
<td><code class="value-key">displayName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Application Name.</td>
</tr>
<tr id="value-group" class="value-anchor" data-section="forecastleapp-parameters">
<td><code class="value-key">group</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`{{ .Release.Namespace }}`</code></td>
<td>Application Group.</td>
</tr>
<tr id="value-properties" class="value-anchor" data-section="forecastleapp-parameters">
<td><code class="value-key">properties</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Custom properties.</td>
</tr>
<tr id="value-networkRestricted" class="value-anchor" data-section="forecastleapp-parameters">
<td><code class="value-key">networkRestricted</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Is application network restricted?.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>GrafanaDashboard Parameters</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="grafanadashboard-parameters">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy [GrafanaDashboard](https://github.com/grafana/grafana-operator) resources.</td>
</tr>
<tr id="value-additionalLabels" class="value-anchor" data-section="grafanadashboard-parameters">
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for GrafanaDashboard.</td>
</tr>
<tr id="value-annotations" class="value-anchor" data-section="grafanadashboard-parameters">
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for GrafanaDashboard.</td>
</tr>
<tr id="value-contents" class="value-anchor" data-section="grafanadashboard-parameters">
<td><code class="value-key">contents</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>List of GrafanaDashboard entries.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Ingress Parameters</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="ingress-parameters">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable Ingress.</td>
</tr>
<tr id="value-ingressClassName" class="value-anchor" data-section="ingress-parameters">
<td><code class="value-key">ingressClassName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Name of the ingress class.</td>
</tr>
<tr id="value-pathType" class="value-anchor" data-section="ingress-parameters">
<td><code class="value-key">pathType</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`ImplementationSpecific`</code></td>
<td>Path type.</td>
</tr>
<tr id="value-serviceName" class="value-anchor" data-section="ingress-parameters">
<td><code class="value-key">serviceName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`{{ include "application.name" $ }}`</code></td>
<td>Service name.</td>
</tr>
<tr id="value-servicePort" class="value-anchor" data-section="ingress-parameters">
<td><code class="value-key">servicePort</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`http`</code></td>
<td>Service port.</td>
</tr>
<tr id="value-additionalLabels" class="value-anchor" data-section="ingress-parameters">
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for ingress.</td>
</tr>
<tr id="value-annotations" class="value-anchor" data-section="ingress-parameters">
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for ingress.</td>
</tr>
<tr id="value-tls" class="value-anchor" data-section="ingress-parameters">
<td><code class="value-key">tls</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>TLS configuration for ingress.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Job Parameters</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="job-parameters">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy Job resources.</td>
</tr>
<tr id="value-jobs" class="value-anchor" data-section="job-parameters">
<td><code class="value-key">jobs</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Map of Job resources.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>NetworkPolicy Parameters</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="networkpolicy-parameters">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable Network Policy.</td>
</tr>
<tr id="value-additionalLabels" class="value-anchor" data-section="networkpolicy-parameters">
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for Network Policy.</td>
</tr>
<tr id="value-annotations" class="value-anchor" data-section="networkpolicy-parameters">
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for Network Policy.</td>
</tr>
<tr id="value-ingress" class="value-anchor" data-section="networkpolicy-parameters">
<td><code class="value-key">ingress</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Ingress rules for Network Policy.</td>
</tr>
<tr id="value-egress" class="value-anchor" data-section="networkpolicy-parameters">
<td><code class="value-key">egress</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Egress rules for Network Policy.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Parameters</strong></td></tr>
<tr id="value-namespaceOverride" class="value-anchor" data-section="parameters">
<td><code class="value-key">namespaceOverride</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Override the namespace for all resources.</td>
</tr>
<tr id="value-componentOverride" class="value-anchor" data-section="parameters">
<td><code class="value-key">componentOverride</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Override the component label for all resources.</td>
</tr>
<tr id="value-partOfOverride" class="value-anchor" data-section="parameters">
<td><code class="value-key">partOfOverride</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Override the partOf label for all resources.</td>
</tr>
<tr id="value-applicationName" class="value-anchor" data-section="parameters">
<td><code class="value-key">applicationName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`{{ .Chart.Name }}`</code></td>
<td>Application name.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>PodDisruptionBudget Parameters</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="poddisruptionbudget-parameters">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable Pod Disruption Budget.</td>
</tr>
<tr id="value-minAvailable" class="value-anchor" data-section="poddisruptionbudget-parameters">
<td><code class="value-key">minAvailable</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Minimum number of pods that must be available after eviction.</td>
</tr>
<tr id="value-maxUnavailable" class="value-anchor" data-section="poddisruptionbudget-parameters">
<td><code class="value-key">maxUnavailable</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>`nil`</code></td>
<td>Maximum number of unavailable pods during voluntary disruptions.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>PrometheusRule Parameters</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="prometheusrule-parameters">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy a PrometheusRule (Prometheus Operator) resource.</td>
</tr>
<tr id="value-additionalLabels" class="value-anchor" data-section="prometheusrule-parameters">
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for PrometheusRule.</td>
</tr>
<tr id="value-groups" class="value-anchor" data-section="prometheusrule-parameters">
<td><code class="value-key">groups</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Groups with alerting rules.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>RBAC Parameters</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="rbac-parameters">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Enable RBAC.</td>
</tr>
<tr id="value-enabled" class="value-anchor" data-section="rbac-parameters">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy Service Account.</td>
</tr>
<tr id="value-name" class="value-anchor" data-section="rbac-parameters">
<td><code class="value-key">name</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`{{ include "application.name" $ }}`</code></td>
<td>Service Account Name.</td>
</tr>
<tr id="value-additionalLabels" class="value-anchor" data-section="rbac-parameters">
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for Service Account.</td>
</tr>
<tr id="value-annotations" class="value-anchor" data-section="rbac-parameters">
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for Service Account.</td>
</tr>
<tr id="value-roles" class="value-anchor" data-section="rbac-parameters">
<td><code class="value-key">roles</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Namespaced Roles.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Route Parameters</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="route-parameters">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy a Route (OpenShift) resource.</td>
</tr>
<tr id="value-additionalLabels" class="value-anchor" data-section="route-parameters">
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for Route.</td>
</tr>
<tr id="value-annotations" class="value-anchor" data-section="route-parameters">
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for Route.</td>
</tr>
<tr id="value-host" class="value-anchor" data-section="route-parameters">
<td><code class="value-key">host</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Explicit host.</td>
</tr>
<tr id="value-path" class="value-anchor" data-section="route-parameters">
<td><code class="value-key">path</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Path.</td>
</tr>
<tr id="value-port" class="value-anchor" data-section="route-parameters">
<td><code class="value-key">port</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Service port.</td>
</tr>
<tr id="value-weight" class="value-anchor" data-section="route-parameters">
<td><code class="value-key">weight</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>100</code></td>
<td>Service weight.</td>
</tr>
<tr id="value-wildcardPolicy" class="value-anchor" data-section="route-parameters">
<td><code class="value-key">wildcardPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>None</code></td>
<td>Wildcard policy.</td>
</tr>
<tr id="value-termination" class="value-anchor" data-section="route-parameters">
<td><code class="value-key">termination</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>edge</code></td>
<td>TLS termination strategy.</td>
</tr>
<tr id="value-insecureEdgeTerminationPolicy" class="value-anchor" data-section="route-parameters">
<td><code class="value-key">insecureEdgeTerminationPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>Redirect</code></td>
<td>TLS insecure termination policy.</td>
</tr>
<tr id="value-alternateBackends" class="value-anchor" data-section="route-parameters">
<td><code class="value-key">alternateBackends</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Alternate backend with it's weight.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>SealedSecret Parameters</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="sealedsecret-parameters">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy [SealedSecret](https://github.com/bitnami-labs/sealed-secrets) resources.</td>
</tr>
<tr id="value-additionalLabels" class="value-anchor" data-section="sealedsecret-parameters">
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for SealedSecret.</td>
</tr>
<tr id="value-annotations" class="value-anchor" data-section="sealedsecret-parameters">
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for SealedSecret.</td>
</tr>
<tr id="value-files" class="value-anchor" data-section="sealedsecret-parameters">
<td><code class="value-key">files</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>List of SealedSecret entries.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Secret Parameters</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="secret-parameters">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy additional Secret resources.</td>
</tr>
<tr id="value-additionalLabels" class="value-anchor" data-section="secret-parameters">
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for Secret.</td>
</tr>
<tr id="value-annotations" class="value-anchor" data-section="secret-parameters">
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for Secret.</td>
</tr>
<tr id="value-files" class="value-anchor" data-section="secret-parameters">
<td><code class="value-key">files</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>List of Secrets entries.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>SecretProviderClass Parameters</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="secretproviderclass-parameters">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy a [Secrets Store CSI Driver SecretProviderClass](https://secrets-store-csi-driver.sigs.k8s.io/) resource.</td>
</tr>
<tr id="value-name" class="value-anchor" data-section="secretproviderclass-parameters">
<td><code class="value-key">name</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Name of the SecretProviderClass.</td>
</tr>
<tr id="value-provider" class="value-anchor" data-section="secretproviderclass-parameters">
<td><code class="value-key">provider</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Name of the provider.</td>
</tr>
<tr id="value-vaultAddress" class="value-anchor" data-section="secretproviderclass-parameters">
<td><code class="value-key">vaultAddress</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Vault Address.</td>
</tr>
<tr id="value-roleName" class="value-anchor" data-section="secretproviderclass-parameters">
<td><code class="value-key">roleName</code></td>
<td><span class="type-badge tpl">tpl/string</span></td>
<td><code>""</code></td>
<td>Vault Role Name.</td>
</tr>
<tr id="value-objects" class="value-anchor" data-section="secretproviderclass-parameters">
<td><code class="value-key">objects</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Objects definitions.</td>
</tr>
<tr id="value-secretObjects" class="value-anchor" data-section="secretproviderclass-parameters">
<td><code class="value-key">secretObjects</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Objects mapping.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Service Parameters</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="service-parameters">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Enable Service.</td>
</tr>
<tr id="value-additionalLabels" class="value-anchor" data-section="service-parameters">
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for service.</td>
</tr>
<tr id="value-annotations" class="value-anchor" data-section="service-parameters">
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for service.</td>
</tr>
<tr id="value-ports" class="value-anchor" data-section="service-parameters">
<td><code class="value-key">ports</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Ports for applications service.</td>
</tr>
<tr id="value-type" class="value-anchor" data-section="service-parameters">
<td><code class="value-key">type</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>ClusterIP</code></td>
<td>Type of service.</td>
</tr>
<tr id="value-clusterIP" class="value-anchor" data-section="service-parameters">
<td><code class="value-key">clusterIP</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Fixed IP for a ClusterIP service.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>ServiceMonitor Parameters</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="servicemonitor-parameters">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy a ServiceMonitor (Prometheus Operator) resource.</td>
</tr>
<tr id="value-additionalLabels" class="value-anchor" data-section="servicemonitor-parameters">
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for ServiceMonitor.</td>
</tr>
<tr id="value-annotations" class="value-anchor" data-section="servicemonitor-parameters">
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for ServiceMonitor.</td>
</tr>
<tr id="value-endpoints" class="value-anchor" data-section="servicemonitor-parameters">
<td><code class="value-key">endpoints</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Service endpoints from which prometheus will scrape data.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>VPA - Vertical Pod Autoscaler Parameters</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="vpa---vertical-pod-autoscaler-parameters">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable Vertical Pod Autoscaling.</td>
</tr>
<tr id="value-additionalLabels" class="value-anchor" data-section="vpa---vertical-pod-autoscaler-parameters">
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for VPA.</td>
</tr>
<tr id="value-annotations" class="value-anchor" data-section="vpa---vertical-pod-autoscaler-parameters">
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for VPA.</td>
</tr>
<tr id="value-containerPolicies" class="value-anchor" data-section="vpa---vertical-pod-autoscaler-parameters">
<td><code class="value-key">containerPolicies</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Container policies for individual containers.</td>
</tr>
<tr id="value-updatePolicy" class="value-anchor" data-section="vpa---vertical-pod-autoscaler-parameters">
<td><code class="value-key">updatePolicy</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Update policy.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>cert-manager Certificate Parameters</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="cert-manager-certificate-parameters">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy a [cert-manager Certificate](https://cert-manager.io) resource.</td>
</tr>
<tr id="value-additionalLabels" class="value-anchor" data-section="cert-manager-certificate-parameters">
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for Certificate.</td>
</tr>
<tr id="value-annotations" class="value-anchor" data-section="cert-manager-certificate-parameters">
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for Certificate.</td>
</tr>
<tr id="value-secretName" class="value-anchor" data-section="cert-manager-certificate-parameters">
<td><code class="value-key">secretName</code></td>
<td><span class="type-badge tpl">tpl/string</span></td>
<td><code>tls-cert</code></td>
<td>Name of the secret resource that will be automatically created and managed by this Certificate resource.</td>
</tr>
<tr id="value-duration" class="value-anchor" data-section="cert-manager-certificate-parameters">
<td><code class="value-key">duration</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>8760h0m0s # 1 year</code></td>
<td>The requested "duration" (i.e. lifetime) of the Certificate.</td>
</tr>
<tr id="value-renewBefore" class="value-anchor" data-section="cert-manager-certificate-parameters">
<td><code class="value-key">renewBefore</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>720h0m0s # 30d</code></td>
<td>The amount of time before the currently issued certificate's notAfter time that cert-manager will begin to attempt to renew the certificate.</td>
</tr>
<tr id="value-subject" class="value-anchor" data-section="cert-manager-certificate-parameters">
<td><code class="value-key">subject</code></td>
<td><span class="type-badge tpl">tpl/object</span></td>
<td><code>`nil`</code></td>
<td>Full X509 name specification for certificate.</td>
</tr>
<tr id="value-commonName" class="value-anchor" data-section="cert-manager-certificate-parameters">
<td><code class="value-key">commonName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>admin-app</code></td>
<td>Common name as specified on the DER encoded CSR.</td>
</tr>
<tr id="value-keyAlgorithm" class="value-anchor" data-section="cert-manager-certificate-parameters">
<td><code class="value-key">keyAlgorithm</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>rsa</code></td>
<td>Private key algorithm of the corresponding private key for this certificate.</td>
</tr>
<tr id="value-keyEncoding" class="value-anchor" data-section="cert-manager-certificate-parameters">
<td><code class="value-key">keyEncoding</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>pkcs1</code></td>
<td>Private key cryptography standards (PKCS) for this certificate's private key to be encoded in.</td>
</tr>
<tr id="value-keySize" class="value-anchor" data-section="cert-manager-certificate-parameters">
<td><code class="value-key">keySize</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>2048</code></td>
<td>Key bit size of the corresponding private key for this certificate.</td>
</tr>
<tr id="value-isCA" class="value-anchor" data-section="cert-manager-certificate-parameters">
<td><code class="value-key">isCA</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Mark this Certificate as valid for certificate signing.</td>
</tr>
<tr id="value-usages" class="value-anchor" data-section="cert-manager-certificate-parameters">
<td><code class="value-key">usages</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Set of x509 usages that are requested for the certificate.</td>
</tr>
<tr id="value-dnsNames" class="value-anchor" data-section="cert-manager-certificate-parameters">
<td><code class="value-key">dnsNames</code></td>
<td><span class="type-badge tpl">tpl/list</span></td>
<td><code>`nil`</code></td>
<td>List of DNS subjectAltNames to be set on the certificate.</td>
</tr>
<tr id="value-ipAddresses" class="value-anchor" data-section="cert-manager-certificate-parameters">
<td><code class="value-key">ipAddresses</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>List of IP address subjectAltNames to be set on the certificate.</td>
</tr>
<tr id="value-uriSANs" class="value-anchor" data-section="cert-manager-certificate-parameters">
<td><code class="value-key">uriSANs</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>List of URI subjectAltNames to be set on the certificate.</td>
</tr>
<tr id="value-emailSANs" class="value-anchor" data-section="cert-manager-certificate-parameters">
<td><code class="value-key">emailSANs</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>List of email subjectAltNames to be set on the Certificate.</td>
</tr>
<tr id="value-enabled" class="value-anchor" data-section="cert-manager-certificate-parameters">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable Private Key for the certificate.</td>
</tr>
<tr id="value-rotationPolicy" class="value-anchor" data-section="cert-manager-certificate-parameters">
<td><code class="value-key">rotationPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>Always</code></td>
<td>Denotes how private keys should be generated or sourced when a certificate is being issued.</td>
</tr>
<tr id="value-name" class="value-anchor" data-section="cert-manager-certificate-parameters">
<td><code class="value-key">name</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>ca-issuer</code></td>
<td>Reference to the issuer for this certificate.</td>
</tr>
<tr id="value-kind" class="value-anchor" data-section="cert-manager-certificate-parameters">
<td><code class="value-key">kind</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>ClusterIssuer</code></td>
<td>Kind of the issuer being referred to.</td>
</tr>
<tr id="value-group" class="value-anchor" data-section="cert-manager-certificate-parameters">
<td><code class="value-key">group</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>cert-manager.io</code></td>
<td>Group of the issuer resource being refered to.</td>
</tr>
<tr id="value-enabled" class="value-anchor" data-section="cert-manager-certificate-parameters">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enables keystore configuration.</td>
</tr>
<tr id="value-create" class="value-anchor" data-section="cert-manager-certificate-parameters">
<td><code class="value-key">create</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Enables PKCS12 keystore creation for the Certificate.</td>
</tr>
<tr id="value-key" class="value-anchor" data-section="cert-manager-certificate-parameters">
<td><code class="value-key">key</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>test_key</code></td>
<td>Key of the entry in the Secret resource's data field to be used.</td>
</tr>
<tr id="value-name" class="value-anchor" data-section="cert-manager-certificate-parameters">
<td><code class="value-key">name</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>test-creds</code></td>
<td>Name of the Secret resource being referred to.</td>
</tr>
<tr id="value-create" class="value-anchor" data-section="cert-manager-certificate-parameters">
<td><code class="value-key">create</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enables jks keystore creation for the Certificate.</td>
</tr>
<tr id="value-key" class="value-anchor" data-section="cert-manager-certificate-parameters">
<td><code class="value-key">key</code></td>
<td><span class="type-badge tpl">tpl/string</span></td>
<td><code>test_key</code></td>
<td>Key of the entry in the Secret resource's data field to be used.</td>
</tr>
<tr id="value-name" class="value-anchor" data-section="cert-manager-certificate-parameters">
<td><code class="value-key">name</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>test-creds</code></td>
<td>Name of the Secret resource being referred to.</td>
</tr>
</tbody>
</table>

---

_Autogenerated from chart metadata using [helm-docs](https://github.com/norwoodj/helm-docs)_
