terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.32"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.11.0"
    }
  }
   required_version = ">= 1.5.0"
}

provider "kubernetes" {
  config_path    = pathexpand("~/.kube/config")
}

provider "helm" {
  kubernetes {
    config_path    = pathexpand("~/.kube/config")
  }
}

