variable "vpc_name" {
  description = "The name to be used on all the resources as identifier"
  type        = string
}

variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "stage" {
  type        = string
  description = "The stage of the environment"
}

variable "vpc_cidr" {
  description = "The IP range (CIDR notation) to be used for the VPC"
  type        = string
}

variable "private_cidrs" {
  description = "List of private CIDR ranges to associate with the private subnets"
  type        = list(any)
}

variable "public_cidrs" {
  description = "List of public CIDR ranges to associate with the public subnets"
  type        = list(any)
}

variable "enable_nat_gateway" {
  description = "Set to true if NAT Gateways for each of the private networks are needed"
  type        = bool
  default     = false
}

variable "single_nat_gateway" {
  description = "Set to true if a single shared NAT Gateway is desired for all private networks"
  type        = bool
  default     = false
}

variable "enable_dns_hostnames" {
  description = "Set to true to enable DNS hostnames for the VPC"
  type        = bool
  default     = false
}

variable "one_nat_gateway_per_az" {
  description = "Set to true to provision one NAT Gateway per Availability Zone"
  type        = bool
  default     = false
}

variable "public_subnet_tags" {
  description = "A map of tags to assign to the public subnets"
  type        = map(any)
  default     = {}
}

variable "private_subnet_tags" {
  description = "A map of tags to assign to the private subnets"
  type        = map(any)
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "Tags for the resources"
  default     = {}
}
