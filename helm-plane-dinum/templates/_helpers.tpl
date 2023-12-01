{{- define "imagePullSecret" }}
{{- printf "{\"auths\":{\"index.docker.io/v1/\":{\"username\":\"%s\",\"password\":\"%s\"}}}" .Values.dockerhub.loginid .Values.dockerhub.password | b64enc }}
{{- end }}