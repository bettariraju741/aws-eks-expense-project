terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "expense"
      Environment = "dev"
      ManagedBy   = "Terraform"
      Purpose     = "monitoring"
    }
  }
}

data "aws_caller_identity" "current" {}

data "aws_ssm_parameter" "al2023_ami" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

resource "aws_security_group" "monitoring" {
  name        = "expense-dev-monitoring-sg"
  description = "Security group for private monitoring EC2"
  vpc_id      = var.vpc_id

  egress {
    description = "Allow outbound traffic for SSM and monitoring integrations"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "expense-dev-monitoring-sg"
  }
}

resource "aws_iam_role" "monitoring" {
  name = "expense-dev-monitoring-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.monitoring.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "monitoring" {
  name = "expense-dev-monitoring-instance-profile"
  role = aws_iam_role.monitoring.name
}

resource "aws_instance" "monitoring" {
  ami                         = data.aws_ssm_parameter.al2023_ami.value
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.monitoring.id]
  iam_instance_profile        = aws_iam_instance_profile.monitoring.name
  associate_public_ip_address = false

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  root_block_device {
    volume_type           = "gp3"
    volume_size           = var.root_volume_size
    encrypted             = true
    delete_on_termination = true
  }

  tags = {
    Name = "expense-dev-monitoring"
  }

  depends_on = [
    aws_iam_role_policy_attachment.ssm
  ]
}
resource "aws_vpc_security_group_ingress_rule" "eks_api_from_monitoring" {
  security_group_id            = "sg-008fbb7739e58ffde"
  referenced_security_group_id = aws_security_group.monitoring.id

  ip_protocol = "tcp"
  from_port   = 443
  to_port     = 443

  description = "Allow monitoring EC2 to reach the EKS Kubernetes API"
}
resource "aws_iam_role_policy" "eks_describe" {
  name = "expense-dev-monitoring-eks-describe"
  role = aws_iam_role.monitoring.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "eks:DescribeCluster"
        ]
        Resource = "arn:aws:eks:us-east-1:318432260649:cluster/expense-dev-eks"
      }
    ]
  })
}
