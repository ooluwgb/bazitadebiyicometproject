terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.34"
    }
    twingate = {
      source  = "twingate/twingate"
      version = ">= 2.0"
    }
  }
}
