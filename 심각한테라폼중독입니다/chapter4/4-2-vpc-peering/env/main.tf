provider "aws" {
  region  = ""
  profile = ""
}

provider "aws" {
  region  = ""
  profile = ""

  alias = "B"
}

locals {
  env_tag = {
    chapter = 4
    tf_env  = "4-2-vpc-peering"
  }
}

module "multi_provider" {
  source = "../module"
  providers = {
    aws.requester = aws
    aws.accepter  = aws.B
  }

  requester_vpc = {
    vpc_id               = "vpc-1234"
    vpc_name             = "A"
    allow_dns_resolution = false
  }

  accepter_vpc = {
    vpc_id               = "vpc-5678"
    vpc_name             = "B"
    allow_dns_resolution = true
  }

  tags = local.env_tag
}

module "single_provider" {
  source = "../module"
  providers = {
    aws.requester = aws
    aws.accepter  = aws
  }

  requester_vpc = {
    vpc_id               = "vpc-1234"
    vpc_name             = "A"
    allow_dns_resolution = false
  }

  accepter_vpc = {
    vpc_id               = "vpc-5678"
    vpc_name             = "B"
    allow_dns_resolution = true
  }

  tags = local.env_tag
}
