variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs for the ALB"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID for the ALB"
  type        = string
}

variable "target_port" {
  description = "Application target port"
  type        = number
  default     = 8080
}

variable "health_check_path" {
  description = "Application health check path"
  type        = string
  default     = "/actuator/health"
}
