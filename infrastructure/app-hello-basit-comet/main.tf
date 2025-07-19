module "comet_eks" {
  source = "../modules/eks"

  name                                            = "comet-eks"
  vpc_id                                          = data.aws_vpc.comet_vpc.id
  subnet_ids                                      = data.aws_subnets.comet_subnets.ids
  control_plane_subnet_ids                        = data.aws_subnets.comet_control_plane_subnets.ids
  cluster_version                                 = "1.32"
  cluster_endpoint_public_access                  = true
  cluster_endpoint_private_access                 = true
  additional_cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]
  kms_key_arn                                     = null
  # Enable creation of the EKS log group in CloudWatch so control plane logs are
  # automatically stored.  If an old log group exists from a previous run you
  # can remove it via the AWS console or using the AWS CLI
  #   aws logs delete-log-group --log-group-name /aws/eks/comet-eks/cluster
  # before applying this configuration.
  create_cloudwatch_log_group = true
  #eks_managed_node_group_defaults = ["t3.medium"]

  eks_managed_node_groups = {
    default = {
      min_size     = 1
      max_size     = 3
      desired_size = 2

      instance_types = ["t3.medium"]

      capacity_type = "ON_DEMAND"

      # Launch instances without public IPs since our subnets don't auto assign
      network_interfaces = [{
        associate_public_ip_address = false
      }]

      labels = {
        role = "worker"
      }

      tags = {
        Name = "comet-ng"
      }
    }
  }
}

module "comet_ecr" {
  source = "../modules/ecr"

  name = "comet-ecr"

}
