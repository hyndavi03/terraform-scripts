# variables.tf

variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "role_name" {
  description = "IAM role name"
}

variable "policy_name" {
  description = "IAM policy name"
}
