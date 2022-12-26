# modules-gcp-gke

A Basic GKE Kubernetes cluster utilizing the default node pool. 

```hcl
resource "google_container_cluster" "container_cluster" {
  provider                 = google-beta
  name                     = var.cluster_name
  location                 = var.region
  subnetwork               = data.google_compute_subnetwork.compute_subnetwork.id
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
```

## Costs and Products

The default vm created by the node-pool is an e2-medium.

1 vcore (half a real core)
4GB memory

From: https://cloud.google.com/compute/vm-instance-pricing

Unlike predefined machine types and custom machine types, shared-core machine types are not billed on their individual resources. Each machine type has a defined price for both vCPUs and memory. E2 shared-core machines with committed use discount contracts consume cores in the following manner:

    e2-micro: 0.25 cores
    e2-small: 0.50 cores
    e2-medium: 1.0 cores

e2-medium instances get 50% of 2 vCPUs and are allowed to burst up to 2 full vCPUs for short periods.

price per hour: $0.036857
price per month: $26.91

## Connecting to your cluster

- get your kubeconfig from gcloud

    ```bash
    gcloud container clusters get-credentials <cluster-name> --zone=<your zone>
    ```
    

## Whats NOT in this project (yet)

This does NOT include a bastion jump box, firewall rules, or workload identities. These will be done later in a GKE or Compute VM specific repo. This is just for the basics you need to have terraform manage the life-cycle of GCP projects.

This guide is meant to be a low-effort general solution/example.

If you need a more in-depth guides on GKE, I would recommend reading:

- [GKE private cluster with a bastion host](https://medium.com/google-cloud/gke-private-cluster-with-a-bastion-host-5480b44793a7) by Peter Hrvola
- [How to use a Private Cluster in Kubernetes Engine](https://github.com/GoogleCloudPlatform/gke-private-cluster-demo) by the GCP team
- [Google Cloud Workload Identity with Kubernetes and Terraform](https://www.cobalt.io/blog/google-cloud-workload-identity-with-kubernetes-and-terraform) by Nikola Velkovski
