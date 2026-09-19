module "vpc" {
  source = "../../modules/vpc"

  project_name  = var.project_name
  environment   = var.environment
  vpc_cidr      = var.vpc_cidr

  availability_zones = var.availability_zones

  public_subnet_cidrs = var.public_subnet_cidrs

  private_eks_subnet_cidrs = var.private_eks_subnet_cidrs

  private_db_subnet_cidrs = var.private_db_subnet_cidrs
}

module "security_groups" {
  source = "../../modules/security-groups"

  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.vpc.vpc_id

  app_port = 8080
}

module "iam" {
  source = "../../modules/iam"

  project_name = var.project_name
  environment  = var.environment
}

module "ecr" {
  source = "../../modules/ecr"

  project_name = var.project_name
  environment  = var.environment

  repository_names = [
    "hsbc-prod-customer-service",
    "hsbc-prod-account-service",
    "hsbc-prod-card-service"
  ]
}

module "eks" {
  source = "../../modules/eks"

  project_name = var.project_name
  environment  = var.environment

  cluster_version = var.eks_cluster_version

  vpc_id = module.vpc.vpc_id

  private_eks_subnet_ids = module.vpc.private_eks_subnet_ids

  eks_cluster_role_arn = module.iam.eks_cluster_role_arn
  eks_node_role_arn    = module.iam.eks_node_role_arn

  cluster_security_group_id = module.security_groups.eks_cluster_security_group_id
}
