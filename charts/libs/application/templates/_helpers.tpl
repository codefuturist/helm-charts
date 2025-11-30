{{/*
Application library helpers built on top of Bitnami common
*/}}

{{/*
Return a standard name using common.names.fullname
*/}}
{{- define "application.fullname" -}}
{{- include "common.names.fullname" . -}}
{{- end -}}

{{/*
Return the namespace, allowing override via Values.namespaceOverride
*/}}
{{- define "application.namespace" -}}
{{- include "common.names.namespace" . -}}
{{- end -}}

{{/*
Standard labels: Bitnami common labels plus optional commonLabels from the chart.
*/}}
{{- define "application.labels" -}}
{{- include "common.labels.standard" (dict "customLabels" .Values.commonLabels "context" $) -}}
{{- end -}}

{{/*
Render values that themselves contain templates, using common.tplvalues.render
*/}}
{{- define "application.tplvalues.render" -}}
{{- include "common.tplvalues.render" . -}}
{{- end -}}
