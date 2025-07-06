# Setup the Application Load Balancer (ALB)
resource "aws_lb" "pp_alb" {
    name               = "pp-alb"
    load_balancer_type = "application"
    internal           = false
    security_groups    = var.security_group_ids
    subnets            = var.subnet_ids
    