module "vpc" {
  source                 = "terraform-aws-modules/vpc/aws"
  version                = "5.7.0"
  name                   = "${var.project_name}-vpc-${var.vpc_name}-${var.stage}"
  cidr                   = var.vpc_cidr
  azs                    = data.aws_availability_zones.this.names
  private_subnets        = var.private_cidrs
  public_subnets         = var.public_cidrs
  enable_nat_gateway     = var.enable_nat_gateway
  single_nat_gateway     = var.single_nat_gateway
  enable_dns_hostnames   = var.enable_dns_hostnames
  one_nat_gateway_per_az = var.one_nat_gateway_per_az
  public_subnet_tags     = merge(var.public_subnet_tags)
  private_subnet_tags    = merge(var.private_subnet_tags)
  tags                   = local.tags
}
