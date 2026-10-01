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
module "eks" {
  source = "./modules/eks"

  project_name = var.project_name
  environment  = var.environment

  cluster_name       = var.eks_cluster_name
  kubernetes_version = var.kubernetes_version

  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids

  public_access_cidrs = var.eks_public_access_cidrs

  node_instance_types = var.eks_node_instance_types
  node_capacity_type  = var.eks_node_capacity_type

  node_min_size     = var.eks_node_min_size
  node_desired_size = var.eks_node_desired_size
  node_max_size     = var.eks_node_max_size

  node_disk_size = var.eks_node_disk_size
}