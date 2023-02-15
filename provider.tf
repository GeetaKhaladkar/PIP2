provider "aws" {
  region = "us-east-1"
}

terraform {
  required_version = ">= 0.12.26"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.20"
    }
  }
}