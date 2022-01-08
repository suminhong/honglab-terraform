locals {
  sg_csvs = fileset("./sg_csv/", "*.csv")
  sg_set  = toset([for f in local.sg_csvs : trimsuffix(f, ".csv")])

  sg_to_sg = csvdecode(file("./sg_to_sg.csv"))
}

## Create Security Group & Rules
module "security_groups" {
  source   = "../../modules/networking/security_group"
  for_each = local.sg_set

  prj      = local.prj
  vpc_id   = module.vpc.vpc_id
  name     = each.key
  sg_rules = csvdecode(file("./sg_csv/${each.key}.csv"))
}

## SG to SG 별도 관리
resource "aws_security_group_rule" "sg_to_sg" {
  for_each = { for rule in local.sg_to_sg : rule.key => rule }

  security_group_id        = module.security_groups[each.value.to_sg].sg_id
  type                     = "ingress"
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  protocol                 = each.value.protocol
  source_security_group_id = module.security_groups[each.value.from_sg].sg_id
  description              = each.value.desc

  depends_on = [
    module.security_groups
  ]
}