variable "ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-003c9adf81de74b40"
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of the key pair to use for SSH access"
  type        = string
  default     = "pp_ec2"
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the instance"
  type        = list(string)
  default     = ["pp_EC2_SG sg-05545f0c01aea7231"]
}

variable "tags" {
  description = "Tags to apply to the EC2 instance"
  type        = object({
    Name        = string
    Owner       = string
    CostCenter  = string
    Project     = string
  })
  default     = {
    Name        = "pp_ec2_instance"
    Owner       = "Bastian"
    CostCenter  = "PP_CostOverview"
    Project     = "IU_CLoudProgramming_Project"
  }
}

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