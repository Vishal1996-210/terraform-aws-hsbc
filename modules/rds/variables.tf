variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "private_db_subnet_ids" {
  type = list(string)
}

variable "security_group_id" {
  type = string
}

variable "engine" {
  type    = string
  default = "mysql"
}

variable "engine_version" {
  type    = string
  default = "8.0"
}

variable "instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "allocated_storage" {
  type    = number
  default = 20
}

variable "max_allocated_storage" {
  type    = number
  default = 50
}

variable "multi_az" {
  type    = bool
  default = false
}

variable "backup_retention_period" {
  type    = number
  default = 7
}

variable "database_name" {
  type    = string
  default = "hsbcbank"
}

variable "master_username" {
  type    = string
  default = "admin"
}
