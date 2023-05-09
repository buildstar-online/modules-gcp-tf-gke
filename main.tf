# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
# Basic GKE Kubernetes cluster utilizing the default node pool.

resource "google_container_cluster" "container_cluster" {
  provider                 = google-beta
  name                     = var.cluster_name
  location                 = var.region
  network                  = var.vpc_network_name
  subnetwork               = var.vpc_network_subnet_name
  remove_default_node_pool = true
  initial_node_count       = var.initial_node_count

  node_locations = [
    "europe-west4-a"
//    "europe-west4-b",
//    "europe-west4-c"
  ]
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "my-node-pool"
  location   = var.region
  cluster    = google_container_cluster.container_cluster.name
  node_count = 1

  node_config {
    spot         = true
    # https://cloud.google.com/kubernetes-engine/docs/how-to/preemptible-vms
    # preemptible = false
    # reservation_affinity 
    image_type   = "ubuntu_containerd"
    machine_type = var.machine_type
    disk_type    = var.disk_type
    disk_size_gb = var.disk_size
    # local_ssd_count
    # min_cpu_platform 
    # https://cloud.google.com/compute/docs/instances/specify-min-cpu-platform
    service_account = var.node_service_account
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    advanced_machine_features {
      threads_per_core = 2
      gvnic = disabled
      guest_accelerator {
        type  = var.guest_accelerator
        count = var.guest_accelerator_count
        # https://docs.nvidia.com/datacenter/tesla/mig-user-guide/#partitioning
        # gpu_partition_size 
        # gpu_sharing_config
        }    
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
