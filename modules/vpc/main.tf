# Setup the VPC
resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name       = var.tags.Name
    Owner      = var.tags.Owner
    CostCenter = var.tags.CostCenter
    Project    = var.tags.Project
  }
}

# Setup the Public Subnets (with public IPs on launch)
resource "aws_subnet" "public_subnet" {
  for_each                = var.public_subnets
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.az
  map_public_ip_on_launch = true
}

# Setup the private Subnets (no public IPs on launch)
resource "aws_subnet" "private_subnet" {
  for_each                = var.private_subnets
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.az
  map_public_ip_on_launch = false
}

# Setup the Internet Gateway for the VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name       = var.tags.Name
    Owner      = var.tags.Owner
    CostCenter = var.tags.CostCenter
    Project    = var.tags.Project
  }
}

# Setup an AWS VPC Endpoint for S3
resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id            = aws_vpc.vpc.id
  service_name      = var.vpc_endpoints.s3_endpoint.service_name
  vpc_endpoint_type = var.vpc_endpoints.s3_endpoint.type
  route_table_ids   = [aws_route_table.rt_private.id]

  tags = {
    Name       = var.tags.Name
    Owner      = var.tags.Owner
    CostCenter = var.tags.CostCenter
    Project    = var.tags.Project
  }
}

# Setup the Network ACLs for the public subnets
resource "aws_network_acl" "public_acl" {
  vpc_id     = aws_vpc.vpc.id
  subnet_ids = [for subnet in aws_subnet.public_subnet : subnet.id]

  egress {
    protocol  = "tcp"
    rule_no   = 200
    action    = "allow"
    from_port = 443
    to_port   = 443
  }

  ingress {
    protocol  = "tcp"
    rule_no   = 100
    action    = "allow"
    from_port = 443
    to_port   = 443
  }
}

# Setup the Network ACLs for the private subnets
resource "aws_network_acl" "private_acl" {
  vpc_id     = aws_vpc.vpc.id
  subnet_ids = [for subnet in aws_subnet.private_subnet : subnet.id]

  egress {
    protocol  = "HTTP"
    rule_no   = 400
    action    = "allow"
    from_port = 80
    to_port   = 80
  }

  ingress {
    protocol  = "HTTP"
    rule_no   = 300
    action    = "allow"
    from_port = 80
    to_port   = 80
  }
}

# Setup the route table for the public subnets
resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Public Route Table"
  }
}

# Rule for Route Table. Allow traffic to the Internet Gateway for public subnets
resource "aws_route" "public_internet_route" {
  route_table_id         = aws_route_table.rt_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Associate the public subnets with the public route table
resource "aws_route_table_association" "rta_public" {
  for_each       = aws_subnet.public_subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.rt_public.id
}

# Setup the route table for the private subnets
resource "aws_route_table" "rt_private" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Private Route Table"
  }
}

# Rule for Route Table. Allow traffic to the NAT Gateway for private subnets
resource "aws_route" "private_nat_route" {
  route_table_id         = aws_route_table.rt_private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
}

# Rule for Route Table. Allow traffic to the VPC Endpoint for S3 in private subnets
resource "aws_route" "private_s3_route" {
  route_table_id  = aws_route_table.rt_private.id
  vpc_endpoint_id = aws_vpc_endpoint.s3_endpoint.id
}

# Associate the private subnets with the private route table
resource "aws_route_table_association" "rta_private" {
  for_each       = aws_subnet.private_subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.rt_private.id
}

# Associate the S3 VPC Endpoint with the private route table
resource "aws_vpc_endpoint_route_table_association" "s3_rta" {
  vpc_endpoint_id = aws_vpc_endpoint.s3_endpoint.id
  route_table_id  = aws_route_table.rt_private.id
}