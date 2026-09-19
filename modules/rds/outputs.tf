output "db_instance_id" {
  description = "RDS instance identifier"
  value       = aws_db_instance.mysql.id
}

output "db_instance_arn" {
  description = "RDS instance ARN"
  value       = aws_db_instance.mysql.arn
}

output "db_endpoint" {
  description = "RDS MySQL endpoint"
  value       = aws_db_instance.mysql.address
}

output "db_port" {
  description = "RDS MySQL port"
  value       = aws_db_instance.mysql.port
}

output "db_name" {
  description = "Initial database name"
  value       = aws_db_instance.mysql.db_name
}

output "master_user_secret_arn" {
  description = "ARN of the Secrets Manager secret containing the RDS master credentials"
  value       = aws_db_instance.mysql.master_user_secret[0].secret_arn
}
