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
    

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.9.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.20.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | n/a |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.9.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google-beta_google_container_cluster.container_cluster](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_container_cluster) | resource |
| [google_container_node_pool.primary_preemptible_nodes](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool) | resource |
| [helm_release.nginx_ingress](https://registry.terraform.io/providers/hashicorp/helm/2.9.0/docs/resources/release) | resource |
| [google_client_config.client_config](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |
| [google_client_config.provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |
| [google_compute_network.network](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_network) | data source |
| [google_compute_subnetwork.network-with-private-secondary-ip-ranges](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_subnetwork) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_autoscaling_enabled"></a> [autoscaling\_enabled](#input\_autoscaling\_enabled) | set autoscaling true or false | `bool` | `false` | no |
| <a name="input_autoscaling_max_nodes"></a> [autoscaling\_max\_nodes](#input\_autoscaling\_max\_nodes) | max number of nodes allowed | `number` | `1` | no |
| <a name="input_autoscaling_min_nodes"></a> [autoscaling\_min\_nodes](#input\_autoscaling\_min\_nodes) | min number of nodes allocation | `number` | `1` | no |
| <a name="input_autoscaling_strategy"></a> [autoscaling\_strategy](#input\_autoscaling\_strategy) | GKE autoscaling strategy | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the GKE cluster we will create | `string` | n/a | yes |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | Default size of the node Disk | `string` | n/a | yes |
| <a name="input_disk_type"></a> [disk\_type](#input\_disk\_type) | 'pd-standard', 'pd-balanced' or 'pd-ssd' | `string` | n/a | yes |
| <a name="input_guest_accelerator"></a> [guest\_accelerator](#input\_guest\_accelerator) | GPU or TPU to attach to the virtual-machine. | `string` | n/a | yes |
| <a name="input_guest_accelerator_count"></a> [guest\_accelerator\_count](#input\_guest\_accelerator\_count) | Number of accelerators to attach to each machine | `number` | n/a | yes |
| <a name="input_initial_node_count"></a> [initial\_node\_count](#input\_initial\_node\_count) | Number of nodes the GKE cluster starts with | `number` | `1` | no |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | The virtual amchine type to use for the node pool | `string` | n/a | yes |
| <a name="input_main_availability_zone"></a> [main\_availability\_zone](#input\_main\_availability\_zone) | the gcp region we do all of this in | `string` | n/a | yes |
| <a name="input_node_service_account"></a> [node\_service\_account](#input\_node\_service\_account) | The SA we will use to control nodes on the GKE cluster | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP project id (gcloud projects list) | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | the gcp region we do all of this in | `string` | n/a | yes |
| <a name="input_state_bucket_name"></a> [state\_bucket\_name](#input\_state\_bucket\_name) | the name of the bucker we are going to store our state in | `string` | n/a | yes |
| <a name="input_state_path"></a> [state\_path](#input\_state\_path) | directory where we store state | `string` | n/a | yes |
| <a name="input_use_default_node_pool"></a> [use\_default\_node\_pool](#input\_use\_default\_node\_pool) | True=use the deafult GKE node pool, Fale=use seprately managed pool | `bool` | n/a | yes |
| <a name="input_vpc_network_name"></a> [vpc\_network\_name](#input\_vpc\_network\_name) | name of the VPC network our machines will live in | `string` | n/a | yes |
| <a name="input_vpc_network_subnet_name"></a> [vpc\_network\_subnet\_name](#input\_vpc\_network\_subnet\_name) | name of the VPC subnetwork our machines will live in | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | n/a |
<!-- END_TF_DOCS -->