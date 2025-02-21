terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.87.0"
    }
  }

  backend "s3" {
    bucket         = "terraform-class-2025-state-bucket"
    dynamodb_table = "TerraformLock"
    encrypt        = true
    key            = "development/terraform-class/state"
    region         = "eu-west-2"
  }
}

provider "aws" {
  region = "eu-west-2"
}
