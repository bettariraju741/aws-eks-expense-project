variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name used for AWS resources"
  type        = string
  default     = "expense"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default = [
    "us-east-1a",
    "us-east-1b"
  ]
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs"
  type        = list(string)
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDRs"
  type        = list(string)
  default = [
    "10.0.11.0/24",
    "10.0.12.0/24"
  ]
}

variable "enable_nat_gateway" {
  description = "Enable NAT Gateway"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Use a single NAT Gateway for the dev environment"
  type        = bool
  default     = true
}

variable "db_name" {
  description = "Expense database name"
  type        = string
  default     = "expenses"
}

variable "db_username" {
  description = "Expense database username"
  type        = string
  default     = "expense"
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "RDS allocated storage in GB"
  type        = number
  default     = 20
}

variable "db_multi_az" {
  description = "Enable RDS Multi-AZ"
  type        = bool
  default     = false
}
variable "eks_cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "expense-dev-eks"
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.35"
}

variable "eks_public_access_cidrs" {
  description = "CIDRs allowed to access EKS public API"
  type        = list(string)
}

variable "eks_node_instance_types" {
  description = "EKS node instance types"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "eks_node_capacity_type" {
  description = "EKS node capacity type"
  type        = string
  default     = "ON_DEMAND"
}

variable "eks_node_min_size" {
  description = "Minimum EKS nodes"
  type        = number
  default     = 1
}

variable "eks_node_desired_size" {
  description = "Desired EKS nodes"
  type        = number
  default     = 1
}

variable "eks_node_max_size" {
  description = "Maximum EKS nodes"
  type        = number
  default     = 2
}

variable "eks_node_disk_size" {
  description = "EKS node disk size"
  type        = number
  default     = 20
}