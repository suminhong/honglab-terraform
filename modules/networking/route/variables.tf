variable "rt_id" {
  description = "Routing Table ID"
  type        = string
}

variable "routings" {
  description = "Routing set"
  type        = map(any)
  default     = {}
}