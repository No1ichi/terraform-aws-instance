terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  profile = "terraform-testing"
  region  = "eu-central-1"
}

provider "aws" {
  profile = "terraform-testing"
  alias   = "us-east-1"
  region  = "us-east-1"
}
