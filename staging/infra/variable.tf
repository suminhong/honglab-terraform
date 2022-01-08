locals {
  env_tag = {
    tf_env = "infra"
  }
}

variable "project" {
  description = "Project Name"
  default     = "honglab"
}

variable "env" {
  description = "Project Environment"
  default     = "staging"
}