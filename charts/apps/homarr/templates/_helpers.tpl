{{/* vim: set filetype=mustache: */}}

{{/*
Define the name of the chart/application.
*/}}
{{- define "homarr.name" -}}
{{- include "common.names.name" . -}}
{{- end -}}

{{/*
Define the fullname of the chart/application.
*/}}
{{- define "homarr.fullname" -}}
{{- include "common.names.fullname" . -}}
{{- end -}}

{{/*
Define the version label.
*/}}
{{- define "homarr.version" -}}
  {{- $version := default "" .Values.deployment.image.tag -}}
  {{- regexReplaceAll "[^a-zA-Z0-9_\\.\\-]" $version "-" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Renders a value that contains template.
Usage:
{{ include "homarr.tplvalues.render" ( dict "value" .Values.path.to.the.Value "context" $) }}
*/}}
{{- define "homarr.tplvalues.render" -}}
{{- include "common.tplvalues.render" . -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "homarr.chart" -}}
{{- include "common.names.chart" . -}}
{{- end }}

{{/*
Additional common labels
*/}}
{{- define "homarr.additionalLabels" -}}
{{- if .Values.additionalLabels }}
{{ include "homarr.tplvalues.render" ( dict "value" .Values.additionalLabels "context" $ ) }}
{{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "homarr.labels" -}}
app.kubernetes.io/name: {{ include "homarr.name" . }}
helm.sh/chart: {{ include "homarr.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- with include "homarr.version" . }}
app.kubernetes.io/version: {{ quote . }}
{{- end }}
{{- if .Values.componentOverride }}
app.kubernetes.io/component: {{ .Values.componentOverride }}
{{- end }}
{{- if .Values.partOfOverride }}
app.kubernetes.io/part-of: {{ .Values.partOfOverride }}
{{- else }}
app.kubernetes.io/part-of: {{ include "homarr.name" . }}
{{- end }}
{{- include "homarr.additionalLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "homarr.selectorLabels" -}}
app.kubernetes.io/name: {{ include "homarr.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Allow the release namespace to be overridden
*/}}
{{- define "homarr.namespace" -}}
{{- include "common.names.namespace" . -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "homarr.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "homarr.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
