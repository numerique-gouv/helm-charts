{{/*
Grist env vars taking into account forward auth

Requires array with top level scope and docWorker or homeWorker scopes
*/}}
{{- define "grist.common.env" -}}
{{- $topLevelScope := index . 0 -}}
{{- $workerScope := index . 1 -}}
{{- if $topLevelScope.Values.forwardAuth.enabled | and $topLevelScope.Values.forwardAuth.enabled }}
{{- $envVars := include "common.env.transformDict" (merge (deepCopy $workerScope.envVars) (dict "GRIST_FORWARD_AUTH_HEADER" "X-Forwarded-User")) -}}
{{- else -}}
{{- $envVars := include "common.env.transformDict" $workerScope.envVars -}}
{{- end }}
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
{{- include "common.labels" $topLevelScope }}
app.kubernetes.io/component: {{ $component }}
{{- end }}

{{/*
Worker selector labels

Requires array with top level scope and component name
*/}}
{{- define "grist.common.selectorLabels" -}}
{{- $topLevelScope := index . 0 -}}
{{- $component := index . 1 -}}
{{- include "common.selectorLabels" $topLevelScope }}
app.kubernetes.io/component: {{ $component }}
{{- end }}

{{/*
Full name for the load balancer

Requires top level scope
*/}}
{{- define "grist.lb.fullname" -}}
{{ include "common.fullname" . }}-lb
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
{{ include "common.fullname" . }}-home-wk
{{- end }}

{{/*
Full name for the doc worker

Requires top level scope
*/}}
{{- define "grist.doc.fullname" -}}
{{ include "common.fullname" . }}-doc-wk
{{- end }}

{{/*
Full name for the doc worker init

Requires top level scope
*/}}
{{- define "grist.doc.init" -}}
{{ include "grist.doc.fullname" . }}-init
{{- end }}
