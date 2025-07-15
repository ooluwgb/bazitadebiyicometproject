module "comet_ecr" {
  source = "../modules/ecr"
  name = "comet_ecr"
  
}

module "eks" {
  source = "../modules/eks"

  cluster_name              = "prod-comet-env1"
  region                    = "us-east-2"
  vpc_id                    = #to be added
  subnet_ids                = #to be added
  control_plane_subnet_ids  = #to be added

  cluster_role_arn          = module.iam.eks_cluster_role_arn
  node_group_role_arn       = module.iam.eks_node_group_role_arn

  tags = {
    #to be added
  }
}


# ## implement the recommended fixes for the IAM role modules first before proqceeding with this
# module "iam" {
#   source = "./modules/iam"

#   cluster_name         = var.cluster_name
#   enable_irsa          = true
#   irsa_service_account = "comet-irsa-sa"
#   irsa_namespace       = "default"
#   irsa_policy_json     = jsonencode({
#     Version = "2012-10-17",
#     Statement = [{
#       Effect   = "Allow",
#       Action   = ["s3:ListBucket"],
#       Resource = "*"
#     }]
#   })
#   tags = var.tags
# }


# ##no network module created, create one using aws  vpc module
# ## just saw the VPC module, it is solid, use it, you can take out this one here
# module "network" {
#   source = "./modules/network"

#   region          = var.region
#   vpc_cidr        = var.vpc_cidr
#   public_subnets  = var.public_subnets
#   private_subnets = var.private_subnets
#   tags            = var.tags
# }

# #this is solid


