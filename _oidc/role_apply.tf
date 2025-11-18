resource "aws_iam_role" "gha_apply" {
  name                 = "gha-apply"
  description          = "GitHub Actions role for Terraform (apply)"
  assume_role_policy   = data.aws_iam_policy_document.gha_apply_assume.json
  max_session_duration = 3600
}

data "aws_iam_policy_document" "gha_apply_assume" {
  statement {
    sid     = "GitHubActionsApplyOIDC"
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values = [
        # https://github.com/daylight55/terraform-cicd-example/tree/main
        "repo:daylight55/terraform-cicd-example:ref:refs/heads/main"
      ]
    }
  }
}

resource "aws_iam_role_policy_attachment" "apply_poweruser" {
  role       = aws_iam_role.gha_apply.name
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}
