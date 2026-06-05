{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if .Values.containerNameSuffix -}}
{{- printf "%s-%s-%s" .Release.Name .Values.containerNameSuffix $name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Return the appropriate apiVersion for deployment.
*/}}
{{- define "deployment.apiVersion" -}}
{{- if semverCompare "<1.9-0" .Capabilities.KubeVersion.GitVersion -}}
{{- print "apps/v1beta2" -}}
{{- else -}}
{{- print "apps/v1" -}}
{{- end -}}
{{- end -}}

{{/*
Return the appropriate apiVersion for ingress.
*/}}
{{- define "ingress.apiVersion" -}}
{{- if semverCompare "<1.14-0" .Capabilities.KubeVersion.GitVersion -}}
{{- print "extensions/v1beta1" -}}
{{- else if semverCompare "<1.19-0" .Capabilities.KubeVersion.GitVersion -}}
{{- print "networking.k8s.io/v1beta1" -}}
{{- else -}}
{{- print "networking.k8s.io/v1" -}}
{{- end -}}
{{- end -}}

{{/*
Return custom name for job or release-job
*/}}
{{- define "jobFullname" -}}
{{- if .Values.job.nameOverride -}}
{{- print .Values.job.nameOverride -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name .Values.job.name -}}
{{- end -}}
{{- end -}}


{{/*
Returns true if the ingressClassname field is supported
Usage:
include "common.ingress.supportsIngressClassname" .
*/}}
{{- define "common.ingress.supportsIngressClassname" -}}
{{- if semverCompare "<1.18-0" .Capabilities.KubeVersion.GitVersion -}}
{{- print "false" -}}
{{- else -}}
{{- print "true" -}}
{{- end -}}
{{- end -}}



{{/*
Env var rendering and merging logic
*/}}


{{- define "render-env-var" -}}
- name: {{ .env.name }}
{{- if .env.typeSecret }}
  valueFrom:
    secretKeyRef:
      name: {{ .env.secretKeyRef.name }}
      key: {{ .env.secretKeyRef.key }}
{{- else if .env.valueFrom }}
{{- if .env.valueFrom.secretKeyRef }}
  valueFrom:
    secretKeyRef:
      name: {{ .env.valueFrom.secretKeyRef.name }}
      key: {{ .env.valueFrom.secretKeyRef.key }}
{{- else if .env.valueFrom.fieldRef }}
  valueFrom:
    fieldRef:
      fieldPath: {{ .env.valueFrom.fieldRef.fieldPath }}
{{- end }}
{{- else }}
  value: {{ .env.value | quote }}
{{- end }}
{{- end -}}

{{- define "render-env-list" -}}
{{- if .envList }}
{{- range $env := .envList }}
{{ include "render-env-var" (dict "env" $env) }}
{{- end }}
{{- end }}
{{- end -}}



{{- define "merge-env-lists" -}}
{{- $containerEnv := .containerEnv | default list -}}
{{- $serviceEnv   := .serviceEnv   | default list -}}
{{- $extraEnv     := .extraEnv     | default list -}}

{{- $envMap := dict -}}
{{- $seen   := list -}}

{{- range $env := $containerEnv -}}
  {{- if not (has $env.name $seen) -}}
    {{- $seen = append $seen $env.name -}}
  {{- end -}}
  {{- $_ := set $envMap $env.name $env -}}
{{- end -}}

{{- range $env := $serviceEnv -}}
  {{- if not (has $env.name $seen) -}}
    {{- $seen = append $seen $env.name -}}
  {{- end -}}
  {{- $_ := set $envMap $env.name $env -}}
{{- end -}}

{{- range $env := $extraEnv -}}
  {{- if not (has $env.name $seen) -}}
    {{- $seen = append $seen $env.name -}}
  {{- end -}}
  {{- $_ := set $envMap $env.name $env -}}
{{- end -}}

{{- $sanitized := list -}}
{{- range $name := $seen -}}
  {{- $env := get $envMap $name -}}
  {{- if $env.valueFrom -}}
    {{- $sanitized = append $sanitized (dict "name" $env.name "valueFrom" $env.valueFrom) -}}
  {{- else if $env.secretKeyRef -}}
    {{- $sanitized = append $sanitized (dict "name" $env.name "valueFrom" (dict "secretKeyRef" $env.secretKeyRef)) -}}
  {{- else -}}
    {{- $sanitized = append $sanitized (dict "name" $env.name "value" ($env.value | toString)) -}}
  {{- end -}}
{{- end -}}

{{- if $sanitized -}}
{{- $sanitized | toYaml -}}
{{- end -}}
{{- end -}}



