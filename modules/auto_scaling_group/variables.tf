variable "asg_name" {
  description = "Sets the Name of the Auto Scaling Group"
  type = string
  default = "asg"
}

variable "auto_scaling_sizes" {
  description = "Map of Auto Scaling group sizes for different environments"
  type = object({
    min_size     = number
    max_size     = number
    desired_size = number
  })
}

variable "subnet_ids" {
  description = "List of subnet IDs for the Auto Scaling group"
  type        = list(string)
}

variable "launch_template_id" {
  description = "The ID of the launch_template"
  type = string
}

variable "alb_target_group_arn" {
  description = "The ARN of the ALB"
  type = string
}