# route

## Usage

```tf
module "route" {
  source = "github.com/suminhong/honglab-terraform.git/modules/networking/route"

  # (필수) Routing Table ID
  # dst_cidr : CIDR Block or Prefix List ID
  # dst_id : IGW / VGW / NAT / TGW / Instance / Peering / VPCE
  rt_id = "rtb-1234"

  # Routing Rule Set. default = {}
  routings = {
    igw = {
      dst_cidr = "0.0.0.0/0",
      dst_id   = "igw-1234",
    },
    peering = {
      dst_cidr = "192.168.0.0/16",
      dst_id   = "pcx-1234",
    },
    pl = {
      dst_cidr = "pl-1234",
      dst_id   = "tgw-1234",
    },
  }
}
```

## Resources

This module creates following resources.

| Name | Type | Note |
|------|------|------|
| [aws_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource | |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| rt_id | Routing Table ID | `string` | n/a | yes |
| routings | Routing set | `map(any)` | `{}` | no |

## Outputs

No outputs.
