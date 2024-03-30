# nat

## Usage

```tf
locals {
  env_tag = {
    tf_env = "infra"
  }
}

module "nat" {
  source = "github.com/suminhong/honglab-terraform.git/modules/networking/nat"
  prj    = "honglab-dev"

  # (필수) NAT Gateway가 속할 Subnet ID    
  subnet_id = "subnet-Example"

  # NAT Gateway 연결 유형. default = false (Public NAT)
  is_private = false

  # module 내 공통 태그 추가. default = {}
  tags = merge(
    local.env_tag,
    {
      Tag = "example",
    },
  )
}

output "nat_id" {
  value = module.nat.nat_id
}

output "public_ip" {
  # is_private = false 인 경우만 생성
  value = module.nat.public_ip
}

output "private_ip" {
  value = module.nat.private_ip
}
```


## Resources

This module creates following resources.

| Name | Type | Note |
|------|------|------|
| [aws_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource | optional |
| [aws_nat_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource | |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| prj | Project Name | `string` | n/a | yes |
| vpc_name | The Name of the VPC | `string` | n/a | yes |
| subnet_id | The ID of Subnet where NAT will exists | `string` | n/a | yes |
| is_private | Connectivity type for the NAT | `bool` | `false` | no |
| tags | A map of tags to add to all resources | `map(string)` | `{}` | no |


## Outputs

| Name | Description |
|------|-------------|
| nat_id | The ID of the NAT Gateway |
| public_ip | The public IP address of the NAT Gateway |
| private_ip | The private IP address of the NAT Gateway |
