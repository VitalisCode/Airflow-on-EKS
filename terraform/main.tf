locals {
  common_tags = {
    Environment = var.environment
    Project     = "airflow-on-eks"
  }
}

module "addons" {
  source          = "./modules/addons"
  cluster_name    = module.eks.cluster_name
  cluster_version = var.kubernetes_version
  depends_on      = [module.eks]
}