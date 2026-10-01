provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      Managedby   = "Terraform"
    }
  }
}
provider "helm" {
  kubernetes = {
    config_path = "~/.kube/config"
  }
}
