# main.tf

provider "aws" {
  region = var.region
}

resource "aws_iam_role" "example_role" {
  name               = var.role_name
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

variable "policy_name" {
  description = "IAM policy name"
}

resource "aws_iam_policy" "example_policy" {
  name        = var.policy_name
  description = "Example IAM policy"
  
  # Define the policy document using JSON syntax
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:ListBucket",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::your-bucket-name/*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "example_policy_attachment" {
  role       = aws_iam_role.example_role.name
  policy_arn = aws_iam_policy.example_policy.arn
}
