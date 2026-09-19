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
  node_security_group_id    = module.security_groups.eks_node_security_group_id
}

module "kms" {
  source = "../../modules/kms"

  project_name = var.project_name
  environment  = var.environment
}

module "rds" {
  source = "../../modules/rds"

  project_name = var.project_name
  environment  = var.environment

  db_subnet_ids = module.vpc.private_db_subnet_ids

  rds_security_group_id = module.security_groups.rds_security_group_id

  kms_key_arn = module.kms.rds_kms_key_arn

  db_name     = var.rds_db_name
  db_username = var.rds_db_username

  db_instance_class = var.rds_instance_class

  allocated_storage     = var.rds_allocated_storage
  max_allocated_storage = var.rds_max_allocated_storage

  mysql_engine_version = var.mysql_engine_version

  backup_retention_period = var.rds_backup_retention_period
}

module "secrets_manager" {
  source = "../../modules/secrets-manager"

  project_name = var.project_name
  environment  = var.environment

  rds_secret_arn = module.rds.master_user_secret_arn
}

resource "aws_eks_pod_identity_association" "aws_load_balancer_controller" {
  cluster_name    = module.eks.cluster_name
  namespace       = "kube-system"
  service_account = "aws-load-balancer-controller"

  role_arn = module.load_balancer_controller.iam_role_arn

  depends_on = [
    module.eks
  ]
}

module "load_balancer_controller" {
  source = "../../modules/load-balancer-controller"

  project_name = var.project_name
  environment  = var.environment

  cluster_name = module.eks.cluster_name
  aws_region   = var.aws_region
  vpc_id       = module.vpc.vpc_id
}

module "route53" {
  source = "../../modules/route53"

  project_name = var.project_name
  environment  = var.environment
  domain_name  = var.domain_name
}
