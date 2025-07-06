variable vpc_id {
  description = "The ID of the VPC where the security group will be created"
  type        = string
  default     = "aws_vpc.pp_vpc.id"
}

variable "alb_sg_id" {
  description = "The ID of the ALB security group"
  type        = string
  default     = "aws_security_group.pp_alb_sg.id"
}

variable "ssh_access_ip" {
  description = "The IP address that is allowed to SSH into the EC2 instances"
  type        = string
  default     = "xxx.xxx.xxx.xxx/32"  # Replace with your specific IP address
}
