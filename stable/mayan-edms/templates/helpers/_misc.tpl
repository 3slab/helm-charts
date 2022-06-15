{/* vim: set filetype=mustache: */}}

{{/*
Selector labels with name suffix
*/}}
{{- define "mayan.selectorLabelsWithSuffix" -}}
app.kubernetes.io/name: {{ include "mayan.name" .root }}-{{- printf "%s" .nameSuffix -}}
{{ printf "\n" }}app.kubernetes.io/instance: {{- printf " %s" .root.Release.Name -}}
{{- end }}

{{- define "mayan.elasticsearch.fullname" -}}
{{- if .Values.elasticsearch.fullnameOverride -}}
{{- .Values.elasticsearch.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default "elasticsearch-master" .Values.elasticsearch.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "mayan.postgresql.fullname" -}}
{{- if .Values.postgresql.fullnameOverride -}}
{{- .Values.postgresql.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default "postgresql" .Values.postgresql.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "mayan.persistentVolumeClaimName" -}}
{{- printf "%s-%s" .Release.Name "mayan-media" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "mayan.persistentVolumeName" -}}
{{- printf "%s-%s" .Release.Name "mayan-media" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
{{- define "mayan.persistentVolumePath" -}}
{{- printf "/%s/%s/%s" "data" "mayan-media" .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
*/}}

{{/*
Return the proper Storage Class
*/}}
{{- define "mayan.storageClass" -}}
{{/*
Helm 2.11 supports the assignment of a value to a variable defined in a different scope,
but Helm 2.9 and 2.10 does not support it, so we need to implement this if-else logic.
*/}}
{{- if .Values.global -}}
    {{- if .Values.global.storageClass -}}
        {{- if (eq "-" .Values.global.storageClass) -}}
            {{- printf "storageClassName: \"\"" -}}
        {{- else }}
            {{- printf "storageClassName: %s" .Values.global.storageClass -}}
        {{- end -}}
    {{- else -}}
        {{- if .Values.persistence.core.storageClass -}}
              {{- if (eq "-" .Values.persistence.core.storageClass) -}}
                  {{- printf "storageClassName: \"\"" -}}
              {{- else }}
                  {{- printf "storageClassName: %s" .Values.persistence.core.storageClass -}}
              {{- end -}}
        {{- end -}}
    {{- end -}}
{{- else -}}
    {{- if .Values.persistence.core.storageClass -}}
        {{- if (eq "-" .Values.persistence.core.storageClass) -}}
            {{- printf "storageClassName: \"\"" -}}
        {{- else }}
            {{- printf "storageClassName: %s" .Values.persistence.core.storageClass -}}
        {{- end -}}
    {{- end -}}
{{- end -}}
{{- end -}}

{{/*
Generate an unique name for each domain of a release
*/}}
{{- define "mayan.tlsUniqueName" -}}
{{ include "mayan.fullname" . }}-{{ .Values.letsencrypt.domain | replace "." "-" }}-{{- if .Values.letsencrypt.production }}production{{ else }}staging{{- end }}
{{- end }}

{{/*
Generate an unique secret name for each domain of a release
*/}}
{{- define "mayan.tlsSecretUniqueName" -}}
secret-{{ include "mayan.fullname" . }}-{{ .Values.letsencrypt.domain | replace "." "-" }}-{{- if .Values.letsencrypt.production }}production{{ else }}staging{{- end }}
{{- end }}
