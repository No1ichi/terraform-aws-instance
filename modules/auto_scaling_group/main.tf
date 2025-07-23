# Setup the Auto Scaling Group (ASG)
resource "aws_autoscaling_group" "asg" {
  name = var.asg_name
  launch_template {
    id      = var.launch_template_id
    version = "$Latest"
  }
  min_size            = var.auto_scaling_sizes.min_size
  max_size            = var.auto_scaling_sizes.max_size
  desired_capacity    = var.auto_scaling_sizes.desired_size
  vpc_zone_identifier = var.subnet_ids
  health_check_type   = "ELB"

}

# Associate the Auto Scaling Group with the Load Balancer
resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.asg.name
  lb_target_group_arn    = var.alb_target_group_arn
}