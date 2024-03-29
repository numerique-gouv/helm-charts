resource "helm_release" "postgresql" {
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "postgresql"
  version    = "13.1.5"
  namespace  = "grist"
  name       = "postgresql"
  values = [
    <<-EOT
    auth:
      username: grist
      password: grist
      database: grist
    tls:
      enabled: true
      autoGenerated: true
    EOT
  ]
}
