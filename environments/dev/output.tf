output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_app_subnet_ids" {
  value = module.vpc.private_app_subnet_ids
}

output "private_db_subnet_ids" {
  value = module.vpc.private_db_subnet_ids
}

output "alb_dns_name" {
  description = "Dev ALB DNS name"
  value       = module.alb.alb_dns_name
}

output "autoscaling_group_name" {
  description = "Application Auto Scaling Group"
  value       = module.autoscaling.autoscaling_group_name
}

output "launch_template_id" {
  description = "Application Launch Template"
  value       = module.autoscaling.launch_template_id
}
