output "autoscaling_group_id" {
  description = "Auto Scaling Group ID"
  value       = aws_autoscaling_group.app.id
}

output "autoscaling_group_name" {
  description = "Auto Scaling Group name"
  value       = aws_autoscaling_group.app.name
}

output "launch_template_id" {
  description = "Launch Template ID"
  value       = aws_launch_template.app.id
}

output "launch_template_latest_version" {
  description = "Latest Launch Template version"
  value       = aws_launch_template.app.latest_version
}
