{{/*
Expand the name of the chart.
*/}}
{{- define "paperless-ngx.name" -}}
{{- include "common.names.name" . -}}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "paperless-ngx.fullname" -}}
{{- include "common.names.fullname" . -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "paperless-ngx.chart" -}}
{{- include "common.names.chart" . -}}
{{- end }}

{{/*
Common labels
*/}}
{{- define "paperless-ngx.labels" -}}
{{- include "common.labels.standard" (dict "customLabels" .Values.commonLabels "context" $) -}}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "paperless-ngx.selectorLabels" -}}
{{- include "common.labels.matchLabels" . -}}
{{- end }}

{{/*
Worker selector labels
*/}}
{{- define "paperless-ngx.workerSelectorLabels" -}}
app.kubernetes.io/name: {{ include "paperless-ngx.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: worker
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "paperless-ngx.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "paperless-ngx.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the proper Paperless-ngx image name
*/}}
{{- define "paperless-ngx.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global "chart" .Chart) -}}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "paperless-ngx.imagePullSecrets" -}}
{{- include "common.images.renderPullSecrets" (dict "images" (list .Values.image) "context" $) -}}
{{- end -}}

{{/*
Return the name of the secret containing the secret key
*/}}
{{- define "paperless-ngx.secretName" -}}
{{- if .Values.config.existingSecret }}
{{- .Values.config.existingSecret }}
{{- else }}
{{- include "paperless-ngx.fullname" . }}
{{- end }}
{{- end }}

{{/*
Return the configured database engine (postgresql or mariadb)
*/}}
{{- define "paperless-ngx.database.engine" -}}
{{- $engine := default "postgresql" (lower .Values.database.type) -}}
{{- if not (has $engine (list "postgresql" "mariadb")) -}}
postgresql
{{- else -}}
{{- $engine -}}
{{- end -}}
{{- end }}

{{/*
Return the database hostname
*/}}
{{- define "paperless-ngx.database.host" -}}
{{- $engine := include "paperless-ngx.database.engine" . -}}
{{- if eq $engine "postgresql" -}}
  {{- if and .Values.postgresql.enabled (not .Values.database.postgresql.host) -}}
{{- printf "%s-postgresql" (include "paperless-ngx.fullname" .) -}}
  {{- else -}}
{{- .Values.database.postgresql.host -}}
  {{- end -}}
{{- else -}}
{{- .Values.database.mariadb.host -}}
{{- end -}}
{{- end }}

{{/*
Return the database port
*/}}
{{- define "paperless-ngx.database.port" -}}
{{- $engine := include "paperless-ngx.database.engine" . -}}
{{- if eq $engine "postgresql" -}}
{{- .Values.database.postgresql.port -}}
{{- else -}}
{{- .Values.database.mariadb.port -}}
{{- end -}}
{{- end }}

{{/*
Return the database name
*/}}
{{- define "paperless-ngx.database.name" -}}
{{- $engine := include "paperless-ngx.database.engine" . -}}
{{- if eq $engine "postgresql" -}}
  {{- if .Values.postgresql.enabled -}}
{{- .Values.postgresql.auth.database -}}
  {{- else -}}
{{- .Values.database.postgresql.database -}}
  {{- end -}}
{{- else -}}
{{- .Values.database.mariadb.database -}}
{{- end -}}
{{- end }}

{{/*
Return the database username
*/}}
{{- define "paperless-ngx.database.username" -}}
{{- $engine := include "paperless-ngx.database.engine" . -}}
{{- if eq $engine "postgresql" -}}
  {{- if .Values.postgresql.enabled -}}
{{- .Values.postgresql.auth.username -}}
  {{- else -}}
{{- .Values.database.postgresql.username -}}
  {{- end -}}
{{- else -}}
{{- .Values.database.mariadb.username -}}
{{- end -}}
{{- end }}

{{/*
Return the configured database SSL mode
*/}}
{{- define "paperless-ngx.database.sslMode" -}}
{{- $engine := include "paperless-ngx.database.engine" . -}}
{{- if eq $engine "postgresql" -}}
{{- .Values.database.postgresql.sslMode -}}
{{- else -}}
{{- .Values.database.mariadb.sslMode -}}
{{- end -}}
{{- end }}

{{/*
Return the name of the secret containing the database password
*/}}
{{- define "paperless-ngx.database.secretName" -}}
{{- $engine := include "paperless-ngx.database.engine" . -}}
{{- if and (eq $engine "postgresql") .Values.database.postgresql.existingSecret -}}
{{- .Values.database.postgresql.existingSecret -}}
{{- else if and (eq $engine "mariadb") .Values.database.mariadb.existingSecret -}}
{{- .Values.database.mariadb.existingSecret -}}
{{- else if and (eq $engine "postgresql") .Values.postgresql.enabled -}}
{{- printf "%s-postgresql" (include "paperless-ngx.fullname" .) -}}
{{- else -}}
{{- include "paperless-ngx.fullname" . -}}
{{- end -}}
{{- end }}

{{/*
Return the database password secret key
*/}}
{{- define "paperless-ngx.database.secretKey" -}}
{{- $engine := include "paperless-ngx.database.engine" . -}}
{{- if and (eq $engine "postgresql") .Values.database.postgresql.existingSecret -}}
{{- .Values.database.postgresql.passwordKey -}}
{{- else if and (eq $engine "mariadb") .Values.database.mariadb.existingSecret -}}
{{- .Values.database.mariadb.passwordKey -}}
{{- else if and (eq $engine "postgresql") .Values.postgresql.enabled -}}
password
{{- else -}}
database-password
{{- end -}}
{{- end }}

{{/*
Return the Redis hostname
*/}}
{{- define "paperless-ngx.redis.host" -}}
{{- if and .Values.redis.enabled (not .Values.redis.host) -}}
{{- printf "%s-redis-master" (include "paperless-ngx.fullname" .) -}}
{{- else -}}
{{- .Values.redis.host -}}
{{- end -}}
{{- end }}

{{/*
Return the Redis port
*/}}
{{- define "paperless-ngx.redis.port" -}}
{{- .Values.redis.port }}
{{- end }}

{{/*
Return the name of the secret containing the redis password
*/}}
{{- define "paperless-ngx.redis.secretName" -}}
{{- if .Values.redis.existingSecret -}}
{{- .Values.redis.existingSecret -}}
{{- else if and .Values.redis.enabled .Values.redis.auth.enabled -}}
{{- printf "%s-redis" (include "paperless-ngx.fullname" .) -}}
{{- else -}}
{{- include "paperless-ngx.fullname" . -}}
{{- end -}}
{{- end }}

{{/*
Return the redis password secret key
*/}}
{{- define "paperless-ngx.redis.secretKey" -}}
{{- if .Values.redis.existingSecret -}}
{{- .Values.redis.passwordKey -}}
{{- else -}}
redis-password
{{- end -}}
{{- end }}

{{/*
Return the name of the secret containing the email password
*/}}
{{- define "paperless-ngx.email.secretName" -}}
{{- if .Values.email.existingSecret -}}
{{- .Values.email.existingSecret -}}
{{- else -}}
{{- include "paperless-ngx.fullname" . -}}
{{- end -}}
{{- end }}

{{/*
Return the Paperless-AI fullname helper
*/}}
{{- define "paperless-ngx.paperlessAi.fullname" -}}
{{- printf "%s-paperless-ai" (include "paperless-ngx.fullname" .) -}}
{{- end }}

{{/*
Selector labels for Paperless-AI
*/}}
{{- define "paperless-ngx.paperlessAi.selectorLabels" -}}
app.kubernetes.io/name: {{ include "paperless-ngx.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: paperless-ai
{{- end }}

{{/*
Common labels for Paperless-AI
*/}}
{{- define "paperless-ngx.paperlessAi.labels" -}}
{{ include "paperless-ngx.labels" . }}
app.kubernetes.io/component: paperless-ai
{{- end }}

{{/*
Return the Paperless-AI image reference
*/}}
{{- define "paperless-ngx.paperlessAi.image" -}}
{{- $imageRoot := .Values.paperlessAi.image | default dict -}}
{{- include "common.images.image" (dict "imageRoot" $imageRoot "global" .Values.global "chart" .Chart) -}}
{{- end }}

{{/*
Return Paperless-AI imagePullSecrets
*/}}
{{- define "paperless-ngx.paperlessAi.imagePullSecrets" -}}
{{- $imageRoot := .Values.paperlessAi.image | default dict -}}
{{- include "common.images.renderPullSecrets" (dict "images" (list $imageRoot) "context" $) -}}
{{- end }}

{{/*
Return Paperless-AI ServiceAccount name
*/}}
{{- define "paperless-ngx.paperlessAi.serviceAccountName" -}}
{{- if .Values.paperlessAi.serviceAccount.create -}}
{{- default (printf "%s-paperless-ai" (include "paperless-ngx.fullname" .)) .Values.paperlessAi.serviceAccount.name -}}
{{- else if .Values.paperlessAi.serviceAccount.name -}}
{{- .Values.paperlessAi.serviceAccount.name -}}
{{- else -}}
{{ include "paperless-ngx.serviceAccountName" . }}
{{- end -}}
{{- end }}

{{/*
Return Paperless-AI PVC name
*/}}
{{- define "paperless-ngx.paperlessAi.pvc" -}}
{{- if .Values.paperlessAi.persistence.existingClaim -}}
{{- .Values.paperlessAi.persistence.existingClaim -}}
{{- else -}}
{{- printf "%s-paperless-ai-data" (include "paperless-ngx.fullname" .) -}}
{{- end -}}
{{- end }}

{{/*
Determine if managed env mode is enabled
*/}}
{{- define "paperless-ngx.paperlessAi.managedEnv" -}}
{{- eq (lower (default "managed" .Values.paperlessAi.configMode)) "managed" -}}
{{- end }}

{{/*
Return Paperless-AI env secret name
*/}}
{{- define "paperless-ngx.paperlessAi.envSecretName" -}}
{{- if .Values.paperlessAi.envSecret.existingSecret -}}
{{- .Values.paperlessAi.envSecret.existingSecret -}}
{{- else -}}
{{- printf "%s-paperless-ai-env" (include "paperless-ngx.fullname" .) -}}
{{- end -}}
{{- end }}

{{/*
Return Paperless-AI env secret key
*/}}
{{- define "paperless-ngx.paperlessAi.envSecretKey" -}}
{{- default "paperless-ai.env" .Values.paperlessAi.envSecret.key -}}
{{- end }}

{{/*
Default Paperless URL (without /api) usable by companion services
*/}}
{{- define "paperless-ngx.paperlessBaseUrl" -}}
{{- if .Values.config.url -}}
{{- .Values.config.url -}}
{{- else if and .Values.ingress.enabled (gt (len .Values.ingress.hosts) 0) -}}
  {{- $host := (index .Values.ingress.hosts 0).host | trimSuffix "/" -}}
  {{- $scheme := ternary "https" "http" (gt (len .Values.ingress.tls) 0) -}}
  {{- printf "%s://%s" $scheme $host -}}
{{- else -}}
  {{- printf "http://%s:%v" (include "paperless-ngx.fullname" .) (.Values.service.port | default 80) -}}
{{- end -}}
{{- end }}

{{/*
Default Paperless API URL (with /api suffix)
*/}}
{{- define "paperless-ngx.paperlessApiUrl" -}}
{{- $base := include "paperless-ngx.paperlessBaseUrl" . -}}
{{- $trimmed := trimSuffix "/" $base -}}
{{- printf "%s/api" $trimmed -}}
{{- end }}

{{/*
Backward compatible helper for Paperless-AI base URL
*/}}
{{- define "paperless-ngx.paperlessAi.basePaperlessUrl" -}}
{{- include "paperless-ngx.paperlessBaseUrl" . -}}
{{- end }}

{{/*
Default Paperless API URL for Paperless-AI
*/}}
{{- define "paperless-ngx.paperlessAi.apiUrl" -}}
{{- include "paperless-ngx.paperlessApiUrl" . -}}
{{- end }}

{{/*
Render managed Paperless-AI env file
*/}}
{{- define "paperless-ngx.paperlessAi.envFile" -}}
{{- $envVals := merge (dict) (default (dict) .Values.paperlessAi.env) -}}
{{- $currentApi := default "" (get $envVals "PAPERLESS_API_URL") -}}
{{- if eq (trim $currentApi) "" -}}
  {{- $_ := set $envVals "PAPERLESS_API_URL" (include "paperless-ngx.paperlessAi.apiUrl" .) -}}
{{- end -}}
{{- $aiPort := default (printf "%d" (int (default 3000 .Values.paperlessAi.service.port))) (get $envVals "PAPERLESS_AI_PORT") -}}
{{- if eq (trim (default "" $aiPort)) "" -}}
  {{- $_ := set $envVals "PAPERLESS_AI_PORT" (printf "%d" (int (default 3000 .Values.paperlessAi.service.port))) -}}
{{- end -}}
{{- $ragUrlDefault := printf "http://127.0.0.1:%d" (int (default 8000 .Values.paperlessAi.service.ragPort)) -}}
{{- $ragUrl := default "" (get $envVals "RAG_SERVICE_URL") -}}
{{- if eq (trim $ragUrl) "" -}}
  {{- $_ := set $envVals "RAG_SERVICE_URL" $ragUrlDefault -}}
{{- end -}}
{{- range $key := sortAlpha (keys $envVals) -}}
  {{- $raw := index $envVals $key -}}
  {{- if ne (kindOf $raw) "<nil>" -}}
    {{- $value := "" -}}
    {{- if eq (kindOf $raw) "string" -}}
      {{- $value = tpl $raw $ -}}
    {{- else -}}
      {{- $value = printf "%v" $raw -}}
    {{- end -}}
{{ printf "%s=%s\n" $key $value }}
  {{- end -}}
{{- end -}}
{{- range $line := .Values.paperlessAi.envExtraLines -}}
{{ printf "%s\n" (tpl $line $) }}
{{- end -}}
{{- end }}

{{/*
Return the Paperless-GPT fullname helper
*/}}
{{- define "paperless-ngx.paperlessGpt.fullname" -}}
{{- printf "%s-paperless-gpt" (include "paperless-ngx.fullname" .) -}}
{{- end }}

{{/*
Selector labels for Paperless-GPT
*/}}
{{- define "paperless-ngx.paperlessGpt.selectorLabels" -}}
app.kubernetes.io/name: {{ include "paperless-ngx.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: paperless-gpt
{{- end }}

{{/*
Common labels for Paperless-GPT
*/}}
{{- define "paperless-ngx.paperlessGpt.labels" -}}
{{ include "paperless-ngx.labels" . }}
app.kubernetes.io/component: paperless-gpt
{{- end }}

{{/*
Return the Paperless-GPT image reference
*/}}
{{- define "paperless-ngx.paperlessGpt.image" -}}
{{- $imageRoot := .Values.paperlessGpt.image | default dict -}}
{{- include "common.images.image" (dict "imageRoot" $imageRoot "global" .Values.global "chart" .Chart) -}}
{{- end }}

{{/*
Return Paperless-GPT imagePullSecrets
*/}}
{{- define "paperless-ngx.paperlessGpt.imagePullSecrets" -}}
{{- $imageRoot := .Values.paperlessGpt.image | default dict -}}
{{- include "common.images.renderPullSecrets" (dict "images" (list $imageRoot) "context" $) -}}
{{- end }}

{{/*
Return Paperless-GPT ServiceAccount name
*/}}
{{- define "paperless-ngx.paperlessGpt.serviceAccountName" -}}
{{- if .Values.paperlessGpt.serviceAccount.create -}}
{{- default (printf "%s-paperless-gpt" (include "paperless-ngx.fullname" .)) .Values.paperlessGpt.serviceAccount.name -}}
{{- else if .Values.paperlessGpt.serviceAccount.name -}}
{{- .Values.paperlessGpt.serviceAccount.name -}}
{{- else -}}
{{ include "paperless-ngx.serviceAccountName" . }}
{{- end -}}
{{- end }}

{{/*
Return Paperless-GPT PVC name
*/}}
{{- define "paperless-ngx.paperlessGpt.pvc" -}}
{{- if .Values.paperlessGpt.persistence.existingClaim -}}
{{- .Values.paperlessGpt.persistence.existingClaim -}}
{{- else -}}
{{- printf "%s-paperless-gpt-data" (include "paperless-ngx.fullname" .) -}}
{{- end -}}
{{- end }}

{{/*
Determine if managed env mode is enabled for Paperless-GPT
*/}}
{{- define "paperless-ngx.paperlessGpt.managedEnv" -}}
{{- eq (lower (default "managed" .Values.paperlessGpt.configMode)) "managed" -}}
{{- end }}

{{/*
Return Paperless-GPT env secret name
*/}}
{{- define "paperless-ngx.paperlessGpt.envSecretName" -}}
{{- if .Values.paperlessGpt.envSecret.existingSecret -}}
{{- .Values.paperlessGpt.envSecret.existingSecret -}}
{{- else -}}
{{- printf "%s-paperless-gpt-env" (include "paperless-ngx.fullname" .) -}}
{{- end -}}
{{- end }}

{{/*
Return Paperless-GPT env secret key
*/}}
{{- define "paperless-ngx.paperlessGpt.envSecretKey" -}}
{{- default "paperless-gpt.env" .Values.paperlessGpt.envSecret.key -}}
{{- end }}

{{/*
Default Paperless API URL for Paperless-GPT
*/}}
{{- define "paperless-ngx.paperlessGpt.apiUrl" -}}
{{- include "paperless-ngx.paperlessApiUrl" . -}}
{{- end }}

{{/*
Render managed Paperless-GPT env file
*/}}
{{- define "paperless-ngx.paperlessGpt.envFile" -}}
{{- $envVals := merge (dict) (default (dict) .Values.paperlessGpt.env) -}}
{{- $currentApi := default "" (get $envVals "PAPERLESS_API_URL") -}}
{{- if eq (trim $currentApi) "" -}}
  {{- $_ := set $envVals "PAPERLESS_API_URL" (include "paperless-ngx.paperlessGpt.apiUrl" .) -}}
{{- end -}}
{{- $ragUrlDefault := printf "http://127.0.0.1:%d" (int (default 8100 .Values.paperlessGpt.service.ragPort)) -}}
{{- $ragUrl := default "" (get $envVals "RAG_SERVICE_URL") -}}
{{- if eq (trim $ragUrl) "" -}}
  {{- $_ := set $envVals "RAG_SERVICE_URL" $ragUrlDefault -}}
{{- end -}}
{{- $aiPort := default (printf "%d" (int (default 3100 .Values.paperlessGpt.service.port))) (get $envVals "PAPERLESS_GPT_PORT") -}}
{{- if eq (trim (default "" $aiPort)) "" -}}
  {{- $_ := set $envVals "PAPERLESS_GPT_PORT" (printf "%d" (int (default 3100 .Values.paperlessGpt.service.port))) -}}
{{- end -}}
{{- range $key := sortAlpha (keys $envVals) -}}
  {{- $raw := index $envVals $key -}}
  {{- if ne (kindOf $raw) "<nil>" -}}
    {{- $value := "" -}}
    {{- if eq (kindOf $raw) "string" -}}
      {{- $value = tpl $raw $ -}}
    {{- else -}}
      {{- $value = printf "%v" $raw -}}
    {{- end -}}
{{ printf "%s=%s\n" $key $value }}
  {{- end -}}
{{- end -}}
{{- range $line := .Values.paperlessGpt.envExtraLines -}}
{{ printf "%s\n" (tpl $line $) }}
{{- end -}}
{{- end }}

{{/*
Return the email password secret key
*/}}
{{- define "paperless-ngx.email.secretKey" -}}
{{- if .Values.email.existingSecret -}}
{{- .Values.email.passwordKey -}}
{{- else -}}
email-password
{{- end -}}
{{- end }}

{{/*
Return the data PVC name
*/}}
{{- define "paperless-ngx.pvc.data" -}}
{{- if .Values.persistence.data.existingClaim -}}
{{- .Values.persistence.data.existingClaim -}}
{{- else -}}
{{- printf "%s-data" (include "paperless-ngx.fullname" .) -}}
{{- end -}}
{{- end }}

{{/*
Return the media PVC name
*/}}
{{- define "paperless-ngx.pvc.media" -}}
{{- if .Values.persistence.media.existingClaim -}}
{{- .Values.persistence.media.existingClaim -}}
{{- else -}}
{{- printf "%s-media" (include "paperless-ngx.fullname" .) -}}
{{- end -}}
{{- end }}

{{/*
Return the consume PVC name
*/}}
{{- define "paperless-ngx.pvc.consume" -}}
{{- if .Values.persistence.consume.existingClaim -}}
{{- .Values.persistence.consume.existingClaim -}}
{{- else -}}
{{- printf "%s-consume" (include "paperless-ngx.fullname" .) -}}
{{- end -}}
{{- end }}

{{/*
Return the export PVC name
*/}}
{{- define "paperless-ngx.pvc.export" -}}
{{- if .Values.persistence.export.existingClaim -}}
{{- .Values.persistence.export.existingClaim -}}
{{- else -}}
{{- printf "%s-export" (include "paperless-ngx.fullname" .) -}}
{{- end -}}
{{- end }}

{{/*
Render the shared environment variables for Paperless workloads
*/}}
{{- define "paperless-ngx.env.common" -}}
{{- $dbEngine := trim (include "paperless-ngx.database.engine" .) -}}
{{- $dbHost := trim (include "paperless-ngx.database.host" .) -}}
{{- $dbPort := trim (include "paperless-ngx.database.port" .) -}}
{{- $dbName := trim (include "paperless-ngx.database.name" .) -}}
{{- $dbUser := trim (include "paperless-ngx.database.username" .) -}}
{{- $dbSecretName := include "paperless-ngx.database.secretName" . -}}
{{- $dbSecretKey := include "paperless-ngx.database.secretKey" . -}}
{{- $dbSSLMode := trim (include "paperless-ngx.database.sslMode" .) -}}
{{- $redisHost := trim (include "paperless-ngx.redis.host" .) -}}
{{- $redisPort := trim (include "paperless-ngx.redis.port" .) -}}
{{- $redisDb := int (default 0 .Values.redis.database) -}}
{{- $redisScheme := ternary "rediss" "redis" .Values.redis.ssl -}}
{{- $redisPasswordManaged := or .Values.redis.password .Values.redis.existingSecret (and .Values.redis.enabled .Values.redis.auth.enabled) -}}
# Application Configuration
- name: PAPERLESS_SECRET_KEY
  valueFrom:
    secretKeyRef:
      name: {{ include "paperless-ngx.secretName" . }}
      key: secret-key
{{- if .Values.config.adminUser }}
- name: PAPERLESS_ADMIN_USER
  value: {{ .Values.config.adminUser | quote }}
{{- end }}
{{- if .Values.config.adminMail }}
- name: PAPERLESS_ADMIN_MAIL
  value: {{ .Values.config.adminMail | quote }}
{{- end }}
{{- if .Values.config.adminPassword }}
- name: PAPERLESS_ADMIN_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ include "paperless-ngx.secretName" . }}
      key: admin-password
{{- end }}
- name: PAPERLESS_TIME_ZONE
  value: {{ .Values.config.timeZone | quote }}
- name: PAPERLESS_OCR_LANGUAGE
  value: {{ .Values.config.ocrLanguage | quote }}
- name: PAPERLESS_OCR_MODE
  value: {{ .Values.config.ocrMode | quote }}
- name: PAPERLESS_OCR_OUTPUT_TYPE
  value: {{ .Values.config.ocrOutputType | quote }}
- name: PAPERLESS_OCR_PAGES
  value: {{ .Values.config.ocrPages | quote }}
- name: PAPERLESS_OCR_IMAGE_DPI
  value: {{ .Values.config.ocrImageDpi | quote }}
- name: PAPERLESS_TASK_WORKERS
  value: {{ .Values.config.taskWorkers | quote }}
- name: PAPERLESS_THREADS_PER_WORKER
  value: {{ .Values.config.threadsPerWorker | quote }}
- name: PAPERLESS_WORKER_TIMEOUT
  value: {{ .Values.config.workerTimeout | quote }}
- name: PAPERLESS_ENABLE_COMPRESSION
  value: {{ .Values.config.enableCompression | quote }}
{{- if .Values.config.convertMemoryLimit }}
- name: PAPERLESS_CONVERT_MEMORY_LIMIT
  value: {{ .Values.config.convertMemoryLimit | quote }}
{{- end }}
{{- if .Values.config.convertTmpdir }}
- name: PAPERLESS_CONVERT_TMPDIR
  value: {{ .Values.config.convertTmpdir | quote }}
{{- end }}
- name: PAPERLESS_OPTIMIZE_THUMBNAILS
  value: {{ .Values.config.optimize | quote }}
- name: PAPERLESS_LOGROTATE_MAX_SIZE
  value: {{ .Values.config.logrotateMaxSize | quote }}
- name: PAPERLESS_LOGROTATE_MAX_BACKUPS
  value: {{ .Values.config.logrotateMaxBackups | quote }}
- name: PAPERLESS_ENABLE_NLTK
  value: {{ .Values.config.enableNltk | quote }}
{{- if .Values.config.dateParserLanguages }}
- name: PAPERLESS_DATE_PARSER_LANGUAGES
  value: {{ .Values.config.dateParserLanguages | quote }}
{{- end }}
{{- if .Values.config.dateOrder }}
- name: PAPERLESS_DATE_ORDER
  value: {{ .Values.config.dateOrder | quote }}
{{- end }}
- name: PAPERLESS_NUMBER_OF_SUGGESTED_DATES
  value: {{ .Values.config.numberOfSuggestedDates | quote }}
{{- if .Values.config.ignoreDates }}
- name: PAPERLESS_IGNORE_DATES
  value: {{ .Values.config.ignoreDates | quote }}
{{- end }}
- name: PAPERLESS_ENABLE_GPG_DECRYPTOR
  value: {{ .Values.config.enableGpgDecryptor | quote }}
{{- if .Values.config.filenameFormat }}
- name: PAPERLESS_FILENAME_FORMAT
  value: {{ .Values.config.filenameFormat | quote }}
{{- end }}
- name: PAPERLESS_FILENAME_FORMAT_REMOVE_NONE
  value: {{ .Values.config.filenameFormatRemoveNone | quote }}
{{- if .Values.config.consumerDisable }}
- name: PAPERLESS_CONSUMER_DISABLE
  value: "true"
{{- end }}
- name: PAPERLESS_CONSUMER_DELETE_DUPLICATES
  value: {{ .Values.config.consumerDeleteDuplicates | quote }}
- name: PAPERLESS_CONSUMER_RECURSIVE
  value: {{ .Values.config.consumerRecursive | quote }}
- name: PAPERLESS_CONSUMER_SUBDIRS_AS_TAGS
  value: {{ .Values.config.consumerSubdirsAsTags | quote }}
- name: PAPERLESS_CONSUMER_POLLING
  value: {{ .Values.config.consumerPolling | quote }}
- name: PAPERLESS_CONSUMER_POLLING_RETRY_COUNT
  value: {{ .Values.config.consumerPollingRetryCount | quote }}
- name: PAPERLESS_CONSUMER_POLLING_DELAY
  value: {{ .Values.config.consumerPollingDelay | quote }}
- name: PAPERLESS_CONSUMER_INOTIFY_DELAY
  value: {{ .Values.config.consumerInotifyDelay | quote }}

# Hosting & Security
{{- if .Values.config.url }}
- name: PAPERLESS_URL
  value: {{ .Values.config.url | quote }}
{{- end }}
{{- if .Values.config.csrfTrustedOrigins }}
- name: PAPERLESS_CSRF_TRUSTED_ORIGINS
  value: {{ join "," .Values.config.csrfTrustedOrigins | quote }}
{{- end }}
{{- if .Values.config.allowedHosts }}
- name: PAPERLESS_ALLOWED_HOSTS
  value: {{ join "," .Values.config.allowedHosts | quote }}
{{- end }}
{{- if .Values.config.corsAllowedHosts }}
- name: PAPERLESS_CORS_ALLOWED_HOSTS
  value: {{ join "," .Values.config.corsAllowedHosts | quote }}
{{- end }}
- name: PAPERLESS_ENABLE_HTTP_REMOTE_USER
  value: {{ .Values.config.enableHttpRemoteUser | quote }}
{{- if .Values.config.enableHttpRemoteUser }}
- name: PAPERLESS_HTTP_REMOTE_USER_HEADER_NAME
  value: {{ .Values.config.httpRemoteUserHeaderName | quote }}
{{- end }}
- name: PAPERLESS_ENABLE_HTTP_REMOTE_USER_API
  value: {{ .Values.config.enableHttpRemoteUserAPI | quote }}
{{- if .Values.config.cookiePrefix }}
- name: PAPERLESS_COOKIE_PREFIX
  value: {{ .Values.config.cookiePrefix | quote }}
{{- end }}
{{- if .Values.config.autoLoginUsername }}
- name: PAPERLESS_AUTO_LOGIN_USERNAME
  value: {{ .Values.config.autoLoginUsername | quote }}
{{- end }}
- name: PAPERLESS_DISABLE_REGULAR_LOGIN
  value: {{ .Values.config.disableRegularLogin | quote }}
- name: PAPERLESS_REDIRECT_LOGIN_TO_SSO
  value: {{ .Values.config.redirectLoginToSSO | quote }}
{{- if .Values.config.logoutRedirectUrl }}
- name: PAPERLESS_LOGOUT_REDIRECT_URL
  value: {{ .Values.config.logoutRedirectUrl | quote }}
{{- end }}
{{- if .Values.config.trustedProxies }}
- name: PAPERLESS_TRUSTED_PROXIES
  value: {{ join "," .Values.config.trustedProxies | quote }}
{{- end }}
{{- if .Values.config.forceScriptName }}
- name: PAPERLESS_FORCE_SCRIPT_NAME
  value: {{ .Values.config.forceScriptName | quote }}
{{- end }}
- name: PAPERLESS_STATIC_URL
  value: {{ .Values.config.staticUrl | quote }}
- name: PAPERLESS_USE_X_FORWARD_HOST
  value: {{ .Values.config.useXForwardedHost | quote }}
- name: PAPERLESS_USE_X_FORWARD_PORT
  value: {{ .Values.config.useXForwardedPort | quote }}
{{- if gt (len .Values.config.proxySslHeader) 0 }}
- name: PAPERLESS_PROXY_SSL_HEADER
  value: {{ toJson .Values.config.proxySslHeader | quote }}
{{- end }}
- name: PAPERLESS_ACCOUNT_ALLOW_SIGNUPS
  value: {{ .Values.config.accountAllowSignups | quote }}
{{- if gt (len .Values.config.accountDefaultGroups) 0 }}
- name: PAPERLESS_ACCOUNT_DEFAULT_GROUPS
  value: {{ join "," .Values.config.accountDefaultGroups | quote }}
{{- end }}
- name: PAPERLESS_SOCIALACCOUNT_ALLOW_SIGNUPS
  value: {{ .Values.config.socialAccountAllowSignups | quote }}
- name: PAPERLESS_SOCIAL_AUTO_SIGNUP
  value: {{ .Values.config.socialAutoSignup | quote }}
- name: PAPERLESS_SOCIAL_ACCOUNT_SYNC_GROUPS
  value: {{ .Values.config.socialAccountSyncGroups | quote }}
{{- if gt (len .Values.config.socialAccountDefaultGroups) 0 }}
- name: PAPERLESS_SOCIAL_ACCOUNT_DEFAULT_GROUPS
  value: {{ join "," .Values.config.socialAccountDefaultGroups | quote }}
{{- end }}
- name: PAPERLESS_ACCOUNT_SESSION_REMEMBER
  value: {{ .Values.config.accountSessionRemember | quote }}
- name: PAPERLESS_SESSION_COOKIE_AGE
  value: {{ .Values.config.sessionCookieAge | quote }}
- name: PAPERLESS_ACCOUNT_EMAIL_VERIFICATION
  value: {{ .Values.config.accountEmailVerification | quote }}
- name: PAPERLESS_ACCOUNT_EMAIL_UNKNOWN_ACCOUNTS
  value: {{ .Values.config.accountEmailUnknownAccounts | quote }}
- name: PAPERLESS_ACCOUNT_DEFAULT_HTTP_PROTOCOL
  value: {{ .Values.config.accountDefaultHttpProtocol | quote }}

# Paths & Storage
{{- if .Values.config.dataDir }}
- name: PAPERLESS_DATA_DIR
  value: {{ .Values.config.dataDir | quote }}
{{- end }}
{{- if .Values.config.mediaRoot }}
- name: PAPERLESS_MEDIA_ROOT
  value: {{ .Values.config.mediaRoot | quote }}
{{- end }}
{{- if .Values.config.consumptionDir }}
- name: PAPERLESS_CONSUMPTION_DIR
  value: {{ .Values.config.consumptionDir | quote }}
{{- end }}
{{- if .Values.config.exportDir }}
- name: PAPERLESS_EXPORT_DIR
  value: {{ .Values.config.exportDir | quote }}
{{- end }}
{{- if .Values.config.staticDir }}
- name: PAPERLESS_STATICDIR
  value: {{ .Values.config.staticDir | quote }}
{{- end }}
{{- if .Values.config.emptyTrashDir }}
- name: PAPERLESS_EMPTY_TRASH_DIR
  value: {{ .Values.config.emptyTrashDir | quote }}
{{- end }}
{{- if .Values.config.loggingDir }}
- name: PAPERLESS_LOGGING_DIR
  value: {{ .Values.config.loggingDir | quote }}
{{- end }}
{{- if .Values.config.nltkDir }}
- name: PAPERLESS_NLTK_DIR
  value: {{ .Values.config.nltkDir | quote }}
{{- end }}
{{- if .Values.config.modelFile }}
- name: PAPERLESS_MODEL_FILE
  value: {{ .Values.config.modelFile | quote }}
{{- end }}

# Database Configuration
- name: PAPERLESS_DBENGINE
  value: {{ $dbEngine | quote }}
- name: PAPERLESS_DBHOST
  value: {{ $dbHost | quote }}
- name: PAPERLESS_DBPORT
  value: {{ $dbPort | quote }}
- name: PAPERLESS_DBNAME
  value: {{ $dbName | quote }}
- name: PAPERLESS_DBUSER
  value: {{ $dbUser | quote }}
- name: PAPERLESS_DBPASS
  valueFrom:
    secretKeyRef:
      name: {{ $dbSecretName }}
      key: {{ $dbSecretKey }}
- name: PAPERLESS_DBSSLMODE
  value: {{ $dbSSLMode | quote }}
{{- if .Values.database.timeout }}
- name: PAPERLESS_DB_TIMEOUT
  value: {{ .Values.database.timeout | quote }}
{{- end }}
{{- if .Values.database.poolSize }}
- name: PAPERLESS_DB_POOLSIZE
  value: {{ .Values.database.poolSize | quote }}
{{- end }}
{{- if .Values.database.sslRootCert }}
- name: PAPERLESS_DBSSLROOTCERT
  value: {{ .Values.database.sslRootCert | quote }}
{{- end }}
{{- if .Values.database.sslCert }}
- name: PAPERLESS_DBSSLCERT
  value: {{ .Values.database.sslCert | quote }}
{{- end }}
{{- if .Values.database.sslKey }}
- name: PAPERLESS_DBSSLKEY
  value: {{ .Values.database.sslKey | quote }}
{{- end }}
- name: PAPERLESS_DB_READ_CACHE_ENABLED
  value: {{ .Values.database.readCache.enabled | quote }}
- name: PAPERLESS_READ_CACHE_TTL
  value: {{ .Values.database.readCache.ttl | quote }}
{{- if .Values.database.readCache.redisUrl }}
- name: PAPERLESS_READ_CACHE_REDIS_URL
  value: {{ .Values.database.readCache.redisUrl | quote }}
{{- end }}

# Redis Configuration
{{- if $redisHost }}
- name: PAPERLESS_REDIS
  value: {{ printf "%s://%s:%s/%d" $redisScheme $redisHost $redisPort $redisDb | quote }}
{{- end }}
{{- if $redisPasswordManaged }}
- name: PAPERLESS_REDIS_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ include "paperless-ngx.redis.secretName" . }}
      key: {{ include "paperless-ngx.redis.secretKey" . }}
{{- end }}
{{- if .Values.redis.prefix }}
- name: PAPERLESS_REDIS_PREFIX
  value: {{ .Values.redis.prefix | quote }}
{{- end }}

# Email Configuration
{{- if .Values.email.enabled }}
- name: PAPERLESS_EMAIL_HOST
  value: {{ .Values.email.host | quote }}
- name: PAPERLESS_EMAIL_PORT
  value: {{ .Values.email.port | quote }}
- name: PAPERLESS_EMAIL_FROM
  value: {{ .Values.email.from | quote }}
- name: PAPERLESS_EMAIL_USE_TLS
  value: {{ .Values.email.useTLS | quote }}
- name: PAPERLESS_EMAIL_USE_SSL
  value: {{ .Values.email.useSSL | quote }}
{{- if .Values.email.username }}
- name: PAPERLESS_EMAIL_HOST_USER
  value: {{ .Values.email.username | quote }}
{{- end }}
{{- if or .Values.email.password .Values.email.existingSecret }}
- name: PAPERLESS_EMAIL_HOST_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ include "paperless-ngx.email.secretName" . }}
      key: {{ include "paperless-ngx.email.secretKey" . }}
{{- end }}
{{- end }}

# Optional Services & Tasks
- name: PAPERLESS_EMAIL_TASK_CRON
  value: {{ .Values.tasks.email | quote }}
- name: PAPERLESS_TRAIN_TASK_CRON
  value: {{ .Values.tasks.train | quote }}
- name: PAPERLESS_INDEX_TASK_CRON
  value: {{ .Values.tasks.index | quote }}
- name: PAPERLESS_SANITY_TASK_CRON
  value: {{ .Values.tasks.sanity | quote }}
- name: PAPERLESS_EMPTY_TRASH_TASK_CRON
  value: {{ .Values.tasks.emptyTrash | quote }}
- name: PAPERLESS_EMAIL_PARSE_DEFAULT_LAYOUT
  value: {{ .Values.emailParsing.defaultLayout | quote }}
- name: PAPERLESS_TIKA_ENABLED
  value: {{ .Values.tika.enabled | quote }}
- name: PAPERLESS_TIKA_ENDPOINT
  value: {{ .Values.tika.endpoint | quote }}
- name: PAPERLESS_TIKA_GOTENBERG_ENDPOINT
  value: {{ .Values.tika.gotenbergEndpoint | quote }}
{{- end }}

{{/*
Compile all warnings into a single message.
*/}}
{{- define "paperless-ngx.validateValues" -}}
{{- $messages := list -}}
{{- $messages := append $messages (include "paperless-ngx.validateValues.database" .) -}}
{{- $messages := append $messages (include "paperless-ngx.validateValues.redis" .) -}}
{{- $messages := without $messages "" -}}
{{- $message := join "\n" $messages -}}
{{- if $message -}}
{{- printf "\nVALUES VALIDATION:\n%s" $message -}}
{{- end -}}
{{- end -}}

{{/*
Validate database configuration
*/}}
{{- define "paperless-ngx.validateValues.database" -}}
{{- $engine := include "paperless-ngx.database.engine" . | trim -}}
{{- if eq $engine "postgresql" -}}
  {{- if not .Values.postgresql.enabled -}}
    {{- if not .Values.database.postgresql.host -}}
paperless-ngx: database.postgresql.host
    Database host is required when postgresql.enabled is false.
    Please set database.postgresql.host (e.g. "postgresql.default.svc.cluster.local")
    or enable the PostgreSQL subchart with postgresql.enabled=true
    {{- end -}}
    {{- if and (not .Values.database.postgresql.password) (not .Values.database.postgresql.existingSecret) -}}
paperless-ngx: database.postgresql.password
    Database password is required.
    Please set database.postgresql.password or database.postgresql.existingSecret
    {{- end -}}
  {{- end -}}
{{- else if eq $engine "mariadb" -}}
  {{- if .Values.postgresql.enabled -}}
paperless-ngx: database.type mismatch
    database.type is set to "mariadb" but the bundled PostgreSQL subchart is still enabled.
    Disable postgresql.enabled or switch database.type back to postgresql.
  {{- end -}}
  {{- if not .Values.database.mariadb.host -}}
paperless-ngx: database.mariadb.host
    MariaDB host is required when database.type is "mariadb".
    Please set database.mariadb.host (e.g. "mariadb.default.svc.cluster.local").
  {{- end -}}
  {{- if and (not .Values.database.mariadb.password) (not .Values.database.mariadb.existingSecret) -}}
paperless-ngx: database.mariadb.password
    MariaDB password is required.
    Please set database.mariadb.password or database.mariadb.existingSecret
  {{- end -}}
{{- end -}}
{{- end -}}

{{/*
Validate Redis configuration
*/}}
{{- define "paperless-ngx.validateValues.redis" -}}
{{- if not .Values.redis.enabled -}}
  {{- if not .Values.redis.host -}}
paperless-ngx: redis.host
    Redis host is required when redis.enabled is false.
    Please set redis.host (e.g. "redis.default.svc.cluster.local")
    along with redis.port, redis.database and authentication details.
  {{- end -}}
  {{- if and (not .Values.redis.password) (not .Values.redis.existingSecret) -}}
paperless-ngx: redis.password
    Redis password (redis.password) or redis.existingSecret is required when using an external Redis instance.
  {{- end -}}
{{- end -}}
{{- end -}}
