resource "kubernetes_namespace" "bookinfo-ns" {
  metadata {
    name = var.namespace-name
  }
}

output "namespace_name" {
  value = kubernetes_namespace.bookinfo-ns.metadata[0].name
}