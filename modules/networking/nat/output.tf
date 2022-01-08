output "nat_id" {
  description = "The ID of the NAT Gateway"
  value       = aws_nat_gateway.nat.id
}

output "public_ip" {
  description = "The public IP address of the NAT Gateway"
  value       = try(aws_nat_gateway.nat.public_ip, null)
}

output "private_ip" {
  description = "The private IP address of the NAT Gateway"
  value       = aws_nat_gateway.nat.private_ip
}