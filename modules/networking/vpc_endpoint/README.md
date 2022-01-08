# vpc endpoint

##Usage

```terraform
module  "vpc_endpoint" {
  source = "github.com/suminhong/honglab-terraform.git/modules/networking/vpc_endpoint"
  prj      = "honglab-dev"
  
  # (필수) VPC ID
  vpc_id = "vpc-1234"

  # Attribut Set. default = {}
  # service : (필수) vpc endpoint service name
  # service_type : Interface(default) or Gateway
  # subnet_ids : Interface Type인 경우 필수
  # security_group : Interface Type인 경우 && 따로 지정하고픈 sg가 있는 경우
  # rt_ids : Gateway Type인 경우 필수
  attribute = {
    service    = "ssm",
    subnet_ids = ["subnet-1234", "subnet-5678"],
  }
 
  # 기본 VPC Security Group ID. default = []
  default_sg = "sg-1234"

  # module 내 공통 태그 추가. default = {}
  tags = merge(
    local.env_tag,
    {
      Tag = "example",
    },
  )
}

output "vpce_id" {
  value = module.vpc_endpoint.vpce_id
}

output "vpce_ips" {
  value = module.vpc_endpoint.vpce_ips
}
```

## Resources

This module creates following resources.

| Name | Type | Note |
|------|------|------|
| [aws_vpc_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource | |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| prj | Project Name | `string` | n/a | yes |
| name | The Name of VPC Endpoint | `string` | n/a | yes |
| attribute | VPC Endpoint Attribute Set | `map(any)` | n/a | yes |
| default_sg | The List of Default Security Groups | `list(string)` | `[]` | no |
| tags | A map of tags to add to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| vpce_id | The ID of VPC Endpoint |
| vpce_ip | The Private IP of VPC Endpoint |
