resource "aws_db_subnet_group" "this" {
  name = "${var.project_name}-${var.environment}-db-subnet-group"

  subnet_ids = var.db_subnet_ids

  tags = {
    Name = "${var.project_name}-${var.environment}-db-subnet-group"
  }
}

resource "aws_db_parameter_group" "mysql" {
  name        = "${var.project_name}-${var.environment}-mysql-parameter-group"
  family      = "mysql8.0"
  description = "MySQL parameter group for ${var.project_name}-${var.environment}"

  tags = {
    Name = "${var.project_name}-${var.environment}-mysql-parameter-group"
  }
}

resource "aws_db_instance" "mysql" {
  identifier = "${var.project_name}-${var.environment}-mysql"

  engine         = "mysql"
  engine_version = var.mysql_engine_version

  instance_class = var.db_instance_class

  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = "gp3"

  db_name  = var.db_name
  username = var.db_username

  manage_master_user_password = true

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [var.rds_security_group_id]

  parameter_group_name = aws_db_parameter_group.mysql.name

  multi_az = true

  publicly_accessible = false

  storage_encrypted = true
  kms_key_id        = var.kms_key_arn

  backup_retention_period = var.backup_retention_period
  backup_window           = "18:00-19:00"

  maintenance_window = "sun:19:00-sun:20:00"

  auto_minor_version_upgrade = true

  deletion_protection = true

  skip_final_snapshot = false

  final_snapshot_identifier = "${var.project_name}-${var.environment}-mysql-final"

  copy_tags_to_snapshot = true

  enabled_cloudwatch_logs_exports = [
    "error",
    "general",
    "slowquery"
  ]

  tags = {
    Name = "${var.project_name}-${var.environment}-mysql"
  }
}
