#can also use aws ecr module here, abstracts alot of complexity

resource "aws_ecr_repository" "this" {
  //for_each = var.repositories // redunant

  name                 =  var.name //each.key
  image_tag_mutability = "IMMUTABLE" // keeps tags from being overwritten

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = merge(var.tags, {
    Name = var.name //replacement for each.key
  })
}

resource "aws_ecr_lifecycle_policy" "this" {
  for_each = var.repositories

  repository = aws.aws_ecr_repository.this//aws_ecr_repository.this[each.key].name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire old images"
        selection = {
          tagStatus     = "any"
          countType     = "imageCountMoreThan"
          countNumber   = 10 //- find a good number to put here
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}


#you don't need the for_each for the ecr repo, unneccesary complexity, should be one repo per app