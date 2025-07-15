module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway   = true
  single_nat_gateway   = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
    "kubernetes.io/cluster/my-vpc" = "shared"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/my-vpc" = "shared"
  }

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_vpc_endpoints = true

  vpc_endpoints = {
    s3 = {
      service             = "s3"
      service_type        = "Gateway"
      route_table_ids     = ["${module.vpc.private_route_table_ids[0]}", "${module.vpc.private_route_table_ids[1]}", "${module.vpc.private_route_table_ids[2]}"]
      tags = {
        Name = "s3-endpoint"
      }
    }
    ecr_api = {
      service             = "ecr.api"
      subnet_ids          = module.vpc.private_subnets
      security_group_ids  = [module.vpc.default_security_group_id]
      private_dns_enabled = true
      tags = {
        Name = "ecr-api-endpoint"
      }
    }
    ecr_dkr = {
      service             = "ecr.dkr"
      subnet_ids          = module.vpc.private_subnets
      security_group_ids  = [module.vpc.default_security_group_id]
      private_dns_enabled = true
      tags = {
        Name = "ecr-dkr-endpoint"
      }
    }
    ec2 = {
      service             = "ec2"
      subnet_ids          = module.vpc.private_subnets
      security_group_ids  = [module.vpc.default_security_group_id]
      private_dns_enabled = true
      tags = {
        Name = "ec2-endpoint"
      }
    }
    sts = {
      service             = "sts"
      subnet_ids          = module.vpc.private_subnets
      security_group_ids  = [module.vpc.default_security_group_id]
      private_dns_enabled = true
      tags = {
        Name = "sts-endpoint"
      }
    }
    logs = {
      service             = "logs"
      subnet_ids          = module.vpc.private_subnets
      security_group_ids  = [module.vpc.default_security_group_id]
      private_dns_enabled = true
      tags = {
        Name = "logs-endpoint"
      }
    }
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
