output "vpc_id" {
  description = "Production VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Production public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_eks_subnet_ids" {
  description = "Production EKS subnet IDs"
  value       = module.vpc.private_eks_subnet_ids
}

output "private_db_subnet_ids" {
  description = "Production DB subnet IDs"
  value       = module.vpc.private_db_subnet_ids
}

output "alb_security_group_id" {
  description = "Production ALB security group ID"
  value       = module.security_groups.alb_security_group_id
}

output "eks_application_security_group_id" {
  description = "Production EKS application security group ID"
  value       = module.security_groups.eks_application_security_group_id
}

output "rds_security_group_id" {
  description = "Production RDS security group ID"
  value       = module.security_groups.rds_security_group_id
}

output "eks_cluster_role_arn" {
  description = "EKS cluster IAM role ARN"
  value       = module.iam.eks_cluster_role_arn
}

output "eks_node_role_arn" {
  description = "EKS node IAM role ARN"
  value       = module.iam.eks_node_role_arn
}

output "ecr_repository_urls" {
  description = "Production ECR repository URLs"
  value       = module.ecr.repository_urls
}
