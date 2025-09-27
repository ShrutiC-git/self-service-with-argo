variable "kubeconfig_path" {
  type        = string
  description = "Path to the kubeconfig file."
  default     = "~/.kube/config"
}

variable "namespaces" {
  description = "A map of namespace configurations. Each key is a logical name for the namespace."
  type = map(object({
    name = string
    quota = optional(map(string))
    rbac = optional(object({
      service_account_name = string
      role_name            = string
      rules = list(object({
        api_groups = list(string)
        resources  = list(string)
        verbs      = list(string)
      }))
    }))
  }))
  default = {
    "infra"     = { name = "infra" },
    "services" = {
      name = "services"
      rbac = {
        service_account_name = "dev-sa"
        role_name            = "dev-role"
        rules = [{
          api_groups = [""]
          resources  = ["pods", "deployments", "services", "secrets", "configmaps", "persistentvolumeclaims"]
          verbs      = ["get", "list", "watch", "create", "update", "patch", "delete"]
        }]
      }
    },
    "ai-jobs" = {
      name = "ai-jobs"
      quota = {
        pods              = "10",
        "requests.cpu"    = "2",
        "requests.memory" = "4Gi",
        "limits.cpu"      = "4",
        "limits.memory"   = "8Gi"
      }
      rbac = {
        service_account_name = "ai-sa"
        role_name            = "ai-role"
        rules = [{
          api_groups = [""]
          resources  = ["pods", "deployments", "services", "secrets", "configmaps", "persistentvolumeclaims"]
          verbs      = ["get", "list", "watch", "create", "update", "patch", "delete"]
        }]
      }
    },
    "kyverno"   = { name = "kyverno" },
    "messaging" = { name = "messaging" },
    "data"      = { name = "data" }
  }
}