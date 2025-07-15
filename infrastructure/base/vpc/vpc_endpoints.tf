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