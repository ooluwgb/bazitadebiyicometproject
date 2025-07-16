module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.name
  cluster_version = var.cluster_version

  bootstrap_self_managed_addons = false

  cluster_addons = var.cluster_addons

  cluster_endpoint_public_access = true

  enable_cluster_creator_admin_permissions = true

  vpc_id                   = var.vpc_id
  subnet_ids               = var.subnet_ids
  control_plane_subnet_ids = var.control_plane_subnet_ids

  eks_managed_node_group_defaults = {
    instance_types = ["t3.medium", "t3.large"]
  }

  eks_managed_node_groups = {
    managed_nodes = {
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.large"]

      min_size     = 2
      max_size     = 5
      desired_size = 2

      iam_role_arn = var.node_group_role_arn
    }
  }

  tags = var.tags
}
