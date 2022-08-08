# Provides a VPC resource.
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
}

# Provides an VPC subnet resource.
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    environment = "development"
    name        = "private_subnets"
    email       = "bankertapan@gmail.com"
    type        = "private_subnets"
    project     = "Sample Application Project with Terraform on AWS"
  }

}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name        = "${var.rds_instance_identifier}-subnet-group"
  description = "Private Subnet Group for RDS"
  subnet_ids  = ["${aws_subnet.private_subnets.*.id}"]
}



# Provides an VPC subnet resource.
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
resource "aws_subnet" "public_subnets" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.public_subnet_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)

    tags = {
    environment = "development"
    name        = "public_subnets"
    email       = "bankertapan@gmail.com"
    type        = "public_subnets"
    project     = "Sample Application Project with Terraform on AWS"
  }
}

