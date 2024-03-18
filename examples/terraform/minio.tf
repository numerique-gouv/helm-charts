resource "helm_release" "minio" {
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "minio"
  version    = "12.8.15"
  namespace  = "grist"
  name       = "minio"
  values = [
    <<-EOT
    mode: distributed
    auth:
      rootUser: gristgristgrist
      rootPassword: gristgristgrist
    provisioning:
      enabled: true
      buckets:
        - name: grist
          versioning: true
    EOT
  ]
}
