# Setup the Security Group for the Application Load Balancer (ALB)
# Allows Inbound HTTPS traffic from the Internet
# Allows Outbound traffic to the Internet
resource "aws_security_group" "alb_sg" {
    name        = var.alb_sg_name
    description = "Security Group for the Application Load Balancer (ALB)"
    vpc_id      = var.vpc_id
}

# Inbound rule for the ALB security group
resource "aws_security_group_rule" "allow_https_from_internet" {
    type              = "ingress"
    description       = "Allows HTTPS traffic from the Internet to the ALB"
    security_group_id = aws_security_group.alb_sg.id
    from_port         = 443
    to_port           = 443
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
}

# Outbound rule for the ALB security group
resource "aws_security_group_rule" "allow_outbound_internet_alb" {
    type              = "egress"
    description       = "Allows outbound traffic to the Internet from the ALB"
    security_group_id = aws_security_group.alb_sg.id
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks       = ["0.0.0.0/0"]
}

# Setup the Security Group for EC2 instances in the VPC
# Allows Inbound traffic from ALB and SSH access with specific IP
# Allows Outbound traffic to the Internet
resource "aws_security_group" "ec2_sg" { 
    name        = var.ec2_sg_name
    description = "Security Group for EC2 instances in the VPC"
    vpc_id      = var.vpc_id
}

# Inbound rule for the EC2 security group
resource "aws_security_group_rule" "allow_http_from_alb" {
    type              = "ingress"
    description       = "Allosws HTTP traffic from ALB to EC2 instances"
    security_group_id = aws_security_group.ec2_sg.id
    from_port         = 80
    to_port           = 80
    protocol          = "tcp"
    source_security_group_id = aws_security_group.alb_sg.id
}

# Inbound rule for SSH access from a specific IP
resource "aws_security_group_rule" "allow_ssh_from_specific_ip" {
    type              = "ingress"
    description       = "Allows SSH access from a specific IP"
    security_group_id = aws_security_group.ec2_sg.id
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    cidr_blocks       = [var.ssh_access_ip]
}

# Inbound rule for connection from EC2 Instance Connect Endpoint to EC2
resource "aws_security_group_rule" "ec2_ssh_from_eice" {
  type                     = "ingress"
  description              = "Allows SSH from EICE to EC2"
  security_group_id        = aws_security_group.ec2_sg.id
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.eice_sg.id
}

# Outbound rule for the EC2 security group
resource "aws_security_group_rule" "allow_outbound_internet" {
    type              = "egress"
    description       = "Allows outbound traffic to the Internet"
    security_group_id = aws_security_group.ec2_sg.id
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks       = ["0.0.0.0/0"]
}

# Setup the Security Group for EC2 Instance Connect Endpoint
# Allows Outbound traffic to the EC2 Instances
resource "aws_security_group" "eice_sg" {
  name        = var.eice_sg_name
  description = "Security Group for EC2 Instance Connect Endpoint"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "eice_ssh_to_ec2" {
    type =  "egress"
    description = "Allows SSH Connection from EICE to EC2"
    security_group_id = aws_security_group.eice_sg.id
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.private_subnets_cidr_blocks
}