provider "aws" {
  region = "ap-northeast-2"
}

locals {
  env_tag = {
    tf_env = "infra"
  }
}

module "vpc" {
  source   = "github.com/suminhong/honglab-terraform.git/modules/networking/vpc"
  project  = "honglab"
  env      = "dev"

  # (필수) VPC의 CIDR
  vpc_cidr = "10.0.0.0/16"
  
  tags = local.env_tag
}