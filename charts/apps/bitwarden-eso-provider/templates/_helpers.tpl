{{/*
Expand the name of the chart.
*/}}
{{- define "bitwarden-eso-provider.name" -}}
{{- include "common.names.name" . -}}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "bitwarden-eso-provider.fullname" -}}
{{- include "common.names.fullname" . -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "bitwarden-eso-provider.chart" -}}
{{- include "common.names.chart" . -}}
{{- end }}

{{/*
Common labels
*/}}
{{- define "bitwarden-eso-provider.labels" -}}
{{- include "common.labels.standard" (dict "customLabels" .Values.additionalLabels "context" $) -}}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "bitwarden-eso-provider.selectorLabels" -}}
{{- include "common.labels.matchLabels" . -}}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "bitwarden-eso-provider.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "bitwarden-eso-provider.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Get the credentials secret name
*/}}
{{- define "bitwarden-eso-provider.credentialsSecretName" -}}
{{- if .Values.bitwarden.auth.existingSecret.name }}
{{- .Values.bitwarden.auth.existingSecret.name }}
{{- else }}
{{- include "bitwarden-eso-provider.fullname" . }}-credentials
{{- end }}
{{- end }}

{{/*
Get the API token secret name
*/}}
{{- define "bitwarden-eso-provider.apiTokenSecretName" -}}
{{- if .Values.api.existingSecret.name }}
{{- .Values.api.existingSecret.name }}
{{- else }}
{{- include "bitwarden-eso-provider.fullname" . }}-api-token
{{- end }}
{{- end }}

{{/*
Image name
*/}}
{{- define "bitwarden-eso-provider.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global "chart" .Chart) -}}
{{- end }}
