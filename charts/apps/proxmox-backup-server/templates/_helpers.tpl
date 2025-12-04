{{/* vim: set filetype=mustache: */}}

{{/*
Expand the name of the chart.
*/}}
{{- define "pbs.name" -}}
{{- include "common.names.name" . -}}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "pbs.fullname" -}}
{{- include "common.names.fullname" . -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "pbs.chart" -}}
{{- include "common.names.chart" . -}}
{{- end }}

{{/*
Common labels
*/}}
{{- define "pbs.labels" -}}
{{- include "common.labels.standard" (dict "customLabels" .Values.additionalLabels "context" $) -}}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "pbs.selectorLabels" -}}
{{- include "common.labels.matchLabels" . -}}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "pbs.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "pbs.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the namespace
*/}}
{{- define "pbs.namespace" -}}
{{- include "common.names.namespace" . -}}
{{- end }}

{{/*
Return the PBS image
*/}}
{{- define "pbs.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global "chart" .Chart) -}}
{{- end }}

{{/*
Return the secret name for PBS credentials
*/}}
{{- define "pbs.secretName" -}}
{{- if .Values.pbs.existingSecret }}
{{- .Values.pbs.existingSecret }}
{{- else }}
{{- include "pbs.fullname" . }}
{{- end }}
{{- end }}

{{/*
Return the PVC name for etc
*/}}
{{- define "pbs.pvcEtcName" -}}
{{- if .Values.persistence.etc.existingClaim }}
{{- .Values.persistence.etc.existingClaim }}
{{- else }}
{{- printf "%s-etc" (include "pbs.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Return the PVC name for logs
*/}}
{{- define "pbs.pvcLogsName" -}}
{{- if .Values.persistence.logs.existingClaim }}
{{- .Values.persistence.logs.existingClaim }}
{{- else }}
{{- printf "%s-logs" (include "pbs.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Return the PVC name for lib
*/}}
{{- define "pbs.pvcLibName" -}}
{{- if .Values.persistence.lib.existingClaim }}
{{- .Values.persistence.lib.existingClaim }}
{{- else }}
{{- printf "%s-lib" (include "pbs.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Validate required values
*/}}
{{- define "pbs.validateValues" -}}
{{- if and (not .Values.pbs.existingSecret) (not .Values.pbs.password) }}
{{- fail "Either pbs.password or pbs.existingSecret must be set" }}
{{- end }}
{{- end }}
