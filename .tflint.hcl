plugin "terraform" {
  enabled = true
  preset  = "recommended"
}

plugin "aws" {
  enabled = true
  version = "0.44.0"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}

plugin "opa" {
  enabled = true
  version = "0.9.0"
  source  = "github.com/terraform-linters/tflint-ruleset-opa"
}
