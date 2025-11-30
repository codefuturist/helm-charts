{{/*
Copyright codefuturist
SPDX-License-Identifier: MIT
*/}}

{{/* vim: set filetype=mustache: */}}

{{/*
Return the proper netboot.xyz image name
*/}}
{{- define "netbootxyz.image" -}}
{{- $imageRoot := .Values.image -}}
{{- $tag := .Values.image.tag | default .Chart.AppVersion -}}
{{- $imageRoot = merge (dict "tag" $tag) $imageRoot -}}
{{- include "common.images.image" (dict "imageRoot" $imageRoot "global" .Values.global) -}}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "netbootxyz.imagePullSecrets" -}}
{{- include "common.images.renderPullSecrets" (dict "images" (list .Values.image) "context" $) -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "netbootxyz.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "common.names.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Return the config PVC name
*/}}
{{- define "netbootxyz.configPvcName" -}}
{{- if .Values.persistence.config.existingClaim -}}
    {{- printf "%s" .Values.persistence.config.existingClaim -}}
{{- else -}}
    {{- printf "%s-config" (include "common.names.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Return the assets PVC name
*/}}
{{- define "netbootxyz.assetsPvcName" -}}
{{- if .Values.persistence.assets.existingClaim -}}
    {{- printf "%s" .Values.persistence.assets.existingClaim -}}
{{- else -}}
    {{- printf "%s-assets" (include "common.names.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Return the TFTP service name
*/}}
{{- define "netbootxyz.tftpServiceName" -}}
{{- printf "%s-tftp" (include "common.names.fullname" .) -}}
{{- end -}}

{{/*
Compile all warnings into a single message
*/}}
{{- define "netbootxyz.validateValues" -}}
{{- $messages := list -}}
{{- $messages := append $messages (include "netbootxyz.validateValues.replicaCount" .) -}}
{{- $messages := without $messages "" -}}
{{- $message := join "\n" $messages -}}
{{- if $message -}}
{{-   printf "\nVALUES VALIDATION:\n%s" $message | fail -}}
{{- end -}}
{{- end -}}

{{/*
Validate values - replicaCount must be 1 for TFTP
*/}}
{{- define "netbootxyz.validateValues.replicaCount" -}}
{{- if and .Values.tftp.service.enabled (gt (int .Values.replicaCount) 1) -}}
netbootxyz: replicaCount
    TFTP service requires replicaCount to be 1 to avoid conflicts.
    Please set replicaCount: 1 or disable TFTP service.
{{- end -}}
{{- end -}}
