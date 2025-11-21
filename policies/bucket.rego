package terraform.s3_region

# すべての S3 バケットが東京リージョンにあることをチェックする deny ルール
deny contains msg if {
  rc := input.resource_changes[_]
  rc.type == "aws_s3_bucket"

  after := rc.change.after
  after != null

  required_region := "ap-northeast-1"
  region := bucket_region(after)
  region != required_region

  bucket_id := object.get(rc, "address", rc.name)
  msg := sprintf("S3 bucket %q のリージョンが ap-northeast-1 ではありません（%q）。",
    [bucket_id, region])
}

bucket_region(after) := region if {
  tags := object.get(after, "tags", {})
  region := object.get(after, "region", object.get(tags, "Region", "unknown"))
}
