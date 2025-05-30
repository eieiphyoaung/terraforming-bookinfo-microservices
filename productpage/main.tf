data "terraform_remote_state" "namespace" {
  backend = "remote"

  config = {
    organization = "eieiphyo-ycc-org"
    workspaces = {
      name = "namespace"
    }
  }
}
resource "kubernetes_service" "productpage-svc" {
  metadata {
    name = var.service_name
    labels = {
      app     = "productpage"
      service = "productpage"
    }
    namespace = data.terraform_remote_state.namespace.outputs.namespace_name
  }
  spec {
    selector = {
      app = "productpage"
    }
    port {
      port = 9080
      name = "http"
    }
  }
}
resource "kubernetes_service_account" "productpage-sa" {
  metadata {
    name = var.service_account_name
    labels = {
      account = "productpage"
    }
    namespace = data.terraform_remote_state.namespace.outputs.namespace_name
  }
}

resource "kubernetes_deployment" "productpage-deployment" {
  metadata {
    name = var.deployment_name
    labels = {
      app     = "productpage"
      version = "v1"
    }
    namespace = data.terraform_remote_state.namespace.outputs.namespace_name
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app     = "productpage"
        version = "v1"
      }
    }

    template {
      metadata {
        annotations = {
          "prometheus.io/scrape" = "true"
          "prometheus.io/port"   = "9080"
          "prometheus.io/path"   = "/metrics"
        }
        labels = {
          app     = "productpage"
          version = "v1"
        }
      }

      spec {
        service_account_name = var.service_account_name
        container {
          image             = "ei2000/bookinfo-productpage-v1:1.20.3"
          name              = "productpage"
          image_pull_policy = "IfNotPresent"
          port {
            container_port = 9080
          }
          volume_mount {
            name       = "tmp"
            mount_path = "/tmp"
          }
        }
        volume {
          name = "tmp"
          empty_dir {}
        }
      }
    }
  }
}

