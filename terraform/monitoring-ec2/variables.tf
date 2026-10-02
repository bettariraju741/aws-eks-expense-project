variable "aws_region" {
  description = "AWS region for the monitoring server"
  type        = string
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "Existing EKS VPC ID"
  type        = string
  default     = "vpc-0c07a2785b1b79ca7"
}

variable "subnet_id" {
  description = "Existing private subnet in us-east-1b"
  type        = string
  default     = "subnet-0506f8798aa8f8b41"
}

variable "instance_type" {
  description = "Monitoring EC2 instance type"
  type        = string
  default     = "t3.small"
}

variable "root_volume_size" {
  description = "Encrypted gp3 root volume size in GiB"
  type        = number
  default     = 30
}
