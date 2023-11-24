# main.tf
Creating IAM user, group, adding user to group , creating policy andy attach it to user
provider "aws" {
  region = var.region
}

variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "iam_user_name" {
  description = "IAM user name"
}

variable "iam_group_name" {
  description = "IAM group name"
}

variable "iam_policy_name" {
  description = "IAM policy name"
}

resource "aws_iam_user" "example_user" {
  name = var.iam_user_name
}

resource "aws_iam_group" "example_group" {
  name = var.iam_group_name
}

resource "aws_iam_user_group_membership" "example_membership" {
  user  = aws_iam_user.example_user.name
  groups = [aws_iam_group.example_group.name]
}

resource "aws_iam_policy" "example_policy" {
  name        = var.iam_policy_name
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
    }
  ]
}
EOF
}

resource "aws_iam_user_policy_attachment" "example_user_policy_attachment" {
  user       = aws_iam_user.example_user.name
  policy_arn = aws_iam_policy.example_policy.arn
}
