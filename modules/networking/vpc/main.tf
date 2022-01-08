locals {
  module_tag = {
    tf_module = "vpc",
  }
}

###################################################
# VPC
###################################################

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = merge(
    var.tags,
    local.module_tag,
    {
      Name = "${var.project}-${var.env}-vpc",
    }
  )
}

###################################################
# Internet Gateway
# enable_igw = true 인 경우 실행
###################################################

resource "aws_internet_gateway" "igw" {
  count  = var.enable_igw ? 1 : 0
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    var.tags,
    local.module_tag,
    {
      Name = "${var.project}-${var.env}-igw",
    }
  )
}

###################################################
# Virtual Private Gateway
# enable_vgw = true 인 경우 실행
###################################################

resource "aws_vpn_gateway" "vgw" {
  count = var.enable_vgw ? 1 : 0

  vpc_id          = aws_vpc.vpc.id
  amazon_side_asn = var.vgw_asn

  tags = merge(
    var.tags,
    local.module_tag,
    {
      Name = "${var.project}-${var.env}-vgw",
    },
  )
}
