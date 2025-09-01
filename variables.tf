# Variable for the AWS region where the resources will be created
variable "region" {
  description = "The AWS region where the resources will be created"
  type        = string
}

# Variable for the domain name
variable "domain_name" {
  description = "The name of the domain"
  type        = string
}

# Tags for tagging the services. Name variable is ${"service-name"}-moduleName
variable "tags" {
  description = "Tags to apply to the registered Domain"
  type = object({
    Name       = string
    Owner      = string
    CostCenter = string
    Project    = string
  })
}

##########################
### ======= S3 ======= ###
##########################

# Variable for the S3 bucket name
variable "s3_bucket_name" {
  description = "Name of the S3 bucket to be created"
  type        = string
}

###########################
### ======= VPC ======= ###
###########################

# Variable for the VPC CIDR block
# Defines the IPv4 CIDR block for the VPC
variable "vpc_cidr" {
  description = "IPv4 CIDR block for the VPC"
  type        = string
}

# Variable for the public subnets setup
# Defines the public subnets with their Availability Zone and CIDR block
variable "public_subnets" {
  description = "Map of public subnets with Availability Zone and CIDR block"
  type = map(object({
    az         = string
    cidr_block = string
  }))
}

# Variable for the private subnets setup
# Defines the private subnets with their Availability Zone and CIDR block
variable "private_subnets" {
  description = "Map of private subnets with Availability Zone and CIDR block"
  type = map(object({
    az         = string
    cidr_block = string
  }))
}

# Variable for VPC endpoints setup
# Defines the VPC endpoints with their service name and type
variable "vpc_endpoints" {
  description = "VPC endpoint with service name and type"
  type = map(object({
    service_name = string
    type         = string
  }))
}

###########################
### ======= WAF ======= ###
###########################

variable "waf_name" {
  description = "The Name of the AWS WAF"
  type        = string
  default     = "WAF"
}

##################################
### ======= Sec. Group ======= ###
##################################

# Variable for the IP address used for SSH access to EC2 instances
variable "ssh_access_ip" {
  description = "IP address for SSH access to EC2 instances"
  type        = string
}

#####################################
### ======= Load Balancer ======= ###
#####################################

# Variable for the ALB name
variable "alb_name" {
  description = "Sets the Name of the Application Load Balancer"
  type        = string
}

###########################################
### ======= EC2 Launch Template ======= ###
###########################################

variable "launch_template_name" {
  description = "Name for the EC2 instance launch template"
  type        = string
}

# Variable for the EC2 instance type
variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

# Variable for the AMI ID used for the EC2 instance
# Defines the Amazon Machine Image (AMI) ID for the EC2 instance
variable "ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-003c9adf81de74b40"
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

mkdir -p /var/www/html

aws s3 sync s3://phantomprotocol-bucket/mywebsite/ /var/www/html/

chown -R apache:apache /var/www/html
EOF
}

variable "public_key" {
  description = "The Public Key connected with the EC2 Instances"
  type        = string
}

##########################################
### ======= Auto Scaling Group ======= ###
##########################################

# sets the Name for the Auto Scaling Group
variable "asg_name" {
  description = "The Name for the Auto Scaling Group"
  type        = string
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
}