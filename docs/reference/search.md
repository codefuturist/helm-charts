---
tags:
  - reference
  - search
---

# Values Search

Search across all chart values in this repository.

!!! tip "Keyboard Shortcuts" - ++ctrl+k++ or ++cmd+k++ - Focus search - ++escape++ - Clear search - Click 🔗 to copy direct link to a value

<input type="text" id="values-search" placeholder="🔍 Search all values... (e.g., 'replicas', 'image.tag', 'enabled')" autofocus />

<div class="filter-buttons">
  <button class="filter-btn" data-section="application">application</button>
  <button class="filter-btn" data-section="bitwarden-eso-provider">bitwarden-eso-provider</button>
  <button class="filter-btn" data-section="compass-web">compass-web</button>
  <button class="filter-btn" data-section="homarr">homarr</button>
  <button class="filter-btn" data-section="home-assistant">home-assistant</button>
  <button class="filter-btn" data-section="it-tools">it-tools</button>
  <button class="filter-btn" data-section="nginx">nginx</button>
  <button class="filter-btn" data-section="pgadmin">pgadmin</button>
  <button class="filter-btn" data-section="proxmox-backup-server">proxmox-backup-server</button>
  <button class="filter-btn" data-section="redisinsight">redisinsight</button>
  <button class="filter-btn" data-section="restic-backup">restic-backup</button>
  <button class="filter-btn" data-section="semaphore">semaphore</button>
  <button class="filter-btn" data-section="shlink">shlink</button>
  <button class="filter-btn" data-section="test-final">test-final</button>
  <button class="filter-btn active" data-section="">All Charts</button>
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
<tr id="application-value-namespaceOverride" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-namespaceOverride">application</a></td>
<td><code class="value-key">namespaceOverride</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Override the namespace for all resources.</td>
</tr>
<tr id="application-value-componentOverride" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-componentOverride">application</a></td>
<td><code class="value-key">componentOverride</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Override the component label for all resources.</td>
</tr>
<tr id="application-value-partOfOverride" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-partOfOverride">application</a></td>
<td><code class="value-key">partOfOverride</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Override the partOf label for all resources.</td>
</tr>
<tr id="application-value-applicationName" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-applicationName">application</a></td>
<td><code class="value-key">applicationName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`{{ .Chart.Name }}`</code></td>
<td>Application name.</td>
</tr>
<tr id="application-value-additionalLabels" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-additionalLabels">application</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge tpl">tpl/object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for all resources.</td>
</tr>
<tr id="application-value-enabled" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-enabled">application</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy CronJob resources.</td>
</tr>
<tr id="application-value-jobs" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-jobs">application</a></td>
<td><code class="value-key">jobs</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Map of CronJob resources.</td>
</tr>
<tr id="application-value-enabled" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-enabled">application</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy Job resources.</td>
</tr>
<tr id="application-value-jobs" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-jobs">application</a></td>
<td><code class="value-key">jobs</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Map of Job resources.</td>
</tr>
<tr id="application-value-enabled" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-enabled">application</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Enable Deployment.</td>
</tr>
<tr id="application-value-additionalLabels" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-additionalLabels">application</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for Deployment.</td>
</tr>
<tr id="application-value-podLabels" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-podLabels">application</a></td>
<td><code class="value-key">podLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional pod labels which are used in Service's Label Selector.</td>
</tr>
<tr id="application-value-annotations" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-annotations">application</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for Deployment.</td>
</tr>
<tr id="application-value-additionalPodAnnotations" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-additionalPodAnnotations">application</a></td>
<td><code class="value-key">additionalPodAnnotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional pod annotations.</td>
</tr>
<tr id="application-value-type" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-type">application</a></td>
<td><code class="value-key">type</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>RollingUpdate</code></td>
<td>Type of deployment strategy.</td>
</tr>
<tr id="application-value-reloadOnChange" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-reloadOnChange">application</a></td>
<td><code class="value-key">reloadOnChange</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Reload deployment if attached Secret/ConfigMap changes.</td>
</tr>
<tr id="application-value-nodeSelector" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-nodeSelector">application</a></td>
<td><code class="value-key">nodeSelector</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Select the node where the pods should be scheduled.</td>
</tr>
<tr id="application-value-hostAliases" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-hostAliases">application</a></td>
<td><code class="value-key">hostAliases</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Mapping between IP and hostnames that will be injected as entries in the pod's hosts files.</td>
</tr>
<tr id="application-value-initContainers" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-initContainers">application</a></td>
<td><code class="value-key">initContainers</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Add init containers to the pods.</td>
</tr>
<tr id="application-value-fluentdConfigAnnotations" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-fluentdConfigAnnotations">application</a></td>
<td><code class="value-key">fluentdConfigAnnotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Configuration details for fluentdConfigurations.</td>
</tr>
<tr id="application-value-replicas" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-replicas">application</a></td>
<td><code class="value-key">replicas</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>`nil`</code></td>
<td>Number of replicas.</td>
</tr>
<tr id="application-value-imagePullSecrets" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-imagePullSecrets">application</a></td>
<td><code class="value-key">imagePullSecrets</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>List of secrets to be used for pulling the images.</td>
</tr>
<tr id="application-value-envFrom" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-envFrom">application</a></td>
<td><code class="value-key">envFrom</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Mount environment variables from ConfigMap or Secret to the pod. See the README "Consuming environment variable in application chart" section for more details.</td>
</tr>
<tr id="application-value-env" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-env">application</a></td>
<td><code class="value-key">env</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Environment variables to be added to the pod. See the README "Consuming environment variable in application chart" section for more details.</td>
</tr>
<tr id="application-value-volumes" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-volumes">application</a></td>
<td><code class="value-key">volumes</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Volumes to be added to the pod.</td>
</tr>
<tr id="application-value-volumeMounts" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-volumeMounts">application</a></td>
<td><code class="value-key">volumeMounts</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Mount path for Volumes.</td>
</tr>
<tr id="application-value-priorityClassName" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-priorityClassName">application</a></td>
<td><code class="value-key">priorityClassName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Define the priority class for the pod.</td>
</tr>
<tr id="application-value-runtimeClassName" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-runtimeClassName">application</a></td>
<td><code class="value-key">runtimeClassName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Set the runtimeClassName for the deployment's pods.</td>
</tr>
<tr id="application-value-tolerations" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-tolerations">application</a></td>
<td><code class="value-key">tolerations</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Taint tolerations for the pods.</td>
</tr>
<tr id="application-value-affinity" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-affinity">application</a></td>
<td><code class="value-key">affinity</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Affinity for the pods.</td>
</tr>
<tr id="application-value-topologySpreadConstraints" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-topologySpreadConstraints">application</a></td>
<td><code class="value-key">topologySpreadConstraints</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Topology spread constraints for the pods.</td>
</tr>
<tr id="application-value-revisionHistoryLimit" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-revisionHistoryLimit">application</a></td>
<td><code class="value-key">revisionHistoryLimit</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>2</code></td>
<td>Number of ReplicaSet revisions to retain.</td>
</tr>
<tr id="application-value-repository" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-repository">application</a></td>
<td><code class="value-key">repository</code></td>
<td><span class="type-badge tpl">tpl/string</span></td>
<td><code>""</code></td>
<td>Repository.</td>
</tr>
<tr id="application-value-tag" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-tag">application</a></td>
<td><code class="value-key">tag</code></td>
<td><span class="type-badge tpl">tpl/string</span></td>
<td><code>""</code></td>
<td>Tag.</td>
</tr>
<tr id="application-value-digest" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-digest">application</a></td>
<td><code class="value-key">digest</code></td>
<td><span class="type-badge tpl">tpl/string</span></td>
<td><code>""</code></td>
<td>Image digest. If resolved to a non-empty value, digest takes precedence on the tag.</td>
</tr>
<tr id="application-value-pullPolicy" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-pullPolicy">application</a></td>
<td><code class="value-key">pullPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>IfNotPresent</code></td>
<td>Image pull policy.</td>
</tr>
<tr id="application-value-dnsConfig" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-dnsConfig">application</a></td>
<td><code class="value-key">dnsConfig</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>DNS config for the pods.</td>
</tr>
<tr id="application-value-dnsPolicy" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-dnsPolicy">application</a></td>
<td><code class="value-key">dnsPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>DNS Policy.</td>
</tr>
<tr id="application-value-startupProbe" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-startupProbe">application</a></td>
<td><code class="value-key">startupProbe</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>See below</code></td>
<td>Startup probe.</td>
</tr>
<tr id="application-value-enabled" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-enabled">application</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable Startup probe.</td>
</tr>
<tr id="application-value-failureThreshold" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-failureThreshold">application</a></td>
<td><code class="value-key">failureThreshold</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>30</code></td>
<td>Number of retries before marking the pod as failed.</td>
</tr>
<tr id="application-value-periodSeconds" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-periodSeconds">application</a></td>
<td><code class="value-key">periodSeconds</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>10</code></td>
<td>Time between retries.</td>
</tr>
<tr id="application-value-successThreshold" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-successThreshold">application</a></td>
<td><code class="value-key">successThreshold</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Number of successful probes before marking the pod as ready.</td>
</tr>
<tr id="application-value-timeoutSeconds" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-timeoutSeconds">application</a></td>
<td><code class="value-key">timeoutSeconds</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Time before the probe times out.</td>
</tr>
<tr id="application-value-httpGet" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-httpGet">application</a></td>
<td><code class="value-key">httpGet</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>HTTP Get probe.</td>
</tr>
<tr id="application-value-exec" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-exec">application</a></td>
<td><code class="value-key">exec</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Exec probe.</td>
</tr>
<tr id="application-value-tcpSocket" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-tcpSocket">application</a></td>
<td><code class="value-key">tcpSocket</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>TCP Socket probe.</td>
</tr>
<tr id="application-value-grpc" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-grpc">application</a></td>
<td><code class="value-key">grpc</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>gRPC probe.</td>
</tr>
<tr id="application-value-readinessProbe" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-readinessProbe">application</a></td>
<td><code class="value-key">readinessProbe</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>See below</code></td>
<td>Readiness probe.</td>
</tr>
<tr id="application-value-enabled" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-enabled">application</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable Readiness probe.</td>
</tr>
<tr id="application-value-failureThreshold" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-failureThreshold">application</a></td>
<td><code class="value-key">failureThreshold</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>30</code></td>
<td>Number of retries before marking the pod as failed.</td>
</tr>
<tr id="application-value-periodSeconds" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-periodSeconds">application</a></td>
<td><code class="value-key">periodSeconds</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>10</code></td>
<td>Time between retries.</td>
</tr>
<tr id="application-value-successThreshold" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-successThreshold">application</a></td>
<td><code class="value-key">successThreshold</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Number of successful probes before marking the pod as ready.</td>
</tr>
<tr id="application-value-timeoutSeconds" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-timeoutSeconds">application</a></td>
<td><code class="value-key">timeoutSeconds</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Time before the probe times out.</td>
</tr>
<tr id="application-value-httpGet" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-httpGet">application</a></td>
<td><code class="value-key">httpGet</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>HTTP Get probe.</td>
</tr>
<tr id="application-value-exec" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-exec">application</a></td>
<td><code class="value-key">exec</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Exec probe.</td>
</tr>
<tr id="application-value-tcpSocket" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-tcpSocket">application</a></td>
<td><code class="value-key">tcpSocket</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>TCP Socket probe.</td>
</tr>
<tr id="application-value-grpc" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-grpc">application</a></td>
<td><code class="value-key">grpc</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>gRPC probe.</td>
</tr>
<tr id="application-value-livenessProbe" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-livenessProbe">application</a></td>
<td><code class="value-key">livenessProbe</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>See below</code></td>
<td>Liveness probe.</td>
</tr>
<tr id="application-value-enabled" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-enabled">application</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable Liveness probe.</td>
</tr>
<tr id="application-value-failureThreshold" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-failureThreshold">application</a></td>
<td><code class="value-key">failureThreshold</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>30</code></td>
<td>Number of retries before marking the pod as failed.</td>
</tr>
<tr id="application-value-periodSeconds" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-periodSeconds">application</a></td>
<td><code class="value-key">periodSeconds</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>10</code></td>
<td>Time between retries.</td>
</tr>
<tr id="application-value-successThreshold" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-successThreshold">application</a></td>
<td><code class="value-key">successThreshold</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Number of successful probes before marking the pod as ready.</td>
</tr>
<tr id="application-value-timeoutSeconds" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-timeoutSeconds">application</a></td>
<td><code class="value-key">timeoutSeconds</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Time before the probe times out.</td>
</tr>
<tr id="application-value-httpGet" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-httpGet">application</a></td>
<td><code class="value-key">httpGet</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>HTTP Get probe.</td>
</tr>
<tr id="application-value-exec" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-exec">application</a></td>
<td><code class="value-key">exec</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Exec probe.</td>
</tr>
<tr id="application-value-tcpSocket" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-tcpSocket">application</a></td>
<td><code class="value-key">tcpSocket</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>TCP Socket probe.</td>
</tr>
<tr id="application-value-grpc" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-grpc">application</a></td>
<td><code class="value-key">grpc</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>gRPC probe.</td>
</tr>
<tr id="application-value-resources" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-resources">application</a></td>
<td><code class="value-key">resources</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Resource limits and requests for the pod.</td>
</tr>
<tr id="application-value-containerSecurityContext" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-containerSecurityContext">application</a></td>
<td><code class="value-key">containerSecurityContext</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Security Context at Container Level.</td>
</tr>
<tr id="application-value-enabled" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-enabled">application</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable [OpenShift OAuth Proxy](https://github.com/openshift/oauth-proxy).</td>
</tr>
<tr id="application-value-port" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-port">application</a></td>
<td><code class="value-key">port</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>8080</code></td>
<td>Port on which application is running inside container.</td>
</tr>
<tr id="application-value-secretName" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-secretName">application</a></td>
<td><code class="value-key">secretName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"openshift-oauth-proxy-tls"</code></td>
<td>Secret name for the OAuth Proxy TLS certificate.</td>
</tr>
<tr id="application-value-image" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-image">application</a></td>
<td><code class="value-key">image</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>openshift/oauth-proxy:latest</code></td>
<td>Image for the OAuth Proxy.</td>
</tr>
<tr id="application-value-disableTLSArg" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-disableTLSArg">application</a></td>
<td><code class="value-key">disableTLSArg</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>If disabled `--http-address=:8081` will be used instead of `--https-address=:8443`.</td>
</tr>
<tr id="application-value-securityContext" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-securityContext">application</a></td>
<td><code class="value-key">securityContext</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Security Context for the pod.</td>
</tr>
<tr id="application-value-command" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-command">application</a></td>
<td><code class="value-key">command</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Command for the app container.</td>
</tr>
<tr id="application-value-args" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-args">application</a></td>
<td><code class="value-key">args</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Args for the app container.</td>
</tr>
<tr id="application-value-ports" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-ports">application</a></td>
<td><code class="value-key">ports</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>List of ports for the app container.</td>
</tr>
<tr id="application-value-hostNetwork" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-hostNetwork">application</a></td>
<td><code class="value-key">hostNetwork</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>`nil`</code></td>
<td>Host network connectivity.</td>
</tr>
<tr id="application-value-terminationGracePeriodSeconds" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-terminationGracePeriodSeconds">application</a></td>
<td><code class="value-key">terminationGracePeriodSeconds</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>`nil`</code></td>
<td>Gracefull termination period.</td>
</tr>
<tr id="application-value-minReadySeconds" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-minReadySeconds">application</a></td>
<td><code class="value-key">minReadySeconds</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>`nil`</code></td>
<td>Minimum number of seconds for which a newly created Pod should be ready without any of its containers crashing.</td>
</tr>
<tr id="application-value-lifecycle" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-lifecycle">application</a></td>
<td><code class="value-key">lifecycle</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Lifecycle configuration for the pod.</td>
</tr>
<tr id="application-value-additionalContainers" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-additionalContainers">application</a></td>
<td><code class="value-key">additionalContainers</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Additional containers besides init and app containers (without templating).</td>
</tr>
<tr id="application-value-enabled" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-enabled">application</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable persistence.</td>
</tr>
<tr id="application-value-mountPVC" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-mountPVC">application</a></td>
<td><code class="value-key">mountPVC</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Whether to mount the created PVC to the deployment.</td>
</tr>
<tr id="application-value-mountPath" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-mountPath">application</a></td>
<td><code class="value-key">mountPath</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"/"</code></td>
<td>If `persistence.mountPVC` is enabled, where to mount the volume in the containers.</td>
</tr>
<tr id="application-value-name" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-name">application</a></td>
<td><code class="value-key">name</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`{{ include "application.name" $ }}-data`</code></td>
<td>Name of the PVC.</td>
</tr>
<tr id="application-value-accessMode" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-accessMode">application</a></td>
<td><code class="value-key">accessMode</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>ReadWriteOnce</code></td>
<td>Access mode for volume.</td>
</tr>
<tr id="application-value-storageClass" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-storageClass">application</a></td>
<td><code class="value-key">storageClass</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>null</code></td>
<td>Storage class for volume.</td>
</tr>
<tr id="application-value-additionalLabels" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-additionalLabels">application</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for persistent volume.</td>
</tr>
<tr id="application-value-annotations" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-annotations">application</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for persistent volume.</td>
</tr>
<tr id="application-value-storageSize" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-storageSize">application</a></td>
<td><code class="value-key">storageSize</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>8Gi</code></td>
<td>Size of the persistent volume.</td>
</tr>
<tr id="application-value-volumeMode" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-volumeMode">application</a></td>
<td><code class="value-key">volumeMode</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>PVC Volume Mode.</td>
</tr>
<tr id="application-value-volumeName" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-volumeName">application</a></td>
<td><code class="value-key">volumeName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Name of the volume.</td>
</tr>
<tr id="application-value-enabled" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-enabled">application</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Enable Service.</td>
</tr>
<tr id="application-value-additionalLabels" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-additionalLabels">application</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for service.</td>
</tr>
<tr id="application-value-annotations" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-annotations">application</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for service.</td>
</tr>
<tr id="application-value-ports" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-ports">application</a></td>
<td><code class="value-key">ports</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Ports for applications service.</td>
</tr>
<tr id="application-value-type" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-type">application</a></td>
<td><code class="value-key">type</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>ClusterIP</code></td>
<td>Type of service.</td>
</tr>
<tr id="application-value-clusterIP" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-clusterIP">application</a></td>
<td><code class="value-key">clusterIP</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Fixed IP for a ClusterIP service.</td>
</tr>
<tr id="application-value-loadBalancerClass" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-loadBalancerClass">application</a></td>
<td><code class="value-key">loadBalancerClass</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>LoadBalancer class name for LoadBalancer type services.</td>
</tr>
<tr id="application-value-enabled" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-enabled">application</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable Ingress.</td>
</tr>
<tr id="application-value-ingressClassName" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-ingressClassName">application</a></td>
<td><code class="value-key">ingressClassName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Name of the ingress class.</td>
</tr>
<tr id="application-value-pathType" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-pathType">application</a></td>
<td><code class="value-key">pathType</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`ImplementationSpecific`</code></td>
<td>Path type.</td>
</tr>
<tr id="application-value-serviceName" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-serviceName">application</a></td>
<td><code class="value-key">serviceName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`{{ include "application.name" $ }}`</code></td>
<td>Service name.</td>
</tr>
<tr id="application-value-servicePort" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-servicePort">application</a></td>
<td><code class="value-key">servicePort</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`http`</code></td>
<td>Service port.</td>
</tr>
<tr id="application-value-additionalLabels" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-additionalLabels">application</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for ingress.</td>
</tr>
<tr id="application-value-annotations" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-annotations">application</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for ingress.</td>
</tr>
<tr id="application-value-tls" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-tls">application</a></td>
<td><code class="value-key">tls</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>TLS configuration for ingress.</td>
</tr>
<tr id="application-value-enabled" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-enabled">application</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable HTTPRoute (Gateway API).</td>
</tr>
<tr id="application-value-parentRefs" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-parentRefs">application</a></td>
<td><code class="value-key">parentRefs</code></td>
<td><span class="type-badge tpl">tpl/list</span></td>
<td><code>`nil`</code></td>
<td>Parent references for the HTTPRoute.</td>
</tr>
<tr id="application-value-useDefaultGateways" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-useDefaultGateways">application</a></td>
<td><code class="value-key">useDefaultGateways</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>The default Gateway scope to use for this Route.</td>
</tr>
<tr id="application-value-gatewayNamespace" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-gatewayNamespace">application</a></td>
<td><code class="value-key">gatewayNamespace</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Namespace of the Gateway to attach this HTTPRoute to.</td>
</tr>
<tr id="application-value-hostnames" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-hostnames">application</a></td>
<td><code class="value-key">hostnames</code></td>
<td><span class="type-badge tpl">tpl/list</span></td>
<td><code>`nil`</code></td>
<td>Hostnames for the HTTPRoute.</td>
</tr>
<tr id="application-value-additionalLabels" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-additionalLabels">application</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional labels for HTTPRoute.</td>
</tr>
<tr id="application-value-annotations" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-annotations">application</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Annotations for HTTPRoute.</td>
</tr>
<tr id="application-value-rules" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-rules">application</a></td>
<td><code class="value-key">rules</code></td>
<td><span class="type-badge tpl">tpl/list</span></td>
<td><code>`nil`</code></td>
<td>Rules for HTTPRoute.</td>
</tr>
<tr id="application-value-enabled" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-enabled">application</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy a Route (OpenShift) resource.</td>
</tr>
<tr id="application-value-additionalLabels" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-additionalLabels">application</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for Route.</td>
</tr>
<tr id="application-value-annotations" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-annotations">application</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for Route.</td>
</tr>
<tr id="application-value-host" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-host">application</a></td>
<td><code class="value-key">host</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Explicit host.</td>
</tr>
<tr id="application-value-path" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-path">application</a></td>
<td><code class="value-key">path</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Path.</td>
</tr>
<tr id="application-value-port" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-port">application</a></td>
<td><code class="value-key">port</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Service port.</td>
</tr>
<tr id="application-value-weight" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-weight">application</a></td>
<td><code class="value-key">weight</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>100</code></td>
<td>Service weight.</td>
</tr>
<tr id="application-value-wildcardPolicy" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-wildcardPolicy">application</a></td>
<td><code class="value-key">wildcardPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>None</code></td>
<td>Wildcard policy.</td>
</tr>
<tr id="application-value-termination" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-termination">application</a></td>
<td><code class="value-key">termination</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>edge</code></td>
<td>TLS termination strategy.</td>
</tr>
<tr id="application-value-insecureEdgeTerminationPolicy" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-insecureEdgeTerminationPolicy">application</a></td>
<td><code class="value-key">insecureEdgeTerminationPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>Redirect</code></td>
<td>TLS insecure termination policy.</td>
</tr>
<tr id="application-value-alternateBackends" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-alternateBackends">application</a></td>
<td><code class="value-key">alternateBackends</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Alternate backend with it's weight.</td>
</tr>
<tr id="application-value-enabled" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-enabled">application</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy a [Secrets Store CSI Driver SecretProviderClass](https://secrets-store-csi-driver.sigs.k8s.io/) resource.</td>
</tr>
<tr id="application-value-name" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-name">application</a></td>
<td><code class="value-key">name</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Name of the SecretProviderClass.</td>
</tr>
<tr id="application-value-provider" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-provider">application</a></td>
<td><code class="value-key">provider</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Name of the provider.</td>
</tr>
<tr id="application-value-vaultAddress" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-vaultAddress">application</a></td>
<td><code class="value-key">vaultAddress</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Vault Address.</td>
</tr>
<tr id="application-value-roleName" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-roleName">application</a></td>
<td><code class="value-key">roleName</code></td>
<td><span class="type-badge tpl">tpl/string</span></td>
<td><code>""</code></td>
<td>Vault Role Name.</td>
</tr>
<tr id="application-value-objects" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-objects">application</a></td>
<td><code class="value-key">objects</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Objects definitions.</td>
</tr>
<tr id="application-value-secretObjects" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-secretObjects">application</a></td>
<td><code class="value-key">secretObjects</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Objects mapping.</td>
</tr>
<tr id="application-value-enabled" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-enabled">application</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy a [ForecastleApp](https://github.com/stakater/Forecastle) resource.</td>
</tr>
<tr id="application-value-additionalLabels" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-additionalLabels">application</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for ForecastleApp.</td>
</tr>
<tr id="application-value-icon" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-icon">application</a></td>
<td><code class="value-key">icon</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>https://raw.githubusercontent.com/stakater/ForecastleIcons/master/stakater-big.png</code></td>
<td>Icon URL.</td>
</tr>
<tr id="application-value-displayName" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-displayName">application</a></td>
<td><code class="value-key">displayName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Application Name.</td>
</tr>
<tr id="application-value-group" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-group">application</a></td>
<td><code class="value-key">group</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`{{ .Release.Namespace }}`</code></td>
<td>Application Group.</td>
</tr>
<tr id="application-value-properties" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-properties">application</a></td>
<td><code class="value-key">properties</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Custom properties.</td>
</tr>
<tr id="application-value-networkRestricted" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-networkRestricted">application</a></td>
<td><code class="value-key">networkRestricted</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Is application network restricted?.</td>
</tr>
<tr id="application-value-enabled" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-enabled">application</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Enable RBAC.</td>
</tr>
<tr id="application-value-enabled" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-enabled">application</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy Service Account.</td>
</tr>
<tr id="application-value-name" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-name">application</a></td>
<td><code class="value-key">name</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`{{ include "application.name" $ }}`</code></td>
<td>Service Account Name.</td>
</tr>
<tr id="application-value-additionalLabels" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-additionalLabels">application</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for Service Account.</td>
</tr>
<tr id="application-value-annotations" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-annotations">application</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for Service Account.</td>
</tr>
<tr id="application-value-roles" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-roles">application</a></td>
<td><code class="value-key">roles</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Namespaced Roles.</td>
</tr>
<tr id="application-value-enabled" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-enabled">application</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy additional ConfigMaps.</td>
</tr>
<tr id="application-value-additionalLabels" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-additionalLabels">application</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for ConfigMaps.</td>
</tr>
<tr id="application-value-annotations" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-annotations">application</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for ConfigMaps.</td>
</tr>
<tr id="application-value-files" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-files">application</a></td>
<td><code class="value-key">files</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>List of ConfigMap entries.</td>
</tr>
<tr id="application-value-enabled" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-enabled">application</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy [SealedSecret](https://github.com/bitnami-labs/sealed-secrets) resources.</td>
</tr>
<tr id="application-value-additionalLabels" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-additionalLabels">application</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for SealedSecret.</td>
</tr>
<tr id="application-value-annotations" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-annotations">application</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for SealedSecret.</td>
</tr>
<tr id="application-value-files" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-files">application</a></td>
<td><code class="value-key">files</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>List of SealedSecret entries.</td>
</tr>
<tr id="application-value-enabled" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-enabled">application</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy additional Secret resources.</td>
</tr>
<tr id="application-value-additionalLabels" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-additionalLabels">application</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for Secret.</td>
</tr>
<tr id="application-value-annotations" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-annotations">application</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for Secret.</td>
</tr>
<tr id="application-value-files" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-files">application</a></td>
<td><code class="value-key">files</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>List of Secrets entries.</td>
</tr>
<tr id="application-value-enabled" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-enabled">application</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy a ServiceMonitor (Prometheus Operator) resource.</td>
</tr>
<tr id="application-value-additionalLabels" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-additionalLabels">application</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for ServiceMonitor.</td>
</tr>
<tr id="application-value-annotations" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-annotations">application</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for ServiceMonitor.</td>
</tr>
<tr id="application-value-endpoints" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-endpoints">application</a></td>
<td><code class="value-key">endpoints</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Service endpoints from which prometheus will scrape data.</td>
</tr>
<tr id="application-value-enabled" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-enabled">application</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable Horizontal Pod Autoscaling.</td>
</tr>
<tr id="application-value-additionalLabels" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-additionalLabels">application</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for HPA.</td>
</tr>
<tr id="application-value-annotations" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-annotations">application</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for HPA.</td>
</tr>
<tr id="application-value-minReplicas" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-minReplicas">application</a></td>
<td><code class="value-key">minReplicas</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Minimum number of replicas.</td>
</tr>
<tr id="application-value-maxReplicas" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-maxReplicas">application</a></td>
<td><code class="value-key">maxReplicas</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>10</code></td>
<td>Maximum number of replicas.</td>
</tr>
<tr id="application-value-metrics" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-metrics">application</a></td>
<td><code class="value-key">metrics</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Metrics used for autoscaling.</td>
</tr>
<tr id="application-value-enabled" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-enabled">application</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable Vertical Pod Autoscaling.</td>
</tr>
<tr id="application-value-additionalLabels" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-additionalLabels">application</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for VPA.</td>
</tr>
<tr id="application-value-annotations" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-annotations">application</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for VPA.</td>
</tr>
<tr id="application-value-containerPolicies" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-containerPolicies">application</a></td>
<td><code class="value-key">containerPolicies</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Container policies for individual containers.</td>
</tr>
<tr id="application-value-updatePolicy" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-updatePolicy">application</a></td>
<td><code class="value-key">updatePolicy</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Update policy.</td>
</tr>
<tr id="application-value-enabled" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-enabled">application</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy an [IMC EndpointMonitor](https://github.com/stakater/IngressMonitorController) resource.</td>
</tr>
<tr id="application-value-additionalLabels" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-additionalLabels">application</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for EndpointMonitor.</td>
</tr>
<tr id="application-value-annotations" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-annotations">application</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for EndpointMonitor.</td>
</tr>
<tr id="application-value-enabled" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-enabled">application</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy a [cert-manager Certificate](https://cert-manager.io) resource.</td>
</tr>
<tr id="application-value-additionalLabels" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-additionalLabels">application</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for Certificate.</td>
</tr>
<tr id="application-value-annotations" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-annotations">application</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for Certificate.</td>
</tr>
<tr id="application-value-secretName" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-secretName">application</a></td>
<td><code class="value-key">secretName</code></td>
<td><span class="type-badge tpl">tpl/string</span></td>
<td><code>tls-cert</code></td>
<td>Name of the secret resource that will be automatically created and managed by this Certificate resource.</td>
</tr>
<tr id="application-value-duration" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-duration">application</a></td>
<td><code class="value-key">duration</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>8760h0m0s # 1 year</code></td>
<td>The requested "duration" (i.e. lifetime) of the Certificate.</td>
</tr>
<tr id="application-value-renewBefore" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-renewBefore">application</a></td>
<td><code class="value-key">renewBefore</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>720h0m0s # 30d</code></td>
<td>The amount of time before the currently issued certificate's notAfter time that cert-manager will begin to attempt to renew the certificate.</td>
</tr>
<tr id="application-value-subject" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-subject">application</a></td>
<td><code class="value-key">subject</code></td>
<td><span class="type-badge tpl">tpl/object</span></td>
<td><code>`nil`</code></td>
<td>Full X509 name specification for certificate.</td>
</tr>
<tr id="application-value-commonName" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-commonName">application</a></td>
<td><code class="value-key">commonName</code></td>
<td><span class="type-badge tpl">tpl/string</span></td>
<td><code>`nil`</code></td>
<td>Common name as specified on the DER encoded CSR. This field is not recommended in cases when this certificate is an end-entity certificate. More information can be found in the [cert-manager documentation](https://cert-manager.io/docs/usage/certificate/#:~:text=%23%20Avoid%20using%20commonName,%3A%20example.com).</td>
</tr>
<tr id="application-value-keyAlgorithm" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-keyAlgorithm">application</a></td>
<td><code class="value-key">keyAlgorithm</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>rsa</code></td>
<td>Private key algorithm of the corresponding private key for this certificate.</td>
</tr>
<tr id="application-value-keyEncoding" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-keyEncoding">application</a></td>
<td><code class="value-key">keyEncoding</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>pkcs1</code></td>
<td>Private key cryptography standards (PKCS) for this certificate's private key to be encoded in.</td>
</tr>
<tr id="application-value-keySize" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-keySize">application</a></td>
<td><code class="value-key">keySize</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>2048</code></td>
<td>Key bit size of the corresponding private key for this certificate.</td>
</tr>
<tr id="application-value-isCA" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-isCA">application</a></td>
<td><code class="value-key">isCA</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Mark this Certificate as valid for certificate signing.</td>
</tr>
<tr id="application-value-usages" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-usages">application</a></td>
<td><code class="value-key">usages</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Set of x509 usages that are requested for the certificate.</td>
</tr>
<tr id="application-value-dnsNames" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-dnsNames">application</a></td>
<td><code class="value-key">dnsNames</code></td>
<td><span class="type-badge tpl">tpl/list</span></td>
<td><code>`nil`</code></td>
<td>List of DNS subjectAltNames to be set on the certificate.</td>
</tr>
<tr id="application-value-ipAddresses" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-ipAddresses">application</a></td>
<td><code class="value-key">ipAddresses</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>List of IP address subjectAltNames to be set on the certificate.</td>
</tr>
<tr id="application-value-uriSANs" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-uriSANs">application</a></td>
<td><code class="value-key">uriSANs</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>List of URI subjectAltNames to be set on the certificate.</td>
</tr>
<tr id="application-value-emailSANs" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-emailSANs">application</a></td>
<td><code class="value-key">emailSANs</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>List of email subjectAltNames to be set on the Certificate.</td>
</tr>
<tr id="application-value-enabled" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-enabled">application</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable Private Key for the certificate.</td>
</tr>
<tr id="application-value-rotationPolicy" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-rotationPolicy">application</a></td>
<td><code class="value-key">rotationPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>Always</code></td>
<td>Denotes how private keys should be generated or sourced when a certificate is being issued.</td>
</tr>
<tr id="application-value-name" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-name">application</a></td>
<td><code class="value-key">name</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>ca-issuer</code></td>
<td>Reference to the issuer for this certificate.</td>
</tr>
<tr id="application-value-kind" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-kind">application</a></td>
<td><code class="value-key">kind</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>ClusterIssuer</code></td>
<td>Kind of the issuer being referred to.</td>
</tr>
<tr id="application-value-group" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-group">application</a></td>
<td><code class="value-key">group</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>cert-manager.io</code></td>
<td>Group of the issuer resource being refered to.</td>
</tr>
<tr id="application-value-enabled" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-enabled">application</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enables keystore configuration.</td>
</tr>
<tr id="application-value-create" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-create">application</a></td>
<td><code class="value-key">create</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Enables PKCS12 keystore creation for the Certificate.</td>
</tr>
<tr id="application-value-key" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-key">application</a></td>
<td><code class="value-key">key</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>test_key</code></td>
<td>Key of the entry in the Secret resource's data field to be used.</td>
</tr>
<tr id="application-value-name" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-name">application</a></td>
<td><code class="value-key">name</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>test-creds</code></td>
<td>Name of the Secret resource being referred to.</td>
</tr>
<tr id="application-value-create" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-create">application</a></td>
<td><code class="value-key">create</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enables jks keystore creation for the Certificate.</td>
</tr>
<tr id="application-value-key" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-key">application</a></td>
<td><code class="value-key">key</code></td>
<td><span class="type-badge tpl">tpl/string</span></td>
<td><code>test_key</code></td>
<td>Key of the entry in the Secret resource's data field to be used.</td>
</tr>
<tr id="application-value-name" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-name">application</a></td>
<td><code class="value-key">name</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>test-creds</code></td>
<td>Name of the Secret resource being referred to.</td>
</tr>
<tr id="application-value-enabled" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-enabled">application</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy an AlertmanagerConfig (Prometheus Operator) resource.</td>
</tr>
<tr id="application-value-selectionLabels" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-selectionLabels">application</a></td>
<td><code class="value-key">selectionLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Labels to be picked up by Alertmanager to add it to base config.</td>
</tr>
<tr id="application-value-spec" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-spec">application</a></td>
<td><code class="value-key">spec</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>AlertmanagerConfig spec.</td>
</tr>
<tr id="application-value-route" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-route">application</a></td>
<td><code class="value-key">route</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Route definition for alerts matching the resource’s namespace.</td>
</tr>
<tr id="application-value-receivers" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-receivers">application</a></td>
<td><code class="value-key">receivers</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>List of receivers.</td>
</tr>
<tr id="application-value-inhibitRules" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-inhibitRules">application</a></td>
<td><code class="value-key">inhibitRules</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Inhibition rules that allows to mute alerts when other alerts are already firing.</td>
</tr>
<tr id="application-value-enabled" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-enabled">application</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy a PrometheusRule (Prometheus Operator) resource.</td>
</tr>
<tr id="application-value-additionalLabels" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-additionalLabels">application</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for PrometheusRule.</td>
</tr>
<tr id="application-value-groups" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-groups">application</a></td>
<td><code class="value-key">groups</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Groups with alerting rules.</td>
</tr>
<tr id="application-value-enabled" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-enabled">application</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy [ExternalSecret](https://external-secrets.io/latest/) resources.</td>
</tr>
<tr id="application-value-additionalLabels" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-additionalLabels">application</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for ExternalSecret.</td>
</tr>
<tr id="application-value-annotations" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-annotations">application</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for ExternalSecret.</td>
</tr>
<tr id="application-value-secretStore" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-secretStore">application</a></td>
<td><code class="value-key">secretStore</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Default values for the SecretStore.</td>
</tr>
<tr id="application-value-name" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-name">application</a></td>
<td><code class="value-key">name</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>tenant-vault-secret-store</code></td>
<td>Name of the SecretStore to use.</td>
</tr>
<tr id="application-value-kind" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-kind">application</a></td>
<td><code class="value-key">kind</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>SecretStore</code></td>
<td>Kind of the SecretStore being refered to.</td>
</tr>
<tr id="application-value-refreshInterval" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-refreshInterval">application</a></td>
<td><code class="value-key">refreshInterval</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"1m"</code></td>
<td>RefreshInterval is the amount of time before the values are read again from the SecretStore provider.</td>
</tr>
<tr id="application-value-files" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-files">application</a></td>
<td><code class="value-key">files</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>List of ExternalSecret entries.</td>
</tr>
<tr id="application-value-enabled" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-enabled">application</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable Network Policy.</td>
</tr>
<tr id="application-value-additionalLabels" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-additionalLabels">application</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for Network Policy.</td>
</tr>
<tr id="application-value-annotations" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-annotations">application</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for Network Policy.</td>
</tr>
<tr id="application-value-ingress" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-ingress">application</a></td>
<td><code class="value-key">ingress</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Ingress rules for Network Policy.</td>
</tr>
<tr id="application-value-egress" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-egress">application</a></td>
<td><code class="value-key">egress</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Egress rules for Network Policy.</td>
</tr>
<tr id="application-value-enabled" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-enabled">application</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable Pod Disruption Budget.</td>
</tr>
<tr id="application-value-minAvailable" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-minAvailable">application</a></td>
<td><code class="value-key">minAvailable</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Minimum number of pods that must be available after eviction.</td>
</tr>
<tr id="application-value-maxUnavailable" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-maxUnavailable">application</a></td>
<td><code class="value-key">maxUnavailable</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>`nil`</code></td>
<td>Maximum number of unavailable pods during voluntary disruptions.</td>
</tr>
<tr id="application-value-enabled" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-enabled">application</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy [GrafanaDashboard](https://github.com/grafana/grafana-operator) resources.</td>
</tr>
<tr id="application-value-additionalLabels" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-additionalLabels">application</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for GrafanaDashboard.</td>
</tr>
<tr id="application-value-annotations" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-annotations">application</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for GrafanaDashboard.</td>
</tr>
<tr id="application-value-contents" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-contents">application</a></td>
<td><code class="value-key">contents</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>List of GrafanaDashboard entries.</td>
</tr>
<tr id="application-value-enabled" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-enabled">application</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy a [Velero/OADP Backup](https://velero.io/docs/main/api-types/backup/) resource.</td>
</tr>
<tr id="application-value-namespace" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-namespace">application</a></td>
<td><code class="value-key">namespace</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`{{ .Release.Namespace }}`</code></td>
<td>Namespace for Backup.</td>
</tr>
<tr id="application-value-additionalLabels" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-additionalLabels">application</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for Backup.</td>
</tr>
<tr id="application-value-annotations" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-annotations">application</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for Backup.</td>
</tr>
<tr id="application-value-defaultVolumesToRestic" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-defaultVolumesToRestic">application</a></td>
<td><code class="value-key">defaultVolumesToRestic</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Whether to use Restic to take snapshots of all pod volumes by default.</td>
</tr>
<tr id="application-value-snapshotVolumes" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-snapshotVolumes">application</a></td>
<td><code class="value-key">snapshotVolumes</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Whether to take snapshots of persistent volumes as part of the backup.</td>
</tr>
<tr id="application-value-storageLocation" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-storageLocation">application</a></td>
<td><code class="value-key">storageLocation</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Name of the backup storage location where the backup should be stored.</td>
</tr>
<tr id="application-value-ttl" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-ttl">application</a></td>
<td><code class="value-key">ttl</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"1h0m0s"</code></td>
<td>How long the Backup should be retained for.</td>
</tr>
<tr id="application-value-includedNamespaces" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-includedNamespaces">application</a></td>
<td><code class="value-key">includedNamespaces</code></td>
<td><span class="type-badge tpl">tpl/list</span></td>
<td><code>`[ {{ include "application.namespace" $ }} ]`</code></td>
<td>List of namespaces to include objects from.</td>
</tr>
<tr id="application-value-includedResources" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-includedResources">application</a></td>
<td><code class="value-key">includedResources</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>List of resource types to include in the backup.</td>
</tr>
<tr id="application-value-excludedResources" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-excludedResources">application</a></td>
<td><code class="value-key">excludedResources</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>List of resource types to exclude from the backup.</td>
</tr>
<tr id="application-value-extraObjects" class="value-anchor" data-section="application">
<td><a href="../charts/application.md#value-extraObjects">application</a></td>
<td><code class="value-key">extraObjects</code></td>
<td><span class="type-badge [list or object] of [tpl">[list or object] of [tpl/object or tpl/string]</span></td>
<td><code>`nil`</code></td>
<td>Extra K8s manifests to deploy.</td>
</tr>
<tr id="bitwarden-eso-provider-value-createClusterSecretStore" class="value-anchor" data-section="bitwarden-eso-provider">
<td><a href="../charts/bitwarden-eso-provider.md#value-createClusterSecretStore">bitwarden-eso-provider</a></td>
<td><code class="value-key">createClusterSecretStore</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Create ClusterSecretStore resource</td>
</tr>
<tr id="bitwarden-eso-provider-value-namespaced" class="value-anchor" data-section="bitwarden-eso-provider">
<td><a href="../charts/bitwarden-eso-provider.md#value-namespaced">bitwarden-eso-provider</a></td>
<td><code class="value-key">namespaced</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Create namespaced SecretStore (if false, creates ClusterSecretStore)</td>
</tr>
<tr id="bitwarden-eso-provider-value-name" class="value-anchor" data-section="bitwarden-eso-provider">
<td><a href="../charts/bitwarden-eso-provider.md#value-name">bitwarden-eso-provider</a></td>
<td><code class="value-key">name</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"bitwarden"</code></td>
<td>SecretStore/ClusterSecretStore name</td>
</tr>
<tr id="bitwarden-eso-provider-value-annotations" class="value-anchor" data-section="bitwarden-eso-provider">
<td><a href="../charts/bitwarden-eso-provider.md#value-annotations">bitwarden-eso-provider</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional annotations</td>
</tr>
<tr id="bitwarden-eso-provider-value-labels" class="value-anchor" data-section="bitwarden-eso-provider">
<td><a href="../charts/bitwarden-eso-provider.md#value-labels">bitwarden-eso-provider</a></td>
<td><code class="value-key">labels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional labels</td>
</tr>
<tr id="bitwarden-eso-provider-value-enabled" class="value-anchor" data-section="bitwarden-eso-provider">
<td><a href="../charts/bitwarden-eso-provider.md#value-enabled">bitwarden-eso-provider</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable network policy</td>
</tr>
<tr id="bitwarden-eso-provider-value-ingress" class="value-anchor" data-section="bitwarden-eso-provider">
<td><a href="../charts/bitwarden-eso-provider.md#value-ingress">bitwarden-eso-provider</a></td>
<td><code class="value-key">ingress</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Ingress rules</td>
</tr>
<tr id="bitwarden-eso-provider-value-egress" class="value-anchor" data-section="bitwarden-eso-provider">
<td><a href="../charts/bitwarden-eso-provider.md#value-egress">bitwarden-eso-provider</a></td>
<td><code class="value-key">egress</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Egress rules (allow Bitwarden API)</td>
</tr>
<tr id="bitwarden-eso-provider-value-enabled" class="value-anchor" data-section="bitwarden-eso-provider">
<td><a href="../charts/bitwarden-eso-provider.md#value-enabled">bitwarden-eso-provider</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable Prometheus metrics endpoint</td>
</tr>
<tr id="bitwarden-eso-provider-value-enabled" class="value-anchor" data-section="bitwarden-eso-provider">
<td><a href="../charts/bitwarden-eso-provider.md#value-enabled">bitwarden-eso-provider</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Create ServiceMonitor resource (requires Prometheus Operator)</td>
</tr>
<tr id="bitwarden-eso-provider-value-annotations" class="value-anchor" data-section="bitwarden-eso-provider">
<td><a href="../charts/bitwarden-eso-provider.md#value-annotations">bitwarden-eso-provider</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>ServiceMonitor annotations</td>
</tr>
<tr id="bitwarden-eso-provider-value-labels" class="value-anchor" data-section="bitwarden-eso-provider">
<td><a href="../charts/bitwarden-eso-provider.md#value-labels">bitwarden-eso-provider</a></td>
<td><code class="value-key">labels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional ServiceMonitor labels</td>
</tr>
<tr id="bitwarden-eso-provider-value-interval" class="value-anchor" data-section="bitwarden-eso-provider">
<td><a href="../charts/bitwarden-eso-provider.md#value-interval">bitwarden-eso-provider</a></td>
<td><code class="value-key">interval</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>30s</code></td>
<td>Scrape interval</td>
</tr>
<tr id="bitwarden-eso-provider-value-scrapeTimeout" class="value-anchor" data-section="bitwarden-eso-provider">
<td><a href="../charts/bitwarden-eso-provider.md#value-scrapeTimeout">bitwarden-eso-provider</a></td>
<td><code class="value-key">scrapeTimeout</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>null</code></td>
<td>Scrape timeout</td>
</tr>
<tr id="bitwarden-eso-provider-value-relabelings" class="value-anchor" data-section="bitwarden-eso-provider">
<td><a href="../charts/bitwarden-eso-provider.md#value-relabelings">bitwarden-eso-provider</a></td>
<td><code class="value-key">relabelings</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Relabelings for ServiceMonitor</td>
</tr>
<tr id="bitwarden-eso-provider-value-metricRelabelings" class="value-anchor" data-section="bitwarden-eso-provider">
<td><a href="../charts/bitwarden-eso-provider.md#value-metricRelabelings">bitwarden-eso-provider</a></td>
<td><code class="value-key">metricRelabelings</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Metric relabelings for ServiceMonitor</td>
</tr>
<tr id="compass-web-value-namespaceOverride" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-namespaceOverride">compass-web</a></td>
<td><code class="value-key">namespaceOverride</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`.Release.Namespace`</code></td>
<td>Override the namespace for all resources</td>
</tr>
<tr id="compass-web-value-nameOverride" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-nameOverride">compass-web</a></td>
<td><code class="value-key">nameOverride</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Override the name of the chart</td>
</tr>
<tr id="compass-web-value-fullnameOverride" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-fullnameOverride">compass-web</a></td>
<td><code class="value-key">fullnameOverride</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Override the full name of the chart</td>
</tr>
<tr id="compass-web-value-additionalLabels" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-additionalLabels">compass-web</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional labels to add to all resources</td>
</tr>
<tr id="compass-web-value-additionalAnnotations" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-additionalAnnotations">compass-web</a></td>
<td><code class="value-key">additionalAnnotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional annotations to add to all resources</td>
</tr>
<tr id="compass-web-value-repository" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-repository">compass-web</a></td>
<td><code class="value-key">repository</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>haohanyang/compass-web</code></td>
<td>MongoDB Compass Web Docker image repository</td>
</tr>
<tr id="compass-web-value-tag" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-tag">compass-web</a></td>
<td><code class="value-key">tag</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>Chart appVersion</code></td>
<td>MongoDB Compass Web Docker image tag</td>
</tr>
<tr id="compass-web-value-pullPolicy" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-pullPolicy">compass-web</a></td>
<td><code class="value-key">pullPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>IfNotPresent</code></td>
<td>Image pull policy</td>
</tr>
<tr id="compass-web-value-digest" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-digest">compass-web</a></td>
<td><code class="value-key">digest</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Image digest (overrides tag if set)</td>
</tr>
<tr id="compass-web-value-imagePullSecrets" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-imagePullSecrets">compass-web</a></td>
<td><code class="value-key">imagePullSecrets</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Image pull secrets for private registries</td>
</tr>
<tr id="compass-web-value-mongoUri" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-mongoUri">compass-web</a></td>
<td><code class="value-key">mongoUri</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>MongoDB connection string(s) (required)</td>
</tr>
<tr id="compass-web-value-existingSecret" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-existingSecret">compass-web</a></td>
<td><code class="value-key">existingSecret</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Name of an existing secret containing MongoDB connection string</td>
</tr>
<tr id="compass-web-value-existingSecretKey" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-existingSecretKey">compass-web</a></td>
<td><code class="value-key">existingSecretKey</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"mongoUri"</code></td>
<td>Key in existingSecret that contains the MongoDB URI</td>
</tr>
<tr id="compass-web-value-appName" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-appName">compass-web</a></td>
<td><code class="value-key">appName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"Compass Web"</code></td>
<td>Application name displayed in the UI</td>
</tr>
<tr id="compass-web-value-orgId" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-orgId">compass-web</a></td>
<td><code class="value-key">orgId</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"default-org-id"</code></td>
<td>Organization ID associated with the connection</td>
</tr>
<tr id="compass-web-value-projectId" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-projectId">compass-web</a></td>
<td><code class="value-key">projectId</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"default-project-id"</code></td>
<td>Project ID associated with the connection</td>
</tr>
<tr id="compass-web-value-clusterId" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-clusterId">compass-web</a></td>
<td><code class="value-key">clusterId</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"default-cluster-id"</code></td>
<td>Cluster ID associated with the connection</td>
</tr>
<tr id="compass-web-value-basicAuth" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-basicAuth">compass-web</a></td>
<td><code class="value-key">basicAuth</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Basic HTTP authentication configuration</td>
</tr>
<tr id="compass-web-value-enabled" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-enabled">compass-web</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable basic authentication</td>
</tr>
<tr id="compass-web-value-username" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-username">compass-web</a></td>
<td><code class="value-key">username</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Username for basic auth</td>
</tr>
<tr id="compass-web-value-password" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-password">compass-web</a></td>
<td><code class="value-key">password</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Password for basic auth</td>
</tr>
<tr id="compass-web-value-existingSecret" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-existingSecret">compass-web</a></td>
<td><code class="value-key">existingSecret</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Name of existing secret containing basic auth credentials</td>
</tr>
<tr id="compass-web-value-existingSecretUsernameKey" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-existingSecretUsernameKey">compass-web</a></td>
<td><code class="value-key">existingSecretUsernameKey</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"username"</code></td>
<td>Key in existingSecret for username</td>
</tr>
<tr id="compass-web-value-existingSecretPasswordKey" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-existingSecretPasswordKey">compass-web</a></td>
<td><code class="value-key">existingSecretPasswordKey</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"password"</code></td>
<td>Key in existingSecret for password</td>
</tr>
<tr id="compass-web-value-genAI" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-genAI">compass-web</a></td>
<td><code class="value-key">genAI</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>GenAI features configuration (requires OpenAI API key)</td>
</tr>
<tr id="compass-web-value-enabled" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-enabled">compass-web</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable GenAI features</td>
</tr>
<tr id="compass-web-value-apiKey" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-apiKey">compass-web</a></td>
<td><code class="value-key">apiKey</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>OpenAI API key</td>
</tr>
<tr id="compass-web-value-existingSecret" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-existingSecret">compass-web</a></td>
<td><code class="value-key">existingSecret</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Name of existing secret containing OpenAI API key</td>
</tr>
<tr id="compass-web-value-existingSecretKey" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-existingSecretKey">compass-web</a></td>
<td><code class="value-key">existingSecretKey</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"apiKey"</code></td>
<td>Key in existingSecret for API key</td>
</tr>
<tr id="compass-web-value-model" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-model">compass-web</a></td>
<td><code class="value-key">model</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"gpt-4o-mini"</code></td>
<td>OpenAI model to use</td>
</tr>
<tr id="compass-web-value-enableSampleDocuments" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-enableSampleDocuments">compass-web</a></td>
<td><code class="value-key">enableSampleDocuments</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable uploading sample documents to GenAI service</td>
</tr>
<tr id="compass-web-value-querySystemPrompt" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-querySystemPrompt">compass-web</a></td>
<td><code class="value-key">querySystemPrompt</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Custom system prompt for query generation</td>
</tr>
<tr id="compass-web-value-aggregationSystemPrompt" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-aggregationSystemPrompt">compass-web</a></td>
<td><code class="value-key">aggregationSystemPrompt</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Custom system prompt for aggregation generation</td>
</tr>
<tr id="compass-web-value-config" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-config">compass-web</a></td>
<td><code class="value-key">config</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional Compass Web configuration as environment variables</td>
</tr>
<tr id="compass-web-value-type" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-type">compass-web</a></td>
<td><code class="value-key">type</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>deployment</code></td>
<td>Controller type (deployment or statefulset)</td>
</tr>
<tr id="compass-web-value-replicas" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-replicas">compass-web</a></td>
<td><code class="value-key">replicas</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Number of replicas</td>
</tr>
<tr id="compass-web-value-strategy" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-strategy">compass-web</a></td>
<td><code class="value-key">strategy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Deployment update strategy</td>
</tr>
<tr id="compass-web-value-updateStrategy" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-updateStrategy">compass-web</a></td>
<td><code class="value-key">updateStrategy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>StatefulSet update strategy (only used if controller.type is statefulset)</td>
</tr>
<tr id="compass-web-value-podManagementPolicy" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-podManagementPolicy">compass-web</a></td>
<td><code class="value-key">podManagementPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>OrderedReady</code></td>
<td>Pod management policy (only used if controller.type is statefulset)</td>
</tr>
<tr id="compass-web-value-command" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-command">compass-web</a></td>
<td><code class="value-key">command</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Command override for the main container</td>
</tr>
<tr id="compass-web-value-args" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-args">compass-web</a></td>
<td><code class="value-key">args</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Args override for the main container</td>
</tr>
<tr id="compass-web-value-workingDir" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-workingDir">compass-web</a></td>
<td><code class="value-key">workingDir</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Working directory for the main container</td>
</tr>
<tr id="compass-web-value-terminationGracePeriodSeconds" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-terminationGracePeriodSeconds">compass-web</a></td>
<td><code class="value-key">terminationGracePeriodSeconds</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>30</code></td>
<td>Termination grace period in seconds</td>
</tr>
<tr id="compass-web-value-lifecycle" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-lifecycle">compass-web</a></td>
<td><code class="value-key">lifecycle</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Lifecycle hooks for the main container</td>
</tr>
<tr id="compass-web-value-type" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-type">compass-web</a></td>
<td><code class="value-key">type</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>ClusterIP</code></td>
<td>Service type</td>
</tr>
<tr id="compass-web-value-port" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-port">compass-web</a></td>
<td><code class="value-key">port</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>8080</code></td>
<td>Service port</td>
</tr>
<tr id="compass-web-value-targetPort" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-targetPort">compass-web</a></td>
<td><code class="value-key">targetPort</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>8080</code></td>
<td>Service target port (container port)</td>
</tr>
<tr id="compass-web-value-nodePort" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-nodePort">compass-web</a></td>
<td><code class="value-key">nodePort</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Node port (only used if type is NodePort)</td>
</tr>
<tr id="compass-web-value-loadBalancerIP" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-loadBalancerIP">compass-web</a></td>
<td><code class="value-key">loadBalancerIP</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Load balancer IP (only used if type is LoadBalancer)</td>
</tr>
<tr id="compass-web-value-loadBalancerSourceRanges" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-loadBalancerSourceRanges">compass-web</a></td>
<td><code class="value-key">loadBalancerSourceRanges</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Load balancer source ranges (only used if type is LoadBalancer)</td>
</tr>
<tr id="compass-web-value-externalTrafficPolicy" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-externalTrafficPolicy">compass-web</a></td>
<td><code class="value-key">externalTrafficPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>External traffic policy (only used if type is LoadBalancer or NodePort)</td>
</tr>
<tr id="compass-web-value-clusterIP" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-clusterIP">compass-web</a></td>
<td><code class="value-key">clusterIP</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Cluster IP (set to None for headless service)</td>
</tr>
<tr id="compass-web-value-sessionAffinity" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-sessionAffinity">compass-web</a></td>
<td><code class="value-key">sessionAffinity</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>None</code></td>
<td>Session affinity</td>
</tr>
<tr id="compass-web-value-sessionAffinityConfig" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-sessionAffinityConfig">compass-web</a></td>
<td><code class="value-key">sessionAffinityConfig</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Session affinity config</td>
</tr>
<tr id="compass-web-value-annotations" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-annotations">compass-web</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Service annotations</td>
</tr>
<tr id="compass-web-value-labels" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-labels">compass-web</a></td>
<td><code class="value-key">labels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Service labels</td>
</tr>
<tr id="compass-web-value-enabled" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-enabled">compass-web</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable ingress</td>
</tr>
<tr id="compass-web-value-className" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-className">compass-web</a></td>
<td><code class="value-key">className</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Ingress class name</td>
</tr>
<tr id="compass-web-value-annotations" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-annotations">compass-web</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Ingress annotations</td>
</tr>
<tr id="compass-web-value-hosts" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-hosts">compass-web</a></td>
<td><code class="value-key">hosts</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Ingress hosts configuration</td>
</tr>
<tr id="compass-web-value-tls" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-tls">compass-web</a></td>
<td><code class="value-key">tls</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Ingress TLS configuration</td>
</tr>
<tr id="compass-web-value-enabled" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-enabled">compass-web</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable persistent storage for Compass Web data</td>
</tr>
<tr id="compass-web-value-storageClassName" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-storageClassName">compass-web</a></td>
<td><code class="value-key">storageClassName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>Default storage class</code></td>
<td>Storage class name</td>
</tr>
<tr id="compass-web-value-accessMode" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-accessMode">compass-web</a></td>
<td><code class="value-key">accessMode</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>ReadWriteOnce</code></td>
<td>Access mode for the persistent volume</td>
</tr>
<tr id="compass-web-value-size" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-size">compass-web</a></td>
<td><code class="value-key">size</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>1Gi</code></td>
<td>Size of the persistent volume</td>
</tr>
<tr id="compass-web-value-existingClaim" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-existingClaim">compass-web</a></td>
<td><code class="value-key">existingClaim</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Name of an existing PVC to use</td>
</tr>
<tr id="compass-web-value-annotations" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-annotations">compass-web</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Annotations for the PVC</td>
</tr>
<tr id="compass-web-value-podSecurityContext" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-podSecurityContext">compass-web</a></td>
<td><code class="value-key">podSecurityContext</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Pod security context</td>
</tr>
<tr id="compass-web-value-securityContext" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-securityContext">compass-web</a></td>
<td><code class="value-key">securityContext</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Container security context</td>
</tr>
<tr id="compass-web-value-resources" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-resources">compass-web</a></td>
<td><code class="value-key">resources</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Resource limits and requests</td>
</tr>
<tr id="compass-web-value-livenessProbe" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-livenessProbe">compass-web</a></td>
<td><code class="value-key">livenessProbe</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Liveness probe configuration</td>
</tr>
<tr id="compass-web-value-readinessProbe" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-readinessProbe">compass-web</a></td>
<td><code class="value-key">readinessProbe</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Readiness probe configuration</td>
</tr>
<tr id="compass-web-value-startupProbe" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-startupProbe">compass-web</a></td>
<td><code class="value-key">startupProbe</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Startup probe configuration</td>
</tr>
<tr id="compass-web-value-podAnnotations" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-podAnnotations">compass-web</a></td>
<td><code class="value-key">podAnnotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Pod annotations</td>
</tr>
<tr id="compass-web-value-podLabels" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-podLabels">compass-web</a></td>
<td><code class="value-key">podLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Pod labels</td>
</tr>
<tr id="compass-web-value-nodeSelector" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-nodeSelector">compass-web</a></td>
<td><code class="value-key">nodeSelector</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Node selector for pod assignment</td>
</tr>
<tr id="compass-web-value-tolerations" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-tolerations">compass-web</a></td>
<td><code class="value-key">tolerations</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Tolerations for pod assignment</td>
</tr>
<tr id="compass-web-value-affinity" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-affinity">compass-web</a></td>
<td><code class="value-key">affinity</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Affinity for pod assignment</td>
</tr>
<tr id="compass-web-value-priorityClassName" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-priorityClassName">compass-web</a></td>
<td><code class="value-key">priorityClassName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Priority class name for the pod</td>
</tr>
<tr id="compass-web-value-topologySpreadConstraints" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-topologySpreadConstraints">compass-web</a></td>
<td><code class="value-key">topologySpreadConstraints</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Topology spread constraints for pod distribution</td>
</tr>
<tr id="compass-web-value-dnsPolicy" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-dnsPolicy">compass-web</a></td>
<td><code class="value-key">dnsPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>ClusterFirst</code></td>
<td>DNS policy</td>
</tr>
<tr id="compass-web-value-dnsConfig" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-dnsConfig">compass-web</a></td>
<td><code class="value-key">dnsConfig</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>DNS config</td>
</tr>
<tr id="compass-web-value-hostAliases" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-hostAliases">compass-web</a></td>
<td><code class="value-key">hostAliases</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Host aliases</td>
</tr>
<tr id="compass-web-value-runtimeClassName" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-runtimeClassName">compass-web</a></td>
<td><code class="value-key">runtimeClassName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Runtime class name</td>
</tr>
<tr id="compass-web-value-initContainers" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-initContainers">compass-web</a></td>
<td><code class="value-key">initContainers</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Init containers to run before the main container</td>
</tr>
<tr id="compass-web-value-extraContainers" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-extraContainers">compass-web</a></td>
<td><code class="value-key">extraContainers</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Extra sidecar containers</td>
</tr>
<tr id="compass-web-value-extraEnv" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-extraEnv">compass-web</a></td>
<td><code class="value-key">extraEnv</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Extra environment variables</td>
</tr>
<tr id="compass-web-value-extraEnvFrom" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-extraEnvFrom">compass-web</a></td>
<td><code class="value-key">extraEnvFrom</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Extra environment variables from ConfigMaps or Secrets</td>
</tr>
<tr id="compass-web-value-extraVolumes" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-extraVolumes">compass-web</a></td>
<td><code class="value-key">extraVolumes</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Extra volumes</td>
</tr>
<tr id="compass-web-value-extraVolumeMounts" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-extraVolumeMounts">compass-web</a></td>
<td><code class="value-key">extraVolumeMounts</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Extra volume mounts</td>
</tr>
<tr id="compass-web-value-enabled" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-enabled">compass-web</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable ServiceMonitor for Prometheus Operator</td>
</tr>
<tr id="compass-web-value-namespace" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-namespace">compass-web</a></td>
<td><code class="value-key">namespace</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Namespace for the ServiceMonitor (defaults to the release namespace)</td>
</tr>
<tr id="compass-web-value-interval" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-interval">compass-web</a></td>
<td><code class="value-key">interval</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>30s</code></td>
<td>Interval at which metrics should be scraped</td>
</tr>
<tr id="compass-web-value-scrapeTimeout" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-scrapeTimeout">compass-web</a></td>
<td><code class="value-key">scrapeTimeout</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>10s</code></td>
<td>Timeout for scraping metrics</td>
</tr>
<tr id="compass-web-value-labels" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-labels">compass-web</a></td>
<td><code class="value-key">labels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional labels for the ServiceMonitor</td>
</tr>
<tr id="compass-web-value-annotations" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-annotations">compass-web</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional annotations for the ServiceMonitor</td>
</tr>
<tr id="compass-web-value-metricRelabelings" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-metricRelabelings">compass-web</a></td>
<td><code class="value-key">metricRelabelings</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Metric relabelings</td>
</tr>
<tr id="compass-web-value-relabelings" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-relabelings">compass-web</a></td>
<td><code class="value-key">relabelings</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Relabelings</td>
</tr>
<tr id="compass-web-value-enabled" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-enabled">compass-web</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable PrometheusRule for alerting</td>
</tr>
<tr id="compass-web-value-namespace" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-namespace">compass-web</a></td>
<td><code class="value-key">namespace</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Namespace for the PrometheusRule (defaults to the release namespace)</td>
</tr>
<tr id="compass-web-value-labels" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-labels">compass-web</a></td>
<td><code class="value-key">labels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional labels for the PrometheusRule</td>
</tr>
<tr id="compass-web-value-rules" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-rules">compass-web</a></td>
<td><code class="value-key">rules</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Alert rules</td>
</tr>
<tr id="compass-web-value-enabled" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-enabled">compass-web</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable PodDisruptionBudget</td>
</tr>
<tr id="compass-web-value-minAvailable" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-minAvailable">compass-web</a></td>
<td><code class="value-key">minAvailable</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Minimum number of pods that must be available</td>
</tr>
<tr id="compass-web-value-maxUnavailable" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-maxUnavailable">compass-web</a></td>
<td><code class="value-key">maxUnavailable</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Maximum number of pods that can be unavailable</td>
</tr>
<tr id="compass-web-value-hpa" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-hpa">compass-web</a></td>
<td><code class="value-key">hpa</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Horizontal Pod Autoscaler configuration</td>
</tr>
<tr id="compass-web-value-enabled" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-enabled">compass-web</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable HorizontalPodAutoscaler</td>
</tr>
<tr id="compass-web-value-minReplicas" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-minReplicas">compass-web</a></td>
<td><code class="value-key">minReplicas</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Minimum number of replicas</td>
</tr>
<tr id="compass-web-value-maxReplicas" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-maxReplicas">compass-web</a></td>
<td><code class="value-key">maxReplicas</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>3</code></td>
<td>Maximum number of replicas</td>
</tr>
<tr id="compass-web-value-targetCPUUtilizationPercentage" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-targetCPUUtilizationPercentage">compass-web</a></td>
<td><code class="value-key">targetCPUUtilizationPercentage</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>80</code></td>
<td>Target CPU utilization percentage</td>
</tr>
<tr id="compass-web-value-targetMemoryUtilizationPercentage" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-targetMemoryUtilizationPercentage">compass-web</a></td>
<td><code class="value-key">targetMemoryUtilizationPercentage</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>80</code></td>
<td>Target memory utilization percentage</td>
</tr>
<tr id="compass-web-value-customMetrics" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-customMetrics">compass-web</a></td>
<td><code class="value-key">customMetrics</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Custom metrics for autoscaling</td>
</tr>
<tr id="compass-web-value-create" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-create">compass-web</a></td>
<td><code class="value-key">create</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Create a service account</td>
</tr>
<tr id="compass-web-value-name" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-name">compass-web</a></td>
<td><code class="value-key">name</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Service account name (generated if not set and create is true)</td>
</tr>
<tr id="compass-web-value-annotations" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-annotations">compass-web</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Service account annotations</td>
</tr>
<tr id="compass-web-value-create" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-create">compass-web</a></td>
<td><code class="value-key">create</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Create RBAC resources</td>
</tr>
<tr id="compass-web-value-rules" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-rules">compass-web</a></td>
<td><code class="value-key">rules</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Additional RBAC rules</td>
</tr>
<tr id="compass-web-value-enabled" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-enabled">compass-web</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable network policy</td>
</tr>
<tr id="compass-web-value-policyTypes" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-policyTypes">compass-web</a></td>
<td><code class="value-key">policyTypes</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Policy types</td>
</tr>
<tr id="compass-web-value-ingress" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-ingress">compass-web</a></td>
<td><code class="value-key">ingress</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Ingress rules</td>
</tr>
<tr id="compass-web-value-egress" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-egress">compass-web</a></td>
<td><code class="value-key">egress</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Egress rules</td>
</tr>
<tr id="compass-web-value-enabled" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-enabled">compass-web</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable diagnostic mode (disables probes, overrides command)</td>
</tr>
<tr id="compass-web-value-command" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-command">compass-web</a></td>
<td><code class="value-key">command</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Command override for diagnostic mode</td>
</tr>
<tr id="compass-web-value-args" class="value-anchor" data-section="compass-web">
<td><a href="../charts/compass-web.md#value-args">compass-web</a></td>
<td><code class="value-key">args</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Args override for diagnostic mode</td>
</tr>
<tr id="homarr-value-namespaceOverride" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-namespaceOverride">homarr</a></td>
<td><code class="value-key">namespaceOverride</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Override the namespace for all resources.</td>
</tr>
<tr id="homarr-value-componentOverride" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-componentOverride">homarr</a></td>
<td><code class="value-key">componentOverride</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Override the component label for all resources.</td>
</tr>
<tr id="homarr-value-partOfOverride" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-partOfOverride">homarr</a></td>
<td><code class="value-key">partOfOverride</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Override the partOf label for all resources.</td>
</tr>
<tr id="homarr-value-applicationName" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-applicationName">homarr</a></td>
<td><code class="value-key">applicationName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`{{ .Chart.Name }}`</code></td>
<td>Application name.</td>
</tr>
<tr id="homarr-value-enabled" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-enabled">homarr</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy CronJob resources.</td>
</tr>
<tr id="homarr-value-jobs" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-jobs">homarr</a></td>
<td><code class="value-key">jobs</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Map of CronJob resources.</td>
</tr>
<tr id="homarr-value-enabled" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-enabled">homarr</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy Job resources.</td>
</tr>
<tr id="homarr-value-jobs" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-jobs">homarr</a></td>
<td><code class="value-key">jobs</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Map of Job resources.</td>
</tr>
<tr id="homarr-value-enabled" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-enabled">homarr</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Enable Deployment.</td>
</tr>
<tr id="homarr-value-additionalLabels" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-additionalLabels">homarr</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for Deployment.</td>
</tr>
<tr id="homarr-value-podLabels" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-podLabels">homarr</a></td>
<td><code class="value-key">podLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional pod labels which are used in Service's Label Selector.</td>
</tr>
<tr id="homarr-value-annotations" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-annotations">homarr</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for Deployment.</td>
</tr>
<tr id="homarr-value-additionalPodAnnotations" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-additionalPodAnnotations">homarr</a></td>
<td><code class="value-key">additionalPodAnnotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional pod annotations.</td>
</tr>
<tr id="homarr-value-type" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-type">homarr</a></td>
<td><code class="value-key">type</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>RollingUpdate</code></td>
<td>Type of deployment strategy.</td>
</tr>
<tr id="homarr-value-maxUnavailable" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-maxUnavailable">homarr</a></td>
<td><code class="value-key">maxUnavailable</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>25%</code></td>
<td>Max unavailable pods during update.</td>
</tr>
<tr id="homarr-value-maxSurge" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-maxSurge">homarr</a></td>
<td><code class="value-key">maxSurge</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>25%</code></td>
<td>Max surge pods during update.</td>
</tr>
<tr id="homarr-value-reloadOnChange" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-reloadOnChange">homarr</a></td>
<td><code class="value-key">reloadOnChange</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Reload deployment if attached Secret/ConfigMap changes.</td>
</tr>
<tr id="homarr-value-nodeSelector" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-nodeSelector">homarr</a></td>
<td><code class="value-key">nodeSelector</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Select the node where the pods should be scheduled.</td>
</tr>
<tr id="homarr-value-hostAliases" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-hostAliases">homarr</a></td>
<td><code class="value-key">hostAliases</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Add host aliases to the pods.</td>
</tr>
<tr id="homarr-value-initContainers" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-initContainers">homarr</a></td>
<td><code class="value-key">initContainers</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Add init containers to the pods.</td>
</tr>
<tr id="homarr-value-fluentdConfigAnnotations" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-fluentdConfigAnnotations">homarr</a></td>
<td><code class="value-key">fluentdConfigAnnotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Configuration details for fluentdConfigurations.</td>
</tr>
<tr id="homarr-value-replicas" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-replicas">homarr</a></td>
<td><code class="value-key">replicas</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>`nil`</code></td>
<td>Number of replicas.</td>
</tr>
<tr id="homarr-value-imagePullSecrets" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-imagePullSecrets">homarr</a></td>
<td><code class="value-key">imagePullSecrets</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>List of secrets to be used for pulling the images.</td>
</tr>
<tr id="homarr-value-envFrom" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-envFrom">homarr</a></td>
<td><code class="value-key">envFrom</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Mount environment variables from ConfigMap or Secret to the pod.</td>
</tr>
<tr id="homarr-value-env" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-env">homarr</a></td>
<td><code class="value-key">env</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Environment variables to be added to the pod.</td>
</tr>
<tr id="homarr-value-volumes" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-volumes">homarr</a></td>
<td><code class="value-key">volumes</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Volumes to be added to the pod.</td>
</tr>
<tr id="homarr-value-volumeMounts" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-volumeMounts">homarr</a></td>
<td><code class="value-key">volumeMounts</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Mount path for Volumes.</td>
</tr>
<tr id="homarr-value-priorityClassName" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-priorityClassName">homarr</a></td>
<td><code class="value-key">priorityClassName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Define the priority class for the pod.</td>
</tr>
<tr id="homarr-value-tolerations" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-tolerations">homarr</a></td>
<td><code class="value-key">tolerations</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Taint tolerations for the pods.</td>
</tr>
<tr id="homarr-value-affinity" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-affinity">homarr</a></td>
<td><code class="value-key">affinity</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Affinity for the pods.</td>
</tr>
<tr id="homarr-value-topologySpreadConstraints" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-topologySpreadConstraints">homarr</a></td>
<td><code class="value-key">topologySpreadConstraints</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Topology spread constraints for the pods.</td>
</tr>
<tr id="homarr-value-revisionHistoryLimit" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-revisionHistoryLimit">homarr</a></td>
<td><code class="value-key">revisionHistoryLimit</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>2</code></td>
<td>Number of ReplicaSet revisions to retain.</td>
</tr>
<tr id="homarr-value-repository" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-repository">homarr</a></td>
<td><code class="value-key">repository</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"nginx"</code></td>
<td>Repository.</td>
</tr>
<tr id="homarr-value-tag" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-tag">homarr</a></td>
<td><code class="value-key">tag</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"latest"</code></td>
<td>Tag.</td>
</tr>
<tr id="homarr-value-digest" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-digest">homarr</a></td>
<td><code class="value-key">digest</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Image digest. If set to a non-empty value, digest takes precedence on the tag.</td>
</tr>
<tr id="homarr-value-pullPolicy" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-pullPolicy">homarr</a></td>
<td><code class="value-key">pullPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>IfNotPresent</code></td>
<td>Image pull policy.</td>
</tr>
<tr id="homarr-value-dnsConfig" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-dnsConfig">homarr</a></td>
<td><code class="value-key">dnsConfig</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>DNS config for the pods.</td>
</tr>
<tr id="homarr-value-startupProbe" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-startupProbe">homarr</a></td>
<td><code class="value-key">startupProbe</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>See below</code></td>
<td>Startup probe.</td>
</tr>
<tr id="homarr-value-enabled" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-enabled">homarr</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable Startup probe.</td>
</tr>
<tr id="homarr-value-failureThreshold" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-failureThreshold">homarr</a></td>
<td><code class="value-key">failureThreshold</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>30</code></td>
<td>Number of retries before marking the pod as failed.</td>
</tr>
<tr id="homarr-value-periodSeconds" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-periodSeconds">homarr</a></td>
<td><code class="value-key">periodSeconds</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>10</code></td>
<td>Time between retries.</td>
</tr>
<tr id="homarr-value-successThreshold" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-successThreshold">homarr</a></td>
<td><code class="value-key">successThreshold</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Number of successful probes before marking the pod as ready.</td>
</tr>
<tr id="homarr-value-timeoutSeconds" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-timeoutSeconds">homarr</a></td>
<td><code class="value-key">timeoutSeconds</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Time before the probe times out.</td>
</tr>
<tr id="homarr-value-httpGet" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-httpGet">homarr</a></td>
<td><code class="value-key">httpGet</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>HTTP Get probe.</td>
</tr>
<tr id="homarr-value-exec" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-exec">homarr</a></td>
<td><code class="value-key">exec</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Exec probe.</td>
</tr>
<tr id="homarr-value-tcpSocket" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-tcpSocket">homarr</a></td>
<td><code class="value-key">tcpSocket</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>TCP Socket probe.</td>
</tr>
<tr id="homarr-value-grpc" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-grpc">homarr</a></td>
<td><code class="value-key">grpc</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>gRPC probe.</td>
</tr>
<tr id="homarr-value-readinessProbe" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-readinessProbe">homarr</a></td>
<td><code class="value-key">readinessProbe</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>See below</code></td>
<td>Readiness probe.</td>
</tr>
<tr id="homarr-value-enabled" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-enabled">homarr</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable Readiness probe.</td>
</tr>
<tr id="homarr-value-failureThreshold" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-failureThreshold">homarr</a></td>
<td><code class="value-key">failureThreshold</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>30</code></td>
<td>Number of retries before marking the pod as failed.</td>
</tr>
<tr id="homarr-value-periodSeconds" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-periodSeconds">homarr</a></td>
<td><code class="value-key">periodSeconds</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>10</code></td>
<td>Time between retries.</td>
</tr>
<tr id="homarr-value-successThreshold" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-successThreshold">homarr</a></td>
<td><code class="value-key">successThreshold</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Number of successful probes before marking the pod as ready.</td>
</tr>
<tr id="homarr-value-timeoutSeconds" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-timeoutSeconds">homarr</a></td>
<td><code class="value-key">timeoutSeconds</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Time before the probe times out.</td>
</tr>
<tr id="homarr-value-httpGet" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-httpGet">homarr</a></td>
<td><code class="value-key">httpGet</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>HTTP Get probe.</td>
</tr>
<tr id="homarr-value-exec" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-exec">homarr</a></td>
<td><code class="value-key">exec</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Exec probe.</td>
</tr>
<tr id="homarr-value-tcpSocket" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-tcpSocket">homarr</a></td>
<td><code class="value-key">tcpSocket</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>TCP Socket probe.</td>
</tr>
<tr id="homarr-value-grpc" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-grpc">homarr</a></td>
<td><code class="value-key">grpc</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>gRPC probe.</td>
</tr>
<tr id="homarr-value-livenessProbe" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-livenessProbe">homarr</a></td>
<td><code class="value-key">livenessProbe</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>See below</code></td>
<td>Liveness probe.</td>
</tr>
<tr id="homarr-value-enabled" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-enabled">homarr</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable Liveness probe.</td>
</tr>
<tr id="homarr-value-failureThreshold" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-failureThreshold">homarr</a></td>
<td><code class="value-key">failureThreshold</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>30</code></td>
<td>Number of retries before marking the pod as failed.</td>
</tr>
<tr id="homarr-value-periodSeconds" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-periodSeconds">homarr</a></td>
<td><code class="value-key">periodSeconds</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>10</code></td>
<td>Time between retries.</td>
</tr>
<tr id="homarr-value-successThreshold" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-successThreshold">homarr</a></td>
<td><code class="value-key">successThreshold</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Number of successful probes before marking the pod as ready.</td>
</tr>
<tr id="homarr-value-timeoutSeconds" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-timeoutSeconds">homarr</a></td>
<td><code class="value-key">timeoutSeconds</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Time before the probe times out.</td>
</tr>
<tr id="homarr-value-httpGet" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-httpGet">homarr</a></td>
<td><code class="value-key">httpGet</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>HTTP Get probe.</td>
</tr>
<tr id="homarr-value-exec" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-exec">homarr</a></td>
<td><code class="value-key">exec</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Exec probe.</td>
</tr>
<tr id="homarr-value-tcpSocket" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-tcpSocket">homarr</a></td>
<td><code class="value-key">tcpSocket</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>TCP Socket probe.</td>
</tr>
<tr id="homarr-value-grpc" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-grpc">homarr</a></td>
<td><code class="value-key">grpc</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>gRPC probe.</td>
</tr>
<tr id="homarr-value-resources" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-resources">homarr</a></td>
<td><code class="value-key">resources</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Resource limits and requests for the pod.</td>
</tr>
<tr id="homarr-value-containerSecurityContext" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-containerSecurityContext">homarr</a></td>
<td><code class="value-key">containerSecurityContext</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Security Context at Container Level.</td>
</tr>
<tr id="homarr-value-enabled" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-enabled">homarr</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable [OpenShift OAuth Proxy](https://github.com/openshift/oauth-proxy).</td>
</tr>
<tr id="homarr-value-port" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-port">homarr</a></td>
<td><code class="value-key">port</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>8080</code></td>
<td>Port on which application is running inside container.</td>
</tr>
<tr id="homarr-value-secretName" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-secretName">homarr</a></td>
<td><code class="value-key">secretName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"openshift-oauth-proxy-tls"</code></td>
<td>Secret name for the OAuth Proxy TLS certificate.</td>
</tr>
<tr id="homarr-value-image" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-image">homarr</a></td>
<td><code class="value-key">image</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>openshift/oauth-proxy:latest</code></td>
<td>Image for the OAuth Proxy.</td>
</tr>
<tr id="homarr-value-disableTLSArg" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-disableTLSArg">homarr</a></td>
<td><code class="value-key">disableTLSArg</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>If disabled `--http-address=:8081` will be used instead of `--https-address=:8443`.</td>
</tr>
<tr id="homarr-value-securityContext" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-securityContext">homarr</a></td>
<td><code class="value-key">securityContext</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Security Context for the pod.</td>
</tr>
<tr id="homarr-value-command" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-command">homarr</a></td>
<td><code class="value-key">command</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Command for the app container.</td>
</tr>
<tr id="homarr-value-args" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-args">homarr</a></td>
<td><code class="value-key">args</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Args for the app container.</td>
</tr>
<tr id="homarr-value-ports" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-ports">homarr</a></td>
<td><code class="value-key">ports</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>List of ports for the app container.</td>
</tr>
<tr id="homarr-value-hostNetwork" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-hostNetwork">homarr</a></td>
<td><code class="value-key">hostNetwork</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>`nil`</code></td>
<td>Host network connectivity.</td>
</tr>
<tr id="homarr-value-terminationGracePeriodSeconds" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-terminationGracePeriodSeconds">homarr</a></td>
<td><code class="value-key">terminationGracePeriodSeconds</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>`nil`</code></td>
<td>Gracefull termination period.</td>
</tr>
<tr id="homarr-value-lifecycle" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-lifecycle">homarr</a></td>
<td><code class="value-key">lifecycle</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Lifecycle configuration for the pod.</td>
</tr>
<tr id="homarr-value-additionalContainers" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-additionalContainers">homarr</a></td>
<td><code class="value-key">additionalContainers</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Additional containers besides init and app containers (without templating).</td>
</tr>
<tr id="homarr-value-enabled" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-enabled">homarr</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable persistence.</td>
</tr>
<tr id="homarr-value-mountPVC" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-mountPVC">homarr</a></td>
<td><code class="value-key">mountPVC</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Whether to mount the created PVC to the deployment.</td>
</tr>
<tr id="homarr-value-mountPath" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-mountPath">homarr</a></td>
<td><code class="value-key">mountPath</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"/"</code></td>
<td>If `persistence.mountPVC` is enabled, where to mount the volume in the containers.</td>
</tr>
<tr id="homarr-value-name" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-name">homarr</a></td>
<td><code class="value-key">name</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`{{ include "application.name" $ }}-data`</code></td>
<td>Name of the PVC.</td>
</tr>
<tr id="homarr-value-accessMode" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-accessMode">homarr</a></td>
<td><code class="value-key">accessMode</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>ReadWriteOnce</code></td>
<td>Access mode for volume.</td>
</tr>
<tr id="homarr-value-storageClass" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-storageClass">homarr</a></td>
<td><code class="value-key">storageClass</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>null</code></td>
<td>Storage class for volume.</td>
</tr>
<tr id="homarr-value-additionalLabels" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-additionalLabels">homarr</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for persistent volume.</td>
</tr>
<tr id="homarr-value-annotations" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-annotations">homarr</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for persistent volume.</td>
</tr>
<tr id="homarr-value-storageSize" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-storageSize">homarr</a></td>
<td><code class="value-key">storageSize</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>8Gi</code></td>
<td>Size of the persistent volume.</td>
</tr>
<tr id="homarr-value-volumeMode" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-volumeMode">homarr</a></td>
<td><code class="value-key">volumeMode</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>PVC Volume Mode.</td>
</tr>
<tr id="homarr-value-volumeName" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-volumeName">homarr</a></td>
<td><code class="value-key">volumeName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Name of the volume.</td>
</tr>
<tr id="homarr-value-enabled" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-enabled">homarr</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Enable Service.</td>
</tr>
<tr id="homarr-value-additionalLabels" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-additionalLabels">homarr</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for service.</td>
</tr>
<tr id="homarr-value-annotations" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-annotations">homarr</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for service.</td>
</tr>
<tr id="homarr-value-ports" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-ports">homarr</a></td>
<td><code class="value-key">ports</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Ports for applications service.</td>
</tr>
<tr id="homarr-value-type" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-type">homarr</a></td>
<td><code class="value-key">type</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>ClusterIP</code></td>
<td>Type of service.</td>
</tr>
<tr id="homarr-value-clusterIP" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-clusterIP">homarr</a></td>
<td><code class="value-key">clusterIP</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Fixed IP for a ClusterIP service.</td>
</tr>
<tr id="homarr-value-enabled" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-enabled">homarr</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable Ingress.</td>
</tr>
<tr id="homarr-value-ingressClassName" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-ingressClassName">homarr</a></td>
<td><code class="value-key">ingressClassName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Name of the ingress class.</td>
</tr>
<tr id="homarr-value-pathType" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-pathType">homarr</a></td>
<td><code class="value-key">pathType</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`ImplementationSpecific`</code></td>
<td>Path type.</td>
</tr>
<tr id="homarr-value-serviceName" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-serviceName">homarr</a></td>
<td><code class="value-key">serviceName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`{{ include "application.name" $ }}`</code></td>
<td>Service name.</td>
</tr>
<tr id="homarr-value-servicePort" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-servicePort">homarr</a></td>
<td><code class="value-key">servicePort</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`http`</code></td>
<td>Service port.</td>
</tr>
<tr id="homarr-value-additionalLabels" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-additionalLabels">homarr</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for ingress.</td>
</tr>
<tr id="homarr-value-annotations" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-annotations">homarr</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for ingress.</td>
</tr>
<tr id="homarr-value-tls" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-tls">homarr</a></td>
<td><code class="value-key">tls</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>TLS configuration for ingress.</td>
</tr>
<tr id="homarr-value-enabled" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-enabled">homarr</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy a Route (OpenShift) resource.</td>
</tr>
<tr id="homarr-value-additionalLabels" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-additionalLabels">homarr</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for Route.</td>
</tr>
<tr id="homarr-value-annotations" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-annotations">homarr</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for Route.</td>
</tr>
<tr id="homarr-value-host" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-host">homarr</a></td>
<td><code class="value-key">host</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Explicit host.</td>
</tr>
<tr id="homarr-value-path" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-path">homarr</a></td>
<td><code class="value-key">path</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Path.</td>
</tr>
<tr id="homarr-value-port" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-port">homarr</a></td>
<td><code class="value-key">port</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Service port.</td>
</tr>
<tr id="homarr-value-weight" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-weight">homarr</a></td>
<td><code class="value-key">weight</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>100</code></td>
<td>Service weight.</td>
</tr>
<tr id="homarr-value-wildcardPolicy" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-wildcardPolicy">homarr</a></td>
<td><code class="value-key">wildcardPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>None</code></td>
<td>Wildcard policy.</td>
</tr>
<tr id="homarr-value-termination" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-termination">homarr</a></td>
<td><code class="value-key">termination</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>edge</code></td>
<td>TLS termination strategy.</td>
</tr>
<tr id="homarr-value-insecureEdgeTerminationPolicy" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-insecureEdgeTerminationPolicy">homarr</a></td>
<td><code class="value-key">insecureEdgeTerminationPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>Redirect</code></td>
<td>TLS insecure termination policy.</td>
</tr>
<tr id="homarr-value-alternateBackends" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-alternateBackends">homarr</a></td>
<td><code class="value-key">alternateBackends</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Alternate backend with it's weight.</td>
</tr>
<tr id="homarr-value-enabled" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-enabled">homarr</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy a [Secrets Store CSI Driver SecretProviderClass](https://secrets-store-csi-driver.sigs.k8s.io/) resource.</td>
</tr>
<tr id="homarr-value-name" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-name">homarr</a></td>
<td><code class="value-key">name</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Name of the SecretProviderClass.</td>
</tr>
<tr id="homarr-value-provider" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-provider">homarr</a></td>
<td><code class="value-key">provider</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Name of the provider.</td>
</tr>
<tr id="homarr-value-vaultAddress" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-vaultAddress">homarr</a></td>
<td><code class="value-key">vaultAddress</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Vault Address.</td>
</tr>
<tr id="homarr-value-roleName" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-roleName">homarr</a></td>
<td><code class="value-key">roleName</code></td>
<td><span class="type-badge tpl">tpl/string</span></td>
<td><code>""</code></td>
<td>Vault Role Name.</td>
</tr>
<tr id="homarr-value-objects" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-objects">homarr</a></td>
<td><code class="value-key">objects</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Objects definitions.</td>
</tr>
<tr id="homarr-value-secretObjects" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-secretObjects">homarr</a></td>
<td><code class="value-key">secretObjects</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Objects mapping.</td>
</tr>
<tr id="homarr-value-enabled" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-enabled">homarr</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy a [ForecastleApp](https://github.com/stakater/Forecastle) resource.</td>
</tr>
<tr id="homarr-value-additionalLabels" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-additionalLabels">homarr</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for ForecastleApp.</td>
</tr>
<tr id="homarr-value-icon" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-icon">homarr</a></td>
<td><code class="value-key">icon</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>https://raw.githubusercontent.com/stakater/ForecastleIcons/master/stakater-big.png</code></td>
<td>Icon URL.</td>
</tr>
<tr id="homarr-value-displayName" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-displayName">homarr</a></td>
<td><code class="value-key">displayName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Application Name.</td>
</tr>
<tr id="homarr-value-group" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-group">homarr</a></td>
<td><code class="value-key">group</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`{{ .Release.Namespace }}`</code></td>
<td>Application Group.</td>
</tr>
<tr id="homarr-value-properties" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-properties">homarr</a></td>
<td><code class="value-key">properties</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Custom properties.</td>
</tr>
<tr id="homarr-value-networkRestricted" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-networkRestricted">homarr</a></td>
<td><code class="value-key">networkRestricted</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Is application network restricted?.</td>
</tr>
<tr id="homarr-value-enabled" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-enabled">homarr</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Enable RBAC.</td>
</tr>
<tr id="homarr-value-enabled" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-enabled">homarr</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy Service Account.</td>
</tr>
<tr id="homarr-value-name" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-name">homarr</a></td>
<td><code class="value-key">name</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`{{ include "application.name" $ }}`</code></td>
<td>Service Account Name.</td>
</tr>
<tr id="homarr-value-additionalLabels" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-additionalLabels">homarr</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for Service Account.</td>
</tr>
<tr id="homarr-value-annotations" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-annotations">homarr</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for Service Account.</td>
</tr>
<tr id="homarr-value-roles" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-roles">homarr</a></td>
<td><code class="value-key">roles</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Namespaced Roles.</td>
</tr>
<tr id="homarr-value-enabled" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-enabled">homarr</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy additional ConfigMaps.</td>
</tr>
<tr id="homarr-value-additionalLabels" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-additionalLabels">homarr</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for ConfigMaps.</td>
</tr>
<tr id="homarr-value-annotations" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-annotations">homarr</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for ConfigMaps.</td>
</tr>
<tr id="homarr-value-files" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-files">homarr</a></td>
<td><code class="value-key">files</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>List of ConfigMap entries.</td>
</tr>
<tr id="homarr-value-enabled" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-enabled">homarr</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy [SealedSecret](https://github.com/bitnami-labs/sealed-secrets) resources.</td>
</tr>
<tr id="homarr-value-additionalLabels" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-additionalLabels">homarr</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for SealedSecret.</td>
</tr>
<tr id="homarr-value-annotations" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-annotations">homarr</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for SealedSecret.</td>
</tr>
<tr id="homarr-value-files" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-files">homarr</a></td>
<td><code class="value-key">files</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>List of SealedSecret entries.</td>
</tr>
<tr id="homarr-value-enabled" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-enabled">homarr</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy additional Secret resources.</td>
</tr>
<tr id="homarr-value-additionalLabels" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-additionalLabels">homarr</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for Secret.</td>
</tr>
<tr id="homarr-value-annotations" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-annotations">homarr</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for Secret.</td>
</tr>
<tr id="homarr-value-files" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-files">homarr</a></td>
<td><code class="value-key">files</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>List of Secrets entries.</td>
</tr>
<tr id="homarr-value-enabled" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-enabled">homarr</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy a ServiceMonitor (Prometheus Operator) resource.</td>
</tr>
<tr id="homarr-value-additionalLabels" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-additionalLabels">homarr</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for ServiceMonitor.</td>
</tr>
<tr id="homarr-value-annotations" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-annotations">homarr</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for ServiceMonitor.</td>
</tr>
<tr id="homarr-value-endpoints" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-endpoints">homarr</a></td>
<td><code class="value-key">endpoints</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Service endpoints from which prometheus will scrape data.</td>
</tr>
<tr id="homarr-value-enabled" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-enabled">homarr</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable Horizontal Pod Autoscaling.</td>
</tr>
<tr id="homarr-value-additionalLabels" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-additionalLabels">homarr</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for HPA.</td>
</tr>
<tr id="homarr-value-annotations" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-annotations">homarr</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for HPA.</td>
</tr>
<tr id="homarr-value-minReplicas" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-minReplicas">homarr</a></td>
<td><code class="value-key">minReplicas</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Minimum number of replicas.</td>
</tr>
<tr id="homarr-value-maxReplicas" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-maxReplicas">homarr</a></td>
<td><code class="value-key">maxReplicas</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>10</code></td>
<td>Maximum number of replicas.</td>
</tr>
<tr id="homarr-value-metrics" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-metrics">homarr</a></td>
<td><code class="value-key">metrics</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Metrics used for autoscaling.</td>
</tr>
<tr id="homarr-value-enabled" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-enabled">homarr</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable Vertical Pod Autoscaling.</td>
</tr>
<tr id="homarr-value-additionalLabels" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-additionalLabels">homarr</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for VPA.</td>
</tr>
<tr id="homarr-value-annotations" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-annotations">homarr</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for VPA.</td>
</tr>
<tr id="homarr-value-containerPolicies" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-containerPolicies">homarr</a></td>
<td><code class="value-key">containerPolicies</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Container policies for individual containers.</td>
</tr>
<tr id="homarr-value-updatePolicy" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-updatePolicy">homarr</a></td>
<td><code class="value-key">updatePolicy</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Update policy.</td>
</tr>
<tr id="homarr-value-enabled" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-enabled">homarr</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy an [IMC EndpointMonitor](https://github.com/stakater/IngressMonitorController) resource.</td>
</tr>
<tr id="homarr-value-additionalLabels" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-additionalLabels">homarr</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for EndpointMonitor.</td>
</tr>
<tr id="homarr-value-annotations" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-annotations">homarr</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for EndpointMonitor.</td>
</tr>
<tr id="homarr-value-enabled" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-enabled">homarr</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy a [cert-manager Certificate](https://cert-manager.io) resource.</td>
</tr>
<tr id="homarr-value-additionalLabels" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-additionalLabels">homarr</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for Certificate.</td>
</tr>
<tr id="homarr-value-annotations" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-annotations">homarr</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for Certificate.</td>
</tr>
<tr id="homarr-value-secretName" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-secretName">homarr</a></td>
<td><code class="value-key">secretName</code></td>
<td><span class="type-badge tpl">tpl/string</span></td>
<td><code>tls-cert</code></td>
<td>Name of the secret resource that will be automatically created and managed by this Certificate resource.</td>
</tr>
<tr id="homarr-value-duration" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-duration">homarr</a></td>
<td><code class="value-key">duration</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>8760h0m0s # 1 year</code></td>
<td>The requested "duration" (i.e. lifetime) of the Certificate.</td>
</tr>
<tr id="homarr-value-renewBefore" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-renewBefore">homarr</a></td>
<td><code class="value-key">renewBefore</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>720h0m0s # 30d</code></td>
<td>The amount of time before the currently issued certificate's notAfter time that cert-manager will begin to attempt to renew the certificate.</td>
</tr>
<tr id="homarr-value-subject" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-subject">homarr</a></td>
<td><code class="value-key">subject</code></td>
<td><span class="type-badge tpl">tpl/object</span></td>
<td><code>`nil`</code></td>
<td>Full X509 name specification for certificate.</td>
</tr>
<tr id="homarr-value-commonName" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-commonName">homarr</a></td>
<td><code class="value-key">commonName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>admin-app</code></td>
<td>Common name as specified on the DER encoded CSR.</td>
</tr>
<tr id="homarr-value-keyAlgorithm" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-keyAlgorithm">homarr</a></td>
<td><code class="value-key">keyAlgorithm</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>rsa</code></td>
<td>Private key algorithm of the corresponding private key for this certificate.</td>
</tr>
<tr id="homarr-value-keyEncoding" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-keyEncoding">homarr</a></td>
<td><code class="value-key">keyEncoding</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>pkcs1</code></td>
<td>Private key cryptography standards (PKCS) for this certificate's private key to be encoded in.</td>
</tr>
<tr id="homarr-value-keySize" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-keySize">homarr</a></td>
<td><code class="value-key">keySize</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>2048</code></td>
<td>Key bit size of the corresponding private key for this certificate.</td>
</tr>
<tr id="homarr-value-isCA" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-isCA">homarr</a></td>
<td><code class="value-key">isCA</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Mark this Certificate as valid for certificate signing.</td>
</tr>
<tr id="homarr-value-usages" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-usages">homarr</a></td>
<td><code class="value-key">usages</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Set of x509 usages that are requested for the certificate.</td>
</tr>
<tr id="homarr-value-dnsNames" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-dnsNames">homarr</a></td>
<td><code class="value-key">dnsNames</code></td>
<td><span class="type-badge tpl">tpl/list</span></td>
<td><code>`nil`</code></td>
<td>List of DNS subjectAltNames to be set on the certificate.</td>
</tr>
<tr id="homarr-value-ipAddresses" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-ipAddresses">homarr</a></td>
<td><code class="value-key">ipAddresses</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>List of IP address subjectAltNames to be set on the certificate.</td>
</tr>
<tr id="homarr-value-uriSANs" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-uriSANs">homarr</a></td>
<td><code class="value-key">uriSANs</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>List of URI subjectAltNames to be set on the certificate.</td>
</tr>
<tr id="homarr-value-emailSANs" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-emailSANs">homarr</a></td>
<td><code class="value-key">emailSANs</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>List of email subjectAltNames to be set on the Certificate.</td>
</tr>
<tr id="homarr-value-enabled" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-enabled">homarr</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable Private Key for the certificate.</td>
</tr>
<tr id="homarr-value-rotationPolicy" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-rotationPolicy">homarr</a></td>
<td><code class="value-key">rotationPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>Always</code></td>
<td>Denotes how private keys should be generated or sourced when a certificate is being issued.</td>
</tr>
<tr id="homarr-value-name" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-name">homarr</a></td>
<td><code class="value-key">name</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>ca-issuer</code></td>
<td>Reference to the issuer for this certificate.</td>
</tr>
<tr id="homarr-value-kind" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-kind">homarr</a></td>
<td><code class="value-key">kind</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>ClusterIssuer</code></td>
<td>Kind of the issuer being referred to.</td>
</tr>
<tr id="homarr-value-group" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-group">homarr</a></td>
<td><code class="value-key">group</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>cert-manager.io</code></td>
<td>Group of the issuer resource being refered to.</td>
</tr>
<tr id="homarr-value-enabled" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-enabled">homarr</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enables keystore configuration.</td>
</tr>
<tr id="homarr-value-create" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-create">homarr</a></td>
<td><code class="value-key">create</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Enables PKCS12 keystore creation for the Certificate.</td>
</tr>
<tr id="homarr-value-key" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-key">homarr</a></td>
<td><code class="value-key">key</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>test_key</code></td>
<td>Key of the entry in the Secret resource's data field to be used.</td>
</tr>
<tr id="homarr-value-name" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-name">homarr</a></td>
<td><code class="value-key">name</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>test-creds</code></td>
<td>Name of the Secret resource being referred to.</td>
</tr>
<tr id="homarr-value-create" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-create">homarr</a></td>
<td><code class="value-key">create</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enables jks keystore creation for the Certificate.</td>
</tr>
<tr id="homarr-value-key" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-key">homarr</a></td>
<td><code class="value-key">key</code></td>
<td><span class="type-badge tpl">tpl/string</span></td>
<td><code>test_key</code></td>
<td>Key of the entry in the Secret resource's data field to be used.</td>
</tr>
<tr id="homarr-value-name" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-name">homarr</a></td>
<td><code class="value-key">name</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>test-creds</code></td>
<td>Name of the Secret resource being referred to.</td>
</tr>
<tr id="homarr-value-enabled" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-enabled">homarr</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy an AlertmanagerConfig (Prometheus Operator) resource.</td>
</tr>
<tr id="homarr-value-selectionLabels" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-selectionLabels">homarr</a></td>
<td><code class="value-key">selectionLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Labels to be picked up by Alertmanager to add it to base config.</td>
</tr>
<tr id="homarr-value-spec" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-spec">homarr</a></td>
<td><code class="value-key">spec</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>AlertmanagerConfig spec.</td>
</tr>
<tr id="homarr-value-route" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-route">homarr</a></td>
<td><code class="value-key">route</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Route definition for alerts matching the resource’s namespace.</td>
</tr>
<tr id="homarr-value-receivers" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-receivers">homarr</a></td>
<td><code class="value-key">receivers</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>List of receivers.</td>
</tr>
<tr id="homarr-value-inhibitRules" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-inhibitRules">homarr</a></td>
<td><code class="value-key">inhibitRules</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Inhibition rules that allows to mute alerts when other alerts are already firing.</td>
</tr>
<tr id="homarr-value-enabled" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-enabled">homarr</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy a PrometheusRule (Prometheus Operator) resource.</td>
</tr>
<tr id="homarr-value-additionalLabels" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-additionalLabels">homarr</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for PrometheusRule.</td>
</tr>
<tr id="homarr-value-groups" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-groups">homarr</a></td>
<td><code class="value-key">groups</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Groups with alerting rules.</td>
</tr>
<tr id="homarr-value-enabled" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-enabled">homarr</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy [ExternalSecret](https://external-secrets.io/latest/) resources.</td>
</tr>
<tr id="homarr-value-additionalLabels" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-additionalLabels">homarr</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for ExternalSecret.</td>
</tr>
<tr id="homarr-value-annotations" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-annotations">homarr</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for ExternalSecret.</td>
</tr>
<tr id="homarr-value-secretStore" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-secretStore">homarr</a></td>
<td><code class="value-key">secretStore</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Default values for the SecretStore.</td>
</tr>
<tr id="homarr-value-name" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-name">homarr</a></td>
<td><code class="value-key">name</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>tenant-vault-secret-store</code></td>
<td>Name of the SecretStore to use.</td>
</tr>
<tr id="homarr-value-kind" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-kind">homarr</a></td>
<td><code class="value-key">kind</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>SecretStore</code></td>
<td>Kind of the SecretStore being refered to.</td>
</tr>
<tr id="homarr-value-refreshInterval" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-refreshInterval">homarr</a></td>
<td><code class="value-key">refreshInterval</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"1m"</code></td>
<td>RefreshInterval is the amount of time before the values are read again from the SecretStore provider.</td>
</tr>
<tr id="homarr-value-files" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-files">homarr</a></td>
<td><code class="value-key">files</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>List of ExternalSecret entries.</td>
</tr>
<tr id="homarr-value-enabled" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-enabled">homarr</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable Network Policy.</td>
</tr>
<tr id="homarr-value-additionalLabels" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-additionalLabels">homarr</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for Network Policy.</td>
</tr>
<tr id="homarr-value-annotations" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-annotations">homarr</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for Network Policy.</td>
</tr>
<tr id="homarr-value-ingress" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-ingress">homarr</a></td>
<td><code class="value-key">ingress</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Ingress rules for Network Policy.</td>
</tr>
<tr id="homarr-value-egress" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-egress">homarr</a></td>
<td><code class="value-key">egress</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Egress rules for Network Policy.</td>
</tr>
<tr id="homarr-value-enabled" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-enabled">homarr</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable Pod Disruption Budget.</td>
</tr>
<tr id="homarr-value-minAvailable" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-minAvailable">homarr</a></td>
<td><code class="value-key">minAvailable</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Minimum number of pods that must be available after eviction.</td>
</tr>
<tr id="homarr-value-maxUnavailable" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-maxUnavailable">homarr</a></td>
<td><code class="value-key">maxUnavailable</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>`nil`</code></td>
<td>Maximum number of unavailable pods during voluntary disruptions.</td>
</tr>
<tr id="homarr-value-enabled" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-enabled">homarr</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy [GrafanaDashboard](https://github.com/grafana/grafana-operator) resources.</td>
</tr>
<tr id="homarr-value-additionalLabels" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-additionalLabels">homarr</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for GrafanaDashboard.</td>
</tr>
<tr id="homarr-value-annotations" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-annotations">homarr</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for GrafanaDashboard.</td>
</tr>
<tr id="homarr-value-contents" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-contents">homarr</a></td>
<td><code class="value-key">contents</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>List of GrafanaDashboard entries.</td>
</tr>
<tr id="homarr-value-enabled" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-enabled">homarr</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Deploy a [Velero/OADP Backup](https://velero.io/docs/main/api-types/backup/) resource.</td>
</tr>
<tr id="homarr-value-namespace" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-namespace">homarr</a></td>
<td><code class="value-key">namespace</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`{{ .Release.Namespace }}`</code></td>
<td>Namespace for Backup.</td>
</tr>
<tr id="homarr-value-additionalLabels" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-additionalLabels">homarr</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Additional labels for Backup.</td>
</tr>
<tr id="homarr-value-annotations" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-annotations">homarr</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Annotations for Backup.</td>
</tr>
<tr id="homarr-value-defaultVolumesToRestic" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-defaultVolumesToRestic">homarr</a></td>
<td><code class="value-key">defaultVolumesToRestic</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Whether to use Restic to take snapshots of all pod volumes by default.</td>
</tr>
<tr id="homarr-value-snapshotVolumes" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-snapshotVolumes">homarr</a></td>
<td><code class="value-key">snapshotVolumes</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Whether to take snapshots of persistent volumes as part of the backup.</td>
</tr>
<tr id="homarr-value-storageLocation" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-storageLocation">homarr</a></td>
<td><code class="value-key">storageLocation</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Name of the backup storage location where the backup should be stored.</td>
</tr>
<tr id="homarr-value-ttl" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-ttl">homarr</a></td>
<td><code class="value-key">ttl</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"1h0m0s"</code></td>
<td>How long the Backup should be retained for.</td>
</tr>
<tr id="homarr-value-includedResources" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-includedResources">homarr</a></td>
<td><code class="value-key">includedResources</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>List of resource types to include in the backup.</td>
</tr>
<tr id="homarr-value-excludedResources" class="value-anchor" data-section="homarr">
<td><a href="../charts/homarr.md#value-excludedResources">homarr</a></td>
<td><code class="value-key">excludedResources</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>List of resource types to exclude from the backup.</td>
</tr>
<tr id="home-assistant-value-create" class="value-anchor" data-section="home-assistant">
<td><a href="../charts/home-assistant.md#value-create">home-assistant</a></td>
<td><code class="value-key">create</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Create service account</td>
</tr>
<tr id="home-assistant-value-annotations" class="value-anchor" data-section="home-assistant">
<td><a href="../charts/home-assistant.md#value-annotations">home-assistant</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Annotations for service account</td>
</tr>
<tr id="home-assistant-value-name" class="value-anchor" data-section="home-assistant">
<td><a href="../charts/home-assistant.md#value-name">home-assistant</a></td>
<td><code class="value-key">name</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Service account name</td>
</tr>
<tr id="home-assistant-value-create" class="value-anchor" data-section="home-assistant">
<td><a href="../charts/home-assistant.md#value-create">home-assistant</a></td>
<td><code class="value-key">create</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Create RBAC resources</td>
</tr>
<tr id="home-assistant-value-enabled" class="value-anchor" data-section="home-assistant">
<td><a href="../charts/home-assistant.md#value-enabled">home-assistant</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable PodDisruptionBudget</td>
</tr>
<tr id="home-assistant-value-tolerations" class="value-anchor" data-section="home-assistant">
<td><a href="../charts/home-assistant.md#value-tolerations">home-assistant</a></td>
<td><code class="value-key">tolerations</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Tolerations</td>
</tr>
<tr id="home-assistant-value-affinity" class="value-anchor" data-section="home-assistant">
<td><a href="../charts/home-assistant.md#value-affinity">home-assistant</a></td>
<td><code class="value-key">affinity</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Affinity rules</td>
</tr>
<tr id="home-assistant-value-extraVolumes" class="value-anchor" data-section="home-assistant">
<td><a href="../charts/home-assistant.md#value-extraVolumes">home-assistant</a></td>
<td><code class="value-key">extraVolumes</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>[]</code></td>
<td>Extra volumes</td>
</tr>
<tr id="home-assistant-value-extraVolumeMounts" class="value-anchor" data-section="home-assistant">
<td><a href="../charts/home-assistant.md#value-extraVolumeMounts">home-assistant</a></td>
<td><code class="value-key">extraVolumeMounts</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>[]</code></td>
<td>Extra volume mounts</td>
</tr>
<tr id="home-assistant-value-initContainers" class="value-anchor" data-section="home-assistant">
<td><a href="../charts/home-assistant.md#value-initContainers">home-assistant</a></td>
<td><code class="value-key">initContainers</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Init containers</td>
</tr>
<tr id="home-assistant-value-extraContainers" class="value-anchor" data-section="home-assistant">
<td><a href="../charts/home-assistant.md#value-extraContainers">home-assistant</a></td>
<td><code class="value-key">extraContainers</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Sidecar containers</td>
</tr>
<tr id="home-assistant-value-enabled" class="value-anchor" data-section="home-assistant">
<td><a href="../charts/home-assistant.md#value-enabled">home-assistant</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable automated configuration setup</td>
</tr>
<tr id="home-assistant-value-forceInit" class="value-anchor" data-section="home-assistant">
<td><a href="../charts/home-assistant.md#value-forceInit">home-assistant</a></td>
<td><code class="value-key">forceInit</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Force initialization on every start</td>
</tr>
<tr id="home-assistant-value-trusted_proxies" class="value-anchor" data-section="home-assistant">
<td><a href="../charts/home-assistant.md#value-trusted_proxies">home-assistant</a></td>
<td><code class="value-key">trusted_proxies</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Trusted proxy CIDR ranges for reverse proxy setups</td>
</tr>
<tr id="home-assistant-value-templateConfig" class="value-anchor" data-section="home-assistant">
<td><a href="../charts/home-assistant.md#value-templateConfig">home-assistant</a></td>
<td><code class="value-key">templateConfig</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>|-</code></td>
<td>Template for configuration.yaml file</td>
</tr>
<tr id="home-assistant-value-initScript" class="value-anchor" data-section="home-assistant">
<td><a href="../charts/home-assistant.md#value-initScript">home-assistant</a></td>
<td><code class="value-key">initScript</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>|-</code></td>
<td>Init script for configuration management</td>
</tr>
<tr id="home-assistant-value-initContainer" class="value-anchor" data-section="home-assistant">
<td><a href="../charts/home-assistant.md#value-initContainer">home-assistant</a></td>
<td><code class="value-key">initContainer</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Init container configuration</td>
</tr>
<tr id="home-assistant-value-name" class="value-anchor" data-section="home-assistant">
<td><a href="../charts/home-assistant.md#value-name">home-assistant</a></td>
<td><code class="value-key">name</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>setup-config</code></td>
<td>Init container name</td>
</tr>
<tr id="home-assistant-value-image" class="value-anchor" data-section="home-assistant">
<td><a href="../charts/home-assistant.md#value-image">home-assistant</a></td>
<td><code class="value-key">image</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>mikefarah/yq:4</code></td>
<td>Init container image (needs yq tool)</td>
</tr>
<tr id="home-assistant-value-securityContext" class="value-anchor" data-section="home-assistant">
<td><a href="../charts/home-assistant.md#value-securityContext">home-assistant</a></td>
<td><code class="value-key">securityContext</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Init container security context</td>
</tr>
<tr id="home-assistant-value-volumeMounts" class="value-anchor" data-section="home-assistant">
<td><a href="../charts/home-assistant.md#value-volumeMounts">home-assistant</a></td>
<td><code class="value-key">volumeMounts</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Additional volume mounts for init container</td>
</tr>
<tr id="it-tools-value-namespaceOverride" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-namespaceOverride">it-tools</a></td>
<td><code class="value-key">namespaceOverride</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`.Release.Namespace`</code></td>
<td>Override the namespace for all resources</td>
</tr>
<tr id="it-tools-value-nameOverride" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-nameOverride">it-tools</a></td>
<td><code class="value-key">nameOverride</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Override the name of the chart</td>
</tr>
<tr id="it-tools-value-fullnameOverride" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-fullnameOverride">it-tools</a></td>
<td><code class="value-key">fullnameOverride</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Override the full name of the chart</td>
</tr>
<tr id="it-tools-value-additionalLabels" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-additionalLabels">it-tools</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional labels to add to all resources</td>
</tr>
<tr id="it-tools-value-additionalAnnotations" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-additionalAnnotations">it-tools</a></td>
<td><code class="value-key">additionalAnnotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional annotations to add to all resources</td>
</tr>
<tr id="it-tools-value-repository" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-repository">it-tools</a></td>
<td><code class="value-key">repository</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>ghcr.io/sharevb/it-tools</code></td>
<td>Docker image repository</td>
</tr>
<tr id="it-tools-value-tag" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-tag">it-tools</a></td>
<td><code class="value-key">tag</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>Chart appVersion</code></td>
<td>Docker image tag</td>
</tr>
<tr id="it-tools-value-pullPolicy" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-pullPolicy">it-tools</a></td>
<td><code class="value-key">pullPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>IfNotPresent</code></td>
<td>Image pull policy</td>
</tr>
<tr id="it-tools-value-digest" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-digest">it-tools</a></td>
<td><code class="value-key">digest</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Image digest (overrides tag if set)</td>
</tr>
<tr id="it-tools-value-imagePullSecrets" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-imagePullSecrets">it-tools</a></td>
<td><code class="value-key">imagePullSecrets</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Image pull secrets for private registries</td>
</tr>
<tr id="it-tools-value-config" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-config">it-tools</a></td>
<td><code class="value-key">config</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Application configuration as environment variables</td>
</tr>
<tr id="it-tools-value-existingSecret" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-existingSecret">it-tools</a></td>
<td><code class="value-key">existingSecret</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Name of an existing secret containing application credentials</td>
</tr>
<tr id="it-tools-value-type" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-type">it-tools</a></td>
<td><code class="value-key">type</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>deployment</code></td>
<td>Controller type (deployment or statefulset)</td>
</tr>
<tr id="it-tools-value-replicas" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-replicas">it-tools</a></td>
<td><code class="value-key">replicas</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Number of replicas</td>
</tr>
<tr id="it-tools-value-strategy" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-strategy">it-tools</a></td>
<td><code class="value-key">strategy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Deployment update strategy</td>
</tr>
<tr id="it-tools-value-updateStrategy" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-updateStrategy">it-tools</a></td>
<td><code class="value-key">updateStrategy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>StatefulSet update strategy (only used if controller.type is statefulset)</td>
</tr>
<tr id="it-tools-value-podManagementPolicy" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-podManagementPolicy">it-tools</a></td>
<td><code class="value-key">podManagementPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>OrderedReady</code></td>
<td>Pod management policy (only used if controller.type is statefulset)</td>
</tr>
<tr id="it-tools-value-command" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-command">it-tools</a></td>
<td><code class="value-key">command</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Command override for the main container</td>
</tr>
<tr id="it-tools-value-args" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-args">it-tools</a></td>
<td><code class="value-key">args</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Args override for the main container</td>
</tr>
<tr id="it-tools-value-workingDir" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-workingDir">it-tools</a></td>
<td><code class="value-key">workingDir</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Working directory for the main container</td>
</tr>
<tr id="it-tools-value-terminationGracePeriodSeconds" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-terminationGracePeriodSeconds">it-tools</a></td>
<td><code class="value-key">terminationGracePeriodSeconds</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>30</code></td>
<td>Termination grace period in seconds</td>
</tr>
<tr id="it-tools-value-lifecycle" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-lifecycle">it-tools</a></td>
<td><code class="value-key">lifecycle</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Lifecycle hooks for the main container</td>
</tr>
<tr id="it-tools-value-type" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-type">it-tools</a></td>
<td><code class="value-key">type</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>ClusterIP</code></td>
<td>Service type</td>
</tr>
<tr id="it-tools-value-port" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-port">it-tools</a></td>
<td><code class="value-key">port</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>80</code></td>
<td>Service port</td>
</tr>
<tr id="it-tools-value-targetPort" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-targetPort">it-tools</a></td>
<td><code class="value-key">targetPort</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>8080</code></td>
<td>Service target port (container port)</td>
</tr>
<tr id="it-tools-value-nodePort" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-nodePort">it-tools</a></td>
<td><code class="value-key">nodePort</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Node port (only used if type is NodePort)</td>
</tr>
<tr id="it-tools-value-loadBalancerIP" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-loadBalancerIP">it-tools</a></td>
<td><code class="value-key">loadBalancerIP</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Load balancer IP (only used if type is LoadBalancer)</td>
</tr>
<tr id="it-tools-value-loadBalancerSourceRanges" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-loadBalancerSourceRanges">it-tools</a></td>
<td><code class="value-key">loadBalancerSourceRanges</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Load balancer source ranges (only used if type is LoadBalancer)</td>
</tr>
<tr id="it-tools-value-externalTrafficPolicy" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-externalTrafficPolicy">it-tools</a></td>
<td><code class="value-key">externalTrafficPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>External traffic policy (only used if type is LoadBalancer or NodePort)</td>
</tr>
<tr id="it-tools-value-clusterIP" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-clusterIP">it-tools</a></td>
<td><code class="value-key">clusterIP</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Cluster IP (set to None for headless service)</td>
</tr>
<tr id="it-tools-value-sessionAffinity" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-sessionAffinity">it-tools</a></td>
<td><code class="value-key">sessionAffinity</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>None</code></td>
<td>Session affinity</td>
</tr>
<tr id="it-tools-value-sessionAffinityConfig" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-sessionAffinityConfig">it-tools</a></td>
<td><code class="value-key">sessionAffinityConfig</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Session affinity config</td>
</tr>
<tr id="it-tools-value-annotations" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-annotations">it-tools</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Service annotations</td>
</tr>
<tr id="it-tools-value-labels" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-labels">it-tools</a></td>
<td><code class="value-key">labels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Service labels</td>
</tr>
<tr id="it-tools-value-enabled" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-enabled">it-tools</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable ingress</td>
</tr>
<tr id="it-tools-value-className" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-className">it-tools</a></td>
<td><code class="value-key">className</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Ingress class name</td>
</tr>
<tr id="it-tools-value-annotations" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-annotations">it-tools</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Ingress annotations</td>
</tr>
<tr id="it-tools-value-hosts" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-hosts">it-tools</a></td>
<td><code class="value-key">hosts</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Ingress hosts configuration</td>
</tr>
<tr id="it-tools-value-tls" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-tls">it-tools</a></td>
<td><code class="value-key">tls</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Ingress TLS configuration</td>
</tr>
<tr id="it-tools-value-enabled" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-enabled">it-tools</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable persistent storage</td>
</tr>
<tr id="it-tools-value-storageClassName" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-storageClassName">it-tools</a></td>
<td><code class="value-key">storageClassName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>Default storage class</code></td>
<td>Storage class name</td>
</tr>
<tr id="it-tools-value-accessMode" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-accessMode">it-tools</a></td>
<td><code class="value-key">accessMode</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>ReadWriteOnce</code></td>
<td>Access mode for the persistent volume</td>
</tr>
<tr id="it-tools-value-size" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-size">it-tools</a></td>
<td><code class="value-key">size</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>1Gi</code></td>
<td>Size of the persistent volume</td>
</tr>
<tr id="it-tools-value-existingClaim" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-existingClaim">it-tools</a></td>
<td><code class="value-key">existingClaim</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Name of an existing PVC to use</td>
</tr>
<tr id="it-tools-value-annotations" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-annotations">it-tools</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Annotations for the PVC</td>
</tr>
<tr id="it-tools-value-mountPath" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-mountPath">it-tools</a></td>
<td><code class="value-key">mountPath</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>/data</code></td>
<td>Mount path for the persistent volume</td>
</tr>
<tr id="it-tools-value-podSecurityContext" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-podSecurityContext">it-tools</a></td>
<td><code class="value-key">podSecurityContext</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Pod security context</td>
</tr>
<tr id="it-tools-value-securityContext" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-securityContext">it-tools</a></td>
<td><code class="value-key">securityContext</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Container security context</td>
</tr>
<tr id="it-tools-value-resources" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-resources">it-tools</a></td>
<td><code class="value-key">resources</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Resource limits and requests</td>
</tr>
<tr id="it-tools-value-livenessProbe" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-livenessProbe">it-tools</a></td>
<td><code class="value-key">livenessProbe</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Liveness probe configuration</td>
</tr>
<tr id="it-tools-value-readinessProbe" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-readinessProbe">it-tools</a></td>
<td><code class="value-key">readinessProbe</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Readiness probe configuration</td>
</tr>
<tr id="it-tools-value-startupProbe" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-startupProbe">it-tools</a></td>
<td><code class="value-key">startupProbe</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Startup probe configuration</td>
</tr>
<tr id="it-tools-value-podAnnotations" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-podAnnotations">it-tools</a></td>
<td><code class="value-key">podAnnotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Pod annotations</td>
</tr>
<tr id="it-tools-value-podLabels" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-podLabels">it-tools</a></td>
<td><code class="value-key">podLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Pod labels</td>
</tr>
<tr id="it-tools-value-nodeSelector" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-nodeSelector">it-tools</a></td>
<td><code class="value-key">nodeSelector</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Node selector for pod assignment</td>
</tr>
<tr id="it-tools-value-tolerations" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-tolerations">it-tools</a></td>
<td><code class="value-key">tolerations</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Tolerations for pod assignment</td>
</tr>
<tr id="it-tools-value-affinity" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-affinity">it-tools</a></td>
<td><code class="value-key">affinity</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Affinity for pod assignment</td>
</tr>
<tr id="it-tools-value-priorityClassName" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-priorityClassName">it-tools</a></td>
<td><code class="value-key">priorityClassName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Priority class name for the pod</td>
</tr>
<tr id="it-tools-value-topologySpreadConstraints" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-topologySpreadConstraints">it-tools</a></td>
<td><code class="value-key">topologySpreadConstraints</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Topology spread constraints for pod distribution</td>
</tr>
<tr id="it-tools-value-dnsPolicy" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-dnsPolicy">it-tools</a></td>
<td><code class="value-key">dnsPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>ClusterFirst</code></td>
<td>DNS policy</td>
</tr>
<tr id="it-tools-value-dnsConfig" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-dnsConfig">it-tools</a></td>
<td><code class="value-key">dnsConfig</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>DNS config</td>
</tr>
<tr id="it-tools-value-hostAliases" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-hostAliases">it-tools</a></td>
<td><code class="value-key">hostAliases</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Host aliases</td>
</tr>
<tr id="it-tools-value-runtimeClassName" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-runtimeClassName">it-tools</a></td>
<td><code class="value-key">runtimeClassName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Runtime class name</td>
</tr>
<tr id="it-tools-value-initContainers" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-initContainers">it-tools</a></td>
<td><code class="value-key">initContainers</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Init containers to run before the main container</td>
</tr>
<tr id="it-tools-value-extraContainers" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-extraContainers">it-tools</a></td>
<td><code class="value-key">extraContainers</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Extra sidecar containers</td>
</tr>
<tr id="it-tools-value-extraEnv" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-extraEnv">it-tools</a></td>
<td><code class="value-key">extraEnv</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Extra environment variables</td>
</tr>
<tr id="it-tools-value-extraEnvFrom" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-extraEnvFrom">it-tools</a></td>
<td><code class="value-key">extraEnvFrom</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Extra environment variables from ConfigMaps or Secrets</td>
</tr>
<tr id="it-tools-value-extraVolumes" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-extraVolumes">it-tools</a></td>
<td><code class="value-key">extraVolumes</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Extra volumes</td>
</tr>
<tr id="it-tools-value-extraVolumeMounts" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-extraVolumeMounts">it-tools</a></td>
<td><code class="value-key">extraVolumeMounts</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Extra volume mounts</td>
</tr>
<tr id="it-tools-value-enabled" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-enabled">it-tools</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable ServiceMonitor for Prometheus Operator</td>
</tr>
<tr id="it-tools-value-namespace" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-namespace">it-tools</a></td>
<td><code class="value-key">namespace</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Namespace for the ServiceMonitor (defaults to the release namespace)</td>
</tr>
<tr id="it-tools-value-interval" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-interval">it-tools</a></td>
<td><code class="value-key">interval</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>30s</code></td>
<td>Interval at which metrics should be scraped</td>
</tr>
<tr id="it-tools-value-scrapeTimeout" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-scrapeTimeout">it-tools</a></td>
<td><code class="value-key">scrapeTimeout</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>10s</code></td>
<td>Timeout for scraping metrics</td>
</tr>
<tr id="it-tools-value-labels" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-labels">it-tools</a></td>
<td><code class="value-key">labels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional labels for the ServiceMonitor</td>
</tr>
<tr id="it-tools-value-annotations" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-annotations">it-tools</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional annotations for the ServiceMonitor</td>
</tr>
<tr id="it-tools-value-metricRelabelings" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-metricRelabelings">it-tools</a></td>
<td><code class="value-key">metricRelabelings</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Metric relabelings</td>
</tr>
<tr id="it-tools-value-relabelings" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-relabelings">it-tools</a></td>
<td><code class="value-key">relabelings</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Relabelings</td>
</tr>
<tr id="it-tools-value-enabled" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-enabled">it-tools</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable PrometheusRule for alerting</td>
</tr>
<tr id="it-tools-value-namespace" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-namespace">it-tools</a></td>
<td><code class="value-key">namespace</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Namespace for the PrometheusRule (defaults to the release namespace)</td>
</tr>
<tr id="it-tools-value-labels" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-labels">it-tools</a></td>
<td><code class="value-key">labels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional labels for the PrometheusRule</td>
</tr>
<tr id="it-tools-value-rules" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-rules">it-tools</a></td>
<td><code class="value-key">rules</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Alert rules</td>
</tr>
<tr id="it-tools-value-enabled" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-enabled">it-tools</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable PodDisruptionBudget</td>
</tr>
<tr id="it-tools-value-minAvailable" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-minAvailable">it-tools</a></td>
<td><code class="value-key">minAvailable</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Minimum number of pods that must be available</td>
</tr>
<tr id="it-tools-value-maxUnavailable" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-maxUnavailable">it-tools</a></td>
<td><code class="value-key">maxUnavailable</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Maximum number of pods that can be unavailable</td>
</tr>
<tr id="it-tools-value-hpa" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-hpa">it-tools</a></td>
<td><code class="value-key">hpa</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Horizontal Pod Autoscaler configuration</td>
</tr>
<tr id="it-tools-value-enabled" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-enabled">it-tools</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable HorizontalPodAutoscaler</td>
</tr>
<tr id="it-tools-value-minReplicas" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-minReplicas">it-tools</a></td>
<td><code class="value-key">minReplicas</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Minimum number of replicas</td>
</tr>
<tr id="it-tools-value-maxReplicas" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-maxReplicas">it-tools</a></td>
<td><code class="value-key">maxReplicas</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>3</code></td>
<td>Maximum number of replicas</td>
</tr>
<tr id="it-tools-value-targetCPUUtilizationPercentage" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-targetCPUUtilizationPercentage">it-tools</a></td>
<td><code class="value-key">targetCPUUtilizationPercentage</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>80</code></td>
<td>Target CPU utilization percentage</td>
</tr>
<tr id="it-tools-value-targetMemoryUtilizationPercentage" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-targetMemoryUtilizationPercentage">it-tools</a></td>
<td><code class="value-key">targetMemoryUtilizationPercentage</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>80</code></td>
<td>Target memory utilization percentage</td>
</tr>
<tr id="it-tools-value-customMetrics" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-customMetrics">it-tools</a></td>
<td><code class="value-key">customMetrics</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Custom metrics for autoscaling</td>
</tr>
<tr id="it-tools-value-create" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-create">it-tools</a></td>
<td><code class="value-key">create</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Create a service account</td>
</tr>
<tr id="it-tools-value-name" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-name">it-tools</a></td>
<td><code class="value-key">name</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Service account name (generated if not set and create is true)</td>
</tr>
<tr id="it-tools-value-annotations" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-annotations">it-tools</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Service account annotations</td>
</tr>
<tr id="it-tools-value-create" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-create">it-tools</a></td>
<td><code class="value-key">create</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Create RBAC resources</td>
</tr>
<tr id="it-tools-value-rules" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-rules">it-tools</a></td>
<td><code class="value-key">rules</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Additional RBAC rules</td>
</tr>
<tr id="it-tools-value-enabled" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-enabled">it-tools</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable network policy</td>
</tr>
<tr id="it-tools-value-policyTypes" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-policyTypes">it-tools</a></td>
<td><code class="value-key">policyTypes</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Policy types</td>
</tr>
<tr id="it-tools-value-ingress" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-ingress">it-tools</a></td>
<td><code class="value-key">ingress</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Ingress rules</td>
</tr>
<tr id="it-tools-value-egress" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-egress">it-tools</a></td>
<td><code class="value-key">egress</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Egress rules</td>
</tr>
<tr id="it-tools-value-enabled" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-enabled">it-tools</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable diagnostic mode (disables probes, overrides command)</td>
</tr>
<tr id="it-tools-value-command" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-command">it-tools</a></td>
<td><code class="value-key">command</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Command override for diagnostic mode</td>
</tr>
<tr id="it-tools-value-args" class="value-anchor" data-section="it-tools">
<td><a href="../charts/it-tools.md#value-args">it-tools</a></td>
<td><code class="value-key">args</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Args override for diagnostic mode</td>
</tr>
<tr id="nginx-value-replicaCount" class="value-anchor" data-section="nginx">
<td><a href="../charts/nginx.md#value-replicaCount">nginx</a></td>
<td><code class="value-key">replicaCount</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>3</code></td>
<td>Number of replicas for the deployment.</td>
</tr>
<tr id="nginx-value-repository" class="value-anchor" data-section="nginx">
<td><a href="../charts/nginx.md#value-repository">nginx</a></td>
<td><code class="value-key">repository</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>nginx</code></td>
<td>Container image repository.</td>
</tr>
<tr id="nginx-value-pullPolicy" class="value-anchor" data-section="nginx">
<td><a href="../charts/nginx.md#value-pullPolicy">nginx</a></td>
<td><code class="value-key">pullPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>IfNotPresent</code></td>
<td>Image pull policy.</td>
</tr>
<tr id="nginx-value-tag" class="value-anchor" data-section="nginx">
<td><a href="../charts/nginx.md#value-tag">nginx</a></td>
<td><code class="value-key">tag</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Overrides the image tag whose default is the chart appVersion.</td>
</tr>
<tr id="nginx-value-imagePullSecrets" class="value-anchor" data-section="nginx">
<td><a href="../charts/nginx.md#value-imagePullSecrets">nginx</a></td>
<td><code class="value-key">imagePullSecrets</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Secrets for pulling images from a private repository.</td>
</tr>
<tr id="nginx-value-nameOverride" class="value-anchor" data-section="nginx">
<td><a href="../charts/nginx.md#value-nameOverride">nginx</a></td>
<td><code class="value-key">nameOverride</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Override the chart name.</td>
</tr>
<tr id="nginx-value-fullnameOverride" class="value-anchor" data-section="nginx">
<td><a href="../charts/nginx.md#value-fullnameOverride">nginx</a></td>
<td><code class="value-key">fullnameOverride</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Override the full name.</td>
</tr>
<tr id="nginx-value-create" class="value-anchor" data-section="nginx">
<td><a href="../charts/nginx.md#value-create">nginx</a></td>
<td><code class="value-key">create</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Specifies whether a service account should be created.</td>
</tr>
<tr id="nginx-value-automount" class="value-anchor" data-section="nginx">
<td><a href="../charts/nginx.md#value-automount">nginx</a></td>
<td><code class="value-key">automount</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Automatically mount a ServiceAccount's API credentials.</td>
</tr>
<tr id="nginx-value-annotations" class="value-anchor" data-section="nginx">
<td><a href="../charts/nginx.md#value-annotations">nginx</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Annotations to add to the service account.</td>
</tr>
<tr id="nginx-value-name" class="value-anchor" data-section="nginx">
<td><a href="../charts/nginx.md#value-name">nginx</a></td>
<td><code class="value-key">name</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>The name of the service account to use. If not set and create is true, a name is generated.</td>
</tr>
<tr id="nginx-value-podAnnotations" class="value-anchor" data-section="nginx">
<td><a href="../charts/nginx.md#value-podAnnotations">nginx</a></td>
<td><code class="value-key">podAnnotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Annotations for pods.</td>
</tr>
<tr id="nginx-value-podLabels" class="value-anchor" data-section="nginx">
<td><a href="../charts/nginx.md#value-podLabels">nginx</a></td>
<td><code class="value-key">podLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Labels for pods.</td>
</tr>
<tr id="nginx-value-podSecurityContext" class="value-anchor" data-section="nginx">
<td><a href="../charts/nginx.md#value-podSecurityContext">nginx</a></td>
<td><code class="value-key">podSecurityContext</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Pod security context.</td>
</tr>
<tr id="nginx-value-securityContext" class="value-anchor" data-section="nginx">
<td><a href="../charts/nginx.md#value-securityContext">nginx</a></td>
<td><code class="value-key">securityContext</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Container security context.</td>
</tr>
<tr id="nginx-value-type" class="value-anchor" data-section="nginx">
<td><a href="../charts/nginx.md#value-type">nginx</a></td>
<td><code class="value-key">type</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>ClusterIP</code></td>
<td>Service type (ClusterIP, NodePort, LoadBalancer).</td>
</tr>
<tr id="nginx-value-port" class="value-anchor" data-section="nginx">
<td><a href="../charts/nginx.md#value-port">nginx</a></td>
<td><code class="value-key">port</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>80</code></td>
<td>Service port.</td>
</tr>
<tr id="nginx-value-enabled" class="value-anchor" data-section="nginx">
<td><a href="../charts/nginx.md#value-enabled">nginx</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable ingress.</td>
</tr>
<tr id="nginx-value-className" class="value-anchor" data-section="nginx">
<td><a href="../charts/nginx.md#value-className">nginx</a></td>
<td><code class="value-key">className</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Ingress class name.</td>
</tr>
<tr id="nginx-value-annotations" class="value-anchor" data-section="nginx">
<td><a href="../charts/nginx.md#value-annotations">nginx</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Ingress annotations.</td>
</tr>
<tr id="nginx-value-hosts" class="value-anchor" data-section="nginx">
<td><a href="../charts/nginx.md#value-hosts">nginx</a></td>
<td><code class="value-key">hosts</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Ingress hosts configuration.</td>
</tr>
<tr id="nginx-value-tls" class="value-anchor" data-section="nginx">
<td><a href="../charts/nginx.md#value-tls">nginx</a></td>
<td><code class="value-key">tls</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Ingress TLS configuration.</td>
</tr>
<tr id="nginx-value-resources" class="value-anchor" data-section="nginx">
<td><a href="../charts/nginx.md#value-resources">nginx</a></td>
<td><code class="value-key">resources</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Resource limits and requests.</td>
</tr>
<tr id="nginx-value-livenessProbe" class="value-anchor" data-section="nginx">
<td><a href="../charts/nginx.md#value-livenessProbe">nginx</a></td>
<td><code class="value-key">livenessProbe</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Liveness probe configuration.</td>
</tr>
<tr id="nginx-value-readinessProbe" class="value-anchor" data-section="nginx">
<td><a href="../charts/nginx.md#value-readinessProbe">nginx</a></td>
<td><code class="value-key">readinessProbe</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Readiness probe configuration.</td>
</tr>
<tr id="nginx-value-enabled" class="value-anchor" data-section="nginx">
<td><a href="../charts/nginx.md#value-enabled">nginx</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable horizontal pod autoscaling.</td>
</tr>
<tr id="nginx-value-minReplicas" class="value-anchor" data-section="nginx">
<td><a href="../charts/nginx.md#value-minReplicas">nginx</a></td>
<td><code class="value-key">minReplicas</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Minimum number of replicas.</td>
</tr>
<tr id="nginx-value-maxReplicas" class="value-anchor" data-section="nginx">
<td><a href="../charts/nginx.md#value-maxReplicas">nginx</a></td>
<td><code class="value-key">maxReplicas</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>100</code></td>
<td>Maximum number of replicas.</td>
</tr>
<tr id="nginx-value-targetCPUUtilizationPercentage" class="value-anchor" data-section="nginx">
<td><a href="../charts/nginx.md#value-targetCPUUtilizationPercentage">nginx</a></td>
<td><code class="value-key">targetCPUUtilizationPercentage</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>80</code></td>
<td>Target CPU utilization percentage.</td>
</tr>
<tr id="nginx-value-volumes" class="value-anchor" data-section="nginx">
<td><a href="../charts/nginx.md#value-volumes">nginx</a></td>
<td><code class="value-key">volumes</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Additional volumes for the deployment.</td>
</tr>
<tr id="nginx-value-volumeMounts" class="value-anchor" data-section="nginx">
<td><a href="../charts/nginx.md#value-volumeMounts">nginx</a></td>
<td><code class="value-key">volumeMounts</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Additional volume mounts for the deployment.</td>
</tr>
<tr id="nginx-value-nodeSelector" class="value-anchor" data-section="nginx">
<td><a href="../charts/nginx.md#value-nodeSelector">nginx</a></td>
<td><code class="value-key">nodeSelector</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Node selector for pod scheduling.</td>
</tr>
<tr id="nginx-value-tolerations" class="value-anchor" data-section="nginx">
<td><a href="../charts/nginx.md#value-tolerations">nginx</a></td>
<td><code class="value-key">tolerations</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Tolerations for pod scheduling.</td>
</tr>
<tr id="nginx-value-affinity" class="value-anchor" data-section="nginx">
<td><a href="../charts/nginx.md#value-affinity">nginx</a></td>
<td><code class="value-key">affinity</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Affinity rules for pod scheduling.</td>
</tr>
<tr id="pgadmin-value-namespaceOverride" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-namespaceOverride">pgadmin</a></td>
<td><code class="value-key">namespaceOverride</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`.Release.Namespace`</code></td>
<td>Override the namespace for all resources</td>
</tr>
<tr id="pgadmin-value-nameOverride" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-nameOverride">pgadmin</a></td>
<td><code class="value-key">nameOverride</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Override the name of the chart</td>
</tr>
<tr id="pgadmin-value-fullnameOverride" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-fullnameOverride">pgadmin</a></td>
<td><code class="value-key">fullnameOverride</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Override the full name of the chart</td>
</tr>
<tr id="pgadmin-value-additionalLabels" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-additionalLabels">pgadmin</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional labels to add to all resources</td>
</tr>
<tr id="pgadmin-value-additionalAnnotations" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-additionalAnnotations">pgadmin</a></td>
<td><code class="value-key">additionalAnnotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional annotations to add to all resources</td>
</tr>
<tr id="pgadmin-value-repository" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-repository">pgadmin</a></td>
<td><code class="value-key">repository</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>dpage/pgadmin4</code></td>
<td>pgAdmin 4 Docker image repository</td>
</tr>
<tr id="pgadmin-value-tag" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-tag">pgadmin</a></td>
<td><code class="value-key">tag</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>Chart appVersion</code></td>
<td>pgAdmin 4 Docker image tag</td>
</tr>
<tr id="pgadmin-value-pullPolicy" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-pullPolicy">pgadmin</a></td>
<td><code class="value-key">pullPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>IfNotPresent</code></td>
<td>Image pull policy</td>
</tr>
<tr id="pgadmin-value-digest" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-digest">pgadmin</a></td>
<td><code class="value-key">digest</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Image digest (overrides tag if set)</td>
</tr>
<tr id="pgadmin-value-imagePullSecrets" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-imagePullSecrets">pgadmin</a></td>
<td><code class="value-key">imagePullSecrets</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Image pull secrets for private registries</td>
</tr>
<tr id="pgadmin-value-email" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-email">pgadmin</a></td>
<td><code class="value-key">email</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"admin@example.com"</code></td>
<td>Default pgAdmin login email address (required if existingSecret is not set)</td>
</tr>
<tr id="pgadmin-value-password" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-password">pgadmin</a></td>
<td><code class="value-key">password</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"changeme" (MUST be changed in production)</code></td>
<td>Default pgAdmin login password (required if existingSecret is not set)</td>
</tr>
<tr id="pgadmin-value-existingSecret" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-existingSecret">pgadmin</a></td>
<td><code class="value-key">existingSecret</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Name of an existing secret containing pgAdmin credentials</td>
</tr>
<tr id="pgadmin-value-existingSecretEmailKey" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-existingSecretEmailKey">pgadmin</a></td>
<td><code class="value-key">existingSecretEmailKey</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"email"</code></td>
<td>Key in existingSecret that contains the email address</td>
</tr>
<tr id="pgadmin-value-existingSecretPasswordKey" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-existingSecretPasswordKey">pgadmin</a></td>
<td><code class="value-key">existingSecretPasswordKey</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"password"</code></td>
<td>Key in existingSecret that contains the password</td>
</tr>
<tr id="pgadmin-value-config" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-config">pgadmin</a></td>
<td><code class="value-key">config</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>pgAdmin configuration settings as environment variables</td>
</tr>
<tr id="pgadmin-value-disablePostfix" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-disablePostfix">pgadmin</a></td>
<td><code class="value-key">disablePostfix</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Disable internal Postfix server (set to any value to disable)</td>
</tr>
<tr id="pgadmin-value-replaceServersOnStartup" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-replaceServersOnStartup">pgadmin</a></td>
<td><code class="value-key">replaceServersOnStartup</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Replace server definitions on every startup (not just first launch)</td>
</tr>
<tr id="pgadmin-value-scriptName" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-scriptName">pgadmin</a></td>
<td><code class="value-key">scriptName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Script name for reverse proxy subdirectory hosting</td>
</tr>
<tr id="pgadmin-value-gunicorn" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-gunicorn">pgadmin</a></td>
<td><code class="value-key">gunicorn</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Gunicorn configuration</td>
</tr>
<tr id="pgadmin-value-threads" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-threads">pgadmin</a></td>
<td><code class="value-key">threads</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>25</code></td>
<td>Number of threads per Gunicorn worker</td>
</tr>
<tr id="pgadmin-value-accessLogfile" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-accessLogfile">pgadmin</a></td>
<td><code class="value-key">accessLogfile</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"-"</code></td>
<td>Access log file path (- for stdout, empty to disable)</td>
</tr>
<tr id="pgadmin-value-limitRequestLine" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-limitRequestLine">pgadmin</a></td>
<td><code class="value-key">limitRequestLine</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>8190</code></td>
<td>Maximum size of HTTP request line in bytes (0 for unlimited, not recommended)</td>
</tr>
<tr id="pgadmin-value-serverDefinitions" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-serverDefinitions">pgadmin</a></td>
<td><code class="value-key">serverDefinitions</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Pre-configured PostgreSQL server definitions</td>
</tr>
<tr id="pgadmin-value-existingServerDefinitionsConfigMap" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-existingServerDefinitionsConfigMap">pgadmin</a></td>
<td><code class="value-key">existingServerDefinitionsConfigMap</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Name of an existing ConfigMap containing server definitions (servers.json)</td>
</tr>
<tr id="pgadmin-value-pgpassFile" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-pgpassFile">pgadmin</a></td>
<td><code class="value-key">pgpassFile</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>pgpass file content for automatic PostgreSQL authentication</td>
</tr>
<tr id="pgadmin-value-existingPgpassSecret" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-existingPgpassSecret">pgadmin</a></td>
<td><code class="value-key">existingPgpassSecret</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Name of an existing Secret containing pgpass file</td>
</tr>
<tr id="pgadmin-value-configLocal" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-configLocal">pgadmin</a></td>
<td><code class="value-key">configLocal</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Custom config_local.py content for advanced pgAdmin configuration</td>
</tr>
<tr id="pgadmin-value-existingConfigLocalConfigMap" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-existingConfigLocalConfigMap">pgadmin</a></td>
<td><code class="value-key">existingConfigLocalConfigMap</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Name of an existing ConfigMap containing config_local.py</td>
</tr>
<tr id="pgadmin-value-smtp" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-smtp">pgadmin</a></td>
<td><code class="value-key">smtp</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>SMTP/Email configuration for notifications and user management</td>
</tr>
<tr id="pgadmin-value-enabled" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-enabled">pgadmin</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable SMTP configuration</td>
</tr>
<tr id="pgadmin-value-server" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-server">pgadmin</a></td>
<td><code class="value-key">server</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>SMTP server host</td>
</tr>
<tr id="pgadmin-value-port" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-port">pgadmin</a></td>
<td><code class="value-key">port</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>587</code></td>
<td>SMTP server port</td>
</tr>
<tr id="pgadmin-value-useTLS" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-useTLS">pgadmin</a></td>
<td><code class="value-key">useTLS</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Use TLS for SMTP</td>
</tr>
<tr id="pgadmin-value-useSSL" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-useSSL">pgadmin</a></td>
<td><code class="value-key">useSSL</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Use SSL for SMTP</td>
</tr>
<tr id="pgadmin-value-username" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-username">pgadmin</a></td>
<td><code class="value-key">username</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>SMTP username</td>
</tr>
<tr id="pgadmin-value-password" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-password">pgadmin</a></td>
<td><code class="value-key">password</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>SMTP password</td>
</tr>
<tr id="pgadmin-value-existingSecret" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-existingSecret">pgadmin</a></td>
<td><code class="value-key">existingSecret</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Name of existing secret containing SMTP credentials</td>
</tr>
<tr id="pgadmin-value-existingSecretUsernameKey" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-existingSecretUsernameKey">pgadmin</a></td>
<td><code class="value-key">existingSecretUsernameKey</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"smtp-username"</code></td>
<td>Key in existingSecret for SMTP username</td>
</tr>
<tr id="pgadmin-value-existingSecretPasswordKey" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-existingSecretPasswordKey">pgadmin</a></td>
<td><code class="value-key">existingSecretPasswordKey</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"smtp-password"</code></td>
<td>Key in existingSecret for SMTP password</td>
</tr>
<tr id="pgadmin-value-fromAddress" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-fromAddress">pgadmin</a></td>
<td><code class="value-key">fromAddress</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"pgadmin@example.com"</code></td>
<td>Email sender address</td>
</tr>
<tr id="pgadmin-value-ldap" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-ldap">pgadmin</a></td>
<td><code class="value-key">ldap</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>LDAP/OAuth integration configuration</td>
</tr>
<tr id="pgadmin-value-enabled" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-enabled">pgadmin</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable LDAP authentication</td>
</tr>
<tr id="pgadmin-value-server" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-server">pgadmin</a></td>
<td><code class="value-key">server</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>LDAP server URI</td>
</tr>
<tr id="pgadmin-value-bindDN" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-bindDN">pgadmin</a></td>
<td><code class="value-key">bindDN</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>LDAP bind DN</td>
</tr>
<tr id="pgadmin-value-bindPassword" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-bindPassword">pgadmin</a></td>
<td><code class="value-key">bindPassword</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>LDAP bind password</td>
</tr>
<tr id="pgadmin-value-userBaseDN" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-userBaseDN">pgadmin</a></td>
<td><code class="value-key">userBaseDN</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>LDAP user base DN</td>
</tr>
<tr id="pgadmin-value-groupBaseDN" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-groupBaseDN">pgadmin</a></td>
<td><code class="value-key">groupBaseDN</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>LDAP group base DN</td>
</tr>
<tr id="pgadmin-value-type" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-type">pgadmin</a></td>
<td><code class="value-key">type</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>deployment</code></td>
<td>Controller type (deployment or statefulset)</td>
</tr>
<tr id="pgadmin-value-replicas" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-replicas">pgadmin</a></td>
<td><code class="value-key">replicas</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Number of pgAdmin replicas</td>
</tr>
<tr id="pgadmin-value-strategy" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-strategy">pgadmin</a></td>
<td><code class="value-key">strategy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Deployment update strategy</td>
</tr>
<tr id="pgadmin-value-updateStrategy" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-updateStrategy">pgadmin</a></td>
<td><code class="value-key">updateStrategy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>StatefulSet update strategy (only used if controller.type is statefulset)</td>
</tr>
<tr id="pgadmin-value-podManagementPolicy" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-podManagementPolicy">pgadmin</a></td>
<td><code class="value-key">podManagementPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>OrderedReady</code></td>
<td>Pod management policy (only used if controller.type is statefulset)</td>
</tr>
<tr id="pgadmin-value-command" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-command">pgadmin</a></td>
<td><code class="value-key">command</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Command override for the main container</td>
</tr>
<tr id="pgadmin-value-args" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-args">pgadmin</a></td>
<td><code class="value-key">args</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Args override for the main container</td>
</tr>
<tr id="pgadmin-value-workingDir" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-workingDir">pgadmin</a></td>
<td><code class="value-key">workingDir</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Working directory for the main container</td>
</tr>
<tr id="pgadmin-value-terminationGracePeriodSeconds" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-terminationGracePeriodSeconds">pgadmin</a></td>
<td><code class="value-key">terminationGracePeriodSeconds</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>30</code></td>
<td>Termination grace period in seconds</td>
</tr>
<tr id="pgadmin-value-lifecycle" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-lifecycle">pgadmin</a></td>
<td><code class="value-key">lifecycle</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Lifecycle hooks for the main container</td>
</tr>
<tr id="pgadmin-value-type" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-type">pgadmin</a></td>
<td><code class="value-key">type</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>ClusterIP</code></td>
<td>Service type</td>
</tr>
<tr id="pgadmin-value-port" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-port">pgadmin</a></td>
<td><code class="value-key">port</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>80</code></td>
<td>Service port</td>
</tr>
<tr id="pgadmin-value-targetPort" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-targetPort">pgadmin</a></td>
<td><code class="value-key">targetPort</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>80</code></td>
<td>Service target port (container port)</td>
</tr>
<tr id="pgadmin-value-nodePort" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-nodePort">pgadmin</a></td>
<td><code class="value-key">nodePort</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Node port (only used if type is NodePort)</td>
</tr>
<tr id="pgadmin-value-loadBalancerIP" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-loadBalancerIP">pgadmin</a></td>
<td><code class="value-key">loadBalancerIP</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Load balancer IP (only used if type is LoadBalancer)</td>
</tr>
<tr id="pgadmin-value-loadBalancerSourceRanges" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-loadBalancerSourceRanges">pgadmin</a></td>
<td><code class="value-key">loadBalancerSourceRanges</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Load balancer source ranges (only used if type is LoadBalancer)</td>
</tr>
<tr id="pgadmin-value-externalTrafficPolicy" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-externalTrafficPolicy">pgadmin</a></td>
<td><code class="value-key">externalTrafficPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>External traffic policy (only used if type is LoadBalancer or NodePort)</td>
</tr>
<tr id="pgadmin-value-clusterIP" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-clusterIP">pgadmin</a></td>
<td><code class="value-key">clusterIP</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Cluster IP (set to None for headless service)</td>
</tr>
<tr id="pgadmin-value-sessionAffinity" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-sessionAffinity">pgadmin</a></td>
<td><code class="value-key">sessionAffinity</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>None</code></td>
<td>Session affinity</td>
</tr>
<tr id="pgadmin-value-sessionAffinityConfig" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-sessionAffinityConfig">pgadmin</a></td>
<td><code class="value-key">sessionAffinityConfig</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Session affinity config</td>
</tr>
<tr id="pgadmin-value-annotations" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-annotations">pgadmin</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Service annotations</td>
</tr>
<tr id="pgadmin-value-labels" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-labels">pgadmin</a></td>
<td><code class="value-key">labels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Service labels</td>
</tr>
<tr id="pgadmin-value-enabled" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-enabled">pgadmin</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable ingress</td>
</tr>
<tr id="pgadmin-value-className" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-className">pgadmin</a></td>
<td><code class="value-key">className</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Ingress class name</td>
</tr>
<tr id="pgadmin-value-annotations" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-annotations">pgadmin</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Ingress annotations</td>
</tr>
<tr id="pgadmin-value-hosts" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-hosts">pgadmin</a></td>
<td><code class="value-key">hosts</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Ingress hosts configuration</td>
</tr>
<tr id="pgadmin-value-tls" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-tls">pgadmin</a></td>
<td><code class="value-key">tls</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Ingress TLS configuration</td>
</tr>
<tr id="pgadmin-value-enabled" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-enabled">pgadmin</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Enable persistent storage for pgAdmin data</td>
</tr>
<tr id="pgadmin-value-storageClassName" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-storageClassName">pgadmin</a></td>
<td><code class="value-key">storageClassName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>Default storage class</code></td>
<td>Storage class name</td>
</tr>
<tr id="pgadmin-value-accessMode" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-accessMode">pgadmin</a></td>
<td><code class="value-key">accessMode</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>ReadWriteOnce</code></td>
<td>Access mode for the persistent volume</td>
</tr>
<tr id="pgadmin-value-size" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-size">pgadmin</a></td>
<td><code class="value-key">size</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>1Gi</code></td>
<td>Size of the persistent volume</td>
</tr>
<tr id="pgadmin-value-existingClaim" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-existingClaim">pgadmin</a></td>
<td><code class="value-key">existingClaim</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Name of an existing PVC to use</td>
</tr>
<tr id="pgadmin-value-annotations" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-annotations">pgadmin</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Annotations for the PVC</td>
</tr>
<tr id="pgadmin-value-podSecurityContext" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-podSecurityContext">pgadmin</a></td>
<td><code class="value-key">podSecurityContext</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Pod security context</td>
</tr>
<tr id="pgadmin-value-securityContext" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-securityContext">pgadmin</a></td>
<td><code class="value-key">securityContext</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Container security context</td>
</tr>
<tr id="pgadmin-value-resources" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-resources">pgadmin</a></td>
<td><code class="value-key">resources</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Resource limits and requests</td>
</tr>
<tr id="pgadmin-value-livenessProbe" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-livenessProbe">pgadmin</a></td>
<td><code class="value-key">livenessProbe</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Liveness probe configuration</td>
</tr>
<tr id="pgadmin-value-readinessProbe" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-readinessProbe">pgadmin</a></td>
<td><code class="value-key">readinessProbe</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Readiness probe configuration</td>
</tr>
<tr id="pgadmin-value-startupProbe" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-startupProbe">pgadmin</a></td>
<td><code class="value-key">startupProbe</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Startup probe configuration</td>
</tr>
<tr id="pgadmin-value-podAnnotations" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-podAnnotations">pgadmin</a></td>
<td><code class="value-key">podAnnotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Pod annotations</td>
</tr>
<tr id="pgadmin-value-podLabels" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-podLabels">pgadmin</a></td>
<td><code class="value-key">podLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Pod labels</td>
</tr>
<tr id="pgadmin-value-nodeSelector" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-nodeSelector">pgadmin</a></td>
<td><code class="value-key">nodeSelector</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Node selector for pod assignment</td>
</tr>
<tr id="pgadmin-value-tolerations" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-tolerations">pgadmin</a></td>
<td><code class="value-key">tolerations</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Tolerations for pod assignment</td>
</tr>
<tr id="pgadmin-value-affinity" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-affinity">pgadmin</a></td>
<td><code class="value-key">affinity</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Affinity for pod assignment</td>
</tr>
<tr id="pgadmin-value-priorityClassName" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-priorityClassName">pgadmin</a></td>
<td><code class="value-key">priorityClassName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Priority class name for the pod</td>
</tr>
<tr id="pgadmin-value-topologySpreadConstraints" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-topologySpreadConstraints">pgadmin</a></td>
<td><code class="value-key">topologySpreadConstraints</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Topology spread constraints for pod distribution</td>
</tr>
<tr id="pgadmin-value-dnsPolicy" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-dnsPolicy">pgadmin</a></td>
<td><code class="value-key">dnsPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>ClusterFirst</code></td>
<td>DNS policy</td>
</tr>
<tr id="pgadmin-value-dnsConfig" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-dnsConfig">pgadmin</a></td>
<td><code class="value-key">dnsConfig</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>DNS config</td>
</tr>
<tr id="pgadmin-value-hostAliases" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-hostAliases">pgadmin</a></td>
<td><code class="value-key">hostAliases</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Host aliases</td>
</tr>
<tr id="pgadmin-value-runtimeClassName" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-runtimeClassName">pgadmin</a></td>
<td><code class="value-key">runtimeClassName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Runtime class name</td>
</tr>
<tr id="pgadmin-value-initContainers" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-initContainers">pgadmin</a></td>
<td><code class="value-key">initContainers</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Init containers to run before the main container</td>
</tr>
<tr id="pgadmin-value-extraContainers" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-extraContainers">pgadmin</a></td>
<td><code class="value-key">extraContainers</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Extra sidecar containers</td>
</tr>
<tr id="pgadmin-value-extraEnv" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-extraEnv">pgadmin</a></td>
<td><code class="value-key">extraEnv</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Extra environment variables</td>
</tr>
<tr id="pgadmin-value-extraEnvFrom" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-extraEnvFrom">pgadmin</a></td>
<td><code class="value-key">extraEnvFrom</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Extra environment variables from ConfigMaps or Secrets</td>
</tr>
<tr id="pgadmin-value-extraVolumes" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-extraVolumes">pgadmin</a></td>
<td><code class="value-key">extraVolumes</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Extra volumes</td>
</tr>
<tr id="pgadmin-value-extraVolumeMounts" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-extraVolumeMounts">pgadmin</a></td>
<td><code class="value-key">extraVolumeMounts</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Extra volume mounts</td>
</tr>
<tr id="pgadmin-value-enabled" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-enabled">pgadmin</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable ServiceMonitor for Prometheus Operator</td>
</tr>
<tr id="pgadmin-value-namespace" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-namespace">pgadmin</a></td>
<td><code class="value-key">namespace</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Namespace for the ServiceMonitor (defaults to the release namespace)</td>
</tr>
<tr id="pgadmin-value-interval" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-interval">pgadmin</a></td>
<td><code class="value-key">interval</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>30s</code></td>
<td>Interval at which metrics should be scraped</td>
</tr>
<tr id="pgadmin-value-scrapeTimeout" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-scrapeTimeout">pgadmin</a></td>
<td><code class="value-key">scrapeTimeout</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>10s</code></td>
<td>Timeout for scraping metrics</td>
</tr>
<tr id="pgadmin-value-labels" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-labels">pgadmin</a></td>
<td><code class="value-key">labels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional labels for the ServiceMonitor</td>
</tr>
<tr id="pgadmin-value-annotations" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-annotations">pgadmin</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional annotations for the ServiceMonitor</td>
</tr>
<tr id="pgadmin-value-metricRelabelings" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-metricRelabelings">pgadmin</a></td>
<td><code class="value-key">metricRelabelings</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Metric relabelings</td>
</tr>
<tr id="pgadmin-value-relabelings" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-relabelings">pgadmin</a></td>
<td><code class="value-key">relabelings</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Relabelings</td>
</tr>
<tr id="pgadmin-value-enabled" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-enabled">pgadmin</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable PrometheusRule for alerting</td>
</tr>
<tr id="pgadmin-value-namespace" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-namespace">pgadmin</a></td>
<td><code class="value-key">namespace</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Namespace for the PrometheusRule (defaults to the release namespace)</td>
</tr>
<tr id="pgadmin-value-labels" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-labels">pgadmin</a></td>
<td><code class="value-key">labels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional labels for the PrometheusRule</td>
</tr>
<tr id="pgadmin-value-rules" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-rules">pgadmin</a></td>
<td><code class="value-key">rules</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Alert rules</td>
</tr>
<tr id="pgadmin-value-enabled" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-enabled">pgadmin</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable PodDisruptionBudget</td>
</tr>
<tr id="pgadmin-value-minAvailable" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-minAvailable">pgadmin</a></td>
<td><code class="value-key">minAvailable</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Minimum number of pods that must be available</td>
</tr>
<tr id="pgadmin-value-maxUnavailable" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-maxUnavailable">pgadmin</a></td>
<td><code class="value-key">maxUnavailable</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Maximum number of pods that can be unavailable</td>
</tr>
<tr id="pgadmin-value-hpa" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-hpa">pgadmin</a></td>
<td><code class="value-key">hpa</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Horizontal Pod Autoscaler configuration</td>
</tr>
<tr id="pgadmin-value-enabled" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-enabled">pgadmin</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable HorizontalPodAutoscaler</td>
</tr>
<tr id="pgadmin-value-minReplicas" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-minReplicas">pgadmin</a></td>
<td><code class="value-key">minReplicas</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Minimum number of replicas</td>
</tr>
<tr id="pgadmin-value-maxReplicas" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-maxReplicas">pgadmin</a></td>
<td><code class="value-key">maxReplicas</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>3</code></td>
<td>Maximum number of replicas</td>
</tr>
<tr id="pgadmin-value-targetCPUUtilizationPercentage" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-targetCPUUtilizationPercentage">pgadmin</a></td>
<td><code class="value-key">targetCPUUtilizationPercentage</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>80</code></td>
<td>Target CPU utilization percentage</td>
</tr>
<tr id="pgadmin-value-targetMemoryUtilizationPercentage" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-targetMemoryUtilizationPercentage">pgadmin</a></td>
<td><code class="value-key">targetMemoryUtilizationPercentage</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>80</code></td>
<td>Target memory utilization percentage</td>
</tr>
<tr id="pgadmin-value-customMetrics" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-customMetrics">pgadmin</a></td>
<td><code class="value-key">customMetrics</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Custom metrics for autoscaling</td>
</tr>
<tr id="pgadmin-value-create" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-create">pgadmin</a></td>
<td><code class="value-key">create</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Create a service account</td>
</tr>
<tr id="pgadmin-value-name" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-name">pgadmin</a></td>
<td><code class="value-key">name</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Service account name (generated if not set and create is true)</td>
</tr>
<tr id="pgadmin-value-annotations" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-annotations">pgadmin</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Service account annotations</td>
</tr>
<tr id="pgadmin-value-create" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-create">pgadmin</a></td>
<td><code class="value-key">create</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Create RBAC resources</td>
</tr>
<tr id="pgadmin-value-rules" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-rules">pgadmin</a></td>
<td><code class="value-key">rules</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Additional RBAC rules</td>
</tr>
<tr id="pgadmin-value-enabled" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-enabled">pgadmin</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable network policy</td>
</tr>
<tr id="pgadmin-value-policyTypes" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-policyTypes">pgadmin</a></td>
<td><code class="value-key">policyTypes</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Policy types</td>
</tr>
<tr id="pgadmin-value-ingress" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-ingress">pgadmin</a></td>
<td><code class="value-key">ingress</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Ingress rules</td>
</tr>
<tr id="pgadmin-value-egress" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-egress">pgadmin</a></td>
<td><code class="value-key">egress</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Egress rules</td>
</tr>
<tr id="pgadmin-value-enabled" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-enabled">pgadmin</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable diagnostic mode (disables probes, overrides command)</td>
</tr>
<tr id="pgadmin-value-command" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-command">pgadmin</a></td>
<td><code class="value-key">command</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Command override for diagnostic mode</td>
</tr>
<tr id="pgadmin-value-args" class="value-anchor" data-section="pgadmin">
<td><a href="../charts/pgadmin.md#value-args">pgadmin</a></td>
<td><code class="value-key">args</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Args override for diagnostic mode</td>
</tr>
<tr id="proxmox-backup-server-value-namespaceOverride" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-namespaceOverride">proxmox-backup-server</a></td>
<td><code class="value-key">namespaceOverride</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`.Release.Namespace`</code></td>
<td>Override the namespace for all resources</td>
</tr>
<tr id="proxmox-backup-server-value-nameOverride" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-nameOverride">proxmox-backup-server</a></td>
<td><code class="value-key">nameOverride</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Override the name of the chart</td>
</tr>
<tr id="proxmox-backup-server-value-fullnameOverride" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-fullnameOverride">proxmox-backup-server</a></td>
<td><code class="value-key">fullnameOverride</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Override the full name of the chart</td>
</tr>
<tr id="proxmox-backup-server-value-additionalLabels" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-additionalLabels">proxmox-backup-server</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional labels to add to all resources</td>
</tr>
<tr id="proxmox-backup-server-value-additionalAnnotations" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-additionalAnnotations">proxmox-backup-server</a></td>
<td><code class="value-key">additionalAnnotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional annotations to add to all resources</td>
</tr>
<tr id="proxmox-backup-server-value-repository" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-repository">proxmox-backup-server</a></td>
<td><code class="value-key">repository</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>ayufan/proxmox-backup-server</code></td>
<td>Proxmox Backup Server Docker image repository</td>
</tr>
<tr id="proxmox-backup-server-value-tag" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-tag">proxmox-backup-server</a></td>
<td><code class="value-key">tag</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>Chart appVersion (use 'latest' for stable or 'beta' for pre-releases)</code></td>
<td>Proxmox Backup Server Docker image tag</td>
</tr>
<tr id="proxmox-backup-server-value-pullPolicy" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-pullPolicy">proxmox-backup-server</a></td>
<td><code class="value-key">pullPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>IfNotPresent</code></td>
<td>Image pull policy</td>
</tr>
<tr id="proxmox-backup-server-value-digest" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-digest">proxmox-backup-server</a></td>
<td><code class="value-key">digest</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Image digest (overrides tag if set)</td>
</tr>
<tr id="proxmox-backup-server-value-imagePullSecrets" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-imagePullSecrets">proxmox-backup-server</a></td>
<td><code class="value-key">imagePullSecrets</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Image pull secrets for private registries</td>
</tr>
<tr id="proxmox-backup-server-value-username" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-username">proxmox-backup-server</a></td>
<td><code class="value-key">username</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"admin@pbs"</code></td>
<td>Default PBS login username</td>
</tr>
<tr id="proxmox-backup-server-value-password" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-password">proxmox-backup-server</a></td>
<td><code class="value-key">password</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>pbspbs (MUST be changed after first login)</code></td>
<td>Default PBS login password</td>
</tr>
<tr id="proxmox-backup-server-value-existingSecret" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-existingSecret">proxmox-backup-server</a></td>
<td><code class="value-key">existingSecret</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Name of an existing secret containing PBS credentials</td>
</tr>
<tr id="proxmox-backup-server-value-existingSecretUsernameKey" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-existingSecretUsernameKey">proxmox-backup-server</a></td>
<td><code class="value-key">existingSecretUsernameKey</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"username"</code></td>
<td>Key in existingSecret that contains the username</td>
</tr>
<tr id="proxmox-backup-server-value-existingSecretPasswordKey" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-existingSecretPasswordKey">proxmox-backup-server</a></td>
<td><code class="value-key">existingSecretPasswordKey</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"password"</code></td>
<td>Key in existingSecret that contains the password</td>
</tr>
<tr id="proxmox-backup-server-value-timezone" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-timezone">proxmox-backup-server</a></td>
<td><code class="value-key">timezone</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"UTC"</code></td>
<td>Timezone configuration</td>
</tr>
<tr id="proxmox-backup-server-value-smartAccess" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-smartAccess">proxmox-backup-server</a></td>
<td><code class="value-key">smartAccess</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Enable SMART device access</td>
</tr>
<tr id="proxmox-backup-server-value-devices" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-devices">proxmox-backup-server</a></td>
<td><code class="value-key">devices</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>List of device paths to expose to the container</td>
</tr>
<tr id="proxmox-backup-server-value-backupVolumes" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-backupVolumes">proxmox-backup-server</a></td>
<td><code class="value-key">backupVolumes</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Additional backup data volumes</td>
</tr>
<tr id="proxmox-backup-server-value-type" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-type">proxmox-backup-server</a></td>
<td><code class="value-key">type</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>deployment</code></td>
<td>Controller type (deployment or statefulset)</td>
</tr>
<tr id="proxmox-backup-server-value-replicas" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-replicas">proxmox-backup-server</a></td>
<td><code class="value-key">replicas</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Number of PBS replicas</td>
</tr>
<tr id="proxmox-backup-server-value-strategy" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-strategy">proxmox-backup-server</a></td>
<td><code class="value-key">strategy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Deployment update strategy</td>
</tr>
<tr id="proxmox-backup-server-value-updateStrategy" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-updateStrategy">proxmox-backup-server</a></td>
<td><code class="value-key">updateStrategy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>StatefulSet update strategy (only used if controller.type is statefulset)</td>
</tr>
<tr id="proxmox-backup-server-value-podManagementPolicy" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-podManagementPolicy">proxmox-backup-server</a></td>
<td><code class="value-key">podManagementPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>OrderedReady</code></td>
<td>Pod management policy (only used if controller.type is statefulset)</td>
</tr>
<tr id="proxmox-backup-server-value-command" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-command">proxmox-backup-server</a></td>
<td><code class="value-key">command</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Command override for the main container</td>
</tr>
<tr id="proxmox-backup-server-value-args" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-args">proxmox-backup-server</a></td>
<td><code class="value-key">args</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Args override for the main container</td>
</tr>
<tr id="proxmox-backup-server-value-workingDir" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-workingDir">proxmox-backup-server</a></td>
<td><code class="value-key">workingDir</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Working directory for the main container</td>
</tr>
<tr id="proxmox-backup-server-value-terminationGracePeriodSeconds" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-terminationGracePeriodSeconds">proxmox-backup-server</a></td>
<td><code class="value-key">terminationGracePeriodSeconds</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>30</code></td>
<td>Termination grace period in seconds</td>
</tr>
<tr id="proxmox-backup-server-value-lifecycle" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-lifecycle">proxmox-backup-server</a></td>
<td><code class="value-key">lifecycle</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Lifecycle hooks for the main container</td>
</tr>
<tr id="proxmox-backup-server-value-type" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-type">proxmox-backup-server</a></td>
<td><code class="value-key">type</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>ClusterIP</code></td>
<td>Service type</td>
</tr>
<tr id="proxmox-backup-server-value-port" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-port">proxmox-backup-server</a></td>
<td><code class="value-key">port</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>8007</code></td>
<td>Service port (PBS uses HTTPS on 8007)</td>
</tr>
<tr id="proxmox-backup-server-value-targetPort" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-targetPort">proxmox-backup-server</a></td>
<td><code class="value-key">targetPort</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>8007</code></td>
<td>Service target port (container port)</td>
</tr>
<tr id="proxmox-backup-server-value-nodePort" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-nodePort">proxmox-backup-server</a></td>
<td><code class="value-key">nodePort</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Node port (only used if type is NodePort)</td>
</tr>
<tr id="proxmox-backup-server-value-loadBalancerIP" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-loadBalancerIP">proxmox-backup-server</a></td>
<td><code class="value-key">loadBalancerIP</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Load balancer IP (only used if type is LoadBalancer)</td>
</tr>
<tr id="proxmox-backup-server-value-loadBalancerSourceRanges" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-loadBalancerSourceRanges">proxmox-backup-server</a></td>
<td><code class="value-key">loadBalancerSourceRanges</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Load balancer source ranges (only used if type is LoadBalancer)</td>
</tr>
<tr id="proxmox-backup-server-value-externalTrafficPolicy" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-externalTrafficPolicy">proxmox-backup-server</a></td>
<td><code class="value-key">externalTrafficPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>External traffic policy (only used if type is LoadBalancer or NodePort)</td>
</tr>
<tr id="proxmox-backup-server-value-clusterIP" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-clusterIP">proxmox-backup-server</a></td>
<td><code class="value-key">clusterIP</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Cluster IP (set to None for headless service)</td>
</tr>
<tr id="proxmox-backup-server-value-sessionAffinity" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-sessionAffinity">proxmox-backup-server</a></td>
<td><code class="value-key">sessionAffinity</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>None</code></td>
<td>Session affinity</td>
</tr>
<tr id="proxmox-backup-server-value-sessionAffinityConfig" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-sessionAffinityConfig">proxmox-backup-server</a></td>
<td><code class="value-key">sessionAffinityConfig</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Session affinity config</td>
</tr>
<tr id="proxmox-backup-server-value-annotations" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-annotations">proxmox-backup-server</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Service annotations</td>
</tr>
<tr id="proxmox-backup-server-value-labels" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-labels">proxmox-backup-server</a></td>
<td><code class="value-key">labels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Service labels</td>
</tr>
<tr id="proxmox-backup-server-value-enabled" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-enabled">proxmox-backup-server</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable ingress</td>
</tr>
<tr id="proxmox-backup-server-value-className" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-className">proxmox-backup-server</a></td>
<td><code class="value-key">className</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Ingress class name</td>
</tr>
<tr id="proxmox-backup-server-value-annotations" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-annotations">proxmox-backup-server</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Ingress annotations</td>
</tr>
<tr id="proxmox-backup-server-value-hosts" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-hosts">proxmox-backup-server</a></td>
<td><code class="value-key">hosts</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Ingress hosts configuration</td>
</tr>
<tr id="proxmox-backup-server-value-tls" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-tls">proxmox-backup-server</a></td>
<td><code class="value-key">tls</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Ingress TLS configuration</td>
</tr>
<tr id="proxmox-backup-server-value-enabled" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-enabled">proxmox-backup-server</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Enable persistent storage for PBS data</td>
</tr>
<tr id="proxmox-backup-server-value-etc" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-etc">proxmox-backup-server</a></td>
<td><code class="value-key">etc</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Persist /etc/proxmox-backup directory (configuration)</td>
</tr>
<tr id="proxmox-backup-server-value-logs" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-logs">proxmox-backup-server</a></td>
<td><code class="value-key">logs</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Persist /var/log/proxmox-backup directory (logs)</td>
</tr>
<tr id="proxmox-backup-server-value-lib" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-lib">proxmox-backup-server</a></td>
<td><code class="value-key">lib</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Persist /var/lib/proxmox-backup directory (library/state)</td>
</tr>
<tr id="proxmox-backup-server-value-podSecurityContext" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-podSecurityContext">proxmox-backup-server</a></td>
<td><code class="value-key">podSecurityContext</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Pod security context</td>
</tr>
<tr id="proxmox-backup-server-value-securityContext" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-securityContext">proxmox-backup-server</a></td>
<td><code class="value-key">securityContext</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Container security context</td>
</tr>
<tr id="proxmox-backup-server-value-resources" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-resources">proxmox-backup-server</a></td>
<td><code class="value-key">resources</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Resource limits and requests</td>
</tr>
<tr id="proxmox-backup-server-value-livenessProbe" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-livenessProbe">proxmox-backup-server</a></td>
<td><code class="value-key">livenessProbe</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Liveness probe configuration</td>
</tr>
<tr id="proxmox-backup-server-value-readinessProbe" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-readinessProbe">proxmox-backup-server</a></td>
<td><code class="value-key">readinessProbe</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Readiness probe configuration</td>
</tr>
<tr id="proxmox-backup-server-value-startupProbe" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-startupProbe">proxmox-backup-server</a></td>
<td><code class="value-key">startupProbe</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Startup probe configuration</td>
</tr>
<tr id="proxmox-backup-server-value-podAnnotations" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-podAnnotations">proxmox-backup-server</a></td>
<td><code class="value-key">podAnnotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Pod annotations</td>
</tr>
<tr id="proxmox-backup-server-value-podLabels" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-podLabels">proxmox-backup-server</a></td>
<td><code class="value-key">podLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Pod labels</td>
</tr>
<tr id="proxmox-backup-server-value-nodeSelector" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-nodeSelector">proxmox-backup-server</a></td>
<td><code class="value-key">nodeSelector</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Node selector for pod assignment</td>
</tr>
<tr id="proxmox-backup-server-value-tolerations" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-tolerations">proxmox-backup-server</a></td>
<td><code class="value-key">tolerations</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Tolerations for pod assignment</td>
</tr>
<tr id="proxmox-backup-server-value-affinity" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-affinity">proxmox-backup-server</a></td>
<td><code class="value-key">affinity</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Affinity for pod assignment</td>
</tr>
<tr id="proxmox-backup-server-value-priorityClassName" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-priorityClassName">proxmox-backup-server</a></td>
<td><code class="value-key">priorityClassName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Priority class name for the pod</td>
</tr>
<tr id="proxmox-backup-server-value-topologySpreadConstraints" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-topologySpreadConstraints">proxmox-backup-server</a></td>
<td><code class="value-key">topologySpreadConstraints</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Topology spread constraints for pod distribution</td>
</tr>
<tr id="proxmox-backup-server-value-dnsPolicy" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-dnsPolicy">proxmox-backup-server</a></td>
<td><code class="value-key">dnsPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>ClusterFirst</code></td>
<td>DNS policy</td>
</tr>
<tr id="proxmox-backup-server-value-dnsConfig" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-dnsConfig">proxmox-backup-server</a></td>
<td><code class="value-key">dnsConfig</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>DNS config</td>
</tr>
<tr id="proxmox-backup-server-value-hostAliases" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-hostAliases">proxmox-backup-server</a></td>
<td><code class="value-key">hostAliases</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Host aliases</td>
</tr>
<tr id="proxmox-backup-server-value-runtimeClassName" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-runtimeClassName">proxmox-backup-server</a></td>
<td><code class="value-key">runtimeClassName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Runtime class name</td>
</tr>
<tr id="proxmox-backup-server-value-initContainers" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-initContainers">proxmox-backup-server</a></td>
<td><code class="value-key">initContainers</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Init containers to run before the main container</td>
</tr>
<tr id="proxmox-backup-server-value-extraContainers" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-extraContainers">proxmox-backup-server</a></td>
<td><code class="value-key">extraContainers</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Extra sidecar containers</td>
</tr>
<tr id="proxmox-backup-server-value-extraEnv" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-extraEnv">proxmox-backup-server</a></td>
<td><code class="value-key">extraEnv</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Extra environment variables</td>
</tr>
<tr id="proxmox-backup-server-value-extraEnvFrom" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-extraEnvFrom">proxmox-backup-server</a></td>
<td><code class="value-key">extraEnvFrom</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Extra environment variables from ConfigMaps or Secrets</td>
</tr>
<tr id="proxmox-backup-server-value-extraVolumes" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-extraVolumes">proxmox-backup-server</a></td>
<td><code class="value-key">extraVolumes</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Extra volumes</td>
</tr>
<tr id="proxmox-backup-server-value-extraVolumeMounts" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-extraVolumeMounts">proxmox-backup-server</a></td>
<td><code class="value-key">extraVolumeMounts</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Extra volume mounts</td>
</tr>
<tr id="proxmox-backup-server-value-enabled" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-enabled">proxmox-backup-server</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable ServiceMonitor for Prometheus Operator</td>
</tr>
<tr id="proxmox-backup-server-value-namespace" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-namespace">proxmox-backup-server</a></td>
<td><code class="value-key">namespace</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Namespace for the ServiceMonitor (defaults to the release namespace)</td>
</tr>
<tr id="proxmox-backup-server-value-interval" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-interval">proxmox-backup-server</a></td>
<td><code class="value-key">interval</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>30s</code></td>
<td>Interval at which metrics should be scraped</td>
</tr>
<tr id="proxmox-backup-server-value-scrapeTimeout" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-scrapeTimeout">proxmox-backup-server</a></td>
<td><code class="value-key">scrapeTimeout</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>10s</code></td>
<td>Timeout for scraping metrics</td>
</tr>
<tr id="proxmox-backup-server-value-labels" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-labels">proxmox-backup-server</a></td>
<td><code class="value-key">labels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional labels for the ServiceMonitor</td>
</tr>
<tr id="proxmox-backup-server-value-annotations" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-annotations">proxmox-backup-server</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional annotations for the ServiceMonitor</td>
</tr>
<tr id="proxmox-backup-server-value-metricRelabelings" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-metricRelabelings">proxmox-backup-server</a></td>
<td><code class="value-key">metricRelabelings</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Metric relabelings</td>
</tr>
<tr id="proxmox-backup-server-value-relabelings" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-relabelings">proxmox-backup-server</a></td>
<td><code class="value-key">relabelings</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Relabelings</td>
</tr>
<tr id="proxmox-backup-server-value-enabled" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-enabled">proxmox-backup-server</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable PrometheusRule for alerting</td>
</tr>
<tr id="proxmox-backup-server-value-namespace" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-namespace">proxmox-backup-server</a></td>
<td><code class="value-key">namespace</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Namespace for the PrometheusRule (defaults to the release namespace)</td>
</tr>
<tr id="proxmox-backup-server-value-labels" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-labels">proxmox-backup-server</a></td>
<td><code class="value-key">labels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional labels for the PrometheusRule</td>
</tr>
<tr id="proxmox-backup-server-value-rules" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-rules">proxmox-backup-server</a></td>
<td><code class="value-key">rules</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Alert rules</td>
</tr>
<tr id="proxmox-backup-server-value-enabled" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-enabled">proxmox-backup-server</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable PodDisruptionBudget</td>
</tr>
<tr id="proxmox-backup-server-value-minAvailable" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-minAvailable">proxmox-backup-server</a></td>
<td><code class="value-key">minAvailable</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Minimum number of pods that must be available</td>
</tr>
<tr id="proxmox-backup-server-value-maxUnavailable" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-maxUnavailable">proxmox-backup-server</a></td>
<td><code class="value-key">maxUnavailable</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Maximum number of pods that can be unavailable</td>
</tr>
<tr id="proxmox-backup-server-value-hpa" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-hpa">proxmox-backup-server</a></td>
<td><code class="value-key">hpa</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Horizontal Pod Autoscaler configuration</td>
</tr>
<tr id="proxmox-backup-server-value-enabled" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-enabled">proxmox-backup-server</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable HorizontalPodAutoscaler</td>
</tr>
<tr id="proxmox-backup-server-value-minReplicas" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-minReplicas">proxmox-backup-server</a></td>
<td><code class="value-key">minReplicas</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Minimum number of replicas</td>
</tr>
<tr id="proxmox-backup-server-value-maxReplicas" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-maxReplicas">proxmox-backup-server</a></td>
<td><code class="value-key">maxReplicas</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>3</code></td>
<td>Maximum number of replicas</td>
</tr>
<tr id="proxmox-backup-server-value-targetCPUUtilizationPercentage" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-targetCPUUtilizationPercentage">proxmox-backup-server</a></td>
<td><code class="value-key">targetCPUUtilizationPercentage</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>80</code></td>
<td>Target CPU utilization percentage</td>
</tr>
<tr id="proxmox-backup-server-value-targetMemoryUtilizationPercentage" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-targetMemoryUtilizationPercentage">proxmox-backup-server</a></td>
<td><code class="value-key">targetMemoryUtilizationPercentage</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>80</code></td>
<td>Target memory utilization percentage</td>
</tr>
<tr id="proxmox-backup-server-value-customMetrics" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-customMetrics">proxmox-backup-server</a></td>
<td><code class="value-key">customMetrics</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Custom metrics for autoscaling</td>
</tr>
<tr id="proxmox-backup-server-value-create" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-create">proxmox-backup-server</a></td>
<td><code class="value-key">create</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Create a service account</td>
</tr>
<tr id="proxmox-backup-server-value-name" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-name">proxmox-backup-server</a></td>
<td><code class="value-key">name</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Service account name (generated if not set and create is true)</td>
</tr>
<tr id="proxmox-backup-server-value-annotations" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-annotations">proxmox-backup-server</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Service account annotations</td>
</tr>
<tr id="proxmox-backup-server-value-create" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-create">proxmox-backup-server</a></td>
<td><code class="value-key">create</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Create RBAC resources</td>
</tr>
<tr id="proxmox-backup-server-value-rules" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-rules">proxmox-backup-server</a></td>
<td><code class="value-key">rules</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Additional RBAC rules</td>
</tr>
<tr id="proxmox-backup-server-value-enabled" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-enabled">proxmox-backup-server</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable network policy</td>
</tr>
<tr id="proxmox-backup-server-value-policyTypes" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-policyTypes">proxmox-backup-server</a></td>
<td><code class="value-key">policyTypes</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Policy types</td>
</tr>
<tr id="proxmox-backup-server-value-ingress" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-ingress">proxmox-backup-server</a></td>
<td><code class="value-key">ingress</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Ingress rules</td>
</tr>
<tr id="proxmox-backup-server-value-egress" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-egress">proxmox-backup-server</a></td>
<td><code class="value-key">egress</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Egress rules</td>
</tr>
<tr id="proxmox-backup-server-value-enabled" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-enabled">proxmox-backup-server</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable diagnostic mode (disables probes, overrides command)</td>
</tr>
<tr id="proxmox-backup-server-value-command" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-command">proxmox-backup-server</a></td>
<td><code class="value-key">command</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Command override for diagnostic mode</td>
</tr>
<tr id="proxmox-backup-server-value-args" class="value-anchor" data-section="proxmox-backup-server">
<td><a href="../charts/proxmox-backup-server.md#value-args">proxmox-backup-server</a></td>
<td><code class="value-key">args</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Args override for diagnostic mode</td>
</tr>
<tr id="redisinsight-value-namespaceOverride" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-namespaceOverride">redisinsight</a></td>
<td><code class="value-key">namespaceOverride</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`.Release.Namespace`</code></td>
<td>Override the namespace for all resources</td>
</tr>
<tr id="redisinsight-value-nameOverride" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-nameOverride">redisinsight</a></td>
<td><code class="value-key">nameOverride</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Override the name of the chart</td>
</tr>
<tr id="redisinsight-value-fullnameOverride" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-fullnameOverride">redisinsight</a></td>
<td><code class="value-key">fullnameOverride</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Override the full name of the chart</td>
</tr>
<tr id="redisinsight-value-additionalLabels" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-additionalLabels">redisinsight</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional labels to add to all resources</td>
</tr>
<tr id="redisinsight-value-additionalAnnotations" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-additionalAnnotations">redisinsight</a></td>
<td><code class="value-key">additionalAnnotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional annotations to add to all resources</td>
</tr>
<tr id="redisinsight-value-repository" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-repository">redisinsight</a></td>
<td><code class="value-key">repository</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>redis/redisinsight</code></td>
<td>Redis Insight Docker image repository</td>
</tr>
<tr id="redisinsight-value-tag" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-tag">redisinsight</a></td>
<td><code class="value-key">tag</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>Chart appVersion</code></td>
<td>Redis Insight Docker image tag</td>
</tr>
<tr id="redisinsight-value-pullPolicy" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-pullPolicy">redisinsight</a></td>
<td><code class="value-key">pullPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>IfNotPresent</code></td>
<td>Image pull policy</td>
</tr>
<tr id="redisinsight-value-digest" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-digest">redisinsight</a></td>
<td><code class="value-key">digest</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Image digest (overrides tag if set)</td>
</tr>
<tr id="redisinsight-value-imagePullSecrets" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-imagePullSecrets">redisinsight</a></td>
<td><code class="value-key">imagePullSecrets</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Image pull secrets for private registries</td>
</tr>
<tr id="redisinsight-value-port" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-port">redisinsight</a></td>
<td><code class="value-key">port</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>5540</code></td>
<td>Application port that Redis Insight listens on</td>
</tr>
<tr id="redisinsight-value-host" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-host">redisinsight</a></td>
<td><code class="value-key">host</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"0.0.0.0"</code></td>
<td>Application host that Redis Insight binds to</td>
</tr>
<tr id="redisinsight-value-logLevel" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-logLevel">redisinsight</a></td>
<td><code class="value-key">logLevel</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"info"</code></td>
<td>Log level for the application</td>
</tr>
<tr id="redisinsight-value-filesLogger" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-filesLogger">redisinsight</a></td>
<td><code class="value-key">filesLogger</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Enable file logging</td>
</tr>
<tr id="redisinsight-value-stdoutLogger" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-stdoutLogger">redisinsight</a></td>
<td><code class="value-key">stdoutLogger</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Enable stdout logging</td>
</tr>
<tr id="redisinsight-value-proxyPath" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-proxyPath">redisinsight</a></td>
<td><code class="value-key">proxyPath</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Proxy path for reverse proxy subdirectory hosting</td>
</tr>
<tr id="redisinsight-value-databaseManagement" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-databaseManagement">redisinsight</a></td>
<td><code class="value-key">databaseManagement</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Enable/disable database connection management</td>
</tr>
<tr id="redisinsight-value-encryptionKey" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-encryptionKey">redisinsight</a></td>
<td><code class="value-key">encryptionKey</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Encryption key for sensitive data</td>
</tr>
<tr id="redisinsight-value-existingEncryptionKeySecret" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-existingEncryptionKeySecret">redisinsight</a></td>
<td><code class="value-key">existingEncryptionKeySecret</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Name of an existing secret containing the encryption key</td>
</tr>
<tr id="redisinsight-value-existingEncryptionKeySecretKey" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-existingEncryptionKeySecretKey">redisinsight</a></td>
<td><code class="value-key">existingEncryptionKeySecretKey</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"encryptionKey"</code></td>
<td>Key in existingEncryptionKeySecret that contains the encryption key</td>
</tr>
<tr id="redisinsight-value-tls" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-tls">redisinsight</a></td>
<td><code class="value-key">tls</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>TLS/SSL configuration for HTTPS</td>
</tr>
<tr id="redisinsight-value-enabled" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-enabled">redisinsight</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable TLS/SSL</td>
</tr>
<tr id="redisinsight-value-key" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-key">redisinsight</a></td>
<td><code class="value-key">key</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>TLS private key (PEM format)</td>
</tr>
<tr id="redisinsight-value-cert" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-cert">redisinsight</a></td>
<td><code class="value-key">cert</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>TLS certificate (PEM format)</td>
</tr>
<tr id="redisinsight-value-existingSecret" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-existingSecret">redisinsight</a></td>
<td><code class="value-key">existingSecret</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Name of an existing secret containing TLS key and cert</td>
</tr>
<tr id="redisinsight-value-existingSecretKeyKey" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-existingSecretKeyKey">redisinsight</a></td>
<td><code class="value-key">existingSecretKeyKey</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"tls.key"</code></td>
<td>Key in existingSecret for TLS private key</td>
</tr>
<tr id="redisinsight-value-existingSecretCertKey" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-existingSecretCertKey">redisinsight</a></td>
<td><code class="value-key">existingSecretCertKey</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"tls.crt"</code></td>
<td>Key in existingSecret for TLS certificate</td>
</tr>
<tr id="redisinsight-value-connections" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-connections">redisinsight</a></td>
<td><code class="value-key">connections</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Pre-configured Redis database connections</td>
</tr>
<tr id="redisinsight-value-existingConnectionPasswordsSecret" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-existingConnectionPasswordsSecret">redisinsight</a></td>
<td><code class="value-key">existingConnectionPasswordsSecret</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Name of an existing secret containing Redis connection passwords</td>
</tr>
<tr id="redisinsight-value-type" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-type">redisinsight</a></td>
<td><code class="value-key">type</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>deployment</code></td>
<td>Controller type (deployment or statefulset)</td>
</tr>
<tr id="redisinsight-value-replicas" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-replicas">redisinsight</a></td>
<td><code class="value-key">replicas</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Number of Redis Insight replicas</td>
</tr>
<tr id="redisinsight-value-strategy" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-strategy">redisinsight</a></td>
<td><code class="value-key">strategy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Deployment update strategy</td>
</tr>
<tr id="redisinsight-value-updateStrategy" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-updateStrategy">redisinsight</a></td>
<td><code class="value-key">updateStrategy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>StatefulSet update strategy (only used if controller.type is statefulset)</td>
</tr>
<tr id="redisinsight-value-podManagementPolicy" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-podManagementPolicy">redisinsight</a></td>
<td><code class="value-key">podManagementPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>OrderedReady</code></td>
<td>Pod management policy (only used if controller.type is statefulset)</td>
</tr>
<tr id="redisinsight-value-command" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-command">redisinsight</a></td>
<td><code class="value-key">command</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Command override for the main container</td>
</tr>
<tr id="redisinsight-value-args" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-args">redisinsight</a></td>
<td><code class="value-key">args</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Args override for the main container</td>
</tr>
<tr id="redisinsight-value-workingDir" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-workingDir">redisinsight</a></td>
<td><code class="value-key">workingDir</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Working directory for the main container</td>
</tr>
<tr id="redisinsight-value-terminationGracePeriodSeconds" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-terminationGracePeriodSeconds">redisinsight</a></td>
<td><code class="value-key">terminationGracePeriodSeconds</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>30</code></td>
<td>Termination grace period in seconds</td>
</tr>
<tr id="redisinsight-value-lifecycle" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-lifecycle">redisinsight</a></td>
<td><code class="value-key">lifecycle</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Lifecycle hooks for the main container</td>
</tr>
<tr id="redisinsight-value-type" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-type">redisinsight</a></td>
<td><code class="value-key">type</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>ClusterIP</code></td>
<td>Service type</td>
</tr>
<tr id="redisinsight-value-port" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-port">redisinsight</a></td>
<td><code class="value-key">port</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>5540</code></td>
<td>Service port</td>
</tr>
<tr id="redisinsight-value-targetPort" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-targetPort">redisinsight</a></td>
<td><code class="value-key">targetPort</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>5540</code></td>
<td>Service target port (container port)</td>
</tr>
<tr id="redisinsight-value-nodePort" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-nodePort">redisinsight</a></td>
<td><code class="value-key">nodePort</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Node port (only used if type is NodePort)</td>
</tr>
<tr id="redisinsight-value-loadBalancerIP" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-loadBalancerIP">redisinsight</a></td>
<td><code class="value-key">loadBalancerIP</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Load balancer IP (only used if type is LoadBalancer)</td>
</tr>
<tr id="redisinsight-value-loadBalancerSourceRanges" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-loadBalancerSourceRanges">redisinsight</a></td>
<td><code class="value-key">loadBalancerSourceRanges</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Load balancer source ranges (only used if type is LoadBalancer)</td>
</tr>
<tr id="redisinsight-value-externalTrafficPolicy" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-externalTrafficPolicy">redisinsight</a></td>
<td><code class="value-key">externalTrafficPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>External traffic policy (only used if type is LoadBalancer or NodePort)</td>
</tr>
<tr id="redisinsight-value-clusterIP" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-clusterIP">redisinsight</a></td>
<td><code class="value-key">clusterIP</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Cluster IP (set to None for headless service)</td>
</tr>
<tr id="redisinsight-value-sessionAffinity" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-sessionAffinity">redisinsight</a></td>
<td><code class="value-key">sessionAffinity</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>None</code></td>
<td>Session affinity</td>
</tr>
<tr id="redisinsight-value-sessionAffinityConfig" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-sessionAffinityConfig">redisinsight</a></td>
<td><code class="value-key">sessionAffinityConfig</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Session affinity config</td>
</tr>
<tr id="redisinsight-value-annotations" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-annotations">redisinsight</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Service annotations</td>
</tr>
<tr id="redisinsight-value-labels" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-labels">redisinsight</a></td>
<td><code class="value-key">labels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Service labels</td>
</tr>
<tr id="redisinsight-value-enabled" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-enabled">redisinsight</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable ingress</td>
</tr>
<tr id="redisinsight-value-className" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-className">redisinsight</a></td>
<td><code class="value-key">className</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Ingress class name</td>
</tr>
<tr id="redisinsight-value-annotations" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-annotations">redisinsight</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Ingress annotations</td>
</tr>
<tr id="redisinsight-value-hosts" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-hosts">redisinsight</a></td>
<td><code class="value-key">hosts</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Ingress hosts configuration</td>
</tr>
<tr id="redisinsight-value-tls" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-tls">redisinsight</a></td>
<td><code class="value-key">tls</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Ingress TLS configuration</td>
</tr>
<tr id="redisinsight-value-enabled" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-enabled">redisinsight</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable persistent storage for Redis Insight data</td>
</tr>
<tr id="redisinsight-value-storageClassName" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-storageClassName">redisinsight</a></td>
<td><code class="value-key">storageClassName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>Default storage class</code></td>
<td>Storage class name</td>
</tr>
<tr id="redisinsight-value-accessMode" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-accessMode">redisinsight</a></td>
<td><code class="value-key">accessMode</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>ReadWriteOnce</code></td>
<td>Access mode for the persistent volume</td>
</tr>
<tr id="redisinsight-value-size" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-size">redisinsight</a></td>
<td><code class="value-key">size</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>1Gi</code></td>
<td>Size of the persistent volume</td>
</tr>
<tr id="redisinsight-value-existingClaim" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-existingClaim">redisinsight</a></td>
<td><code class="value-key">existingClaim</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Name of an existing PVC to use</td>
</tr>
<tr id="redisinsight-value-annotations" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-annotations">redisinsight</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Annotations for the PVC</td>
</tr>
<tr id="redisinsight-value-podSecurityContext" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-podSecurityContext">redisinsight</a></td>
<td><code class="value-key">podSecurityContext</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Pod security context</td>
</tr>
<tr id="redisinsight-value-securityContext" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-securityContext">redisinsight</a></td>
<td><code class="value-key">securityContext</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Container security context</td>
</tr>
<tr id="redisinsight-value-resources" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-resources">redisinsight</a></td>
<td><code class="value-key">resources</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Resource limits and requests</td>
</tr>
<tr id="redisinsight-value-livenessProbe" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-livenessProbe">redisinsight</a></td>
<td><code class="value-key">livenessProbe</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Liveness probe configuration</td>
</tr>
<tr id="redisinsight-value-readinessProbe" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-readinessProbe">redisinsight</a></td>
<td><code class="value-key">readinessProbe</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Readiness probe configuration</td>
</tr>
<tr id="redisinsight-value-startupProbe" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-startupProbe">redisinsight</a></td>
<td><code class="value-key">startupProbe</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Startup probe configuration</td>
</tr>
<tr id="redisinsight-value-podAnnotations" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-podAnnotations">redisinsight</a></td>
<td><code class="value-key">podAnnotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Pod annotations</td>
</tr>
<tr id="redisinsight-value-podLabels" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-podLabels">redisinsight</a></td>
<td><code class="value-key">podLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Pod labels</td>
</tr>
<tr id="redisinsight-value-nodeSelector" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-nodeSelector">redisinsight</a></td>
<td><code class="value-key">nodeSelector</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Node selector for pod assignment</td>
</tr>
<tr id="redisinsight-value-tolerations" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-tolerations">redisinsight</a></td>
<td><code class="value-key">tolerations</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Tolerations for pod assignment</td>
</tr>
<tr id="redisinsight-value-affinity" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-affinity">redisinsight</a></td>
<td><code class="value-key">affinity</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Affinity for pod assignment</td>
</tr>
<tr id="redisinsight-value-priorityClassName" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-priorityClassName">redisinsight</a></td>
<td><code class="value-key">priorityClassName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Priority class name for the pod</td>
</tr>
<tr id="redisinsight-value-topologySpreadConstraints" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-topologySpreadConstraints">redisinsight</a></td>
<td><code class="value-key">topologySpreadConstraints</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Topology spread constraints for pod distribution</td>
</tr>
<tr id="redisinsight-value-dnsPolicy" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-dnsPolicy">redisinsight</a></td>
<td><code class="value-key">dnsPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>ClusterFirst</code></td>
<td>DNS policy</td>
</tr>
<tr id="redisinsight-value-dnsConfig" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-dnsConfig">redisinsight</a></td>
<td><code class="value-key">dnsConfig</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>DNS config</td>
</tr>
<tr id="redisinsight-value-hostAliases" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-hostAliases">redisinsight</a></td>
<td><code class="value-key">hostAliases</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Host aliases</td>
</tr>
<tr id="redisinsight-value-runtimeClassName" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-runtimeClassName">redisinsight</a></td>
<td><code class="value-key">runtimeClassName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Runtime class name</td>
</tr>
<tr id="redisinsight-value-initContainers" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-initContainers">redisinsight</a></td>
<td><code class="value-key">initContainers</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Init containers to run before the main container</td>
</tr>
<tr id="redisinsight-value-extraContainers" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-extraContainers">redisinsight</a></td>
<td><code class="value-key">extraContainers</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Extra sidecar containers</td>
</tr>
<tr id="redisinsight-value-extraEnv" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-extraEnv">redisinsight</a></td>
<td><code class="value-key">extraEnv</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Extra environment variables</td>
</tr>
<tr id="redisinsight-value-extraEnvFrom" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-extraEnvFrom">redisinsight</a></td>
<td><code class="value-key">extraEnvFrom</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Extra environment variables from ConfigMaps or Secrets</td>
</tr>
<tr id="redisinsight-value-extraVolumes" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-extraVolumes">redisinsight</a></td>
<td><code class="value-key">extraVolumes</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Extra volumes</td>
</tr>
<tr id="redisinsight-value-extraVolumeMounts" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-extraVolumeMounts">redisinsight</a></td>
<td><code class="value-key">extraVolumeMounts</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Extra volume mounts</td>
</tr>
<tr id="redisinsight-value-enabled" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-enabled">redisinsight</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable ServiceMonitor for Prometheus Operator</td>
</tr>
<tr id="redisinsight-value-namespace" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-namespace">redisinsight</a></td>
<td><code class="value-key">namespace</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Namespace for the ServiceMonitor (defaults to the release namespace)</td>
</tr>
<tr id="redisinsight-value-interval" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-interval">redisinsight</a></td>
<td><code class="value-key">interval</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>30s</code></td>
<td>Interval at which metrics should be scraped</td>
</tr>
<tr id="redisinsight-value-scrapeTimeout" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-scrapeTimeout">redisinsight</a></td>
<td><code class="value-key">scrapeTimeout</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>10s</code></td>
<td>Timeout for scraping metrics</td>
</tr>
<tr id="redisinsight-value-labels" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-labels">redisinsight</a></td>
<td><code class="value-key">labels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional labels for the ServiceMonitor</td>
</tr>
<tr id="redisinsight-value-annotations" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-annotations">redisinsight</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional annotations for the ServiceMonitor</td>
</tr>
<tr id="redisinsight-value-metricRelabelings" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-metricRelabelings">redisinsight</a></td>
<td><code class="value-key">metricRelabelings</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Metric relabelings</td>
</tr>
<tr id="redisinsight-value-relabelings" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-relabelings">redisinsight</a></td>
<td><code class="value-key">relabelings</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Relabelings</td>
</tr>
<tr id="redisinsight-value-enabled" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-enabled">redisinsight</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable PrometheusRule for alerting</td>
</tr>
<tr id="redisinsight-value-namespace" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-namespace">redisinsight</a></td>
<td><code class="value-key">namespace</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Namespace for the PrometheusRule (defaults to the release namespace)</td>
</tr>
<tr id="redisinsight-value-labels" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-labels">redisinsight</a></td>
<td><code class="value-key">labels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional labels for the PrometheusRule</td>
</tr>
<tr id="redisinsight-value-rules" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-rules">redisinsight</a></td>
<td><code class="value-key">rules</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Alert rules</td>
</tr>
<tr id="redisinsight-value-enabled" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-enabled">redisinsight</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable PodDisruptionBudget</td>
</tr>
<tr id="redisinsight-value-minAvailable" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-minAvailable">redisinsight</a></td>
<td><code class="value-key">minAvailable</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Minimum number of pods that must be available</td>
</tr>
<tr id="redisinsight-value-maxUnavailable" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-maxUnavailable">redisinsight</a></td>
<td><code class="value-key">maxUnavailable</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Maximum number of pods that can be unavailable</td>
</tr>
<tr id="redisinsight-value-hpa" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-hpa">redisinsight</a></td>
<td><code class="value-key">hpa</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Horizontal Pod Autoscaler configuration</td>
</tr>
<tr id="redisinsight-value-enabled" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-enabled">redisinsight</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable HorizontalPodAutoscaler</td>
</tr>
<tr id="redisinsight-value-minReplicas" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-minReplicas">redisinsight</a></td>
<td><code class="value-key">minReplicas</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Minimum number of replicas</td>
</tr>
<tr id="redisinsight-value-maxReplicas" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-maxReplicas">redisinsight</a></td>
<td><code class="value-key">maxReplicas</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>3</code></td>
<td>Maximum number of replicas</td>
</tr>
<tr id="redisinsight-value-targetCPUUtilizationPercentage" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-targetCPUUtilizationPercentage">redisinsight</a></td>
<td><code class="value-key">targetCPUUtilizationPercentage</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>80</code></td>
<td>Target CPU utilization percentage</td>
</tr>
<tr id="redisinsight-value-targetMemoryUtilizationPercentage" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-targetMemoryUtilizationPercentage">redisinsight</a></td>
<td><code class="value-key">targetMemoryUtilizationPercentage</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>80</code></td>
<td>Target memory utilization percentage</td>
</tr>
<tr id="redisinsight-value-customMetrics" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-customMetrics">redisinsight</a></td>
<td><code class="value-key">customMetrics</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Custom metrics for autoscaling</td>
</tr>
<tr id="redisinsight-value-create" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-create">redisinsight</a></td>
<td><code class="value-key">create</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Create a service account</td>
</tr>
<tr id="redisinsight-value-name" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-name">redisinsight</a></td>
<td><code class="value-key">name</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Service account name (generated if not set and create is true)</td>
</tr>
<tr id="redisinsight-value-annotations" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-annotations">redisinsight</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Service account annotations</td>
</tr>
<tr id="redisinsight-value-create" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-create">redisinsight</a></td>
<td><code class="value-key">create</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Create RBAC resources</td>
</tr>
<tr id="redisinsight-value-rules" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-rules">redisinsight</a></td>
<td><code class="value-key">rules</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Additional RBAC rules</td>
</tr>
<tr id="redisinsight-value-enabled" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-enabled">redisinsight</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable network policy</td>
</tr>
<tr id="redisinsight-value-policyTypes" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-policyTypes">redisinsight</a></td>
<td><code class="value-key">policyTypes</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Policy types</td>
</tr>
<tr id="redisinsight-value-ingress" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-ingress">redisinsight</a></td>
<td><code class="value-key">ingress</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Ingress rules</td>
</tr>
<tr id="redisinsight-value-egress" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-egress">redisinsight</a></td>
<td><code class="value-key">egress</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Egress rules</td>
</tr>
<tr id="redisinsight-value-enabled" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-enabled">redisinsight</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable diagnostic mode (disables probes, overrides command)</td>
</tr>
<tr id="redisinsight-value-command" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-command">redisinsight</a></td>
<td><code class="value-key">command</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Command override for diagnostic mode</td>
</tr>
<tr id="redisinsight-value-args" class="value-anchor" data-section="redisinsight">
<td><a href="../charts/redisinsight.md#value-args">redisinsight</a></td>
<td><code class="value-key">args</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Args override for diagnostic mode</td>
</tr>
<tr id="restic-backup-value-namespaceOverride" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-namespaceOverride">restic-backup</a></td>
<td><code class="value-key">namespaceOverride</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Override the namespace for all resources.</td>
</tr>
<tr id="restic-backup-value-componentOverride" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-componentOverride">restic-backup</a></td>
<td><code class="value-key">componentOverride</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Override the component label for all resources.</td>
</tr>
<tr id="restic-backup-value-partOfOverride" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-partOfOverride">restic-backup</a></td>
<td><code class="value-key">partOfOverride</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Override the partOf label for all resources.</td>
</tr>
<tr id="restic-backup-value-applicationName" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-applicationName">restic-backup</a></td>
<td><code class="value-key">applicationName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`{{ .Chart.Name }}`</code></td>
<td>Application name.</td>
</tr>
<tr id="restic-backup-value-additionalLabels" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-additionalLabels">restic-backup</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge tpl">tpl/object</span></td>
<td><code>{}</code></td>
<td>Additional labels for all resources.</td>
</tr>
<tr id="restic-backup-value-repository" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-repository">restic-backup</a></td>
<td><code class="value-key">repository</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"/backup-repository"</code></td>
<td>Restic repository URL. Supports multiple backends.</td>
</tr>
<tr id="restic-backup-value-password" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-password">restic-backup</a></td>
<td><code class="value-key">password</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"changeme-to-a-secure-password"</code></td>
<td>Restic repository password. Required for encryption.</td>
</tr>
<tr id="restic-backup-value-existingSecret" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-existingSecret">restic-backup</a></td>
<td><code class="value-key">existingSecret</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>""</code></td>
<td>Reference to existing secret containing restic credentials.</td>
</tr>
<tr id="restic-backup-value-backendEnv" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-backendEnv">restic-backup</a></td>
<td><code class="value-key">backendEnv</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Backend-specific environment variables.</td>
</tr>
<tr id="restic-backup-value-backup" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-backup">restic-backup</a></td>
<td><code class="value-key">backup</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Backup job configuration.</td>
</tr>
<tr id="restic-backup-value-enabled" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-enabled">restic-backup</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Enable backup job.</td>
</tr>
<tr id="restic-backup-value-schedule" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-schedule">restic-backup</a></td>
<td><code class="value-key">schedule</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"0 2 * * *"</code></td>
<td>Cron schedule for backup job (default: daily at 2 AM).</td>
</tr>
<tr id="restic-backup-value-successfulJobsHistoryLimit" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-successfulJobsHistoryLimit">restic-backup</a></td>
<td><code class="value-key">successfulJobsHistoryLimit</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>3</code></td>
<td>Number of successful jobs to keep.</td>
</tr>
<tr id="restic-backup-value-failedJobsHistoryLimit" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-failedJobsHistoryLimit">restic-backup</a></td>
<td><code class="value-key">failedJobsHistoryLimit</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Number of failed jobs to keep.</td>
</tr>
<tr id="restic-backup-value-tags" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-tags">restic-backup</a></td>
<td><code class="value-key">tags</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>List of tags to apply to backups.</td>
</tr>
<tr id="restic-backup-value-excludes" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-excludes">restic-backup</a></td>
<td><code class="value-key">excludes</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Exclude patterns for backup.</td>
</tr>
<tr id="restic-backup-value-retention" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-retention">restic-backup</a></td>
<td><code class="value-key">retention</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Retention policy for backups.</td>
</tr>
<tr id="restic-backup-value-enabled" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-enabled">restic-backup</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Enable automatic pruning of old backups.</td>
</tr>
<tr id="restic-backup-value-keepLast" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-keepLast">restic-backup</a></td>
<td><code class="value-key">keepLast</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>7</code></td>
<td>Keep last N snapshots.</td>
</tr>
<tr id="restic-backup-value-keepDaily" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-keepDaily">restic-backup</a></td>
<td><code class="value-key">keepDaily</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>14</code></td>
<td>Keep daily snapshots for N days.</td>
</tr>
<tr id="restic-backup-value-keepWeekly" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-keepWeekly">restic-backup</a></td>
<td><code class="value-key">keepWeekly</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>8</code></td>
<td>Keep weekly snapshots for N weeks.</td>
</tr>
<tr id="restic-backup-value-keepMonthly" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-keepMonthly">restic-backup</a></td>
<td><code class="value-key">keepMonthly</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>12</code></td>
<td>Keep monthly snapshots for N months.</td>
</tr>
<tr id="restic-backup-value-keepYearly" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-keepYearly">restic-backup</a></td>
<td><code class="value-key">keepYearly</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>3</code></td>
<td>Keep yearly snapshots for N years.</td>
</tr>
<tr id="restic-backup-value-options" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-options">restic-backup</a></td>
<td><code class="value-key">options</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional restic backup options.</td>
</tr>
<tr id="restic-backup-value-init" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-init">restic-backup</a></td>
<td><code class="value-key">init</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Repository initialization job.</td>
</tr>
<tr id="restic-backup-value-enabled" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-enabled">restic-backup</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Enable repository initialization job.</td>
</tr>
<tr id="restic-backup-value-check" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-check">restic-backup</a></td>
<td><code class="value-key">check</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Repository check job configuration.</td>
</tr>
<tr id="restic-backup-value-enabled" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-enabled">restic-backup</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Enable repository check job.</td>
</tr>
<tr id="restic-backup-value-schedule" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-schedule">restic-backup</a></td>
<td><code class="value-key">schedule</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"0 3 * * 0"</code></td>
<td>Cron schedule for check job (default: weekly on Sunday at 3 AM).</td>
</tr>
<tr id="restic-backup-value-readData" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-readData">restic-backup</a></td>
<td><code class="value-key">readData</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Read all data packs to verify integrity (slower but thorough).</td>
</tr>
<tr id="restic-backup-value-enabled" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-enabled">restic-backup</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Enable dedicated volume for backup repository storage.</td>
</tr>
<tr id="restic-backup-value-type" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-type">restic-backup</a></td>
<td><code class="value-key">type</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>pvc</code></td>
<td>Type of volume to use for backup repository.</td>
</tr>
<tr id="restic-backup-value-mountPath" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-mountPath">restic-backup</a></td>
<td><code class="value-key">mountPath</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>/backup-repository</code></td>
<td>Mount path for the backup repository volume.</td>
</tr>
<tr id="restic-backup-value-pvc" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-pvc">restic-backup</a></td>
<td><code class="value-key">pvc</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>PersistentVolumeClaim configuration for backup repository.</td>
</tr>
<tr id="restic-backup-value-existingClaim" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-existingClaim">restic-backup</a></td>
<td><code class="value-key">existingClaim</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Name of existing PVC to use (leave empty to create new one).</td>
</tr>
<tr id="restic-backup-value-storageClassName" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-storageClassName">restic-backup</a></td>
<td><code class="value-key">storageClassName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Storage class for the PVC (uses cluster default if empty).</td>
</tr>
<tr id="restic-backup-value-accessModes" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-accessModes">restic-backup</a></td>
<td><code class="value-key">accessModes</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Access mode for the PVC.</td>
</tr>
<tr id="restic-backup-value-size" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-size">restic-backup</a></td>
<td><code class="value-key">size</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>10Gi</code></td>
<td>Storage size for backup repository.</td>
</tr>
<tr id="restic-backup-value-annotations" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-annotations">restic-backup</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional PVC annotations.</td>
</tr>
<tr id="restic-backup-value-selector" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-selector">restic-backup</a></td>
<td><code class="value-key">selector</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Resource selector for PVC.</td>
</tr>
<tr id="restic-backup-value-hostPath" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-hostPath">restic-backup</a></td>
<td><code class="value-key">hostPath</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>HostPath configuration (when type is hostPath).</td>
</tr>
<tr id="restic-backup-value-emptyDir" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-emptyDir">restic-backup</a></td>
<td><code class="value-key">emptyDir</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>EmptyDir configuration (when type is emptyDir).</td>
</tr>
<tr id="restic-backup-value-nfs" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-nfs">restic-backup</a></td>
<td><code class="value-key">nfs</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>NFS configuration (when type is nfs).</td>
</tr>
<tr id="restic-backup-value-custom" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-custom">restic-backup</a></td>
<td><code class="value-key">custom</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Custom volume specification (when type is custom).</td>
</tr>
<tr id="restic-backup-value-volumes" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-volumes">restic-backup</a></td>
<td><code class="value-key">volumes</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>List of volumes to backup. Supports multiple volume types.</td>
</tr>
<tr id="restic-backup-value-additionalLabels" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-additionalLabels">restic-backup</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional labels for CronJob.</td>
</tr>
<tr id="restic-backup-value-annotations" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-annotations">restic-backup</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Annotations for CronJob.</td>
</tr>
<tr id="restic-backup-value-additionalPodAnnotations" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-additionalPodAnnotations">restic-backup</a></td>
<td><code class="value-key">additionalPodAnnotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional pod annotations.</td>
</tr>
<tr id="restic-backup-value-concurrencyPolicy" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-concurrencyPolicy">restic-backup</a></td>
<td><code class="value-key">concurrencyPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>Forbid</code></td>
<td>Concurrency policy for backup jobs.</td>
</tr>
<tr id="restic-backup-value-restartPolicy" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-restartPolicy">restic-backup</a></td>
<td><code class="value-key">restartPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>OnFailure</code></td>
<td>Restart policy for backup pods.</td>
</tr>
<tr id="restic-backup-value-startingDeadlineSeconds" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-startingDeadlineSeconds">restic-backup</a></td>
<td><code class="value-key">startingDeadlineSeconds</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>300</code></td>
<td>Deadline in seconds for starting the job.</td>
</tr>
<tr id="restic-backup-value-securityContext" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-securityContext">restic-backup</a></td>
<td><code class="value-key">securityContext</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Pod security context.</td>
</tr>
<tr id="restic-backup-value-runAsNonRoot" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-runAsNonRoot">restic-backup</a></td>
<td><code class="value-key">runAsNonRoot</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Run as non-root user when possible.</td>
</tr>
<tr id="restic-backup-value-containerSecurityContext" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-containerSecurityContext">restic-backup</a></td>
<td><code class="value-key">containerSecurityContext</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Container security context.</td>
</tr>
<tr id="restic-backup-value-resources" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-resources">restic-backup</a></td>
<td><code class="value-key">resources</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Resource limits and requests.</td>
</tr>
<tr id="restic-backup-value-nodeSelector" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-nodeSelector">restic-backup</a></td>
<td><code class="value-key">nodeSelector</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Node selector for backup pods.</td>
</tr>
<tr id="restic-backup-value-tolerations" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-tolerations">restic-backup</a></td>
<td><code class="value-key">tolerations</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Tolerations for backup pods.</td>
</tr>
<tr id="restic-backup-value-affinity" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-affinity">restic-backup</a></td>
<td><code class="value-key">affinity</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Affinity rules for backup pods.</td>
</tr>
<tr id="restic-backup-value-ttlSecondsAfterFinished" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-ttlSecondsAfterFinished">restic-backup</a></td>
<td><code class="value-key">ttlSecondsAfterFinished</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>86400 # 24 hours</code></td>
<td>Optional TTL in seconds for finished jobs (auto-cleanup).</td>
</tr>
<tr id="restic-backup-value-activeDeadlineSeconds" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-activeDeadlineSeconds">restic-backup</a></td>
<td><code class="value-key">activeDeadlineSeconds</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>3600 # 1 hour default timeout</code></td>
<td>Optional deadline in seconds for job completion (timeout).</td>
</tr>
<tr id="restic-backup-value-useConfigMap" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-useConfigMap">restic-backup</a></td>
<td><code class="value-key">useConfigMap</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Use ConfigMap for backup scripts instead of inline commands.</td>
</tr>
<tr id="restic-backup-value-enabled" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-enabled">restic-backup</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable metrics exporter for Prometheus monitoring.</td>
</tr>
<tr id="restic-backup-value-image" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-image">restic-backup</a></td>
<td><code class="value-key">image</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Metrics exporter image configuration.</td>
</tr>
<tr id="restic-backup-value-port" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-port">restic-backup</a></td>
<td><code class="value-key">port</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>9092</code></td>
<td>Port for metrics endpoint.</td>
</tr>
<tr id="restic-backup-value-scrapeInterval" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-scrapeInterval">restic-backup</a></td>
<td><code class="value-key">scrapeInterval</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>60</code></td>
<td>Interval between metrics collection in seconds.</td>
</tr>
<tr id="restic-backup-value-additionalLabels" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-additionalLabels">restic-backup</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional labels for metrics deployment.</td>
</tr>
<tr id="restic-backup-value-annotations" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-annotations">restic-backup</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Annotations for metrics deployment.</td>
</tr>
<tr id="restic-backup-value-podAnnotations" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-podAnnotations">restic-backup</a></td>
<td><code class="value-key">podAnnotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional pod annotations for metrics exporter.</td>
</tr>
<tr id="restic-backup-value-securityContext" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-securityContext">restic-backup</a></td>
<td><code class="value-key">securityContext</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Security context for metrics exporter pod.</td>
</tr>
<tr id="restic-backup-value-containerSecurityContext" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-containerSecurityContext">restic-backup</a></td>
<td><code class="value-key">containerSecurityContext</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Container security context for metrics exporter.</td>
</tr>
<tr id="restic-backup-value-resources" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-resources">restic-backup</a></td>
<td><code class="value-key">resources</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Resource limits and requests for metrics exporter.</td>
</tr>
<tr id="restic-backup-value-nodeSelector" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-nodeSelector">restic-backup</a></td>
<td><code class="value-key">nodeSelector</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Node selector for metrics exporter.</td>
</tr>
<tr id="restic-backup-value-tolerations" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-tolerations">restic-backup</a></td>
<td><code class="value-key">tolerations</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Tolerations for metrics exporter.</td>
</tr>
<tr id="restic-backup-value-affinity" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-affinity">restic-backup</a></td>
<td><code class="value-key">affinity</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Affinity rules for metrics exporter.</td>
</tr>
<tr id="restic-backup-value-service" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-service">restic-backup</a></td>
<td><code class="value-key">service</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Service configuration for metrics.</td>
</tr>
<tr id="restic-backup-value-type" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-type">restic-backup</a></td>
<td><code class="value-key">type</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>ClusterIP</code></td>
<td>Service type.</td>
</tr>
<tr id="restic-backup-value-port" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-port">restic-backup</a></td>
<td><code class="value-key">port</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>9092</code></td>
<td>Service port.</td>
</tr>
<tr id="restic-backup-value-clusterIP" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-clusterIP">restic-backup</a></td>
<td><code class="value-key">clusterIP</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Cluster IP (optional).</td>
</tr>
<tr id="restic-backup-value-additionalLabels" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-additionalLabels">restic-backup</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional labels for service.</td>
</tr>
<tr id="restic-backup-value-annotations" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-annotations">restic-backup</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Annotations for service.</td>
</tr>
<tr id="restic-backup-value-repository" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-repository">restic-backup</a></td>
<td><code class="value-key">repository</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>restic/restic</code></td>
<td>Restic image repository.</td>
</tr>
<tr id="restic-backup-value-pullPolicy" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-pullPolicy">restic-backup</a></td>
<td><code class="value-key">pullPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>IfNotPresent</code></td>
<td>Image pull policy.</td>
</tr>
<tr id="restic-backup-value-tag" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-tag">restic-backup</a></td>
<td><code class="value-key">tag</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"0.18.1"</code></td>
<td>Image tag (overrides appVersion from Chart.yaml).</td>
</tr>
<tr id="restic-backup-value-imagePullSecrets" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-imagePullSecrets">restic-backup</a></td>
<td><code class="value-key">imagePullSecrets</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Image pull secrets.</td>
</tr>
<tr id="restic-backup-value-create" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-create">restic-backup</a></td>
<td><code class="value-key">create</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Create service account.</td>
</tr>
<tr id="restic-backup-value-annotations" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-annotations">restic-backup</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Annotations for service account.</td>
</tr>
<tr id="restic-backup-value-name" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-name">restic-backup</a></td>
<td><code class="value-key">name</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Name of existing service account to use.</td>
</tr>
<tr id="restic-backup-value-automountServiceAccountToken" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-automountServiceAccountToken">restic-backup</a></td>
<td><code class="value-key">automountServiceAccountToken</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Automount service account token.</td>
</tr>
<tr id="restic-backup-value-create" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-create">restic-backup</a></td>
<td><code class="value-key">create</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Create RBAC resources (Role, RoleBinding).</td>
</tr>
<tr id="restic-backup-value-additionalRules" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-additionalRules">restic-backup</a></td>
<td><code class="value-key">additionalRules</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Additional rules to add to the role.</td>
</tr>
<tr id="restic-backup-value-enabled" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-enabled">restic-backup</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable network policy.</td>
</tr>
<tr id="restic-backup-value-ingress" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-ingress">restic-backup</a></td>
<td><code class="value-key">ingress</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>[]</code></td>
<td>Ingress rules for network policy.</td>
</tr>
<tr id="restic-backup-value-egress" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-egress">restic-backup</a></td>
<td><code class="value-key">egress</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Egress rules for network policy.</td>
</tr>
<tr id="restic-backup-value-enabled" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-enabled">restic-backup</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable notifications on backup completion/failure.</td>
</tr>
<tr id="restic-backup-value-webhook" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-webhook">restic-backup</a></td>
<td><code class="value-key">webhook</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Webhook configuration for notifications.</td>
</tr>
<tr id="restic-backup-value-email" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-email">restic-backup</a></td>
<td><code class="value-key">email</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Email configuration for notifications.</td>
</tr>
<tr id="restic-backup-value-enabled" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-enabled">restic-backup</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable one-time restore job.</td>
</tr>
<tr id="restic-backup-value-snapshotId" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-snapshotId">restic-backup</a></td>
<td><code class="value-key">snapshotId</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"latest"</code></td>
<td>Snapshot ID to restore (latest if not specified).</td>
</tr>
<tr id="restic-backup-value-targetVolume" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-targetVolume">restic-backup</a></td>
<td><code class="value-key">targetVolume</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Target volume for restore (PVC name - for backward compatibility).</td>
</tr>
<tr id="restic-backup-value-targetVolumeConfig" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-targetVolumeConfig">restic-backup</a></td>
<td><code class="value-key">targetVolumeConfig</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Target volume configuration for restore (advanced).</td>
</tr>
<tr id="restic-backup-value-targetPath" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-targetPath">restic-backup</a></td>
<td><code class="value-key">targetPath</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"/"</code></td>
<td>Target path within the volume.</td>
</tr>
<tr id="restic-backup-value-verify" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-verify">restic-backup</a></td>
<td><code class="value-key">verify</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Verify restored data integrity.</td>
</tr>
<tr id="restic-backup-value-preBackup" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-preBackup">restic-backup</a></td>
<td><code class="value-key">preBackup</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>[]</code></td>
<td>Commands to run before backup.</td>
</tr>
<tr id="restic-backup-value-postBackup" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-postBackup">restic-backup</a></td>
<td><code class="value-key">postBackup</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>[]</code></td>
<td>Commands to run after backup.</td>
</tr>
<tr id="restic-backup-value-envFrom" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-envFrom">restic-backup</a></td>
<td><code class="value-key">envFrom</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>[]</code></td>
<td>Additional environment variables from secrets/configmaps.</td>
</tr>
<tr id="restic-backup-value-extraVolumes" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-extraVolumes">restic-backup</a></td>
<td><code class="value-key">extraVolumes</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Additional volumes to mount.</td>
</tr>
<tr id="restic-backup-value-extraVolumeMounts" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-extraVolumeMounts">restic-backup</a></td>
<td><code class="value-key">extraVolumeMounts</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Additional volume mounts for backup container.</td>
</tr>
<tr id="restic-backup-value-priorityClassName" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-priorityClassName">restic-backup</a></td>
<td><code class="value-key">priorityClassName</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>""</code></td>
<td>Priority class for backup pods.</td>
</tr>
<tr id="restic-backup-value-hostNetwork" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-hostNetwork">restic-backup</a></td>
<td><code class="value-key">hostNetwork</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable host network mode.</td>
</tr>
<tr id="restic-backup-value-dnsPolicy" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-dnsPolicy">restic-backup</a></td>
<td><code class="value-key">dnsPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>ClusterFirst</code></td>
<td>DNS policy for backup pods.</td>
</tr>
<tr id="restic-backup-value-dnsConfig" class="value-anchor" data-section="restic-backup">
<td><a href="../charts/restic-backup.md#value-dnsConfig">restic-backup</a></td>
<td><code class="value-key">dnsConfig</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>DNS configuration for backup pods.</td>
</tr>
<tr id="semaphore-value-env" class="value-anchor" data-section="semaphore">
<td><a href="../charts/semaphore.md#value-env">semaphore</a></td>
<td><code class="value-key">env</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>---BEGIN OPENSSH PRIVATE KEY----- (example) ---END OPENSSH PRIVATE KEY----- (example)</td>
</tr>
<tr id="shlink-value-enabled" class="value-anchor" data-section="shlink">
<td><a href="../charts/shlink.md#value-enabled">shlink</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable Pod Disruption Budget</td>
</tr>
<tr id="shlink-value-minAvailable" class="value-anchor" data-section="shlink">
<td><a href="../charts/shlink.md#value-minAvailable">shlink</a></td>
<td><code class="value-key">minAvailable</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Minimum available pods</td>
</tr>
<tr id="shlink-value-maxUnavailable" class="value-anchor" data-section="shlink">
<td><a href="../charts/shlink.md#value-maxUnavailable">shlink</a></td>
<td><code class="value-key">maxUnavailable</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Maximum unavailable pods (alternative to minAvailable)</td>
</tr>
<tr id="shlink-value-enabled" class="value-anchor" data-section="shlink">
<td><a href="../charts/shlink.md#value-enabled">shlink</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable diagnostic mode (sleep infinity instead of running application)</td>
</tr>
<tr id="shlink-value-command" class="value-anchor" data-section="shlink">
<td><a href="../charts/shlink.md#value-command">shlink</a></td>
<td><code class="value-key">command</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Command to run in diagnostic mode</td>
</tr>
<tr id="shlink-value-args" class="value-anchor" data-section="shlink">
<td><a href="../charts/shlink.md#value-args">shlink</a></td>
<td><code class="value-key">args</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Arguments for diagnostic mode command</td>
</tr>
<tr id="shlink-value-postgresql" class="value-anchor" data-section="shlink">
<td><a href="../charts/shlink.md#value-postgresql">shlink</a></td>
<td><code class="value-key">postgresql</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>PostgreSQL subchart configuration</td>
</tr>
<tr id="shlink-value-enabled" class="value-anchor" data-section="shlink">
<td><a href="../charts/shlink.md#value-enabled">shlink</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Enable PostgreSQL subchart</td>
</tr>
<tr id="shlink-value-image" class="value-anchor" data-section="shlink">
<td><a href="../charts/shlink.md#value-image">shlink</a></td>
<td><code class="value-key">image</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>PostgreSQL image configuration</td>
</tr>
<tr id="shlink-value-auth" class="value-anchor" data-section="shlink">
<td><a href="../charts/shlink.md#value-auth">shlink</a></td>
<td><code class="value-key">auth</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>PostgreSQL authentication configuration</td>
</tr>
<tr id="shlink-value-username" class="value-anchor" data-section="shlink">
<td><a href="../charts/shlink.md#value-username">shlink</a></td>
<td><code class="value-key">username</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>shlink</code></td>
<td>PostgreSQL username</td>
</tr>
<tr id="shlink-value-password" class="value-anchor" data-section="shlink">
<td><a href="../charts/shlink.md#value-password">shlink</a></td>
<td><code class="value-key">password</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>changeme</code></td>
<td>PostgreSQL password</td>
</tr>
<tr id="shlink-value-database" class="value-anchor" data-section="shlink">
<td><a href="../charts/shlink.md#value-database">shlink</a></td>
<td><code class="value-key">database</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>shlink</code></td>
<td>PostgreSQL database name</td>
</tr>
<tr id="shlink-value-existingSecret" class="value-anchor" data-section="shlink">
<td><a href="../charts/shlink.md#value-existingSecret">shlink</a></td>
<td><code class="value-key">existingSecret</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Existing secret with PostgreSQL credentials</td>
</tr>
<tr id="shlink-value-architecture" class="value-anchor" data-section="shlink">
<td><a href="../charts/shlink.md#value-architecture">shlink</a></td>
<td><code class="value-key">architecture</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>standalone</code></td>
<td>PostgreSQL architecture (standalone or replication)</td>
</tr>
<tr id="shlink-value-primary" class="value-anchor" data-section="shlink">
<td><a href="../charts/shlink.md#value-primary">shlink</a></td>
<td><code class="value-key">primary</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>PostgreSQL primary configuration</td>
</tr>
<tr id="shlink-value-persistence" class="value-anchor" data-section="shlink">
<td><a href="../charts/shlink.md#value-persistence">shlink</a></td>
<td><code class="value-key">persistence</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Persistence configuration for primary</td>
</tr>
<tr id="shlink-value-resources" class="value-anchor" data-section="shlink">
<td><a href="../charts/shlink.md#value-resources">shlink</a></td>
<td><code class="value-key">resources</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Resource limits for primary</td>
</tr>
<tr id="test-final-value-namespaceOverride" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-namespaceOverride">test-final</a></td>
<td><code class="value-key">namespaceOverride</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`.Release.Namespace`</code></td>
<td>Override the namespace for all resources</td>
</tr>
<tr id="test-final-value-nameOverride" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-nameOverride">test-final</a></td>
<td><code class="value-key">nameOverride</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Override the name of the chart</td>
</tr>
<tr id="test-final-value-fullnameOverride" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-fullnameOverride">test-final</a></td>
<td><code class="value-key">fullnameOverride</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Override the full name of the chart</td>
</tr>
<tr id="test-final-value-additionalLabels" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-additionalLabels">test-final</a></td>
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional labels to add to all resources</td>
</tr>
<tr id="test-final-value-additionalAnnotations" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-additionalAnnotations">test-final</a></td>
<td><code class="value-key">additionalAnnotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional annotations to add to all resources</td>
</tr>
<tr id="test-final-value-repository" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-repository">test-final</a></td>
<td><code class="value-key">repository</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>nginx:1.27.3</code></td>
<td>Docker image repository</td>
</tr>
<tr id="test-final-value-tag" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-tag">test-final</a></td>
<td><code class="value-key">tag</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>Chart appVersion</code></td>
<td>Docker image tag</td>
</tr>
<tr id="test-final-value-pullPolicy" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-pullPolicy">test-final</a></td>
<td><code class="value-key">pullPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>IfNotPresent</code></td>
<td>Image pull policy</td>
</tr>
<tr id="test-final-value-digest" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-digest">test-final</a></td>
<td><code class="value-key">digest</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Image digest (overrides tag if set)</td>
</tr>
<tr id="test-final-value-imagePullSecrets" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-imagePullSecrets">test-final</a></td>
<td><code class="value-key">imagePullSecrets</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Image pull secrets for private registries</td>
</tr>
<tr id="test-final-value-config" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-config">test-final</a></td>
<td><code class="value-key">config</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Application configuration as environment variables</td>
</tr>
<tr id="test-final-value-existingSecret" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-existingSecret">test-final</a></td>
<td><code class="value-key">existingSecret</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Name of an existing secret containing application credentials</td>
</tr>
<tr id="test-final-value-type" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-type">test-final</a></td>
<td><code class="value-key">type</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>deployment</code></td>
<td>Controller type (deployment or statefulset)</td>
</tr>
<tr id="test-final-value-replicas" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-replicas">test-final</a></td>
<td><code class="value-key">replicas</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Number of replicas</td>
</tr>
<tr id="test-final-value-strategy" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-strategy">test-final</a></td>
<td><code class="value-key">strategy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Deployment update strategy</td>
</tr>
<tr id="test-final-value-updateStrategy" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-updateStrategy">test-final</a></td>
<td><code class="value-key">updateStrategy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>StatefulSet update strategy (only used if controller.type is statefulset)</td>
</tr>
<tr id="test-final-value-podManagementPolicy" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-podManagementPolicy">test-final</a></td>
<td><code class="value-key">podManagementPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>OrderedReady</code></td>
<td>Pod management policy (only used if controller.type is statefulset)</td>
</tr>
<tr id="test-final-value-command" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-command">test-final</a></td>
<td><code class="value-key">command</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Command override for the main container</td>
</tr>
<tr id="test-final-value-args" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-args">test-final</a></td>
<td><code class="value-key">args</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Args override for the main container</td>
</tr>
<tr id="test-final-value-workingDir" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-workingDir">test-final</a></td>
<td><code class="value-key">workingDir</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Working directory for the main container</td>
</tr>
<tr id="test-final-value-terminationGracePeriodSeconds" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-terminationGracePeriodSeconds">test-final</a></td>
<td><code class="value-key">terminationGracePeriodSeconds</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>30</code></td>
<td>Termination grace period in seconds</td>
</tr>
<tr id="test-final-value-lifecycle" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-lifecycle">test-final</a></td>
<td><code class="value-key">lifecycle</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Lifecycle hooks for the main container</td>
</tr>
<tr id="test-final-value-type" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-type">test-final</a></td>
<td><code class="value-key">type</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>ClusterIP</code></td>
<td>Service type</td>
</tr>
<tr id="test-final-value-port" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-port">test-final</a></td>
<td><code class="value-key">port</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>80</code></td>
<td>Service port</td>
</tr>
<tr id="test-final-value-targetPort" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-targetPort">test-final</a></td>
<td><code class="value-key">targetPort</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>8080</code></td>
<td>Service target port (container port)</td>
</tr>
<tr id="test-final-value-nodePort" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-nodePort">test-final</a></td>
<td><code class="value-key">nodePort</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Node port (only used if type is NodePort)</td>
</tr>
<tr id="test-final-value-loadBalancerIP" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-loadBalancerIP">test-final</a></td>
<td><code class="value-key">loadBalancerIP</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Load balancer IP (only used if type is LoadBalancer)</td>
</tr>
<tr id="test-final-value-loadBalancerSourceRanges" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-loadBalancerSourceRanges">test-final</a></td>
<td><code class="value-key">loadBalancerSourceRanges</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Load balancer source ranges (only used if type is LoadBalancer)</td>
</tr>
<tr id="test-final-value-externalTrafficPolicy" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-externalTrafficPolicy">test-final</a></td>
<td><code class="value-key">externalTrafficPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>External traffic policy (only used if type is LoadBalancer or NodePort)</td>
</tr>
<tr id="test-final-value-clusterIP" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-clusterIP">test-final</a></td>
<td><code class="value-key">clusterIP</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Cluster IP (set to None for headless service)</td>
</tr>
<tr id="test-final-value-sessionAffinity" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-sessionAffinity">test-final</a></td>
<td><code class="value-key">sessionAffinity</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>None</code></td>
<td>Session affinity</td>
</tr>
<tr id="test-final-value-sessionAffinityConfig" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-sessionAffinityConfig">test-final</a></td>
<td><code class="value-key">sessionAffinityConfig</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Session affinity config</td>
</tr>
<tr id="test-final-value-annotations" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-annotations">test-final</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Service annotations</td>
</tr>
<tr id="test-final-value-labels" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-labels">test-final</a></td>
<td><code class="value-key">labels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Service labels</td>
</tr>
<tr id="test-final-value-enabled" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-enabled">test-final</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable ingress</td>
</tr>
<tr id="test-final-value-className" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-className">test-final</a></td>
<td><code class="value-key">className</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Ingress class name</td>
</tr>
<tr id="test-final-value-annotations" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-annotations">test-final</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Ingress annotations</td>
</tr>
<tr id="test-final-value-hosts" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-hosts">test-final</a></td>
<td><code class="value-key">hosts</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Ingress hosts configuration</td>
</tr>
<tr id="test-final-value-tls" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-tls">test-final</a></td>
<td><code class="value-key">tls</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Ingress TLS configuration</td>
</tr>
<tr id="test-final-value-enabled" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-enabled">test-final</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable persistent storage</td>
</tr>
<tr id="test-final-value-storageClassName" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-storageClassName">test-final</a></td>
<td><code class="value-key">storageClassName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>Default storage class</code></td>
<td>Storage class name</td>
</tr>
<tr id="test-final-value-accessMode" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-accessMode">test-final</a></td>
<td><code class="value-key">accessMode</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>ReadWriteOnce</code></td>
<td>Access mode for the persistent volume</td>
</tr>
<tr id="test-final-value-size" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-size">test-final</a></td>
<td><code class="value-key">size</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>1Gi</code></td>
<td>Size of the persistent volume</td>
</tr>
<tr id="test-final-value-existingClaim" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-existingClaim">test-final</a></td>
<td><code class="value-key">existingClaim</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Name of an existing PVC to use</td>
</tr>
<tr id="test-final-value-annotations" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-annotations">test-final</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Annotations for the PVC</td>
</tr>
<tr id="test-final-value-mountPath" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-mountPath">test-final</a></td>
<td><code class="value-key">mountPath</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>/data</code></td>
<td>Mount path for the persistent volume</td>
</tr>
<tr id="test-final-value-podSecurityContext" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-podSecurityContext">test-final</a></td>
<td><code class="value-key">podSecurityContext</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Pod security context</td>
</tr>
<tr id="test-final-value-securityContext" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-securityContext">test-final</a></td>
<td><code class="value-key">securityContext</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Container security context</td>
</tr>
<tr id="test-final-value-resources" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-resources">test-final</a></td>
<td><code class="value-key">resources</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Resource limits and requests</td>
</tr>
<tr id="test-final-value-livenessProbe" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-livenessProbe">test-final</a></td>
<td><code class="value-key">livenessProbe</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Liveness probe configuration</td>
</tr>
<tr id="test-final-value-readinessProbe" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-readinessProbe">test-final</a></td>
<td><code class="value-key">readinessProbe</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Readiness probe configuration</td>
</tr>
<tr id="test-final-value-startupProbe" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-startupProbe">test-final</a></td>
<td><code class="value-key">startupProbe</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Startup probe configuration</td>
</tr>
<tr id="test-final-value-podAnnotations" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-podAnnotations">test-final</a></td>
<td><code class="value-key">podAnnotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Pod annotations</td>
</tr>
<tr id="test-final-value-podLabels" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-podLabels">test-final</a></td>
<td><code class="value-key">podLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Pod labels</td>
</tr>
<tr id="test-final-value-nodeSelector" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-nodeSelector">test-final</a></td>
<td><code class="value-key">nodeSelector</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Node selector for pod assignment</td>
</tr>
<tr id="test-final-value-tolerations" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-tolerations">test-final</a></td>
<td><code class="value-key">tolerations</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Tolerations for pod assignment</td>
</tr>
<tr id="test-final-value-affinity" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-affinity">test-final</a></td>
<td><code class="value-key">affinity</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Affinity for pod assignment</td>
</tr>
<tr id="test-final-value-priorityClassName" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-priorityClassName">test-final</a></td>
<td><code class="value-key">priorityClassName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Priority class name for the pod</td>
</tr>
<tr id="test-final-value-topologySpreadConstraints" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-topologySpreadConstraints">test-final</a></td>
<td><code class="value-key">topologySpreadConstraints</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Topology spread constraints for pod distribution</td>
</tr>
<tr id="test-final-value-dnsPolicy" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-dnsPolicy">test-final</a></td>
<td><code class="value-key">dnsPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>ClusterFirst</code></td>
<td>DNS policy</td>
</tr>
<tr id="test-final-value-dnsConfig" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-dnsConfig">test-final</a></td>
<td><code class="value-key">dnsConfig</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>DNS config</td>
</tr>
<tr id="test-final-value-hostAliases" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-hostAliases">test-final</a></td>
<td><code class="value-key">hostAliases</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Host aliases</td>
</tr>
<tr id="test-final-value-runtimeClassName" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-runtimeClassName">test-final</a></td>
<td><code class="value-key">runtimeClassName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Runtime class name</td>
</tr>
<tr id="test-final-value-initContainers" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-initContainers">test-final</a></td>
<td><code class="value-key">initContainers</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Init containers to run before the main container</td>
</tr>
<tr id="test-final-value-extraContainers" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-extraContainers">test-final</a></td>
<td><code class="value-key">extraContainers</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Extra sidecar containers</td>
</tr>
<tr id="test-final-value-extraEnv" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-extraEnv">test-final</a></td>
<td><code class="value-key">extraEnv</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Extra environment variables</td>
</tr>
<tr id="test-final-value-extraEnvFrom" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-extraEnvFrom">test-final</a></td>
<td><code class="value-key">extraEnvFrom</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Extra environment variables from ConfigMaps or Secrets</td>
</tr>
<tr id="test-final-value-extraVolumes" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-extraVolumes">test-final</a></td>
<td><code class="value-key">extraVolumes</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Extra volumes</td>
</tr>
<tr id="test-final-value-extraVolumeMounts" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-extraVolumeMounts">test-final</a></td>
<td><code class="value-key">extraVolumeMounts</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Extra volume mounts</td>
</tr>
<tr id="test-final-value-enabled" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-enabled">test-final</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable ServiceMonitor for Prometheus Operator</td>
</tr>
<tr id="test-final-value-namespace" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-namespace">test-final</a></td>
<td><code class="value-key">namespace</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Namespace for the ServiceMonitor (defaults to the release namespace)</td>
</tr>
<tr id="test-final-value-interval" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-interval">test-final</a></td>
<td><code class="value-key">interval</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>30s</code></td>
<td>Interval at which metrics should be scraped</td>
</tr>
<tr id="test-final-value-scrapeTimeout" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-scrapeTimeout">test-final</a></td>
<td><code class="value-key">scrapeTimeout</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>10s</code></td>
<td>Timeout for scraping metrics</td>
</tr>
<tr id="test-final-value-labels" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-labels">test-final</a></td>
<td><code class="value-key">labels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional labels for the ServiceMonitor</td>
</tr>
<tr id="test-final-value-annotations" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-annotations">test-final</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional annotations for the ServiceMonitor</td>
</tr>
<tr id="test-final-value-metricRelabelings" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-metricRelabelings">test-final</a></td>
<td><code class="value-key">metricRelabelings</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Metric relabelings</td>
</tr>
<tr id="test-final-value-relabelings" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-relabelings">test-final</a></td>
<td><code class="value-key">relabelings</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Relabelings</td>
</tr>
<tr id="test-final-value-enabled" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-enabled">test-final</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable PrometheusRule for alerting</td>
</tr>
<tr id="test-final-value-namespace" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-namespace">test-final</a></td>
<td><code class="value-key">namespace</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Namespace for the PrometheusRule (defaults to the release namespace)</td>
</tr>
<tr id="test-final-value-labels" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-labels">test-final</a></td>
<td><code class="value-key">labels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional labels for the PrometheusRule</td>
</tr>
<tr id="test-final-value-rules" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-rules">test-final</a></td>
<td><code class="value-key">rules</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Alert rules</td>
</tr>
<tr id="test-final-value-enabled" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-enabled">test-final</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable PodDisruptionBudget</td>
</tr>
<tr id="test-final-value-minAvailable" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-minAvailable">test-final</a></td>
<td><code class="value-key">minAvailable</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Minimum number of pods that must be available</td>
</tr>
<tr id="test-final-value-maxUnavailable" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-maxUnavailable">test-final</a></td>
<td><code class="value-key">maxUnavailable</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Maximum number of pods that can be unavailable</td>
</tr>
<tr id="test-final-value-hpa" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-hpa">test-final</a></td>
<td><code class="value-key">hpa</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Horizontal Pod Autoscaler configuration</td>
</tr>
<tr id="test-final-value-enabled" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-enabled">test-final</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable HorizontalPodAutoscaler</td>
</tr>
<tr id="test-final-value-minReplicas" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-minReplicas">test-final</a></td>
<td><code class="value-key">minReplicas</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Minimum number of replicas</td>
</tr>
<tr id="test-final-value-maxReplicas" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-maxReplicas">test-final</a></td>
<td><code class="value-key">maxReplicas</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>3</code></td>
<td>Maximum number of replicas</td>
</tr>
<tr id="test-final-value-targetCPUUtilizationPercentage" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-targetCPUUtilizationPercentage">test-final</a></td>
<td><code class="value-key">targetCPUUtilizationPercentage</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>80</code></td>
<td>Target CPU utilization percentage</td>
</tr>
<tr id="test-final-value-targetMemoryUtilizationPercentage" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-targetMemoryUtilizationPercentage">test-final</a></td>
<td><code class="value-key">targetMemoryUtilizationPercentage</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>80</code></td>
<td>Target memory utilization percentage</td>
</tr>
<tr id="test-final-value-customMetrics" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-customMetrics">test-final</a></td>
<td><code class="value-key">customMetrics</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Custom metrics for autoscaling</td>
</tr>
<tr id="test-final-value-create" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-create">test-final</a></td>
<td><code class="value-key">create</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Create a service account</td>
</tr>
<tr id="test-final-value-name" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-name">test-final</a></td>
<td><code class="value-key">name</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Service account name (generated if not set and create is true)</td>
</tr>
<tr id="test-final-value-annotations" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-annotations">test-final</a></td>
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Service account annotations</td>
</tr>
<tr id="test-final-value-create" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-create">test-final</a></td>
<td><code class="value-key">create</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Create RBAC resources</td>
</tr>
<tr id="test-final-value-rules" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-rules">test-final</a></td>
<td><code class="value-key">rules</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Additional RBAC rules</td>
</tr>
<tr id="test-final-value-enabled" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-enabled">test-final</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable network policy</td>
</tr>
<tr id="test-final-value-policyTypes" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-policyTypes">test-final</a></td>
<td><code class="value-key">policyTypes</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Policy types</td>
</tr>
<tr id="test-final-value-ingress" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-ingress">test-final</a></td>
<td><code class="value-key">ingress</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Ingress rules</td>
</tr>
<tr id="test-final-value-egress" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-egress">test-final</a></td>
<td><code class="value-key">egress</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Egress rules</td>
</tr>
<tr id="test-final-value-enabled" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-enabled">test-final</a></td>
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable diagnostic mode (disables probes, overrides command)</td>
</tr>
<tr id="test-final-value-command" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-command">test-final</a></td>
<td><code class="value-key">command</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Command override for diagnostic mode</td>
</tr>
<tr id="test-final-value-args" class="value-anchor" data-section="test-final">
<td><a href="../charts/test-final.md#value-args">test-final</a></td>
<td><code class="value-key">args</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Args override for diagnostic mode</td>
</tr>
</tbody>
</table>

---

_Last updated: 2025-12-23 17:28:11_
