{{/*
Expand the name of the chart.
*/}}
{{- define "pihole.name" -}}
{{- default .Chart.Name .Values.applicationName | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "pihole.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.applicationName }}
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
{{- define "pihole.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "pihole.labels" -}}
helm.sh/chart: {{ include "pihole.chart" . }}
{{ include "pihole.selectorLabels" . }}
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
{{- define "pihole.selectorLabels" -}}
app.kubernetes.io/name: {{ include "pihole.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
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
