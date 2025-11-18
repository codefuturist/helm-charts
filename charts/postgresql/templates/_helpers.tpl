{{/* vim: set filetype=mustache: */}}

{{/*
Define the name of the chart/application.
*/}}
{{- define "postgresql.name" -}}
{{- default .Chart.Name .Values.applicationName | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "postgresql.fullname" -}}
{{- if .Values.applicationName -}}
{{- .Values.applicationName | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "postgresql.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Renders a value that contains template.
Usage:
{{ include "postgresql.tplvalues.render" ( dict "value" .Values.path.to.the.Value "context" $) }}
*/}}
{{- define "postgresql.tplvalues.render" -}}
    {{- if typeIs "string" .value }}
        {{- tpl .value .context }}
    {{- else }}
        {{- tpl (.value | toYaml) .context }}
    {{- end }}
{{- end -}}

{{/*
Additional common labels
*/}}
{{- define "postgresql.additionalLabels" -}}
{{- if .Values.additionalLabels }}
{{ include "postgresql.tplvalues.render" ( dict "value" .Values.additionalLabels "context" $ ) }}
{{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "postgresql.labels" -}}
helm.sh/chart: {{ include "postgresql.chart" . }}
{{ include "postgresql.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if .Values.componentOverride }}
app.kubernetes.io/component: {{ .Values.componentOverride }}
{{- else }}
app.kubernetes.io/component: database
{{- end }}
{{- if .Values.partOfOverride }}
app.kubernetes.io/part-of: {{ .Values.partOfOverride }}
{{- else }}
app.kubernetes.io/part-of: {{ include "postgresql.name" . }}
{{- end }}
{{ include "postgresql.additionalLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "postgresql.selectorLabels" -}}
app.kubernetes.io/name: {{ include "postgresql.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "postgresql.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "postgresql.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the proper PostgreSQL image name
*/}}
{{- define "postgresql.image" -}}
{{- $registryName := .Values.postgresql.image.repository -}}
{{- $tag := .Values.postgresql.image.tag | toString -}}
{{- $digest := .Values.postgresql.image.digest | toString -}}
{{- if $digest }}
{{- printf "%s@%s" $registryName $digest -}}
{{- else -}}
{{- printf "%s:%s" $registryName $tag -}}
{{- end -}}
{{- end -}}

{{/*
Return the namespace
*/}}
{{- define "postgresql.namespace" -}}
{{- if .Values.namespaceOverride -}}
{{- .Values.namespaceOverride -}}
{{- else -}}
{{- .Release.Namespace -}}
{{- end -}}
{{- end -}}

{{/*
Return the PostgreSQL primary service name
*/}}
{{- define "postgresql.primary.serviceName" -}}
{{- printf "%s" (include "postgresql.fullname" .) -}}
{{- end -}}

{{/*
Return the PostgreSQL read replica service name
*/}}
{{- define "postgresql.replica.serviceName" -}}
{{- printf "%s-read" (include "postgresql.fullname" .) -}}
{{- end -}}

{{/*
Return the PostgreSQL secret name
*/}}
{{- define "postgresql.secretName" -}}
{{- if .Values.postgresql.existingSecret -}}
{{- .Values.postgresql.existingSecret -}}
{{- else -}}
{{- include "postgresql.fullname" . -}}
{{- end -}}
{{- end -}}

{{/*
Return the PostgreSQL postgres secret name
*/}}
{{- define "postgresql.postgresSecretName" -}}
{{- if .Values.postgresql.existingPostgresSecret -}}
{{- .Values.postgresql.existingPostgresSecret -}}
{{- else -}}
{{- include "postgresql.fullname" . -}}
{{- end -}}
{{- end -}}

{{/*
Return the PostgreSQL password key
*/}}
{{- define "postgresql.passwordKey" -}}
{{- if .Values.postgresql.existingSecret -}}
{{- .Values.postgresql.existingSecretPasswordKey -}}
{{- else -}}
postgresql-password
{{- end -}}
{{- end -}}

{{/*
Return the PostgreSQL postgres password key
*/}}
{{- define "postgresql.postgresPasswordKey" -}}
{{- if .Values.postgresql.existingPostgresSecret -}}
{{- .Values.postgresql.existingPostgresPasswordKey -}}
{{- else -}}
postgresql-postgres-password
{{- end -}}
{{- end -}}

{{/*
Return true if a secret object should be created
*/}}
{{- define "postgresql.createSecret" -}}
{{- if not .Values.postgresql.existingSecret -}}
{{- true -}}
{{- end -}}
{{- end -}}

{{/*
Get the password for PostgreSQL
*/}}
{{- define "postgresql.password" -}}
{{- if .Values.postgresql.password -}}
{{- .Values.postgresql.password | b64enc | quote -}}
{{- else -}}
{{- randAlphaNum 16 | b64enc | quote -}}
{{- end -}}
{{- end -}}

{{/*
Get the postgres password for PostgreSQL
*/}}
{{- define "postgresql.postgresPassword" -}}
{{- if .Values.postgresql.postgresPassword -}}
{{- .Values.postgresql.postgresPassword | b64enc | quote -}}
{{- else -}}
{{- randAlphaNum 16 | b64enc | quote -}}
{{- end -}}
{{- end -}}

{{/*
Return PostgreSQL data volume mount
*/}}
{{- define "postgresql.dataVolumeName" -}}
{{- if .Values.persistence.enabled -}}
data
{{- else -}}
data-emptydir
{{- end -}}
{{- end -}}

{{/*
Compile all warnings into a single message.
*/}}
{{- define "postgresql.validateValues" -}}
{{- $messages := list -}}
{{- $messages := append $messages (include "postgresql.validateValues.database" .) -}}
{{- $messages := append $messages (include "postgresql.validateValues.username" .) -}}
{{- $messages := append $messages (include "postgresql.validateValues.replication" .) -}}
{{- $messages := without $messages "" -}}
{{- $message := join "\n" $messages -}}
{{- if $message -}}
{{- printf "\nVALUES VALIDATION:\n%s" $message | fail -}}
{{- end -}}
{{- end -}}

{{/*
Validate values - Database
*/}}
{{- define "postgresql.validateValues.database" -}}
{{- if not .Values.postgresql.database -}}
postgresql: database
    A database name is required.
    Please set postgresql.database (e.g. postgres)
{{- end -}}
{{- end -}}

{{/*
Validate values - Username
*/}}
{{- define "postgresql.validateValues.username" -}}
{{- if not .Values.postgresql.username -}}
postgresql: username
    A username is required.
    Please set postgresql.username (e.g. postgres)
{{- end -}}
{{- end -}}

{{/*
Validate values - Replication
*/}}
{{- define "postgresql.validateValues.replication" -}}
{{- if and .Values.replication.enabled (not .Values.statefulset.enabled) -}}
postgresql: replication
    Replication requires StatefulSet to be enabled.
    Please set statefulset.enabled=true when using replication.
{{- end -}}
{{- end -}}

{{/*
Return the appropriate apiVersion for PodDisruptionBudget
*/}}
{{- define "postgresql.pdb.apiVersion" -}}
{{- if semverCompare ">=1.21-0" .Capabilities.KubeVersion.Version -}}
{{- print "policy/v1" -}}
{{- else -}}
{{- print "policy/v1beta1" -}}
{{- end -}}
{{- end -}}

{{/*
Return the appropriate apiVersion for HorizontalPodAutoscaler
*/}}
{{- define "postgresql.hpa.apiVersion" -}}
{{- if semverCompare ">=1.23-0" .Capabilities.KubeVersion.Version -}}
{{- print "autoscaling/v2" -}}
{{- else -}}
{{- print "autoscaling/v2beta2" -}}
{{- end -}}
{{- end -}}

{{/*
Check if values have changed that require pod restart
*/}}
{{- define "postgresql.configChanged" -}}
{{- $config := include (print $.Template.BasePath "/configmap.yaml") . | sha256sum -}}
{{- $secret := include (print $.Template.BasePath "/secret.yaml") . | sha256sum -}}
{{- printf "%s-%s" $config $secret -}}
{{- end -}}

{{/*
Service mesh annotations
*/}}
{{- define "postgresql.serviceMeshAnnotations" -}}
{{- if .Values.serviceMesh.enabled -}}
{{- if eq .Values.serviceMesh.provider "istio" -}}
{{- if .Values.serviceMesh.istio.injection }}
sidecar.istio.io/inject: "true"
{{- else }}
sidecar.istio.io/inject: "false"
{{- end }}
{{- if .Values.serviceMesh.istio.mtls }}
{{- if .Values.serviceMesh.istio.mtls.mode }}
security.istio.io/tlsMode: {{ .Values.serviceMesh.istio.mtls.mode | quote }}
{{- end }}
{{- end }}
{{- else if eq .Values.serviceMesh.provider "linkerd" -}}
{{- if .Values.serviceMesh.linkerd.injection }}
linkerd.io/inject: enabled
{{- else }}
linkerd.io/inject: disabled
{{- end }}
{{- if .Values.serviceMesh.linkerd.skipInboundPorts }}
config.linkerd.io/skip-inbound-ports: {{ .Values.serviceMesh.linkerd.skipInboundPorts | quote }}
{{- end }}
{{- if .Values.serviceMesh.linkerd.skipOutboundPorts }}
config.linkerd.io/skip-outbound-ports: {{ .Values.serviceMesh.linkerd.skipOutboundPorts | quote }}
{{- end }}
{{- end }}
{{- end }}
{{- end -}}

{{/*
Kubernetes integration annotations
*/}}
{{- define "postgresql.kubernetesAnnotations" -}}
{{- if .Values.kubernetesIntegration.autoReload.enabled }}
configmap.reloader.stakater.com/reload: "{{ include "postgresql.fullname" . }}-config"
secret.reloader.stakater.com/reload: "{{ include "postgresql.fullname" . }}"
{{- end }}
{{- end -}}

{{/*
Generate SQL for creating additional databases
*/}}
{{- define "postgresql.databaseSQL" -}}
{{- $databases := list -}}
{{- $users := list -}}
{{- if .Values.postgresql.additionalDatabases -}}
{{- $databases = .Values.postgresql.additionalDatabases -}}
{{- end -}}
{{- if .Values.postgresql.additionalUsers -}}
{{- $users = .Values.postgresql.additionalUsers -}}
{{- end -}}
{{- if and .Values.postgresql.externalResources.enabled .Values.postgresql.externalResources.databasesConfigMap.name -}}
{{- $cmNamespace := .Values.postgresql.externalResources.databasesConfigMap.namespace | default .Release.Namespace -}}
{{- $cm := lookup "v1" "ConfigMap" $cmNamespace .Values.postgresql.externalResources.databasesConfigMap.name -}}
{{- if $cm -}}
{{- $key := .Values.postgresql.externalResources.databasesConfigMap.key -}}
{{- if hasKey $cm.data $key -}}
{{- $externalDbs := index $cm.data $key | fromYaml -}}
{{- $databases = concat $databases $externalDbs -}}
{{- end -}}
{{- end -}}
{{- end -}}
{{- if and .Values.postgresql.externalResources.enabled .Values.postgresql.externalResources.usersConfigMap.name -}}
{{- $cmNamespace := .Values.postgresql.externalResources.usersConfigMap.namespace | default .Release.Namespace -}}
{{- $cm := lookup "v1" "ConfigMap" $cmNamespace .Values.postgresql.externalResources.usersConfigMap.name -}}
{{- if $cm -}}
{{- $key := .Values.postgresql.externalResources.usersConfigMap.key -}}
{{- if hasKey $cm.data $key -}}
{{- $externalUsers := index $cm.data $key | fromYaml -}}
{{- $users = concat $users $externalUsers -}}
{{- end -}}
{{- end -}}
{{- end -}}
{{- range $db := $databases }}
{{- $owner := $db.owner -}}
{{- if not $owner -}}
{{- range $user := $users -}}
{{- if $user.databases -}}
{{- range $userDb := $user.databases -}}
{{- if eq $userDb $db.name -}}
{{- if not $owner -}}
{{- $owner = $user.username -}}
{{- end -}}
{{- end -}}
{{- end -}}
{{- end -}}
{{- end -}}
{{- end -}}
-- Create database: {{ $db.name }}
SELECT 'CREATE DATABASE {{ $db.name }}
{{- if $owner }} OWNER {{ $owner }}{{ end }}
{{- if $db.encoding }} ENCODING {{ $db.encoding | squote }}{{ end }}
{{- if $db.lc_collate }} LC_COLLATE {{ $db.lc_collate | squote }}{{ end }}
{{- if $db.lc_ctype }} LC_CTYPE {{ $db.lc_ctype | squote }}{{ end }}
{{- if $db.template }} TEMPLATE {{ $db.template }}{{ end }}'
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = '{{ $db.name }}');
\gexec
{{- end -}}
{{- end -}}

{{/*
Generate SQL for creating additional users
*/}}
{{- define "postgresql.userSQL" -}}
{{- $users := list -}}
{{- if .Values.postgresql.additionalUsers -}}
{{- $users = .Values.postgresql.additionalUsers -}}
{{- end -}}
{{- if and .Values.postgresql.externalResources.enabled .Values.postgresql.externalResources.usersConfigMap.name -}}
{{- $cmNamespace := .Values.postgresql.externalResources.usersConfigMap.namespace | default .Release.Namespace -}}
{{- $cm := lookup "v1" "ConfigMap" $cmNamespace .Values.postgresql.externalResources.usersConfigMap.name -}}
{{- if $cm -}}
{{- $key := .Values.postgresql.externalResources.usersConfigMap.key -}}
{{- if hasKey $cm.data $key -}}
{{- $externalUsers := index $cm.data $key | fromYaml -}}
{{- $users = concat $users $externalUsers -}}
{{- end -}}
{{- end -}}
{{- end -}}
{{- $secretNamespace := .Release.Namespace -}}
{{- $usersSecret := "" -}}
{{- if and .Values.postgresql.externalResources.enabled .Values.postgresql.externalResources.usersSecret.name -}}
{{- $usersSecretNamespace := .Values.postgresql.externalResources.usersSecret.namespace | default .Release.Namespace -}}
{{- $usersSecret = lookup "v1" "Secret" $usersSecretNamespace .Values.postgresql.externalResources.usersSecret.name -}}
{{- end -}}
{{- range $user := $users }}
-- Create user: {{ $user.username }}
DO $$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_catalog.pg_user WHERE usename = '{{ $user.username }}') THEN
    CREATE USER {{ $user.username }}
    {{- if $user.password }} WITH PASSWORD '{{ $user.password }}'{{ end }}
    {{- if $user.superuser }} SUPERUSER{{ else }} NOSUPERUSER{{ end }}
    {{- if $user.createdb }} CREATEDB{{ else }} NOCREATEDB{{ end }}
    {{- if $user.createrole }} CREATEROLE{{ else }} NOCREATEROLE{{ end }}
    {{- if $user.replication }} REPLICATION{{ else }} NOREPLICATION{{ end }};
  END IF;
END
$$;

{{- if $user.existingSecret }}
{{- $userSecretNamespace := $secretNamespace -}}
{{- $userSecret := lookup "v1" "Secret" $userSecretNamespace $user.existingSecret -}}
{{- if $userSecret }}
{{- $passwordKey := $user.existingSecretKey | default "password" -}}
{{- if hasKey $userSecret.data $passwordKey }}
{{- $password := index $userSecret.data $passwordKey | b64dec }}
-- Update password from secret for user: {{ $user.username }}
ALTER USER {{ $user.username }} WITH PASSWORD '{{ $password }}';
{{- end }}
{{- end }}
{{- else if and $usersSecret (hasKey $.Values.postgresql.externalResources.usersSecret.passwordKeys $user.username) }}
{{- $passwordKey := index $.Values.postgresql.externalResources.usersSecret.passwordKeys $user.username -}}
{{- if hasKey $usersSecret.data $passwordKey }}
{{- $password := index $usersSecret.data $passwordKey | b64dec }}
-- Update password from external secret for user: {{ $user.username }}
ALTER USER {{ $user.username }} WITH PASSWORD '{{ $password }}';
{{- end }}
{{- end }}

{{- if $user.databases }}
{{- range $db := $user.databases }}
-- Grant {{ $user.privileges | default "ALL" }} on {{ $db }} to {{ $user.username }}
GRANT {{ $user.privileges | default "ALL PRIVILEGES" }} ON DATABASE {{ $db }} TO {{ $user.username }};
{{- end }}
{{- end }}
{{- end -}}
{{- end -}}
