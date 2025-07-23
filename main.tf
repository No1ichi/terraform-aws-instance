provider "aws" {
  region = var.region
}

provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}

# Module Route 53
# Module creates and registers the domain. Availability Check must be done manually before
module "route53" {
  source       = "./modules/route53"
  domain_name  = var.domain_name
  alb_dns_name = module.load_balancer.load_balancer_dns_name
  alb_zone_id  = module.load_balancer.load_balancer_id
}

# Module Amazon Certificate Manager
# Module creates certificate for ALB and CloufFront
module "acm" {
  source         = "./modules/acm"
  hosted_zone_id = module.route53.hosted_zone_id
  domain_name    = var.domain_name
}

# S3 Bucket
# Module creates a S3 bucket with private access
module "s3" {
  source      = "./modules/s3"
  bucket_name = var.s3_bucket_name
}

# Module VPC
# Module creates a VPC with 2 public and private subnets, one Internet Gateway and one VPC Endpoint for S3 Bucket.
module "vpc" {
  source          = "./modules/vpc"
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  vpc_endpoints   = var.vpc_endpoints
  nat_gateway_id  = module.nat_gateway.nat_gateway_id
}

#Module Web App. Firewall WAF
# Module creates a WAF with 4 rules (commonRules, IPRep, BadInputs, Custom IP Rate Limit)
module "waf" {
  source = "./modules/waf"
}

# Module for Security Groups setup
# Module creates security groups for ALB and EC2 instances with specific rules
module "securitygroups" {
  source        = "./modules/securitygroups"
  vpc_id        = module.vpc.vpc_id
  ssh_access_ip = var.ssh_access_ip
}

# Module for NAT Gateway setup
# Module creates one NAT Gateway in public subnet for private subnets to access the Internet
module "nat_gateway" {
  source           = "./modules/nat_gateway"
  public_subnet_id = module.vpc.public_subnet_id
}

# Module for ALB setup
# Module creates an Application Load Balancer with listener and target group
module "load_balancer" {
  source                = "./modules/load_balancer"
  subnet_ids            = module.vpc.public_subnet_id
  alb_security_group_id = module.securitygroups.alb_security_group_id
  vpc_id                = module.vpc.vpc_id
  certificate_arn       = module.acm.certificate_arn
}

# Module for EC2 Launch Template setup
# Module creates a Launch Template used in Auto Scaling Group for EC2 instances with user data script
module "ec2_launch_template" {
  source             = "./modules/ec2"
  instance_type      = var.instance_type
  key_name           = var.key_name
  ami                = var.ami
  user_data          = var.user_data
  security_group_ids = module.securitygroups.ec2_security_group_id
}

# Module for Auto Scaling Group setup
# Module creates an Auto Scaling Group with Launch Template and scaling policies
module "auto_scaling_group" {
  source               = "./modules/auto_scaling_group"
  subnet_ids           = module.vpc.private_subnet_id
  launch_template_id   = module.ec2_launch_template.launch_template_id
  alb_target_group_arn = module.load_balancer.load_balancer_arn
}

# Module CloudFront
# Module sets up the CloudFront Distribution
module "cloudfront" {
  source                     = "./modules/cloudfront"
  waf_arn                    = module.waf.waf_arn
  alb_dns_name               = module.load_balancer.load_balancer_dns_name
  acm_cloudfront_certificate = module.acm.cf_certificate_arn
  alb_id                     = module.load_balancer.load_balancer_id
}