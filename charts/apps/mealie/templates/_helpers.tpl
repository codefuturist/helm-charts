{{/*
Expand the name of the chart.
*/}}
{{- define "mealie.name" -}}
{{- include "common.names.name" . -}}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "mealie.fullname" -}}
{{- include "common.names.fullname" . -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "mealie.chart" -}}
{{- include "common.names.chart" . -}}
{{- end }}

{{/*
Common labels
*/}}
{{- define "mealie.labels" -}}
{{- include "common.labels.standard" (dict "customLabels" .Values.additionalLabels "context" $) -}}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "mealie.selectorLabels" -}}
{{- include "common.labels.matchLabels" . -}}
{{- end }}

{{/*
Selector labels for Mealie component
*/}}
{{- define "mealie.mealie.selectorLabels" -}}
{{ include "mealie.selectorLabels" . }}
app.kubernetes.io/component: mealie
{{- end }}

{{/*
Selector labels for PostgreSQL component
*/}}
{{- define "mealie.postgres.selectorLabels" -}}
{{ include "mealie.selectorLabels" . }}
app.kubernetes.io/component: postgres
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "mealie.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "mealie.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the appropriate apiVersion for networking.
*/}}
{{- define "mealie.ingress.apiVersion" -}}
{{- if semverCompare ">=1.19-0" .Capabilities.KubeVersion.GitVersion -}}
networking.k8s.io/v1
{{- else if semverCompare ">=1.14-0" .Capabilities.KubeVersion.GitVersion -}}
networking.k8s.io/v1beta1
{{- else -}}
extensions/v1beta1
{{- end }}
{{- end }}

{{/*
Return namespace
*/}}
{{- define "mealie.namespace" -}}
{{- include "common.names.namespace" . -}}
{{- end -}}
