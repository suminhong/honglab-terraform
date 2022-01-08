locals {
  vpc_cidr = "10.0.0.0/16"
}

module "vpc" {
  source = "github.com/suminhong/honglab-terraform.git/modules/networking/vpc"
  prj    = local.prj

  vpc_cidr   = var.vpc_cidr
  enable_vgw = true
  tags       = local.env_tag
}