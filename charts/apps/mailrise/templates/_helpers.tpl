{{/* vim: set filetype=mustache: */}}

{{/*
Expand the name of the chart.
*/}}
{{- define "mailrise.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "mailrise.fullname" -}}
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
{{- define "mailrise.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "mailrise.labels" -}}
helm.sh/chart: {{ include "mailrise.chart" . }}
{{ include "mailrise.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/component: database-admin
{{- with .Values.additionalLabels }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "mailrise.selectorLabels" -}}
app.kubernetes.io/name: {{ include "mailrise.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "mailrise.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "mailrise.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the namespace
*/}}
{{- define "mailrise.namespace" -}}
{{- default .Release.Namespace .Values.namespaceOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Return the Mailrise image
*/}}
{{- define "mailrise.image" -}}
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
Return the secret name for Mailrise credentials
*/}}
{{- define "mailrise.secretName" -}}
{{- if .Values.mailrise.existingSecret }}
{{- .Values.mailrise.existingSecret }}
{{- else }}
{{- include "mailrise.fullname" . }}
{{- end }}
{{- end }}

{{/*
Return the PVC name
*/}}
{{- define "mailrise.pvcName" -}}
{{- if .Values.persistence.existingClaim }}
{{- .Values.persistence.existingClaim }}
{{- else }}
{{- include "mailrise.fullname" . }}
{{- end }}
{{- end }}

{{/*
Return the ConfigMap name for server definitions
*/}}
{{- define "mailrise.serverDefinitionsConfigMapName" -}}
{{- if .Values.mailrise.existingServerDefinitionsConfigMap }}
{{- .Values.mailrise.existingServerDefinitionsConfigMap }}
{{- else }}
{{- printf "%s-server-definitions" (include "mailrise.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Validate required values
*/}}
{{- define "mailrise.validateValues" -}}
{{- if and (not .Values.mailrise.existingSecret) (not .Values.mailrise.password) }}
{{- fail "Either mailrise.password or mailrise.existingSecret must be set" }}
{{- end }}
{{- end }}

{{/*
Return the SMTP secret name
*/}}
{{- define "mailrise.smtpSecretName" -}}
{{- if .Values.mailrise.smtp.existingSecret }}
{{- .Values.mailrise.smtp.existingSecret }}
{{- else }}
{{- printf "%s-smtp" (include "mailrise.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Return the pgpass secret name
*/}}
{{- define "mailrise.pgpassSecretName" -}}
{{- if .Values.mailrise.existingPgpassSecret }}
{{- .Values.mailrise.existingPgpassSecret }}
{{- else }}
{{- printf "%s-pgpass" (include "mailrise.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Return the config_local ConfigMap name
*/}}
{{- define "mailrise.configLocalConfigMapName" -}}
{{- if .Values.mailrise.existingConfigLocalConfigMap }}
{{- .Values.mailrise.existingConfigLocalConfigMap }}
{{- else }}
{{- printf "%s-config-local" (include "mailrise.fullname" .) }}
{{- end }}
{{- end }}


{{/*
ConfigMap name
*/}}
{{- define "mailrise.configMapName" -}}
{{- if .Values.mailrise.existingConfigMap }}
{{- .Values.mailrise.existingConfigMap }}
{{- else }}
{{- include "mailrise.fullname" . }}
{{- end }}
{{- end }}

{{/*
PVC name
*/}}
