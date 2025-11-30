{{/*
Expand the name of the chart.
*/}}
{{- define "bitwarden-eso-provider.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "bitwarden-eso-provider.fullname" -}}
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
{{- define "bitwarden-eso-provider.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "bitwarden-eso-provider.labels" -}}
helm.sh/chart: {{ include "bitwarden-eso-provider.chart" . }}
{{ include "bitwarden-eso-provider.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "bitwarden-eso-provider.selectorLabels" -}}
app.kubernetes.io/name: {{ include "bitwarden-eso-provider.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "bitwarden-eso-provider.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "bitwarden-eso-provider.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Get the credentials secret name
*/}}
{{- define "bitwarden-eso-provider.credentialsSecretName" -}}
{{- if .Values.bitwarden.auth.existingSecret.name }}
{{- .Values.bitwarden.auth.existingSecret.name }}
{{- else }}
{{- include "bitwarden-eso-provider.fullname" . }}-credentials
{{- end }}
{{- end }}

{{/*
Get the API token secret name
*/}}
{{- define "bitwarden-eso-provider.apiTokenSecretName" -}}
{{- if .Values.api.existingSecret.name }}
{{- .Values.api.existingSecret.name }}
{{- else }}
{{- include "bitwarden-eso-provider.fullname" . }}-api-token
{{- end }}
{{- end }}

{{/*
Image name
*/}}
{{- define "bitwarden-eso-provider.image" -}}
{{- $tag := .Values.image.tag | default .Chart.AppVersion }}
{{- printf "%s:%s" .Values.image.repository $tag }}
{{- end }}
