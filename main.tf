terraform {
  # Each Terraform module must declare which providers it requires, so that Terraform can install and use them. 
  # Provider requirements are declared in a required_providers block.
  # The required_providers block must be nested inside the top-level terraform block 
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.23.0"
    }
  }
}
# Configure the AWS Provider
provider "aws" {
  region = var.region
}