{{/*
Expand the name of the chart.
*/}}
{{- define "protonpass-eso-provider.name" -}}
{{- include "common.names.name" . -}}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "protonpass-eso-provider.fullname" -}}
{{- include "common.names.fullname" . -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "protonpass-eso-provider.chart" -}}
{{- include "common.names.chart" . -}}
{{- end }}

{{/*
Common labels
*/}}
{{- define "protonpass-eso-provider.labels" -}}
{{- include "common.labels.standard" (dict "customLabels" .Values.additionalLabels "context" $) -}}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "protonpass-eso-provider.selectorLabels" -}}
{{- include "common.labels.matchLabels" . -}}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "protonpass-eso-provider.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "protonpass-eso-provider.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Get the credentials secret name
*/}}
{{- define "protonpass-eso-provider.credentialsSecretName" -}}
{{- if .Values.protonpass.auth.existingSecret.name }}
{{- .Values.protonpass.auth.existingSecret.name }}
{{- else }}
{{- include "protonpass-eso-provider.fullname" . }}-credentials
{{- end }}
{{- end }}

{{/*
Get the API token secret name
*/}}
{{- define "protonpass-eso-provider.apiTokenSecretName" -}}
{{- if .Values.api.existingSecret.name }}
{{- .Values.api.existingSecret.name }}
{{- else }}
{{- include "protonpass-eso-provider.fullname" . }}-api-token
{{- end }}
{{- end }}

{{/*
Image name
*/}}
{{- define "protonpass-eso-provider.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global "chart" .Chart) -}}
{{- end }}
