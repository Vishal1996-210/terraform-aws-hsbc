variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "secret_name" {
  description = "Name of the RDS database secret"
  type        = string
}

variable "kms_key_arn" {
  description = "KMS key ARN used to encrypt the secret"
  type        = string
}
