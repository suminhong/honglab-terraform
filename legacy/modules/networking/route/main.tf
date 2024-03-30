locals {
  gateway = ["igw", "vgw"]
}

###################################################
# Routing
###################################################

resource "aws_route" "routing" {
  for_each       = var.routings
  route_table_id = var.rt_id

  destination_cidr_block     = length(regexall("[a-z]", each.value.dst_cidr)) == 0 ? each.value.dst_cidr : null
  destination_prefix_list_id = substr(each.value.dst_cidr, 0, 2) == "pl" ? each.value.dst_cidr : null

  gateway_id                = contains(local.gateway, substr(each.value.dst_id, 0, 3)) ? each.value.dst_id : null
  instance_id               = substr(each.value.dst_id, 0, 2) == "i-" ? each.value.dst_id : null
  nat_gateway_id            = substr(each.value.dst_id, 0, 3) == "nat" ? each.value.dst_id : null
  vpc_endpoint_id           = substr(each.value.dst_id, 0, 4) == "vpce" ? each.value.dst_id : null
  transit_gateway_id        = substr(each.value.dst_id, 0, 3) == "tgw" ? each.value.dst_id : null
  vpc_peering_connection_id = substr(each.value.dst_id, 0, 3) == "pcx" ? each.value.dst_id : null
}