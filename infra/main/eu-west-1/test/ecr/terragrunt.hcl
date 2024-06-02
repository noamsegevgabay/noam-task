# ecr/terragrunt.hcl

terraform {
  source = "../../../../../modules/ecr"
}

locals {
  stage          = "test"
  project_name   = "noam-task"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  stage = local.stage
  applications = {
    noam-task = {
      scan_on_push         = true
      image_tag_mutability = "MUTABLE"
    }
  }
}