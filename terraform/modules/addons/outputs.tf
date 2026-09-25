output "addon_names" {
  value = keys(aws_eks_addon.this)
}
