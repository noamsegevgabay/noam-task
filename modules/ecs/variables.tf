variable "project_name" {
  type        = string
  description = "The name of the project"
}

variable "family" {
  type        = string
  description = "The family of the task definition"
}

variable "network_mode" {
  type        = string
  description = "The network mode of the task definition"
}

variable "requires_compatibilities" {
  type        = list(string)
  description = "The compatibility of the task definition"
}

variable "cpu" {
  type        = string
  description = "The cpu of the task definition"
}

variable "memory" {
  type        = string
  description = "The memory of the task definition"
}

variable "container_definitions" {
  type = list(object({
    name             = string
    image            = string
    cpu              = number
    memory           = number
    portMappings     = list(object({
      containerPort = number
      hostPort      = number
      protocol      = string
    }))
    logConfiguration = object({
      logDriver = string
      options   = map(string)
    })
  }))
  description = "The container definitions of the task definition"
}


variable "desired_count" {
  type        = number
  description = "The desired count of the service"
}

variable "launch_type" {
  type        = string
  description = "The launch type of the service"
}

variable "deployment_minimum_healthy_percent" {
  type        = number
  description = "The minimum healthy percent of the deployment"
}

variable "deployment_maximum_percent" {
  type        = number
  description = "The maximum percent of the deployment"
}

variable "private_subnets" {
  type        = list(string)
  description = "The private subnets of the environment"
}

variable "public_subnets" {
  type        = list(string)
  description = "The public subnets of the environment"
}

variable "container_name" {
  type        = string
  description = "The name of the container"
}

variable "vpc_id" {
  type        = string
  description = "The id of the vpc"
}

variable "max_capacity" {
  type        = number
  description = "The maximum capacity of the autoscaling group"
}

variable "min_capacity" {
  type        = number
  description = "The minimum capacity of the autoscaling group"
}

variable "scale_down_cpu_threshold" {
  type        = number
  description = "The minimum capacity of the autoscaling group"
}

variable "scale_up_cpu_threshold" {
  type        = number
  description = "The maximum capacity of the autoscaling group"
}

variable "region" {
  type        = string
  description = "The region of the environment"
}

variable "stage" {
  type        = string
  description = "The stage of the environment"
}

variable "tags" {
  type        = map(string)
  description = "Tags for the resources"
  default     = {}
}
