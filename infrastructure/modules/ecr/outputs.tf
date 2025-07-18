output "repository_urls" {
  description = "Map of ECR repository URLs"
  value = {
    for repo, details in aws_ecr_repository.this :
    repo => details.repository_url
  }
}

output "repository_arns" {
  description = "Map of ECR repository ARNs"
  value = {
    for repo, details in aws_ecr_repository.this :
    repo => details.arn
  }
}
