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

variable "private_app_subnet_ids" {
  description = "Private application subnet IDs"
  type        = list(string)
}

variable "security_group_id" {
  description = "Application security group ID"
  type        = string
}

variable "target_group_arn" {
  description = "ALB target group ARN"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "min_size" {
  description = "Minimum ASG capacity"
  type        = number
  default     = 2
}

variable "desired_capacity" {
  description = "Desired ASG capacity"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum ASG capacity"
  type        = number
  default     = 4
}

variable "app_port" {
  description = "Application port"
  type        = number
  default     = 8080
}
