output "rds_secret_reader_role_arn" {
  description = "IAM role ARN used by EKS workloads to read the RDS secret"
  value       = aws_iam_role.rds_secret_reader.arn
}

output "rds_secret_reader_role_name" {
  description = "IAM role name used by EKS workloads to read the RDS secret"
  value       = aws_iam_role.rds_secret_reader.name
}
