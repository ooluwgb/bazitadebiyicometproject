resource "aws_ecr_repository" "comet_repo" {
  for_each = var.repositories

  name                 = each.key
  image_tag_mutability = "MUTABLE" # or "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = each.value.image_scan_on_push
  }

  tags = merge(var.tags, {
    Name = each.key
  })
}

resource "aws_ecr_lifecycle_policy" "this" {
  for_each = var.repositories

  repository = aws_ecr_repository.this[each.key].name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire old images"
        selection = {
          tagStatus     = "any"
          countType     = "imageCountMoreThan"
          countNumber   = each.value.max_image_count
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}
