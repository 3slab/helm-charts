{{/* vim: set filetype=mustache: */}}

{{/*
Return the container environment.
*/}}
{{- define "containers.env" -}}
{{- if .environment -}}
{{ "" }}
env:
{{ toYaml .environment | indent 2 -}}
{{- end -}}
{{- end -}}

{{/*
Return the complete image name.
*/}}
{{- define "containers.image" -}}
    {{- $registryName := .Values.image.registry | default "" -}}
    {{- $registryNameSeparator := "/" -}}
    {{- $imageTag := .Values.image.tag | default .Chart.AppVersion | toString -}}

    {{- if .Values.global }}
        {{- if .Values.global.imageRegistry }}
            {{- $registryName = .Values.global.imageRegistry -}}
        {{- end -}}
    {{- end -}}

    {{- if (not $registryName) }}
    {{- $registryNameSeparator = "" -}}
    {{- end -}}
{{- printf "image: %s%s%s:%s" $registryName $registryNameSeparator .Values.image.repository $imageTag -}}
{{- end -}}

{{/*
Return the complete container image register secrets.
*/}}
{{- define "containers.imagePullSecrets" -}}
    {{- $imagePullSecrets := list }}

    {{- if .Values.global -}}
        {{- range .Values.global.imagePullSecrets -}}
            {{- $imagePullSecrets = append $imagePullSecrets . -}}
        {{- end -}}
    {{- end -}}

    {{- range .Values.image.pullSecrets -}}
        {{- $imagePullSecrets = append $imagePullSecrets . -}}
    {{- end -}}

    {{- if (not (empty $imagePullSecrets)) }}
imagePullSecrets:
        {{- range $imagePullSecrets }}
  - name: {{ . }}
        {{- end }}
    {{- end }}
{{- end -}}
