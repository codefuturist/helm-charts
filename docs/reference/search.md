---
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
  <button class="filter-btn" data-section="application">application</button>
  <button class="filter-btn" data-section="homarr">homarr</button>
  <button class="filter-btn" data-section="nginx">nginx</button>
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
</tbody>
</table>

---

*Last updated: 2025-12-23 17:21:52*
