# Provides an RDS security group resource. This is only for DB instances in the EC2-Classic Platform.
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_security_group
resource "aws_db_security_group" "rds_internal_access" {
  name = "rds_internal_access"

  ingress {
    cidr = aws_vpc.main.cidr_block
  }
}


# Provides an RDS instance resource. A DB instance is an isolated database environment in the cloud. 
# A DB instance can contain multiple user-created databases.
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance

resource "aws_db_instance" "main_rds" {
  identifier                = var.rds_instance_identifier
  allocated_storage         = 100
  engine                    = var.rds_db_engine
  engine_version            = var.rds_engine_version
  instance_class            = var.rds_db_instance_class
  db_name                   = var.rds_db_name
  multi_az                  = true
  username                  = var.rds_username
  password                  = var.rds_password
  parameter_group_name      = "default.mysql5.7"
  vpc_security_group_ids    = ["${aws_db_security_group.rds_internal_access.id}"]
  db_subnet_group_name      = aws_db_subnet_group.rds_subnet_group.id
  skip_final_snapshot       = true
  final_snapshot_identifier = "Ignore"

    tags = {
    environment = "development"
    name        = "EC2-instance"
    email       = "bankertapan@gmail.com"
    type        = "ec2"
    project     = "Sample Application Project with Terraform on AWS"
  }
}
