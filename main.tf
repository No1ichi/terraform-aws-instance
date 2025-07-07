terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
    region = var.region 
}

# Module creates certificate for ALB and CloufFront
module certificate {
  source = "./modules/acm"
  domain_name = var.domain_name
}

# Module for S3 Bucket setup
# Module creates a S3 bucket with private access
module s3 {
  source = "./modules/s3"
  bucket_name = var.s3_bucket_name
}

# Module for Security Groups setup
# Module creates security groups for ALB and EC2 instances with specific rules
module securitygroups {
  source = "./modules/securitygroups"
  ssh_access_ip = var.ssh_access_ip                                            
}

# Module for VPC setup
# Module creates a VPC with public and private subnets, an Internet Gateway and VPC Endpoints for S3.
module vpc {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
  vpc_endpoints = var.vpc_endpoints
}

# Module for NAT Gateway setup
# Module creates one NAT Gateway in public subnet for private subnets to access the Internet
module nat_gateway {
  source = "./modules/nat_gateway"
  subnet_id = var.subnet_id
}

# Module for EC2 Launch Template setup
# Module creates a Launch Template used in Auto Scaling Group for EC2 instances with user data script
module ec2_launch_template {
  source = "./modules/ec2_launch_template"
  instance_type = var.instance_type
  ami_id = var.ami_id
  user_data_script = var.user_data_script
}

# Module for ALB setup
# Module creates an Application Load Balancer with listener and target group
module load_balancer {
  source = "./modules/alb"
  alb_name = var.alb_name
}

# Module for Auto Scaling Group setup
# Module creates an Auto Scaling Group with Launch Template and scaling policies
module auto_scaling_group {
  source = "./modules/auto_scaling_group"
  subnet_ids = var.subnet_ids
  auto_scaling_sizes = var.auto_scaling_sizes
}

