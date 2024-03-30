output "subnet_ids" {
  description = "The ID List of the Subnets"
  value       = aws_subnet.subnet.*.id
}

output "subnet_arns" {
  description = "The ARN List of the Subnets"
  value       = aws_subnet.subnet.*.arn
}

output "rt_id" {
  description = "The ID of the Routing Table"
  value       = aws_route_table.rt.id
}