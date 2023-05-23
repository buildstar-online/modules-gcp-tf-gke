data "google_client_config" "provider" {
}

provider "kubernetes" {
  host  = "https://${google_container_cluster.container_cluster.endpoint}"
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(
    google_container_cluster.container_cluster.master_auth[0].cluster_ca_certificate,
  )
}

provider "helm" {
  kubernetes {
  host  = "https://${google_container_cluster.container_cluster.endpoint}"
    token = data.google_client_config.provider.access_token
    cluster_ca_certificate = base64decode(
      google_container_cluster.container_cluster.master_auth[0].cluster_ca_certificate
    )
  }
}

/*
data "http" "nvidia_driver_installer_manifest" {
  url = "https://raw.githubusercontent.com/GoogleCloudPlatform/container-engine-accelerators/master/nvidia-driver-installer/ubuntu/daemonset-preloaded.yaml"
}

resource "kubernetes_manifest" "nvidia_driver_installer" {
  manifest = yamldecode(data.http.nvidia_driver_installer_manifest.response_body)
}
*/

resource "helm_release" "nginx_ingress" {
  name             = "ingress-nginx"
  namespace        = "ingress-nginx"
  create_namespace = true
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
}

/*
resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  namespace        = "kube-system"
  create_namespace = true
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  depends_on = [
    helm_release.nginx_ingress
  ]
}
*/
  
/*
resource "kubernetes_manifest" "cluster-issuer" {
  manifest = yamldecode(<<-EOF
    apiVersion: cert-manager.io/v1
    kind: ClusterIssuer
    metadata:
      name: letsencrypt-staging
    spec:
      acme:
        server: https://acme-staging-v02.api.letsencrypt.org/directory
        email: admin@cloudydev.net
        privateKeySecretRef:
          name: letsencrypt-staging
        solvers:
        - http01:
            ingress:
              class: nginx
    EOF
  )
  depends_on = [
    helm_release.cert_manager
  ]
}
*/
