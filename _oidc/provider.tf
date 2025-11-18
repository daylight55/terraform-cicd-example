terraform {
  required_version = "~> 1.13.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.67"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.7.2"
    }
    # github = {
    #   source  = "integrations/github"
    #   version = "~> 6.0"
    # }
  }
}

provider "aws" {
  region = "ap-northeast-1"
  default_tags {
    tags = {
      ManagedBy = "Terraform"
    }
  }
}
