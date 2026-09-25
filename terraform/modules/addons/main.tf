resource "aws_eks_addon" "this" {
  for_each                    = var.addons
  cluster_name                = var.cluster_name
  addon_name                  = each.key
  addon_version               = try(each.value.version, null)
  resolve_conflicts_on_create = try(each.value.resolve, "OVERWRITE")
  service_account_role_arn    = try(each.value.service_account, null)
  tags                        = { ManagedBy = "terraform" }
}
