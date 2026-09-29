resource "kubernetes_storage_class_v1" "efs" {
  metadata {
    name = "efs-sc"
  }

  storage_provisioner    = "efs.csi.aws.com"
  reclaim_policy         = "Retain"
  volume_binding_mode    = "WaitForFirstConsumer"
  allow_volume_expansion = true
  mount_options          = ["tls"]

  parameters = {
    fileSystemId   = module.efs.file_system_id
    accessPointId  = module.efs.access_point_id
    directoryPerms = "700"
  }

  depends_on = [module.addons, module.efs]
}

module "airflow" {
  source              = "./modules/airflow"
  release_name        = "airflow"
  values_file         = "${path.module}/modules/airflow/values.yaml"
  efs_file_system_id  = module.efs.file_system_id
  efs_access_point_id = module.efs.access_point_id
  database_host       = module.rds.endpoint
  database_name       = var.database_name
  database_user       = var.database_user
  database_password   = local.database_password
  depends_on          = [module.addons, module.efs, module.rds, kubernetes_storage_class_v1.efs]
}
