# always make sure your variables are in modules.tf...
# variable "region" {
#   description = "AWS region"
#   type        = string
#   default     = "us-east-2"
# }

# variable "vpc_cidr" {
#   description = "CIDR block for the VPC"
#   type        = string
#   default     = "10.0.0.0/16"
# }

# variable "public_subnets" {
#   description = "List of public subnet CIDRs"
#   type        = list(string)
#   default     = ["10.0.1.0/24", "10.0.2.0/24"]
# }

# variable "private_subnets" {
#   description = "List of private subnet CIDRs"
#   type        = list(string)
#   default     = ["10.0.101.0/24", "10.0.102.0/24"]
# }

# variable "tags" {
#   description = "Tags to apply to resources"
#   type        = map(string)
#   default     = {}
# }
