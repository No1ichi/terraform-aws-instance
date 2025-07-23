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

variable vpc_id {
  description = "The ID of the VPC where the security group will be created"
  type        = string
}

variable "ssh_access_ip" {
  description = "The IP address that is allowed to SSH into the EC2 instances"
  type        = string
}
