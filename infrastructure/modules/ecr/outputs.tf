output "repository_urls" {
  description = "Map of ECR repository URLs"
  value = aws_ecr_repository.this.repository_url
}

output "repository_name" {
  description = "Map of ECR repository ARNs"
  value = aws_ecr_repository.this.name
}
