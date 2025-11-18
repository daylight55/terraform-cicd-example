resource "random_pet" "this" {
  separator = "-"
}

resource "aws_s3_bucket" "example" {
  bucket = "example-bucket-${random_pet.this.id}"
}
