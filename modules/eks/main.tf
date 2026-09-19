resource "aws_eks_cluster" "this" {
  name     = "${var.project_name}-${var.environment}-eks"
  role_arn = var.eks_cluster_role_arn
  version  = var.cluster_version

  access_config {
    authentication_mode                         = "API"
    bootstrap_cluster_creator_admin_permissions = true
  }

  vpc_config {
    subnet_ids = var.private_eks_subnet_ids

    endpoint_private_access = true
    endpoint_public_access  = false

    security_group_ids = [
      var.cluster_security_group_id
    ]
  }

  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  tags = {
    Name = "${var.project_name}-${var.environment}-eks"
  }
}


# ---------------------------------------------------------
# Launch template for system nodes
# ---------------------------------------------------------

resource "aws_launch_template" "system" {
  name = "${var.project_name}-${var.environment}-system-node-template"

  instance_type = var.system_node_instance_types[0]

  vpc_security_group_ids = [
    var.node_security_group_id
  ]

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.project_name}-${var.environment}-system-node"
    }
  }

  tag_specifications {
    resource_type = "volume"

    tags = {
      Name = "${var.project_name}-${var.environment}-system-node-volume"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}


# ---------------------------------------------------------
# Launch template for application nodes
# ---------------------------------------------------------

resource "aws_launch_template" "application" {
  name = "${var.project_name}-${var.environment}-application-node-template"

  instance_type = var.application_node_instance_types[0]

  vpc_security_group_ids = [
    var.node_security_group_id
  ]

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.project_name}-${var.environment}-application-node"
    }
  }

  tag_specifications {
    resource_type = "volume"

    tags = {
      Name = "${var.project_name}-${var.environment}-application-node-volume"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}


# ---------------------------------------------------------
# System node group
# ---------------------------------------------------------

resource "aws_eks_node_group" "system" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${var.project_name}-${var.environment}-system"

  node_role_arn = var.eks_node_role_arn

  subnet_ids = var.private_eks_subnet_ids

  capacity_type = "ON_DEMAND"

  scaling_config {
    desired_size = 3
    min_size     = 3
    max_size     = 6
  }

  update_config {
    max_unavailable = 1
  }

  launch_template {
    id      = aws_launch_template.system.id
    version = aws_launch_template.system.latest_version
  }

  labels = {
    workload = "system"
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-system-node-group"
  }

  depends_on = [
    aws_eks_cluster.this,
    aws_launch_template.system
  ]
}


# ---------------------------------------------------------
# Application node group
# ---------------------------------------------------------

resource "aws_eks_node_group" "application" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${var.project_name}-${var.environment}-application"

  node_role_arn = var.eks_node_role_arn

  subnet_ids = var.private_eks_subnet_ids

  capacity_type = "ON_DEMAND"

  scaling_config {
    desired_size = 3
    min_size     = 3
    max_size     = 10
  }

  update_config {
    max_unavailable = 1
  }

  launch_template {
    id      = aws_launch_template.application.id
    version = aws_launch_template.application.latest_version
  }

  labels = {
    workload = "application"
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-application-node-group"
  }

  depends_on = [
    aws_eks_cluster.this,
    aws_launch_template.application
  ]
}


# ---------------------------------------------------------
# EKS VPC CNI
# ---------------------------------------------------------

resource "aws_eks_addon" "vpc_cni" {
  cluster_name = aws_eks_cluster.this.name
  addon_name   = "vpc-cni"

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE"

  depends_on = [
    aws_eks_cluster.this
  ]
}


# ---------------------------------------------------------
# CoreDNS
# ---------------------------------------------------------

resource "aws_eks_addon" "coredns" {
  cluster_name = aws_eks_cluster.this.name
  addon_name   = "coredns"

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE"

  depends_on = [
    aws_eks_cluster.this,
    aws_eks_node_group.system
  ]
}


# ---------------------------------------------------------
# kube-proxy
# ---------------------------------------------------------

resource "aws_eks_addon" "kube_proxy" {
  cluster_name = aws_eks_cluster.this.name
  addon_name   = "kube-proxy"

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE"

  depends_on = [
    aws_eks_cluster.this
  ]
}


# ---------------------------------------------------------
# EKS Pod Identity Agent
# ---------------------------------------------------------

resource "aws_eks_addon" "pod_identity_agent" {
  cluster_name = aws_eks_cluster.this.name
  addon_name   = "eks-pod-identity-agent"

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE"

  depends_on = [
    aws_eks_cluster.this
  ]
}


# ---------------------------------------------------------
# AWS Secrets Store CSI Driver Provider
# ---------------------------------------------------------

resource "aws_eks_addon" "secrets_store_csi_driver_provider" {
  cluster_name = aws_eks_cluster.this.name

  addon_name = "aws-secrets-store-csi-driver-provider"

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE"

  depends_on = [
    aws_eks_cluster.this,
    aws_eks_addon.pod_identity_agent
  ]
}
