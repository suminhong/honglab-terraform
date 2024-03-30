variable "requester_vpc" {
  description = "Requester VPC Info"
  type = object({
    vpc_id   = string
    vpc_name = string
  })
}

variable "accepter_vpc" {
  description = "Accepter VPC Info"
  type = object({
    vpc_id   = string
    vpc_name = string
  })
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}