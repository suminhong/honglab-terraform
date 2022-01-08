locals {
  sg_csvs = fileset("./sg_csv/", "*.csv")
  sg_set  = toset([for f in local.sg_csvs : trimsuffix(f, ".csv")])
}

module "security_groups" {
  source   = "../../modules/networking/security_group"
  for_each = local.sg_set

  prj      = local.prj
  vpc_id   = module.vpc.vpc_id
  name     = each.key
  sg_rules = csvdecode(file("./sg_csv/${each.key}.csv"))
}