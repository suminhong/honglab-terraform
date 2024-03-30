locals {
  # dst_cidr : CIDR Block or Prefix List ID
  # dst_id : IGW / VGW / NAT / TGW / Instance / Peering / VPCE
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


## Create Routing
module "routing" {
  source   = "../../modules/networking/route"
  for_each = local.routings

  rt_id    = module.subnet[each.key].rt_id
  routings = each.value

  depends_on = [
    module.vpc,
    module.subnet,
  ]
}