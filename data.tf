# Assets the are presumed to already exist

resource "google_compute_shared_vpc_service_project" "service_project" {
  host_project    = var.project_id
  service_project = var.cluster_name
}

resource "google_compute_network" "network" {
  name                    = var.cluster_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "network-with-private-secondary-ip-ranges" {
  name          = var.cluster_name
  ip_cidr_range = "10.0.0.0/16"
  region        = var.region
  network       = google_compute_network.network.id
  secondary_ip_range {
    range_name    = "${var.cluster_name}-private"
    ip_cidr_range = "192.168.50.0/24"
  }
}

data "google_client_config" "client_config" {

}
