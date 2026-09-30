variable "aws_region" {
    description = "aws region"
    type = string
    default = "us-east-1"
  
}

variable "project_name" {
    description = "project name used by aws resources"
    type = string
    default = "expense"
  
}
variable "environment" {
    description = "Deployment environment"
    type = string
    default = "dev"
}