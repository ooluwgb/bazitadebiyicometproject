# ## implement the recommended fixes for the IAM role modules first before proqceeding with this
# module "iam" {
#   source = "./modules/iam"

#   cluster_name         = var.cluster_name
#   enable_irsa          = true
#   irsa_service_account = "comet-irsa-sa"
#   irsa_namespace       = "default"
#   irsa_policy_json     = jsonencode({
#     Version = "2012-10-17",
#     Statement = [{
#       Effect   = "Allow",
#       Action   = ["s3:ListBucket"],
#       Resource = "*"
#     }]
#   })
#   tags = var.tags
# }