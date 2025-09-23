resource "kubernetes_persistent_volume_claim" "artifacts" {
  metadata {
    name      = "model-artifacts"
    namespace = kubernetes_namespace.ns["ai-jobs"].metadata[0].name
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "1Gi"
      }
    }
    storage_class_name = "standard"
  }
}
