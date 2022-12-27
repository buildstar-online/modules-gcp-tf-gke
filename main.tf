# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
# Basic GKE Kubernetes cluster utilizing the default node pool.

resource "google_container_cluster" "container_cluster" {
  provider                 = google-beta
  name                     = var.cluster_name
  location                 = var.region
  subnetwork               = var.vpc_network_subnet_name
  remove_default_node_pool = var.use_default_node_pool
  initial_node_count       = var.initial_node_count

  node_config {
    disk_type    = var.disk_type
    machine_type = var.machine_type
  }

  cluster_autoscaling {
    enabled             = var.autoscaling_enabled
    autoscaling_profile = var.autoscaling_strategy
    resource_limits {
      resource_type = "memory"
      minimum       = var.autoscaling_min_mem
      maximum       = var.autoscaling_max_mem

    }
    resource_limits {
      resource_type = "cpu"
      minimum       = var.autoscaling_min_cpu
      maximum       = var.autoscaling_max_cpu
    }
    auto_provisioning_defaults {
      service_account = var.node_service_account
    }
  }
}

output "endpoint" {
  value = google_container_cluster.container_cluster.endpoint
}
