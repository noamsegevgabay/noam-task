variable "stage" {
  type        = string
  description = "The stage of the environment"
}

variable "applications" {
  type = map(object({
    scan_on_push         = bool
    image_tag_mutability = string
  }))
  description = "ECR repositories to create"
}

variable "tags" {
  type        = map(string)
  description = "Tags for the resources"
  default     = {}
}
