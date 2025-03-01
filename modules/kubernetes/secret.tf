resource "kubernetes_secret" "db_creds" {
  metadata {
    name      = "db-credentials"
    namespace = "default"
  }

  data = {
    DB_USER     = "harry"
    DB_PASSWORD = "password"
    DB_HOST     = "postgres-service"
    DB_NAME     = "users"
  }

  type = "Opaque"
}
