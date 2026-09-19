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

output "eks_cluster_name" {
  description = "Production EKS cluster name"
  value       = module.eks.cluster_name
}

output "eks_cluster_arn" {
  description = "Production EKS cluster ARN"
  value       = module.eks.cluster_arn
}

output "eks_cluster_endpoint" {
  description = "Production EKS API endpoint"
  value       = module.eks.cluster_endpoint
}

output "eks_system_node_group" {
  description = "Production EKS system node group"
  value       = module.eks.system_node_group_name
}

output "eks_application_node_group" {
  description = "Production EKS application node group"
  value       = module.eks.application_node_group_name
}

output "rds_instance_id" {
  description = "Production RDS instance ID"
  value       = module.rds.db_instance_id
}

output "rds_endpoint" {
  description = "Production RDS endpoint"
  value       = module.rds.db_endpoint
}

output "rds_port" {
  description = "Production RDS MySQL port"
  value       = module.rds.db_port
}

output "rds_database_name" {
  description = "Production RDS database name"
  value       = module.rds.db_name
}

output "rds_master_user_secret_arn" {
  description = "Secrets Manager ARN containing the RDS master credentials"
  value       = module.rds.master_user_secret_arn
}

output "rds_kms_key_arn" {
  description = "KMS key ARN used for RDS encryption"
  value       = module.kms.rds_kms_key_arn
}

output "rds_secret_reader_role_arn" {
  description = "IAM role ARN for EKS workloads to read RDS credentials"
  value       = module.secrets_manager.rds_secret_reader_role_arn
}

output "route53_hosted_zone_id" {
  description = "Production Route 53 hosted zone ID"
  value       = module.route53.hosted_zone_id
}

output "route53_name_servers" {
  description = "Production Route 53 name servers"
  value       = module.route53.name_servers
}

output "route53_domain_name" {
  description = "Production Route 53 domain name"
  value       = module.route53.domain_name
}
