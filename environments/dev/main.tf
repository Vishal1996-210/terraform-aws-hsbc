module "vpc" {
  source = "../../modules/vpc"

  project_name = var.project_name
  environment  = var.environment

  vpc_cidr = "10.10.0.0/16"

  availability_zones = [
    "ap-south-1a",
    "ap-south-1b"
  ]

  public_subnet_cidrs = [
    "10.10.1.0/24",
    "10.10.2.0/24"
  ]

  private_app_subnet_cidrs = [
    "10.10.11.0/24",
    "10.10.12.0/24"
  ]

  private_db_subnet_cidrs = [
    "10.10.21.0/24",
    "10.10.22.0/24"
  ]
}

module "security_groups" {
  source = "../../modules/security-groups"

  project_name = var.project_name
  environment  = var.environment

  vpc_id = module.vpc.vpc_id
}

module "alb" {
  source = "../../modules/alb"

  project_name = var.project_name
  environment  = var.environment

  vpc_id = module.vpc.vpc_id

  public_subnet_ids = module.vpc.public_subnet_ids

  security_group_id = module.security_groups.alb_security_group_id

  target_port       = 8080
  health_check_path = "/actuator/health"
}

module "autoscaling" {
  source = "../../modules/autoscaling"

  project_name = var.project_name
  environment  = var.environment

  vpc_id = module.vpc.vpc_id

  private_app_subnet_ids = module.vpc.private_app_subnet_ids

  security_group_id = module.security_groups.app_security_group_id

  target_group_arn = module.alb.target_group_arn

  instance_profile_name = module.iam.ec2_instance_profile_name

  instance_type = "t3.micro"

  min_size         = 2
  desired_capacity = 2
  max_size         = 4

  app_port = 8080
}

module "iam" {
  source = "../../modules/iam"

  project_name = var.project_name
  environment  = var.environment
}
