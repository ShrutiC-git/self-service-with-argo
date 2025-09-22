terraform {
    required_providers {
        kubernetes = {
            source = "hashicorp/kubernetes"
            version = "~>2.30"
        }
    }
}

provider "kubernetes" {
    config_path = var.kubeconfig_path
}