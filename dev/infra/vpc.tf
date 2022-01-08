locals {
  sub_cidrs = {
    public    = [cidrsubnet(var.vpc_cidr, 8, 0), cidrsubnet(var.vpc_cidr, 8, 1)],
    private   = [cidrsubnet(var.vpc_cidr, 8, 2), cidrsubnet(var.vpc_cidr, 8, 3)],
    directory = [cidrsubnet(var.vpc_cidr, 8, 4), cidrsubnet(var.vpc_cidr, 8, 5)],
  }
}

module "vpc" {
  source = "github.com/suminhong/honglab-terraform.git/modules/networking/vpc"

  prj        = local.prj
  vpc_cidr   = var.vpc_cidr
  enable_vgw = true
  tags       = local.env_tag
}

module "subnet" {
  source   = "github.com/suminhong/honglab-terraform.git/modules/networking/subnet"
  for_each = local.sub_cidrs

  prj        = local.prj
  vpc_id     = module.vpc.vpc_id
  name       = each.key
  ip_address = each.value
  azs        = local.azs
  tags       = local.env_tag
}