locals {
  module_tag = {
    tf_module = "vpc",
  }
}

###################################################
# Security Group
###################################################

resource "aws_security_group" "sg" {
  name        = "${var.prj}-sg-${var.name}"
  description = "Managed By Terraform"
  vpc_id      = var.vpc_id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    local.module_tag,
    {
      Name = "${var.prj}-sg-${var.name}",
    }
  )
}

###################################################
# Security Group Rule
###################################################

resource "aws_security_group_rule" "sg" {
  for_each                 = { for rule in var.sg_rules : rule.key => rule }
  security_group_id        = aws_security_group.sg.id
  type                     = each.value.rule_type
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  protocol                 = each.value.protocol
  cidr_blocks              = length(regexall("[a-z]", each.value.src_or_dst)) == 0 ? [each.value.src_or_dst] : null
  prefix_list_ids          = substr(each.value.src_or_dst, 0, 2) == "pl" ? [each.value.src_or_dst] : null
  source_security_group_id = substr(each.value.src_or_dst, 0, 2) == "sg" ? each.value.src_or_dst : null
  self                     = each.value.src_or_dst == "self" ? true : null
  description              = lookup(each.value, "desc", null)
}