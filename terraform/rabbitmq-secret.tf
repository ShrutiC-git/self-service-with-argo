resource "random_password" "rabbitmq_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "kubernetes_secret" "rabbitmq_secret" {
  for_each = { for k, v in var.namespaces : k => v if contains(["messaging", "services", "ai-jobs"], k) }

  metadata {
    name      = "rabbitmq-secret"
    namespace = each.value.name
  }

  data = {
    RABBITMQ_DEFAULT_USER = "user" # Use a non-default username
    RABBITMQ_DEFAULT_PASS = random_password.rabbitmq_password.result
  }

  type = "Opaque"
}