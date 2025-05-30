data "terraform_remote_state" "namespace" {
  backend = "remote"

  config = {
    organization = "eieiphyo-ycc-org"
    workspaces = {
      name = "namespace"
    }
  }
}
resource "kubernetes_service" "reviews-svc" {
  metadata {
    name = var.service_name
    labels = {
      app     = "reviews"
      service = "reviews"
    }
    namespace = data.terraform_remote_state.namespace.outputs.namespace_name
  }
  spec {
    selector = {
      app = "reviews"
    }
    port {
      port = 9080
      name = "http"
    }
  }
}
resource "kubernetes_service_account" "reviews-sa" {
  metadata {
    name = var.service_account_name
    labels = {
      account = "reviews"
    }
    namespace = data.terraform_remote_state.namespace.outputs.namespace_name
  }
}

resource "kubernetes_deployment" "reviews-deployment" {
  metadata {
    name = var.deployment_name1
    labels = {
      app     = "reviews"
      version = "v1"
    }
    namespace = data.terraform_remote_state.namespace.outputs.namespace_name
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app     = "reviews"
        version = "v1"
      }
    }

    template {
      metadata {
        labels = {
          app     = "reviews"
          version = "v1"
        }
      }

      spec {
        service_account_name = var.service_account_name
        container {
          image             = "ei2000/bookinfo-reviews-v1:1.20.3"
          name              = "reviews"
          image_pull_policy = "IfNotPresent"
          env {
            name = "LOG_DIR"
            value = "/tmp/logs"
          }
          port {
            container_port = 9080
          }
          volume_mount {
            name       = "tmp"
            mount_path = "/tmp"
          }
          volume_mount {
            name       = "wlp-output"
            mount_path = "/opt/ibm/wlp/output"
          }
        }
        volume {
          name = "tmp"
          empty_dir {}
        }
        volume {
          name = "wlp-output"
          empty_dir {}
        }
      }
    }
  }
}

resource "kubernetes_deployment" "reviews-deployment2" {
  metadata {
    name = var.deployment_name2
    labels = {
      app     = "reviews"
      version = "v2"
    }
    namespace = data.terraform_remote_state.namespace.outputs.namespace_name
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app     = "reviews"
        version = "v2"
      }
    }

    template {
      metadata {
        labels = {
          app     = "reviews"
          version = "v2"
        }
      }

      spec {
        service_account_name = var.service_account_name
        container {
          image             = "ei2000/bookinfo-reviews-v2:1.20.3"
          name              = "reviews"
          image_pull_policy = "IfNotPresent"
          env {
            name = "LOG_DIR"
            value = "/tmp/logs"
          }
          port {
            container_port = 9080
          }
          volume_mount {
            name       = "tmp"
            mount_path = "/tmp"
          }
          volume_mount {
            name       = "wlp-output"
            mount_path = "/opt/ibm/wlp/output"
          }
        }
        volume {
          name = "tmp"
          empty_dir {}
        }
        volume {
          name = "wlp-output"
          empty_dir {}
        }
      }
    }
  }
}

resource "kubernetes_deployment" "reviews-deployment3" {
  metadata {
    name = var.deployment_name3
    labels = {
      app     = "reviews"
      version = "v3"
    }
    namespace = data.terraform_remote_state.namespace.outputs.namespace_name
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app     = "reviews"
        version = "v3"
      }
    }

    template {
      metadata {
        labels = {
          app     = "reviews"
          version = "v3"
        }
      }

      spec {
        service_account_name = var.service_account_name
        container {
          image             = "ei2000/bookinfo-reviews-v3:1.20.3"
          name              = "reviews"
          image_pull_policy = "IfNotPresent"
          env {
            name = "LOG_DIR"
            value = "/tmp/logs"
          }
          port {
            container_port = 9080
          }
          volume_mount {
            name       = "tmp"
            mount_path = "/tmp"
          }
          volume_mount {
            name       = "wlp-output"
            mount_path = "/opt/ibm/wlp/output"
          }
        }
        volume {
          name = "tmp"
          empty_dir {}
        }
        volume {
          name = "wlp-output"
          empty_dir {}
        }
      }
    }
  }
}

