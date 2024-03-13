resource "kubernetes_deployment_v1" "keycloak" {
  metadata {
    namespace = "grist"
    name      = "keycloak"
  }
  spec {
    selector {
      match_labels = {
        "app.kubernetes.io/name"     = "keycloak"
        "app.kubernetes.io/instance" = "keycloak"
      }
    }
    template {
      metadata {
        labels = {
          "app.kubernetes.io/name"     = "keycloak"
          "app.kubernetes.io/instance" = "keycloak"
        }
      }
      spec {
        container {
          image   = "quay.io/keycloak/keycloak:22.0"
          name    = "keycloak"
          command = ["sh"]
          args = [
            "-c",
            "/opt/keycloak/bin/kc.sh import --file /opt/keycloak/import/grist.json && /opt/keycloak/bin/kc.sh start",
          ]
          env {
            name  = "KEYCLOAK_ADMIN"
            value = "su"
          }
          env {
            name  = "KEYCLOAK_ADMIN_PASSWORD"
            value = "su"
          }
          env {
            name  = "KC_PROXY"
            value = "edge"
          }
          env {
            name  = "KC_HOSTNAME_URL"
            value = "https://keycloak.minikube.local"
          }
          volume_mount {
            name       = "keycloak"
            mount_path = "/opt/keycloak/import"
          }
          port {
            protocol       = "TCP"
            name           = "http"
            container_port = "8080"
          }
        }
        volume {
          name = "keycloak"
          config_map {
            name = "keycloak"
          }
        }
      }
    }
  }
}
resource "kubernetes_config_map_v1" "keycloak" {
  metadata {
    name      = "keycloak"
    namespace = "grist"
  }
  data = {
    "grist.json" = replace(file("${path.module}/../docker_compose/grist.json"), "http://grist.docker.localhost:8080", "https://grist.minikube.local")
  }
}
resource "kubernetes_service_v1" "keycloak" {
  metadata {
    name      = "keycloak"
    namespace = "grist"
  }
  spec {
    selector = {
      "app.kubernetes.io/name"     = "keycloak"
      "app.kubernetes.io/instance" = "keycloak"
    }
    port {
      port        = 80
      target_port = 8080
    }
  }
}
resource "kubernetes_ingress_v1" "keycloak" {
  metadata {
    name      = "keycloak"
    namespace = "grist"
  }
  spec {
    tls {
      hosts       = ["keycloak.minikube.local"]
      secret_name = "keycloak-tls"
    }
    rule {
      host = "keycloak.minikube.local"
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "keycloak"
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}
