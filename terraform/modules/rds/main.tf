locals {
  name_prefix = "${var.project_name}-${var.environment}"
}

resource "aws_security_group" "rds" {
  name        = "${local.name_prefix}-rds-sg"
  description = "Security group for Expense RDS MySQL"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${local.name_prefix}-rds-sg"
  }
}

resource "aws_db_subnet_group" "this" {
  name = "${local.name_prefix}-db-subnet-group"

  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${local.name_prefix}-db-subnet-group"
  }
}

resource "aws_db_instance" "this" {
  identifier = "${local.name_prefix}-mysql"

  engine         = "mysql"
  engine_version = var.engine_version

  instance_class        = var.instance_class
  allocated_storage     = var.allocated_storage
  max_allocated_storage = 100
  storage_type          = "gp3"
  storage_encrypted     = true

  db_name  = var.db_name
  username = var.db_username
  port     = 3306

  manage_master_user_password = true

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.rds.id]

  publicly_accessible = false
  multi_az            = var.multi_az

  backup_retention_period = var.backup_retention_period
  backup_window           = "03:00-04:00"
  maintenance_window      = "sun:04:00-sun:05:00"

  auto_minor_version_upgrade = true

  deletion_protection = var.deletion_protection
  skip_final_snapshot = true

  copy_tags_to_snapshot = true

  tags = {
    Name = "${local.name_prefix}-mysql"
  }
}
resource "aws_vpc_security_group_ingress_rule" "mysql_from_eks" {
  security_group_id            = aws_security_group.rds.id
  referenced_security_group_id = var.eks_node_security_group_id

  ip_protocol = "tcp"
  from_port   = 3306
  to_port     = 3306

  description = "Allow MySQL from EKS worker nodes"
}