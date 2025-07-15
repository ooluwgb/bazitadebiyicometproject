##this is cool, but it should not be in the module, here in the modules I would don something like the below
#maybe make a small directory here to handle IAM policy creation??
##ALL the ready made roles should be in #app-hello-world directory
##also fix the output to be the arn of the role that's being created here

# resource "aws_iam_role" "this" {
#   name = "var.name"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Principal = {
#           Service = var.assume_role_service // e.g., "eks.amazonaws.com"
#         }
#         Action = "sts:AssumeRole"
#       }
#     ]
#   })

#   tags = merge(var.tags, {
#     Name = "${var.cluster_name}-eks-cluster-role"
#   })
# }

# resource "aws_iam_role_policy" "this" {
#   name = "${var.cluster_name}-eks-cluster-policy"

#   role   = aws_iam_role.eks_cluster.name
#   policy = //have chatgpt create a customizable policy based on the cluster requirements and put here

#   tags = merge(var.tags, {
#     Name = "${var.cluster_name}-eks-cluster-policy"
#   })
# }

# resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
#   role       = aws_iam_role.eks_cluster.name
#   policy_arn = data.aws_iam_policy.eks_cluster_policy.arn
# }

# --- EKS Cluster Role ---
resource "aws_iam_role" "eks_cluster" {
  name = "${var.cluster_name}-eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = merge(var.tags, {
    Name = "${var.cluster_name}-eks-cluster-role"
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"// use a data source to get the policy arn, never hardcode it
}

# --- Node Group Role ---
resource "aws_iam_role" "eks_node_group" {
  name = "${var.cluster_name}-eks-nodegroup-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = merge(var.tags, {
    Name = "${var.cluster_name}-eks-nodegroup-role"
  })
}

resource "aws_iam_role_policy_attachment" "node_AmazonEKSWorkerNodePolicy" {
  role       = aws_iam_role.eks_node_group.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "node_ECRReadOnly" {
  role       = aws_iam_role.eks_node_group.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "node_CNI" {
  role       = aws_iam_role.eks_node_group.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSCNIPolicy"
}

# --- Optional IRSA ---
resource "aws_iam_openid_connect_provider" "this" {
  count = var.enable_irsa ? 1 : 0

  url             = "https://oidc.eks.${data.aws_region.current.name}.amazonaws.com/id/EXAMPLED539D4633E53DE1B716D3041E"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["9e99a48a9960b14926bb7f3b02e22da0afd10c63"]
  # NOTE: Replace the URL and thumbprint dynamically in real code
  # Here it's hardcoded for demo purposes
}

resource "aws_iam_role" "irsa_role" {
  count = var.enable_irsa ? 1 : 0

  name = "${var.cluster_name}-irsa-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.this[0].arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "oidc.eks.${data.aws_region.current.name}.amazonaws.com/id/EXAMPLED539D4633E53DE1B716D3041E:sub" = "system:serviceaccount:${var.irsa_namespace}:${var.irsa_service_account}"
          }
        }
      }
    ]
  })

  tags = merge(var.tags, {
    Name = "${var.cluster_name}-irsa-role"
  })
}

resource "aws_iam_policy" "irsa_policy" {
  count = var.enable_irsa && var.irsa_policy_json != "" ? 1 : 0

  name   = "${var.cluster_name}-irsa-policy"
  policy = var.irsa_policy_json
}

resource "aws_iam_role_policy_attachment" "irsa_policy_attachment" {
  count      = var.enable_irsa && var.irsa_policy_json != "" ? 1 : 0
  role       = aws_iam_role.irsa_role[0].name
  policy_arn = aws_iam_policy.irsa_policy[0].arn
}

data "aws_region" "current" {}


#it's code is being repeated here