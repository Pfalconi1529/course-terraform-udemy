terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>6.3.0"
    }
     random = {
      source  = "hashicorp/random"
      version = "~>3.7.0"
    }
  }
  required_version = "~>1.13.0"
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = var.tags
  }
}

# provider "aws" {
#   region = "us-east-2"
#   alias = "ohio"
# }



