resource "kubernetes_namespace" "this" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "this" {
  name       = var.release_name
  namespace  = kubernetes_namespace.this.metadata[0].name
  repository = "https://airflow.apache.org"
  chart      = "airflow"
  version    = var.chart_version
  values     = [file(var.values_file)]

  set {
    name  = "data.metadataConnection.host"
    value = var.database_host
  }
  set {
    name  = "data.metadataConnection.db"
    value = var.database_name
  }
  set {
    name  = "data.metadataConnection.user"
    value = var.database_user
  }
  set_sensitive {
    name  = "data.metadataConnection.pass"
    value = var.database_password
  }
  set {
    name  = "dags.persistence.enabled"
    value = "true"
  }
  set {
    name  = "dags.persistence.storageClassName"
    value = "efs-sc"
  }
  set {
    name  = "dags.persistence.accessMode"
    value = "ReadWriteMany"
  }

  depends_on = [kubernetes_namespace.this]
}
