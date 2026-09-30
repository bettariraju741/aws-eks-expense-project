output "ecr_repository_urls" {
  description = "ECR repository URLs"

  value = module.ecr.repository_urls
}

output "vpc_id" {
  description = "VPC ID"

  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"

  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private subnet IDs"

  value = module.vpc.private_subnet_ids
}

output "nat_gateway_ids" {
  description = "NAT Gateway IDs"

  value = module.vpc.nat_gateway_ids
}
