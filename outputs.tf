#### VPC ####
output "vpc_arn" {
  description = "The ARN of the AWS VPC."
  value       = aws_vpc.main.arn
}

output "vpc_cidr_block" {
  description = "The CIDR block of the AWS VPC."
  value       = aws_vpc.main.cidr_block
}

output "vpc_id" {
  description = "The ID of the AWS VPC."
  value       = aws_vpc.main.id
}

#### Ec2 ####
output "ec2_ip_addr" {
  description = "The AWS EC2 Public IP address"
  value = aws_instance.main_instance.public_ip
}

#### RDS ####
output "rds_address" {
  description = "The AWS RDS Public IP address"
  value = aws_db_instance.main_rds.address
}


output "rds_endpoint" {
  description = "The AWS RDS Database end point"
  value = aws_db_instance.main_rds.endpoint
}

output "rds_arn" {
  description = "The AWS RDS Database ARN number"
  value = aws_db_instance.main_rds.arn
}
