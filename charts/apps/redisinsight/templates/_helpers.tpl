{{/*
Expand the name of the chart.
*/}}
{{- define "redisinsight.name" -}}
{{- include "common.names.name" . -}}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "redisinsight.fullname" -}}
{{- include "common.names.fullname" . -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "redisinsight.chart" -}}
{{- include "common.names.chart" . -}}
{{- end }}

{{/*
Common labels
*/}}
{{- define "redisinsight.labels" -}}
{{- include "common.labels.standard" (dict "customLabels" .Values.additionalLabels "context" $) -}}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "redisinsight.selectorLabels" -}}
{{- include "common.labels.matchLabels" . -}}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "redisinsight.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "redisinsight.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the proper namespace
*/}}
{{- define "redisinsight.namespace" -}}
{{- include "common.names.namespace" . -}}
{{- end }}

{{/*
Return the proper image name
*/}}
{{- define "redisinsight.image" -}}
{{- if .Values.image.digest }}
{{- printf "%s@%s" .Values.image.repository .Values.image.digest }}
{{- else }}
{{- $tag := .Values.image.tag | default .Chart.AppVersion }}
{{- printf "%s:%s" .Values.image.repository $tag }}
{{- end }}
{{- end }}

{{/*
Return the proper PVC name
*/}}
{{- define "redisinsight.pvcName" -}}
{{- if .Values.persistence.existingClaim }}
{{- .Values.persistence.existingClaim }}
{{- else }}
{{- include "redisinsight.fullname" . }}
{{- end }}
{{- end }}

{{/*
Validate required values
*/}}
{{- define "redisinsight.validateValues" -}}
{{- /* Redis Insight has no required values - it can run standalone */ -}}
{{- end }}

{{/*
Return the encryption key secret name
*/}}
{{- define "redisinsight.encryptionKeySecretName" -}}
{{- if .Values.redisInsight.existingEncryptionKeySecret }}
{{- .Values.redisInsight.existingEncryptionKeySecret }}
{{- else }}
{{- printf "%s-encryption" (include "redisinsight.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Return the TLS secret name
*/}}
{{- define "redisinsight.tlsSecretName" -}}
{{- if .Values.redisInsight.tls.existingSecret }}
{{- .Values.redisInsight.tls.existingSecret }}
{{- else }}
{{- printf "%s-tls" (include "redisinsight.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Return the connection passwords secret name
*/}}
{{- define "redisinsight.connectionPasswordsSecretName" -}}
{{- if .Values.redisInsight.existingConnectionPasswordsSecret }}
{{- .Values.redisInsight.existingConnectionPasswordsSecret }}
{{- else }}
{{- printf "%s-connections" (include "redisinsight.fullname" .) }}
{{- end }}
{{- end }}
