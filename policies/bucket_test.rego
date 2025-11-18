package terraform.s3_region_test

import data.terraform.s3_region

invalid_plan := {
  "resource_changes": [
    {
      "type": "aws_s3_bucket",
      "name": "bad",
      "address": "aws_s3_bucket.bad",
      "change": {
        "after": {
          "region": "us-east-1"
        }
      }
    }
  ]
}

valid_plan := {
  "resource_changes": [
    {
      "type": "aws_s3_bucket",
      "name": "good",
      "address": "aws_s3_bucket.good",
      "change": {
        "after": {
          "tags": {
            "Region": "ap-northeast-1"
          }
        }
      }
    }
  ]
}

test_deny_when_bucket_not_in_tokyo if {
  denies := s3_region.deny with input as invalid_plan
  expected := {"S3 bucket \"aws_s3_bucket.bad\" のリージョンが ap-northeast-1 ではありません（\"us-east-1\"）。"}
  denies == expected
}

test_allow_when_region_set_via_tag if {
  denies := s3_region.deny with input as valid_plan
  count(denies) == 0
}

test_current_plan_keeps_buckets_in_tokyo if {
  denies := s3_region.deny with input as data.testdata.current_plan
  count(denies) == 0
}
