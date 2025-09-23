resource "random_password" "rabbitmq_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "kubernetes_secret" "rabbitmq_secret" {
  metadata {
    name      = "rabbitmq-secret"
    namespace = kubernetes_namespace.ns["messaging"].metadata[0].name
  }

  data = {
    RABBITMQ_DEFAULT_USER = "user" # Use a non-default username
    RABBITMQ_DEFAULT_PASS = random_password.rabbitmq_password.result
  }

  type = "Opaque"
}