locals {
  env_tag = {
    Env    = var.env,
    tf_env = "infra",
  }

  prj = "${var.project}-${var.env}"
}

variable "project" {
  description = "Project Name"
  default     = "honglab"
}

variable "env" {
  description = "Project Environment"
  default     = "staging"
}