{{/*
Expand the name of the chart.
*/}}
{{- define "home-assistant.name" -}}
{{- include "common.names.name" . -}}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "home-assistant.fullname" -}}
{{- include "common.names.fullname" . -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "home-assistant.chart" -}}
{{- include "common.names.chart" . -}}
{{- end }}

{{/*
Common labels
*/}}
{{- define "home-assistant.labels" -}}
{{- include "common.labels.standard" (dict "customLabels" .Values.additionalLabels "context" $) -}}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "home-assistant.selectorLabels" -}}
{{- include "common.labels.matchLabels" . -}}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "home-assistant.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "home-assistant.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the appropriate apiVersion for PodDisruptionBudget
*/}}
{{- define "home-assistant.pdb.apiVersion" -}}
{{- if .Capabilities.APIVersions.Has "policy/v1/PodDisruptionBudget" -}}
policy/v1
{{- else -}}
policy/v1beta1
{{- end -}}
{{- end -}}

{{/*
Get the namespace
*/}}
{{- define "home-assistant.namespace" -}}
{{- include "common.names.namespace" . -}}
{{- end }}

{{/*
Get the config PVC name
*/}}
{{- define "home-assistant.configPvcName" -}}
{{- if .Values.persistence.existingClaim }}
{{- .Values.persistence.existingClaim }}
{{- else }}
{{- include "home-assistant.fullname" . }}-config
{{- end }}
{{- end }}

{{/*
Get the media PVC name
*/}}
{{- define "home-assistant.mediaPvcName" -}}
{{- if .Values.persistence.media.existingClaim }}
{{- .Values.persistence.media.existingClaim }}
{{- else }}
{{- include "home-assistant.fullname" . }}-media
{{- end }}
{{- end }}

{{/*
Get the backup PVC name
*/}}
{{- define "home-assistant.backupPvcName" -}}
{{- if .Values.persistence.backup.existingClaim }}
{{- .Values.persistence.backup.existingClaim }}
{{- else }}
{{- include "home-assistant.fullname" . }}-backup
{{- end }}
{{- end }}

{{/*
Get database URL for Home Assistant
*/}}
{{- define "home-assistant.databaseUrl" -}}
{{- if eq .Values.database.type "postgresql" -}}
{{- $host := .Values.database.postgresql.host -}}
{{- $port := .Values.database.postgresql.port -}}
{{- $db := .Values.database.postgresql.database -}}
{{- $user := .Values.database.postgresql.username -}}
{{- printf "postgresql://%s:$(DB_PASSWORD)@%s:%d/%s" $user $host (int $port) $db -}}
{{- end -}}
{{- end -}}

{{/*
Get the image tag
*/}}
{{- define "home-assistant.imageTag" -}}
{{- .Values.image.tag | default .Chart.AppVersion -}}
{{- end -}}

{{/*
Return the proper image name
*/}}
{{- define "home-assistant.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global "chart" .Chart) -}}
{{- end -}}

{{/*
Validate controller type and settings
*/}}
{{- define "home-assistant.validateController" -}}
{{- $validControllers := list "StatefulSet" "Deployment" -}}
{{- if not (has .Values.controller.type $validControllers) -}}
{{- fail (printf "Invalid controller.type '%s'. Must be 'StatefulSet' or 'Deployment'" .Values.controller.type) -}}
{{- end -}}
{{- if and (eq .Values.controller.type "StatefulSet") .Values.persistence.existingClaim -}}
{{- fail "Cannot use persistence.existingClaim with StatefulSet. Use persistence.existingVolume instead." -}}
{{- end -}}
{{- if and (eq .Values.controller.type "Deployment") .Values.persistence.existingVolume -}}
{{- fail "Cannot use persistence.existingVolume with Deployment. Use persistence.existingClaim instead." -}}
{{- end -}}
{{- end -}}

{{/*
Return the appropriate controller annotations
*/}}
{{- define "home-assistant.controllerAnnotations" -}}
{{- if eq .Values.controller.type "StatefulSet" -}}
{{- toYaml .Values.controller.statefulSetAnnotations -}}
{{- else if eq .Values.controller.type "Deployment" -}}
{{- toYaml .Values.controller.deploymentAnnotations -}}
{{- end -}}
{{- end -}}
