{/* vim: set filetype=mustache: */}}

{{- define "pvs.persistentVolumeName" -}}
{{- printf "%s-%s" .Release.Name "mayan-media" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
