resource "aws_iam_role" "rds_secret_reader" {
  name = "${var.project_name}-${var.environment}-rds-secret-reader"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "pods.eks.amazonaws.com"
        }

        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
      }
    ]
  })

  tags = {
    Name = "${var.project_name}-${var.environment}-rds-secret-reader"
  }
}

resource "aws_iam_policy" "rds_secret_reader" {
  name = "${var.project_name}-${var.environment}-rds-secret-reader"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]

        Resource = var.rds_secret_arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "rds_secret_reader" {
  role       = aws_iam_role.rds_secret_reader.name
  policy_arn = aws_iam_policy.rds_secret_reader.arn
}
