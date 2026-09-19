output "rds_kms_key_id" {
  description = "KMS key ID used for RDS encryption"
  value       = aws_kms_key.rds.key_id
}

output "rds_kms_key_arn" {
  description = "KMS key ARN used for RDS encryption"
  value       = aws_kms_key.rds.arn
}

output "rds_kms_alias_arn" {
  description = "KMS alias ARN for RDS encryption"
  value       = aws_kms_alias.rds.arn
}
