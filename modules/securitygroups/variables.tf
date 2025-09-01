variable alb_sg_name {
  description = "The Name of the ALB security group"
  type = string
  default = "alb-sg"
}

variable ec2_sg_name {
  description = "The Name of the EC2 security group"
  type = string
  default = "ec2-sg"
}

variable eice_sg_name {
  description = "The Name of the EC2 Instance Connect Endpoint Security Group"
  type = string
  default = "eice_sg"
}

variable vpc_id {
  description = "The ID of the VPC where the security group will be created"
  type        = string
}

variable "ssh_access_ip" {
  description = "The IP address that is allowed to SSH into the EC2 instances"
  type        = string
}

variable "private_subnets_cidr_blocks" {
  description = "The CIDR-Blocks from the private subnets"
  type = list(string)
}