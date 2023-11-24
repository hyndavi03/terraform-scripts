# variables.tf
creating IAM resources (user, group, and policy) without hardcoding values. It uses variables and a separate variables file to make it more flexible.

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
