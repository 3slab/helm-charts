{{- define "simple-job.fullname" -}}
{{- printf "%s" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "simple-job.labels" -}}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
app.kubernetes.io/name: simple-job
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/* Validation : image.repository est obligatoire */}}
{{- define "simple-job.validateImage" -}}
{{- if eq .Values.image.repository "" }}
{{- fail "ERREUR : image.repository est requis. Exemple : --set image.repository=python --set image.tag=3.12-alpine" }}
{{- end }}
{{- end }}
