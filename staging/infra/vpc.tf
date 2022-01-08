locals {
  vpc_cidr = "10.0.0.0/16"
}

module "vpc" {
  source   = "github.com/suminhong/honglab-terraform.git/modules/networking/vpc"
  project  = local.prj
  vpc_cidr = local.vpc_cidr
  tags     = local.env_tag
}