# Assets the are presumed to already exist

data "google_compute_network" "network" {
  name                    = var.vpc_network_name
}

data "google_compute_subnetwork" "network-with-private-secondary-ip-ranges" {
  name          = var.vpc_network_subnet_name
}

data "google_client_config" "client_config" {

}
