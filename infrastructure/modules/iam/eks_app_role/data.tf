locals {
  account_id     = data.aws_caller_identity.current.account_id
  oidc_providers = [for c in data.aws_eks_cluster.this : replace(c.identity[0].oidc[0].issuer, "https://", "")]
}

data "aws_partition" "current" {}
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_eks_clusters" "this" {}
data "aws_eks_cluster" "this" {
  for_each = toset(data.aws_eks_clusters.this.names)
  name     = each.value
}

data "aws_iam_policy_document" "this" {
  dynamic "statement" {
    for_each = var.github_repo != "" ? [""] : []
    content {
      actions = [
        "sts:AssumeRoleWithWebIdentity"
      ]
      principals {
        type = "Federated"
        identifiers = [
          "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"
        ]
      }
      condition {
        test     = "StringLike"
        variable = "token.actions.githubusercontent.com:sub"
        # Ref: https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services#configuring-the-role-and-trust-policy
        values = [for env in var.github_environments : "repo:ml-ews/${var.github_repo}:environment:${env}:*"]
      }
      condition {
        test     = "StringEquals"
        variable = "token.actions.githubusercontent.com:aud"
        values = [
          "sts.amazonaws.com"
        ]
      }
    }
  }

  dynamic "statement" {
    for_each = var.allow_human ? [""] : []
    content {
      actions = [
        "sts:AssumeRole",
      ]
      principals {
        type = "AWS"
        identifiers = [
          "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
        ]
      }
      condition {
        test     = "ArnEquals"
        variable = "aws:PrincipalArn"
        values = [
          "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_*",
        ]
      }
    }
  }

  dynamic "statement" {
    for_each = local.oidc_providers

    content {
      effect  = "Allow"
      actions = ["sts:AssumeRoleWithWebIdentity"]

      principals {
        type        = "Federated"
        identifiers = ["arn:aws:iam::${local.account_id}:oidc-provider/${statement.value}"]
      }

      condition {
        test     = "StringLike"
        variable = "${statement.value}:sub"
        values   = [for c in var.namespace_service_account : "system:serviceaccount:${c}"]
      }

      condition {
        test     = "StringEquals"
        variable = "${statement.value}:aud"
        values   = ["sts.amazonaws.com"]
      }
    }
  }
}
