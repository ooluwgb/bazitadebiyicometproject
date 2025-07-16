output "cluster_arn" {
  value = module.eks.cluster_arn
  description = "The ARN of the EKS cluster." 
}

output "cluster_name" {
  value       = module.eks.cluster_name
  description = "The name of the EKS cluster."
}

output "cluster_endpoint" {
  value       = module.eks.cluster_endpoint
  description = "The endpoint for the EKS cluster."
}

output "kubeconfig_filename" {
  value       = module.eks.kubeconfig_filename
  description = "Path to the generated kubeconfig file."
}

output "cluster_oidc_issuer_url" {
  value       = module.eks.cluster_oidc_issuer_url
  description = "OIDC issuer URL for the EKS cluster."
}

output "node_group_names" {
  value       = module.eks.eks_managed_node_groups[*].node_group_name
  description = "Names of the managed node groups."
}
