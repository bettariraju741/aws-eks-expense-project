output "iam_role_arn" {
  value = aws_iam_role.backend.arn
}

output "iam_policy_arn" {
  value = aws_iam_policy.backend_secrets.arn
}

output "pod_identity_association_id" {
  value = aws_eks_pod_identity_association.backend.association_id
}
