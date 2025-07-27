variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs where the Load Balancer will be deployed"
  type        = list(string)
}

variable "alb_security_group_id" {
  description = "Security group ID to associate with the Load Balancer"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to the VPC and its resources"
  type = object({
    Name       = string
    Owner      = string
    CostCenter = string
    Project    = string
  })
  default = {
    Name       = "service-name"
    Owner      = "Owner"
    CostCenter = "Cost-Center"
    Project    = "Project-Name"
  }
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type = string
}

variable "certificate_arn" {
  description = "The ACM Certificate ARN for the Load Balancer Certificate"
  type = string
}
