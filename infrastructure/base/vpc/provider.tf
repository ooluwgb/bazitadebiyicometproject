terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
}

provider "aws" {
    region = "us-east-1"
}


#is putting this here intentional??
# module "vpc" {
#     source  = "terraform-aws-modules/vpc/aws"
#     version = "~> 5.0"

#     name = "my-vpc"
#     cidr = "10.0.0.0/16"

#     azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
#     public_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
#     private_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

#     enable_nat_gateway = true
#     single_nat_gateway = true

#     tags = {
#         Terraform   = "true"
#         Environment = "dev"
#     }
# }