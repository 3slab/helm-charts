{/* vim: set filetype=mustache: */}}

{{- define "pvcs.persistentVolumeClaimName" -}}
{{- printf "%s-%s" .Release.Name "mayan-media" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return the Storage Class name.
*/}}
{{- define "pvcs.storageClass" -}}
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
