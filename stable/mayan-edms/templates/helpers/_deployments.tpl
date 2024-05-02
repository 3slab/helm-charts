{/* vim: set filetype=mustache: */}}

{{/*
Return the aggregated deployment affinity.
*/}}
{{- define "deployments.affinity" -}}
    {{- $localAffinity := .local.affinity | default (dict) -}}
    {{- $rootAffinity := .root.Values.affinity | default (dict) -}}
    {{- $deploymentAffinity := merge $localAffinity $rootAffinity -}}

{{ "" }}

affinity: {{- toYaml $deploymentAffinity | nindent 2 -}}
{{- end -}}

{{/*
Return the aggregated worker deployment affinity.
*/}}
{{- define "deployments.workers.affinity" -}}
    {{- $localAffinity := .local.affinity | default (dict) -}}
    {{- $workerDefaultAffinity := .root.Values.workerDefaults.affinity | default (dict) -}}
    {{- $rootAffinity := .root.Values.affinity | default (dict) -}}
    {{- $deploymentAffinity := merge $localAffinity $workerDefaultAffinity $rootAffinity -}}

{{ "" }}

affinity: {{- toYaml $deploymentAffinity | nindent 2 -}}
{{- end -}}
