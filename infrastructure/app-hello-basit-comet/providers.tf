terraform {
  required_version = ">= 1.3"
  backend "s3" {
    bucket = "terraformstatemanagementcomet"
    dynamodb_table = "tfstatelockcomet"
    key = "envs/dev/terraform.tfstate"
    region = "us-east-2"
    // encrypt = true (Create KMS key) // can use aws default key for this, removes need for CMK
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-2" #var.region

  default_tags {
    tags = {
    managed_by = "terraform",
    environment = "Production",
    project = "Comet",
    owner = "Bazit Adebiyi"
    }
  }
}
