resource "random_string" "suffix" {
  length  = 8
  upper   = false
  lower   = true
  special = false
}

resource "aws_s3_bucket" "tfstate" {
  bucket        = "tf-s3-bucket-${random_string.suffix.result}"
  force_destroy = true
}
