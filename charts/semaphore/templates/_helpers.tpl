{{/* vim: set filetype=mustache: */}}

{{/*
Expand the name of the chart.
*/}}
{{- define "semaphore.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "semaphore.fullname" -}}
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
{{- define "semaphore.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "semaphore.labels" -}}
helm.sh/chart: {{ include "semaphore.chart" . }}
{{ include "semaphore.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/component: automation
{{- with .Values.additionalLabels }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "semaphore.selectorLabels" -}}
app.kubernetes.io/name: {{ include "semaphore.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "semaphore.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "semaphore.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the namespace
*/}}
{{- define "semaphore.namespace" -}}
{{- default .Release.Namespace .Values.namespaceOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Return the Semaphore image
*/}}
{{- define "semaphore.image" -}}
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
Return the PVC name for data volume
*/}}
{{- define "semaphore.dataPvcName" -}}
{{- if .Values.persistence.data.existingClaim }}
{{- .Values.persistence.data.existingClaim }}
{{- else }}
{{- printf "%s-data" (include "semaphore.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Return the PVC name for config volume
*/}}
{{- define "semaphore.configPvcName" -}}
{{- if .Values.persistence.config.existingClaim }}
{{- .Values.persistence.config.existingClaim }}
{{- else }}
{{- printf "%s-config" (include "semaphore.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Return the PVC name for tmp volume
*/}}
{{- define "semaphore.tmpPvcName" -}}
{{- if .Values.persistence.tmp.existingClaim }}
{{- .Values.persistence.tmp.existingClaim }}
{{- else }}
{{- printf "%s-tmp" (include "semaphore.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Return the secret name
*/}}
{{- define "semaphore.secretName" -}}
{{- if .Values.semaphore.existingSecret }}
{{- .Values.semaphore.existingSecret }}
{{- else }}
{{- include "semaphore.fullname" . }}
{{- end }}
{{- end }}

{{/*
Return the database connection string
*/}}
{{- define "semaphore.databaseConfig" -}}
{{- if eq .Values.semaphore.database.dialect "sqlite" }}
{{- printf "bolt:///var/lib/semaphore/database.boltdb" }}
{{- else if eq .Values.semaphore.database.dialect "postgres" }}
{{- printf "postgres://%s:%s@%s:%s/%s?sslmode=%s" .Values.semaphore.database.user "" .Values.semaphore.database.host (.Values.semaphore.database.port | default "5432") .Values.semaphore.database.name (.Values.semaphore.database.sslMode | default "prefer") }}
{{- else if eq .Values.semaphore.database.dialect "mysql" }}
{{- printf "%s:%s@tcp(%s:%s)/%s" .Values.semaphore.database.user "" .Values.semaphore.database.host (.Values.semaphore.database.port | default "3306") .Values.semaphore.database.name }}
{{- end }}
{{- end }}

{{/*
Runner service account name
*/}}
{{- define "semaphore.runner.serviceAccountName" -}}
{{- if .Values.runnerDeployment.serviceAccount.create }}
{{- default (printf "%s-runner" (include "semaphore.fullname" .)) .Values.runnerDeployment.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.runnerDeployment.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Runner secret name
*/}}
{{- define "semaphore.runner.secretName" -}}
{{- if .Values.runnerDeployment.server.existingSecret }}
{{- .Values.runnerDeployment.server.existingSecret }}
{{- else }}
{{- printf "%s-runner" (include "semaphore.fullname" .) }}
{{- end }}
{{- end }}
