locals {
  module_tag = {
    tf_module = "vpc_endpoint",
  }
}

###################################################
# Find VPC Endpoint Name
###################################################

data "aws_vpc_endpoint_service" "vpce_name" {
  service = lookup(var.attribute, "service", null)

  filter {
    name   = "service-type"
    values = [lookup(var.attribute, "service_type", "Interface")]
  }
}

###################################################
# VPC Endpoint
###################################################

resource "aws_vpc_endpoint" "vpce" {
  vpc_id            = var.vpc_id
  service_name      = data.aws_vpc_endpoint_service.vpce_name.service_name
  vpc_endpoint_type = lookup(var.attribute, "service_type", "Interface")

  security_group_ids  = lookup(var.attribute, "service_type", "Interface") == "Interface" ? lookup(var.attribute, "security_group", var.default_sg) : null
  subnet_ids          = lookup(var.attribute, "service_type", "Interface") == "Interface" ? lookup(var.attribute, "subnet_ids", null) : null
  route_table_ids     = lookup(var.attribute, "service_type", "Interface") == "Gateway" ? lookup(var.attribute, "route_table_ids", null) : null
  private_dns_enabled = lookup(var.attribute, "service_type", "Interface") == "Interface" ? true : null

  tags = merge(
    lookup(var.attribute, "tags", null),
    var.tags,
    local.module_tag,
    {
      Name = "${var.prj}-vpce-${var.name}"
    }
  )
}

###################################################
# Find VPC Endpoint Network Interface ID
###################################################

locals {
  vpce_id_list = tolist(aws_vpc_endpoint.vpce.network_interface_ids)
}

data "aws_network_interface" "vpce_ip_id" {
  count = lookup(var.attribute, "service_type", "Interface") == "Interface" ? length(var.attribute.subnet_ids) : 0
  id    = local.vpce_id_list[count.index]
}