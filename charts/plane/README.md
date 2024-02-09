# Plane helm chart

## Parameters

### General configuration

| Name                                  | Description                                          | Value                     |
| ------------------------------------- | ---------------------------------------------------- | ------------------------- |
| `image.repository`                    | Repository to use to pull plane's container image    | `makeplane/plane-backend` |
| `image.tag`                           | plane's container tag                                | `latest`                  |
| `image.pullPolicy`                    | Container image pull policy                          | `IfNotPresent`            |
| `image.credentials.username`          | Username for container registry authentication       |                           |
| `image.credentials.password`          | Password for container registry authentication       |                           |
| `image.credentials.registry`          | Registry url for which the credentials are specified |                           |
| `image.credentials.name`              | Name of the generated secret for imagePullSecrets    |                           |
| `nameOverride`                        | Override the chart name                              | `""`                      |
| `fullnameOverride`                    | Override the full application name                   | `""`                      |
| `ingress.enabled`                     | whether to enable the Ingress or not                 | `true`                    |
| `ingress.className`                   | IngressClass to use for the Ingress                  | `nil`                     |
| `ingress.host`                        | Host for the Ingress                                 | `plane.example.com`       |
| `ingress.path`                        | Path to use for the Ingress                          | `/`                       |
| `ingress.hosts`                       | Additionnal host to configure for the Ingress        | `[]`                      |
| `ingress.tls.enabled`                 | Wether to enable TLS for the Ingress                 | `true`                    |
| `ingress.tls.additional[].secretName` | Secret name for additional TLS config                |                           |
| `ingress.tls.additional[].hosts[]`    | Hosts for additional TLS config                      |                           |
| `ingress.customBackends`              | Add custom backends to ingress                       | `[]`                      |

### api

| Name                                              | Description                                                                     | Value               |
| ------------------------------------------------- | ------------------------------------------------------------------------------- | ------------------- |
| `api.image.repository`                            | Repository to use to pull plane's api container image                           |                     |
| `api.image.tag`                                   | plane's api container tag                                                       |                     |
| `api.image.pullPolicy`                            | api container image pull policy                                                 |                     |
| `api.command`                                     | Override the api container command                                              | `["./bin/takeoff"]` |
| `api.args`                                        | Override the api container args                                                 | `[]`                |
| `api.replicas`                                    | Amount of api replicas                                                          | `3`                 |
| `api.shareProcessNamespace`                       | Enable share process namespace between containers                               | `false`             |
| `api.sidecars`                                    | Add sidecars containers to api deployment                                       | `[]`                |
| `api.securityContext`                             | Configure api Pod security context                                              | `nil`               |
| `api.envVars`                                     | Configure api container environment variables                                   | `undefined`         |
| `api.envVars.BY_VALUE`                            | Example environment variable by setting value directly                          |                     |
| `api.envVars.FROM_CONFIGMAP.configMapKeyRef.name` | Name of a ConfigMap when configuring env vars from a ConfigMap                  |                     |
| `api.envVars.FROM_CONFIGMAP.configMapKeyRef.key`  | Key within a ConfigMap when configuring env vars from a ConfigMap               |                     |
| `api.envVars.FROM_SECRET.secretKeyRef.name`       | Name of a Secret when configuring env vars from a Secret                        |                     |
| `api.envVars.FROM_SECRET.secretKeyRef.key`        | Key within a Secret when configuring env vars from a Secret                     |                     |
| `api.podAnnotations`                              | Annotations to add to the api Pod                                               | `{}`                |
| `api.service.type`                                | api Service type                                                                | `ClusterIP`         |
| `api.service.port`                                | api Service listening port                                                      | `80`                |
| `api.service.targetPort`                          | api container listening port                                                    | `8000`              |
| `api.service.annotations`                         | Annotations to add to the api Service                                           | `{}`                |
| `api.probes`                                      | Configure probe for api                                                         | `{}`                |
| `api.probes.liveness.path`                        | Configure path for api HTTP liveness probe                                      |                     |
| `api.probes.liveness.targetPort`                  | Configure port for api HTTP liveness probe                                      |                     |
| `api.probes.liveness.initialDelaySeconds`         | Configure initial delay for api liveness probe                                  |                     |
| `api.probes.liveness.initialDelaySeconds`         | Configure timeout for api liveness probe                                        |                     |
| `api.probes.startup.path`                         | Configure path for api HTTP startup probe                                       |                     |
| `api.probes.startup.targetPort`                   | Configure port for api HTTP startup probe                                       |                     |
| `api.probes.startup.initialDelaySeconds`          | Configure initial delay for api startup probe                                   |                     |
| `api.probes.startup.initialDelaySeconds`          | Configure timeout for api startup probe                                         |                     |
| `api.probes.readiness.path`                       | Configure path for api HTTP readiness probe                                     |                     |
| `api.probes.readiness.targetPort`                 | Configure port for api HTTP readiness probe                                     |                     |
| `api.probes.readiness.initialDelaySeconds`        | Configure initial delay for api readiness probe                                 |                     |
| `api.probes.readiness.initialDelaySeconds`        | Configure timeout for api readiness probe                                       |                     |
| `api.resources`                                   | Resource requirements for the api container                                     | `{}`                |
| `api.nodeSelector`                                | Node selector for the api Pod                                                   | `{}`                |
| `api.tolerations`                                 | Tolerations for the api Pod                                                     | `[]`                |
| `api.affinity`                                    | Affinity for the api Pod                                                        | `{}`                |
| `api.persistence`                                 | Additionnal volumes to create and mount on the api. Used for debugging purposes | `{}`                |
| `api.persistence.volume-name.size`                | Size of the additional volume                                                   |                     |
| `api.persistence.volume-name.type`                | Type of the additional volume, persistentVolumeClaim or emptyDir                |                     |
| `api.persistence.volume-name.mountPath`           | Path where the volume should be mounted to                                      |                     |
| `api.extraVolumeMounts`                           | Additionnal volumes to mount on the api.                                        | `[]`                |
| `api.extraVolumes`                                | Additionnal volumes to mount on the api.                                        | `[]`                |

### space

| Name                                                | Description                                                                       | Value                         |
| --------------------------------------------------- | --------------------------------------------------------------------------------- | ----------------------------- |
| `space.image.repository`                            | Repository to use to pull plane's space container image                           | `makeplane/plane-space`       |
| `space.image.tag`                                   | plane's space container tag                                                       | `latest`                      |
| `space.image.pullPolicy`                            | space container image pull policy                                                 | `IfNotPresent`                |
| `space.command`                                     | Override the space container command                                              | `["/usr/local/bin/start.sh"]` |
| `space.args`                                        | Override the space container args                                                 | `["space/server.js","space"]` |
| `space.replicas`                                    | Amount of space replicas                                                          | `3`                           |
| `space.shareProcessNamespace`                       | Enable share process namespace between containers                                 | `false`                       |
| `space.sidecars`                                    | Add sidecars containers to space deployment                                       | `[]`                          |
| `space.securityContext`                             | Configure space Pod security context                                              | `nil`                         |
| `space.envVars`                                     | Configure space container environment variables                                   | `undefined`                   |
| `space.envVars.BY_VALUE`                            | Example environment variable by setting value directly                            |                               |
| `space.envVars.FROM_CONFIGMAP.configMapKeyRef.name` | Name of a ConfigMap when configuring env vars from a ConfigMap                    |                               |
| `space.envVars.FROM_CONFIGMAP.configMapKeyRef.key`  | Key within a ConfigMap when configuring env vars from a ConfigMap                 |                               |
| `space.envVars.FROM_SECRET.secretKeyRef.name`       | Name of a Secret when configuring env vars from a Secret                          |                               |
| `space.envVars.FROM_SECRET.secretKeyRef.key`        | Key within a Secret when configuring env vars from a Secret                       |                               |
| `space.podAnnotations`                              | Annotations to add to the space Pod                                               | `{}`                          |
| `space.service.type`                                | space Service type                                                                | `ClusterIP`                   |
| `space.service.port`                                | space Service listening port                                                      | `80`                          |
| `space.service.targetPort`                          | space container listening port                                                    | `3000`                        |
| `space.service.annotations`                         | Annotations to add to the space Service                                           | `{}`                          |
| `space.probes`                                      | Configure probe for space                                                         | `{}`                          |
| `space.probes.liveness.path`                        | Configure path for space HTTP liveness probe                                      |                               |
| `space.probes.liveness.targetPort`                  | Configure port for space HTTP liveness probe                                      |                               |
| `space.probes.liveness.initialDelaySeconds`         | Configure initial delay for space liveness probe                                  |                               |
| `space.probes.liveness.initialDelaySeconds`         | Configure timeout for space liveness probe                                        |                               |
| `space.probes.startup.path`                         | Configure path for space HTTP startup probe                                       |                               |
| `space.probes.startup.targetPort`                   | Configure port for space HTTP startup probe                                       |                               |
| `space.probes.startup.initialDelaySeconds`          | Configure initial delay for space startup probe                                   |                               |
| `space.probes.startup.initialDelaySeconds`          | Configure timeout for space startup probe                                         |                               |
| `space.probes.readiness.path`                       | Configure path for space HTTP readiness probe                                     |                               |
| `space.probes.readiness.targetPort`                 | Configure port for space HTTP readiness probe                                     |                               |
| `space.probes.readiness.initialDelaySeconds`        | Configure initial delay for space readiness probe                                 |                               |
| `space.probes.readiness.initialDelaySeconds`        | Configure timeout for space readiness probe                                       |                               |
| `space.resources`                                   | Resource requirements for the space container                                     | `{}`                          |
| `space.nodeSelector`                                | Node selector for the space Pod                                                   | `{}`                          |
| `space.tolerations`                                 | Tolerations for the space Pod                                                     | `[]`                          |
| `space.affinity`                                    | Affinity for the space Pod                                                        | `{}`                          |
| `space.persistence`                                 | Additionnal volumes to create and mount on the space. Used for debugging purposes | `{}`                          |
| `space.persistence.volume-name.size`                | Size of the additional volume                                                     |                               |
| `space.persistence.volume-name.type`                | Type of the additional volume, persistentVolumeClaim or emptyDir                  |                               |
| `space.persistence.volume-name.mountPath`           | Path where the volume should be mounted to                                        |                               |
| `space.extraVolumeMounts`                           | Additionnal volumes to mount on the api.                                          | `[]`                          |
| `space.extraVolumes`                                | Additionnal volumes to mount on the api.                                          | `[]`                          |

### web

| Name                                              | Description                                                                     | Value                         |
| ------------------------------------------------- | ------------------------------------------------------------------------------- | ----------------------------- |
| `web.image.repository`                            | Repository to use to pull plane's web container image                           | `makeplane/plane-frontend`    |
| `web.image.tag`                                   | plane's web container tag                                                       | `latest`                      |
| `web.image.pullPolicy`                            | web container image pull policy                                                 | `IfNotPresent`                |
| `web.command`                                     | Override the web container command                                              | `["/usr/local/bin/start.sh"]` |
| `web.args`                                        | Override the web container args                                                 | `["web/server.js","web"]`     |
| `web.replicas`                                    | Amount of web replicas                                                          | `3`                           |
| `web.shareProcessNamespace`                       | Enable share process nameweb between containers                                 | `false`                       |
| `web.sidecars`                                    | Add sidecars containers to web deployment                                       | `[]`                          |
| `web.securityContext`                             | Configure web Pod security context                                              | `nil`                         |
| `web.envVars`                                     | Configure web container environment variables                                   | `undefined`                   |
| `web.envVars.BY_VALUE`                            | Example environment variable by setting value directly                          |                               |
| `web.envVars.FROM_CONFIGMAP.configMapKeyRef.name` | Name of a ConfigMap when configuring env vars from a ConfigMap                  |                               |
| `web.envVars.FROM_CONFIGMAP.configMapKeyRef.key`  | Key within a ConfigMap when configuring env vars from a ConfigMap               |                               |
| `web.envVars.FROM_SECRET.secretKeyRef.name`       | Name of a Secret when configuring env vars from a Secret                        |                               |
| `web.envVars.FROM_SECRET.secretKeyRef.key`        | Key within a Secret when configuring env vars from a Secret                     |                               |
| `web.podAnnotations`                              | Annotations to add to the web Pod                                               | `{}`                          |
| `web.service.type`                                | web Service type                                                                | `ClusterIP`                   |
| `web.service.port`                                | web Service listening port                                                      | `80`                          |
| `web.service.targetPort`                          | web container listening port                                                    | `3000`                        |
| `web.service.annotations`                         | Annotations to add to the web Service                                           | `{}`                          |
| `web.probes`                                      | Configure probe for web                                                         | `{}`                          |
| `web.probes.liveness.path`                        | Configure path for web HTTP liveness probe                                      |                               |
| `web.probes.liveness.targetPort`                  | Configure port for web HTTP liveness probe                                      |                               |
| `web.probes.liveness.initialDelaySeconds`         | Configure initial delay for web liveness probe                                  |                               |
| `web.probes.liveness.initialDelaySeconds`         | Configure timeout for web liveness probe                                        |                               |
| `web.probes.startup.path`                         | Configure path for web HTTP startup probe                                       |                               |
| `web.probes.startup.targetPort`                   | Configure port for web HTTP startup probe                                       |                               |
| `web.probes.startup.initialDelaySeconds`          | Configure initial delay for web startup probe                                   |                               |
| `web.probes.startup.initialDelaySeconds`          | Configure timeout for web startup probe                                         |                               |
| `web.probes.readiness.path`                       | Configure path for web HTTP readiness probe                                     |                               |
| `web.probes.readiness.targetPort`                 | Configure port for web HTTP readiness probe                                     |                               |
| `web.probes.readiness.initialDelaySeconds`        | Configure initial delay for web readiness probe                                 |                               |
| `web.probes.readiness.initialDelaySeconds`        | Configure timeout for web readiness probe                                       |                               |
| `web.resources`                                   | Resource requirements for the web container                                     | `{}`                          |
| `web.nodeSelector`                                | Node selector for the web Pod                                                   | `{}`                          |
| `web.tolerations`                                 | Tolerations for the web Pod                                                     | `[]`                          |
| `web.affinity`                                    | Affinity for the web Pod                                                        | `{}`                          |
| `web.persistence`                                 | Additionnal volumes to create and mount on the web. Used for debugging purposes | `{}`                          |
| `web.persistence.volume-name.size`                | Size of the additional volume                                                   |                               |
| `web.persistence.volume-name.type`                | Type of the additional volume, persistentVolumeClaim or emptyDir                |                               |
| `web.persistence.volume-name.mountPath`           | Path where the volume should be mounted to                                      |                               |
| `web.extraVolumeMounts`                           | Additionnal volumes to mount on the api.                                        | `[]`                          |
| `web.extraVolumes`                                | Additionnal volumes to mount on the api.                                        | `[]`                          |

### worker

| Name                                                 | Description                                                                        | Value                     |
| ---------------------------------------------------- | ---------------------------------------------------------------------------------- | ------------------------- |
| `worker.image.repository`                            | Repository to use to pull plane's worker container image                           | `makeplane/plane-backend` |
| `worker.image.tag`                                   | plane's worker container tag                                                       | `latest`                  |
| `worker.image.pullPolicy`                            | worker container image pull policy                                                 | `IfNotPresent`            |
| `worker.command`                                     | Override the worker container command                                              | `["./bin/worker"]`        |
| `worker.args`                                        | Override the worker container args                                                 | `[]`                      |
| `worker.replicas`                                    | Amount of worker replicas                                                          | `3`                       |
| `worker.shareProcessNamespace`                       | Enable share process nameworker between containers                                 | `false`                   |
| `worker.sidecars`                                    | Add sidecars containers to worker deployment                                       | `[]`                      |
| `worker.securityContext`                             | Configure worker Pod security context                                              | `nil`                     |
| `worker.envVars`                                     | Configure worker container environment variables                                   | `undefined`               |
| `worker.envVars.BY_VALUE`                            | Example environment variable by setting value directly                             |                           |
| `worker.envVars.FROM_CONFIGMAP.configMapKeyRef.name` | Name of a ConfigMap when configuring env vars from a ConfigMap                     |                           |
| `worker.envVars.FROM_CONFIGMAP.configMapKeyRef.key`  | Key within a ConfigMap when configuring env vars from a ConfigMap                  |                           |
| `worker.envVars.FROM_SECRET.secretKeyRef.name`       | Name of a Secret when configuring env vars from a Secret                           |                           |
| `worker.envVars.FROM_SECRET.secretKeyRef.key`        | Key within a Secret when configuring env vars from a Secret                        |                           |
| `worker.podAnnotations`                              | Annotations to add to the worker Pod                                               | `{}`                      |
| `worker.probes`                                      | Configure probe for worker                                                         | `{}`                      |
| `worker.probes.liveness.path`                        | Configure path for worker HTTP liveness probe                                      |                           |
| `worker.probes.liveness.targetPort`                  | Configure port for worker HTTP liveness probe                                      |                           |
| `worker.probes.liveness.initialDelaySeconds`         | Configure initial delay for worker liveness probe                                  |                           |
| `worker.probes.liveness.initialDelaySeconds`         | Configure timeout for worker liveness probe                                        |                           |
| `worker.probes.startup.path`                         | Configure path for worker HTTP startup probe                                       |                           |
| `worker.probes.startup.targetPort`                   | Configure port for worker HTTP startup probe                                       |                           |
| `worker.probes.startup.initialDelaySeconds`          | Configure initial delay for worker startup probe                                   |                           |
| `worker.probes.startup.initialDelaySeconds`          | Configure timeout for worker startup probe                                         |                           |
| `worker.probes.readiness.path`                       | Configure path for worker HTTP readiness probe                                     |                           |
| `worker.probes.readiness.targetPort`                 | Configure port for worker HTTP readiness probe                                     |                           |
| `worker.probes.readiness.initialDelaySeconds`        | Configure initial delay for worker readiness probe                                 |                           |
| `worker.probes.readiness.initialDelaySeconds`        | Configure timeout for worker readiness probe                                       |                           |
| `worker.resources`                                   | Resource requirements for the worker container                                     | `{}`                      |
| `worker.nodeSelector`                                | Node selector for the worker Pod                                                   | `{}`                      |
| `worker.tolerations`                                 | Tolerations for the worker Pod                                                     | `[]`                      |
| `worker.affinity`                                    | Affinity for the worker Pod                                                        | `{}`                      |
| `worker.persistence`                                 | Additionnal volumes to create and mount on the worker. Used for debugging purposes | `{}`                      |
| `worker.persistence.volume-name.size`                | Size of the additional volume                                                      |                           |
| `worker.persistence.volume-name.type`                | Type of the additional volume, persistentVolumeClaim or emptyDir                   |                           |
| `worker.persistence.volume-name.mountPath`           | Path where the volume should be mounted to                                         |                           |
| `worker.extraVolumeMounts`                           | Additionnal volumes to mount on the api.                                           | `[]`                      |
| `worker.extraVolumes`                                | Additionnal volumes to mount on the api.                                           | `[]`                      |

### beat_worker

| Name                                                      | Description                                                                             | Value                     |
| --------------------------------------------------------- | --------------------------------------------------------------------------------------- | ------------------------- |
| `beat_worker.image.repository`                            | Repository to use to pull plane's beat_worker container image                           | `makeplane/plane-backend` |
| `beat_worker.image.tag`                                   | plane's beat_worker container tag                                                       | `latest`                  |
| `beat_worker.image.pullPolicy`                            | beat_worker container image pull policy                                                 | `IfNotPresent`            |
| `beat_worker.command`                                     | Override the beat_worker container command                                              | `["./bin/beat"]`          |
| `beat_worker.args`                                        | Override the beat_worker container args                                                 | `[]`                      |
| `beat_worker.replicas`                                    | Amount of beat_worker replicas                                                          | `3`                       |
| `beat_worker.shareProcessNamespace`                       | Enable share process namebeat_worker between containers                                 | `false`                   |
| `beat_worker.sidecars`                                    | Add sidecars containers to beat_worker deployment                                       | `[]`                      |
| `beat_worker.securityContext`                             | Configure beat_worker Pod security context                                              | `nil`                     |
| `beat_worker.envVars`                                     | Configure beat_worker container environment variables                                   | `undefined`               |
| `beat_worker.envVars.BY_VALUE`                            | Example environment variable by setting value directly                                  |                           |
| `beat_worker.envVars.FROM_CONFIGMAP.configMapKeyRef.name` | Name of a ConfigMap when configuring env vars from a ConfigMap                          |                           |
| `beat_worker.envVars.FROM_CONFIGMAP.configMapKeyRef.key`  | Key within a ConfigMap when configuring env vars from a ConfigMap                       |                           |
| `beat_worker.envVars.FROM_SECRET.secretKeyRef.name`       | Name of a Secret when configuring env vars from a Secret                                |                           |
| `beat_worker.envVars.FROM_SECRET.secretKeyRef.key`        | Key within a Secret when configuring env vars from a Secret                             |                           |
| `beat_worker.podAnnotations`                              | Annotations to add to the beat_worker Pod                                               | `{}`                      |
| `beat_worker.probes`                                      | Configure probe for beat_worker                                                         | `{}`                      |
| `beat_worker.probes.liveness.path`                        | Configure path for beat_worker HTTP liveness probe                                      |                           |
| `beat_worker.probes.liveness.targetPort`                  | Configure port for beat_worker HTTP liveness probe                                      |                           |
| `beat_worker.probes.liveness.initialDelaySeconds`         | Configure initial delay for beat_worker liveness probe                                  |                           |
| `beat_worker.probes.liveness.initialDelaySeconds`         | Configure timeout for beat_worker liveness probe                                        |                           |
| `beat_worker.probes.startup.path`                         | Configure path for beat_worker HTTP startup probe                                       |                           |
| `beat_worker.probes.startup.targetPort`                   | Configure port for beat_worker HTTP startup probe                                       |                           |
| `beat_worker.probes.startup.initialDelaySeconds`          | Configure initial delay for beat_worker startup probe                                   |                           |
| `beat_worker.probes.startup.initialDelaySeconds`          | Configure timeout for beat_worker startup probe                                         |                           |
| `beat_worker.probes.readiness.path`                       | Configure path for beat_worker HTTP readiness probe                                     |                           |
| `beat_worker.probes.readiness.targetPort`                 | Configure port for beat_worker HTTP readiness probe                                     |                           |
| `beat_worker.probes.readiness.initialDelaySeconds`        | Configure initial delay for beat_worker readiness probe                                 |                           |
| `beat_worker.probes.readiness.initialDelaySeconds`        | Configure timeout for beat_worker readiness probe                                       |                           |
| `beat_worker.resources`                                   | Resource requirements for the beat_worker container                                     | `{}`                      |
| `beat_worker.nodeSelector`                                | Node selector for the beat_worker Pod                                                   | `{}`                      |
| `beat_worker.tolerations`                                 | Tolerations for the beat_worker Pod                                                     | `[]`                      |
| `beat_worker.affinity`                                    | Affinity for the beat_worker Pod                                                        | `{}`                      |
| `beat_worker.persistence`                                 | Additionnal volumes to create and mount on the beat_worker. Used for debugging purposes | `{}`                      |
| `beat_worker.persistence.volume-name.size`                | Size of the additional volume                                                           |                           |
| `beat_worker.persistence.volume-name.type`                | Type of the additional volume, persistentVolumeClaim or emptyDir                        |                           |
| `beat_worker.persistence.volume-name.mountPath`           | Path where the volume should be mounted to                                              |                           |
| `beat_worker.extraVolumeMounts`                           | Additionnal volumes to mount on the api.                                                | `[]`                      |
| `beat_worker.extraVolumes`                                | Additionnal volumes to mount on the api.                                                | `[]`                      |
