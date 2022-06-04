
provider "aws" {
  region = "eu-west-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" {
    bucket         = "terraform-state-sre-kata"
    key            = "terraform-state-sre-kata/terraform.tfstate"
    dynamodb_table = "terraform-state-lock"
    region         = "eu-west-1"
    encrypt        = false
  }
}

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}
