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
  default = {
    min_size     = 1
    max_size     = 2
    desired_size = 1
  }
}

variable "subnet_ids" {
  description = "List of subnet IDs for the Auto Scaling group"
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b"]
}