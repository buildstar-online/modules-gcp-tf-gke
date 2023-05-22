data "google_client_config" "provider" {
}


data "http" "nvidia_driver_installer_manifest" {
  url = "https://raw.githubusercontent.com/GoogleCloudPlatform/container-engine-accelerators/master/nvidia-driver-installer/ubuntu/daemonset-preloaded.yaml"
}

resource "kubernetes_manifest" "nvidia_driver_installer" {
  manifest = yamldecode(data.http.nvidia_driver_installer_manifest.response_body)
}
  
resource "helm_release" "nginx_ingress" {
  name             = "ingress-nginx"
  namespace        = "ingress-nginx"
  create_namespace = true
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
}
