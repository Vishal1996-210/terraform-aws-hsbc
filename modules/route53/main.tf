resource "aws_route53_zone" "this" {
  name = var.domain_name

  tags = {
    Name = "${var.project_name}-${var.environment}-hosted-zone"
  }
}
