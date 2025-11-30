{{/* vim: set filetype=mustache: */}}

{{/*
Define the name of the chart/application.
*/}}
{{- define "restic-backup.name" -}}
{{- include "common.names.name" . -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "restic-backup.chart" -}}
{{- include "common.names.chart" . -}}
{{- end }}

{{/*
Renders a value that contains template.
Usage:
{{ include "restic-backup.tplvalues.render" ( dict "value" .Values.path.to.the.Value "context" $) }}
*/}}
{{- define "restic-backup.tplvalues.render" -}}
{{- include "common.tplvalues.render" . -}}
{{- end -}}

{{/*
Additional common labels
*/}}
{{- define "restic-backup.additionalLabels" -}}
{{- if .Values.additionalLabels }}
{{ include "restic-backup.tplvalues.render" ( dict "value" .Values.additionalLabels "context" $ ) }}
{{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "restic-backup.labels" -}}
helm.sh/chart: {{ include "restic-backup.chart" . }}
{{ include "restic-backup.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if .Values.componentOverride }}
app.kubernetes.io/component: {{ .Values.componentOverride }}
{{- else }}
app.kubernetes.io/component: backup
{{- end }}
{{- if .Values.partOfOverride }}
app.kubernetes.io/part-of: {{ .Values.partOfOverride }}
{{- else }}
app.kubernetes.io/part-of: {{ include "restic-backup.name" . }}
{{- end }}
{{ include "restic-backup.additionalLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "restic-backup.selectorLabels" -}}
{{- include "common.labels.matchLabels" . -}}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "restic-backup.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "restic-backup.name" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Define the namespace
*/}}
{{- define "restic-backup.namespace" -}}
{{- include "common.names.namespace" . -}}
{{- end }}

{{/*
Return the restic image
*/}}
{{- define "restic-backup.image" -}}
{{- $tag := .Values.image.tag | default .Chart.AppVersion -}}
{{- printf "%s:%s" .Values.image.repository $tag -}}
{{- end }}

{{/*
Return the secret name containing restic credentials
*/}}
{{- define "restic-backup.secretName" -}}
{{- if .Values.restic.existingSecret }}
{{- .Values.restic.existingSecret }}
{{- else }}
{{- include "restic-backup.name" . }}-credentials
{{- end }}
{{- end }}

{{/*
Return true if a secret should be created
*/}}
{{- define "restic-backup.createSecret" -}}
{{- if not .Values.restic.existingSecret }}
{{- if and .Values.restic.repository .Values.restic.password }}
true
{{- end }}
{{- end }}
{{- end }}

{{/*
Validate required values
*/}}
{{- define "restic-backup.validateValues" -}}
{{- if and .Values.restic.backup.enabled (not .Values.volumes) }}
{{- fail "At least one volume must be specified in .Values.volumes when backup is enabled" }}
{{- end }}
{{- if and .Values.restic.backup.enabled (not .Values.restic.repository) (not .Values.restic.existingSecret) }}
{{- fail "Either .Values.restic.repository or .Values.restic.existingSecret must be specified" }}
{{- end }}
{{- if and .Values.restic.backup.enabled .Values.restic.repository (not .Values.restic.password) (not .Values.restic.existingSecret) }}
{{- fail "Either .Values.restic.password or .Values.restic.existingSecret must be specified" }}
{{- end }}
{{- end }}

{{/*
Get backup volume PVC name
*/}}
{{- define "restic-backup.backupVolumePVCName" -}}
{{- if .Values.backupVolume.pvc.existingClaim -}}
{{- .Values.backupVolume.pvc.existingClaim -}}
{{- else -}}
{{- include "restic-backup.name" . }}-repository
{{- end -}}
{{- end -}}

{{/*
Generate backup volume configuration
*/}}
{{- define "restic-backup.backupVolume" -}}
{{- if .Values.backupVolume.enabled -}}
- name: backup-repository
  {{- if eq .Values.backupVolume.type "pvc" }}
  persistentVolumeClaim:
    claimName: {{ include "restic-backup.backupVolumePVCName" . }}
  {{- else if eq .Values.backupVolume.type "hostPath" }}
  hostPath:
    path: {{ .Values.backupVolume.hostPath.path }}
    type: {{ .Values.backupVolume.hostPath.type }}
  {{- else if eq .Values.backupVolume.type "emptyDir" }}
  emptyDir:
    {{- if .Values.backupVolume.emptyDir.sizeLimit }}
    sizeLimit: {{ .Values.backupVolume.emptyDir.sizeLimit }}
    {{- end }}
  {{- else if eq .Values.backupVolume.type "nfs" }}
  nfs:
    server: {{ .Values.backupVolume.nfs.server }}
    path: {{ .Values.backupVolume.nfs.path }}
    readOnly: {{ .Values.backupVolume.nfs.readOnly }}
  {{- else if eq .Values.backupVolume.type "custom" }}
  {{- toYaml .Values.backupVolume.custom | nindent 2 }}
  {{- end }}
{{- end -}}
{{- end -}}

{{/*
Generate backup volume mount configuration
*/}}
{{- define "restic-backup.backupVolumeMount" -}}
{{- if .Values.backupVolume.enabled -}}
- name: backup-repository
  mountPath: {{ .Values.backupVolume.mountPath }}
{{- end -}}
{{- end -}}
