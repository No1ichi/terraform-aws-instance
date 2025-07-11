# Variable for the AWS region where the resources will be created
variable "region" {
  description = "The AWS region where the resources will be created"
  type        = string
  default     = "eu-central-1"
}

# Variable for the domain name used in the ACM certificate
# Variable is list of strings to allow multiple domain names
variable "domain_name" {
  description = "Domain name for the ACM certificate"
  type        = string
  default     = "phantomprotocol.de"
}

# Variable for the S3 bucket name
variable "s3_bucket_name" {
  description = "Name of the S3 bucket to be created"
  type        = string
  default     = "phantomprotocol-bucket"
}

# Variable for the IP address used for SSH access to EC2 instances
variable "ssh_access_ip" {
  description = "IP address for SSH access to EC2 instances"
  type        = string
  default     = "xxx.xxx.xxx.xxx/32"
}

# Variable for the VPC CIDR block
# Defines the IPv4 CIDR block for the VPC
variable "vpc_cidr" {
  description = "IPv4 CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# Variable for the public subnets setup
# Defines the public subnets with their Availability Zone and CIDR block
variable "public_subnets" {
  description = "Map of public subnets with Availability Zone and CIDR block"
  type = map(object({
    az         = string
    cidr_block = string
  }))
  default = {
    # Public Subnet 1
    public_subnet1 = {
      az         = "eu-central-1a"
      cidr_block = "10.0.1.0/24"
    }
    # Public Subnet 2
    public_subnet2 = {
      az         = "eu-central-1b"
      cidr_block = "10.0.2.0/24"
    }
  }
}

# Variable for the private subnets setup
# Defines the private subnets with their Availability Zone and CIDR block
variable "private_subnets" {
  description = "Map of private subnets with Availability Zone and CIDR block"
  type = map(object({
    az         = string
    cidr_block = string
  }))
  default = {
    # Private Subnet 1
    private_subnet1 = {
      az         = "eu-central-1a"
      cidr_block = "10.0.3.0/24"
    }
    # Private Subnet 2
    private_subnet2 = {
      az         = "eu-central-1b"
      cidr_block = "10.0.4.0/24"
    }
  }
}

# Variable for VPC endpoints setup
# Defines the VPC endpoints with their service name and type
variable "vpc_endpoints" {
  description = "VPC endpoint with service name and type"
  type = map(object({
    service_name = string
    type         = string
  }))
  default = {
    # VPC Endpoint for S3
    s3_endpoint = {
      service_name = "com.amazonaws.eu-central-1.s3"
      type         = "Gateway"
    }
  }
}

# Variable for the NAT Gateway subnet ID
# Defines the Subnet where the NAT Gateway will be deployed
variable "subnet_id" {
  description = "The ID of the subnet where the NAT Gateway will be deployed"
  type        = string
  default     = "aws.subnet.pp_public_subnet[0].id"
}

# Variable for the AMI ID used for the EC2 instance
# Defines the Amazon Machine Image (AMI) ID for the EC2 instance
variable "ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-003c9adf81de74b40"
}

# Variable for the EC2 instance type
variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

# Variable for the key pair name used for SSH access to EC2 instances
variable "key_name" {
  description = "Name of the key pair to use for SSH access"
  type        = string
  default     = "pp_ec2"
}

# Variable for the user data script used in the EC2 Launch Template
# This script updates the instance, installs apache httpd and AWS CLI, starts the httpd service, and syncs files from an S3 bucket
variable "user_data" {
  description = "User data script to run on instance launch"
  type        = string
  default     = <<EOF
#!/bin/bash
yum update -y
yum install -y httpd awscli
systemctl enable httpd
systemctl start httpd

aws s3 sync s3://phantomprotocol-bucket/mywebsite/ /var/WWW/html/

chown -R apache:apache /var/www/html
EOF
}

# Variable for the ALB name
variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
  default     = "pp-alb"
}

# Variable for the subnet IDs used in the Auto Scaling group
# This variable is a list of subnet IDs where the Auto Scaling group will launch instances
variable "subnet_ids" {
  description = "List of subnet IDs for the Auto Scaling group"
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b"]
}

# Variable for the Auto Scaling group sizes
# This variable defines the minimum, maximum, and desired sizes for the Auto Scaling group
variable "auto_scaling_sizes" {
  description = "Map of Auto Scaling group sizes for different environments"
  type = object({
    min_size     = number
    max_size     = number
    desired_size = number
  })
  default = {
    min_size     = 1
    max_size     = 2
    desired_size = 1
  }
}