{{/*
Return the chart name.
*/}}
{{- define "memcached.name" -}}
{{ .Chart.Name }}
{{- end -}}

{{/*
Return the fullname (release name + chart name)
*/}}
{{- define "memcached.fullname" -}}
{{ printf "%s-%s" .Release.Name (include "memcached.name" .) | trunc 63 | trimSuffix "-" }}
{{- end -}}
