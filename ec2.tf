# Using AMI Lookup
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


# Provides a security group resource.
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
resource "aws_security_group" "allow_internal" {
  name = "aws_internal_access"

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }
  
  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
# Provides an EC2 instance resource
resource "aws_instance" "main_instance" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t2.medium"
  subnet_id       = aws_subnet.private_subnets[0].id
  monitoring      = true
  security_groups = ["${aws_security_group.allow_internal.id}"]

  tags = {
    environment = "development"
    name        = "EC2-instance"
    email       = "bankertapan@gmail.com"
    type        = "ec2"
    project     = "Sample Application Project with Terraform on AWS"
  }

}