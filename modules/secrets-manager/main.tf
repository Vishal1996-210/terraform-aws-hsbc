resource "aws_secretsmanager_secret" "customer_db" {
  name        = "${var.project_name}-${var.environment}-customer-db"
  description = "Database credentials for Customer service"

  tags = {
    Name = "${var.project_name}-${var.environment}-customer-db"
  }
}

resource "aws_secretsmanager_secret" "account_db" {
  name        = "${var.project_name}-${var.environment}-account-db"
  description = "Database credentials for Account service"

  tags = {
    Name = "${var.project_name}-${var.environment}-account-db"
  }
}

resource "aws_secretsmanager_secret" "card_db" {
  name        = "${var.project_name}-${var.environment}-card-db"
  description = "Database credentials for Card service"

  tags = {
    Name = "${var.project_name}-${var.environment}-card-db"
  }
}


resource "aws_iam_role" "customer_secret_reader" {
  name = "${var.project_name}-${var.environment}-customer-secret-reader"

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
    Name = "${var.project_name}-${var.environment}-customer-secret-reader"
  }
}

resource "aws_iam_policy" "customer_secret_reader" {
  name = "${var.project_name}-${var.environment}-customer-secret-reader"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]

        Resource = aws_secretsmanager_secret.customer_db.arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "customer_secret_reader" {
  role       = aws_iam_role.customer_secret_reader.name
  policy_arn = aws_iam_policy.customer_secret_reader.arn
}


resource "aws_iam_role" "account_secret_reader" {
  name = "${var.project_name}-${var.environment}-account-secret-reader"

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
    Name = "${var.project_name}-${var.environment}-account-secret-reader"
  }
}

resource "aws_iam_policy" "account_secret_reader" {
  name = "${var.project_name}-${var.environment}-account-secret-reader"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]

        Resource = aws_secretsmanager_secret.account_db.arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "account_secret_reader" {
  role       = aws_iam_role.account_secret_reader.name
  policy_arn = aws_iam_policy.account_secret_reader.arn
}


resource "aws_iam_role" "card_secret_reader" {
  name = "${var.project_name}-${var.environment}-card-secret-reader"

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
    Name = "${var.project_name}-${var.environment}-card-secret-reader"
  }
}

resource "aws_iam_policy" "card_secret_reader" {
  name = "${var.project_name}-${var.environment}-card-secret-reader"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]

        Resource = aws_secretsmanager_secret.card_db.arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "card_secret_reader" {
  role       = aws_iam_role.card_secret_reader.name
  policy_arn = aws_iam_policy.card_secret_reader.arn
}
