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


output "cluster_oidc_issuer_url" {
  value       = module.eks.cluster_oidc_issuer_url
  description = "OIDC issuer URL for the EKS cluster."
}

