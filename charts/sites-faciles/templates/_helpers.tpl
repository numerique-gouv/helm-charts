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
  value: "{{ .Values.containerPort }}"
{{- if .Values.postgresql.enabled }}
- name: DATABASE_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ .Values.postgresql.auth.existingSecret | default .Values.postgresql.fullnameOverride | default "sites-faciles-postgresql" }}
      key: postgres-password
- name: DATABASE_URL
  value: {{ printf "postgresql://%s:$(DATABASE_PASSWORD)@%s:5432/%s" .Values.postgresql.auth.username (.Values.postgresql.fullnameOverride | default "sites-faciles-postgresql") (.Values.postgresql.auth.database | default .Values.postgresql.auth.username) | quote }}
{{- end }}
{{- if not .Values.config.djangoSuperuserEmail }}
- name: DJANGO_SUPERUSER_EMAIL
  valueFrom:
    secretKeyRef:
      name: {{ printf "%s-%s" (include "helper.fullname" .) "admin" }}
      key: DJANGO_SUPERUSER_EMAIL
{{- end }}
{{- if not .Values.config.djangoSuperuserUsername }}
- name: DJANGO_SUPERUSER_USERNAME
  valueFrom:
    secretKeyRef:
      name: {{ printf "%s-%s" (include "helper.fullname" .) "admin" }}
      key: DJANGO_SUPERUSER_USERNAME
{{- end }}
{{- if not .Values.config.djangoSuperuserPassword }}
- name: DJANGO_SUPERUSER_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ printf "%s-%s" (include "helper.fullname" .) "admin" }}
      key: DJANGO_SUPERUSER_PASSWORD
{{- end }}
{{- if not .Values.config.secretKey }}
- name: SECRET_KEY
  valueFrom:
    secretKeyRef:
      name: {{ printf "%s-%s" (include "helper.fullname" .) "admin" }}
      key: SECRET_KEY
{{- end }}
{{- range $key, $val := .Values.config }}
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
Selector labels
*/}}
{{- define "helper.selectorLabels" -}}
app.kubernetes.io/name: {{ include "helper.fullname" . | trunc 63 | trimSuffix "-" }}
app.kubernetes.io/instance: {{ .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end -}}

{{/*
App labels
*/}}
{{- define "helper.labels" -}}
{{ include "helper.commonLabels" . }}
{{ include "helper.selectorLabels" . }}
{{- end -}}
