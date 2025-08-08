output "vpc_id" {
  description = "The ID of the VPC"
  value = aws_vpc.vpc.id
}

output "private_subnet_id" {
  description = "The IDs of the private subnets"
  value = [for subnet in aws_subnet.private_subnet : subnet.id]
}

output "public_subnet_id" {
  description = "The IDs of the public subnets"
  value = [for subnet in aws_subnet.public_subnet : subnet.id]
}

output "cidr_block" {
  description = "The CIDR Block of the VPC"
  value = aws_vpc.vpc.cidr_block
}