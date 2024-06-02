locals {
  tags = merge(
    { ManagedBy = "Terraform" },
    { Environment = var.stage },
    var.tags
  )
}
