{/* vim: set filetype=mustache: */}}

{{- define "mayan.configMapName" -}}
{{- $name := "mayan-edms" }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}-configmap
{{- end }}
{{- end }}

{{/*
Generate extra configuation, not managed by the _helpers
*/}}
{{- define "mayan.configuration.unmanaged" -}}
{{- $managedKeys := list "MAYAN_DOCUMENTS_FILE_STORAGE_BACKEND" "DOCUMENTS_FILE_PAGE_IMAGE_CACHE_STORAGE_BACKEND" "DOCUMENTS_VERSION_PAGE_IMAGE_CACHE_STORAGE_BACKEND" "MAYAN_PIP_INSTALLS" -}}
{{- range $key, $val := .Values.configuration -}}
{{- $keyFound := has $key $managedKeys -}}
{{- if not $keyFound -}}
{{ $key }}: {{ $val | quote }}
{{- "\n" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "mayan.configuration.managed" -}}
{{ include "mayan.configuration.documentsFileStorageBackend" . }}
{{ include "mayan.configuration.documentsVersionPageImageCacheStorageBackend" . }}
{{ include "mayan.configuration.pipInstalls" . }}
{{- end -}}

{{/*
Generate the MAYAN_DOCUMENTS_FILE_STORAGE_BACKEND environment variable
*/}}
{{- define "mayan.configuration.documentsFileStorageBackend" -}}
{{- if eq .Values.persistence.documentsFileStorage.type "default" -}}
{{- else if eq .Values.persistence.documentsFileStorage.type "objectLocal" -}}
{{- if .Values.minio.enabled -}}
MAYAN_DOCUMENTS_FILE_STORAGE_BACKEND: "storages.backends.s3boto3.S3Boto3Storage"
{{- else -}}
{{ fail "Must enable Minio to be able to use 'objectLocal' storage." }}
{{- end -}}
{{- else if eq .Values.persistence.documentsFileStorage.type "objectExternal"  -}}
MAYAN_DOCUMENTS_FILE_STORAGE_BACKEND: "storages.backends.s3boto3.S3Boto3Storage"
{{- else if eq .Values.persistence.documentsFileStorage.type "custom"  -}}
MAYAN_DOCUMENTS_FILE_STORAGE_BACKEND: "{{ .Values.persistence.documentsFileStorage.backend }}"
{{- end -}}
{{- end -}}

{{/*
Generate the DOCUMENTS_FILE_PAGE_IMAGE_CACHE_STORAGE_BACKEND environment variable
*/}}
{{- define "mayan.configuration.documentsFilePageImageCacheStorageBackend" -}}
{{- if eq .Values.persistence.documentsFilePageImageCacheStorage.type "default" -}}
{{- else if eq .Values.persistence.documentsFilePageImageCacheStorage.type "objectLocal" -}}
{{- if .Values.minio.enabled -}}
MAYAN_DOCUMENTS_FILE_PAGE_IMAGE_CACHE_STORAGE_BACKEND: "storages.backends.s3boto3.S3Boto3Storage"
{{- else -}}
{{ fail "Must enable Minio to be able to use 'objectLocal' storage." }}
{{- end -}}
{{- else if eq .Values.persistence.documentsFilePageImageCacheStorage.type "objectExternal"  -}}
MAYAN_DOCUMENTS_FILE_PAGE_IMAGE_CACHE_STORAGE_BACKEND: "storages.backends.s3boto3.S3Boto3Storage"
{{- else if eq .Values.persistence.documentsFilePageImageCacheStorage.type "custom"  -}}
MAYAN_DOCUMENTS_FILE_PAGE_IMAGE_CACHE_STORAGE_BACKEND: "{{ .Values.persistence.documentsFilePageImageCacheStorage.backend }}"
{{- end -}}
{{- end -}}

{{/*
Generate the DOCUMENTS_VERSION_PAGE_IMAGE_CACHE_STORAGE_BACKEND environment variable
*/}}
{{- define "mayan.configuration.documentsVersionPageImageCacheStorageBackend" -}}
{{- if eq .Values.persistence.documentsVersionPageImageCacheStorage.type "default" -}}
{{- else if eq .Values.persistence.documentsVersionPageImageCacheStorage.type "objectLocal" -}}
{{- if .Values.minio.enabled -}}
MAYAN_DOCUMENTS_VERSION_PAGE_IMAGE_CACHE_STORAGE_BACKEND: "storages.backends.s3boto3.S3Boto3Storage"
{{- else -}}
{{ fail "Must enable Minio to be able to use 'objectLocal' storage." }}
{{- end -}}
{{- else if eq .Values.persistence.documentsVersionPageImageCacheStorage.type "objectExternal"  -}}
MAYAN_DOCUMENTS_VERSION_PAGE_IMAGE_CACHE_STORAGE_BACKEND: "storages.backends.s3boto3.S3Boto3Storage"
{{- else if eq .Values.persistence.documentsVersionPageImageCacheStorage.type "custom"  -}}
MAYAN_DOCUMENTS_VERSION_PAGE_IMAGE_CACHE_STORAGE_BACKEND: "{{ .Values.persistence.documentsVersionPageImageCacheStorage.backend }}"
{{- end -}}
{{- end -}}

{{- define "mayan.configuration.pipInstalls" -}}
{{- $objectStorageTypes := list "objectLocal" "objectExternal" -}}
MAYAN_PIP_INSTALLS: "{{ .Values.configuration.MAYAN_PIP_INSTALLS }}{{- if or (has .Values.persistence.documentsFileStorage.type $objectStorageTypes) (has .Values.persistence.documentsFilePageImageCacheStorage.type $objectStorageTypes) (has .Values.persistence.documentsVersionPageImageCacheStorage.type $objectStorageTypes) }} django-storages==1.10 boto3==1.14.58{{- end -}}"
{{- end -}}
