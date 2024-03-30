data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  module_tag = {
    tf_module = "subnet",
  }

  azs = length(var.azs) > 0 ? var.azs : data.aws_availability_zones.available.names
}

###################################################
# Create Subnet
###################################################

resource "aws_subnet" "subnet" {
  count             = length(var.ip_address)
  cidr_block        = var.ip_address[count.index]
  availability_zone = local.azs[count.index]
  vpc_id            = var.vpc_id
  tags = merge(
    var.tags,
    local.module_tag,
    {
      Name = "${var.prj}-sub-${var.name}-${substr(local.azs[count.index], -1, -1)}",
    }
  )
}

###################################################
# Create Routing Table
###################################################

resource "aws_route_table" "rt" {
  vpc_id = var.vpc_id

  tags = merge(
    var.tags,
    local.module_tag,
    {
      Name = "${var.prj}-rt-${var.name}",
    }
  )
}

###################################################
# Associate Routing Table - Subnet
###################################################

resource "aws_route_table_association" "rt_asso" {
  count          = length(var.ip_address)
  route_table_id = aws_route_table.rt.id
  subnet_id      = aws_subnet.subnet[count.index].id

  depends_on = [
    aws_subnet.subnet,
    aws_route_table.rt,
  ]
}