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

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "example_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  tags = {
    "hello" = "terraform"
    "Name"  = "Web Server"
  }
}

