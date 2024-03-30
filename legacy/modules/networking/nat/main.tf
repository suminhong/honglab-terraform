locals {
  module_tag = {
    tf_module = "nat",
  }
}

###################################################
# Create EIP
###################################################

resource "aws_eip" "eip" {
  count = var.is_private ? 0 : 1

  vpc = true

  tags = merge(
    var.tags,
    local.module_tag,
    {
      Name = "${var.prj}-nat",
    },
  )
}

###################################################
# Create NAT
###################################################

resource "aws_nat_gateway" "nat" {
  connectivity_type = var.is_private ? "private" : "public"
  subnet_id         = var.subnet_id
  allocation_id     = var.is_private ? null : aws_eip.eip.0.id

  tags = merge(
    var.tags,
    local.module_tag,
    {
      Name = "${var.prj}-nat",
    },
  )
}