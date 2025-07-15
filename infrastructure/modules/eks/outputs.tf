output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_oidc_issuer_url" {
  value = module.eks.cluster_oidc_issuer_url
}

output "kubeconfig_filename" {
  value = module.eks.kubeconfig_filename
}

output "node_group_names" {
  value = module.eks.eks_managed_node_groups[*].node_group_name
}
