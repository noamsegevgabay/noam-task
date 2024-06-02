# vpc-main/terragrunt.hcl

terraform {
  source = "../../../../../modules/vpc"
}

locals {
  cidr           = 130
  stage          = "test"
  region         = "eu-west-1"
  account_id     = "753392824297"
  project_name   = "noam-task"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  vpc_name               = "main"
  enable_nat_gateway     = true
  single_nat_gateway     = true
  enable_dns_hostnames   = true
  one_nat_gateway_per_az = false
  stage                  = local.stage
  project_name           = local.project_name
  vpc_cidr               = "10.${local.cidr}.0.0/16"
  public_cidrs           = ["10.${local.cidr}.96.0/20", "10.${local.cidr}.112.0/20"]
  private_cidrs          = ["10.${local.cidr}.0.0/20", "10.${local.cidr}.16.0/20"]
  public_subnet_tags = {
    "public-subnet"          = "true"
    "ManagedBy"              = "Terraform"
    "Environment"            = local.stage
  }
  private_subnet_tags = {
    "private-subnet"                  = "true"
    "ManagedBy"                       = "Terraform"
    "Environment"                     = local.stage
  }
}