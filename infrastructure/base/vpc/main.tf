module "vpc" {
  source = "../../modules/vpc"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-2a", "us-east-2b", "us-east-2c"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  tags = {
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}
#   vpc_endpoints = {
#   ecr_api = {
#     service             = "ecr.api"
#     subnet_ids          = module.vpc.private_subnets
#     security_group_ids  = [module.vpc.default_security_group_id]
#     private_dns_enabled = true
#     tags = {
#       Project = "comet"
#     }
#   }
#   ecr_dkr = {
#     service             = "ecr.dkr"
#     subnet_ids          = module.vpc.private_subnets
#     security_group_ids  = [module.vpc.default_security_group_id]
#     private_dns_enabled = true
#     tags = {
#       Project = "comet"
#     }
#   }
#   ec2 = {
#     service             = "ec2"
#     subnet_ids          = module.vpc.private_subnets
#     security_group_ids  = [module.vpc.default_security_group_id]
#     private_dns_enabled = true
#     tags = {
#       Project = "comet"
#     }
#   }
#   logs = {
#     service             = "logs"
#     subnet_ids          = module.vpc.private_subnets
#     security_group_ids  = [module.vpc.default_security_group_id]
#     private_dns_enabled = true
#     tags = {
#       Project = "comet"
#     }
#   }
# }




