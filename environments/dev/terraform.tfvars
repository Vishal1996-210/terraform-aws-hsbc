aws_region   = "ap-south-1"
environment  = "prod"
project_name = "hsbc"

aws_region   = "ap-south-1"
environment  = "prod"
project_name = "hsbc"

vpc_cidr = "10.20.0.0/16"

availability_zones = [
  "ap-south-1a",
  "ap-south-1b",
  "ap-south-1c"
]

public_subnet_cidrs = [
  "10.20.1.0/24",
  "10.20.2.0/24",
  "10.20.3.0/24"
]

private_eks_subnet_cidrs = [
  "10.20.11.0/20",
  "10.20.12.0/20",
  "10.20.13.0/20"
]

private_db_subnet_cidrs = [
  "10.20.21.0/24",
  "10.20.22.0/24",
  "10.20.23.0/24"
]

eks_cluster_version = "1.35"

rds_db_name = "hsbc"

rds_db_username = "hsbcadmin"

rds_instance_class = "db.m6i.large"

rds_allocated_storage = 100

rds_max_allocated_storage = 500

mysql_engine_version = "8.0"

rds_backup_retention_period = 7

domain_name = "example.com"
