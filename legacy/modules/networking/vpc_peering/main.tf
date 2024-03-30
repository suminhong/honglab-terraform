################################################################################
# VPC Peering Connection
################################################################################
resource "aws_vpc_peering_connection" "this" {
  peer_owner_id = local.is_cross_account ? local.accepter_account : null
  peer_region   = local.is_cross_region ? local.accepter_region : null

  peer_vpc_id = var.accepter_vpc.vpc_id
  vpc_id      = var.requester_vpc.vpc_id

  auto_accept = local.need_accepter ? false : true

  dynamic "requester" {
    for_each = local.need_accepter ? toset([]) : toset(["1"])
    content {
      allow_remote_vpc_dns_resolution = true
    }
  }

  dynamic "accepter" {
    for_each = local.need_accepter ? toset([]) : toset(["1"])
    content {
      allow_remote_vpc_dns_resolution = true
    }
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.requester_vpc.vpc_name}-to-${var.accepter_vpc.vpc_name}",
      Side = "Requester"
    }
  )
}

## need_accpter = true 인 경우에만 아래 코드들 실행

################################################################################
# VPC Peering Accepter
################################################################################
resource "aws_vpc_peering_connection_accepter" "this" {
  count                     = local.need_accepter ? 1 : 0
  provider                  = aws.accepter
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
  auto_accept               = true

  tags = merge(
    var.tags,
    {
      Name = "${var.requester_vpc.vpc_name}-to-${var.accepter_vpc.vpc_name}",
      Side = "Accepter"
    }
  )
}


################################################################################
# VPC Peering Option
################################################################################
resource "aws_vpc_peering_connection_options" "requester" {
  count = local.need_accepter ? 1 : 0

  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.this[count.index].id

  requester {
    allow_remote_vpc_dns_resolution = true
  }
}

resource "aws_vpc_peering_connection_options" "accepter" {
  count    = local.need_accepter ? 1 : 0
  provider = aws.accepter

  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.this[count.index].id

  accepter {
    allow_remote_vpc_dns_resolution = true
  }
}