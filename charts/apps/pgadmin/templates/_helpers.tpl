{{/* vim: set filetype=mustache: */}}

{{/*
Expand the name of the chart.
*/}}
{{- define "pgadmin.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "pgadmin.fullname" -}}
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
{{- define "pgadmin.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "pgadmin.labels" -}}
helm.sh/chart: {{ include "pgadmin.chart" . }}
{{ include "pgadmin.selectorLabels" . }}
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
{{- define "pgadmin.selectorLabels" -}}
app.kubernetes.io/name: {{ include "pgadmin.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "pgadmin.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "pgadmin.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the namespace
*/}}
{{- define "pgadmin.namespace" -}}
{{- default .Release.Namespace .Values.namespaceOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Return the pgAdmin image
*/}}
{{- define "pgadmin.image" -}}
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
Return the secret name for pgAdmin credentials
*/}}
{{- define "pgadmin.secretName" -}}
{{- if .Values.pgadmin.existingSecret }}
{{- .Values.pgadmin.existingSecret }}
{{- else }}
{{- include "pgadmin.fullname" . }}
{{- end }}
{{- end }}

{{/*
Return the PVC name
*/}}
{{- define "pgadmin.pvcName" -}}
{{- if .Values.persistence.existingClaim }}
{{- .Values.persistence.existingClaim }}
{{- else }}
{{- include "pgadmin.fullname" . }}
{{- end }}
{{- end }}

{{/*
Return the ConfigMap name for server definitions
*/}}
{{- define "pgadmin.serverDefinitionsConfigMapName" -}}
{{- if .Values.pgadmin.existingServerDefinitionsConfigMap }}
{{- .Values.pgadmin.existingServerDefinitionsConfigMap }}
{{- else }}
{{- printf "%s-server-definitions" (include "pgadmin.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Validate required values
*/}}
{{- define "pgadmin.validateValues" -}}
{{- if and (not .Values.pgadmin.existingSecret) (not .Values.pgadmin.password) }}
{{- fail "Either pgadmin.password or pgadmin.existingSecret must be set" }}
{{- end }}
{{- end }}

{{/*
Return the SMTP secret name
*/}}
{{- define "pgadmin.smtpSecretName" -}}
{{- if .Values.pgadmin.smtp.existingSecret }}
{{- .Values.pgadmin.smtp.existingSecret }}
{{- else }}
{{- printf "%s-smtp" (include "pgadmin.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Return the pgpass secret name
*/}}
{{- define "pgadmin.pgpassSecretName" -}}
{{- if .Values.pgadmin.existingPgpassSecret }}
{{- .Values.pgadmin.existingPgpassSecret }}
{{- else }}
{{- printf "%s-pgpass" (include "pgadmin.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Return the config_local ConfigMap name
*/}}
{{- define "pgadmin.configLocalConfigMapName" -}}
{{- if .Values.pgadmin.existingConfigLocalConfigMap }}
{{- .Values.pgadmin.existingConfigLocalConfigMap }}
{{- else }}
{{- printf "%s-config-local" (include "pgadmin.fullname" .) }}
{{- end }}
{{- end }}
