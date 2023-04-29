# Projec Options
project_id        = ""
state_bucket_name = ""
state_path        = "terraform/state"
credentials_path  = ""

# Geographic Options
main_availability_zone = "europe-west4-a"
region                 = "europe-west4"

# Network
vpc_network_name        = "default"
vpc_network_subnet_name = "default"

# GKE Cluster Options
use_default_node_pool = "false"
cluster_name          = "three-vms-in-a-trenchcoat"
node_service_account  = ""
machine_type          = "e2-medium"
disk_type             = "pd-ssd"

# Autoscaling Options
autoscaling_enabled  = "true"
autoscaling_strategy = "OPTIMIZE_UTILIZATION"
autoscaling_min_cpu  = "1"
autoscaling_max_cpu  = "80"
autoscaling_min_mem  = "10"
autoscaling_max_mem  = "100"

# App deployment vars
app_name        = "Hello-GKE"
app_slug        = "hellogke"
container_image = "nginxdemos/hello"
container_name  = "hello"
replicas        = 3
guaranteed_mem  = "150Mi"
guaranteed_cpu  = "250m"
app_label       = "hello"
app_namespace   = "hello"

# lets-encrypt vars
api_token = ""
username = ""
url = ""
url_alternative = ""

# App Service Vars
port        = "80" #string
target_port = 80
