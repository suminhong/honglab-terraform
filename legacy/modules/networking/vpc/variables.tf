variable "prj" {
  description = "Project Name"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block of the VPC"
  type        = string
}

variable "enable_igw" {
  description = "Whether to enable Internet Gateway"
  type        = bool
  default     = true
}

variable "enable_vgw" {
  description = "Whether to enable VPN Gateway"
  type        = bool
  default     = false
}

variable "vgw_asn" {
  description = "VGW ASN"
  type        = string
  default     = "64512"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}