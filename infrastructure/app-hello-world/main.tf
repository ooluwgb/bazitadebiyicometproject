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

# module "network" {
#   source = "./modules/network"

#   region          = var.region
#   vpc_cidr        = var.vpc_cidr
#   public_subnets  = var.public_subnets
#   private_subnets = var.private_subnets
#   tags            = var.tags
# }

module "eks" {
  source = "../modules/eks"

  name              = "comet-eks"
  #region                    = var.region #region is not an input for this module. set in your provider block.
  vpc_id                    = "vpc-078f0039a71ac815c"
  subnet_ids                = ["subnet-02840f07a9c4ef62f"]
  control_plane_subnet_ids  = ["subnet-02840f07a9c4ef62f"]
  cluster_version           = "1.32"
  node_group_role_arn       = "arn:aws:iam::690893780650:role/aws-service-role/support.amazonaws.com/AWSServiceRoleForSupport"
}
