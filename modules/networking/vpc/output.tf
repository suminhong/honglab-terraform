output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc.id
}

output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = try(aws_internet_gateway.igw.*.id[0], null)
}

output "vpn_gateway_id" {
  description = "The ID of the Virtual Private Gateway"
  value       = try(aws_vpn_gateway.vgw.*.id[0], null)
}