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

resource "aws_eks_node_group" "system" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${var.project_name}-${var.environment}-system"
  node_role_arn   = var.eks_node_role_arn

  subnet_ids = var.private_eks_subnet_ids

  instance_types = var.system_node_instance_types
  capacity_type  = "ON_DEMAND"

  scaling_config {
    desired_size = 3
    min_size     = 3
    max_size     = 6
  }

  update_config {
    max_unavailable = 1
  }

  labels = {
    workload = "system"
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-system-node-group"
  }

  depends_on = [
    aws_eks_cluster.this
  ]
  network_interfaces {
    security_groups = [
      var.node_security_group_id
    ]
  }
}

resource "aws_eks_node_group" "application" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${var.project_name}-${var.environment}-application"
  node_role_arn   = var.eks_node_role_arn

  subnet_ids = var.private_eks_subnet_ids

  instance_types = var.application_node_instance_types
  capacity_type  = "ON_DEMAND"

  scaling_config {
    desired_size = 3
    min_size     = 3
    max_size     = 10
  }

  update_config {
    max_unavailable = 1
  }

  labels = {
    workload = "application"
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-application-node-group"
  }

  depends_on = [
    aws_eks_cluster.this
  ]
  network_interfaces {
    security_groups = [
      var.node_security_group_id
    ]
  }
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name = aws_eks_cluster.this.name
  addon_name   = "vpc-cni"

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE"

  depends_on = [
    aws_eks_cluster.this
  ]
}

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

resource "aws_eks_addon" "kube_proxy" {
  cluster_name = aws_eks_cluster.this.name
  addon_name   = "kube-proxy"

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE"

  depends_on = [
    aws_eks_cluster.this
  ]
}

resource "aws_eks_addon" "pod_identity_agent" {
  cluster_name = aws_eks_cluster.this.name
  addon_name   = "eks-pod-identity-agent"

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE"

  depends_on = [
    aws_eks_cluster.this
  ]
}

resource "aws_eks_pod_identity_association" "rds_secret_reader" {
  cluster_name    = aws_eks_cluster.this.name
  namespace       = "customer"
  service_account = "customer-service"

  role_arn = var.rds_secret_reader_role_arn

  depends_on = [
    aws_eks_addon.pod_identity_agent
  ]
}

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
