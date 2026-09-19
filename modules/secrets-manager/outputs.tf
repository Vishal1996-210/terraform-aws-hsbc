output "customer_secret_arn" {
  description = "ARN of the Customer service database secret"
  value       = aws_secretsmanager_secret.customer_db.arn
}

output "account_secret_arn" {
  description = "ARN of the Account service database secret"
  value       = aws_secretsmanager_secret.account_db.arn
}

output "card_secret_arn" {
  description = "ARN of the Card service database secret"
  value       = aws_secretsmanager_secret.card_db.arn
}

output "customer_secret_reader_role_arn" {
  description = "IAM role ARN for Customer service to read its database secret"
  value       = aws_iam_role.customer_secret_reader.arn
}

output "account_secret_reader_role_arn" {
  description = "IAM role ARN for Account service to read its database secret"
  value       = aws_iam_role.account_secret_reader.arn
}

output "card_secret_reader_role_arn" {
  description = "IAM role ARN for Card service to read its database secret"
  value       = aws_iam_role.card_secret_reader.arn
}
