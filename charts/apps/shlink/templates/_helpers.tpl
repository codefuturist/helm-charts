{{/* vim: set filetype=mustache: */}}

{{/*
Expand the name of the chart.
*/}}
{{- define "shlink.name" -}}
{{- include "common.names.name" . -}}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "shlink.fullname" -}}
{{- include "common.names.fullname" . -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "shlink.chart" -}}
{{- include "common.names.chart" . -}}
{{- end }}

{{/*
Common labels
*/}}
{{- define "shlink.labels" -}}
{{- $labels := include "common.labels.standard" (dict "customLabels" .Values.additionalLabels "context" $) -}}
{{- $labels -}}
{{- if not (contains "app.kubernetes.io/component" $labels) }}
app.kubernetes.io/component: url-shortener
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "shlink.selectorLabels" -}}
{{- include "common.labels.matchLabels" . -}}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "shlink.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "shlink.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the namespace
*/}}
{{- define "shlink.namespace" -}}
{{- include "common.names.namespace" . -}}
{{- end }}

{{/*
Return the Shlink image
*/}}
{{- define "shlink.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global "chart" .Chart) -}}
{{- end }}

{{/*
Return the secret name for Shlink credentials
*/}}
{{- define "shlink.secretName" -}}
{{- if .Values.shlink.existingSecret }}
{{- .Values.shlink.existingSecret }}
{{- else }}
{{- include "shlink.fullname" . }}
{{- end }}
{{- end }}

{{/*
Return the PVC name
*/}}
{{- define "shlink.pvcName" -}}
{{- if .Values.persistence.existingClaim }}
{{- .Values.persistence.existingClaim }}
{{- else }}
{{- include "shlink.fullname" . }}
{{- end }}
{{- end }}

{{/*
Return the database secret name
*/}}
{{- define "shlink.databaseSecretName" -}}
{{- if .Values.database.existingSecret }}
{{- .Values.database.existingSecret }}
{{- else if .Values.postgresql.enabled }}
{{- printf "%s-postgresql" (include "shlink.fullname" .) }}
{{- else }}
{{- include "shlink.fullname" . }}
{{- end }}
{{- end }}

{{/*
Return the database host
*/}}
{{- define "shlink.databaseHost" -}}
{{- if .Values.postgresql.enabled }}
{{- printf "%s-postgresql" (include "shlink.fullname" .) }}
{{- else }}
{{- required "database.host is required when postgresql.enabled is false" .Values.database.host }}
{{- end }}
{{- end }}

{{/*
Return the database port
*/}}
{{- define "shlink.databasePort" -}}
{{- if .Values.postgresql.enabled }}
{{- print "5432" }}
{{- else }}
{{- .Values.database.port | toString }}
{{- end }}
{{- end }}

{{/*
Return the database name
*/}}
{{- define "shlink.databaseName" -}}
{{- if .Values.postgresql.enabled }}
{{- .Values.postgresql.auth.database }}
{{- else }}
{{- .Values.database.name }}
{{- end }}
{{- end }}

{{/*
Return the database username
*/}}
{{- define "shlink.databaseUser" -}}
{{- if .Values.postgresql.enabled }}
{{- .Values.postgresql.auth.username }}
{{- else }}
{{- .Values.database.user }}
{{- end }}
{{- end }}

{{/*
Validate required values
*/}}
{{- define "shlink.validateValues" -}}
{{- if and (not .Values.postgresql.enabled) (not .Values.database.host) }}
{{- fail "database.host is required when postgresql.enabled is false" }}
{{- end }}
{{- if and (not .Values.database.existingSecret) (not .Values.postgresql.enabled) (not .Values.database.password) }}
{{- fail "Either database.password, database.existingSecret, or postgresql.enabled must be set" }}
{{- end }}
{{- end }}

{{/*
Return the web client ConfigMap name
*/}}
{{- define "shlink.webClientConfigMapName" -}}
{{- printf "%s-webclient-config" (include "shlink.fullname" .) }}
{{- end }}

{{/*
Web client labels
*/}}
{{- define "shlink.webClientLabels" -}}
helm.sh/chart: {{ include "shlink.chart" . }}
{{ include "shlink.webClientSelectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/component: web-client
{{- with .Values.additionalLabels }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
Web client selector labels
*/}}
{{- define "shlink.webClientSelectorLabels" -}}
app.kubernetes.io/name: {{ include "shlink.name" . }}-webclient
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Return the web client image
*/}}
{{- define "shlink.webClientImage" -}}
{{- $registry := .Values.webClient.image.repository -}}
{{- $tag := .Values.webClient.image.tag | toString -}}
{{- $digest := .Values.webClient.image.digest | toString -}}
{{- if $digest }}
{{- printf "%s@%s" $registry $digest -}}
{{- else }}
{{- printf "%s:%s" $registry $tag -}}
{{- end }}
{{- end }}
