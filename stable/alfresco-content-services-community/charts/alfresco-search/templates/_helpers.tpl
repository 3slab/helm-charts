{{/*
THE TEMPLATES DEFINED BELOW WILL BE USED BY OTHER CHARTS.
"alfresco-search" IS THE CHART NAME. THE VALUE HAS TO BE HARD CODED.
".Chart.Name" CANNOT BE USED FOR THESE TEMPLATES AS THE TEMPLATE WILL BE REFERENCED FROM OTHER CHARTS.
*/}}

{{/*
Get Alfresco Search Full Name
*/}}
{{- define "alfresco-search.fullName" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Get Alfresco Search Host
*/}}
{{- define "alfresco-search.host" -}}
{{- printf "%s-%s-%s" .Release.Name "alfresco-search" "solr" -}}
{{- end -}}

{{/*
Get Alfresco Search Port
*/}}
{{- define "alfresco-search.port" -}}
{{- print (index .Values "alfresco-search" "service" "externalPort") -}}
{{- end -}}

{{/* ======================================================================== */}}

{{/* THE TEMPLATES DEFINED BELOW ARE SUPPOSSED TO BE USED FOR THIS CHART ONLY */}}

{{/*
Get Alfresco Search Internal Port
*/}}
{{- define "alfresco-search.internalPort" -}}
{{- if and (.Values.type) (eq (.Values.type | toString) "insight-engine") }}
{{- print .Values.insightEngineImage.internalPort -}}
{{- else }}
{{- print .Values.searchServicesImage.internalPort -}}
{{- end }}
{{- end -}}

{{/*
Get Alfresco Search Pull Policy
*/}}
{{- define "alfresco-search.pullPolicy" -}}
{{- if and (.Values.type) (eq (.Values.type | toString) "insight-engine") }}
{{- print .Values.insightEngineImage.pullPolicy -}}
{{- else }}
{{- print .Values.searchServicesImage.pullPolicy -}}
{{- end }}
{{- end -}}

{{/*
Get Alfresco Search Docker Image
*/}}
{{- define "alfresco-search.dockerImage" -}}
{{- if and (.Values.type) (eq (.Values.type | toString) "insight-engine") }}
{{- printf "%s:%s" .Values.insightEngineImage.repository .Values.insightEngineImage.tag -}}
{{- else }}
{{- printf "%s:%s" .Values.searchServicesImage.repository .Values.searchServicesImage.tag -}}
{{- end }}
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