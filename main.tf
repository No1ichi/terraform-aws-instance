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
module acm_certificate {
  source = "./modules/acm_certificate"
}

# Module for S3 Bucket setup
# Module creates a S3 bucket with private access
module s3 {
  source = "./modules/s3"
}

# Module for Security Groups setup
# Module creates security groups for ALB and EC2 instances with specific rules
module securitygroups {
  source = "./modules/securitygroups"
  ssh_access_ip = "xxx.xxx.xxx.xxx/32"                                              #<-- Replace with own IP address -->
}

# Module for VPC setup
# Module creates a VPC with public and private subnets, an Internet Gateway and VPC Endpoints for S3.
module vpc {
  source = "./modules/vpc"
}

# Module for NAT Gateway setup
# Module creates one NAT Gateway in public subnet for private subnets to access the Internet
module nat_gateway {
  source = "./modules/nat_gateway"
}

# Module for EC2 Launch Template setup
# Module creates a Launch Template used in Auto Scaling Group for EC2 instances with user data script
module ec2_launch_template {
  source = "./modules/ec2"
}

# Module for ALB setup
# Module creates an Application Load Balancer with listener and target group
module load_balancer {
  source = "./modules/load_balancer"
}

# Module for Auto Scaling Group setup
# Module creates an Auto Scaling Group with Launch Template and scaling policies
module auto_scaling_group {
  source = "./modules/auto_scaling_group"
}

