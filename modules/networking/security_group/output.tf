output "sg_id" {
  description = "The ID of the Security Group"
  value       = aws_security_group.sg.id
}

output "sg_arn" {
  description = "The ARN of the Security Group"
  value       = aws_security_group.sg.arn
}