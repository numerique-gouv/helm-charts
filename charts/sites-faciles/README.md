# sites-faciles

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2.5.2](https://img.shields.io/badge/AppVersion-2.5.2-informational?style=flat-square)

A Helm chart to deploy sites-faciles.

**Homepage:** <https://sites.beta.gouv.fr>

## Source Code

* <https://github.com/numerique-gouv/sites-faciles>
* <https://github.com/numerique-gouv/helm-charts>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| oci://registry-1.docker.io/cloudpirates | postgresql(postgres) | 0.16.0 |

## Values

### General

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Affinity configuration. |
| args | list | `[]` | Container command args. |
| command | list | `[]` | Container command. |
| containerPort | int | `8000` | Container port. |
| env | object | `{}` | Container env variables, it will be injected into a configmap and loaded into the container. |
| envFrom | list | `[]` | Container env variables loaded from configmap or secret reference. |
| extraContainers | list | `[]` | Extra containers to add to the pod as sidecars. |
| extraObjects | list | `[]` | Add extra specs dynamically to this chart. |
| extraPorts | list | `[]` | Extra container ports. |
| fullnameOverride | string | `""` | String to fully override the default application name. |
| hostAliases | list | `[]` | Host aliases that will be injected at pod-level into /etc/hosts. |
| initContainers | list | `[]` | Init containers to add to the pod. |
| nameOverride | string | `""` | Provide a name in place of the default application name. |
| nodeSelector | object | `{}` | Default node selector. |
| pdb.annotations | object | `{}` | Annotations to be added to pdb. |
| pdb.enabled | bool | `false` | Deploy a PodDisruptionBudget |
| pdb.labels | object | `{}` | Labels to be added to pdb. |
| pdb.maxUnavailable | string | `""` | Number of pods that are unavailable after eviction as number or percentage (eg.: 50%). Has higher precedence over `pdb.minAvailable`. |
| pdb.minAvailable | string | `""` (defaults to 0 if not specified) | Number of pods that are available after eviction as number or percentage (eg.: 50%). |
| podAnnotations | object | `{}` | Annotations for the deployed pods. |
| podLabels | object | `{}` | Labels for the deployed pods. |
| podSecurityContext | object | `{}` | Toggle and define pod-level security context. |
| replicaCount | int | `1` | The number of application controller pods to run. |
| revisionHistoryLimit | int | `10` | Revision history limit. |
| secrets | object | `{}` | Container env secrets, it will be injected into a secret and loaded into the container. |
| securityContext | object | `{}` | Toggle and define container-level security context. |
| strategy.rollingUpdate.maxSurge | int | `1` | The maximum number of pods that can be scheduled above the desired number of pods. |
| strategy.rollingUpdate.maxUnavailable | int | `1` | The maximum number of pods that can be unavailable during the update process. |
| strategy.type | string | `"RollingUpdate"` | Strategy type used to replace old Pods by new ones, can be `Recreate` or `RollingUpdate`. |
| tolerations | list | `[]` | Default tolerations. |

### Autoscaling

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| autoscaling.enabled | bool | `false` | Enable Horizontal Pod Autoscaler. |
| autoscaling.maxReplicas | int | `3` | Maximum number of replicas. |
| autoscaling.minReplicas | int | `1` | Minimum number of replicas. |
| autoscaling.targetCPUUtilizationPercentage | int | `80` | Average CPU utilization percentage. |
| autoscaling.targetMemoryUtilizationPercentage | int | `80` | Average memory utilization percentage. |

### Config

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| config.allowedHosts | string | `"localhost,127.0.0.1"` | The domain(s) authorized to access the site, separated by commas if more than one. |
| config.defaultFromEmail | string | `"no-reply@domain.local"` | Default email address used for sending emails. |
| config.djangoSuperuserEmail | string | `""` | Django superuser email (Default to `<djangoSuperuserUsername>@domain.local` if not set). |
| config.djangoSuperuserPassword | string | `""` | Django superuser password (Default to autogenerating a random password if not set). |
| config.djangoSuperuserUsername | string | `""` | Django superuser username (Default to `admin` if not set). |
| config.emailHost | string | `""` | Host to use for sending emails. |
| config.emailHostPassword | string | `""` | Password to use for the SMTP server defined in `EMAIL_HOST`. |
| config.emailHostUser | string | `""` | Username to use for the SMTP server defined in `EMAIL_HOST`. |
| config.emailPort | int | `465` | Port to use for the SMTP server defined above. |
| config.emailSslCertfile | string | `""` | If `EMAIL_USE_SSL` or `EMAIL_USE_TLS` are true, optionally set the path to a PEM certificate chain file for SSL connection. |
| config.emailSslKeyfile | string | `""` | If `EMAIL_USE_SSL` or `EMAIL_USE_TLS` are true, optionally set the path to a PEM private key file for SSL connection. |
| config.emailTimeout | int | `30` | Timeout in seconds for blocking operations such as connection attempts. Must not be zero. |
| config.emailUseSsl | bool | `false` | Whether to use implicit TLS (SSL) for SMTP communication. |
| config.emailUseTls | bool | `true` | Whether to use a secure TLS connection for SMTP communication. |
| config.hostProto | string | `"http"` | The protocol to use for the app's main URL. |
| config.hostUrl | string | `"localhost:8000"` | The domain name of your site's main URL. |
| config.s3BucketName | string | `""` | Name of the S3 bucket to use for storage. |
| config.s3BucketRegion | string | `""` | AWS region of the S3 bucket. |
| config.s3Host | string | `""` | S3 host (without https://), e.g. `s3.amazonaws.com`. |
| config.s3KeyId | string | `""` | S3 access key ID for authentication. |
| config.s3KeySecret | string | `""` | S3 secret access key for authentication. |
| config.s3Location | string | `""` | The S3_LOCATION parameter is optional, but allows you to share the S3 bucket with several Easy Sites installations. We recommend using the app name as the value. |
| config.secretKey | string | `""` | Secret key, for example generated in a terminal with the command `openssl rand -hex 32` (Default to a random value if not set). |
| config.wagtailPasswordResetEnabled | bool | `true` | Allow users to request a password reset. |

### Image

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy for the app. |
| image.repository | string | `"ghcr.io/numerique-gouv/sites-faciles"` | Repository to use for the app. |
| image.tag | string | `""` | Tag to use for the app. Overrides the image tag whose default is the chart appVersion. |
| imagePullSecrets | list | `[]` | Image credentials configuration. |

### Ingress

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| ingress.annotations | object | `{}` | Additional ingress annotations. |
| ingress.className | string | `""` | Defines which ingress controller will implement the resource. |
| ingress.enabled | bool | `false` | Whether or not ingress should be enabled. |
| ingress.hosts[0].backend.portNumber | string | `nil` | Port used by the backend service linked to the host record (leave null to use the app service port). |
| ingress.hosts[0].backend.serviceName | string | `""` | Name of the backend service linked to the host record (leave empty to use the app service). |
| ingress.hosts[0].name | string | `"domain.local"` | Name of the host record. |
| ingress.hosts[0].path | string | `"/"` | Path of the host record to manage routing. |
| ingress.hosts[0].pathType | string | `"Prefix"` | Path type of the host record. |
| ingress.labels | object | `{}` | Additional ingress labels. |
| ingress.tls | list | `[]` | Enable TLS configuration. |

### Metrics

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| metrics.enabled | bool | `false` | Deploy metrics service. |
| metrics.service.annotations | object | `{}` | Metrics service annotations. |
| metrics.service.labels | object | `{}` | Metrics service labels. |
| metrics.service.port | int | `9100` | Metrics service port. |
| metrics.service.targetPort | int | `9100` | Metrics service target port. |
| metrics.serviceMonitor.annotations | object | `{}` | Prometheus ServiceMonitor annotations. |
| metrics.serviceMonitor.enabled | bool | `false` | Enable a prometheus ServiceMonitor. |
| metrics.serviceMonitor.endpoints[0].basicAuth.password | string | `""` | The secret in the service monitor namespace that contains the password for authentication. |
| metrics.serviceMonitor.endpoints[0].basicAuth.username | string | `""` | The secret in the service monitor namespace that contains the username for authentication. |
| metrics.serviceMonitor.endpoints[0].bearerTokenSecret.key | string | `""` | Secret key to mount to read bearer token for scraping targets. The secret needs to be in the same namespace as the service monitor and accessible by the Prometheus Operator. |
| metrics.serviceMonitor.endpoints[0].bearerTokenSecret.name | string | `""` | Secret name to mount to read bearer token for scraping targets. The secret needs to be in the same namespace as the service monitor and accessible by the Prometheus Operator. |
| metrics.serviceMonitor.endpoints[0].honorLabels | bool | `false` | When true, honorLabels preserves the metric's labels when they collide with the target's labels. |
| metrics.serviceMonitor.endpoints[0].interval | string | `"30s"` | Prometheus ServiceMonitor interval. |
| metrics.serviceMonitor.endpoints[0].metricRelabelings | list | `[]` | Prometheus MetricRelabelConfigs to apply to samples before ingestion. |
| metrics.serviceMonitor.endpoints[0].path | string | `"/metrics"` | Path used by the Prometheus ServiceMonitor to scrape metrics. |
| metrics.serviceMonitor.endpoints[0].relabelings | list | `[]` | Prometheus RelabelConfigs to apply to samples before scraping. |
| metrics.serviceMonitor.endpoints[0].scheme | string | `""` | Prometheus ServiceMonitor scheme. |
| metrics.serviceMonitor.endpoints[0].scrapeTimeout | string | `"10s"` | Prometheus ServiceMonitor scrapeTimeout. If empty, Prometheus uses the global scrape timeout unless it is less than the target's scrape interval value in which the latter is used. |
| metrics.serviceMonitor.endpoints[0].selector | object | `{}` | Prometheus ServiceMonitor selector. |
| metrics.serviceMonitor.endpoints[0].tlsConfig | object | `{}` | Prometheus ServiceMonitor tlsConfig. |
| metrics.serviceMonitor.labels | object | `{}` | Prometheus ServiceMonitor labels. |

### NetworkPolicy

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| networkPolicy.create | bool | `false` | Create NetworkPolicy object. |
| networkPolicy.egress | list | `[]` | Egress rules for the NetworkPolicy object. |
| networkPolicy.ingress | list | `[]` | Ingress rules for the NetworkPolicy object. |
| networkPolicy.policyTypes | list | `["Ingress"]` | Policy types used in the NetworkPolicy object. |

### Database

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| postgresql.auth.database | string | `"sitesfaciles"` | Name of the database to create. |
| postgresql.auth.existingSecret | string | `""` | Name of an existing secret containing PostgreSQL credentials. |
| postgresql.auth.password | string | `""` | PostgreSQL admin password (auto-generated if not set). |
| postgresql.auth.username | string | `"sitesfaciles"` | PostgreSQL admin username (also creates a database with the same name). |
| postgresql.enabled | bool | `true` | Enable the PostgreSQL subchart (See. https://artifacthub.io/packages/helm/cloudpirates-postgres/postgres). |
| postgresql.fullnameOverride | string | `"sites-faciles-postgresql"` | Override the fullname of the PostgreSQL subchart. |
| postgresql.persistence.enabled | bool | `true` | Enable persistence using PVC. |
| postgresql.persistence.size | string | `"1Gi"` | Size of the PVC for PostgreSQL data. |
| postgresql.resources.limits.cpu | string | `"200m"` | CPU limit for PostgreSQL. |
| postgresql.resources.limits.memory | string | `"512Mi"` | Memory limit for PostgreSQL. |
| postgresql.resources.requests.cpu | string | `"200m"` | CPU request for PostgreSQL. |
| postgresql.resources.requests.memory | string | `"512Mi"` | Memory request for PostgreSQL. |

### Probes

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| probes.healthcheck.path | string | `"/"` | Container healthcheck endpoint. |
| probes.healthcheck.port | int | `8000` | Port to use for healthcheck (defaults to container port if not set) |
| probes.livenessProbe.enabled | bool | `true` | Whether or not enable the probe. |
| probes.livenessProbe.failureThreshold | int | `3` | Minimum consecutive failures for the probe to be considered failed after having succeeded. |
| probes.livenessProbe.initialDelaySeconds | int | `30` | Number of seconds after the container has started before probe is initiated. |
| probes.livenessProbe.periodSeconds | int | `30` | How often (in seconds) to perform the probe. |
| probes.livenessProbe.successThreshold | int | `1` | Minimum consecutive successes for the probe to be considered successful after having failed. |
| probes.livenessProbe.timeoutSeconds | int | `5` | Number of seconds after which the probe times out. |
| probes.readinessProbe.enabled | bool | `true` | Whether or not enable the probe. |
| probes.readinessProbe.failureThreshold | int | `3` | Minimum consecutive failures for the probe to be considered failed after having succeeded. |
| probes.readinessProbe.initialDelaySeconds | int | `10` | Number of seconds after the container has started before probe is initiated. |
| probes.readinessProbe.periodSeconds | int | `10` | How often (in seconds) to perform the probe. |
| probes.readinessProbe.successThreshold | int | `2` | Minimum consecutive successes for the probe to be considered successful after having failed. |
| probes.readinessProbe.timeoutSeconds | int | `5` | Number of seconds after which the probe times out. |
| probes.startupProbe.enabled | bool | `true` | Whether or not enable the probe. |
| probes.startupProbe.failureThreshold | int | `10` | Minimum consecutive failures for the probe to be considered failed after having succeeded. |
| probes.startupProbe.initialDelaySeconds | int | `5` | Number of seconds after the container has started before probe is initiated. |
| probes.startupProbe.periodSeconds | int | `10` | How often (in seconds) to perform the probe. |
| probes.startupProbe.successThreshold | int | `1` | Minimum consecutive successes for the probe to be considered successful after having failed. |
| probes.startupProbe.timeoutSeconds | int | `5` | Number of seconds after which the probe times out. |

### Resources

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| resources.limits.cpu | string | `"1"` | CPU limit. |
| resources.limits.memory | string | `"1Gi"` | Memory limit. |
| resources.requests.cpu | string | `"200m"` | CPU request. |
| resources.requests.memory | string | `"256Mi"` | Memory request. |

### Service

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| service.extraPorts | list | `[]` | Extra service ports. |
| service.nodePort | int | `31000` | Port used when type is `NodePort` to expose the service on the given node port. |
| service.port | int | `80` | Port used by the service. |
| service.portName | string | `"http"` | Port name used by the service. |
| service.protocol | string | `"TCP"` | Protocol used by the service. |
| service.type | string | `"ClusterIP"` | Type of service to create. |

### Service Account

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| serviceAccount.annotations | object | `{}` | Annotations applied to created service account. |
| serviceAccount.automountServiceAccountToken | bool | `false` | Should the service account access token be automount in the pod. |
| serviceAccount.create | bool | `false` | Create a service account. |
| serviceAccount.enabled | bool | `false` | Enable the service account. |
| serviceAccount.name | string | `""` | Service account name. |

### Volumes

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| volumeClaims | list | `[]` | List of volumeClaims to add. |
| volumeMounts | list | `[]` | List of mounts to add (normally used with `volumes` or `volumeClaims`). |
| volumes | list | `[]` | List of volumes to add. |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
