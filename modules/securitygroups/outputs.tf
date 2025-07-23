output "alb_security_group_id" {
    description = "The ID of the ALG security group"
    value = aws_security_group.alb_sg.id
}

output "ec2_security_group_id" {
    description = "The ID of the EC2 security group"
    value = aws_security_group.ec2_sg.id
}