data "aws_iam_policy_document" "backend_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]
  }
}

data "aws_iam_policy_document" "backend_secrets" {
  statement {
    effect = "Allow"

    actions = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret"
    ]

    resources = [
      var.rds_secret_arn
    ]
  }
}

resource "aws_iam_role" "backend" {
  name = "${var.project_name}-${var.environment}-eks-backend-role"

  assume_role_policy = data.aws_iam_policy_document.backend_assume_role.json

  tags = {
    Name = "${var.project_name}-${var.environment}-eks-backend-role"
  }
}

resource "aws_iam_policy" "backend_secrets" {
  name        = "${var.project_name}-${var.environment}-eks-backend-secrets-policy"
  description = "Allow Expense backend to read its RDS secret"

  policy = data.aws_iam_policy_document.backend_secrets.json

  tags = {
    Name = "${var.project_name}-${var.environment}-eks-backend-secrets-policy"
  }
}

resource "aws_iam_role_policy_attachment" "backend_secrets" {
  role       = aws_iam_role.backend.name
  policy_arn = aws_iam_policy.backend_secrets.arn
}

resource "aws_eks_pod_identity_association" "backend" {
  cluster_name    = var.cluster_name
  namespace       = "expense"
  service_account = "expense-backend"
  role_arn        = aws_iam_role.backend.arn

  depends_on = [
    aws_iam_role_policy_attachment.backend_secrets
  ]
}
