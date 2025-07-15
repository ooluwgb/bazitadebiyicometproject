output "eks_cluster_role_arn" {
  description = "ARN of the EKS cluster IAM role"
  value       = aws_iam_role.eks_cluster.arn
}

output "eks_node_group_role_arn" {
  description = "ARN of the EKS node group IAM role"
  value       = aws_iam_role.eks_node_group.arn
}

output "irsa_role_arn" {
  description = "ARN of the IRSA role (if enabled)"
  value       = try(aws_iam_role.irsa_role[0].arn, null)
}

output "irsa_policy_arn" {
  description = "ARN of the IRSA policy (if enabled)"
  value       = try(aws_iam_policy.irsa_policy[0].arn, null)
}
