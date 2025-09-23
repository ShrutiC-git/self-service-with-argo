resource "kubernetes_persistent_volume_claim" "artifacts" {
  metadata { name="model-artifacts" namespace="ai-jobs" }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources { requests = { storage = "5Gi" } }
  }
}
