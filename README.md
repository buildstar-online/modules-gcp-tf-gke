# modules-gcp-tf-gke (WiP)

GKE cluster with GPU Nodes 

```hcl
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
    image_type   = "ubuntu_containerd"
    machine_type = var.machine_type
    disk_type    = var.disk_type
    disk_size_gb = 32
    service_account = var.node_service_account
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    guest_accelerator {
      type  = "nvidia-tesla-t4"
      count = 1
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
```

## Connecting to your cluster

- get your kubeconfig from gcloud

    ```bash
    gcloud container clusters get-credentials <cluster-name> --zone=<your zone>
    ```
    
