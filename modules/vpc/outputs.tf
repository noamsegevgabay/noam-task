output "vpc_id" {
  description = "The unique identifier of the VPC created."
  value       = module.vpc.vpc_id
}

output "cidr_block" {
  description = "The CIDR block range associated with the VPC."
  value       = module.vpc.vpc_cidr_block
}

output "private_subnets" {
  description = "A list of private subnet identifiers within the VPC."
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "A list of public subnet identifiers within the VPC."
  value       = module.vpc.public_subnets
}

output "public_nat_gateway_ips" {
  description = "A list of public NAT gateway IPs."
  value       = module.vpc.nat_public_ips
}
