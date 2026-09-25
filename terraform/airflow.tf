module "airflow" {
  source              = "./modules/airflow"
  release_name        = "airflow"
  values_file         = "${path.module}/modules/airflow/values.yaml"
  efs_file_system_id  = module.efs.file_system_id
  efs_access_point_id = module.efs.access_point_id
  database_host       = module.rds.endpoint
  database_name       = var.database_name
  database_user       = var.database_user
  database_password   = var.database_password
  depends_on          = [module.addons, module.efs, module.rds]
}
