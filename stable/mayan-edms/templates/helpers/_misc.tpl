{/* vim: set filetype=mustache: */}}

{{/*
Selector labels with name suffix
*/}}
{{- define "mayan.selectorLabelsWithSuffix" -}}
app.kubernetes.io/name: {{ include "mayan.name" .root }}-{{- printf "%s" .nameSuffix -}}
{{ printf "\n" }}app.kubernetes.io/instance: {{- printf " %s" .root.Release.Name -}}
{{- end }}
