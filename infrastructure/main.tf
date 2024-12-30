terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.82"
    }
  }
  required_version = ">= 1.0.0"
  backend "s3" {
    bucket = "cloud-resume-challenge-terraform"
    key    = "cloud-resume.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region
}
