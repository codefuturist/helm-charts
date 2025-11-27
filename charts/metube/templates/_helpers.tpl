{{/* vim: set filetype=mustache: */}}

{{/*
Return the proper MeTube image name
*/}}
{{- define "metube.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) -}}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "metube.imagePullSecrets" -}}
{{- include "common.images.renderPullSecrets" (dict "images" (list .Values.image) "context" $) -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "metube.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "common.names.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Compile all warnings into a single message.
*/}}
{{- define "metube.validateValues" -}}
{{- $messages := list -}}
{{- $messages := append $messages (include "metube.validateValues.persistence" .) -}}
{{- $messages := without $messages "" -}}
{{- $message := join "\n" $messages -}}
{{- if $message -}}
{{-   printf "\nVALUES VALIDATION:\n%s" $message -}}
{{- end -}}
{{- end -}}

{{/*
Validate values of MeTube - Persistence
*/}}
{{- define "metube.validateValues.persistence" -}}
{{- if and .Values.persistence.enabled (not .Values.persistence.existingClaim) (not .Values.persistence.size) }}
metube: persistence.size
    A valid persistence size is required when persistence is enabled!
    Please set a valid size in persistence.size (e.g. 10Gi)
{{- end -}}
{{- end -}}

{{/*
Return the MeTube configuration secret name
*/}}
{{- define "metube.configSecretName" -}}
{{- printf "%s-config" (include "common.names.fullname" .) -}}
{{- end -}}

{{/*
Return the cookies secret name
*/}}
{{- define "metube.cookiesSecretName" -}}
{{- if .Values.cookies.existingSecret -}}
    {{- .Values.cookies.existingSecret -}}
{{- else -}}
    {{- printf "%s-cookies" (include "common.names.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Return the TLS secret name
*/}}
{{- define "metube.tlsSecretName" -}}
{{- if .Values.tls.existingSecret -}}
  {{- .Values.tls.existingSecret -}}
{{- else -}}
  {{- printf "%s-tls" (include "common.names.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Return true if cert-manager required annotations for TLS signed
certificates are set in the Ingress annotations
Ref: https://cert-manager.io/docs/usage/ingress/#supported-annotations
*/}}
{{- define "metube.ingress.certManagerRequest" -}}
{{ if or (hasKey . "cert-manager.io/cluster-issuer") (hasKey . "cert-manager.io/issuer") (hasKey . "kubernetes.io/tls-acme") }}
    {{- true -}}
{{- end -}}
{{- end -}}
