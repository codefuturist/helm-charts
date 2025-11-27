{{/* vim: set filetype=mustache: */}}

{{/*
Expand the name of the chart.
*/}}
{{- define "metube.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "metube.fullname" -}}
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
{{- define "metube.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "metube.labels" -}}
helm.sh/chart: {{ include "metube.chart" . }}
{{ include "metube.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/component: video-downloader
{{- with .Values.additionalLabels }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "metube.selectorLabels" -}}
app.kubernetes.io/name: {{ include "metube.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "metube.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "metube.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the namespace
*/}}
{{- define "metube.namespace" -}}
{{- default .Release.Namespace .Values.namespaceOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Return the MeTube image
*/}}
{{- define "metube.image" -}}
{{- $registry := .Values.image.repository -}}
{{- $tag := default .Chart.AppVersion .Values.image.tag | toString -}}
{{- $digest := .Values.image.digest | toString -}}
{{- if $digest }}
{{- printf "%s@%s" $registry $digest -}}
{{- else }}
{{- printf "%s:%s" $registry $tag -}}
{{- end }}
{{- end }}

{{/*
Return the PVC name
*/}}
{{- define "metube.pvcName" -}}
{{- if .Values.persistence.existingClaim }}
{{- .Values.persistence.existingClaim }}
{{- else }}
{{- include "metube.fullname" . }}
{{- end }}
{{- end }}

{{/*
Return the ConfigMap name for MeTube configuration
*/}}
{{- define "metube.configMapName" -}}
{{- printf "%s-config" (include "metube.fullname" .) }}
{{- end }}

{{/*
Return the secret name for cookies
*/}}
{{- define "metube.cookiesSecretName" -}}
{{- if .Values.metube.cookies.existingSecret }}
{{- .Values.metube.cookies.existingSecret }}
{{- else }}
{{- printf "%s-cookies" (include "metube.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Return the TLS secret name
*/}}
{{- define "metube.tlsSecretName" -}}
{{- if .Values.metube.existingTlsSecret }}
{{- .Values.metube.existingTlsSecret }}
{{- else }}
{{- printf "%s-tls" (include "metube.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Return the yt-dlp options ConfigMap name
*/}}
{{- define "metube.ytdlOptionsConfigMapName" -}}
{{- if .Values.metube.existingYtdlOptionsConfigMap }}
{{- .Values.metube.existingYtdlOptionsConfigMap }}
{{- else }}
{{- printf "%s-ytdl-options" (include "metube.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Return the robots.txt ConfigMap name
*/}}
{{- define "metube.robotsTxtConfigMapName" -}}
{{- if .Values.metube.existingRobotsTxtConfigMap }}
{{- .Values.metube.existingRobotsTxtConfigMap }}
{{- else }}
{{- printf "%s-robots-txt" (include "metube.fullname" .) }}
{{- end }}
{{- end }}
