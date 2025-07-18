resource "aws_iam_role" "this" {
  name                 = var.role_name
  assume_role_policy   = var.assume_role_policy == "" ? data.aws_iam_policy_document.this.json : var.assume_role_policy
  max_session_duration = var.max_session_duration
  path                 = var.path
  tags                 = var.tags
}

resource "aws_iam_role_policy" "this" {
  count  = var.inline_policy == "" ? 0 : 1
  name   = "${aws_iam_role.this.name}_inline_policy"
  role   = aws_iam_role.this.name
  policy = var.inline_policy
}

resource "aws_iam_role_policy_attachment" "this" {
  count      = length(var.policy_arns)
  role       = aws_iam_role.this.name
  policy_arn = var.policy_arns[count.index]
}