{/* vim: set filetype=mustache: */}}

{{- define "mayan.secretsName" -}}
{{- $name := "mayan-edms" }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}-secrets
{{- end }}
{{- end }}

{{/*
Generate extra secrets, not managed by the _helpers
*/}}
{{- define "mayan.secrets.unmanaged" -}}
{{- $managedKeys := list "MAYAN_CELERY_BROKER_URL" "MAYAN_CELERY_RESULT_BACKEND" "MAYAN_DATABASES" "MAYAN_DOCUMENTS_FILE_STORAGE_BACKEND_ARGUMENTS" "DOCUMENTS_FILE_PAGE_IMAGE_CACHE_STORAGE_BACKEND_ARGUMENTS" "DOCUMENTS_VERSION_PAGE_IMAGE_CACHE_STORAGE_BACKEND_ARGUMENTS" "MAYAN_LOCK_MANAGER_BACKEND_ARGUMENTS" "MAYAN_SEARCH_BACKEND_ARGUMENTS" -}}
{{- range $key, $val := .Values.secrets -}}
{{- $keyFound := has $key $managedKeys -}}
{{- if not $keyFound -}}
{{ $key }}: {{ $val | quote }}
{{- "\n" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "mayan.secrets.managed" -}}
{{ include "mayan.secrets.celeryBrokerUrl" . }}
{{ include "mayan.secrets.celeryResultBackend" . }}
{{ include "mayan.secrets.databases" . }}
{{ include "mayan.secrets.documentsFileStorageBackendArguments" . }}
{{ include "mayan.secrets.documentsFilePageImageCacheStorageBackendArguments" . }}
{{ include "mayan.secrets.documentsVersionPageImageCacheStorageBackendArguments" . }}
{{ include "mayan.secrets.lockManagerBackendArguments" . }}
{{ include "mayan.secrets.searchBackendArguments" . }}
{{- end -}}

{{/*
Generate the RabbitMQ hostname
*/}}
{{- define "mayan.rabbitmq.host" -}}
{{ .Release.Name }}-rabbitmq
{{- end -}}

{{/*
Generate the MAYAN_CELERY_BROKEN_URL environment variable
*/}}
{{- define "mayan.secrets.celeryBrokerUrl" -}}
{{- if .Values.rabbitmq.enabled -}}
MAYAN_CELERY_BROKER_URL: "{{- if .Values.rabbitmq.auth.tls.enabled -}}amqps{{- else -}}amqp{{- end -}}://{{ .Values.rabbitmq.auth.username }}:{{ .Values.rabbitmq.auth.password }}@{{ template "mayan.rabbitmq.host" . }}:{{- if .Values.rabbitmq.auth.tls.enabled -}}{{ .Values.rabbitmq.service.tlsPort }}{{- else -}}{{ .Values.rabbitmq.service.port }}{{- end -}}"
{{- else -}}
{{- if .Values.redis.enabled -}}
MAYAN_CELERY_BROKER_URL: "redis://:{{ .Values.redis.password }}@{{ template "mayan.redis.host" . }}:{{ .Values.redis.redisPort }}/2"
{{- else -}}
MAYAN_CELERY_BROKER_URL: "{{ .Values.secrets.MAYAN_CELERY_BROKER_URL }}"
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Generate the Redis hostname
*/}}
{{- define "mayan.redis.host" -}}
{{ .Release.Name }}-redis-master
{{- end -}}

{{/*
Generate the MAYAN_CELERY_RESULT_BACKEND environment variable
*/}}
{{- define "mayan.secrets.celeryResultBackend" -}}
{{- if .Values.redis.enabled -}}
MAYAN_CELERY_RESULT_BACKEND: "redis://:{{ .Values.redis.password }}@{{ template "mayan.redis.host" . }}:{{ .Values.redis.redisPort }}/0"
{{- else -}}
MAYAN_CELERY_RESULT_BACKEND: "{{ .Values.secrets.MAYAN_CELERY_RESULT_BACKEND }}"
{{- end -}}
{{- end -}}

{{/*
Generate the MAYAN_DATABASES environment variable
*/}}
{{- define "mayan.secrets.databases" -}}
{{- if .Values.postgresql.enabled -}}
MAYAN_DATABASES: "{'default':{'ENGINE':'django.db.backends.postgresql','NAME':'{{ .Values.postgresql.postgresqlDatabase }}','PASSWORD':'{{ .Values.postgresql.postgresqlPassword }}','USER':'{{ .Values.postgresql.postgresqlUsername }}','HOST':'{{ template "mayan.postgresql.fullname" . }}'}}"
{{- else -}}
MAYAN_DATABASES: "{{ .Values.secrets.MAYAN_DATABASES }}"
{{- end -}}
{{- end -}}

{{/*
Generate the MAYAN_SEARCH_BACKEND_ARGUMENTS environment variable
*/}}
{{- define "mayan.secrets.searchBackendArguments" -}}
{{- if .Values.elasticsearch.enabled -}}
MAYAN_SEARCH_BACKEND_ARGUMENTS: "{'client_host':'{{ template "mayan.elasticsearch.fullname" . }}'}"
{{- else -}}
MAYAN_SEARCH_BACKEND_ARGUMENTS: "{{ .Values.secrets.MAYAN_SEARCH_BACKEND_ARGUMENTS }}"
{{- end -}}
{{- end -}}

{{/*
Generate the Minio hostname
*/}}
{{- define "mayan.minio.host" -}}
{{ .Release.Name }}-minio
{{- end -}}

{{/*
Generate the MAYAN_DOCUMENTS_FILE_STORAGE_BACKEND_ARGUMENTS environment variable
*/}}
{{- define "mayan.secrets.documentsFileStorageBackendArguments" -}}
{{- if eq .Values.persistence.documentsFileStorage.type "default" -}}
{{- else if eq .Values.persistence.documentsFileStorage.type "objectLocal" -}}
{{- if .Values.minio.enabled -}}
MAYAN_DOCUMENTS_FILE_STORAGE_BACKEND_ARGUMENTS: "{'endpoint_url':'http://{{ template "mayan.minio.host" . }}:{{ .Values.minio.service.port }}','access_key':'{{ .Values.minio.accessKey.password }}','secret_key':'{{ .Values.minio.secretKey.password }}','bucket_name':'{{ .Values.minio.defaultBuckets }}'}"
{{- else -}}
{{ fail "Must enable Minio to be able to use 'objectLocal' storage." }}
{{- end -}}
{{- else if eq .Values.persistence.documentsFileStorage.type "objectExternal" -}}
{{- if .Values.persistence.documentsFileStorage.argument -}}
MAYAN_DOCUMENTS_FILE_STORAGE_BACKEND_ARGUMENTS: "{{ .Values.persistence.documentsFileStorage.argument }}"
{{- else if .Values.persistence.documentsFileStorage.argumentMap -}}
MAYAN_DOCUMENTS_FILE_STORAGE_BACKEND_ARGUMENTS: "{
{{- range $key, $val := .Values.persistence.documentsFileStorage.argumentMap -}}
'{{ $key }}':'{{ $val }}',
{{- end -}}
}"
{{- end -}}
{{- else if eq .Values.persistence.documentsFileStorage.type "custom" -}}
{{- if .Values.persistence.documentsFileStorage.argument -}}
MAYAN_DOCUMENTS_FILE_STORAGE_BACKEND_ARGUMENTS: "{{ .Values.persistence.documentsFileStorage.argument }}"
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Generate the MAYAN_DOCUMENTS_FILE_PAGE_IMAGE_CACHE_STORAGE_BACKEND_ARGUMENTS environment variable
*/}}
{{- define "mayan.secrets.documentsFilePageImageCacheStorageBackendArguments" -}}
{{- if eq .Values.persistence.documentsFilePageImageCacheStorage.type "default" -}}
{{- else if eq .Values.persistence.documentsFilePageImageCacheStorage.type "objectLocal" -}}
{{- if .Values.minio.enabled -}}
MAYAN_DOCUMENTS_FILE_PAGE_IMAGE_CACHE_STORAGE_BACKEND_ARGUMENTS: "{'endpoint_url':'http://{{ template "mayan.minio.host" . }}:{{ .Values.minio.service.port }}','access_key':'{{ .Values.minio.accessKey.password }}','secret_key':'{{ .Values.minio.secretKey.password }}','bucket_name':'{{ .Values.minio.defaultBuckets }}'}"
{{- else -}}
{{ fail "Must enable Minio to be able to use 'objectLocal' storage." }}
{{- end -}}
{{- else if eq .Values.persistence.documentsFilePageImageCacheStorage.type "objectExternal" -}}
{{- if .Values.persistence.documentsFilePageImageCacheStorage.argument -}}
MAYAN_DOCUMENTS_FILE_PAGE_IMAGE_CACHE_STORAGE_BACKEND_ARGUMENTS: "{{ .Values.persistence.documentsFilePageImageCacheStorage.argument }}"
{{- else if .Values.persistence.documentsFilePageImageCacheStorage.argumentMap -}}
MAYAN_DOCUMENTS_FILE_PAGE_IMAGE_CACHE_STORAGE_BACKEND_ARGUMENTS: "{
{{- range $key, $val := .Values.persistence.documentsFilePageImageCacheStorage.argumentMap -}}
'{{ $key }}':'{{ $val }}',
{{- end -}}
}"
{{- end -}}
{{- else if eq .Values.persistence.documentsFilePageImageCacheStorage.type "custom" -}}
{{- if .Values.persistence.documentsFilePageImageCacheStorage.argument -}}
MAYAN_DOCUMENTS_FILE_PAGE_IMAGE_CACHE_STORAGE_BACKEND_ARGUMENTS: "{{ .Values.persistence.documentsFilePageImageCacheStorage.argument }}"
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Generate the MAYAN_DOCUMENTS_VERSION_PAGE_IMAGE_CACHE_STORAGE_BACKEND_ARGUMENTS environment variable
*/}}
{{- define "mayan.secrets.documentsVersionPageImageCacheStorageBackendArguments" -}}
{{- if eq .Values.persistence.documentsVersionPageImageCacheStorage.type "default" -}}
{{- else if eq .Values.persistence.documentsVersionPageImageCacheStorage.type "objectLocal" -}}
{{- if .Values.minio.enabled -}}
MAYAN_DOCUMENTS_VERSION_PAGE_IMAGE_CACHE_STORAGE_BACKEND_ARGUMENTS: "{'endpoint_url':'http://{{ template "mayan.minio.host" . }}:{{ .Values.minio.service.port }}','access_key':'{{ .Values.minio.accessKey.password }}','secret_key':'{{ .Values.minio.secretKey.password }}','bucket_name':'{{ .Values.minio.defaultBuckets }}'}"
{{- else -}}
{{ fail "Must enable Minio to be able to use 'objectLocal' storage." }}
{{- end -}}
{{- else if eq .Values.persistence.documentsVersionPageImageCacheStorage.type "objectExternal" -}}
{{- if .Values.persistence.documentsVersionPageImageCacheStorage.argument -}}
MAYAN_DOCUMENTS_VERSION_PAGE_IMAGE_CACHE_STORAGE_BACKEND_ARGUMENTS: "{{ .Values.persistence.documentsVersionPageImageCacheStorage.argument }}"
{{- else if .Values.persistence.documentsVersionPageImageCacheStorage.argumentMap -}}
MAYAN_DOCUMENTS_VERSION_PAGE_IMAGE_CACHE_STORAGE_BACKEND_ARGUMENTS: "{
{{- range $key, $val := .Values.persistence.documentsVersionPageImageCacheStorage.argumentMap -}}
'{{ $key }}':'{{ $val }}',
{{- end -}}
}"
{{- end -}}
{{- else if eq .Values.persistence.documentsVersionPageImageCacheStorage.type "custom" -}}
{{- if .Values.persistence.documentsVersionPageImageCacheStorage.argument -}}
MAYAN_DOCUMENTS_VERSION_PAGE_IMAGE_CACHE_STORAGE_BACKEND_ARGUMENTS: "{{ .Values.persistence.documentsVersionPageImageCacheStorage.argument }}"
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Generate the MAYAN_LOCK_MANAGER_BACKEND_ARGUMENTS environment variable
*/}}
{{- define "mayan.secrets.lockManagerBackendArguments" -}}
{{- if .Values.redis.enabled -}}
MAYAN_LOCK_MANAGER_BACKEND_ARGUMENTS: "{'redis_url':'redis://:{{ .Values.redis.password }}@{{ template "mayan.redis.host" . }}:{{ .Values.redis.redisPort }}/1'}"
{{- else -}}
MAYAN_LOCK_MANAGER_BACKEND_ARGUMENTS: "{{ .Values.secrets.MAYAN_LOCK_MANAGER_BACKEND_ARGUMENTS }}"
{{- end -}}
{{- end -}}
