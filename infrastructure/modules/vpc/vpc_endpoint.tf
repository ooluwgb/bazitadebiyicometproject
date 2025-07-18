# resource "aws_vpc_endpoint" "interface" {
#   for_each = var.vpc_endpoints

#   vpc_id            = module.vpc.vpc_id
#   service_name      = "com.amazonaws.${var.region}.${each.value.service}"
#   vpc_endpoint_type = "Interface"

#   subnet_ids          = each.value.subnet_ids
#   security_group_ids  = each.value.security_group_ids
#   private_dns_enabled = each.value.private_dns_enabled

#   tags = merge(
#     {
#       Name = "${each.key}-vpc-endpoint"
#     },
#     each.value.tags
#   )
# }

# resource "aws_vpc_endpoint" "gateway" {
#   for_each = var.gateway_endpoints

#   vpc_id            = module.vpc.vpc_id
#   service_name      = "com.amazonaws.${var.region}.${each.value.service}"
#   vpc_endpoint_type = "Gateway"

#   route_table_ids = module.vpc.private_route_table_ids

#   tags = merge(
#     {
#       Name = "${each.key}-gateway-endpoint"
#     },
#     var.tags
#   )
# }

# resource "aws_vpc_endpoint" "ecr_api" {
#   vpc_id              = aws_vpc.main.id
#   service_name        = "com.amazonaws.${var.region}.ecr.api"
#   vpc_endpoint_type   = "Interface"
#   subnet_ids          = aws_subnet.private[*].id
#   security_group_ids  = [aws_security_group.default.id]
#   private_dns_enabled = true
#   tags = merge(var.tags, {
#     Name = "ecr-api"
#   })
# }
