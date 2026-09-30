variable "project_name" {
  description = "project name"
  type        = string
}
variable "environment" {
  description = "Environment name"
  type        = string
}
variable "repositories" {
  description = "List of ECR repositories to create"
  type        = set(string)
}