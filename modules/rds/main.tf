resource "aws_db_subnet_group" "this" {
  name = "${var.project_name}-${var.environment}-db-subnet-group"

  subnet_ids = var.private_db_subnet_ids

  tags = {
    Name        = "${var.project_name}-${var.environment}-db-subnet-group"
    Project     = var.project_name
    Environment = var.environment
    Tier        = "database"
    ManagedBy   = "Terraform"
  }
}


resource "aws_db_instance" "this" {
  identifier = "${var.project_name}-${var.environment}-mysql"

  engine         = var.engine
  engine_version = var.engine_version

  instance_class        = var.instance_class
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = "gp3"

  db_name  = var.database_name
  username = var.master_username

  manage_master_user_password = true

  port = 3306

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [var.security_group_id]

  publicly_accessible = false

  storage_encrypted = true

  multi_az = var.multi_az

  backup_retention_period = var.backup_retention_period

  backup_window = "18:00-19:00"

  maintenance_window = "sun:19:00-sun:20:00"

  auto_minor_version_upgrade = true

  deletion_protection = false

  skip_final_snapshot = true

  apply_immediately = true

  copy_tags_to_snapshot = true

  tags = {
    Name        = "${var.project_name}-${var.environment}-mysql"
    Project     = var.project_name
    Environment = var.environment
    Tier        = "database"
    ManagedBy   = "Terraform"
  }
}
