terraform {
  required_version = ">= 1.3"
  backend "s3" {
    bucket = "terraformstatemanagementcomet"
    dynamodb_table = "tfstatelockcomet"
    key = "envs/dev/terraform.tfstate"
    region = "us-east-2"
    // encrypt = true (Create KMS key)
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"

  default_tags {
    tags = {
      Environment = "dev"
      Project     = "comet"
      Owner       = "Bazit"
    }
  }
}
