---
tags:
  - application
  - restic-backup
---

# restic-backup

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square)
![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)
![AppVersion: 0.17.3](https://img.shields.io/badge/AppVersion-0.17.3-informational?style=flat-square)

A user-friendly Helm chart for automated Kubernetes volume backups using restic with support for multiple storage backends and flexible scheduling

## Quick Links

- [Installation](#installing-the-chart)
- [Values Reference](#values)
- [Search All Values](../reference/search.md)

## Installing the Chart

```bash
helm repo add pandia https://charts.pandia.io
helm repo update
helm install my-restic-backup pandia/restic-backup
```

## Values

!!! tip "Search Values"
Press ++ctrl+k++ or ++cmd+k++ to search, or use the [interactive values search](../reference/search.md).

<div class="filter-buttons">
  <button class="filter-btn" data-section="advanced-parameters">Advanced Parameters</button>
  <button class="filter-btn" data-section="backup-volume-configuration">Backup Volume Configuration</button>
  <button class="filter-btn" data-section="cronjob-parameters">CronJob Parameters</button>
  <button class="filter-btn" data-section="global-parameters">Global Parameters</button>
  <button class="filter-btn" data-section="hooks-parameters">Hooks Parameters</button>
  <button class="filter-btn" data-section="image-parameters">Image Parameters</button>
  <button class="filter-btn" data-section="metrics-parameters">Metrics Parameters</button>
  <button class="filter-btn" data-section="network-policy-parameters">Network Policy Parameters</button>
  <button class="filter-btn" data-section="notifications-parameters">Notifications Parameters</button>
  <button class="filter-btn" data-section="rbac-parameters">RBAC Parameters</button>
  <button class="filter-btn" data-section="restic-configuration">Restic Configuration</button>
  <button class="filter-btn" data-section="restore-parameters">Restore Parameters</button>
  <button class="filter-btn" data-section="scripts-parameters">Scripts Parameters</button>
  <button class="filter-btn" data-section="serviceaccount-parameters">ServiceAccount Parameters</button>
  <button class="filter-btn" data-section="volumes-configuration">Volumes Configuration</button>
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
<tr class="values-section-header"><td colspan="4"><strong>Advanced Parameters</strong></td></tr>
<tr id="value-envFrom" class="value-anchor" data-section="advanced-parameters">
<td><code class="value-key">envFrom</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>[]</code></td>
<td>Additional environment variables from secrets/configmaps.</td>
</tr>
<tr id="value-extraVolumes" class="value-anchor" data-section="advanced-parameters">
<td><code class="value-key">extraVolumes</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Additional volumes to mount.</td>
</tr>
<tr id="value-extraVolumeMounts" class="value-anchor" data-section="advanced-parameters">
<td><code class="value-key">extraVolumeMounts</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Additional volume mounts for backup container.</td>
</tr>
<tr id="value-priorityClassName" class="value-anchor" data-section="advanced-parameters">
<td><code class="value-key">priorityClassName</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>""</code></td>
<td>Priority class for backup pods.</td>
</tr>
<tr id="value-hostNetwork" class="value-anchor" data-section="advanced-parameters">
<td><code class="value-key">hostNetwork</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable host network mode.</td>
</tr>
<tr id="value-dnsPolicy" class="value-anchor" data-section="advanced-parameters">
<td><code class="value-key">dnsPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>ClusterFirst</code></td>
<td>DNS policy for backup pods.</td>
</tr>
<tr id="value-dnsConfig" class="value-anchor" data-section="advanced-parameters">
<td><code class="value-key">dnsConfig</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>DNS configuration for backup pods.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Backup Volume Configuration</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="backup-volume-configuration">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Enable dedicated volume for backup repository storage.</td>
</tr>
<tr id="value-type" class="value-anchor" data-section="backup-volume-configuration">
<td><code class="value-key">type</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>pvc</code></td>
<td>Type of volume to use for backup repository.</td>
</tr>
<tr id="value-mountPath" class="value-anchor" data-section="backup-volume-configuration">
<td><code class="value-key">mountPath</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>/backup-repository</code></td>
<td>Mount path for the backup repository volume.</td>
</tr>
<tr id="value-pvc" class="value-anchor" data-section="backup-volume-configuration">
<td><code class="value-key">pvc</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>PersistentVolumeClaim configuration for backup repository.</td>
</tr>
<tr id="value-existingClaim" class="value-anchor" data-section="backup-volume-configuration">
<td><code class="value-key">existingClaim</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Name of existing PVC to use (leave empty to create new one).</td>
</tr>
<tr id="value-storageClassName" class="value-anchor" data-section="backup-volume-configuration">
<td><code class="value-key">storageClassName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Storage class for the PVC (uses cluster default if empty).</td>
</tr>
<tr id="value-accessModes" class="value-anchor" data-section="backup-volume-configuration">
<td><code class="value-key">accessModes</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`nil`</code></td>
<td>Access mode for the PVC.</td>
</tr>
<tr id="value-size" class="value-anchor" data-section="backup-volume-configuration">
<td><code class="value-key">size</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>10Gi</code></td>
<td>Storage size for backup repository.</td>
</tr>
<tr id="value-annotations" class="value-anchor" data-section="backup-volume-configuration">
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional PVC annotations.</td>
</tr>
<tr id="value-selector" class="value-anchor" data-section="backup-volume-configuration">
<td><code class="value-key">selector</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Resource selector for PVC.</td>
</tr>
<tr id="value-hostPath" class="value-anchor" data-section="backup-volume-configuration">
<td><code class="value-key">hostPath</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>HostPath configuration (when type is hostPath).</td>
</tr>
<tr id="value-emptyDir" class="value-anchor" data-section="backup-volume-configuration">
<td><code class="value-key">emptyDir</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>EmptyDir configuration (when type is emptyDir).</td>
</tr>
<tr id="value-nfs" class="value-anchor" data-section="backup-volume-configuration">
<td><code class="value-key">nfs</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>NFS configuration (when type is nfs).</td>
</tr>
<tr id="value-custom" class="value-anchor" data-section="backup-volume-configuration">
<td><code class="value-key">custom</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Custom volume specification (when type is custom).</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>CronJob Parameters</strong></td></tr>
<tr id="value-additionalLabels" class="value-anchor" data-section="cronjob-parameters">
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional labels for CronJob.</td>
</tr>
<tr id="value-annotations" class="value-anchor" data-section="cronjob-parameters">
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Annotations for CronJob.</td>
</tr>
<tr id="value-additionalPodAnnotations" class="value-anchor" data-section="cronjob-parameters">
<td><code class="value-key">additionalPodAnnotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional pod annotations.</td>
</tr>
<tr id="value-concurrencyPolicy" class="value-anchor" data-section="cronjob-parameters">
<td><code class="value-key">concurrencyPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>Forbid</code></td>
<td>Concurrency policy for backup jobs.</td>
</tr>
<tr id="value-restartPolicy" class="value-anchor" data-section="cronjob-parameters">
<td><code class="value-key">restartPolicy</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>OnFailure</code></td>
<td>Restart policy for backup pods.</td>
</tr>
<tr id="value-startingDeadlineSeconds" class="value-anchor" data-section="cronjob-parameters">
<td><code class="value-key">startingDeadlineSeconds</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>300</code></td>
<td>Deadline in seconds for starting the job.</td>
</tr>
<tr id="value-securityContext" class="value-anchor" data-section="cronjob-parameters">
<td><code class="value-key">securityContext</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Pod security context.</td>
</tr>
<tr id="value-runAsNonRoot" class="value-anchor" data-section="cronjob-parameters">
<td><code class="value-key">runAsNonRoot</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Run as non-root user when possible.</td>
</tr>
<tr id="value-containerSecurityContext" class="value-anchor" data-section="cronjob-parameters">
<td><code class="value-key">containerSecurityContext</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Container security context.</td>
</tr>
<tr id="value-resources" class="value-anchor" data-section="cronjob-parameters">
<td><code class="value-key">resources</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Resource limits and requests.</td>
</tr>
<tr id="value-nodeSelector" class="value-anchor" data-section="cronjob-parameters">
<td><code class="value-key">nodeSelector</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Node selector for backup pods.</td>
</tr>
<tr id="value-tolerations" class="value-anchor" data-section="cronjob-parameters">
<td><code class="value-key">tolerations</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Tolerations for backup pods.</td>
</tr>
<tr id="value-affinity" class="value-anchor" data-section="cronjob-parameters">
<td><code class="value-key">affinity</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Affinity rules for backup pods.</td>
</tr>
<tr id="value-ttlSecondsAfterFinished" class="value-anchor" data-section="cronjob-parameters">
<td><code class="value-key">ttlSecondsAfterFinished</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>86400 # 24 hours</code></td>
<td>Optional TTL in seconds for finished jobs (auto-cleanup).</td>
</tr>
<tr id="value-activeDeadlineSeconds" class="value-anchor" data-section="cronjob-parameters">
<td><code class="value-key">activeDeadlineSeconds</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>3600 # 1 hour default timeout</code></td>
<td>Optional deadline in seconds for job completion (timeout).</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Global Parameters</strong></td></tr>
<tr id="value-namespaceOverride" class="value-anchor" data-section="global-parameters">
<td><code class="value-key">namespaceOverride</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Override the namespace for all resources.</td>
</tr>
<tr id="value-componentOverride" class="value-anchor" data-section="global-parameters">
<td><code class="value-key">componentOverride</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Override the component label for all resources.</td>
</tr>
<tr id="value-partOfOverride" class="value-anchor" data-section="global-parameters">
<td><code class="value-key">partOfOverride</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Override the partOf label for all resources.</td>
</tr>
<tr id="value-applicationName" class="value-anchor" data-section="global-parameters">
<td><code class="value-key">applicationName</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>`{{ .Chart.Name }}`</code></td>
<td>Application name.</td>
</tr>
<tr id="value-additionalLabels" class="value-anchor" data-section="global-parameters">
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge tpl">tpl/object</span></td>
<td><code>{}</code></td>
<td>Additional labels for all resources.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Hooks Parameters</strong></td></tr>
<tr id="value-preBackup" class="value-anchor" data-section="hooks-parameters">
<td><code class="value-key">preBackup</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>[]</code></td>
<td>Commands to run before backup.</td>
</tr>
<tr id="value-postBackup" class="value-anchor" data-section="hooks-parameters">
<td><code class="value-key">postBackup</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>[]</code></td>
<td>Commands to run after backup.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Image Parameters</strong></td></tr>
<tr id="value-repository" class="value-anchor" data-section="image-parameters">
<td><code class="value-key">repository</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>restic/restic</code></td>
<td>Restic image repository.</td>
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
<td><code>"0.18.1"</code></td>
<td>Image tag (overrides appVersion from Chart.yaml).</td>
</tr>
<tr id="value-imagePullSecrets" class="value-anchor" data-section="image-parameters">
<td><code class="value-key">imagePullSecrets</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Image pull secrets.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Metrics Parameters</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="metrics-parameters">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable metrics exporter for Prometheus monitoring.</td>
</tr>
<tr id="value-image" class="value-anchor" data-section="metrics-parameters">
<td><code class="value-key">image</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Metrics exporter image configuration.</td>
</tr>
<tr id="value-port" class="value-anchor" data-section="metrics-parameters">
<td><code class="value-key">port</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>9092</code></td>
<td>Port for metrics endpoint.</td>
</tr>
<tr id="value-scrapeInterval" class="value-anchor" data-section="metrics-parameters">
<td><code class="value-key">scrapeInterval</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>60</code></td>
<td>Interval between metrics collection in seconds.</td>
</tr>
<tr id="value-additionalLabels" class="value-anchor" data-section="metrics-parameters">
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional labels for metrics deployment.</td>
</tr>
<tr id="value-annotations" class="value-anchor" data-section="metrics-parameters">
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Annotations for metrics deployment.</td>
</tr>
<tr id="value-podAnnotations" class="value-anchor" data-section="metrics-parameters">
<td><code class="value-key">podAnnotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional pod annotations for metrics exporter.</td>
</tr>
<tr id="value-securityContext" class="value-anchor" data-section="metrics-parameters">
<td><code class="value-key">securityContext</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Security context for metrics exporter pod.</td>
</tr>
<tr id="value-containerSecurityContext" class="value-anchor" data-section="metrics-parameters">
<td><code class="value-key">containerSecurityContext</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Container security context for metrics exporter.</td>
</tr>
<tr id="value-resources" class="value-anchor" data-section="metrics-parameters">
<td><code class="value-key">resources</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Resource limits and requests for metrics exporter.</td>
</tr>
<tr id="value-nodeSelector" class="value-anchor" data-section="metrics-parameters">
<td><code class="value-key">nodeSelector</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Node selector for metrics exporter.</td>
</tr>
<tr id="value-tolerations" class="value-anchor" data-section="metrics-parameters">
<td><code class="value-key">tolerations</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Tolerations for metrics exporter.</td>
</tr>
<tr id="value-affinity" class="value-anchor" data-section="metrics-parameters">
<td><code class="value-key">affinity</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Affinity rules for metrics exporter.</td>
</tr>
<tr id="value-service" class="value-anchor" data-section="metrics-parameters">
<td><code class="value-key">service</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Service configuration for metrics.</td>
</tr>
<tr id="value-type" class="value-anchor" data-section="metrics-parameters">
<td><code class="value-key">type</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>ClusterIP</code></td>
<td>Service type.</td>
</tr>
<tr id="value-port" class="value-anchor" data-section="metrics-parameters">
<td><code class="value-key">port</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>9092</code></td>
<td>Service port.</td>
</tr>
<tr id="value-clusterIP" class="value-anchor" data-section="metrics-parameters">
<td><code class="value-key">clusterIP</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Cluster IP (optional).</td>
</tr>
<tr id="value-additionalLabels" class="value-anchor" data-section="metrics-parameters">
<td><code class="value-key">additionalLabels</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional labels for service.</td>
</tr>
<tr id="value-annotations" class="value-anchor" data-section="metrics-parameters">
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Annotations for service.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Network Policy Parameters</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="network-policy-parameters">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable network policy.</td>
</tr>
<tr id="value-ingress" class="value-anchor" data-section="network-policy-parameters">
<td><code class="value-key">ingress</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>[]</code></td>
<td>Ingress rules for network policy.</td>
</tr>
<tr id="value-egress" class="value-anchor" data-section="network-policy-parameters">
<td><code class="value-key">egress</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Egress rules for network policy.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Notifications Parameters</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="notifications-parameters">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable notifications on backup completion/failure.</td>
</tr>
<tr id="value-webhook" class="value-anchor" data-section="notifications-parameters">
<td><code class="value-key">webhook</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Webhook configuration for notifications.</td>
</tr>
<tr id="value-email" class="value-anchor" data-section="notifications-parameters">
<td><code class="value-key">email</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Email configuration for notifications.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>RBAC Parameters</strong></td></tr>
<tr id="value-create" class="value-anchor" data-section="rbac-parameters">
<td><code class="value-key">create</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Create RBAC resources (Role, RoleBinding).</td>
</tr>
<tr id="value-additionalRules" class="value-anchor" data-section="rbac-parameters">
<td><code class="value-key">additionalRules</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>Additional rules to add to the role.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Restic Configuration</strong></td></tr>
<tr id="value-repository" class="value-anchor" data-section="restic-configuration">
<td><code class="value-key">repository</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"/backup-repository"</code></td>
<td>Restic repository URL. Supports multiple backends.</td>
</tr>
<tr id="value-password" class="value-anchor" data-section="restic-configuration">
<td><code class="value-key">password</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"changeme-to-a-secure-password"</code></td>
<td>Restic repository password. Required for encryption.</td>
</tr>
<tr id="value-existingSecret" class="value-anchor" data-section="restic-configuration">
<td><code class="value-key">existingSecret</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>""</code></td>
<td>Reference to existing secret containing restic credentials.</td>
</tr>
<tr id="value-backendEnv" class="value-anchor" data-section="restic-configuration">
<td><code class="value-key">backendEnv</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Backend-specific environment variables.</td>
</tr>
<tr id="value-backup" class="value-anchor" data-section="restic-configuration">
<td><code class="value-key">backup</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Backup job configuration.</td>
</tr>
<tr id="value-enabled" class="value-anchor" data-section="restic-configuration">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Enable backup job.</td>
</tr>
<tr id="value-schedule" class="value-anchor" data-section="restic-configuration">
<td><code class="value-key">schedule</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"0 2 * * *"</code></td>
<td>Cron schedule for backup job (default: daily at 2 AM).</td>
</tr>
<tr id="value-successfulJobsHistoryLimit" class="value-anchor" data-section="restic-configuration">
<td><code class="value-key">successfulJobsHistoryLimit</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>3</code></td>
<td>Number of successful jobs to keep.</td>
</tr>
<tr id="value-failedJobsHistoryLimit" class="value-anchor" data-section="restic-configuration">
<td><code class="value-key">failedJobsHistoryLimit</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>1</code></td>
<td>Number of failed jobs to keep.</td>
</tr>
<tr id="value-tags" class="value-anchor" data-section="restic-configuration">
<td><code class="value-key">tags</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>List of tags to apply to backups.</td>
</tr>
<tr id="value-excludes" class="value-anchor" data-section="restic-configuration">
<td><code class="value-key">excludes</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>`nil`</code></td>
<td>Exclude patterns for backup.</td>
</tr>
<tr id="value-retention" class="value-anchor" data-section="restic-configuration">
<td><code class="value-key">retention</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Retention policy for backups.</td>
</tr>
<tr id="value-enabled" class="value-anchor" data-section="restic-configuration">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Enable automatic pruning of old backups.</td>
</tr>
<tr id="value-keepLast" class="value-anchor" data-section="restic-configuration">
<td><code class="value-key">keepLast</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>7</code></td>
<td>Keep last N snapshots.</td>
</tr>
<tr id="value-keepDaily" class="value-anchor" data-section="restic-configuration">
<td><code class="value-key">keepDaily</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>14</code></td>
<td>Keep daily snapshots for N days.</td>
</tr>
<tr id="value-keepWeekly" class="value-anchor" data-section="restic-configuration">
<td><code class="value-key">keepWeekly</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>8</code></td>
<td>Keep weekly snapshots for N weeks.</td>
</tr>
<tr id="value-keepMonthly" class="value-anchor" data-section="restic-configuration">
<td><code class="value-key">keepMonthly</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>12</code></td>
<td>Keep monthly snapshots for N months.</td>
</tr>
<tr id="value-keepYearly" class="value-anchor" data-section="restic-configuration">
<td><code class="value-key">keepYearly</code></td>
<td><span class="type-badge int">int</span></td>
<td><code>3</code></td>
<td>Keep yearly snapshots for N years.</td>
</tr>
<tr id="value-options" class="value-anchor" data-section="restic-configuration">
<td><code class="value-key">options</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Additional restic backup options.</td>
</tr>
<tr id="value-init" class="value-anchor" data-section="restic-configuration">
<td><code class="value-key">init</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Repository initialization job.</td>
</tr>
<tr id="value-enabled" class="value-anchor" data-section="restic-configuration">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Enable repository initialization job.</td>
</tr>
<tr id="value-check" class="value-anchor" data-section="restic-configuration">
<td><code class="value-key">check</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>`nil`</code></td>
<td>Repository check job configuration.</td>
</tr>
<tr id="value-enabled" class="value-anchor" data-section="restic-configuration">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Enable repository check job.</td>
</tr>
<tr id="value-schedule" class="value-anchor" data-section="restic-configuration">
<td><code class="value-key">schedule</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"0 3 * * 0"</code></td>
<td>Cron schedule for check job (default: weekly on Sunday at 3 AM).</td>
</tr>
<tr id="value-readData" class="value-anchor" data-section="restic-configuration">
<td><code class="value-key">readData</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Read all data packs to verify integrity (slower but thorough).</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Restore Parameters</strong></td></tr>
<tr id="value-enabled" class="value-anchor" data-section="restore-parameters">
<td><code class="value-key">enabled</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>false</code></td>
<td>Enable one-time restore job.</td>
</tr>
<tr id="value-snapshotId" class="value-anchor" data-section="restore-parameters">
<td><code class="value-key">snapshotId</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"latest"</code></td>
<td>Snapshot ID to restore (latest if not specified).</td>
</tr>
<tr id="value-targetVolume" class="value-anchor" data-section="restore-parameters">
<td><code class="value-key">targetVolume</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Target volume for restore (PVC name - for backward compatibility).</td>
</tr>
<tr id="value-targetVolumeConfig" class="value-anchor" data-section="restore-parameters">
<td><code class="value-key">targetVolumeConfig</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Target volume configuration for restore (advanced).</td>
</tr>
<tr id="value-targetPath" class="value-anchor" data-section="restore-parameters">
<td><code class="value-key">targetPath</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>"/"</code></td>
<td>Target path within the volume.</td>
</tr>
<tr id="value-verify" class="value-anchor" data-section="restore-parameters">
<td><code class="value-key">verify</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Verify restored data integrity.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Scripts Parameters</strong></td></tr>
<tr id="value-useConfigMap" class="value-anchor" data-section="scripts-parameters">
<td><code class="value-key">useConfigMap</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Use ConfigMap for backup scripts instead of inline commands.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>ServiceAccount Parameters</strong></td></tr>
<tr id="value-create" class="value-anchor" data-section="serviceaccount-parameters">
<td><code class="value-key">create</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Create service account.</td>
</tr>
<tr id="value-annotations" class="value-anchor" data-section="serviceaccount-parameters">
<td><code class="value-key">annotations</code></td>
<td><span class="type-badge object">object</span></td>
<td><code>{}</code></td>
<td>Annotations for service account.</td>
</tr>
<tr id="value-name" class="value-anchor" data-section="serviceaccount-parameters">
<td><code class="value-key">name</code></td>
<td><span class="type-badge string">string</span></td>
<td><code>""</code></td>
<td>Name of existing service account to use.</td>
</tr>
<tr id="value-automountServiceAccountToken" class="value-anchor" data-section="serviceaccount-parameters">
<td><code class="value-key">automountServiceAccountToken</code></td>
<td><span class="type-badge bool">bool</span></td>
<td><code>true</code></td>
<td>Automount service account token.</td>
</tr>
<tr class="values-section-header"><td colspan="4"><strong>Volumes Configuration</strong></td></tr>
<tr id="value-volumes" class="value-anchor" data-section="volumes-configuration">
<td><code class="value-key">volumes</code></td>
<td><span class="type-badge list">list</span></td>
<td><code>[]</code></td>
<td>List of volumes to backup. Supports multiple volume types.</td>
</tr>
</tbody>
</table>

---

_Autogenerated from chart metadata using [helm-docs](https://github.com/norwoodj/helm-docs)_
