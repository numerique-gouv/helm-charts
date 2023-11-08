resource "helm_release" "minio" {
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "minio"
  version    = "12.8.15"
  namespace  = "grist"
  name       = "minio"
  values = [
    <<-EOT
    auth:
      rootUser: gristgristgrist
      rootPassword: gristgristgrist
    provisionning:
      config:
        - name: region
          options:
            name: local
      buckets:
        - name: grist
          region: local
          versioning: true
    EOT
  ]
}
