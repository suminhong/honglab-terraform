locals {
  region = "ap-northeast-2"
  azs    = ["${local.region}a", "${local.region}c"]

  prj = "${var.project}-${var.env}"

  env_tag = {
    Env    = var.env,
    tf_env = "infra",
  }
}

variable "project" {
  description = "Project Name"
  type        = string
  default     = "honglab"
}

variable "env" {
  description = "Project Environment"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "The CIDR block of the VPC"
  type        = string
  default     = "10.0.0.0/16"
}