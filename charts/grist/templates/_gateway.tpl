{{/*
Helpers shared by the Gateway API / Envoy Gateway resources
(ListenerSet, HTTPRoute, SecurityPolicy, BackendTrafficPolicy).
*/}}

{{/*
Namespace of a Gateway API resource, defaulting to the release namespace.

Requires array with the resource scope and the top level scope
Usage : {{ include "envoy-gateway-app.namespace" (list . $) }}
*/}}
{{- define "envoy-gateway-app.namespace" -}}
{{- $resource := index . 0 -}}
{{- $topLevelScope := index . 1 -}}
{{- default $topLevelScope.Release.Namespace $resource.namespace -}}
{{- end }}

{{/*
Common labels for the Gateway API resources

Requires top level scope
*/}}
{{- define "envoy-gateway-app.labels" -}}
{{- include "grist.labels" . -}}
{{- end }}

{{/*
Merge the global annotations with the per resource ones, the latter taking precedence.
Renders nothing when both are empty so the caller can wrap it in a `with`.

Usage : {{ include "envoy-gateway-app.annotations" (dict "globalAnnotations" $.Values.global.annotations "localAnnotations" .annotations) }}
*/}}
{{- define "envoy-gateway-app.annotations" -}}
{{- $annotations := merge (dict) (default (dict) .localAnnotations) (default (dict) .globalAnnotations) -}}
{{- with $annotations -}}
{{- toYaml . -}}
{{- end -}}
{{- end }}

{{/*
A single entry of an HTTPRoute `parentRefs` list, rendered as a YAML list item.

Requires a parentRef scope
*/}}
{{- define "envoy-gateway-app.parentRef" -}}
- name: {{ .name }}
  {{- with .namespace }}
  namespace: {{ . }}
  {{- end }}
  kind: {{ .kind | default "Gateway" }}
  group: {{ .group | default "gateway.networking.k8s.io" }}
  {{- with .sectionName }}
  sectionName: {{ . }}
  {{- end }}
  {{- with .port }}
  port: {{ . }}
  {{- end }}
{{- end }}

{{/*
`targetRef` stanza of an Envoy Gateway policy.

Requires a targetRef scope
*/}}
{{- define "envoy-gateway-app.targetRef" -}}
targetRef:
  group: {{ .group | default "gateway.networking.k8s.io" }}
  kind: {{ .kind | default "HTTPRoute" }}
  name: {{ .name }}
  {{- with .sectionName }}
  sectionName: {{ . }}
  {{- end }}
{{- end }}

{{/*
`targetRefs` stanza of an Envoy Gateway policy.

Requires a list of targetRef scopes
*/}}
{{- define "envoy-gateway-app.targetRefs" -}}
targetRefs:
{{- range . }}
  - group: {{ .group | default "gateway.networking.k8s.io" }}
    kind: {{ .kind | default "HTTPRoute" }}
    name: {{ .name }}
    {{- with .sectionName }}
    sectionName: {{ . }}
    {{- end }}
{{- end }}
{{- end }}

{{/*
HTTPRoute filters, passed through as-is so any filter type supported by the
Gateway API can be configured from the values.

Requires a list of filter scopes
*/}}
{{- define "envoy-gateway-app.httpFilters" -}}
{{- toYaml . -}}
{{- end }}
