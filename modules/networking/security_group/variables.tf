variable "prj" {
  description = "Project Name"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "name" {
  description = "The Name of Security Group"
  type        = string
}

variable "sg_rules" {
  description = "The Rule Set List of the Security Group"
  type        = list(any)
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}