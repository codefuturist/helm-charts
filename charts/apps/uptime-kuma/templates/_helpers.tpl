{{/* vim: set filetype=mustache: */}}

{{/*
Expand the name of the chart.
*/}}
{{- define "uptime-kuma.name" -}}
{{- include "common.names.name" . -}}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "uptime-kuma.fullname" -}}
{{- include "common.names.fullname" . -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "uptime-kuma.chart" -}}
{{- include "common.names.chart" . -}}
{{- end }}

{{/*
Common labels
*/}}
{{- define "uptime-kuma.labels" -}}
{{- $labels := include "common.labels.standard" (dict "customLabels" .Values.additionalLabels "context" $) -}}
{{- $labels -}}
{{- if not (contains "app.kubernetes.io/component" $labels) }}
app.kubernetes.io/component: monitoring
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "uptime-kuma.selectorLabels" -}}
{{- include "common.labels.matchLabels" . -}}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "uptime-kuma.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "uptime-kuma.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the namespace
*/}}
{{- define "uptime-kuma.namespace" -}}
{{- include "common.names.namespace" . -}}
{{- end }}

{{/*
Return the Uptime Kuma image
*/}}
{{- define "uptime-kuma.image" -}}
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
Return the PVC name
*/}}
{{- define "uptime-kuma.pvcName" -}}
{{- if .Values.persistence.existingClaim }}
{{- .Values.persistence.existingClaim }}
{{- else }}
{{- include "uptime-kuma.fullname" . }}
{{- end }}
{{- end }}
