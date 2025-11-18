{{/* vim: set filetype=mustache: */}}

{{/*
Expand the name of the chart.
*/}}
{{- define "pbs.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "pbs.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "pbs.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "pbs.labels" -}}
helm.sh/chart: {{ include "pbs.chart" . }}
{{ include "pbs.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/component: backup-server
{{- with .Values.additionalLabels }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "pbs.selectorLabels" -}}
app.kubernetes.io/name: {{ include "pbs.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "pbs.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "pbs.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the namespace
*/}}
{{- define "pbs.namespace" -}}
{{- default .Release.Namespace .Values.namespaceOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Return the PBS image
*/}}
{{- define "pbs.image" -}}
{{- $registry := .Values.image.repository -}}
{{- $tag := .Values.image.tag | toString -}}
{{- $digest := .Values.image.digest | toString -}}
{{- if $digest }}
{{- printf "%s@%s" $registry $digest -}}
{{- else }}
{{- printf "%s:%s" $registry $tag -}}
{{- end }}
{{- end }}

{{/*
Return the secret name for PBS credentials
*/}}
{{- define "pbs.secretName" -}}
{{- if .Values.pbs.existingSecret }}
{{- .Values.pbs.existingSecret }}
{{- else }}
{{- include "pbs.fullname" . }}
{{- end }}
{{- end }}

{{/*
Return the PVC name for etc
*/}}
{{- define "pbs.pvcEtcName" -}}
{{- if .Values.persistence.etc.existingClaim }}
{{- .Values.persistence.etc.existingClaim }}
{{- else }}
{{- printf "%s-etc" (include "pbs.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Return the PVC name for logs
*/}}
{{- define "pbs.pvcLogsName" -}}
{{- if .Values.persistence.logs.existingClaim }}
{{- .Values.persistence.logs.existingClaim }}
{{- else }}
{{- printf "%s-logs" (include "pbs.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Return the PVC name for lib
*/}}
{{- define "pbs.pvcLibName" -}}
{{- if .Values.persistence.lib.existingClaim }}
{{- .Values.persistence.lib.existingClaim }}
{{- else }}
{{- printf "%s-lib" (include "pbs.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Validate required values
*/}}
{{- define "pbs.validateValues" -}}
{{- if and (not .Values.pbs.existingSecret) (not .Values.pbs.password) }}
{{- fail "Either pbs.password or pbs.existingSecret must be set" }}
{{- end }}
{{- end }}
