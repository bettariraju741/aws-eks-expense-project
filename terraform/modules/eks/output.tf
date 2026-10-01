output "cluster_name" {
  description = "EKS cluster name"
  value       = aws_eks_cluster.this.name
}

output "cluster_arn" {
  description = "EKS cluster ARN"
  value       = aws_eks_cluster.this.arn
}

output "cluster_endpoint" {
  description = "EKS Kubernetes API endpoint"
  value       = aws_eks_cluster.this.endpoint
}

output "cluster_certificate_authority_data" {
  description = "EKS cluster certificate authority data"
  value       = aws_eks_cluster.this.certificate_authority[0].data
  sensitive   = true
}

output "cluster_security_group_id" {
  description = "EKS cluster security group ID"
  value       = aws_eks_cluster.this.vpc_config[0].cluster_security_group_id
}

output "cluster_iam_role_arn" {
  description = "EKS cluster IAM role ARN"
  value       = aws_iam_role.cluster.arn
}

output "node_iam_role_arn" {
  description = "EKS node IAM role ARN"
  value       = aws_iam_role.node.arn
}

output "node_group_name" {
  description = "EKS managed node group name"
  value       = aws_eks_node_group.this.node_group_name
}

output "node_group_arn" {
  description = "EKS managed node group ARN"
  value       = aws_eks_node_group.this.arn
}