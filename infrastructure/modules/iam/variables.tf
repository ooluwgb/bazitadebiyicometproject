variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all IAM resources"
  type        = map(string)
  default     = {}
}

variable "enable_irsa" {
  description = "Whether to create an IAM OIDC provider and IRSA role"
  type        = bool
  default     = false
}

variable "irsa_service_account" {
  description = "Name of the service account for IRSA"
  type        = string
  default     = "comet-irsa-sa"
}

variable "irsa_namespace" {
  description = "Namespace of the IRSA service account"
  type        = string
  default     = "default"
}

variable "irsa_policy_json" {
  description = "JSON IAM policy document for the IRSA role"
  type        = string
  default     = ""
}
