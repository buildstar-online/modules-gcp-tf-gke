variable "project_id" {
  description = "GCP project id (gcloud projects list)"
  type        = string
}

variable "region" {
  description = "the gcp region we do all of this in"
  type        = string
  default     = "europe-west1"
}

variable "main_availability_zone" {
  description = "the gcp region we do all of this in"
  type        = string
  default     = "europe-west1-d"
}

variable "state_bucket_name" {
  description = "the name of the bucker we are going to store our state in"
  type        = string
}

variable "state_path" {
  description = "directory where we store state"
  type        = string
}

variable "credentials_path" {
  description = "directory where we store the credentials file"
  type        = string
}

variable "vpc_network_name" {
  description = "name of the VPC network our machines will live in"
  type        = string
}

variable "vpc_network_subnet_name" {
  description = "name of the VPC subnetwork our machines will live in"
  type        = string
}

variable "use_default_node_pool" {
  description = "True=use the deafult GKE node pool, Fale=use seprately managed pool"
  type        = bool
}

variable "initial_node_count" {
  description = "Number of nodes the GKE cluster starts with"
  type        = number
  default     = 1
}

variable "cluster_name" {
  description = "Name of the GKE cluster we will create"
  type        = string
}

variable "node_service_account" {
  description = "The SA we will use to control nodes on the GKE cluster"
  type        = string
}

variable "autoscaling_enabled" {
  description = "set autoscaling true or false"
  type        = bool
  default     = false
}

variable "autoscaling_min_cpu" {
  description = "min cpu allocation"
  type        = number
}

variable "autoscaling_max_cpu" {
  description = "max cpu allowed"
  type        = number
}

variable "autoscaling_min_mem" {
  description = "min memory allocation"
  type        = number
}

variable "autoscaling_max_mem" {
  description = "max memory allocation"
  type        = number
}

variable "autoscaling_strategy" {
  description = "GKE autoscaling strategy"
  type        = string
}

variable "app_name" {
  description = "name of the application being deplyed"
  type        = string
}

variable "container_image" {
  description = "docker or container repo image url "
  type        = string
}

variable "container_name" {
  description = "name of the container"
  type        = string
}

variable "replicas" {
  description = "number of replicas"
  type        = number
}

variable "guaranteed_mem" {
  description = "minimum amount of memory the application will get"
  type        = string
  default     = "100Mi"
}

variable "guaranteed_cpu" {
  description = "minimum amount of cputime the application will get"
  type        = string
  default     = "500m"
}

variable "port" {
  description = "value"
  type        = string
}

variable "target_port" {
  description = "value"
  type        = number
}

variable "machine_type" {
  description = " The virtual amchine type to use for the node pool"
  type        = string
}

variable "disk_type" {
  description = " 'pd-standard', 'pd-balanced' or 'pd-ssd' "
  type        = string
}

variable "app_slug" {
  description = "app name but without spaces caps or dsashes"
  type        = string
}

variable "app_label" {
  description = "app label"
  type        = string
}

variable "app_namespace" {
  description = "unique namespace for application to be deployed in"
  type        = string
}

variable "api_token" {
  description = "api token for cert-manager dns challenge"
  type = string
}

variable "username" {
  description = "username for the dns challenge"
  type = string
}

variable "url" {
  description = "domain"
  type = string
}

variable "url_alternative" {
  description = "alternative url to domain"
  type = string
}
