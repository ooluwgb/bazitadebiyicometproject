module "iam" {
  source = "./modules/iam"

  cluster_name         = var.cluster_name
  enable_irsa          = true
  irsa_service_account = "comet-irsa-sa"
  irsa_namespace       = "default"
  irsa_policy_json     = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect   = "Allow",
      Action   = ["s3:ListBucket"],
      Resource = "*"
    }]
  })
  tags = var.tags
}

module "network" {
  source = "./modules/network"

  region          = var.region
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  tags            = var.tags
}

module "eks" {
  source = "./modules/eks"

  cluster_name              = var.cluster_name
  region                    = var.region
  vpc_id                    = module.network.vpc_id
  subnet_ids                = module.network.private_subnet_ids
  control_plane_subnet_ids  = module.network.private_subnet_ids

  cluster_role_arn          = module.iam.eks_cluster_role_arn
  node_group_role_arn       = module.iam.eks_node_group_role_arn

  tags = var.tags
}
