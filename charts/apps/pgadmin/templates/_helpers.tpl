{{/* vim: set filetype=mustache: */}}

{{/*
Expand the name of the chart.
*/}}
{{- define "pgadmin.name" -}}
{{- include "common.names.name" . -}}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "pgadmin.fullname" -}}
{{- include "common.names.fullname" . -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "pgadmin.chart" -}}
{{- include "common.names.chart" . -}}
{{- end }}

{{/*
Common labels
*/}}
{{- define "pgadmin.labels" -}}
{{- $labels := include "common.labels.standard" (dict "customLabels" .Values.additionalLabels "context" $) -}}
{{- $labels -}}
{{- if not (contains "app.kubernetes.io/component" $labels) }}
app.kubernetes.io/component: database-admin
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "pgadmin.selectorLabels" -}}
{{- include "common.labels.matchLabels" . -}}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "pgadmin.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "pgadmin.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the namespace
*/}}
{{- define "pgadmin.namespace" -}}
{{- include "common.names.namespace" . -}}
{{- end }}

{{/*
Return the pgAdmin image
*/}}
{{- define "pgadmin.image" -}}
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
Return the secret name for pgAdmin credentials
*/}}
{{- define "pgadmin.secretName" -}}
{{- if .Values.pgadmin.existingSecret }}
{{- .Values.pgadmin.existingSecret }}
{{- else }}
{{- include "pgadmin.fullname" . }}
{{- end }}
{{- end }}

{{/*
Return the PVC name
*/}}
{{- define "pgadmin.pvcName" -}}
{{- if .Values.persistence.existingClaim }}
{{- .Values.persistence.existingClaim }}
{{- else }}
{{- include "pgadmin.fullname" . }}
{{- end }}
{{- end }}

{{/*
Return the ConfigMap name for server definitions
*/}}
{{- define "pgadmin.serverDefinitionsConfigMapName" -}}
{{- if .Values.pgadmin.existingServerDefinitionsConfigMap }}
{{- .Values.pgadmin.existingServerDefinitionsConfigMap }}
{{- else }}
{{- printf "%s-server-definitions" (include "pgadmin.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Validate required values
*/}}
{{- define "pgadmin.validateValues" -}}
{{- if and (not .Values.pgadmin.existingSecret) (not .Values.pgadmin.password) }}
{{- fail "Either pgadmin.password or pgadmin.existingSecret must be set" }}
{{- end }}
{{- end }}

{{/*
Return the SMTP secret name
*/}}
{{- define "pgadmin.smtpSecretName" -}}
{{- if .Values.pgadmin.smtp.existingSecret }}
{{- .Values.pgadmin.smtp.existingSecret }}
{{- else }}
{{- printf "%s-smtp" (include "pgadmin.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Return the pgpass secret name
*/}}
{{- define "pgadmin.pgpassSecretName" -}}
{{- if .Values.pgadmin.existingPgpassSecret }}
{{- .Values.pgadmin.existingPgpassSecret }}
{{- else }}
{{- printf "%s-pgpass" (include "pgadmin.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Return the config_local ConfigMap name
*/}}
{{- define "pgadmin.configLocalConfigMapName" -}}
{{- if .Values.pgadmin.existingConfigLocalConfigMap }}
{{- .Values.pgadmin.existingConfigLocalConfigMap }}
{{- else }}
{{- printf "%s-config-local" (include "pgadmin.fullname" .) }}
{{- end }}
{{- end }}
