terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
      version = ">=2.9.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = ">=2.20.0"
    }
    google-beta = {
      source = "hashicorp/google-beta"
      version = ">=4.47.0"
    }
  }
}
