resource "aws_iam_role" "this" {
  name        = var.name
  name_prefix = var.name_prefix
  path        = var.path
  description = var.description

  assume_role_policy    = data.aws_iam_policy_document.this.json
  max_session_duration  = var.max_session_duration
  permissions_boundary  = var.role_permissions_boundary_arn

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = var.policy_arns

  role       = aws_iam_role.this.name
  policy_arn = each.value
}
