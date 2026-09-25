module "rds" {
  source                 = "./modules/rds"
  identifier             = "${var.cluster_name}-postgres"
  subnet_ids             = module.vpc.private_subnet_ids
  vpc_security_group_ids = [aws_security_group.rds.id]
  engine_version         = "15.6"
  instance_class         = var.rds_instance_class
  allocated_storage      = var.rds_allocated_storage
  database_name          = var.database_name
  master_username        = var.database_user
  master_password        = var.database_password
  tags                   = local.common_tags
}