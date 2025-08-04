# sites-faciles

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2.0.0](https://img.shields.io/badge/AppVersion-2.0.0-informational?style=flat-square)

A Helm chart to deploy sites-faciles.

**Homepage:** <https://sites.beta.gouv.fr>

## Source Code

* <https://github.com/numerique-gouv/sites-faciles>
* <https://github.com/numerique-gouv/helm-charts>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://cloudnative-pg.github.io/charts | cnpgOperator(cloudnative-pg) | 0.25.0 |
| https://cloudnative-pg.github.io/charts | cnpgCluster(cluster) | 0.3.1 |

## Values

### General

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| app.affinity | object | `{}` | Affinity used for app pod. |
| app.args | list | `[]` | App container command args. |
| app.command | list | `[]` | App container command. |
| app.containerPort | int | `8000` | App container port. |
| app.env | object | `{}` | App container env variables, it will be injected into a configmap and loaded into the container. |
| app.envFrom | list | `[]` | App container env variables loaded from configmap or secret reference. |
| app.extraContainers | list | `[]` | Extra containers to add to the app pod as sidecars. |
| app.extraPorts | list | `[]` | App extra container ports. |
| app.hostAliases | list | `[]` | Host aliases that will be injected at pod-level into /etc/hosts. |
| app.initContainers | list | `[]` | Init containers to add to the app pod. |
| app.nodeSelector | object | `{}` | Default node selector for app. |
| app.pdb.annotations | object | `{}` | Annotations to be added to app pdb. |
| app.pdb.enabled | bool | `false` | Deploy a PodDisruptionBudget for the app |
| app.pdb.labels | object | `{}` | Labels to be added to app pdb. |
| app.pdb.maxUnavailable | string | `""` | Number of pods that are unavailable after eviction as number or percentage (eg.: 50%). Has higher precedence over `app.pdb.minAvailable`. |
| app.pdb.minAvailable | string | `""` (defaults to 0 if not specified) | Number of pods that are available after eviction as number or percentage (eg.: 50%). |
| app.podAnnotations | object | `{}` | Annotations for the app deployed pods. |
| app.podLabels | object | `{}` | Labels for the app deployed pods. |
| app.podSecurityContext | object | `{}` | Toggle and define pod-level security context. |
| app.replicaCount | int | `1` | The number of application controller pods to run. |
| app.revisionHistoryLimit | int | `10` | Revision history limit for the app. |
| app.secrets | object | `{}` | App container env secrets, it will be injected into a secret and loaded into the container. |
| app.securityContext | object | `{}` | Toggle and define container-level security context. |
| app.strategy.rollingUpdate.maxSurge | int | `1` | The maximum number of pods that can be scheduled above the desired number of pods. |
| app.strategy.rollingUpdate.maxUnavailable | int | `1` | The maximum number of pods that can be unavailable during the update process. |
| app.strategy.type | string | `"RollingUpdate"` | Strategy type used to replace old Pods by new ones, can be `Recreate` or `RollingUpdate`. |
| app.tolerations | list | `[]` | Default tolerations for app. |
| extraObjects | list | `[]` | Add extra specs dynamically to this chart. |
| fullnameOverride | string | `""` | String to fully override the default application name. |
| nameOverride | string | `""` | Provide a name in place of the default application name. |

### Autoscaling

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| app.autoscaling.enabled | bool | `false` | Enable Horizontal Pod Autoscaler for the app. |
| app.autoscaling.maxReplicas | int | `3` | Maximum number of replicas for the app. |
| app.autoscaling.minReplicas | int | `1` | Minimum number of replicas for the app. |
| app.autoscaling.targetCPUUtilizationPercentage | int | `80` | Average CPU utilization percentage for the app. |
| app.autoscaling.targetMemoryUtilizationPercentage | int | `80` | Average memory utilization percentage for the app. |

### Config

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| app.config.allowedHosts | string | `"localhost,127.0.0.1"` | The domain(s) authorized to access the site, separated by commas if more than one. |
| app.config.defaultFromEmail | string | `"no-reply@domain.local"` | Default email address used for sending emails. |
| app.config.djangoSuperuserEmail | string | `""` | Django superuser email (Default to `<djangoSuperuserUsername>@domain.local` if not set). |
| app.config.djangoSuperuserPassword | string | `""` | Django superuser password (Default to autogenerating a random password if not set). |
| app.config.djangoSuperuserUsername | string | `""` | Django superuser username (Default to `admin` if not set). |
| app.config.emailHost | string | `""` | Host to use for sending emails. |
| app.config.emailHostPassword | string | `""` | Password to use for the SMTP server defined in `EMAIL_HOST`. |
| app.config.emailHostUser | string | `""` | Username to use for the SMTP server defined in `EMAIL_HOST`. |
| app.config.emailPort | int | `465` | Port to use for the SMTP server defined above. |
| app.config.emailSslCertfile | string | `""` | If `EMAIL_USE_SSL` or `EMAIL_USE_TLS` are true, optionally set the path to a PEM certificate chain file for SSL connection. |
| app.config.emailSslKeyfile | string | `""` | If `EMAIL_USE_SSL` or `EMAIL_USE_TLS` are true, optionally set the path to a PEM private key file for SSL connection. |
| app.config.emailTimeout | int | `30` | Timeout in seconds for blocking operations such as connection attempts. Must not be zero. |
| app.config.emailUseSsl | bool | `false` | Whether to use implicit TLS (SSL) for SMTP communication. |
| app.config.emailUseTls | bool | `true` | Whether to use a secure TLS connection for SMTP communication. |
| app.config.hostProto | string | `"http"` | The protocol to use for the app's main URL. |
| app.config.hostUrl | string | `"localhost:8000"` | The domain name of your site's main URL. |
| app.config.s3BucketName | string | `""` | Name of the S3 bucket to use for storage. |
| app.config.s3BucketRegion | string | `""` | AWS region of the S3 bucket. |
| app.config.s3Host | string | `""` | S3 host (without https://), e.g. `s3.amazonaws.com`. |
| app.config.s3KeyId | string | `""` | S3 access key ID for authentication. |
| app.config.s3KeySecret | string | `""` | S3 secret access key for authentication. |
| app.config.s3Location | string | `""` | The S3_LOCATION parameter is optional, but allows you to share the S3 bucket with several Easy Sites installations. We recommend using the app name as the value. |
| app.config.secretKey | string | `""` | Secret key, for example generated in a terminal with the command `openssl rand -hex 32` (Default to a random value if not set). |
| app.config.wagtailPasswordResetEnabled | bool | `true` | Allow users to request a password reset. |

### Image

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| app.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy for the app. |
| app.image.repository | string | `"ghcr.io/numerique-gouv/sites-faciles"` | Repository to use for the app. |
| app.image.tag | string | `"main"` | Tag to use for the app. Overrides the image tag whose default is the chart appVersion. |
| app.imagePullSecrets | list | `[]` | Image credentials configuration. |

### Ingress

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| app.ingress.annotations | object | `{}` | Additional ingress annotations. |
| app.ingress.className | string | `""` | Defines which ingress controller will implement the resource. |
| app.ingress.enabled | bool | `false` | Whether or not ingress should be enabled. |
| app.ingress.hosts[0].backend.portNumber | string | `nil` | Port used by the backend service linked to the host record (leave null to use the app service port). |
| app.ingress.hosts[0].backend.serviceName | string | `""` | Name of the backend service linked to the host record (leave empty to use the app service). |
| app.ingress.hosts[0].name | string | `"domain.local"` | Name of the host record. |
| app.ingress.hosts[0].path | string | `"/"` | Path of the host record to manage routing. |
| app.ingress.hosts[0].pathType | string | `"Prefix"` | Path type of the host record. |
| app.ingress.labels | object | `{}` | Additional ingress labels. |
| app.ingress.tls | list | `[]` | Enable TLS configuration. |

### Metrics

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| app.metrics.enabled | bool | `false` | Deploy metrics service. |
| app.metrics.service.annotations | object | `{}` | Metrics service annotations. |
| app.metrics.service.labels | object | `{}` | Metrics service labels. |
| app.metrics.service.port | int | `9100` | Metrics service port. |
| app.metrics.service.targetPort | int | `9100` | Metrics service target port. |
| app.metrics.serviceMonitor.annotations | object | `{}` | Prometheus ServiceMonitor annotations. |
| app.metrics.serviceMonitor.enabled | bool | `false` | Enable a prometheus ServiceMonitor. |
| app.metrics.serviceMonitor.endpoints[0].basicAuth.password | string | `""` | The secret in the service monitor namespace that contains the password for authentication. |
| app.metrics.serviceMonitor.endpoints[0].basicAuth.username | string | `""` | The secret in the service monitor namespace that contains the username for authentication. |
| app.metrics.serviceMonitor.endpoints[0].bearerTokenSecret.key | string | `""` | Secret key to mount to read bearer token for scraping targets. The secret needs to be in the same namespace as the service monitor and accessible by the Prometheus Operator. |
| app.metrics.serviceMonitor.endpoints[0].bearerTokenSecret.name | string | `""` | Secret name to mount to read bearer token for scraping targets. The secret needs to be in the same namespace as the service monitor and accessible by the Prometheus Operator. |
| app.metrics.serviceMonitor.endpoints[0].honorLabels | bool | `false` | When true, honorLabels preserves the metric’s labels when they collide with the target’s labels. |
| app.metrics.serviceMonitor.endpoints[0].interval | string | `"30s"` | Prometheus ServiceMonitor interval. |
| app.metrics.serviceMonitor.endpoints[0].metricRelabelings | list | `[]` | Prometheus MetricRelabelConfigs to apply to samples before ingestion. |
| app.metrics.serviceMonitor.endpoints[0].path | string | `"/metrics"` | Path used by the Prometheus ServiceMonitor to scrape metrics. |
| app.metrics.serviceMonitor.endpoints[0].relabelings | list | `[]` | Prometheus RelabelConfigs to apply to samples before scraping. |
| app.metrics.serviceMonitor.endpoints[0].scheme | string | `""` | Prometheus ServiceMonitor scheme. |
| app.metrics.serviceMonitor.endpoints[0].scrapeTimeout | string | `"10s"` | Prometheus ServiceMonitor scrapeTimeout. If empty, Prometheus uses the global scrape timeout unless it is less than the target's scrape interval value in which the latter is used. |
| app.metrics.serviceMonitor.endpoints[0].selector | object | `{}` | Prometheus ServiceMonitor selector. |
| app.metrics.serviceMonitor.endpoints[0].tlsConfig | object | `{}` | Prometheus ServiceMonitor tlsConfig. |
| app.metrics.serviceMonitor.labels | object | `{}` | Prometheus ServiceMonitor labels. |

### NetworkPolicy

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| app.networkPolicy.create | bool | `false` | Create NetworkPolicy object for the app. |
| app.networkPolicy.egress | list | `[]` | Egress rules for the NetworkPolicy object. |
| app.networkPolicy.ingress | list | `[]` | Ingress rules for the NetworkPolicy object. |
| app.networkPolicy.policyTypes | list | `["Ingress"]` | Policy types used in the NetworkPolicy object. |

### Probes

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| app.probes.healthcheck.path | string | `"/"` | App container healthcheck endpoint. |
| app.probes.healthcheck.port | int | `8000` | Port to use for healthcheck (defaults to container port if not set) |
| app.probes.livenessProbe.enabled | bool | `false` | Whether or not enable the probe. |
| app.probes.livenessProbe.failureThreshold | int | `3` | Minimum consecutive failures for the probe to be considered failed after having succeeded. |
| app.probes.livenessProbe.initialDelaySeconds | int | `30` | Number of seconds after the container has started before probe is initiated. |
| app.probes.livenessProbe.periodSeconds | int | `30` | How often (in seconds) to perform the probe. |
| app.probes.livenessProbe.successThreshold | int | `1` | Minimum consecutive successes for the probe to be considered successful after having failed. |
| app.probes.livenessProbe.timeoutSeconds | int | `5` | Number of seconds after which the probe times out. |
| app.probes.readinessProbe.enabled | bool | `false` | Whether or not enable the probe. |
| app.probes.readinessProbe.failureThreshold | int | `3` | Minimum consecutive failures for the probe to be considered failed after having succeeded. |
| app.probes.readinessProbe.initialDelaySeconds | int | `10` | Number of seconds after the container has started before probe is initiated. |
| app.probes.readinessProbe.periodSeconds | int | `10` | How often (in seconds) to perform the probe. |
| app.probes.readinessProbe.successThreshold | int | `2` | Minimum consecutive successes for the probe to be considered successful after having failed. |
| app.probes.readinessProbe.timeoutSeconds | int | `5` | Number of seconds after which the probe times out. |
| app.probes.startupProbe.enabled | bool | `false` | Whether or not enable the probe. |
| app.probes.startupProbe.failureThreshold | int | `10` | Minimum consecutive failures for the probe to be considered failed after having succeeded. |
| app.probes.startupProbe.initialDelaySeconds | int | `5` | Number of seconds after the container has started before probe is initiated. |
| app.probes.startupProbe.periodSeconds | int | `10` | How often (in seconds) to perform the probe. |
| app.probes.startupProbe.successThreshold | int | `1` | Minimum consecutive successes for the probe to be considered successful after having failed. |
| app.probes.startupProbe.timeoutSeconds | int | `5` | Number of seconds after which the probe times out. |

### Resources

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| app.resources.limits.cpu | string | `"1"` | CPU limit for the app. |
| app.resources.limits.memory | string | `"1Gi"` | Memory limit for the app. |
| app.resources.requests.cpu | string | `"200m"` | CPU request for the app. |
| app.resources.requests.memory | string | `"256Mi"` | Memory request for the app. |

### Service

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| app.service.extraPorts | list | `[]` | Extra service ports. |
| app.service.nodePort | int | `31000` | Port used when type is `NodePort` to expose the service on the given node port. |
| app.service.port | int | `80` | Port used by the service. |
| app.service.portName | string | `"http"` | Port name used by the service. |
| app.service.protocol | string | `"TCP"` | Protocol used by the service. |
| app.service.type | string | `"ClusterIP"` | Type of service to create for the app. |

### Service Account

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| app.serviceAccount.annotations | object | `{}` | Annotations applied to created service account. |
| app.serviceAccount.automountServiceAccountToken | bool | `false` | Should the service account access token be automount in the pod. |
| app.serviceAccount.clusterRole.create | bool | `false` | Should the clusterRole be created. |
| app.serviceAccount.clusterRole.rules | list | `[]` | ClusterRole rules associated with the service account. |
| app.serviceAccount.create | bool | `false` | Create a service account. |
| app.serviceAccount.enabled | bool | `false` | Enable the service account. |
| app.serviceAccount.name | string | `""` | Service account name. |
| app.serviceAccount.role.create | bool | `false` | Should the role be created. |
| app.serviceAccount.role.rules | list | `[]` | Role rules associated with the service account. |

### Volumes

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| app.volumeClaims | list | `[]` | List of volumeClaims to add. |
| app.volumeMounts | list | `[]` | List of mounts to add (normally used with `volumes` or `volumeClaims`). |
| app.volumes | list | `[]` | List of volumes to add. |

### Database

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cnpgCluster.cluster.initdb.database | string | `"sitesfaciles"` | Name of the database. |
| cnpgCluster.cluster.initdb.owner | string | `"sitesfaciles"` | Name of the database owner. |
| cnpgCluster.cluster.initdb.secret.name | string | `"sites-faciles-pg-cluster-app"` | Name of the secret containing the app user credentials. It will be created if not provided. |
| cnpgCluster.cluster.instances | int | `1` | Number of CNPG cluster instances. |
| cnpgCluster.cluster.storage.size | string | `"1Gi"` | Size of the storage used by the CNPG cluster. |
| cnpgCluster.cluster.superuserSecret | string | `"sites-faciles-pg-cluster-admin"` | Name of the secret containing the admin user credentials. |
| cnpgCluster.enabled | bool | `false` | Enable the CNPG cluster (See. https://artifacthub.io/packages/helm/cloudnative-pg/cluster). |
| cnpgCluster.fullnameOverride | string | `"sites-faciles-pg-cluster"` | Name of the CNPG cluster. |
| cnpgCluster.resources.limits.cpu | string | `"200m"` | CPU limit for the CNPG cluster. |
| cnpgCluster.resources.limits.memory | string | `"512Mi"` | Memory limit for the CNPG cluster. |
| cnpgCluster.resources.requests.cpu | string | `"200m"` | CPU request for the CNPG cluster. |
| cnpgCluster.resources.requests.memory | string | `"512Mi"` | Memory request for the CNPG cluster. |
| cnpgOperator.enabled | bool | `false` | Enable the CNPG operator (See. https://artifacthub.io/packages/helm/cloudnative-pg/cloudnative-pg). |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
