{{/*
Expand the name of the chart.
*/}}
{{- define "redisinsight.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "redisinsight.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "redisinsight.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "redisinsight.labels" -}}
helm.sh/chart: {{ include "redisinsight.chart" . }}
{{ include "redisinsight.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- with .Values.additionalLabels }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "redisinsight.selectorLabels" -}}
app.kubernetes.io/name: {{ include "redisinsight.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
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
{{- default .Release.Namespace .Values.namespaceOverride | trunc 63 | trimSuffix "-" }}
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
