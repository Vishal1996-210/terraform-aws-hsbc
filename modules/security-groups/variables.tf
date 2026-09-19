variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "app_port" {
  description = "Application port used by Java microservices"
  type        = number
  default     = 8080
}
