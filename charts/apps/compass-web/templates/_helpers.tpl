{{/* vim: set filetype=mustache: */}}

{{/*
Expand the name of the chart.
*/}}
{{- define "compass-web.name" -}}
{{- include "common.names.name" . -}}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "compass-web.fullname" -}}
{{- include "common.names.fullname" . -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "compass-web.chart" -}}
{{- include "common.names.chart" . -}}
{{- end }}

{{/*
Common labels
*/}}
{{- define "compass-web.labels" -}}
{{- $labels := include "common.labels.standard" (dict "customLabels" .Values.additionalLabels "context" $) -}}
{{- $labels -}}
{{- if not (contains "app.kubernetes.io/component" $labels) }}
app.kubernetes.io/component: database-admin
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "compass-web.selectorLabels" -}}
{{- include "common.labels.matchLabels" . -}}
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
{{- include "common.names.namespace" . -}}
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
