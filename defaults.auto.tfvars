#### Global ####
region = "us-west-1"
account_id = "359515349909"
environment = "development"

#### AWS VPC ####
availability_zones   = ["us-west-1a", "us-west-1b", "us-west-1c"]
private_subnet_cidrs = ["172.16.0.0/19", "172.16.32.0/19", "172.16.64.0/19"]
public_subnet_cidrs  = ["172.16.96.0/19", "172.16.128.0/19", "172.16.160.0/19"]
vpc_cidr             = "172.16.0.0/16"

####AWS RDS ####
rds_db_instance_class      = "db.r5.xlarge"
rds_db_name                = "org_db"
rds_db_engine              = "mysql"
rds_username               = "mysql_user"
rds_password               = "random_password_from_env"
rds_engine_version         = "5.7.33"
rds_create_monitoring_role = false
rds_snapshot_identifier    = "encrypted-dev"
rds_instance_identifier    = "enc_rds"

#### AWS Route53 ####
route53_hosted_zone_name = "example.com"

#### AWS S3 ####
s3_bucket_name = "data_bucket"
