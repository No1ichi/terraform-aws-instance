# Setup the Application Load Balancer (ALB)
resource "aws_lb" "alb" {
    name               = var.alb_name
    load_balancer_type = "application"
    internal           = false
    security_groups    = var.alb_security_group_ids
    subnets            = var.subnet_ids

    tags = {
        Name        = "${var.tags.Name}-alb"
        Owner       = var.tags.Owner
        CostCenter  = var.tags.CostCenter
        Project     = var.tags.Project
    }
}

# Setup the target group for the ALB
resource "aws_lb_target_group" "alb_target_group" {
    name     = "tg-webserver"
    port     = 80
    protocol = "HTTP"
    vpc_id   = var.vpc_id

    health_check {
        enabled = true
        protocol = "HTTP"
        port = 80
        path    = "/index.html"
        matcher = "200-399"
        timeout = 5
        interval = 15
        healthy_threshold = 2
        unhealthy_threshold = 2
    }

}

# Setup the listener for the ALB
resource "aws_lb_listener" "alb_listener" {
    load_balancer_arn = aws_lb.alb.arn
    port              = 443
    protocol          = "HTTPS"
    ssl_policy        = "ELBSecurityPolicy-2016-08"

    certificate_arn = var.certificate_arn

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.alb_target_group.arn
    }

}