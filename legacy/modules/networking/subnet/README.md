# subnet

## Usage

```tf
locals {
  env_tag = {
    tf_env = "infra"
  }
}

module "subnet" {
  source = "github.com/suminhong/honglab-terraform.git/modules/networking/subnet"
  prj    = "honglab-dev"

  # (필수) Subnet들이 속할 VPC ID
  vpc_id = "vpc-1234"

  # (필수) Subnet을 구분하는 이름
  name = "public"
  
  # (필수) Subnet들의 CIDR List
  cidr_block = ["10.0.0.0/24", "10.0.10.0/24"]

  # 각 Subnet이 속할 가용영역. default : 현재 리전의 available 상태인 AZ List
  availability_zone = ["ap-northeast-2a", "ap-northeast-2c"]
  
  # module 내 공통 태그 추가. default = {}
  tags = merge(
    local.env_tag,
    {
      Tag = "example",
    },
  )
}

output "subnet_ids" {
  value = module.subnet.subnet_ids
}

output "subnet_arns" {
  value = module.subnet.subnet_arns
}

output "rt_id" {
  value = module.subnet.rt_id
}
```


## Resources

This module creates following resources.

| Name | Type | Note |
|------|------|------|
| [aws_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource | |
| [aws_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource | |
| [aws_route_table_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |  |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| prj | Project Name | `string` | n/a | yes |
| name | The Name of Subnet | `string` | n/a | yes |
| ip_address | The CIDR block List of the Subnets | `list(string)` | n/a | yes |
| azs | The List of Availability Zones | `list(string)` | `[]` | yes |
| tags | A map of tags to add to all resources | `map(string)` | `{}` | no |


## Outputs

| Name | Description |
|------|-------------|
| subnet_ids | The ID List of the Subnets |
| subnet_arns | The ARN List of the Subnets |
| rt_id | The ID of the Routing Table |
