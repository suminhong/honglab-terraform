output "vpce_id" {
  description = "The ID of VPC Endpoint"
  value       = aws_vpc_endpoint.vpce.id
}

output "vpce_ips" {
  description = "The Private IP List of VPC Endpoint"
  value       = data.aws_network_interface.vpce_ip_id.*.private_ip[*]
}