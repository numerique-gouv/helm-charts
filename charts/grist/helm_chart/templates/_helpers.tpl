{{/*
Expand the name of the chart.
*/}}
{{- define "grist.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "grist.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "grist.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
grist.labels
*/}}
{{- define "grist.labels" -}}
helm.sh/chart: {{ include "grist.chart" . }}
{{ include "grist.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "grist.selectorLabels" -}}
app.kubernetes.io/name: {{ include "grist.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
transform dictionnary of environment variables
Usage : {{ include "grist.env.transformDict" .Values.envVars }}

Example:
envVars:
  # Using simple strings as env vars
  ENV_VAR_NAME: "envVar value"
  # Using a value from a configMap
  ENV_VAR_FROM_CM:
    configMapKeyRef:
      name: cm-name
      key: "key_in_cm"
  # Using a value from a secret
  ENV_VAR_FROM_SECRET:
    secretKeyRef:
      name: secret-name
      key: "key_in_secret"
*/}}
{{- define "grist.env.transformDict" -}}
{{- range $key, $value := . }}
- name: {{ $key | quote }}
{{- if $value | kindIs "map" }}
  valueFrom: {{ $value | toYaml | nindent 4 }}
{{- else }}
  value: {{ $value | quote }}
{{- end }}
{{- end }}
{{- end }}


{{/*
Grist env vars taking into account forward auth

Requires array with top level scope and docWorker or homeWorker scopes
*/}}
{{- define "grist.common.env" -}}
{{- $topLevelScope := index . 0 -}}
{{- $workerScope := index . 1 -}}
{{- include "grist.env.transformDict" $workerScope.envVars -}}
{{- end }}

{{/*
Doc worker unique name

Requires array with top level scope and doc worker index
*/}}
{{- define "grist.docworker.uniquename" -}}
{{- $topLevelScope := index . 0 -}}
{{- $index := index . 1 -}}
{{ include "grist.doc.fullname" $topLevelScope }}-{{ $index }}
{{- end }}

{{/*
Worker labels

Requires array with top level scope and component name
*/}}
{{- define "grist.common.labels" -}}
{{- $topLevelScope := index . 0 -}}
{{- $component := index . 1 -}}
{{- include "grist.labels" $topLevelScope }}
app.kubernetes.io/component: {{ $component }}
{{- end }}

{{/*
Worker selector labels

Requires array with top level scope and component name
*/}}
{{- define "grist.common.selectorLabels" -}}
{{- $topLevelScope := index . 0 -}}
{{- $component := index . 1 -}}
{{- include "grist.selectorLabels" $topLevelScope }}
app.kubernetes.io/component: {{ $component }}
{{- end }}

{{- define "grist.probes.abstract" -}}
{{- if .exec -}}
exec:
{{- toYaml .exec | nindent 2 }}
{{- else if .tcpSocket -}}
tcpSocket:
{{- toYaml .tcpSocket | nindent 2 }}
{{- else -}}
httpGet:
  path: {{ .path }}
  port: {{ .targetPort }}
{{- end }}
initialDelaySeconds: {{ .initialDelaySeconds | eq nil | ternary 0 .initialDelaySeconds }}
timeoutSeconds: {{ .timeoutSeconds | eq nil | ternary 1 .timeoutSeconds }}
{{- end }}

{{/*
Full name for the load balancer

Requires top level scope
*/}}
{{- define "grist.lb.fullname" -}}
{{ include "grist.fullname" . }}-lb
{{- end }}
{{/*
Full name for the load balancer config

Requires top level scope
*/}}
{{- define "grist.lb.config" -}}
{{ include "grist.lb.fullname" . }}-config
{{- end }}

{{/*
Full name for the home worker

Requires top level scope
*/}}
{{- define "grist.home.fullname" -}}
{{ include "grist.fullname" . }}-home-wk
{{- end }}

{{/*
Full name for the doc worker

Requires top level scope
*/}}
{{- define "grist.doc.fullname" -}}
{{ include "grist.fullname" . }}-doc-wk
{{- end }}


{{- define "grist.secret.dockerconfigjson.data" }}
{{- printf "{\"auths\":{\"%s\":{\"username\":\"%s\",\"password\":\"%s\",\"auth\":\"%s\"}}}" .registry .username .password (printf "%s:%s" .username .password | b64enc) | b64enc }}
{{- end }}

{{/*
Usage : {{ include "grist.secret.dockerconfigjson.name" (dict "fullname" (include "grist.fullname" .) "imageCredentials" .Values.path.to.the.image1) }}
*/}}
{{- define "grist.secret.dockerconfigjson.name" }}
{{- if (default (dict) .imageCredentials).name }}{{ .imageCredentials.name }}{{ else }}{{ .fullname | trunc 63 | trimSuffix "-" }}-dockerconfig{{ end -}}
{{- end }}

{{/*
Usage : {{ include "grist.secret.dockerconfigjson" (dict "fullname" (include "grist.fullname" .) "imageCredentials" .Values.path.to.the.image1) }}
*/}}
{{- define "grist.secret.dockerconfigjson" }}
{{- if .imageCredentials -}}
apiVersion: v1
kind: Secret
metadata:
  name: {{ template "grist.secret.dockerconfigjson.name" (dict "fullname" .fullname "imageCredentials" .imageCredentials) }}
  annotations:
    "helm.sh/hook": pre-install,pre-upgrade
    "helm.sh/hook-weight": "-5"
    "helm.sh/hook-delete-policy": before-hook-creation
type: kubernetes.io/dockerconfigjson
data:
  .dockerconfigjson: {{ template "grist.secret.dockerconfigjson.data" .imageCredentials }}
{{- end -}}
{{- end }}

