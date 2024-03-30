# security group

## Usage

### security group
```terraform
locals {
  env_tag = {
    tf_env = "infra"
  }
}

module "sg" {
  source = "github.com/suminhong/honglab-terraform.git/modules/networking/security_group"
  prj    = "honglab-dev"
  
  # (필수) 보안 그룹이 속할 VPC ID
  vpc_id = "vpc-1234"

  # (필수) 보안 그룹을 구분하는 이름
  name = "alb"

  # (필수) 보안 그룹 Rule List. CSV File 사용 권장.
  sg_rules = tolist([
    {
      "key" = "0"
      "rule_type" = "ingress"
      "protocol" = "-1"
      "from_port" = "0"
      "to_port" = "0"
      "src_or_dst" = "self"
      "desc" = "ALB Self Reference"
    },
    {
      "key" = "1"
      "rule_type" = "ingress"
      "protocol" = "tcp"
      "from_port" = "80"
      "to_port" = "80"
      "src_or_dst" = "10.0.0.10/32"
      "desc" = "NLB"
    },
  ])
  # CSV File 사용하는 경우
  sg_rules = csvdecode(file("./alb.csv"))
  
  # module 내 공통 태그 추가. default = {}
  tags = merge(
    local.env_tag,
    {
      Tag = "example",
    },
  )       
}

output "sg_id" {
  value = module.sg.sg_id
}

output "sg_arn" {
  value = module.sg.sg_arn
}
```

## Resources

This module creates following resources.

| Name | Type | Note |
|------|------|------|
| [aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource | |
| [aws_security_group_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource | |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| prj | Project Name | `string` | n/a | yes |
| vpc_id | The ID of the VPC | `string` | n/a | yes |
| name | The Name of Security Group | `string` | n/a | yes |
| sg_rules | The Rule Set List of the Security Group | `list(string)` | n/a | yes |
| tags | A map of tags to add to all resources | `map(string)` | `{}` | no |


## Outputs

| Name | Description |
|------|-------------|
| sg_id | The ID of the Security Group |
| sg_arn | The ARN of the Security Group |