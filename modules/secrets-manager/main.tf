resource "aws_secretsmanager_secret" "rds" {
  name = var.secret_name

  kms_key_id = var.kms_key_arn

  tags = {
    Name = var.secret_name
  }
}
