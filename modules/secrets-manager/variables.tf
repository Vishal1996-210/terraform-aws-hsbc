variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "rds_secret_arn" {
  description = "ARN of the RDS-managed Secrets Manager secret"
  type        = string
}
