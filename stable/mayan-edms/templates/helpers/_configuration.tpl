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
Generate extra configuration, not managed by the _helpers
*/}}
{{- define "mayan.configuration.unmanaged" -}}
{{- range $key, $val := .Values.configuration -}}
{{ $key }}: {{ $val | quote }}
{{- "\n" -}}
{{- end -}}
{{- end -}}
