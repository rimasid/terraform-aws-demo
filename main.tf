provider "aws"{
    region = var.aws_region
}

resource "aws_iam_role" "demo-roles"{
    count = var.countr
    name = "demo-role-${count.index +1}"

    assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy" "demo-policies"{
    count = var.countp
    name = "demo-policy-${count.index +1}"

    policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:GetObject"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach" {
  count = var.countr

  role       = aws_iam_role.demo-roles[count.index].name
  policy_arn = aws_iam_policy.demo-policies[count.index].arn
}