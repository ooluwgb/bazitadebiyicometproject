variable "name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.32"
}

variable "vpc_id" {
  description = "ID of the VPC where EKS will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the worker nodes"
  type        = list(string)
}

variable "control_plane_subnet_ids" {
  description = "List of subnet IDs for EKS control plane endpoints"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}


variable "node_group_role_arn" {
  description = "IAM role ARN for the node group"
  type        = string
}

variable "active" {
  description = "Flag to indicate if the EKS cluster addons should be active"
  type        = bool
  default     = true
  
}

variable "coredns_autoscaling_values" {
  description = "Values for the CoreDNS autoscaling addon"
  type        = map(any)
  default     = {}
}

variable "additional_cluster_endpoint_public_access_cidrs" {
  description = "Additional CIDRs for public access to the EKS cluster endpoint"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "enable_pod_eni" {
  description = "Flag to enable the use of pod ENIs"
  type        = bool
  default     = true
}

variable "cluster_enabled_log_types" {
  description = "List of enabled log types for the EKS cluster"
  type        = list(string)
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable "eks_managed_node_groups" {
  description = "Map of EKS managed node groups with their configurations"
  type        = any
  default     = {}
}

# variable "ebs_csi_driver_role_name" {
#   description = "Name of the IAM role for the EBS CSI driver"
#   type        = string
#   default     = "ebs-csi-driver-role"
# }


variable "ebs_csi_driver_role" {
  description = "IAM role for the EBS CSI driver"
  type        = any
  default     = {
    iam_role_arn = ""
    iam_role_id  = ""
  }
}

# variable "ebs_csi_driver_addon_version" {
#   description = "Version of the EBS CSI driver addon"
#   type        = string
#   default     = "v1.21.0-eksbuild.1"
# }



variable "create_cloudwatch_log_group" {
  description = "Whether to create the CloudWatch log group for EKS"
  type        = bool
  default     = false
}
