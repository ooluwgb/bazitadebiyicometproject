variable "name" {
  description = "Name of the VPC"
  type        = string
  default     = "dev-vpc"
  
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
  
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
  
}

variable "vpc_endpoints" {
  description = "Map of VPC interface endpoints to create"
  type = map(object({
    service             = string
    subnet_ids          = list(string)
    security_group_ids  = list(string)
    private_dns_enabled = bool
    tags                = map(string)
  }))
  default = {}
}


variable "gateway_endpoints" {
  description = "Map of VPC gateway endpoints to create"
  type = map(object({
    service = string
    tags    = map(string)
  }))
  default = {}
}