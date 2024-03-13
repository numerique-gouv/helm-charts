resource "kubernetes_namespace_v1" "grist" {
  metadata {
    name = "grist"
  }
}
