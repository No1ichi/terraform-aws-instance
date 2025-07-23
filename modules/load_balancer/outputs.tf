output "load_balancer_arn" {
    description = "The ARN of the ALB"
    value = aws_lb_target_group.alb_target_group.arn
}

output "alb_name" {
  description = "The name of the ALB"
  value = aws_lb.alb.name
}

output "load_balancer_id" {
    description = "The ID of the ALB"
    value = aws_lb.alb.id
}

output "load_balancer_dns_name" {
    description = "The DNS Name of the ALB"
    value = aws_lb.alb.dns_name
}