module "ecr" {
  source = "./modules/ecr"

  project_name = var.project_name
  environment  = var.environment

  repositories = [
    "frontend",
    "backend"
  ]
}

module "vpc" {
  source = "./modules/vpc"

  project_name = var.project_name
  environment  = var.environment

  vpc_cidr             = var.vpc_cidr
  availability_zones   = var.availability_zones
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs

  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = var.single_nat_gateway
}

module "rds" {
  source = "./modules/rds"

  project_name = var.project_name
  environment  = var.environment

  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids

  db_name     = var.db_name
  db_username = var.db_username

  instance_class    = var.db_instance_class
  allocated_storage = var.db_allocated_storage
  multi_az          = var.db_multi_az
}