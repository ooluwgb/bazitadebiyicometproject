locals {
  default_lifecycle_count = var.snapshot ? 350 : 300
  lifecycle_count         = coalesce(var.lifecycle_count, local.default_lifecycle_count)
}

resource "aws_ecr_repository" "this" {
  name = var.name

  tags = merge(
    {
      Name = var.name
    },
    var.tags
  )
}

resource "aws_ecr_lifecycle_policy" "this" {
  repository = aws_ecr_repository.this.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last ${local.lifecycle_count} images",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": ${local.lifecycle_count}
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}