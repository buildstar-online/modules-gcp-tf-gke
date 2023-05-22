# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
# Basic GKE Kubernetes cluster utilizing the default node pool.

resource "google_iam_workload_identity_pool" "identity_pool" {
  workload_identity_pool_id = "idpool"
}

resource "google_container_cluster" "container_cluster" {
  project                  = var.project_id
  provider                 = google-beta
  name                     = var.cluster_name
  location                 = var.region
  network                  = var.vpc_network_name
  subnetwork               = var.vpc_network_subnet_name
  remove_default_node_pool = true
  initial_node_count       = var.initial_node_count
 
  workload_identity_config {
    workload_pool = "gpu-cloud-init-project.svc.id.goog"
  }

  node_locations = [
    "europe-west4-a"
//    "europe-west4-b",
//    "europe-west4-c"
  ]
}

resource "google_gke_hub_membership" "hub_membership" {
  provider = google-beta
  project = var.project_id
  membership_id = "membersxonly"
  endpoint {
    gke_cluster {
     resource_link = "//container.googleapis.com/${google_container_cluster.container_cluster.id}"
    }
  }
  authority {
    issuer = "https://container.googleapis.com/v1/${google_container_cluster.container_cluster.id}"
  }
}


resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "my-node-pool"
  location   = var.region
  cluster    = google_container_cluster.container_cluster.name
  node_count = 1

  node_config {
    spot         = true
    image_type   = "COS_CONTAINERD"
    machine_type = var.machine_type
    disk_type    = var.disk_type
    disk_size_gb = var.disk_size
    service_account = var.node_service_account
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    guest_accelerator {
      type  = var.guest_accelerator
      count = var.guest_accelerator_count
      }
    }

  autoscaling {
    total_min_node_count = 1
    total_max_node_count = 1
    location_policy = var.autoscaling_strategy
  }
}

output "endpoint" {
  value = google_container_cluster.container_cluster.endpoint
}
