resource "kubernetes_pod" "postgres" {
  metadata {
    name      = "postgres"
    namespace = "default"
    labels = {
      app = "postgres"
    }
  }

  spec {
    container {
      name  = "postgres"
      image = "postgres:latest"

      env {
        name = "POSTGRES_USER"
        value_from {
          secret_key_ref {
            key  = "DB_USER"
            name = kubernetes_secret.db_creds.metadata[0].name
          }
        }
      }

      env {
        name = "POSTGRES_PASSWORD"
        value_from {
          secret_key_ref {
            key  = "DB_PASSWORD"
            name = kubernetes_secret.db_creds.metadata[0].name
          }
        }
      }

      env {
        name = "POSTGRES_DB"
        value_from {
          secret_key_ref {
            key  = "DB_NAME"
            name = kubernetes_secret.db_creds.metadata[0].name
          }
        }
      }

      port {
        container_port = 5432
      }
    }
  }
}

resource "kubernetes_service" "postgres_service" {
  metadata {
    name      = "postgres-service"
    namespace = "default"
  }

  spec {
    selector = {
      app = kubernetes_pod.postgres.metadata[0].name
    }

    port {
      port        = 5432
      target_port = 5432
    }

    type = "ClusterIP"
  }
}
