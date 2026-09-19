output "alb_security_group_id" {
  description = "Security group ID for the ALB"
  value       = aws_security_group.alb.id
}

output "eks_application_security_group_id" {
  description = "Security group ID for EKS application workloads"
  value       = aws_security_group.eks_application.id
}

output "rds_security_group_id" {
  description = "Security group ID for RDS"
  value       = aws_security_group.rds.id
}
