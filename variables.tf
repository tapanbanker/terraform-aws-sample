#### VPC ####

variable "availability_zones" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
  default     = []
}

variable "private_subnet_cidrs" {
  description = "A list of CIDR blocks to use for the private subnets."
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "A list of CIDR blocks to use for the public subnets."
  type        = list(string)
}

variable "vpc_cidr" {
  description = "The CIDR block used for creating the VPC."
  type        = string
}

#### RDS ####
# https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/AuroraMySQL.Managing.html#AuroraMySQL.Managing.Performance.InstanceScaling
variable "rds_db_instance_class" {
  type        = string
  description = "Database instance type. "
}
variable "rds_snapshot_identifier" {
  type        = string
  description = "Initial encrypted snapshot"
}

variable "rds_instance_identifier" {
  type        = string
  description = "Instance identifier"
}

variable "rds_db_name" {
  type        = string
  description = "Database name."
}

variable "rds_db_engine" {
  type        = string
  default     = "aurora-mysql"
  description = "database engine"
}

variable "rds_username" {
  type        = string
  description = "database username"
}

variable "rds_password" {
  type        = string
  description = "Database password"
}

variable "rds_engine_version" {
  type        = string
  default     = "5.7.mysql_aurora.2.03.2"
  description = "Engine version (9.6.12 for PG)"
}

variable "rds_create_monitoring_role" {
  type        = bool
  default     = false
  description = "Create monitoring role for RDS"
}

#### Misc ####
variable "region" {
  type        = string
  default     = "us-east-2"
  description = "AWS Region"
}

variable "account_id" {
  type        = string
  description = "AWS Account ID"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

#### Route53 ####
variable "route53_hosted_zone_name" {
  type        = string
  description = "Base domain that will be used to create the hosted zone."
}

#### S3 ####
variable "s3_bucket_name" {
  type        = string
  description = "S3 Bucket"
}