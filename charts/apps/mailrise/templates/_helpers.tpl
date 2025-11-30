{{/* vim: set filetype=mustache: */}}

{{/*
Expand the name of the chart.
*/}}
{{- define "mailrise.name" -}}
{{- include "common.names.name" . -}}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "mailrise.fullname" -}}
{{- include "common.names.fullname" . -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "mailrise.chart" -}}
{{- include "common.names.chart" . -}}
{{- end }}

{{/*
Common labels
*/}}
{{- define "mailrise.labels" -}}
{{- $labels := include "common.labels.standard" (dict "customLabels" .Values.additionalLabels "context" $) -}}
{{- $labels -}}
{{- if not (contains "app.kubernetes.io/component" $labels) }}
app.kubernetes.io/component: database-admin
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "mailrise.selectorLabels" -}}
{{- include "common.labels.matchLabels" . -}}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "mailrise.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "mailrise.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the namespace
*/}}
{{- define "mailrise.namespace" -}}
{{- include "common.names.namespace" . -}}
{{- end }}

{{/*
Return the Mailrise image
*/}}
{{- define "mailrise.image" -}}
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
Return the secret name for Mailrise credentials
*/}}
{{- define "mailrise.secretName" -}}
{{- if .Values.mailrise.existingSecret }}
{{- .Values.mailrise.existingSecret }}
{{- else }}
{{- include "mailrise.fullname" . }}
{{- end }}
{{- end }}

{{/*
Return the PVC name
*/}}
{{- define "mailrise.pvcName" -}}
{{- if .Values.persistence.existingClaim }}
{{- .Values.persistence.existingClaim }}
{{- else }}
{{- include "mailrise.fullname" . }}
{{- end }}
{{- end }}

{{/*
Return the ConfigMap name for server definitions
*/}}
{{- define "mailrise.serverDefinitionsConfigMapName" -}}
{{- if .Values.mailrise.existingServerDefinitionsConfigMap }}
{{- .Values.mailrise.existingServerDefinitionsConfigMap }}
{{- else }}
{{- printf "%s-server-definitions" (include "mailrise.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Validate required values
*/}}
{{- define "mailrise.validateValues" -}}
{{- if and (not .Values.mailrise.existingSecret) (not .Values.mailrise.password) }}
{{- fail "Either mailrise.password or mailrise.existingSecret must be set" }}
{{- end }}
{{- end }}

{{/*
Return the SMTP secret name
*/}}
{{- define "mailrise.smtpSecretName" -}}
{{- if .Values.mailrise.smtp.existingSecret }}
{{- .Values.mailrise.smtp.existingSecret }}
{{- else }}
{{- printf "%s-smtp" (include "mailrise.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Return the pgpass secret name
*/}}
{{- define "mailrise.pgpassSecretName" -}}
{{- if .Values.mailrise.existingPgpassSecret }}
{{- .Values.mailrise.existingPgpassSecret }}
{{- else }}
{{- printf "%s-pgpass" (include "mailrise.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Return the config_local ConfigMap name
*/}}
{{- define "mailrise.configLocalConfigMapName" -}}
{{- if .Values.mailrise.existingConfigLocalConfigMap }}
{{- .Values.mailrise.existingConfigLocalConfigMap }}
{{- else }}
{{- printf "%s-config-local" (include "mailrise.fullname" .) }}
{{- end }}
{{- end }}


{{/*
ConfigMap name
*/}}
{{- define "mailrise.configMapName" -}}
{{- if .Values.mailrise.existingConfigMap }}
{{- .Values.mailrise.existingConfigMap }}
{{- else }}
{{- include "mailrise.fullname" . }}
{{- end }}
{{- end }}

{{/*
PVC name
*/}}
