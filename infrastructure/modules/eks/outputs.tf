output "cluster_arn" {
  value = module.eks.cluster_arn
  description = "The ARN of the EKS cluster." 
}