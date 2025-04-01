terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}



# The configuration for the `remote` backend.
terraform {
  backend "remote" {
    organization = "test_playground_security"

    workspaces {
      name = "AWS_ENV"
    }
  }
}
