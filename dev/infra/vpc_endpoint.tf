locals {
  rt_ids = tolist([
    module.subnet["public"].rt_id,
    module.subnet["private"].rt_id,
    module.subnet["directory"].rt_id,
  ])

  endpoints = {
    ssm = {
      service    = "ssm"
      subnet_ids = module.subnet["private"].subnet_ids
    },
    ec2messages = {
      service    = "ec2messages"
      subnet_ids = module.subnet["private"].subnet_ids
    },
    ssmmessages = {
      service    = "ssmmessages"
      subnet_ids = module.subnet["private"].subnet_ids
    },
    datasync = {
      service        = "datasync"
      subnet_ids     = module.subnet["private"].subnet_ids
      security_group = [module.security_groups["datasync-vpce"].sg_id]
    },
    s3 = {
      service         = "s3"
      service_type    = "Gateway"
      route_table_ids = local.rt_ids
    },
  }
}

## Create VPC Endpoints
module "vpce" {
  source   = "../../modules/networking/vpc_endpoint"
  for_each = local.endpoints

  prj        = local.prj
  vpc_id     = module.vpc.vpc_id
  name       = each.key
  attribute  = each.value
  default_sg = [module.security_groups["vpce"].sg_id]
  tags       = local.env_tag

  depends_on = [
    module.subnet,
  ]
}