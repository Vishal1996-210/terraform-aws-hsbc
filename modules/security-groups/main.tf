resource "aws_security_group" "alb" {
  name        = "${var.project_name}-${var.environment}-alb-sg"
  description = "Security group for production Application Load Balancer"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.project_name}-${var.environment}-alb-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "alb_https" {
  security_group_id = aws_security_group.alb.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  to_port     = 443
  ip_protocol = "tcp"

  description = "Allow HTTPS traffic from the internet"
}

resource "aws_vpc_security_group_egress_rule" "alb_all_outbound" {
  security_group_id = aws_security_group.alb.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"

  description = "Allow outbound traffic from ALB"
}

resource "aws_security_group" "eks_cluster" {
  name        = "${var.project_name}-${var.environment}-eks-cluster-sg"
  description = "Security group for EKS control plane"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.project_name}-${var.environment}-eks-cluster-sg"
  }
}

resource "aws_security_group" "eks_node" {
  name        = "${var.project_name}-${var.environment}-eks-node-sg"
  description = "Security group for EKS worker nodes"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.project_name}-${var.environment}-eks-node-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "eks_node_from_alb" {
  security_group_id = aws_security_group.eks_node.id

  referenced_security_group_id = aws_security_group.alb.id

  from_port   = var.app_port
  to_port     = var.app_port
  ip_protocol = "tcp"

  description = "Allow application traffic from ALB"
}

resource "aws_vpc_security_group_ingress_rule" "eks_cluster_from_nodes" {
  security_group_id = aws_security_group.eks_cluster.id

  referenced_security_group_id = aws_security_group.eks_node.id

  from_port   = 443
  to_port     = 443
  ip_protocol = "tcp"

  description = "Allow Kubernetes API traffic from EKS nodes"
}

resource "aws_vpc_security_group_egress_rule" "eks_node_all_outbound" {
  security_group_id = aws_security_group.eks_node.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"

  description = "Allow outbound traffic from EKS nodes"
}

resource "aws_security_group" "rds" {
  name        = "${var.project_name}-${var.environment}-rds-sg"
  description = "Security group for production RDS MySQL"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.project_name}-${var.environment}-rds-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "rds_from_eks" {
  security_group_id = aws_security_group.rds.id

  referenced_security_group_id = aws_security_group.eks_node.id

  from_port   = 3306
  to_port     = 3306
  ip_protocol = "tcp"

  description = "Allow MySQL traffic from EKS nodes"
}

resource "aws_vpc_security_group_egress_rule" "rds_all_outbound" {
  security_group_id = aws_security_group.rds.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"

  description = "Allow outbound traffic from RDS"
}
