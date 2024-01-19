resource "helm_release" "redis" {
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "redis"
  version    = "18.1.5"
  namespace  = "grist"
  name       = "redis"
  values = [
    <<-EOT
    architecture: standalone
    auth:
      enabled: true
      password: grist
    master:
      disableCommands: []
    EOT
  ]
}
