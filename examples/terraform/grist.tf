resource "helm_release" "grist" {
  chart     = "../../helm_chart"
  name      = "grist"
  namespace = "grist"
  values = [
    <<-EOT
    image:
      tag: 1.1.7
    commonEnvVars: &commonEnvVars
      APP_HOME_URL: https://grist.minikube.local
      GRIST_FORWARD_AUTH_HEADER: X-Forwarded-User
      GRIST_FORWARD_AUTH_LOGOUT_PATH: _oauth/logout
      GRIST_ORG_IN_PATH: "true"
      GRIST_DEFAULT_EMAIL: "admin@example.org"
      GRIST_SANDBOX_FLAVOR: gvisor
      GRIST_HIDE_UI_ELEMENTS: billing
      APP_STATIC_INCLUDE_CUSTOM_CSS: true
      GRIST_DEFAULT_LOCALE: fr
      GRIST_HELP_CENTER: https://outline.incubateur.anct.gouv.fr/doc/documentation-grist-YPWlYTHa8j
      REDIS_URL: redis://default:grist@redis-master
      GRIST_ANON_PLAYGROUND: false
      PERMITTED_CUSTOM_WIDGETS: "calendar"
      TYPEORM_TYPE: postgres
      TYPEORM_DATABASE: grist
      TYPEORM_HOST: postgresql
      TYPEORM_USERNAME: grist
      TYPEORM_PASSWORD: grist
      GRIST_SINGLE_PORT: 0
      GRIST_ALLOWED_HOSTS: grist.minikube.local

    docWorker:
      replicas: 2
      envVars:
        <<: *commonEnvVars

        GRIST_SERVERS: docs
        GRIST_DOCS_MINIO_BUCKET: grist
        GRIST_DOCS_MINIO_ENDPOINT: minio
        GRIST_DOCS_MINIO_PORT: 9000
        GRIST_DOCS_MINIO_USE_SSL: 0
        GRIST_DOCS_MINIO_BUCKET_REGION: local
        GRIST_DOCS_MINIO_ACCESS_KEY: gristgristgrist
        GRIST_DOCS_MINIO_SECRET_KEY: gristgristgrist

    homeWorker:
      replicas: 2
      envVars:
        <<: *commonEnvVars

        GRIST_SERVERS: home,static

    ingress:
      enabled: true
      host: grist.minikube.local

    forwardAuth:
      enabled: true
      envVars:
        INSECURE_COOKIE: "true"
        DEFAULT_PROVIDER: "generic-oauth"
        SECRET: changeme
        LOGOUT_REDIRECT: https://grist.minikube.local/signed-out
        PROVIDERS_GENERIC_OAUTH_AUTH_URL: https://keycloak.minikube.local/realms/grist/protocol/openid-connect/auth
        PROVIDERS_GENERIC_OAUTH_CLIENT_ID: grist
        PROVIDERS_GENERIC_OAUTH_CLIENT_SECRET: yT00LmUDppwn3s4cFCNPV3Qg95pU14ZQ
        PROVIDERS_GENERIC_OAUTH_SCOPE: openid email organizations
        # Using the service name with http intead of the https URL because we don't have official certificates localy
        PROVIDERS_GENERIC_OAUTH_TOKEN_URL: http://keycloak/realms/grist/protocol/openid-connect/token
        PROVIDERS_GENERIC_OAUTH_USER_URL: http://keycloak/realms/grist/protocol/openid-connect/userinfo
    EOT
  ]
}
