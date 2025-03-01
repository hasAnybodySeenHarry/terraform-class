resource "kubernetes_deployment" "dummy_app" {
  metadata {
    name      = "dummy-app"
    namespace = "default"
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "dummy-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "dummy-app"
        }
      }

      spec {
        container {
          name  = "dummy-app"
          image = "demona9458/dummy-app:v1.0.0"
          port {
            container_port = 8080
          }

          env {
            name = "DB_USER"
            value_from {
              secret_key_ref {
                key  = "DB_USER"
                name = kubernetes_secret.db_creds.metadata[0].name
              }
            }
          }

          env {
            name = "DB_PASSWORD"
            value_from {
              secret_key_ref {
                key  = "DB_PASSWORD"
                name = kubernetes_secret.db_creds.metadata[0].name
              }
            }
          }

          env {
            name = "DB_HOST"
            value_from {
              secret_key_ref {
                key  = "DB_HOST"
                name = kubernetes_secret.db_creds.metadata[0].name
              }
            }
          }

          env {
            name  = "DB_PORT"
            value = "5432"
          }

          env {
            name = "DB_NAME"
            value_from {
              secret_key_ref {
                key  = "DB_NAME"
                name = kubernetes_secret.db_creds.metadata[0].name
              }
            }
          }

          env {
            name  = "CONN_MODE"
            value = "disable"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "dummy_app_service" {
  metadata {
    name      = "dummy-app-service"
    namespace = "default"
  }

  spec {
    selector = {
      app = kubernetes_deployment.dummy_app.metadata[0].name
    }

    port {
      port        = 8080
      target_port = 8080
    }

    type = "ClusterIP"
  }
}
