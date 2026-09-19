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
