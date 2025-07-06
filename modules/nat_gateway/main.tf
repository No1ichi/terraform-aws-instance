# Allocate the Elastic IP for the NAT Gateway+
resource "aws_eip" "pp_nat_eip" {
    domain = "vpc"
}

# Setup the NAT Gateway
resource "aws_nat_gateway" "pp_nat_gateway" {
    allocation_id = aws_eip.pp_nat_eip.id
    subnet_id = var.subnet_id

    tags = {
        Name        = var.tags.Name
        Owner       = var.tags.Owner
        CostCenter  = var.tags.CostCenter
        Project     = var.tags.Project
    }

    depends_on = [aws_internet_gateway.pp_igw]

}