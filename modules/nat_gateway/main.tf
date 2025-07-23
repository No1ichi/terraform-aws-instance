# Allocate the Elastic IP for the NAT Gateway+
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

# Setup the NAT Gateway
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = var.public_subnet_id

  tags = {
    Name       = "${var.tags.Name}-natgateway"
    Owner      = var.tags.Owner
    CostCenter = var.tags.CostCenter
    Project    = var.tags.Project
  }
}