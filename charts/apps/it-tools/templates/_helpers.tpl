{{/* vim: set filetype=mustache: */}}

{{/*
Expand the name of the chart.
*/}}
{{- define "app.name" -}}
{{- include "common.names.name" . -}}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "app.fullname" -}}
{{- include "common.names.fullname" . -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "app.chart" -}}
{{- include "common.names.chart" . -}}
{{- end }}

{{/*
Common labels
*/}}
{{- define "app.labels" -}}
{{- $labels := include "common.labels.standard" (dict "customLabels" .Values.additionalLabels "context" $) -}}
{{- $labels -}}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "app.selectorLabels" -}}
{{- include "common.labels.matchLabels" . -}}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "app.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "app.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the namespace
*/}}
{{- define "app.namespace" -}}
{{- include "common.names.namespace" . -}}
{{- end }}

{{/*
Return the application image
*/}}
{{- define "app.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global "chart" .Chart) -}}
{{- end }}

{{/*
Return the secret name for application credentials
*/}}
{{- define "app.secretName" -}}
{{- if .Values.app.existingSecret }}
{{- .Values.app.existingSecret }}
{{- else }}
{{- include "app.fullname" . }}
{{- end }}
{{- end }}

{{/*
Return the PVC name
*/}}
{{- define "app.pvcName" -}}
{{- if .Values.persistence.existingClaim }}
{{- .Values.persistence.existingClaim }}
{{- else }}
{{- include "app.fullname" . }}
{{- end }}
{{- end }}

{{/*
Return the ConfigMap name
*/}}
{{- define "app.configMapName" -}}
{{- printf "%s-config" (include "app.fullname" .) }}
{{- end }}

{{/*
Validate required values
Add your validation logic here
*/}}
{{- define "app.validateValues" -}}
{{/* Example validation:
{{- if and (not .Values.app.existingSecret) (not .Values.app.password) }}
{{- fail "Either app.password or app.existingSecret must be set" }}
{{- end }}
*/}}
{{- end }}

{{/*
Return container port
*/}}
{{- define "app.containerPort" -}}
{{- .Values.service.targetPort | default 8080 }}
{{- end }}

