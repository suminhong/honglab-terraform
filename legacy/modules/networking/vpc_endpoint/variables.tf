variable "prj" {
  description = "Project Name"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "name" {
  description = "The Name of VPC Endpoint"
  type        = string
}

variable "attribute" {
  description = "VPC Endpoint Attribute Set"
}

variable "default_sg" {
  description = "The List of Default Security Groups"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}