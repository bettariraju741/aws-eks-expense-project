output "instance_id" {
  description = "Monitoring EC2 instance ID"
  value       = aws_instance.monitoring.id
}

output "private_ip" {
  description = "Monitoring EC2 private IP"
  value       = aws_instance.monitoring.private_ip
}

output "security_group_id" {
  description = "Monitoring EC2 security group ID"
  value       = aws_security_group.monitoring.id
}

output "iam_role_arn" {
  description = "Monitoring EC2 IAM role ARN"
  value       = aws_iam_role.monitoring.arn
}
