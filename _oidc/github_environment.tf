# resource "github_actions_secret" "plan_role" {
#   repository      = var.repository
#   secret_name     = "AWS_TERRAFORM_PLAN_ROLE"
#   plaintext_value = "arn:aws:iam::${var.account_id}:role/${var.aws_terraform_plan_role_name}"
# }

# resource "github_actions_secret" "apply_role" {
#   repository      = var.repository
#   secret_name     = "AWS_TERRAFORM_APPLY_ROLE"
#   plaintext_value = "arn:aws:iam::${var.account_id}:role/${var.aws_terraform_apply_role_name}"
# }
