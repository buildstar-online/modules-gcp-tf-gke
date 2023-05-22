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

provider "kubernetes" {
  host  = "https://${google_container_cluster.container_cluster.endpoint}"
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(
    google_container_cluster.container_cluster.master_auth[0].cluster_ca_certificate,
  )
}

provider "helm" {
  kubernetes {
  host  = "https://${google_container_cluster.container_cluster.endpoint}"
    token = data.google_client_config.provider.access_token
    cluster_ca_certificate = base64decode(
      google_container_cluster.container_cluster.master_auth[0].cluster_ca_certificate
    )
  }
}
