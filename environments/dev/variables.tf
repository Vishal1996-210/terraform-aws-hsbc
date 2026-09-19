variable "aws_region" {
  description = "AWS region for the production environment"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the production VPC"
  type        = string
}

variable "availability_zones" {
  description = "Availability Zones for the production VPC"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_eks_subnet_cidrs" {
  description = "CIDR blocks for private EKS subnets"
  type        = list(string)
}

variable "private_db_subnet_cidrs" {
  description = "CIDR blocks for private DB subnets"
  type        = list(string)
}

variable "eks_cluster_version" {
  description = "Kubernetes version for production EKS"
  type        = string
}

variable "rds_db_name" {
  description = "Initial MySQL database name"
  type        = string
}

variable "rds_db_username" {
  description = "RDS master username"
  type        = string
}

variable "rds_instance_class" {
  description = "RDS MySQL instance class"
  type        = string
}

variable "rds_allocated_storage" {
  description = "Initial RDS storage in GB"
  type        = number
}

variable "rds_max_allocated_storage" {
  description = "Maximum RDS storage in GB"
  type        = number
}

variable "mysql_engine_version" {
  description = "MySQL engine version"
  type        = string
}

variable "rds_backup_retention_period" {
  description = "RDS automated backup retention period"
  type        = number
}
