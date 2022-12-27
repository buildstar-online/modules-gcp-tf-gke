resource "kubernetes_namespace" "namespace" {
  metadata {
    annotations = {
      name = "hello"
    }

    labels = {
      app = "hello"
    }

    name = "hello"
  }
}


resource "kubernetes_deployment" "deployment" {
  provider = kubernetes
  metadata {
    name      = "hello-app"
    namespace = kubernetes_namespace.namespace.id
    labels = {
      app = "hello"
    }
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = "hello"
      }
    }

    template {
      metadata {
        labels = {
          app = "hello"
        }
      }

      spec {
        container {
          image = var.container_image
          name  = var.container_name

          resources {
            requests = {
              cpu    = "250m"
              memory = "150Mi"
            }
          }

          liveness_probe {
            http_get {
              path = "/"
              port = 80
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}
