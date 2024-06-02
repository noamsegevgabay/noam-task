resource "aws_ecr_repository" "this" {
  for_each             = var.applications
  name                 = "${each.key}-${var.stage}"
  image_tag_mutability = each.value["image_tag_mutability"]
  image_scanning_configuration {
    scan_on_push = each.value["scan_on_push"]
  }
  tags = local.tags
}
