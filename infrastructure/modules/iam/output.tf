output "arn" {
  value       = aws_iam_role.this.arn
  description = "The ARN of the IAM Role"
}

output "iam_role_name" {
  value       = aws_iam_role.this.name
  description = "The NAME of the IAM Role"
}