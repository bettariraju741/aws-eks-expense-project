output "db_instance_id" {
  description = "RDS instance identifier"

  value = aws_db_instance.this.id
}

output "db_endpoint" {
  description = "RDS endpoint"

  value = aws_db_instance.this.address
}

output "db_port" {
  description = "RDS database port"

  value = aws_db_instance.this.port
}

output "db_name" {
  description = "Database name"

  value = aws_db_instance.this.db_name
}

output "security_group_id" {
  description = "RDS security group ID"

  value = aws_security_group.rds.id
}

output "subnet_group_name" {
  description = "RDS subnet group name"

  value = aws_db_subnet_group.this.name
}
