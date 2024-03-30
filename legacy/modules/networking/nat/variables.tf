variable "prj" {
  description = "Project Name"
  type        = string
}

variable "subnet_id" {
  description = "The ID of Subnet where NAT will exists"
  type        = string
}

variable "is_private" {
  description = "Connectivity type for the NAT"
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}