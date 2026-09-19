output "alb_security_group_id" {
  description = "Security group ID for the ALB"
  value       = aws_security_group.alb.id
}

output "rds_security_group_id" {
  description = "Security group ID for RDS"
  value       = aws_security_group.rds.id
}

output "eks_cluster_security_group_id" {
  description = "EKS cluster security group ID"
  value       = aws_security_group.eks_cluster.id
}

output "eks_node_security_group_id" {
  description = "Security group ID for EKS worker nodes"
  value       = aws_security_group.eks_node.id
}
