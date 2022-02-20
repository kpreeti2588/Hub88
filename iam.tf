resource "aws_iam_role" "ec2_access_role" {
  name               = "ec2-cloud-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}


resource "aws_iam_instance_profile" "test_profile" {                             
name  = "test_ec2_profile"                         
role = aws_iam_role.ec2_access_role.name
}


resource "aws_iam_role_policy" "ec2-role-policy" {
  name = "ec2-role-policy"
  role = aws_iam_role.ec2_access_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_policy" "ec2-logs-policy" {
  name = "ec2-logs"

  policy = jsonencode({
    Version = "2012-10-17"
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:DescribeInstances",
        "ec2:DescribeRegions",
        "ec2:StartInstances",
        "ec2:StopInstances"
      ],
      "Resource": "*"
    }
  ]
  })
}

resource "aws_iam_role_policy_attachment" "logs-ec2-policy-attach" {
  policy_arn = aws_iam_policy.ec2-logs-policy.arn
  role = aws_iam_role.ec2_access_role.name
}