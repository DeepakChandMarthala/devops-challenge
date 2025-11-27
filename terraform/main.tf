terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.32"
    }
  }
}

provider "kubernetes" {
  config_path = "C:/Users/admin/.kube/config"
}

resource "kubernetes_namespace" "devops_challenge" {
  metadata {
    name = "devops-challenge"
  }
}

resource "kubernetes_resource_quota" "memory_quota" {
  metadata {
    name      = "memory-quota"
    namespace = kubernetes_namespace.devops_challenge.metadata.0.name
  }

  spec {
    hard = {
      "limits.memory" = "512Mi"
    }
  }
}
