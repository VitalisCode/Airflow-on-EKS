output "release_name" {
  value = helm_release.this.name
}

output "namespace" {
  value = kubernetes_namespace.this.metadata[0].name
}
