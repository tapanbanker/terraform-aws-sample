
# The ACM certificate resource allows requesting and management of certificates from the Amazon Certificate Manager.
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate
resource "aws_acm_certificate" "cert" {
  domain_name       = var.route53_hosted_zone_name
  validation_method = "DNS"
  
  tags = {
    environment = "development"
    name        = "ACM-certificate"
    email       = "bankertapan@gmail.com"
    project     = "Sample Application Project with Terraform on AWS"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Provides a security group resource.
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
resource "aws_security_group" "alb" {
  name = "alb_access"

  ingress {
    description = "TLS from Internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  
  tags = {
    environment = "development"
    name        = "AWS-Security-Group-ALB"
    email       = "bankertapan@gmail.com"
    project     = "Sample Application Project with Terraform on AWS"
    description = "Provides a security group resource."
  }
}

# Provides a Load Balancer resource
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb
resource "aws_lb" "main_lb" {
  name               = "main-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = [for subnet in aws_subnet.public_subnets : subnet.id]

  enable_deletion_protection = true

    
  tags = {
    environment = "development"
    name        = "AWS Load Balancer Main Load Balancer"
    email       = "bankertapan@gmail.com"
    project     = "Sample Application Project with Terraform on AWS"
    description = "Provides a Load Balancer resource"
  }
}

# Provides a Target Group resource for use with Load Balancer resources.
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group
resource "aws_alb_target_group" "http_tg" {
  name     = "http-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
  # Alter the destination of the health check to be the login page.
  health_check {
    path = "/health"
    port = 80
  }
}

# Provides a Load Balancer Listener resource.
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener
resource "aws_alb_listener" "listener_https" {
  load_balancer_arn = aws_lb.main_lb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.cert.arn
  default_action {
    target_group_arn = aws_alb_target_group.http_tg.arn
    type             = "forward"
  }
}

data "aws_route53_zone" "zone" {
  name = var.route53_hosted_zone_name
}

# Provides a Route53 record resource.
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record
resource "aws_route53_record" "terraform" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "terraform.${var.route53_hosted_zone_name}"
  type    = "A"
  alias {
    name                   = aws_lb.main_lb.dns_name
    zone_id                = aws_lb.main_lb.zone_id
    evaluate_target_health = true
  }
}