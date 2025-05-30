data "terraform_remote_state" "namespace" {
  backend = "remote"

  config = {
    organization = "eieiphyo-ycc-org"
    workspaces = {
      name = "namespace"
    }
  }
}
resource "kubernetes_service" "details-svc" {
  metadata {
    name = var.service_name
    labels = {
      app     = "details"
      service = "details"
    }
    namespace = data.terraform_remote_state.namespace.outputs.namespace_name
  }
  spec {
    selector = {
      app = "details"
    }
    port {
      port = 9080
      name = "http"
    }
  }
}
resource "kubernetes_service_account" "details-sa" {
  metadata {
    name = var.service_account_name
    labels = {
      account = "details"
    }
    namespace = data.terraform_remote_state.namespace.outputs.namespace_name
  }
}

resource "kubernetes_deployment" "details-deployment" {
  metadata {
    name = var.deployment_name
    labels = {
      app     = "details"
      version = "v1"
    }
    namespace = data.terraform_remote_state.namespace.outputs.namespace_name
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app     = "details"
        version = "v1"
      }
    }

    template {
      metadata {
        labels = {
          app     = "details"
          version = "v1"
        }
      }

      spec {
        service_account_name = var.service_account_name
        container {
          image             = "ei2000/bookinfo-details-v1:1.20.3"
          name              = "details"
          image_pull_policy = "IfNotPresent"
          port {
            container_port = 9080
          }
        }
      }
    }
  }
}

