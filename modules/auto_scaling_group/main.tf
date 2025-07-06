# Setup the Auto Scaling Group (ASG)
resource "aws_autoscaling_group" "pp_asg" {
    name                      = "pp-asg"
    launch_template {
        id      = aws_launch_template.pp_launch_template.id
        version = "$Latest"
    }
    min_size                  = var.auto_scaling_sizes.min_size
    max_size                  = var.auto_scaling_sizes.max_size
    desired_capacity          = var.auto_scaling_sizes.desired_size
    vpc_zone_identifier       = var.subnet_ids
    health_check_type         = "ELB"

}

# Associate the Auto Scaling Group with the Load Balancer
resource "aws_autoscaling_attachment" "pp_asg_attachment" {
    autoscaling_group_name = aws_autoscaling_group.pp_asg.name
    lb_target_group_arn    = aws_lb_target_group.pp_alb_target_group.arn

    depends_on = [aws_autoscaling_group.pp_asg, aws_lb_target_group.pp_alb_target_group]
}