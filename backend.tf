# terraform {
#   required_version = ">= 1.0.0"

#   backend "s3" {
#     region  = "us-east-1"
#     bucket  = "example12345678-us-east-1-prod-terraform-state"
#     key     = "terraform.tfstate"
#     profile = ""
#     encrypt = "true"

#     dynamodb_table = "example12345678-us-east-1-prod-terraform-state-lock"
#   }
# }
