locals {
  vpc_cidr = "10.0.0.0/16"
}

module "vpc" {
  source   = "../../modules/networking/vpc"
  prj      = local.prj
  vpc_cidr = local.vpc_cidr
  tags     = local.env_tag
}