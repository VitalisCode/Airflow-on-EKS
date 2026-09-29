locals {
  common_tags = {
    Environment = var.environment
    Project     = "airflow-on-eks"
  }

  database_secret_name = coalesce(var.database_secret_name, "${var.cluster_name}-database-password")
  database_password    = coalesce(var.database_password, random_password.database.result)
}

resource "random_password" "database" {
  length  = 32
  special = true
}

resource "aws_secretsmanager_secret" "database" {
  name                    = local.database_secret_name
  recovery_window_in_days = 0
  tags                    = local.common_tags
}

resource "aws_secretsmanager_secret_version" "database" {
  secret_id = aws_secretsmanager_secret.database.id
  secret_string = jsonencode({
    username = var.database_user
    password = local.database_password
  })
}

module "addons" {
  source          = "./modules/addons"
  cluster_name    = module.eks.cluster_name
  cluster_version = var.kubernetes_version
  addons = {
    vpc-cni            = {}
    kube-proxy         = {}
    coredns            = {}
    aws-efs-csi-driver = {}
  }
  depends_on = [module.eks]
}