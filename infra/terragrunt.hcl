// terragrunt.hcl

remote_state {
  backend      = "s3"
  disable_init = tobool(get_env("TERRAGRUNT_DISABLE_INIT", "false"))
  generate = {
    path      = "_backend.tf"
    if_exists = "overwrite"
  }
  config = {
    encrypt                     = true
    region                      = "eu-west-1"
    key                         = format("%s/terraform.tfstate", path_relative_to_include())
    bucket                      = format("noam-task-terraform-states")
    dynamodb_table              = format("noam-task-terraform-locks")
    skip_metadata_api_check     = true
    skip_credentials_validation = true
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
    provider "aws" {
      region = "eu-west-1"
      allowed_account_ids = ["753392824297"]
    }
  EOF
}