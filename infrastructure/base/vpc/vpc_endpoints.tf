vpc_endpoints = {
  ecr_api = {
    service             = "ecr.api"
    subnet_ids          = module.vpc.private_subnets
    security_group_ids  = [module.vpc.default_security_group_id]
    private_dns_enabled = true
    tags = {
      Project = "comet"
    }
  }
  ecr_dkr = {
    service             = "ecr.dkr"
    subnet_ids          = module.vpc.private_subnets
    security_group_ids  = [module.vpc.default_security_group_id]
    private_dns_enabled = true
    tags = {
      Project = "comet"
    }
  }
  ec2 = {
    service             = "ec2"
    subnet_ids          = module.vpc.private_subnets
    security_group_ids  = [module.vpc.default_security_group_id]
    private_dns_enabled = true
    tags = {
      Project = "comet"
    }
  }
  logs = {
    service             = "logs"
    subnet_ids          = module.vpc.private_subnets
    security_group_ids  = [module.vpc.default_security_group_id]
    private_dns_enabled = true
    tags = {
      Project = "comet"
    }
  }
}
=======
variable "vpc_endpoints" {
  description = "Map of VPC interface endpoints to create"
  type = map(object({
    service             = string
    subnet_ids          = list(string)
    security_group_ids  = list(string)
    private_dns_enabled = bool
    tags                = map(string)
  }))
  default = {}
}

resource "aws_vpc_endpoint" "this" {
  for_each = var.vpc_endpoints

  vpc_id            = module.vpc.vpc_id
  service_name      = "com.amazonaws.${var.region}.${each.value.service}"
  vpc_endpoint_type = "Interface"

  subnet_ids          = each.value.subnet_ids
  security_group_ids  = each.value.security_group_ids
  private_dns_enabled = each.value.private_dns_enabled

  tags = merge(
    {
      Name = "${each.key}-vpc-endpoint"
    },
    each.value.tags
  )
}

resource "aws_vpc_endpoint" "gateway" {
  for_each = var.gateway_endpoints

  vpc_id            = module.vpc.vpc_id
  service_name      = "com.amazonaws.${var.region}.${each.value.service}"
  vpc_endpoint_type = "Gateway"

  route_table_ids = module.vpc.private_route_table_ids

  tags = merge(
    {
      Name = "${each.key}-gateway-endpoint"
    },
    each.value.tags
  )
}

variable "gateway_endpoints" {
  description = "Map of VPC gateway endpoints to create"
  type = map(object({
    service = string
    tags    = map(string)
  }))
  default = {}
}

