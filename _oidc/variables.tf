variable "repository" {
  description = "GitHub repository in owner/repo format"
  type        = string
}

variable "account_id" {
  description = "AWS Account ID where the OIDC roles are created"
  type        = string
}

variable "aws_terraform_plan_role_name" {
  description = "Name of the IAM role used for terraform plan"
  type        = string
  sensitive   = true
}

variable "aws_terraform_apply_role_name" {
  description = "Name of the IAM role used for terraform apply"
  type        = string
  sensitive   = true
}
