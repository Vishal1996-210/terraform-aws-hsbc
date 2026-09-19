resource "aws_lb" "this" {
  name               = "${var.project_name}-${var.environment}-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    var.security_group_id
  ]

  subnets = var.public_subnet_ids

  enable_deletion_protection = false

  tags = {
    Name = "${var.project_name}-${var.environment}-alb"
  }
}

resource "aws_lb_target_group" "app" {
  name = "${var.project_name}-${var.environment}-app-tg"

  port     = var.target_port
  protocol = "HTTP"

  vpc_id = var.vpc_id

  target_type = "instance"

  health_check {
    enabled = true

    protocol = "HTTP"
    path     = var.health_check_path
    port     = "traffic-port"

    healthy_threshold   = 3
    unhealthy_threshold = 3

    timeout  = 5
    interval = 30

    matcher = "200"
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-app-tg"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn

  port     = 80
  protocol = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.this.arn

  port     = 443
  protocol = "HTTPS"

  ssl_policy      = var.ssl_policy
  certificate_arn = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}
