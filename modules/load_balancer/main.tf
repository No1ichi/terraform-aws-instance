# Setup the Application Load Balancer (ALB)
resource "aws_lb" "alb" {
    name               = var.alb_name
    load_balancer_type = "application"
    internal           = false
    security_groups    = var.security_group_ids
    subnets            = var.subnet_ids

    tags = {
        Name        = var.tags.Name
        Owner       = var.tags.Owner
        CostCenter  = var.tags.CostCenter
        Project     = var.tags.Project
    }
}

# Setup the target group for the ALB
resource "aws_lb_target_group" "alb_target_group" {
    name     = "tg_webserver"
    port     = 80
    protocol = "HTTP"
    vpc_id   = aws_vpc.vpc.id

    health_check {
        enabled = true
        path    = "/"
    }

}

# Setup the listener for the ALB
resource "aws_lb_listener" "alb_listener" {
    load_balancer_arn = aws_lb.alb.arn
    port              = 443
    protocol          = "HTTPS"
    ssl_policy        = "ELBSecurityPolicy-2016-08"

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.alb_target_group.arn
    }

}

resource "aws_lb_listener_certificate" "alb_listener_certificate" {
    listener_arn = aws_lb_listener.alb_listener.arn
    certificate_arn = module.acm.certificate_arn
    depends_on = [aws_lb_listener.alb_listener]
}