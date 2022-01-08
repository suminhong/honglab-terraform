# vpc

## Usage

```tf
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
  
  # Internet Gateway 활성화 여부. default = true
  enable_igw = true
  
  # VGW 활성화 여부. default = false
  enable_vgw = true
  
  # VGW ASN 설정 필요 시 입력. default = 64512
  vgw_asn = 64512
  
  # module 내 공통 태그 추가. default = {}
  tags = merge(
    local.env_tag,
    {
      Tag = "example",
    },
  )
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "enable_igw" {
  # internet_gateway_enabled = true 인 경우만 생성
  value = module.vpc.igw_id
}

output "vpn_gateway_id" {
  # enable_vgw = true 인 경우만 생성
  value = module.vpc.vpn_gateway_id
}
```

## Resources

This module creates following resources.

| Name | Type | Note |
|------|------|------|
| [aws_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource | |
| [aws_internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource | optional |
| [aws_vpn_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_gateway) | resource |  optional |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project | Project Name | `string` | n/a | yes |
| env | Project Environment | `string` | n/a | yes |
| vpc_cidr | The CIDR block of the VPC | `string` | n/a | yes |
| enable_igw | Whether to enable Internet Gateway | `bool` | `true` | no |
| enable_vgw | Whether to enable VPN Gateway | `bool` | `false` | no |
| vgw_asn | VGW ASN | `string` | `"64512"` | no |
| tags | A map of tags to add to all resources | `map(string)` | `{}` | no |


## Outputs

| Name | Description |
|------|-------------|
| vpc_id | The ID of the VPC |
| igw_id | The ID of the Internet Gateway |
| vpn_gateway_id | The ID of the Virtual Private Gateway |
