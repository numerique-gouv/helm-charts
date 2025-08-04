{{/*
Expand the name of the chart.
*/}}
{{- define "helper.name" -}}
{{- (.Values.nameOverride | default .Chart.Name) | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "helper.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := .Values.nameOverride | default .Chart.Name }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- (printf "%s-%s" .Release.Name $name) | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "helper.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create image pull secret
*/}}
{{- define "helper.imagePullSecret" }}
{{- $registry := .registry -}}
{{- $username := .username -}}
{{- $password := .password -}}
{{- $email := .email -}}
{{- printf "{\"auths\":{\"%s\":{\"username\":\"%s\",\"password\":\"%s\",\"email\":\"%s\",\"auth\":\"%s\"}}}" $registry $username $password $email (printf "%s:%s" $username $password | b64enc) | b64enc }}
{{- end }}

{{/*
Create container environment variables from configmap
*/}}
{{- define "helper.env" -}}
{{ range $key, $val := .env }}
{{ $key }}: {{ tpl (toYaml $val) . }}
{{- end }}
{{- end }}

{{/*
Create container environment variables from secret
*/}}
{{- define "helper.secret" -}}
{{ range $key, $val := .secrets }}
{{ $key }}: {{ tpl (toYaml $val) . | b64enc }}
{{- end }}
{{- end }}

{{/*
Create container environment variables from config values
*/}}
{{- define "helper.config" -}}
- name: CONTAINER_PORT
  value: "{{ .Values.app.containerPort }}"
{{- if .Values.cnpgCluster.enabled }}
- name: DATABASE_URL
  valueFrom:
    secretKeyRef:
      name: {{ printf "%s-%s" .Values.cnpgCluster.fullnameOverride "infos" }}
      key: DATABASE_URL
{{- end }}
{{- if not .Values.app.config.djangoSuperuserEmail }}
- name: DJANGO_SUPERUSER_EMAIL
  valueFrom:
    secretKeyRef:
      name: {{ printf "%s-%s" (include "helper.fullname" .) "admin" }}
      key: DJANGO_SUPERUSER_EMAIL
{{- end }}
{{- if not .Values.app.config.djangoSuperuserUsername }}
- name: DJANGO_SUPERUSER_USERNAME
  valueFrom:
    secretKeyRef:
      name: {{ printf "%s-%s" (include "helper.fullname" .) "admin" }}
      key: DJANGO_SUPERUSER_USERNAME
{{- end }}
{{- if not .Values.app.config.djangoSuperuserPassword }}
- name: DJANGO_SUPERUSER_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ printf "%s-%s" (include "helper.fullname" .) "admin" }}
      key: DJANGO_SUPERUSER_PASSWORD
{{- end }}
{{- if not .Values.app.config.secretKey }}
- name: SECRET_KEY
  valueFrom:
    secretKeyRef:
      name: {{ printf "%s-%s" (include "helper.fullname" .) "admin" }}
      key: SECRET_KEY
{{- end }}
{{- range $key, $val := .Values.app.config }}
{{- if kindIs "map" $val }}
{{- if $val.valueFrom }}
- name: {{ $key | snakecase | upper | quote }}
  {{- if $val.valueFrom.secretKeyRef }}
  valueFrom:
    secretKeyRef:
      name: {{ $val.valueFrom.secretKeyRef.name | quote }}
      key: {{ $val.valueFrom.secretKeyRef.key | quote }}
  {{- else if $val.valueFrom.configMapKeyRef }}
  valueFrom:
    configMapKeyRef:
      name: {{ $val.valueFrom.configMapKeyRef.name | quote }}
      key: {{ $val.valueFrom.configMapKeyRef.key | quote }}
  {{- end }}
{{- end }}
{{- else if $val }}
- name: {{ $key | snakecase | upper | quote }}
  value: {{ (tpl (toYaml $val) .) | trimPrefix "'" | trimSuffix "'" | quote }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Define a file checksum to trigger rollout on configmap of secret change
*/}}
{{- define "helper.checksum" -}}
{{- $ := index . 0 }}
{{- $path := index . 1 }}
{{- $resourceType := include (print $.Template.BasePath $path) $ | fromYaml -}}
{{- if $resourceType -}}
checksum/{{ $resourceType.kind | lower }}-{{ $resourceType.metadata.name }}: {{ $resourceType.data | toYaml | sha256sum }}
{{- end -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "helper.commonLabels" -}}
helm.sh/chart: {{ include "helper.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Generic selector labels
Parameters:
- $root: The root context
- $componentName: The name of the component for which the selector labels are being generated
*/}}
{{- define "helper.selectorLabels" -}}
{{- $root := .root | default $ -}}
{{- $componentName := .componentName | default "app" -}}
app.kubernetes.io/name: {{ printf "%s-%s" (include "helper.fullname" $root) $componentName | trunc 63 | trimSuffix "-" }}
app.kubernetes.io/instance: {{ $root.Release.Name | trunc 63 | trimSuffix "-" }}
{{- end -}}

{{/*
Generic app labels
Parameters:
- $root: The root context
- $componentName: The name of the component for which the selector labels are being generated
*/}}
{{- define "helper.labels" -}}
{{- $root := .root -}}
{{- $componentName := .componentName | default "app" -}}
{{ include "helper.commonLabels" $root }}
{{ include "helper.selectorLabels" (dict "root" $root "componentName" $componentName) }}
{{- end -}}
