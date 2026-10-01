variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.35"
}

variable "vpc_id" {
  description = "VPC ID for EKS"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for EKS"
  type        = list(string)
}

variable "public_access_cidrs" {
  description = "CIDR blocks allowed to access EKS public API"
  type        = list(string)
}

variable "node_instance_types" {
  description = "EKS worker node instance types"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "node_capacity_type" {
  description = "EKS node capacity type"
  type        = string
  default     = "ON_DEMAND"
}

variable "node_min_size" {
  description = "Minimum worker nodes"
  type        = number
  default     = 1
}

variable "node_desired_size" {
  description = "Desired worker nodes"
  type        = number
  default     = 1
}

variable "node_max_size" {
  description = "Maximum worker nodes"
  type        = number
  default     = 2
}

variable "node_disk_size" {
  description = "Worker node disk size in GB"
  type        = number
  default     = 20
}