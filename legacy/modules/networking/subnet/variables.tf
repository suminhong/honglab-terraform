variable "prj" {
  description = "Project Name"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "name" {
  description = "The Name of Subnet"
  type        = string
}

variable "ip_address" {
  description = "The CIDR block List of the Subnets"
  type        = list(string)
}

variable "azs" {
  description = "The List of Availability Zones"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}