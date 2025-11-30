{{/*
Expand the name of the chart.
*/}}
{{- define "pihole.name" -}}
{{- include "common.names.name" . -}}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "pihole.fullname" -}}
{{- include "common.names.fullname" . -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "pihole.chart" -}}
{{- include "common.names.chart" . -}}
{{- end }}

{{/*
Common labels
*/}}
{{- define "pihole.labels" -}}
{{- include "common.labels.standard" (dict "customLabels" .Values.additionalLabels "context" $) -}}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "pihole.selectorLabels" -}}
{{- include "common.labels.matchLabels" . -}}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "pihole.serviceAccountName" -}}
{{- if .Values.serviceAccount.enabled }}
{{- default (include "pihole.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the appropriate apiVersion for networking.
*/}}
{{- define "pihole.ingress.apiVersion" -}}
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
{{- define "pihole.namespace" -}}
{{- default .Release.Namespace .Values.namespaceOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return the name of the secret to use for sensitive data
*/}}
{{- define "pihole.secretName" -}}
{{- if .Values.secret.existingSecret }}
{{- .Values.secret.existingSecret }}
{{- else if .Values.externalSecrets.enabled }}
{{- .Values.externalSecrets.target.name | default (include "pihole.fullname" .) }}
{{- else if .Values.sealedSecrets.enabled }}
{{- include "pihole.fullname" . }}
{{- else if .Values.secret.enabled }}
{{- include "pihole.fullname" . }}
{{- else }}
{{- include "pihole.fullname" . }}
{{- end }}
{{- end }}

{{/*
Return whether a secret should be created or referenced
*/}}
{{- define "pihole.createSecret" -}}
{{- if or .Values.secret.enabled .Values.externalSecrets.enabled .Values.sealedSecrets.enabled }}
true
{{- else }}
false
{{- end }}
{{- end }}
