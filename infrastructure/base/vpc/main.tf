module "vpc" {
    source  = "terraform-aws-modules/vpc/aws"
    version = "~> 5.0"

    name = "my-vpc"
    cidr = "10.0.0.0/16"

    azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
    public_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
    private_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

    enable_nat_gateway = true
    single_nat_gateway = true

    tags = {
        Terraform   = "true"
        Environment = "dev"
    }
}


##only use the module the rest is redundant
# provider "aws" {
#   region = var.region
# }

# resource "aws_vpc" "main" {
#   cidr_block           = var.vpc_cidr
#   enable_dns_support   = true
#   enable_dns_hostnames = true

#   tags = merge(var.tags, {
#     Name = "comet-base-vpc"
#   })
# }

# resource "aws_internet_gateway" "igw" {
#   vpc_id = aws_vpc.main.id

#   tags = merge(var.tags, {
#     Name = "comet-igw"
#   })
# }

# # Public subnets
# resource "aws_subnet" "public" {
#   count = length(var.public_subnets)

#   vpc_id                  = aws_vpc.main.id
#   cidr_block              = var.public_subnets[count.index]
#   availability_zone       = element(data.aws_availability_zones.available.names, count.index)
#   map_public_ip_on_launch = true

#   tags = merge(var.tags, {
#     Name = "comet-public-subnet-${count.index + 1}"
#   })
# }

# # Private subnets
# resource "aws_subnet" "private" {
#   count = length(var.private_subnets)

#   vpc_id            = aws_vpc.main.id
#   cidr_block        = var.private_subnets[count.index]
#   availability_zone = element(data.aws_availability_zones.available.names, count.index)

#   tags = merge(var.tags, {
#     Name = "comet-private-subnet-${count.index + 1}"
#   })
# }

# # NAT Gateway (Optional)
# resource "aws_eip" "nat" {
#   count = length(var.private_subnets) > 0 ? 1 : 0

#   vpc = true

#   tags = merge(var.tags, {
#     Name = "comet-nat-eip"
#   })
# }

# resource "aws_nat_gateway" "nat" {
#   count = length(var.private_subnets) > 0 ? 1 : 0

#   allocation_id = aws_eip.nat[0].id
#   subnet_id     = aws_subnet.public[0].id

#   tags = merge(var.tags, {
#     Name = "comet-nat-gateway"
#   })
# }

# # Public route table
# resource "aws_route_table" "public" {
#   vpc_id = aws_vpc.main.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.igw.id
#   }

#   tags = merge(var.tags, {
#     Name = "comet-public-rt"
#   })
# }

# resource "aws_route_table_association" "public" {
#   count = length(aws_subnet.public)

#   subnet_id      = aws_subnet.public[count.index].id
#   route_table_id = aws_route_table.public.id
# }

# # Private route table (uses NAT)
# resource "aws_route_table" "private" {
#   count = length(var.private_subnets) > 0 ? 1 : 0

#   vpc_id = aws_vpc.main.id

#   route {
#     cidr_block     = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.nat[0].id
#   }

#   tags = merge(var.tags, {
#     Name = "comet-private-rt"
#   })
# }

# resource "aws_route_table_association" "private" {
#   count = length(aws_subnet.private)

#   subnet_id      = aws_subnet.private[count.index].id
#   route_table_id = aws_route_table.private[0].id
# }

# # Basic security group for networking
# resource "aws_security_group" "base_sg" {
#   name        = "comet-base-sg"
#   description = "Base security group allowing basic traffic"
#   vpc_id      = aws_vpc.main.id

#   ingress {
#     description = "Allow SSH"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = merge(var.tags, {
#     Name = "comet-base-sg"
#   })
# }

# data "aws_availability_zones" "available" {}
