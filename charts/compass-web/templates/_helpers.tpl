{{/* vim: set filetype=mustache: */}}

{{/*
Expand the name of the chart.
*/}}
{{- define "compass-web.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "compass-web.fullname" -}}
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
{{- define "compass-web.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "compass-web.labels" -}}
helm.sh/chart: {{ include "compass-web.chart" . }}
{{ include "compass-web.selectorLabels" . }}
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
{{- define "compass-web.selectorLabels" -}}
app.kubernetes.io/name: {{ include "compass-web.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "compass-web.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "compass-web.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the namespace
*/}}
{{- define "compass-web.namespace" -}}
{{- default .Release.Namespace .Values.namespaceOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Return the Compass Web image
*/}}
{{- define "compass-web.image" -}}
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
Return the secret name for Compass Web credentials
*/}}
{{- define "compass-web.secretName" -}}
{{- if .Values.compassWeb.existingSecret }}
{{- .Values.compassWeb.existingSecret }}
{{- else }}
{{- include "compass-web.fullname" . }}
{{- end }}
{{- end }}

{{/*
Return the PVC name
*/}}
{{- define "compass-web.pvcName" -}}
{{- if .Values.persistence.existingClaim }}
{{- .Values.persistence.existingClaim }}
{{- else }}
{{- include "compass-web.fullname" . }}
{{- end }}
{{- end }}

{{/*
Validate required values
*/}}
{{- define "compass-web.validateValues" -}}
{{- if and (not .Values.compassWeb.existingSecret) (not .Values.compassWeb.mongoUri) }}
{{- fail "Either compassWeb.mongoUri or compassWeb.existingSecret must be set" }}
{{- end }}
{{- end }}

{{/*
Return the basic auth secret name
*/}}
{{- define "compass-web.basicAuthSecretName" -}}
{{- if .Values.compassWeb.basicAuth.existingSecret }}
{{- .Values.compassWeb.basicAuth.existingSecret }}
{{- else }}
{{- printf "%s-basic-auth" (include "compass-web.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Return the GenAI secret name
*/}}
{{- define "compass-web.genAISecretName" -}}
{{- if .Values.compassWeb.genAI.existingSecret }}
{{- .Values.compassWeb.genAI.existingSecret }}
{{- else }}
{{- printf "%s-genai" (include "compass-web.fullname" .) }}
{{- end }}
{{- end }}
