output "iam_role_arn" {
  description = "IAM role ARN used by AWS Load Balancer Controller"
  value       = aws_iam_role.this.arn
}

output "iam_role_name" {
  description = "IAM role name used by AWS Load Balancer Controller"
  value       = aws_iam_role.this.name
}

output "iam_policy_arn" {
  description = "IAM policy ARN used by AWS Load Balancer Controller"
  value       = aws_iam_policy.this.arn
}
