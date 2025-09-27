resource "random_password" "minio_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "kubernetes_secret" "minio_secret" {
  for_each = { for k, v in var.namespaces : k => v if contains(["infra","services", "ai-jobs"], k) }

  metadata {
    name      = "minio-secret"
    namespace = each.value.name
  }

  data = {
    MINIO_ACCESS_KEY = "minioadmin" # Use a non-default username
    MINIO_SECRET_KEY = random_password.minio_password.result
  }

  type = "Opaque"
}