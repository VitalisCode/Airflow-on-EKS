module "efs" {
  source             = "./modules/efs"
  name               = var.cluster_name
  subnet_ids         = module.vpc.private_subnet_ids
  security_group_ids = [aws_security_group.efs.id]
  tags               = local.common_tags
}