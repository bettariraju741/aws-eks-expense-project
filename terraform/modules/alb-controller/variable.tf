variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where EKS is running"
  type        = string
}

variable "account_id" {
  description = "AWS account ID"
  type        = string
}

variable "controller_version" {
  description = "AWS Load Balancer Controller version"
  type        = string
  default     = "v2.14.1"
}

variable "helm_chart_version" {
  description = "AWS Load Balancer Controller Helm chart version"
  type        = string
  default     = "1.14.1"
}