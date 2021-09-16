terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
provider "aws" {
  region     = var.region
  access_key =file(var.access_key)
  secret_key =file(var.secret_key)
}

