## Usage

```terraform
module "vpc_peering" {
  source = "github.com/suminhong/honglab-terraform.git/modules/networking/vpc_peering"
  providers = {
    aws.requester = aws.A
    aws.accepter = aws.B
  }

  requester_vpc = {
    vpc_id = "vpc-1234"
    vpc_name = "A"
  }

  accepter_vpc = {
    vpc_id = "vpc-5678"
    vpc_name = "B"
  }
}
```

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_aws.accepter"></a> [aws.accepter](#provider\_aws.accepter) | n/a |
| <a name="provider_aws.requester"></a> [aws.requester](#provider\_aws.requester) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_vpc_peering_connection.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection) | resource |
| [aws_vpc_peering_connection_accepter.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection_accepter) | resource |
| [aws_vpc_peering_connection_options.accepter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection_options) | resource |
| [aws_vpc_peering_connection_options.requester](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection_options) | resource |
| [aws_caller_identity.accepter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_caller_identity.requester](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.accepter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_region.requester](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_accepter_vpc"></a> [accepter\_vpc](#input\_accepter\_vpc) | Accepter VPC Info | <pre>object({<br>    vpc_id   = string<br>    vpc_name = string<br>  })</pre> | n/a | yes |
| <a name="input_requester_vpc"></a> [requester\_vpc](#input\_requester\_vpc) | Requester VPC Info | <pre>object({<br>    vpc_id   = string<br>    vpc_name = string<br>  })</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |

## Outputs

No outputs.
