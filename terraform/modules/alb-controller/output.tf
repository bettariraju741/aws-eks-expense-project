output "iam_role_arn" {
  description = "IAM role ARN used by the AWS Load Balancer Controller"
  value       = aws_iam_role.controller.arn
}

output "iam_policy_arn" {
  description = "IAM policy ARN attached to the AWS Load Balancer Controller role"
  value       = aws_iam_policy.controller.arn
}

output "pod_identity_association_id" {
  description = "EKS Pod Identity association ID for the AWS Load Balancer Controller"
  value       = aws_eks_pod_identity_association.controller.association_id
}

output "helm_release_name" {
  description = "Helm release name of the AWS Load Balancer Controller"
  value       = helm_release.controller.name
}

output "helm_release_namespace" {
  description = "Kubernetes namespace where the AWS Load Balancer Controller is installed"
  value       = helm_release.controller.namespace
}