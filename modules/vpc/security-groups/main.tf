resource "aws_security_group" "alb" {
  name        = "${var.project_name}-${var.environment}-alb-sg"
  description = "Security group for Application Load Balancer"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.project_name}-${var.environment}-alb-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "alb_https" {
  security_group_id = aws_security_group.alb.id

  description = "Allow HTTPS from internet"

  ip_protocol = "tcp"
  from_port   = 443
  to_port     = 443

  cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "alb_http" {
  security_group_id = aws_security_group.alb.id

  description = "Allow HTTP from internet for Dev"

  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80

  cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "alb_to_app" {
  security_group_id = aws_security_group.alb.id

  description = "Allow ALB to communicate with application tier"

  ip_protocol = "tcp"
  from_port   = 8080
  to_port     = 8080

  referenced_security_group_id = aws_security_group.app.id
}

resource "aws_security_group" "app" {
  name        = "${var.project_name}-${var.environment}-app-sg"
  description = "Security group for application servers"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.project_name}-${var.environment}-app-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "app_from_alb" {
  security_group_id = aws_security_group.app.id

  description = "Allow application traffic from ALB"

  ip_protocol = "tcp"
  from_port   = 8080
  to_port     = 8080

  referenced_security_group_id = aws_security_group.alb.id
}

resource "aws_security_group" "db" {
  name        = "${var.project_name}-${var.environment}-db-sg"
  description = "Security group for database"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.project_name}-${var.environment}-db-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "db_from_app" {
  security_group_id = aws_security_group.db.id

  description = "Allow MySQL from application tier"

  ip_protocol = "tcp"
  from_port   = 3306
  to_port     = 3306

  referenced_security_group_id = aws_security_group.app.id
}

resource "aws_vpc_security_group_ingress_rule" "app_ssh" {
  count = var.allowed_ssh_cidr != null ? 1 : 0

  security_group_id = aws_security_group.app.id

  description = "Allow SSH from approved administration network"

  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22

  cidr_ipv4 = var.allowed_ssh_cidr
}
