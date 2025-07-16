variable "name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.29"
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

variable "cluster_addons" {
  description = "Map of EKS cluster addons to enable"
  type        = map(any)
  default     = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }
  
}

variable "cluster_role_arn" {
  description = "IAM role ARN for the EKS cluster"
  type        = string
}

variable "node_group_role_arn" {
  description = "IAM role ARN for the node group"
  type        = string
}
