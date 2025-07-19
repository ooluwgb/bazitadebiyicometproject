module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.name
  cluster_version = var.cluster_version

  bootstrap_self_managed_addons = false

  cluster_endpoint_public_access  = var.cluster_endpoint_public_access
  cluster_endpoint_private_access = var.cluster_endpoint_private_access

  enable_irsa                          = true
  vpc_id                               = var.vpc_id
  subnet_ids                           = var.subnet_ids
  iam_role_name                        = var.name
  cluster_security_group_name          = var.name
  cluster_security_group_description   = "${var.name} EKS cluster security group."
  cluster_enabled_log_types            = var.cluster_enabled_log_types
  create_cloudwatch_log_group          = var.create_cloudwatch_log_group
  control_plane_subnet_ids             = var.control_plane_subnet_ids
  cluster_endpoint_public_access_cidrs = var.additional_cluster_endpoint_public_access_cidrs
  #cluster_role_arn                  = var.cluster_role_arn

  enable_cluster_creator_admin_permissions = true

  cluster_encryption_config = var.kms_key_arn != null ? [{
    provider_key_arn = var.kms_key_arn
    resources        = ["secrets"]
  }] : []

  cluster_addons = var.active ? {} : {
    coredns = {
      configuration_values = jsonencode(merge(local.coredns_addon_config_vals, var.coredns_autoscaling_values))
      most_recent          = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
      configuration_values = jsonencode({
        init = {
          env = {
            DISABLE_TCP_EARLY_DEMUX = "true" # required for sg for pods. See https://github.com/aws/amazon-vpc-cni-k8s/blob/master/README.md#disable_tcp_early_demux-v173
          }
        }
        env = {
          ENABLE_POD_ENI                    = var.enable_pod_eni ? "true" : "false" # enable sg for pods
          POD_SECURITY_GROUP_ENFORCING_MODE = "strict"                              # for whitelisting cross VPC (e.g. peering) to work, otherwise it uses eks node sg
        }
      })
    }
    aws-ebs-csi-driver = {
      service_account_role_arn = var.ebs_csi_driver_role.iam_role_arn
      most_recent              = true
    }
  }

  eks_managed_node_group_defaults = {
    enable_monitoring = true
    instance_types    = ["t3.medium", "t3.large"]
    iam_role_arn      = var.node_group_role_arn
  }

  eks_managed_node_groups = {
    for k, v in var.eks_managed_node_groups : k => merge(v, {
      name                            = "${var.name}-${k}"
      use_name_prefix                 = true
      launch_template_name            = "${var.name}-${k}-lt"
      launch_template_use_name_prefix = true
      min_size                        = var.active ? v.min_size : 0
      desired_size                    = var.active ? v.desired_size : 0
      iam_role_arn                    = coalesce(v.iam_role_arn, var.node_group_role_arn)
    })
  }
  tags = var.tags
}


