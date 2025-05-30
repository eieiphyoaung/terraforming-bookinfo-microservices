data "terraform_remote_state" "namespace" {
  backend = "remote"

  config = {
    organization = "eieiphyo-ycc-org"
    workspaces = {
      name = "namespace"
    }
  }
}
resource "kubernetes_service" "ratings-svc" {
  metadata {
    name = var.service_name
    labels = {
      app     = "ratings"
      service = "ratings"
    }
    namespace = data.terraform_remote_state.namespace.outputs.namespace_name
  }
  spec {
    selector = {
      app = "ratings"
    }
    port {
      port = 9080
      name = "http"
    }
  }
}
resource "kubernetes_service_account" "ratings-sa" {
  metadata {
    name = var.service_account_name
    labels = {
      account = "ratings"
    }
    namespace = data.terraform_remote_state.namespace.outputs.namespace_name
  }
}

resource "kubernetes_deployment" "ratings-deployment" {
  metadata {
    name = var.deployment_name
    labels = {
      app     = "ratings"
      version = "v1"
    }
    namespace = data.terraform_remote_state.namespace.outputs.namespace_name
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app     = "ratings"
        version = "v1"
      }
    }

    template {
      metadata {
        labels = {
          app     = "ratings"
          version = "v1"
        }
      }

      spec {
        service_account_name = var.service_account_name
        container {
          image             = "ei2000/bookinfo-ratings-v1:1.20.3"
          name              = "ratings"
          image_pull_policy = "IfNotPresent"
          port {
            container_port = 9080
          }
        }
      }
    }
  }
}

