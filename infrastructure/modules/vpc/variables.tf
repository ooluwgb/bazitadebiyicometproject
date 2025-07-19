variable "name" {
  description = "Name of the VPC"
  type        = string
  default     = "dev-vpc"
}

variable "cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
  default     = []
}

variable "public_subnets" {
  description = "Public subnet CIDRs"
  type        = list(string)
  default     = []
}

variable "private_subnets" {
  description = "Private subnet CIDRs"
  type        = list(string)
  default     = []
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

variable "enable_nat_gateway" {
  description = "Whether to create NAT gateways for private subnets"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Use a single shared NAT gateway across AZs"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool
  default     = true
}