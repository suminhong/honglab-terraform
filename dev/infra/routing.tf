locals {
  routings = {
    public = {
      igw = {
        dst_cidr = "0.0.0.0/0",
        dst_id   = module.vpc.igw_id,
      },
    },
    private = {
      nat = {
        dst_cidr = "0.0.0.0/0",
        dst_id   = module.nat.nat_id,
      },
    },
    directory = {
      nat = {
        dst_cidr = "0.0.0.0/0",
        dst_id   = module.nat.nat_id,
      },
    }
  }
}

module "routing" {
  source = "../../modules/networking/route"
  for_each = local.routings

  rt_id = module.subnet[each.key].rt_id
  routings = each.value
}