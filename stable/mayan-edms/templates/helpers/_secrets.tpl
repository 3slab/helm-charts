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
{{- range $key, $val := .Values.secrets -}}
{{ $key }}: {{ $val | quote }}
{{- "\n" -}}
{{- end -}}
{{- end -}}
